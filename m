Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A611ACEAF
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748869987; cv=none; b=IfLUwOmj5ECif7SRpR+w6Rzf311bskEWIBUmFTTHT2t0eZRn2D0ekpaF5YJR7Lmz+3DcXTPxvuWCbniLWArMlGL609/DNm5BdMxkwaqkWy3+nvzQFHzMoAJmZtoq3Gyht9k27fqDFukbe3GN+RUK+u2DxNk5m5jxkgtaZm/JLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748869987; c=relaxed/simple;
	bh=MDJWR6DBR0PHBvfuomk1aEKVR4Vvg+I0ApS4tg7Ae4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QenzqnnPWmlWzjs5NpG1ev2uT9KRGKsusFW/41Okj7VU4ekF4pdJ5aLRX4TTsx+hYsP42taKKAm2bSjck/pFgjqzCgsytDGf6VBWtmYWmmq35lmQ/lVcUK8Ls6Ixv3LHJAXag0J9qkV3bTCrkhBVtoTsNFAuc7TDOrLbaKkxMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nutrient.io; spf=pass smtp.mailfrom=pspdfkit.com; dkim=pass (2048-bit key) header.d=nutrient.io header.i=@nutrient.io header.b=qjPs1DLq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nutrient.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutrient.io header.i=@nutrient.io header.b="qjPs1DLq"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso7881771a12.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nutrient.io; s=google; t=1748869983; x=1749474783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDJWR6DBR0PHBvfuomk1aEKVR4Vvg+I0ApS4tg7Ae4w=;
        b=qjPs1DLqsuBWSMQMf/X+2V9+Q6Jpp9pXPc8eX5YgH6yoy0DvtktlCrtjEtLylImTOy
         rmIvyFBVZ3CYxEEW+2Vs3mgROWEJHrqC01u0yNGbbvCXzxdknFVxpI7D449tTOX5Ugml
         YHp2b/G2hEDUjE6kL9RCRROBgOV3ozsXg9x/Hc5TOgJ/bOwDUuvwQZCUi1/YfEgCVbv5
         P6CCG/WsVJfqOkVlrHRiYUsA5ir4Holmo4AMMm2nWqZKVzidwd2lTppiJWcColtN9p9y
         9Qa/D7PbDOIDDxxVZ+E2vRFjrEuJ5oRJOpJ8Y0ysU0R6AIx1aEj8HOfPxNo0zlikAyDY
         Z0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748869983; x=1749474783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDJWR6DBR0PHBvfuomk1aEKVR4Vvg+I0ApS4tg7Ae4w=;
        b=OX94YUEPYKIHWvoiZ8D91/UNFxLP1lhLIupEB2E/sOeSi0NvyXUIx/6VoVw6piqPb6
         27Q6MRIGgjllOe1rodcMuVCHZqwc19wdDgf56qoL63oFSETWZPcKq8G48SBZ67nkWVAE
         z4P9EP0kzn4WRTtPHI9hvfZHiC/VKVGuiHzWiZM5sUyn2YZN3Fg9oXOchzImvHSIq+Md
         G7Vb6ogYR5/y6/e1vEX+l+TYroNAzMpP+3xOCAXHtR8nRHFlm8nFNVPvevmCp8utqHV1
         ssa9ZLOCMLg74eXI/UEUDG1ZZGr4S5DdL1boAmEwRHKCmaK2WP4wQC89EpuEbV4LJdv6
         e3Bg==
X-Gm-Message-State: AOJu0Yy+ojxjlU3iuIE88duM7pdRe4kSHJecV0rpLuP8kr2gNIX1qFEm
	KLWrtDyBTW5nxFXEmIuGMnVv1W72IaPID2GVPHo0m5abyxjCut5F8AvsrwPB/5q964Vh0oWWbZe
	BO5AnKkRu4bJ2TqMi9U5VaVk2EnFK/GGgoXc9vxoEnw==
X-Gm-Gg: ASbGncs8P7lBdqA8eDUNgpfDVqaxUleRL/y1gARpvpDAAWpdxEIGj6EIOHq4IJm01QM
	3WT13bPO8wBwuFs1yPCLrPzlMywb6uUp1ntGgQUo+fYpqUqVOdQSP0TpY8kfMs/b2vbbXHXay0y
	ZIxQQUFcalduuc9pJp+TFDHKnWZtuZAq+k+aySzoDesebR
X-Google-Smtp-Source: AGHT+IF4ACPbF2P+ECXBUvM2a5xkV64T+tPv3qRw9pU5ODx5iDXGtRj7BJhEB2zg3Jx0m43UMgP4RxRPuOWMC987GFg=
X-Received: by 2002:a17:907:7241:b0:ad8:9878:b898 with SMTP id
 a640c23a62f3a-adb322b3333mr1074665566b.9.1748869983627; Mon, 02 Jun 2025
 06:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528130116.21534-1-patrik@pspdfkit.com> <xmqqfrgnhuuw.fsf@gitster.g>
 <CANMzfzhhHX1J_vPH-DMD2kPmQ6G_6YUV=7aZ5JojGy-LU6guAQ@mail.gmail.com> <xmqqo6v9es3s.fsf@gitster.g>
In-Reply-To: <xmqqo6v9es3s.fsf@gitster.g>
From: Patrik Weiskircher <patrik.weiskircher@nutrient.io>
Date: Mon, 2 Jun 2025 09:12:52 -0400
X-Gm-Features: AX0GCFtznS7hDIvtqaYFqNdByyb-nC_ZzVzaL2QxcAM4mhb0b5-iAx48h7Ayh_4
Message-ID: <CANMzfzgggS0T9=5FtTdDi0PmVyfQJSp3_nyhj8FxUCj1wSpnZw@mail.gmail.com>
Subject: Re: [PATCH 0/2] contrib/subtree: Add -S/--gpg-sign option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, apenwarr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 4:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrik Weiskircher <patrik.weiskircher@nutrient.io> writes:
>
> > This means my options become:
> > 1. use --stuck-long or
> > 2. make -S not take any parameter or
> > 3. make -S require a parameter
>
> 4. accept "-S[<key-id>]" in stuck form, and --gpg-sign[=3D<key-id>]
>
> which is a variant of #1 may be an option?

Not with git rev-parse, unfortunately. Either `-Sabc` or
`--gpg-sign=3Dabc` would get transformed into `-S 'abc'` after
rev-parse, where we run into the ambiguity of what is an optional
argument again. I *could* parse this manually without git rev-parse
beforehand, but that seems like just adding yet-another difficult to
maintain thing.

```
$ echo $OPTS_SPEC | git rev-parse --parseopt -- "--gpg-sign=3Dabcd"
set -- -S 'abcd' --

$ echo $OPTS_SPEC | git rev-parse --parseopt -- "-Sabcd"
set -- -S 'abcd' --
```
