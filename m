Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0492116E5
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524219; cv=none; b=TDb/Km5OM8dVh1KjNbwV+mGgFnXVbV6b5BEuVyQqEEutvNoIElK20raSHb4CgCSsSJQmOiX6pzVX3neCrsikxnC6UXKKsNpZeXnSB147UFw9xhA1v+oOAmeMjOeu+s+Lc/nkgjD4zEV47mGpfnNRgiI9Wq8OMiAQbcpEFd74Fsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524219; c=relaxed/simple;
	bh=am6UaME/muNCQLGdQ9jXyplrY9bdlYUFAL/h+2irA4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuyZJ4doYIgbBCSApzMBqdhdyJsWzM/fMUpjkLdZmNEUr8ljxpZeSmLd4SKu2vB0w6+adMZ/RiJvypT51Ko7svUaeLjjLkD/VvTR/6tkXzupZs3xR9ZhsBNh41IvyyXkxsP6o/Ls0Jb7f6/YDjL87anRH0Esy2uvXX4OTvWcMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ciL603VW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ciL603VW"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3a1cfeb711so3215121276.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736524216; x=1737129016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=am6UaME/muNCQLGdQ9jXyplrY9bdlYUFAL/h+2irA4s=;
        b=ciL603VWJAeCipyvFQBauxZX0B5Xs02g6yKN41bJhUm6iEk7pozhrgRLbxwLbUXxRd
         dV7n8hYfi4FZue7SwEP6wfPAXpXAQG5bFCuAexkEpcKAOXUcYWMD7fQu5Pi+JxUg0qiK
         FaSfTwq9jjInKF2KenrBIJ+zB6YYNy1P1S7tG+Vap+UWjGAD8cD7qK3FMeyvFt7vBAGY
         IimGFna5oluxsXFMNgdRBNwJ6Qg0AHj///yCUr6iZVh37rg2XPE9xEGumuj8eaLTaVTt
         wcR43g4m1DSsQT7E35wJ+eHrKnCf2wqOPbc/+8keIPW9BmiTiVVkFrn2VPTlHl54jFcL
         lgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736524216; x=1737129016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am6UaME/muNCQLGdQ9jXyplrY9bdlYUFAL/h+2irA4s=;
        b=e1rWqSs2/m7NP4OhYa7AvqfUQ/QY7xEI48jqNZpSsbIObeI/wCn32g21ReRyhhUYud
         zjkm7tJjDbSeoj9SKPMJVPPOW1vBS7JCioJSsZXQJETuvF8Bw+3VJISz65H732D24Mee
         xgCZ0kEsaivDnsP7X1Ka3Z2XpgM8eRNjhTgAiEu0OHDnuhzJBfngz+oyEbjjpAIG2Slf
         h/p3su/uVoXvZ1yh4cRDbsIuUQWQMiUUq56PwxWtHyoMmpSnMEAKl7tVWr46gfW5RqFw
         6jSP0t8uurcXNxpSREpbj2ZYleAvw1s8+r3QNXTm7ASVlckZxs0KQW9zyxLbIszgJse7
         /OTQ==
X-Gm-Message-State: AOJu0YyXFxzanO9cDNWjUQKVTurd5wwnMD3UTZ1yDoBlmZ3bAp7/mhQh
	3VT+m9EIH+gQs1BKXSKN6LbQv1ppd6f/49huuDV95sGu6cs4tX2k4vz/SjzwQFnVnPEL0TTkQaN
	rUPE=
X-Gm-Gg: ASbGncvv6KTFdJ4KTu6BzFsArd+WnC6h/WbDZepZDBCPD4O7j5gqxp5bT2U0LesKY5z
	IiiObVje07sd4Qhu3rukSrKUCYXjvx/dkkqYO35fyR3ZaEU2Qt1asfd6g/TqMXI0YT73+wZFCri
	520AXTkD0zoqEwxinpS2q6cl+IxgzGjqEW5qha1lyDrR4oI/Cb77v3sLJ7VkscTA1kLknNsR/ni
	jm53EQRRFwJlyDOjYbiQDpXYpDaU7GxWQo8aeUIx0oMiVwu3DfVcLHk4ktGf/FW9NXEojh1c8FN
	6NIVOirpiMHEaQ3Cp55NopsDWXEm
X-Google-Smtp-Source: AGHT+IHL5JhSelMnJpfD6hU1AjbFHgjSk1ilcdxEJjPv9V+BAZiE+ljVpGl6YnC6kk1q53Ezq9Utcw==
X-Received: by 2002:a05:690c:6b83:b0:6ea:5da9:34cc with SMTP id 00721157ae682-6f5311e631emr86412747b3.7.1736524216440;
        Fri, 10 Jan 2025 07:50:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c43921sm6699707b3.45.2025.01.10.07.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:50:15 -0800 (PST)
Date: Fri, 10 Jan 2025 10:50:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] compat/zlib: allow use of zlib-ng as backend
Message-ID: <Z4FBtuktzcayrb5T@nand.local>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>

On Fri, Jan 10, 2025 at 01:55:27PM +0100, Patrick Steinhardt wrote:
> This patch series refactors how we wire up zlib in our project by
> introducing a new "compat/zlib.h" header function. This header is then
> later extended to patch over the differences between zlib and zlib-ng,
> which is mostly just that zlib-ng has a `zng_` prefix for each of its
> symbols. Like this, we can support both libraries directly, and a new
> Meson build options allows users to pick whichever backend they like.

I'm very excited about the possibility of supporting zlib-ng. You
mention that there are new Meson build options here, but I don't see any
changes to the Makefile.

Can we build Git against zlib-ng out of the box with the Makefile? If
so, that is great, and we should document how to build it with zlib
versus zlib-ng when using the Makefile. If not, I am somewhat
uncomfortable about exposing new build options and the features that
they enable behind the new build system.

I think that we should continue to evolve the two more or less in
lockstep if/until we are ready to deprecate the Makefile.

Thanks,
Taylor
