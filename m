Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC421E4A6
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038909; cv=none; b=WPBEpjLCacMamscj3hF9xiqXZBUsfuM0kN9drIGp2u9vYQGw/+/pycEdsF+ZK7XnYK1qqEPaB9KyPJcoL9NuTQUdJ3It7Ste/7Q3i83cy3PKKaTnOeyhnl8k04dOq5rThPr8pq2bgLhN8Xhxmsx1Oz7WeGyX33GimZbl0+UDadU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038909; c=relaxed/simple;
	bh=kU8z2HCmS7GWy9Az2ruAgooDErwgjgcE5U1RNsatHbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4N5fh/+PfJ95+oizwLHDDHCvMjTT/tgDoh2oELvTNRHUpWd46hrYxGK1f0lIbVhysYwtiGmgr/F7nTevzshvqxl/q7x2m8go6hZ0KgOoiZVD+awG8uI6JXFTMOCDhLTfrDK4GhZ8dRk/laaMa4cRHhp9uUimr7viHom7OsCt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W87OUSEe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W87OUSEe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166022c5caso165980375ad.2
        for <git@vger.kernel.org>; Sat, 04 Jan 2025 17:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736038905; x=1736643705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCZ/4dPyKPj3YvPYcmf1w58NXfS9HUXC4L1h+4D+83U=;
        b=W87OUSEeqGAb0/c414oCF8Ge0JFCuzMVet4yX8wgeBMBWq93AxMDa0Q5zuCXyy1tmf
         MeYm0JPM1dlG59Z5pcN2cOxvaiPWPypY77q5ZYMbro1ELRIuWGE31ivscTYh15jUM1ii
         13Pu14bzgMUEqm5RUnvxf5ZZTZRqUAC9XcBGCZTvUCwTmuideeWUWl27TEP6sbt5IFla
         RaJ/D2JY03iSS5DUSSFjoOXnXFit+G32ltspzlwbOHaHbtMFfTpSrrd9HqbOsi0Vwz2A
         oiCKREq2lEiOAaxh2YstUjJd3YYINXGzuhz1Y8ZF91PJc6cuukH2msIQRLQLQfyzTcA8
         iw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736038905; x=1736643705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCZ/4dPyKPj3YvPYcmf1w58NXfS9HUXC4L1h+4D+83U=;
        b=swc2q4Bml5DXe1EULpWlOjPHEJMr5dP4lfZPH269hSstZoKvwnzkJbLlivzlVdEnfi
         9w2s2YX+BYWVobU5GwkUi7gBJOlUqzFApqtnJtXW107+FOi9EVN7okRYEP9WvIYygL3e
         LSIfpXuSJQhrlDt5yOzeJzvWcx8BgjlmNbmzwRO3NV+cxS5kcnT5qzsX9Puf+umbVHVY
         46fztv/VGvb53vVHbb/Zj8EMfrEvi3VuktMn6NIZRWaGryOS1Y16iQ8yCxgQUEbFWCv/
         edD/gfmtFCWVPgMw/qSXanUk7MhmSK1LsjgguzXYDKTHCjZPiM3RZPl9AKYHm7FCOu4X
         qswA==
X-Gm-Message-State: AOJu0YwDVaWvCVlBbAw0zwCo0Uor0s0sagBid4or5ikYdwsLJPJiidD4
	PlXUaoTYBDNnC/5YVYWBWzzW0BVYit67nMDhh6/gz/3xBNenghG9
X-Gm-Gg: ASbGncthMfq60+3v++w1PbHNGzFpG+3KfYszL8UAytgtOa1dBzHtJd0IRBTMjBN+iUX
	/3zKtCOu9QesRCNwq6wpFobTNdFBryZyQRXBD1Bz5gQJXwyTsthUyfgJEyM9binHAx9JPs5pMlV
	S9G7oXLK3Z8qRRDINyYzMd6jXOSeSilYtcNaoUeFLbbfum5i4RQwfe8gfR3Bav04keZWc3l//VD
	O5hR3y/HxoN6Ln3FleGKAcad6WlLklVONfKoLZ4CJuGsJkyahZ2
X-Google-Smtp-Source: AGHT+IFxxUqUL/W3SOonGVHY+6IOP84Z4lVijUpXSVTobe+vduWFhdVQIeu5TB5A09UsflfWI9rwLg==
X-Received: by 2002:a05:6a20:2443:b0:1e1:90bd:2190 with SMTP id adf61e73a8af0-1e5e0819124mr85778120637.44.1736038904706;
        Sat, 04 Jan 2025 17:01:44 -0800 (PST)
Received: from gmail.com ([172.56.120.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbab4sm28579028b3a.94.2025.01.04.17.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:01:44 -0800 (PST)
Date: Sat, 4 Jan 2025 17:01:41 -0800
From: David Aguilar <davvid@gmail.com>
To: Bartosz Pracz <bartosz.pracz.92@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] all: standardize headers to reflect Git's purpose as a
 DVCS
Message-ID: <Z3nZ9YXIDTWOjhZV@gmail.com>
References: <20241231001234.1182828-1-bartosz.pracz.92@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241231001234.1182828-1-bartosz.pracz.92@gmail.com>

On Tue, Dec 31, 2024 at 01:12:34AM +0100, Bartosz Pracz wrote:
> Updated headers across multiple files to reflect Git's role as a distributed version control system (DVCS).
> This change replaces outdated or informal descriptions, enhancing professionalism and consistency
> throughout the codebase.

These changes drop Linus's original comments. IMO those comments bring
levity and were a tongue-in-cheek description of the system during its
inception.

"The (blank) from hell," is a phrase coined and popularized by the late
comedian Richard Lewis. I'll leave it to others as to whether this is
frowned upon, but I've personally always understood it as a
light-hearted (and self-deprecating) joke.


> No functional changes were made, and this commit is purely cosmetic.

Besides my personal opinion above, there is one technical issue below.


> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index dec8afe5b1..ac84a03e17 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -376,7 +376,7 @@ $ ./bin-wrappers/git walken
>  
>  You should see all of the subject lines of all the commits in
>  your tree's history, in order, ending with the initial commit, "Initial revision
> -of "git", the information manager from hell". Congratulations! You've written
> +of "git", Distributed version control system". Congratulations! You've written
>  your first revision walk. You can play with printing some additional fields
>  from each commit if you're curious; have a look at the functions available in
>  `commit.h`.

These changes make the paragraph above incorrect.

The object walk will still land on the initial commit, and that commit's
description will continue to say, "The information manager from hell,"
irrespective of your changes. Git's history is immutable.


> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b13561cf73..34f4553da4 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -1,5 +1,5 @@
>  /*
> - * GIT - The information manager from hell
> + * GIT - Distributed version control system

"Distribute version control" sans "system" might be slightly better?

While I'm not sure if this is something worth changing, others
on this list may think otherwise. If no one else responds then the
likely explanation is that it's not something folks want to change.


cheers,
-- 
David
