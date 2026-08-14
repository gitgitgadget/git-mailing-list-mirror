Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051747FB10
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727574; cv=pass; b=X3NWz/lMAcwVcPXz/hvHMeMp8H0dlW+up6zSHYzc3uoYyaF7EJdwQ6gYOgipdD4E6fgqBxQBJuL62uskbYt5SXRh4LvS0IYMKQ8+jnTnrzNzO+iKTy6M/egmHm9hxfeZ+gBLa93k3IPsghCSMmyQoFDTKZ0DVxCzQpKPh8upVCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727574; c=relaxed/simple;
	bh=+Doc8JvsGOE1Qnqk76AMEvR72IGz5bQjyGAgR16Bk4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imbOilCGmkOgBh4qtZnC1PXhVI91EnGb6+AI37qM9UuypHnl5Siz0WwyrouZIU4vt6f/TxaDWsB5d9oV1L/G9kCqqDj2Zmt72dMMor2x3sIKhEdV1FeFPB3plHISgUgypAcsCt6hc3NDmOU3qizBdwdN0fn0g7i5N6ibtzWAnJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrpHWrYG; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrpHWrYG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1419983a91.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 10:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786727573; cv=none;
        d=google.com; s=arc-20260327;
        b=lQOFOZhtUa/UdD7UU3aFmBv8tgd7Ynmu+DgvZ5IrgfBnO5aUutLslV8PsKPef/DHdo
         IsCgnTsi4MN+LHMyIsVoz3n1/01R2eJNzmMRLmVfe2zJsosKxZm6Qd246oBC2kM6Hyl6
         qZwDLa/BwS4B1Jr4ofCIZ2qLyadkqLePqL8KBVEaLYtWoPcHA33rsBqGFWgWP0S976EF
         NCK9SNFlxOWgvjVFJpngQZod+qSxxucWDFfBPnRDrxStxj3QWhozyA0f067pfNxJQ6E3
         2ccJExa253LyNnDXbWjfcbIJc8qLwLA9QVpXOqmQ4BupFM1U1x84c+V9VPxnSZGlhoBv
         iMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A6/x/4psaVcD1zs4TA8hk+etuqi7gcINuRLfC2D9c+8=;
        fh=pN7wu1zwD+xcQsXWuh1aXLiVhMCtwuxgzoUDjuwgVME=;
        b=sZAn8IEYhg7grD3dhPIk0nygNuu34J705KtxwqluDHohflahhCmi+5+Kud+lyEXqwf
         SAtyo5mTZAx4pO7wmUTRA0La18lR/oh/6s+tg9bycjTNXuxYbcIpaQRXIgX2P9Kks8tB
         m1KTyresEgnt85WrHHuSolybvDam8Lzgs1yJm8cSLvOlXr/A6ilBDkZhT7/e0v1yn4bu
         DJxuNVlF0MV7XX3/7hM8IZp3Qd2hPBIeqQ5biQmpV2LIX8go2FDncVElgLAGAeUVPyf+
         h03OIuMqvRUBW+FR5HroDJgl842j2BqeVHCAojtAWvs8GerKeOf2p/Z/WjH8IU8ZDy3c
         weGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786727572; x=1787332372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A6/x/4psaVcD1zs4TA8hk+etuqi7gcINuRLfC2D9c+8=;
        b=BrpHWrYGm0inePVaHL/OV1BSlnEgDp8w8cFlCeWuKK+S2vbwnBnsevXModDiSDX4tS
         tL7UXWMjxiSzg4BuYfEpnLuQ8/n0fhFHGrdhfeMV48stQTk1qLlmcNi6aa5Y0ECsXS5L
         u8Or4weGbcixFMU44pXgfrd/iTwCyH4OwqUZMJbycToU8STdRfn0QwOQ71EMCdysriDm
         nWr5P4RFQGAplk2aknBhFgv1WwwauNvGHpph66XtG91y+EOgH3sm9JfTSaGDUCl8YcAO
         ZlMdJyiEPE/G0uasLDvWx01hU5AKeZyqJ4hSss5II6OnmamuZRWnYq2fHpXbdkTJBntP
         vNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786727573; x=1787332373;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A6/x/4psaVcD1zs4TA8hk+etuqi7gcINuRLfC2D9c+8=;
        b=lFLPk0GFHV4pxD+P5IXRy+iHVnLtYw9ibu81uVCD6TaDNocAj1UwO0kR+xPRFMhIf7
         6i3xmU59dmPmyzjGlRt5VUcugXqienR5lbiK/UkZ88FAr7f1CNOJY/BWV2aHQ15tx2R6
         iFrxKPDMv+4oTvys1P3oK/M6cwbXSu0j6CUfVGgqxM/GhjUTR0sbEeu/L96cCmgO2fL1
         9cCXXjaqm2QOgGuSkjqPdD4G1oN0XfAdhkpi3X6iVWW2TZmBX1DC3cEl7riHi70oMwd6
         PXyNpD4urmXRKJGE8cOm1XESrEWx94lqP/EeexhqYJgT+TTByYmyrlrlBBTu+zSOEi7b
         zxnQ==
X-Gm-Message-State: AOJu0Ywdx3L/hd9Qac2SqyGBxLJSYbu10pE9sMa/qvh7B/hU7z7tBSt3
	JimYFF62+rhVx6FrjRcBGADTi70rmNztcpcAzYWnqhfbu6eWYxgA4+KgYqf5vzoYVmY4en++UXE
	6HkW5pe90VPYP+Oelr5CIL3ExHFeBHWU=
X-Gm-Gg: AR+sD10vPu2V01vEjqKj2xH40/uwJJG/J5scL8V2exx6HO3TpYrgXhB7lrtKE+4s2O6
	3dAojPSjSjqK1P7/a8caJBXL6uPhtPRLS3XQP2bra0nH7fQxxbl0djqn/0edhf956Nxm+ImDTqI
	sAP2/25D6uQ7Rzbxe9vM5nV7M7BrtwM1q//PgvthRXVOuAzhrRMPmpyIkPW7Z8/XKHO8wMUqzLa
	aEk6M/1Sv7cVOH6MhYdS3+vh0u+72H7s7GPXiJvtrA1CyXOZ7CpWi7uO/a36LfSdZaBvPyU320R
	UsSwT/wn9QOYzduM6mQRxBGQxYwSHEQ1vy6X9dDs6DtiXZ1KpoIfG3kaack85Yc4ktFdYgni28t
	KoM746saYohNOPsZwDBO7V3GVQtJkK6feOIBVJBIRC0tBibhXXp5lMZGrK5ON5g==
X-Received: by 2002:a17:90b:4cc1:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-3933bd0dd0fmr9488113a91.2.1786727572497; Fri, 14 Aug 2026
 10:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com> <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 14 Aug 2026 19:12:39 +0200
X-Gm-Features: AcwNN1WpmtoU4k6FIPFHSGGIV1hhK9RhbdIo5jmu-LZpZf6Lr_HTZrVz_ABbgw4
Message-ID: <CAP8UFD1esJ0fk3xPXvAmQhMK_5wrpGKZJg9YaFV0-qUAC7bf5g@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 0/6] repack: add --drop-filtered to reclaim space
 in partial clones
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, siddharthasthana31@gmail.com, 
	ttaylorr@openai.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 10:08=E2=80=AFPM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:

> Changes since v4:
>   * list-objects-filter: fixed the object-size local from "unsigned
>     long" to "size_t" to match object_info.sizep - caught by Junio
>   * list-objects-filter: made the filter options parameter const and
>     dropped the now-unnecessary cast at the call site - caught by Christi=
an
>   * repack-filtered: comment fixes
>   * squashed the documentation into the patches it describes: the option
>     description now lands with "actually drop filtered promisor blobs"
>     and the guards paragraph with "add guards for --drop-filtered",
>     dropping the separate documentation patch, so the series is now 6
>     patches - Suggested by Christian
>   * improved the "operation in progress" error message to name the
>     operations (merge, rebase, am, cherry-pick, revert, or bisect)
>   * swept test comments to be proper sentences and fixed tab or space
>     indentation

Thanks. This version looks good to me.
