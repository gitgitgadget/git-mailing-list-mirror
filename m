Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C101E1A1F
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380240; cv=none; b=AiSBtFDOU10jvnd+sgWZLGJpopXSBvSNWBV3dY4hTyMHzPg2c7onYLwYk6ojmDjtt1q6oFi6tAWqGAIj3c/MTyPUi0pOQaY/ZdxbOgdWL7j/Ky2ZXtSFlRcNTV/oOgRMCjMcO52yhaqi5u3aLDslkGAV1Y/+tCxix9ES04JO5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380240; c=relaxed/simple;
	bh=/XmuN5YSXRu5dgvYqO0Kt/FPM1ICIcfFRS23jvEDKsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hln5X4LTjj4z8Tg0ofhCllPuDQzEpdIAt0nPmFoEyT36PoG0oOVG6mdfRYPDSyF4qMeSkOz+58DkT1NzamUqsO9N3PBW1d5vugu4TZBaKVyqb9+nvKEY2F6yJ57oZqWFX7TM1mzXpnre38Ho17nCfcFC1fCzquSx87cY20zpe9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYPiyCce; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYPiyCce"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f32f5b0631so2945591eaf.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737380238; x=1737985038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLpmqBTESCNsyVrlZphbKLeFCb+TG4nl7igGQdoj8Mk=;
        b=JYPiyCceB0NIzEoW32e3GUvI7TSU8+Dxr4AHO5tU51r6nAjYmoFhPs512+qa+yp5Nz
         ND2D1PUQJrLE3UOZYkcn1bTVRLPcb2x3U5nvE1RcZfIEVzm2kgfKFHkRx7D5kn3gi2+t
         WIP5QNYHvmLKMfLawrD9yESKFK/VxqpmF6lTFgz/srrx7Sq5C6CGEH1K3HqZJ9InU+CH
         6Xw3WK9kpvlGHhCIZqgkLs3Ameo1ARVEU6COoW+7E6kINRMVLwVCjba4RJxeXIZ9rQ+N
         l0sSniDAxaH2mGUIy0BF5oN/IETazsKoCncomRa/W1o+wHKdtn3zi/20Sdy13aBXRsa/
         u9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737380238; x=1737985038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLpmqBTESCNsyVrlZphbKLeFCb+TG4nl7igGQdoj8Mk=;
        b=crr6m/DxmSbmnaUkHMf27jUsVi9W7dykxjft6WK3igOb6XNFXEK6UaJdAW0i5NTph+
         WgQYe48aZIUEkdCZ/JKsIGFQ2vPQMAOEOg41N0bFVXgaUWJX9h4eoNYcEpxC3qfKoe1l
         AfT0P3f7eeb4X3M/mw6zVxDuvg+r/faNk1qbATU/xrHfSLl4/EYdeeSGcOOZVYQMvs9l
         KAAcwxD948ikYL51P00hutfNS4I8TRE+Yc4YIny9kn33DrKtXRZpGjFUpSB3/q7yEVFz
         OXpGwj0IJ/GAd/sNqxRGQN0G9G+wRV9UOl/LdgazBwF+hu59MXKfg8NeOd2wpa7Ooa38
         qmZg==
X-Forwarded-Encrypted: i=1; AJvYcCWV1fXzEojtQkm1zeidhinbokyLQlQWIZsbpwbsx1knMpW2Lh4uur1hS5Li/TCTkwokzQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhOWe/LhwVFCzh3mUL/XAc/D57oWag1v18rB49zNNQvdCpjQI
	WHl3fZfZv22sE9i4p4ixdCgIU6CVTvBOEq5v//MkDSeTsV8fwQnb
X-Gm-Gg: ASbGnctreC8ZiI6J/x9SFEm9VZs8eX8XU2VgHqrmv8JN6juldIy7ZAxggmC+SLd6uMf
	C5m3HRbfchIrkv5bFHVl7xq8x/EDoU3qsop787HiHykuNqMX3W2/ODbNbH2vIBEBn4pzyIrUk/O
	ueDLP0jhpay4GJXBP22I9fUKTOf8pS5H4LOw1S/SVAaIJUdcN2db67TUVxtSyxwj1niKNMqZ2Fk
	86dEo65W9/Jmg18MeGOJgrhQHhNAPVkc9BmeKyKUKrpg8Sf
X-Google-Smtp-Source: AGHT+IF6li7zs9op2ZBGfRf0vP3C/f1/xWxGZeD59d5AbeEjVLTfHK2vXYUtRiiWEKYToa0TqUQH4g==
X-Received: by 2002:a05:6820:2706:b0:5f6:6547:8a0f with SMTP id 006d021491bc7-5fa3887bbfamr8068455eaf.6.1737380238301;
        Mon, 20 Jan 2025 05:37:18 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-5fa35f05bd3sm2393795eaf.16.2025.01.20.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:37:17 -0800 (PST)
Date: Mon, 20 Jan 2025 21:38:37 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z45R3YvA-ITWI9RS@ArchLinux>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z432QXJb_TfzNBa2@pks.im>

On Mon, Jan 20, 2025 at 08:07:53AM +0100, Patrick Steinhardt wrote:
> On Sun, Jan 19, 2025 at 03:43:29PM +0530, Kaartic Sivaraam wrote:
> > Hello everyone,
> > 
> > It is that time of year. GSoC Org Applications for 2025 are open now[1].
> > They are due before Tuesday, February 11 at 1800 UTC. It's good to see that
> > few contributors have already started working on microprojects this year :-)
> > 
> > I could help as an Org Admin like previous years. I prefer not to
> > volunteer as a mentor this time owing to other commitments, though.
> 
> Thanks for your work, as usual!
> 
> > There are no noticeable changes to the program this year.
> > 
> > The GSoC contributor application period is March 24 - April 8, so
> > (co-)mentors and org admins are already welcome to volunteer. As usual,
> > we also need project ideas to refresh our idea page from last year
> > (https://git.github.io/SoC-2024-Ideas/). Feel free to share your
> > thoughts and discuss. It would be great if we could come up with a good mix
> > of small, medium and large projects.
> > 
> > Do feel free to ask if there's anything that needs to be clarified.
> > 
> > Just like previous year, there will be a GSoC Meetup in Brussels during
> > FOSDEM weekend on Saturday, February 1st in the evening. If you are
> > around, interested and haven't received the link to register directly
> > from Google, let me know so I can send it to you.
> > 
> > [1]: https://opensource.googleblog.com/2025/01/google-summer-of-code-2025-is-here.html
> 
> I'd be happy to mentor this year again. A couple of ideas:
> 
>   - Consolidate ref-related functionality into git-refs(1). This would
>     mean that we add new subcommands "list", "get", "exists", "write"
>     and "optimize" to it so that we have a central place to manage refs
>     overall. This would replace git-update-ref(1), git-for-each-ref(1)
>     git-show-ref(1) as well as git-pack-ref(1), which would of course
>     stay around for the foreseeable future.
> 
>   - Refactor "environment.c" such that more of its global state is
>     instead stored locally, e.g. as part of `struct repository` or
>     `struct repository_settings`.

I think this is a good project which is not too difficult for a student
to finish. By refactoring "environment.c", we could slowly drop the
global variable "the_repository". I'd like to co-mentor with this idea
if possible.

Thanks,
Jialuo
