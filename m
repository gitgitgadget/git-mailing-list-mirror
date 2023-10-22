Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3305111E
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="eko8N7a5"
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD0E6
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 23:04:22 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-583f571a213so1391426eaf.3
        for <git@vger.kernel.org>; Sat, 21 Oct 2023 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697954661; x=1698559461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkDrLqzH1tHL6tXwoOc93UYWkX2sKENQxNqrHpxGqNM=;
        b=eko8N7a5wrH51lxJaHFgQKUOMRl/7N725ThxJKQpGgMOQS+1hNRBsX+LgBLCi7T4vR
         uc5M2y3via52HmblU+QZpHe3AeSg4WzW/SqKWoRIb6dAQPxaVoQIgjiZqnXy9YcNjvpt
         0bV1nyHmnCXohhYJcZ6RIJ+5eMq7ZxEviEBQOTMJIJ1LizS+qoXANzNFvrHa0oyZMGLI
         84tT4ZhTE12J1ZledUFrk/nFZDw9QbF2ocTuqRWzRFpTLetL3OtEaddmk3B5YEMp0eIW
         P51dbHMA72Nt32kFTm6yvsw8KJ7Hf8avlV4zFSjIJtyEpdWntVlmnUp/wFzsZ7UldU4Q
         uSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697954661; x=1698559461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkDrLqzH1tHL6tXwoOc93UYWkX2sKENQxNqrHpxGqNM=;
        b=TupzZiZcA8LaCEIfQ4KVE9qbLmjw2KTuRGtHJCa7MELTzbuFgM3/KsDYkQXp71E+/j
         QEbU06wD9+/7eS6xDdkZ7didyUBAn0AADp6RH1jkRrxBKjcWPHfQ5LVQ+Wf2Ke2lATDJ
         2yxBbocHDaPNlqi/p9yNFjTyNDYuJTU+eoeKZImr6GIvr1STSqdOTVAPj8cEJg30rBqo
         Z1YiNJaFzVMaylbkI1Zu14FQ6+ccSnNK3fSAU6BKwgUWgBljMOMsnrZI9KW3L7sWkr6Z
         LLLXWrd3/nxYvj0l1MVrmVbrvf45Y5WDZp2JhYmwP54NzcHVaVWyvA2plnN93NE0UQya
         Dpxg==
X-Gm-Message-State: AOJu0YxmAriUl401ayyJ8H0IXBoBwPrkZl3qhlj3H7yBbzHB0NhVMEvk
	affEKinH4HgVMyvt80fzpYjP/Q==
X-Google-Smtp-Source: AGHT+IF/CNffLH+JPc1jN1/aMgIu/i1CPc5+hYaET3NxqsvBYdEYI3ttTJN6rBW8i0W1l1TjyBqvCA==
X-Received: by 2002:a05:6358:914a:b0:135:b4c:a490 with SMTP id r10-20020a056358914a00b001350b4ca490mr8446891rwr.10.1697954661160;
        Sat, 21 Oct 2023 23:04:21 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-47-162.mycingular.net. [166.170.47.162])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7990a000000b0068bbe3073b6sm3039291pff.181.2023.10.21.23.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 23:04:20 -0700 (PDT)
Date: Sat, 21 Oct 2023 23:04:18 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTS7YsxSE8UA+n4G.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <xmqqwmvgoovg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmvgoovg.fsf@gitster.g>

On Fri, Oct 20, 2023 at 04:28:19PM -0700, Junio C Hamano wrote:
> 
> You are not alone in feeling the impedance mismatch between the
> intended audience the patch(es) try to help (pointy-clicky GUI
> users) 

I'm sure there's overlap with "pointy-clicky GUI users" but my point
isn't to directly cater to them. I find it intersting to think about
how visual (and ok fine even gui) tools can be used as bridge tools
that can be discarded one the important concepts are solidified, and
maybe resurrected in a moment of stupidity or strife.

It's like yes use the crutch if you need it, but then do it the real
way once you get it.

And altho this is a visual helper feature, it keeps the user within the
terminal, close to the Git cli and may help some subset stay there.

> and the codebase the patch(es) modify (perhaps spartan
> command line interface).

Git does have some comforting features doesn't it? For example the
hints, as well as the nice pretty colored --graph option for log. I'm
sure I'm missing some others? Isn't there a file called pretty.c?! :D

> I did wonder why this is not made as a
> part of sugarcoating the command line interface with some GUI that
> shows what could be added, what has been added, and the stuff in its
> "git status" equivalent.

I'm working on a couple of tools (ok fine basically guis) that include
this feature.

The reason to bring it up here is that a common feedback I got on my
existing tool was "add something like this into git", so I was curious
about what was possible to do from the Git cli.

This would obviously be the best way for the feature to reach the widest
possible audience and get the most use. Any standalone tool I create
would get a teensy fraction of the use that a feature in Git itself would
get, so I figured I'd give it a whirl.
