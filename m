Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61E63A
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="KU9Zan28"
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F299DAF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:12:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5ac88d2cfaaso2966208a12.2
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698095534; x=1698700334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R6hRnSos8PtiO5oszqY/B3St7e9IBZRFqVSf6JwaYe0=;
        b=KU9Zan28apgS3zUPhcnru5ic+b+MPG3XqBktKCCwuD6Gp3XQBw3WP1vnnzGKoLmjjb
         bbM3Y65JR9/kEw09PxKozYbEVNHWCB17VdScQmOqjEzDN/nEn7jxJKil/6OaYwYg+y3B
         Zc1tl7pZ9A0HIuPUEyV360TtI0maunM5c8uN3+gNuxif9Syhh4F9qzlqB6faG7tJHLVf
         ky/wLo8YpNgCs/vMieEFDxFbIGpC8o5zGxba+cCSvqmBkmFKhJpWvL/qL2+6w8U+WDhv
         FBp9DN/4XLMMOllzsZVTVX/iBiSv8IPbvKgGgGFttnxH+V+pAY/70XoZR+Ay+lslfP+u
         t3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095534; x=1698700334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6hRnSos8PtiO5oszqY/B3St7e9IBZRFqVSf6JwaYe0=;
        b=xHZ7PX56H+fSp0BMJaqfEL76uesjkflkSsjW1j2dIfrktPy97tFsPQP8AX6zkVVtYd
         czYgPEfmicKqhgFzrnQjMp0nb/NwqCqe5migagk2Xvv+hyoedo/5aRAjjBlsw7kofczx
         +R7NgzBMqba1WQ31N2O4MFf5TGC4nYYpR6AekGCIXdFQoxsVmL5Ptp6aWFsSgeZkFeBX
         77zsrX2NP7SC7UJ3q2tF7eHi8roOO2Ef6sFwMY22N/Rv1/FHrCd/hyO0OwC7EAWR8a7S
         xERjN4OG58/byxCT7jWSNC8JZdngFCwOyR9WRJbeeTfmbTqciGz2MvmXofX39rpuCDKA
         aNlQ==
X-Gm-Message-State: AOJu0YzskVsMjYkOKE5sq+l5wkQjPBpWqR/uykWvYfrTuP39bD5IXL4U
	slWjJm+SKowUbcLby21xAejw2pn4a1aS972pp1Y=
X-Google-Smtp-Source: AGHT+IG0RYxzFTiZ32RGsoRKGuFhiW715im9xFU6LnImIHOS8SAN5ZhSdJAstStRO1ZCA422QZCdUg==
X-Received: by 2002:a17:90a:e512:b0:27d:880d:8645 with SMTP id t18-20020a17090ae51200b0027d880d8645mr9288599pjy.49.1698095534398;
        Mon, 23 Oct 2023 14:12:14 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-44-139.mycingular.net. [166.170.44.139])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a1a5d00b002777001ee76sm8776178pjl.18.2023.10.23.14.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:12:13 -0700 (PDT)
Date: Mon, 23 Oct 2023 14:12:11 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTbhqzRLFS6/99lb.jacob@initialcommit.io>
References: <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
 <xmqqfs21noxx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfs21noxx.fsf@gitster.g>

On Mon, Oct 23, 2023 at 12:01:14PM -0700, Junio C Hamano wrote:
> Ah, OK, now I see where your "--table" is coming from ;-).
> "git-sim" was exactly what I thought about when I saw it, and I did
> not know that "--table" came from the same set of brain cells.

Haha the set is not quite the same I'm sure I've lost many over the
course of this year. But the survivors are doing their best.

> One thing that nobody seems to have raised that disturbs me is that
> even though there may be educational value in having such a
> "feature", having to carry the extra code to implement in Git incurs
> extra cost.  I was reasonably happy when I saw that "git-sim" was
> done as a totally separate entity exactly for this reason.

Erm, not to get too sappy here but I'd love to maintain anything related
to this that gets implemented, in whatever form that turns out to be.

I already spend way too much of my free time working on Git-related
things so making this contribution to Git itself would mean a lot to me.

Starting Git-Sim as a separate entity made sense to me because:

  * I had no idea whether anyone wanted something like this, so it
    would have made for a pretty weak argument to the community. (It
    turned out way more users were interested than I thought).

  * It's written in Python and relies on a dependency library called
    Manim, so I thought it wouldn't make any sense to try and wedge
    that into the Git codebase.

  * The output is presentation quality images / video animations, which
    is unlike anything I've seen outputted by any Git command. (I didn't
    explore what it would take to do something similar in C).

The main downsides to Git-Sim as a separate tool are:

  * The main downside is lack of reach. Not being Git-native means only
    a tiny fraction of Git users will ever know it exists.

  * There is technically no guarantee that a simulated output actually
    corresponds to what the command will do, as highlighted by this
    comment on Hacker News: "Next HN post - "I destroyed my repo - but
    it WORKED in Git-Sim!"

  * As Git changes over time, Git-Sim is destined to be a step behind.

  * Certain commands (like the networked commands fetch/push/pull/etc)
    are not easy to simulate without doing horrible things like cloning
    a new copy of the repo behind the scenes, running the desired
    operation on it, and checking the result. I assume things like this
    would be a lot easier to do within Git.
