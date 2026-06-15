Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFE30E858
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556474; cv=pass; b=TpbjwZfQ4Fez5nhiUVK6qRLmafuzyW8ggvsD2maeurjQNkILhvrjMsrp9rBv0loTPwyH4i3J/4tYa1pKokyiSLdkgt/YKZi+o9Rj036Au9YuuKlsJwYzaFrT1BU4/2fq9JsEtmEDNfOsv1M6M4C/JAQvAnwQ3LVWj0PZCRbmhRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556474; c=relaxed/simple;
	bh=o/UGZa20pOnsOYkg+HO9uyYyPKxGYKpxY1WQXmdkBBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M34exSghU5VxNyt7SxRwcMPuB/N7EaRrm5pncoLQ6FOR2NZg8FbkIvITMsf2XFpo0RjQ22K9QAa+kgysOC01q0/+1Z1yQ6Pxg77ReaKuc4whufqG5oRutLu51TacsFRe9uUqEw5QQGFAEbGUHPe6JxA2QPYOPxNMeiznGDt0gOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq/gm+Gb; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq/gm+Gb"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa5ce4904eso3684881e87.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781556471; cv=none;
        d=google.com; s=arc-20240605;
        b=kNhq61ywheHVTgq3kmtQBvjUmW5HpcJaiDTJ/B2PJtfQrp1vJ4SXNqyMd/IPKRvIRx
         3eKzhLgY+/J8+uikCXuWGgTDvxy7NC2PhsLeiSUdXK8zM8iEIX9TY0ncsTJORjKZDSNj
         67R5X8pf2ioy71wWhS6HPffN5saj+j31Ui8/oTCvbWgXsGwK/4vCb+QNywlxqYRWwlgr
         kAyzan1RprFKkrBu0oYiPVlc7Bs4cqqW+Xa/WdfGuIv7CEd3AQpkfOSxPrItllUIOStb
         5H6p2iTp4fgrgaQg94opDdxhpEtDA/hTzwKI0eBfKGH5B/XWgj21k27B0m5EbK72IiKT
         eL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Or7w2SlWNBP4/6FkbOu0n5CPwivgdu9XsfNQ4H1sIU8=;
        fh=RD/vUOVMoT1UUKxjcxCpxkPLYvwUpf2EQL3VSfmX2rY=;
        b=i3cChVUwwj1rOFyxEpmHE/xdd/ycu6Vgf7OUrrY2dPcIke/qlN7mjeZZVp1vtrtF+3
         Cj1vyKdYfZrwZSGfUnpg8oUDZ2DNwEMBxJTcUzuQ7By8SxhmpnUrBXlW2QdZOFCpInrn
         mIKQAQBaSNY7QQdLpH/es4Ut3vnybQqwV3j0rZohRrimAM/QXD5UTAnl9An5ju9AS+zg
         qB7JXaLlSFDJkt1XMD8bGpVHCnvuDmM0GWShxl4RT6U7xVOqyFzVh6SGNn/RzJxHFQu+
         DwXKLM4ZNJKVdSTS6i/r+WT1Bb/vC8448dHMTcSOS8po/Yfu/StucXaafymqvN2aj+mq
         JDPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781556471; x=1782161271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or7w2SlWNBP4/6FkbOu0n5CPwivgdu9XsfNQ4H1sIU8=;
        b=Hq/gm+Gbu26GaVo+LM2MZ763aBkRTrQOKuhlzQ8iV+ACXgpg/znwY6Mbvx2Q6n+Bio
         Dph9ImqEnd93qz1z/7m0TiVVkh2fFzE3/j1PmJWsZVYZdiTxCdcDtmp7fr847zKaf0ON
         64n45YCyQpfNFqrKKvc8h3kDd9OMY3GDnW0yzCawpqCEJvFAnxEH+cLgA1T5pQkjnGo+
         hCUUX1p7AyxUdVTSoHcNxylGrSnTBaqx0E/a43EBFi+mOmlmirrsRdb7PUi6P7wRVXds
         VJemi0v3ZhzRovz9U/NlseflJhXMfWUs72iVRDhmOqYvymtti1ZRgIiq8KVJHp2bFl6S
         ZRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781556471; x=1782161271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Or7w2SlWNBP4/6FkbOu0n5CPwivgdu9XsfNQ4H1sIU8=;
        b=FpTtGCoQ/bVJBBsEWkRONk+C8kqlIPr34fK3Aa/Qk94RkBAmWVvULfqjYdbD9JRF+H
         SLjGopwTNEyF6XA8h44cUUcc85MkipWf7TR/1ewVW382k3GT2NIGJlWWR5NBR3QGpzil
         H9dTxyB9tdVG247S5jDN2mlFtDNqAJhYoCDOsFJ+cMQQZR2D557ffY6g3e62Aq6o7RIt
         WiNvwDzTJ5wTZF4V8UClN9tp+CKNKwAjYQu2zVyDZK4LGwV3EkyuTyIFMhY9nKiBI8pn
         FvbZId9eodWNHLppn7cGxYIEWlxQX1+ziOAjK+9RKz2iRUsjhq0sTuypvdIm1HTJ3hS8
         QWTg==
X-Gm-Message-State: AOJu0YyZPaXgZP+LFeOKM/Xfnq0MrcyIh5AN4//i19tpKYO1f91snJgu
	BdYYknQPvUa8/G9isYBo20umSakz+OuS2/oG067XaYQX6OYshLE0Unxc7a8oQ+SVjY3L7psyOPc
	XEe6FnaAXUOazj+NwZ/yESVb4skOkOJXcpAii
X-Gm-Gg: Acq92OEMb6QYof7JM+kXyY0Z82lot+DlbKbiSK3gK8ixh0QQVZb838l3NR6SxvkJjrR
	7OF/1e8YsmJsXVURRUbWXFMAQjsLW2yjo6kBCl6Adl3L+wkeDcrac+247Blc7FGDm/6/BB6SXDq
	Y9WDVhXR/iJfORU5JPTf0NwhJL2z62suFEX9TAnsfSgj8So3Ziljq5b50CeXKbxq6KELYDAFu6o
	Y+vzJQg9/eRpH0dsp+8jRgqXNDeFze4Recq60iM1kYX0Ead1YVXKNGNGo7gyGXnvagTlnUdcv2c
	45kECnw7XwAVNYppbtVxuQjq2G4ZZIQwY8o3GoakJzX/oP2cVAYL1GsLT7ItNC4+OPrc8DxZFmv
	r2JE3M/4lX3ABPFNXr8RjsVuN71w3
X-Received: by 2002:a05:6512:64c4:b0:5aa:8823:e312 with SMTP id
 2adb3069b0e04-5ad437531b3mr153639e87.48.1781556470669; Mon, 15 Jun 2026
 13:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com> <20260612-fix-git-branch-regression-v4-1-f150038c02f4@gmail.com>
In-Reply-To: <20260612-fix-git-branch-regression-v4-1-f150038c02f4@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 15 Jun 2026 13:47:14 -0700
X-Gm-Features: AVVi8Cfs7Qo6u0x6Ux4KpuW2kJ38tEKFCPsQqsYwOkWbEx_mxdmI-LNrbswLXdQ
Message-ID: <CAJ-ks9=Qa0956vCmE=RyReu4jfdXzjiSO4rRGD9nGbNNrMvOfA@mail.gmail.com>
Subject: Re: [PATCH v4] ref-filter: restore prefix-scoped iteration
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Victoria Dye <vdye@github.com>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 5:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> dabecb9db2 (for-each-ref: introduce a '--start-after' option,
> 2025-07-15) changed branch, remote-tracking branch, and tag enumeration
> from constructing an iterator with the namespace prefix to constructing
> an unscoped iterator and seeking to the prefix.
>
> Review of --start-after noted that the construction prefix and seek
> position represent different state and are easy to conflate [1]. It also
> noted that future branch or tag support would need to retain the
> namespace prefix while moving the cursor [2].
>
> The files backend constructs its loose-ref iterator with cache priming
> enabled. cache_ref_iterator_begin() immediately applies the construction
> prefix through cache_ref_iterator_set_prefix(), reading loose refs
> beneath it before packed refs are opened. An empty prefix therefore
> reads every loose ref, and a later seek cannot undo that I/O.
>
> For the current single-kind filters, construct the iterator with the
> namespace prefix when start_after is not set. Leave the existing
> start_after path unchanged; no current command combines it with these
> filters, and future support must carry the prefix separately from the
> cursor.
>
> With 10,000 unrelated loose refs in the files backend, the p6300 tests
> improve as follows:
>
>                          before   after
>   branch                  2.74 s   0.11 s
>   branch --remotes        2.81 s   0.12 s
>   tag                     3.01 s   0.11 s
>
> [1] https://lore.kernel.org/r/aGZidwwlToWThkn8@pks.im/
> [2] https://lore.kernel.org/r/xmqqikjq7s16.fsf@gitster.g/
>
> Fixes: dabecb9db2b2 ("for-each-ref: introduce a '--start-after' option")
> Suggested-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> The series is based on a89346e34a (maint) because the regression has
> been present in released versions since Git 2.51.0.
> ---
> Changes in v4:
> - Explain the historical references in the commit message.
> - Run the new performance cases with both ref backends.
> - Drop the Assisted-by trailer.
> - Link to v3: https://patch.msgid.link/20260610-fix-git-branch-regression=
-v3-1-6fd48fad7a53@gmail.com
>
> Changes in v3:
> - Construct the iterator directly with the namespace prefix.
> - Explain when the files backend primes its loose-ref cache.
> - Condense the commit message and performance results.
> - Link to v2: https://patch.msgid.link/20260608-fix-git-branch-regression=
-v2-1-fd82075a8520@gmail.com
>
> Changes in v2:
> - Extract local variable `store`.
> - Link to v1: https://patch.msgid.link/20260605-fix-git-branch-regression=
-v1-1-02f40ad40929@gmail.com
> ---

Hi folks, does this look reasonable?
