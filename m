Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259C154C12
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765027; cv=none; b=HWADGLnQLedtSEXb0VIy/z/2ZgcEFJCu5gMwYMYgWmMfbMRVRuUyhboPGecHmTVVeVT0Q8PbhDjYFf6r8910clK8CAj1jdvYAZSpb1tjaC5Bgtyrv9fF0dhOqn5u9bXWOsm8zaSg9/VHXrvu8KygaJy44WSXoECrwZbHZ92OYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765027; c=relaxed/simple;
	bh=Uyf+lVXp9jO/Svi+Und4YtWXEpFbGfPCZipM6WASeeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBWkpXpIAYA6c0WAAjxc9VOQLNp6bb/G97Gaml/F9OpBwxjeeJKezIbNr3qt5EalKJku9e58CMOJWwxWH1QJjMmZMG8A4j5wOfdreGjupQEovkkKZeUitS93xfbMz5yUWQNgo8RBRVLlkg1UaxRXgqIG7obpwA42SHs5ueX9kJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvSEEbbB; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvSEEbbB"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b1e962fde1so34710eaf.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714765025; x=1715369825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyucwJ6InUsKzuJOBwh1zdvH5MJ7tMm/SYSbYg4y7LE=;
        b=NvSEEbbBCtKetFdOQNVUQRqB0gJhn22sqb1/xjpowOJMwBFwSxtXGB831nOhhl2+nr
         IrmOO1K+iwPx6YZE2UgpDeePhNJX2ko0C/q+RANuVhyX4LlT9ZpexjO/pFAZb6SXzv7M
         UAxOP6pw0DyqKmJTVpXaAM4puuClerkFZQx/oVWclV1V08x8ZZU/aH5eDYY5/v8ogDPl
         dRcYvdpgn3hZXDt5AS6hEIA32MjY2J64gvyHwboBZW/FtyuTVZwINPXJ+63rNdtaxyr9
         fkP/idoHmGmQ+SdYHeDpmfR9tsJWmbfssE4sEmqP2CoZHrkrtlIr1IAW4Ho2nEBRy6sz
         M4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765025; x=1715369825;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyucwJ6InUsKzuJOBwh1zdvH5MJ7tMm/SYSbYg4y7LE=;
        b=ksFnCqmU1GJ+Rp4W5XgTNHsG0txWyliez2S3n54N7Z/tZzRQo+FCJAGtVyktEWZvzA
         wAO4jiCPXAXYTcd0Jt/nG9RlyY2f0X4rKtQ6lUpgq3Ct7RvtmPZVggSWl/MhxqgXGOz4
         oUgSfM9W93Nzy3Y6oQhIw2Jpsak84IyRE9LWjfA9AlgyUCHYh4eoflVUfS3bwJbVzJn2
         pgzhDXlMjY7qpOrtGvG37ZVhuMganIBG0xVKzmgVoS0PJGYmQ9on/IFWmUVpkdCeSaGx
         6HpIh8Ma1exNs/0fsrbJtMIPxzPKTer3t0AEtJRr6CXnAxX3phd0B+5jGcS+2ZoZU/m5
         AsgQ==
X-Gm-Message-State: AOJu0Yywe62OPEHjj1anTo7RL/hM/blx3Fbe3ckBFgat9tADLbR/UCBP
	t047qC8CqsxRpL9Z1Zr+v6I6QjEOGKEyJN0/W2tn3NBfp0ye3dv3
X-Google-Smtp-Source: AGHT+IGhV1sMRWanCCx/p/SliVbiZLn8aUEUhM3a0VF/7veigNowezj4+cnHAxZHqE0MWFB3poDXkQ==
X-Received: by 2002:a05:6871:29b:b0:23e:5b1d:54c with SMTP id i27-20020a056871029b00b0023e5b1d054cmr2878265oae.45.1714765025188;
        Fri, 03 May 2024 12:37:05 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id py20-20020a056871e41400b0022ea967bb9dsm721223oac.50.2024.05.03.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:37:04 -0700 (PDT)
Date: Fri, 3 May 2024 14:35:46 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 00/13] t: exercise Git/JGit reftable compatibility
Message-ID: <2hhwttin6gvs2munwpl2zhnm2573bm5vklbk6mcwxbgc7z5sog@3dygnrnnnpna>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Luca Milanesio <luca.milanesio@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Toon Claes <toon@iotcl.com>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
 <x7v4d4siixs3wllzycibxtgsqipnwohhyxg72zvcxboucshd2t@won3yobvixbu>
 <ZjUxY7kqgy-iLIzG@ncase>
 <ZjUzjhN78lqYtXqT@ncase>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjUzjhN78lqYtXqT@ncase>

On 24/05/03 08:57PM, Patrick Steinhardt wrote:
> On Fri, May 03, 2024 at 08:48:03PM +0200, Patrick Steinhardt wrote:
> > On Fri, May 03, 2024 at 01:42:32PM -0500, Justin Tobler wrote:
> > > On 24/04/12 06:43AM, Patrick Steinhardt wrote:
> > > > Hi,
> > > > 
> > > > here's the (hopefully last) version of my patch series that introduces
> > > > Git/JGit compatibility tests for the reftable format. Only a single
> > > > commit changed, where I fixed two typos and added a missing signoff.
> > > 
> > > With 35e293e6 (Merge branch 'ps/ci-test-with-jgit' into next,
> > > 2024-05-01), I've noticed that a subset of the `test:linux` GitLab CI
> > > jobs have started failing on next.
> > > 
> > > https://gitlab.com/gitlab-org/git/-/pipelines/1277877090
> > > 
> > > I'll take a look.
> > 
> > Are you sure it's related to this merge? All failures are on
> > "ubuntu:latest", and the complaints are about the "python2" package
> > being missing. Given the recent release of Ubuntu 24.04, maybe the root
> > cause is that "python2" does not exist there anymore?

Ya, you are right. That appears to be the problem here.

> Maybe we should do something like below patch. Basically, we start to
> acknowledge the fact that Python 2 is end of life and always use Python
> 3 on ubuntu:latest. We might go even further than that and only use
> Python 2 on ubuntu:20.04 and slowly phase out support for it.
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 473a2d0348..3967a5af85 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -325,11 +325,18 @@ ubuntu-*)
>  		break
>  	fi
>  
> -	PYTHON_PACKAGE=python2
> -	if test "$jobname" = linux-gcc
> -	then
> +	case "$distro" in
> +	ubuntu-latest)
>  		PYTHON_PACKAGE=python3
> -	fi
> +		;;
> +	*)
> +		PYTHON_PACKAGE=python2
> +		if test "$jobname" = linux-gcc
> +		then
> +			PYTHON_PACKAGE=python3
> +		fi
> +		;;
> +	esac
>  	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
>  
>  	export GIT_TEST_HTTPD=true

This seems reasonable to me :)

-Justin

