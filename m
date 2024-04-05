Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84B160798
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308489; cv=none; b=MRETi02PWXoN+oNhNzD+gZ3GNSDPoaYACWP+pG9+PQPs2TV+y3Mid4e+0Ep6YldbymeF++c3bTJxhz48W69R7kIh06ZSm+7g6Pbn4WMDptdwQuIlq1NamA8nao02yEmHSG1hlU4VDjWomUsSUQ1YySR+fC439spkLvY0+v9yohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308489; c=relaxed/simple;
	bh=84/jj2w+X/mNsVd9shPJWqNvh7JLNf5/WTO423Lsr9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbOG4bEFkwgKTreFHWCBT0O7OF3eK3jK2FgTj5nWFJ4Q5s6Ifk4b+bkLAuOuKGuOgE9kSOvaEALtKIqAfkZk3yUgwngqU9EKPmEjjcXqv5l2uIrY+sYMlkNTUGSX+0QvE41LPdMANxmGo1EvR0O/2gwXYjaegxX+6myDcMbbAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29e0229d6b5so1499708a91.3
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 02:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308487; x=1712913287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g9VSTAjppVbhYey2TidBVy3beFErsR4EoVrC+Z9U2Q=;
        b=M9zelLCeEkyg7rsUi9Ht4EEOCMkZm2I2JVf5Jye+SWWHgozHbzONYoiNPKe6QU8lXs
         NhLJntQ4JQyvdiqVgboPPEMcI7alWq1ihj+MELPhJFmAgqJ7YD44tf6XyCvEKbEuCdjZ
         jAQH+CQDBDehsiWzK4FmqMNaRst4v0gRHxlo4K9WzFoZl68O3Xp+DyguTufxRgRMM8db
         5+QgnpSXdlQek7ZeXPTcVIBQvjQc13fV7NGC0NYuD+v8KCNtLUIpRafhNsbdV1/NzLba
         PmjWVQb0wqF/NaqS+Jhbk86WfUij6V4UP/HU20nYoitABuE3K7fek+LMXfrtYUV2/ITf
         qynA==
X-Gm-Message-State: AOJu0Yz9Auipqu25Lw/mhNdzDmja03Nd+UFSF2/RxO6sjoczGA1nbTfw
	fqoLrUAwWc4EcVu1ZTOEOsKAfP5PaS/0JkPLHHdhKzYjVppseG+7gb4Lny3U6vOjxUWV4sfXXLd
	BaVnFSSmlVJ30p1aI7hsUPUVJC7w=
X-Google-Smtp-Source: AGHT+IGOCfYS91yhvGHB8I+AmmDLJ0/7EUADRiuG2o+mlmnMkNUrZyIJ9wl83YLNV2MmwcqmVzltmhAI1mGhw2HEzHA=
X-Received: by 2002:a17:90a:e00b:b0:2a2:d16a:8df3 with SMTP id
 u11-20020a17090ae00b00b002a2d16a8df3mr746126pjy.40.1712308486653; Fri, 05 Apr
 2024 02:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712235356.git.ps@pks.im> <c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
In-Reply-To: <c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 5 Apr 2024 05:14:34 -0400
Message-ID: <CAPig+cSb_cKXYaNCBpe9Uy_iGB_K2NXaw4d1hg5bPuVaCEWvjA@mail.gmail.com>
Subject: Re: [PATCH 11/12] t0610: fix non-portable variable assignment
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	JGit Developers list <jgit-dev@eclipse.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 3:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> In `test_expect_perms()` we assign the output of a command to a variable
> declared via `local`. To assert that the command is actually successful
> we also chain it with `&&`. This construct is seemingly not portable and
> may fail with "local: 1: bad variable name".
>
> Split up the variable declaration and assignment to fix this.

Under what configuration, circumstances, conditions did you encounter
this problem? I ask because this isn't the only such case in the test
suite, as shown by:

    git grep -nP 'local ..*=3D\$\(..*&&' -- t

What makes this case distinct from the others? Including such
information would improve the commit message and help future readers.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> @@ -80,8 +80,9 @@ test_expect_success 'init: reinitializing reftable with=
 files backend fails' '
>  test_expect_perms () {
>         local perms=3D"$1"
>         local file=3D"$2"
> -       local actual=3D$(ls -l "$file") &&
> +       local actual
>
> +       actual=3D$(ls -l "$file") &&
