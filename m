Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367919DF66
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354521; cv=none; b=pLO2ApVkah0IPAnqD0Zof70kmeyrQj9MN1wL66SV0yf57gqduieI9ECPPG3ZiwdWTkl9VvCnFw6idRippPrbLDwHzAj1bilpEL4hOCyaMEJWFsiulDzpuHLFpNpIrwcLhodGFw6fEHgXiTd5XYEB09XxtDHjX94QfKHGwt1wo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354521; c=relaxed/simple;
	bh=ey+IDVmJLBz5aUTJNJC6l4yem+hv8QJQMb4/rB62W9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rwd7zN8GDDQlxyl/6Be0iKT3JAkhuSmYLgplsuulo09zmp7kAiIVSd9kUMfTRfdOTROoW7dYkn5wdAJR/0d/dfqnrOy/lg8B+TxWVGac2DYZAnX73jVUIMjTzVZHvIzN9IjCpHVXiromjwHhKuLEC8glPdKa20MO1V9WxBsE5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGpTyHXM; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGpTyHXM"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f1eb278d85so105599eaf.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 15:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733354518; x=1733959318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJKgzA3Dx0r5pDg2PUJjgqyyp267vYvot3LI+rVh/C0=;
        b=TGpTyHXM0P8rTwULYWMMjeN+WblKrki41BY+WID1LWCJ0PxyDq8Zhj4uCVm7MEnJH6
         2EehkGp5DztAZQjcFRURIsq9zOP+xzL0gZQ6h4XiuEI7waopkb+DQhWh6b3ctMjIWX6S
         DUwNuykD6cu9/kOh4gOrGNQEcoBQYm/7Xx9jydnVubYY0zRaUGTBwv5f+EIrAV0/HwBK
         McEompzMCHku30OpljWqvE7rtEaS2TRGnnEvwUq7ka6E9PdBwrs261efuH/AO3xRCrzL
         rGID29MRr/ILOwh404ODw6NnnmVnpLALQC0haY0eaBLKJW7XNqYcVs6bObKRbwkHt8sK
         aW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733354518; x=1733959318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJKgzA3Dx0r5pDg2PUJjgqyyp267vYvot3LI+rVh/C0=;
        b=AwQDEh+FBypOmweykojO13T735qbTjY1lvAvaIJAhcJOikP7dr1sg2zNeg/ssMJ8O9
         O924daKrPItEPPSfEodibyZICnman1qyQQ00lpCMxYHqW1ZquOiV/4Y6wrIXAvHEuKyl
         OGRgKMTPyMfzp5W6709ZlFUrsD047Xgv6XS4MQJ64ILoVsdU7AZtIsnBV7NCl0McMb6k
         LCn/VnZqKjFsvtGqPwbIrcjpdPNfsvNDV4NzIrovfm1BQpzXDaSno0hZueBtljGCrc9C
         ymZAdTimdvs/gHtZIBg7XA6tnmiXgyrkkNjJwObIZic2raohDNKZ+D/H5Bg0y/is2CNt
         RaDQ==
X-Gm-Message-State: AOJu0Yx1RR7ussjNLpt4B9FVhy1Ch1iFLL6v4kyjrfcTDMiegum+9SLH
	2WE4v67egDYOiZ6wYn/Q3EXbaAcalbNTkLK10+PM4R6UPX+x/ecHUl/2Cg==
X-Gm-Gg: ASbGncsglFUCQqTc3Jm+HWjhjUglAvFzjgc5x3G+1ad9IBAqe9p1sDC1BmWDDTCy3J6
	HY5fVhrZhYUAhFbyW94ct3c6+ftTH9FnEs+I5Q/2sqTvhJdxDWMAdx0Z4hq8H5JByHEHanchEqC
	e4AiO4R11/97I21vN/yX0v9U9q2L7eoM+wFC2YPIuNif0zoTdZQcpZ+Kdawc2yBwf6FhAl+O6Ew
	8Qh59ElriNldwnrXSvZEiJ5NdxHUrnzstseM5JKaDY=
X-Google-Smtp-Source: AGHT+IHUuvA6xUXWXqI/m+wXtf8YI0ix+NZ9x9uQoQLmrVlZkSKwArxccoqRSY/RTO2zRLcF8voKNA==
X-Received: by 2002:a05:6820:270d:b0:5e5:d0c8:8030 with SMTP id 006d021491bc7-5f25adf2d84mr5682802eaf.3.1733354518618;
        Wed, 04 Dec 2024 15:21:58 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2792235b7sm70656eaf.13.2024.12.04.15.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 15:21:58 -0800 (PST)
Date: Wed, 4 Dec 2024 17:19:53 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Sainan <sainan@calamity.inc>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Some feedback on 'git clone create'
Message-ID: <pgz37cgfssouykfqxvmjt6pc2lycta6tmyjkovsceqwibww4fw@424usnt3dlh2>
References: <AfLIcOv4X1AxLOaODNS89HA-bMeI7bj0xUGsLD-6xmVAS_a_2xOzy2uX-wXxpNA7kCpKYudELCEKv73roW_-HTd83Fcz3FZ_yJQOswQHW48=@calamity.inc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AfLIcOv4X1AxLOaODNS89HA-bMeI7bj0xUGsLD-6xmVAS_a_2xOzy2uX-wXxpNA7kCpKYudELCEKv73roW_-HTd83Fcz3FZ_yJQOswQHW48=@calamity.inc>

On 24/12/04 05:28AM, Sainan wrote:
> Hi, I hope this email finds you well.
> 
> I think Git bundles/packfiles are an exceptional compression format, but I find there are some rough edges with the tool to create them:
> 
> 1. There is no way to specify that you want a shallow bundle, instead you are only able to a) pack the entire tree at a given head or b) pack new/updated objects in a specified range. Anecdotally, this could store data in ~67% of the size of an equivalent .zip file.

You can create an incremental bundle covering a specified range.
Something like the following example might help you achieve what you are
looking for:

  $ git bundle create inc.bundle main~10..main

> 
> 2. It seems that when specifiying a commit hash, it raises an error:
> $ git bundle create repo.bundle $(git rev-list HEAD | head -n 1)
> > fatal: Refusing to create empty bundle.
> This confuses me slightly because I thought a commit hash should also be a valid head _pointer_. 'git rev-list' also seems to agree with me on this.

A bundle is essentially a pack file with a header indicating the
references contained within the bundle. If no reference is provided, the
bundle is considered empty and git refuses to create it. I think this
makes sense in the context of unbundling as you probably would not want
to add new objects without updating references in the target repository.

From the git-bundle(1) docs for "create", the usage does say it accepts
<git-rev-list-args> which may be a bit misleading because
git-rev-list(1) does consider the commit hash as valid. Maybe that
should be updated to indicate that proper references are expected.

-Justin
