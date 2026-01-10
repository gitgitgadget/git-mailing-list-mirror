Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F221D00A
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768065245; cv=none; b=Y92ssJBedMqUspij8R4pZuTjtZep6YtAiUU9HER30CN1T6KUOLGUgflPeUh60vzZE25jm0WegTwZp/2YDYDiMzwhnT1dzvAA9iF8S0+QjukqjLs11o+NZug8OgdoZWt7LFRIc5HID6QGwb6a3XVh2z3dRUd0kAY69pROTx2heB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768065245; c=relaxed/simple;
	bh=wHHcxIRmO+Uo0i4IJ/g0v4y9EwEHDTuGfk6RzYS8RNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fkqt5GcZIOcH0Z1fgXUdJscSUJFkf1DQNF1ubUUHPDd5RSmFdpMwlIF5xvKFH4vi63kOVzANwBalBg6dnnTRu3mFSkNh/g8FNqffXPbSi7bnQ3gQL6O1Xl86n+7JCsYe1eoUy1oZRySMJlZ9jU/5VEstpFjBFTiegEEHY+iWwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+2blE42; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+2blE42"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775895d69cso25766785e9.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 09:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768065242; x=1768670042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o97wmd0O1Oh1Ca6K8NpLaiaPM4itZR9cCwqAz0ji7g8=;
        b=e+2blE425Y8DmzKZiRsmS86/Km6cozaQGfU3ZTW1+fNz27mxzBIdPhqGknvdd75xkd
         uHazqYy5tD0KVvND+mw/jvxxMtU1Jgc8yL5uB00WG0rI+Uo4KKADe0QDsi0aPM23GE3M
         CFFvY3QsQxD1rQk/MpXOCCPFPilCNrnU7h0xZh/tQoaMkLXNWdan2rXOYKDis6QwHwjK
         4QOGVXCujZfVnyAIbPD5tW+ZLAg0q5dExUzSKktBHu/2jxGkfKyuGOKqSeMnIAnxoXA/
         Qr7PwasRja07PsR3/zNWtRUvReIluJdIQHmHBCKGkhNKkWjpbcFDEpAu+gGHR7PlpOgE
         LCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768065242; x=1768670042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o97wmd0O1Oh1Ca6K8NpLaiaPM4itZR9cCwqAz0ji7g8=;
        b=PQN1DZXRJBZYfaVVCJvPUI7GGMSbPDk7S5kjE8YTNYuNr9hecYTBfZdxkWnpFgTay+
         NRTnD1Sn8cDyheHY2VvnhJvxBlLC578rVJ3s09KgZsrxv9+akZlzkBJ/2MNh9YiK+RGx
         ht2QzfGlkHmM+yG3vQ2q7F0nBl43sYBMScYbamWOlGpuwzQO8E/JfXsDadVdLQ77AprK
         rKbz72yJ8PvOOWQD/8nD8e85DYKB59HDTgUHfYKiVHYNYlTuh0cNHUBuTI5kgCxBkK4a
         MYfsWtHOf6F9KRj7mmDgfmLjszFNmqLfwvCqn/q2jvgfSdL+q9uF3VYwokozRp94pUCQ
         Pl6g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7ArHqObayBIZYlGwxbfV2V0LH+x/fkdA4Ub2YCE3TKwFnpUEJxdkRPoUNbnEpt7JtYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitUN3UiWt1FAyBe2nzkXWuJfRXPSg7jPvYnV8MjYQZClP2fcn
	9ZPbO4HhJ5dsf70MJXYJJgYv7d/7Eo1gHztUhseE5/PTZFgOiLNXcjAV
X-Gm-Gg: AY/fxX7nj1w/Pt3FSy6oM0/t99w9smLxHyRqYhIsZj0g6Kn/Z3gXV9yc04sd8mvxlVG
	xBXn4j2dh98LukO9eSxIPxWdR4ZVGToWorpBJU93xKFqjS0iw9pLu+QF4Ww0Fazn8OvGIItxHic
	94xKSWrDFSbbJ2Xy5kQCiLAeCbzemYZEDJKjDkv9TKy9SWwASWRV2ygw4zdtfDH1F5m1bBoQ7F1
	jE0aT+yeLOLMgDbvFB1XAPsr5ANVZSd/eP/cYE/UKdDEFiRUboKI9kzamb+j7cb5ZErQ4kfmPXj
	MF6Rc7QvhBKjJEusrxfkdhBS0YEJhoNUEhbKHyn8ikXD8k4hqoq6DtfJGVo9kfyeD2QCXU+Gf92
	V/b93A8Gruikvfa8BQwjDFpDJMPGQYVnooNyv+H6j/4JLrpsB245YgdlkVPYtD3o3SMCL1QDBjq
	d57x3qbtLpgljEh4PFi22FCu81Ym9n4/NE+sQO+h/z
X-Google-Smtp-Source: AGHT+IGiMUAPUkK0/hkhkTldZEatRUUmN3I4mvXXRUG9By1WHiwOIiTOhHs3/RxH+3OhlbEvde7heg==
X-Received: by 2002:a05:600c:630d:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-47d84b1fea3mr169214085e9.9.1768065242260;
        Sat, 10 Jan 2026 09:14:02 -0800 (PST)
Received: from localhost (78-131-17-190.pool.digikabel.hu. [78.131.17.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm263360635e9.13.2026.01.10.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 09:14:01 -0800 (PST)
Date: Sat, 10 Jan 2026 18:14:00 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v9 0/7] Introduce git-history(1) command for easy history
 editing
Message-ID: <aWKI2BxszQuo1mRn@szeder.dev>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <CABPp-BEVZbN08zF2P0wNWuOZozc+tbWodfOjtiAkX+XhMiyC6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEVZbN08zF2P0wNWuOZozc+tbWodfOjtiAkX+XhMiyC6w@mail.gmail.com>

On Fri, Jan 09, 2026 at 05:26:48PM -0800, Elijah Newren wrote:
> On Fri, Jan 9, 2026 at 12:35 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Changes in v9:
> >   - Rename `struct replay_ref_updates` to `struct replay_result` to make
> >     its semantics less focussed on ref updates, only.
> >   - Clarify and fix return codes of git-replay(1) so that we return 1 on
> >     conflict, 128 on an error and 0 on success.
> >   - The usual small improvements to commit messages.
> >   - Link to v8: https://lore.kernel.org/r/20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im
> 
> I read through this series in detail; it's forming into shape nicely.
> I think there's still a number of small implementation things to fix
> up (see my comments on the individual patches), but the design looks
> good to me now.  I suspect we'll be ready to merge before long.

I don't think this should be merged until we have clear and feasible
plans for future subcommands that will cause conflicts, to avoid
painting ourselves into a corner, like when we couldn't change the not
well thought out details of 'git switch/restore' anymore.

