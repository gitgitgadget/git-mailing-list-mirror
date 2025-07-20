Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD38F40
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752973347; cv=none; b=PtvJYREqFT4p7yADoCK0IfYwxhVOE1GE2+MauTbN+CYO/AJPXkXx8XaqyUeA13WsfsvgZLbrxLH4Upkq1gRB+KMN5fbM8p3f/7J8SLCV0GukrlIH8bt2JyJznM6ircma902677wkywmY8gdTeRAksBtOs6m+7JZUldnbMcX7eAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752973347; c=relaxed/simple;
	bh=iXksoAu30nxsHWH55IGA2PGYGap8/t7hVaQZNMeMhS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8g/JSwJqQd6qwiHvwRrYpFgUzPUJ4Z2hbdEGgp/YMeQdrg9gUdhBj6kiwJkVtdGHe8n7vu/HIC8UmERwsMewjClkt02tbjmYrWuQHrU2gt4SjcwM1uKwnG6kB0qvZpQhyS1Q7JgJPqks9cDubE0KLQ6rewpSPPhxN9lPXrluBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le9hpFE0; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le9hpFE0"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7170344c100so27527637b3.0
        for <git@vger.kernel.org>; Sat, 19 Jul 2025 18:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752973344; x=1753578144; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GcTrDuxWlyoEImCdIZu8GPO2rISl3jsDppqCBOFkKQo=;
        b=Le9hpFE0GCFuGSPXo/fVhVbwUeSR50bZQTqpzJcUJej5TkBQbLfMH8tr7RbUwVDg//
         JaDk2YiEI0IsLjYAlAeb6OwzFVDAg1cC2gfNujkzqbej6tfsCFZqbwKDgIDSM/1mA/4r
         eRWWkEySW65czjBLsKl9JZoWgxkdS+I6NUJq7HtkRr+F+5HxUBN8JNtxktb3DXcGdO1S
         9BEExbo7cNmLrY+FDc5HIpqo8mHDRUFCWKKzjVZCTozBt06AMERYETOWQ3jBvLae/6G9
         XhHnLHhw4IiAJMknZ1hZ3IucmTCJ0tSC75sVaGZEX2S0FzcT3GEsLSJqxdWZ4KcF8vca
         hRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752973344; x=1753578144;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcTrDuxWlyoEImCdIZu8GPO2rISl3jsDppqCBOFkKQo=;
        b=YmDTtSF5WDnYCGIPD+DX+axuAVmUHIj8lSsy/vrh0FhVU+c9nlbHtvfBvamUKdlsOK
         DvBJEI4QkVTu0CvG96cRPlA5aJYDDO8h/RjFBXzDmZ3sk0WeBoZ66b4Tvk8rtZyoK7dg
         zK1Lwg9LX+zyJUkUD5XkiRO42pbphoq2CMtGZwfnS7uif9lN/K8W+LHYFRO8AEwvkQtB
         l43tnkoSSSe/FpueiNoxJRIHDsqfIVD43OL7m2UURkhtUdg/xoSTIfT8jAaoptKG+BT8
         jMh3ULjileGlJ70B4IvjMZIpjv47xMOhxiUjdNrzpot7AHtz6KqkYspDl8SGlPYMgkjJ
         oU5g==
X-Gm-Message-State: AOJu0YyTd9IukVsF5NWgCP3fjgSMZGczp8ivgGkmRQFZH5Zo7NafkRdI
	jhHpmuqIoJ2p94Lo8fpY3m5X4nKGM/X32hFdeFIRAtiZ1HDxUwTLYasIFwfsr1Id
X-Gm-Gg: ASbGncszYh9RItw2srgg8XZXWMS4T367TivzgrtQZXq0LB+vMfe12PJJpUlwsEv03cW
	6hSnZsiXcM40IeQE0IQpey18ubIA7C7FScun7qtZps69h2EThsl8hLwrv0w6yLbVI5kpcZsqIK4
	yl7V+OEc/44Ynuuv15W0VVX7yT1gvOfmzR+9AzjOJXhWenWQSSzFUTdrcWRPU8Awhx10llhRgDf
	GvN9jkeMIDgHyhtzFK4IfLyetWgBCgfM6723QNpgN84p6HwKWt47nwsjmzy8hzf4e4Qz5x7yx5f
	GlkTduGtKgu717snDzc7qww/1rCMd9FWlT3b7NoesEzEWa40K0yaB2+4Qo2dm1KVHdKITWVjg3z
	PUieCnZZtuNk2vA==
X-Google-Smtp-Source: AGHT+IFZpBoxqQ3fHxtepQGagFDNHyXjK3b7VHGeSPCw+qIcm2h3hEHfSEw/6N/Tj0TMzweuVotcPQ==
X-Received: by 2002:a05:690c:350d:b0:70e:7663:8bb4 with SMTP id 00721157ae682-7183751491dmr196942887b3.25.1752973344474;
        Sat, 19 Jul 2025 18:02:24 -0700 (PDT)
Received: from localhost ([2600:1702:5e40:2a30::15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71953306571sm11340307b3.79.2025.07.19.18.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 18:02:24 -0700 (PDT)
From: Eric Frederickson <ericfrederickson68@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: Re: A Question from a Hopeful Future Contributor
In-Reply-To: <77CAB8BB-ECA5-46FD-A72D-CD59D96B584C@gmail.com>
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
 <77CAB8BB-ECA5-46FD-A72D-CD59D96B584C@gmail.com>
Date: Sat, 19 Jul 2025 21:02:23 -0400
Message-ID: <875xfnptcw.fsf@arch.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> Hello everyone,
>> 
>> I hope that this message finds you well! I'm a software developer and passionate
>> git user, and I'd like to try my hand at contributing to the project.
>
> Hi!
>
> The suggestions from Ayush are really helpful.

Agreed! [1]

> In the last few months I helped some people (a friend and some students from
> my university) to join the Git community and to send their first patches.
>
> I would start with the microproject. Some of them are really easy, but you'll
> get familiar with the contribution process (i.e. sending patches, code
> conventions, commit conventions, etc).

Will do. And I think I've got one in mind :).

> After that, follow the tutorials for creating a new command (MyFirstContribution,
> MyFirstObjectWalk). Perhaps you'll find something outdated in them and that's 
> another good opportunity to send another patch!

Noted!

> Another good reference is "First steps contributing to Git" [1]. It covers
> everything that you need to know and to do to get started.
>
> If you aren't familiar with the core concepts of Git (objects, index, references,
> etc), read the chapter "Git Internals" from Pro Git [2].

Both of the resources you linked here are much appreciated.

> I hope it helps you!

Very much so!

> [1] https://matheustavares.dev/posts/first-steps-contributing-to-git
> [2] https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain

Thanks again, and best wishes,
--
Eric Frederickson
ericfrederickson68@gmail.com
https://emfred.com

[1] (I sent him a reply giving my thanks (but forgot to Cc the mailing list...))
