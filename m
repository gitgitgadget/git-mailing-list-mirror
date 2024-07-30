Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81124145A11
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379762; cv=none; b=etX25oC+S1BT51ZZPw+PKwyvI9Eytvs+O//Q1QpOwFb9mceYCSDAsPZfzWp4B4EABxwRs01Qt7NHVmzpekOJVprMCItc2Te/O54n83sccF8B5KXdRnDZZK5rZywJC291asgpeEc/RPke3vomXot/FP0CsxztnjyVtBwQ/C+J6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379762; c=relaxed/simple;
	bh=NkbYXP6vaT9u6CeiXFzIWwlQfPPfFtg4MAztCMUUV34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLxLv4Xkwkcbv2nw8ozC6DsZ1FK7hjp8sGbd2iVzcQDm3sumh/Gy74iUflUN3usQAQ3BsiPsqDrCZFcpw8VBgvPEZ+PLPx9MJE83B2LYUv22UTVlVrs4aZMU97FdXcu3gJxnLVyk8jMOx/2XkNKBolaWPKsCIwtz2uG8I7m/phU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdHY9L3Z; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdHY9L3Z"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-260e6dfc701so3211099fac.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722379760; x=1722984560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGqeGYsstUaKWYaJO6F9fbsb14CumSiP4oCYD2iSkZo=;
        b=FdHY9L3ZV22RzQt/aS2CJe+4Aju2a6X101ziF5PftHvgLrgEUuy5mPuUgeDApYQRMe
         nQftgACGt7MOxZNhOAEQHwmXx+linnhA1GqTFr6xGmeTP5Gmj1r/6afDFbI6Dvw0qkij
         ixKgu9a4CUt7gmfM6qn618/pgv4CEb1/rSSnS7eO4BkzjTe96PIEOEPJqm6oWdwNfnjh
         SikOt26UTDUUeiVuBGkrQL7tfi83FDc08txXkRPzaYyIZBlQyw+kuqJg6uDotdykSxHW
         I7fMVRXY2K6Hfwe5nYb0TD1Hc2P01kVLpeijSuo+6oxgxbfnX47K4679/axhg6Hlw5vc
         eAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379760; x=1722984560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGqeGYsstUaKWYaJO6F9fbsb14CumSiP4oCYD2iSkZo=;
        b=V517Pkv0rEaC4sSKMEWmYBe2JAGsEduwrNoSGydbejVN3XNinTO9hcsqYXSfbahRL+
         mZLvJKN2M8eNIzZJc2nQ5LFs2Ryydzb2KRqnUEe8646PZaCs1d43CPD/hurEE/X9TIKt
         Pmo521XxOP1U2HdZ/C1mK7N4SPfCPI99QfpI2CsiZVAsrZY5T9XdTOg2EI1XvAkMv9Za
         KnJBJyFz0vfBiqXi+jIMlkWnKXXDmt/QjcK8GJuo/0r1ABWMvJNMIEtKf80dVJ0JUR6B
         l9zZfVSoKUk46ggtpE/1h06rEjoWmL8Nxxm+640j5WzqSathZIfyPjn/GEWQ1MX6oizr
         THqg==
X-Gm-Message-State: AOJu0Yy5L7xgNxTGc6wi7qMe8aCjapRUidULbadm5gxh+1QSOmHpATnt
	UrMJ4aVz60+p/n/p0ZeeoJlLNrMYIU4HcVNSBZROL30FsaGGHSsx7uTiEQ==
X-Google-Smtp-Source: AGHT+IEzJQc7QNxp7T5pr8+1ZPW/OvlxswYRrmnWIKPe4U02utIF3vhDb6qG6ukVt535Yv+4TJB8tw==
X-Received: by 2002:a05:6870:3749:b0:261:1deb:f0ee with SMTP id 586e51a60fabf-267d4d5ee5fmr15411029fac.13.1722379760560;
        Tue, 30 Jul 2024 15:49:20 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7095ad69356sm616010a34.19.2024.07.30.15.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:49:20 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:48:38 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: update Perforce version to r23.2
Message-ID: <xy2vh6bv6sjixvwd6fifuctozjizxns5evvgnqee5s6snnzb36@5hhtwvdk2a36>
References: <cover.1721740612.git.ps@pks.im>
 <ee5d836b779087890acdad061ef6995642942479.1721740612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee5d836b779087890acdad061ef6995642942479.1721740612.git.ps@pks.im>

On 24/07/23 04:05PM, Patrick Steinhardt wrote:
> Update our Perforce version from r21.2 to r23.2. Note that the updated
> version is not the newest version. Instead, it is the last version where
> the way that Perforce is being distributed remains the same as in r21.2.
> Newer releases stopped distributing p4 and p4d executablesas well as the

s/executablesas/executables as/

> macOS archives directly and would thus require more work.

Out of curiousity, for Perforce is there a defined range of versions
that the Git project supports? I guess I'm trying to figure if it even
makes sense to support older version of Perforce in our tests.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 6ec0f85972..b59fd7c1fd 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -7,7 +7,7 @@
>  
>  begin_group "Install dependencies"
>  
> -P4WHENCE=https://cdist2.perforce.com/perforce/r21.2
> +P4WHENCE=https://cdist2.perforce.com/perforce/r23.2
>  LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
>  JGITWHENCE=https://repo.eclipse.org/content/groups/releases//org/eclipse/jgit/org.eclipse.jgit.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.202311291450-r.sh
>  
> -- 
> 2.46.0.rc1.dirty
> 


