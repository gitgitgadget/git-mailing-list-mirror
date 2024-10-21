Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B01E22FD
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545695; cv=none; b=KRxQGafeTC+QF0weAcSJFxYuEvuTloxTlNydJPCK2EhStbRe3mGDJBmVlQhPd/o9DBm8PasJODFkILrb5zCgm68xJNwwK0yjqMt8aqmlotsbFEaI7bnIZsN6Iax0Z4A177oYJ3XV42UcYpgbakFIR618f6C63U3ZYHFjqJObfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545695; c=relaxed/simple;
	bh=lCW2psU62p6X2AvM11JPmACO48nVZozAI1o4+kC1gxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agWbs1kXrhsUjfKaSYVyXwXNp0OuaGgbfJvB2E0F9lX49f6GHe5KThPbLBqoYn4hvDpe8N3xGgiBJ/T/9iVdNj/svsYFEtF8BvIjjIw6s8q/E5z3dgrRxB2sUO5fI6MegJD2XGKl2KlA8gXuRS38VF+e8K+V1jQIjnntVtCmiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fQRC+hya; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fQRC+hya"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e297c8f8c86so4924583276.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729545693; x=1730150493; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c4G0cSpFQ/NSGXxXvXHkdNxiv5hEDilLuOey46v/fFg=;
        b=fQRC+hyakbCfxz+puOXpe5dMYatvR3mrn3tYw7xkAX7hWkq3BlgRwoGOlzWTcLMwaC
         iyMRlFMiM5JdPsKTAt2imIW/O4lp01s3s4qkVUTOgXGgsyZjQwZJuqNJMoh0PUGAZG8W
         x+o0mtoboZPrGOrnYTTxDjqb3RZkaiZdXPKtwznuCKsQZ2ZObOLLsrfoohYfnnk+tzKK
         jzdszkSERf2o3qbWwXq1mscy5hrEUS/p15eZLvalcK9ca+++GJQci2Qe/xhNLpSdjwsr
         5RCcLRpyRmEetEbzsw8Z96XrhhvyOQpSPTYH3pmWtv40fo0bZO2/kPX50s2ou1PeZJOS
         lgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545693; x=1730150493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4G0cSpFQ/NSGXxXvXHkdNxiv5hEDilLuOey46v/fFg=;
        b=WMtit+QotzSfMn2mleZYWEBhmyPFpYES6V0gjGJJypJq4yTlIE5vFvhxHc1KB8vmJ9
         Rc4GYpqM+aTnzxk2PjmWggezIyy6alxHivZc1z+s+vhfBONFwgLUQSnhCLekmr+1bRk0
         lXzA2RiyUUL/fSlPVPNRrSHDdGOaE50rPf34Di7lIssd32T1mXgII2UAWWNUcuZD1XUz
         5UOxORR8ScZM8U0YoBMdbWOjeiH6R1FTWZHKf89fa+LB5jslaJFoV0HwyXJSZDOHY0+d
         4G4xbwd7awSEWrdkKIOXhP8ZJ+ECQmcanUPu2b8yViHgnvwCbtIvpAY4tjGwNy0gkcGC
         WJEg==
X-Gm-Message-State: AOJu0Yx0chmrLFp1SdMT+BDuNywd4ilnLEHcbuP+4h7ONFUW3UR2QJE+
	ZNAhp6i/2H0boEUgY88fyYGW0T08cVsAuz+yQiYhFLxOu9+l68kVD1f/WMFQOnHd1UDOXNaWYaF
	A
X-Google-Smtp-Source: AGHT+IFm+1t29zWL4Zizqxh0JvgmwQLY5AUczNQC6d45avgfPld1o3HCnPakti9r2om7mAlaHxy0HA==
X-Received: by 2002:a05:690c:4907:b0:6e5:de2d:39e0 with SMTP id 00721157ae682-6e5de2d5659mr94602087b3.42.1729545692748;
        Mon, 21 Oct 2024 14:21:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f56absm8335107b3.11.2024.10.21.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:21:32 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:21:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	gitster@pobox.com, dsimic@manjaro.org
Subject: Re: [PATCH v2] t7001: add failure test which triggers assertion
Message-ID: <ZxbF2xxqh3rTgXvN@nand.local>
References: <ce1b5ae24ed8356b9beed340fff61e96f7c1d549.1708259215.git.code@khaugsbakk.name>
 <29d71db280c972c91174bd0a501af66be72643af.1729462326.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29d71db280c972c91174bd0a501af66be72643af.1729462326.git.code@khaugsbakk.name>

On Mon, Oct 21, 2024 at 12:14:46AM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> git-mv(1) gets very confused:
>
>     git: builtin/mv.c:506: cmd_mv: Assertion `pos >= 0' failed.
>     Aborted (core dumped)
>     test_must_fail: died by signal 6: git mv a/a.txt a b
>     fatal: Unable to create '<path>.git/index.lock': File exists.
>
>     Another git process seems to be running in this repository, e.g.
>     an editor opened by 'git commit'. Please make sure all processes
>     are terminated then try again. If it still fails, a git process
>     may have crashed in this repository earlier:
>     remove the file manually to continue.

There was some good analysis of what the problem was in the earlier
parts of this thread. I think it is probably worth capturing some of
those here, too.

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     It’s been a good while.  Let’s just add this as a known breakage?
>
>  t/t7001-mv.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 86258f9f430..739c25e2551 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -551,4 +551,16 @@ test_expect_success 'moving nested submodules' '
>  	git status
>  '
>
> +test_expect_failure 'nonsense mv triggers assertion failure at builtin/mv.c:502' '

Do we want to be so specific about the line number that the assertion
failure occurs on? The actual coredump triggered by this test will tell
us that information. But in the meantime this line is likely to go stale
as builtin/mv.c changes over time.

> +	test_when_finished git reset --hard HEAD &&
> +	git reset --hard HEAD &&
> +	mkdir -p a &&
> +	mkdir -p b &&
> +	>a/a.txt &&
> +	git add a/a.txt &&
> +	test_must_fail git mv a/a.txt a b &&
> +	git status --porcelain >actual &&
> +	grep "^A[ ]*a/a.txt$" actual
> +'

Thanks,
Taylor
