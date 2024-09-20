Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E809145345
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842084; cv=none; b=SPBxR25jBUioW3ZiIdR4PPRNYazKw9IIiETUbe/bA3h5k/ET0WA4gPPjgFFHiZFA8RVc0XQk22jj6LLuHCrmdUBmNrMHK8oHYwgTQV3vxyETxttFpTY/olfhi+btKTTqBIf2Mrd2koGogfrnBZREADQsBjMWS/U+z450bG4aJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842084; c=relaxed/simple;
	bh=RrKUKnmfB1WRWqhU0RxbCbONmOvJYHTaY2qRysh+Bw0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtvoiKdFnLIBFCqK1E7SaFakGJupeq5CwtYcNf+ktfOuvDq1auLgpHq3qnWl3gPFyQEmkkYWSldG3bRbBT9XtAs2CDwZWcXkCSfTTsttt3Ja/Ag7VDPRjdWq2YG0gze8B4DaqGPJjMk1iBpfMBwOB7AmNHGjvq8qfIB0dH6+SEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tcygRtr7; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tcygRtr7"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cdada0f21so87264139f.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726842082; x=1727446882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyQPYS3uPnd96Ilf2zZjdoEzFnmcGO4wCwvOwcwu81c=;
        b=tcygRtr7HJ6IGmx18Tk4LUrqQqeMuG238NQApvenBaWGJbeY/SKQhv4nGgXe+HlYEH
         3+LIkTqs06cw8DQKS2cvYL15PgFcNsxVQeix18lAVTSjU+NUia3NUUXjgCi7Cpn4hLUp
         xv6ZOTnn34YGQFq8ZWMsBQDc2tAehG+THKsY4cL83HXnjrBIdaJBbvnrZkvu/4pXo4Pv
         EcaJIQsTHByPcfJFtdJWIEh3Q8sWg/8r/h7lLVgSvyRKYFcqSuesjWkZ+5oDttAjmg0m
         K2wCDsHWMPwqbTwO7/hhcNBIqOzHBt1zOI0qG/hxdtmhymxQBqo1hAvG4O88Uw3HZjO+
         5qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842082; x=1727446882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyQPYS3uPnd96Ilf2zZjdoEzFnmcGO4wCwvOwcwu81c=;
        b=c5wqbaV/I6iqUokOOhEf5JcmQrRQYoZU45Mn506F76DJAe4GnJH3miAej419z1dyuE
         LOm5y20LiwD7ltzjoPFUB9ZXHy1zbvezs9PRw1b3Dh6zoxmExc8dpNQYTTp67llPSzmB
         ggLZ1pd0TVBypVRamO598g4FQZMzHOG+8NmuLuqFyjkxoFvCwuTR16plZ3lohUkFQPRa
         qnbqRX/AsPq9bu+/NoocEpH20X2bM7rYrMYictd9L3u7pO7a6y11IhigyBQG16wx41NS
         O7F0APAIPFWfPjadbP3S49oJBsrTK6qOJFW3pUOWSJ7Y1xvv0NL3/0lSv7uUzhpqzV/b
         qyBg==
X-Gm-Message-State: AOJu0YzdBfhzsprJ2o8SRBdM1fE9NFvYO5Zs9Xun9jME059C4JadwkOP
	EGZuvtxxlYw8zs12FyiBqbOEtQ3U4u9TJQuuG1DKL1m889kfJmgypqAc811KkMsj1ts84u3fYlM
	Mr671fw==
X-Google-Smtp-Source: AGHT+IFtcUqT0MaYpcTAmPJIMBQS6M1cHzjDHUR2Lp+mDftZuBFXHTt7AxkRLgF3sX8iH4z1eiiqGA==
X-Received: by 2002:a05:6602:620c:b0:82c:ecf5:a75e with SMTP id ca18e2360f4ac-83209ce9040mr302641939f.3.1726842082069;
        Fri, 20 Sep 2024 07:21:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d4928d5dasm374882639f.14.2024.09.20.07.21.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:21:21 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:21:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 08/11] Modern Build Systems
Message-ID: <Zu2E3vIcTzywWOx3@nand.local>
References: <Zu2DmS30E0kKug2a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zu2DmS30E0kKug2a@nand.local>

Modern Build System
===================

(moderator: Patrick; notetaker: brian)

* Patrick: three different build system; should get rid of at least one
  of them
  * Should delete autoconf because it's not really maintained
  * Think about a proper build system
  * Obvious choice: cmake
* Taylor: What's the problem with Makefiles
* Patrick: Non-standard
  * Meson is nicer than cmake as an alternative
* Jonathan: xz compromise shows autoconf is a risk
* Autoconf isn't a problem for distro
* Taylor: distro builds that can't handle "make" without configure are a
  distro problem
* Jonathan: Modern build system can reflect the structure of how your
  code is set up
  * Declared dependencies
* Brian: Rust will make the decision for us: cargo
  * BSDs use Make (granted, not GNU make) for building
* Patrick: Is anyone else in favour of a proper build system
  * Ninja is way faster than make to build the projects
* Taylor: Feels odd to build with a fancy tool that might have a
  dependency on Git
* Dscho: --help is a autoconf feature and removed features are detected
* Patrick: Isn't that an argument for cmake over autoconf? Dscho: yes
* Kyle: Editor integration is useful
* brian: standard structure is helpful for LSPs
* Emily: libification has shown that makefile is cumbersome
* Jonathan: Should we do a comparison of build systems in terms of what
  we need from them on the list? Similar to
  Documentation/technical/unit-tests.txt
  * Patrick: I can write such a thing.
* Patrick: Are their any features we need to consider?
* Johannes Sixt: Consider supported platforms
* Patrick: Want to verify that cmake is up to the task by testing in CI?
  * Will volunteer to post something to the list
