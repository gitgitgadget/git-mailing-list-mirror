Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CF15959F
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782071; cv=none; b=nqVhC8mQ/tIPDH0iUgjijBTfmOpa9mgq5w4P3alyxxwRBIYip8C12zROwXc9Lm5hIZA4BFbeoG+WEwAr0E6+G6E1kj5kC58g27qiHKFUJF8H/bAmdlK99ge1F7o8SftkXWrmr0xhByOEoTMaEHIpLT0KPAmu26Ikw3f9K92jDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782071; c=relaxed/simple;
	bh=IDiXhS/eeBtMGBkprBJDys5cBRccFSsWECFo0zwJGsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fawLf6UJ3/+4qOk56Zjc6ZJXryfb/ZNghSO9y9v4QS8URtgyMv6TxmOfjTu58dxXyN6S+NgXfflWWLtm7UizQbCtQ6+zXrRLnPPBErXx7Rv1LSg7TuIe3tEajjAxixQq0Bt3TSxfbpVBgbIoA5RtvlLnWFlToHh6kyJkY4R5PnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg54xcxu; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg54xcxu"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2228c4c5ac3so4201316fac.0
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712782069; x=1713386869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXZfs5RCg3mKTEPxLDrp9yyXgLMTleKPjCWv2gmSh/Y=;
        b=dg54xcxuIjBCVwnI+uH2VburMbQT5XLY1CBvt3AURYQP1UbQzZizJ0XCo3dpWsxNDP
         WDk//Tkb6ldfNjm+Y53qLGUG9LKsUI7Ww6HD0UvI7yojMbP4/jMt9+6bDpvvlV3mcOK9
         vKqjyJ5MNkxNGJh+us/8RhiQpjUfTfDkPluHkoNuKL4IrAFLhxywNSiaKM120so/WS7+
         37ECJEXWpro2q49OLWMLafdwy8y9aY/6NuSlDVoHOnLD574MCK21m3J+sMzT1DTZu24r
         gljFJN66Or3n117029LMbNkw/0do+wYiennFVj/gDliG+SFk1EWso2cCbmzFDoB+y/dG
         l2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712782069; x=1713386869;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXZfs5RCg3mKTEPxLDrp9yyXgLMTleKPjCWv2gmSh/Y=;
        b=GqFXK0z3q73oiA3sKIY8P06ErOH7NlZc3WiE5KeK1+fodxpnJL83F1jd3yOeOLVWnT
         NPMnSdgdWvT7GNybmrJ86PestdN7S8MiiDZef5lpZjU6H0UBXi+uvtKKGteF2yKpVHdg
         DNaMmXMrBQ1GK/BPXA8yFUPcsidP2stxxo8xLGk+KejbQAYp2i/vMckfuRzIrb5Rk+cF
         0B1bj3gehoXMzG+3WD+8kt6q+lJB5Ffqcl2SmDm53d3gcF8RfHSKnCC24Sa6MCf9qeGu
         ZsTX2GZwvk5oJJn/8StLbpFTpRfQgTpwfJ8ibDiJ2ncif/5R8ifjm7Y/2cyGwubJG2Rr
         Y7pA==
X-Gm-Message-State: AOJu0Yx/7OZu4Y+6jjxgl2MxWLCq0Z/gmHLbTUF4zMsbjFc67DgoJWVW
	TosjsfBj8q0aY4+u9j7FcUiAGhM55TYN3EnE2gTSER/SZzxw5zMl
X-Google-Smtp-Source: AGHT+IF0t8gx4iDz05qgimr3l09n9BqICl2ruoQu/eaE3uXDoaJkQyeV7lSmeyRbNIH8/ug5Q9oMfg==
X-Received: by 2002:a05:6871:b24:b0:22a:6d7f:6171 with SMTP id fq36-20020a0568710b2400b0022a6d7f6171mr4326854oab.36.1712782069353;
        Wed, 10 Apr 2024 13:47:49 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id ry5-20020a056871208500b0022f7268ec29sm29651oab.54.2024.04.10.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 13:47:48 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:46:49 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/12] ci: convert "install-dependencies.sh" to use
 "/bin/sh"
Message-ID: <powdcoghaz226mefeeoinoyryzhooiqifrix76hocdd7scu42x@xbfkvqu5aa4b>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Luca Milanesio <luca.milanesio@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <6abc53bf5173e7de3fa271d175145c1672f17a88.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6abc53bf5173e7de3fa271d175145c1672f17a88.1712555682.git.ps@pks.im>

On 24/04/08 08:46AM, Patrick Steinhardt wrote:
> We're about to merge the "install-docker-dependencies.sh" script into
> "install-dependencies.sh". This will also move our Alpine-based jobs
> over to use the latter script. This script uses the Bash shell though,
> which is not available by default on Alpine Linux.
> 
> Refactor "install-dependencies.sh" to use "/bin/sh" instead of Bash.
> This requires us to get rid of the pushd/popd invocations, which are
> replaced by some more elaborate commands that download or extract
> executables right to where they are needed.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/install-dependencies.sh | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index fad53aac96..7bcccc96fd 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env bash
> +#!/bin/sh
>  #
>  # Install dependencies required to build and test Git on Linux and macOS
>  #
> @@ -30,19 +30,14 @@ ubuntu-*)
>  		$CC_PACKAGE $PYTHON_PACKAGE
>  
>  	mkdir --parents "$P4_PATH"
> -	pushd "$P4_PATH"
> -		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
> -		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
> -		chmod u+x p4d
> -		chmod u+x p4
> -	popd
> +	wget --quiet --directory-prefix="$P4_PATH" \
> +		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
> +	chmod u+x "$P4_PATH/p4d" "$P4_PATH/p4"
>  
>  	mkdir --parents "$GIT_LFS_PATH"
> -	pushd "$GIT_LFS_PATH"
> -		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
> -		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
> -		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
> -	popd
> +	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
> +	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$GIT_LFS_PATH" --strip-components=1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"

Do we want to fold this line since it is rather long?

-Justin

