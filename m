Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F924203
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9CC0
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:18:30 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-49d8fbd307fso1533464e0c.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 16:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698103109; x=1698707909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yLydk83ffJj90QJbFYX6G3JOJ9ULvejNUBl9xSIp4c=;
        b=S/BvI9Uekga18qLv/VWaGGBeTV+V/6hMxeu4s6igkXXA7OZkwXpVubXe4TfgB5fGEa
         5dqWMGOvegqB/i7exixKE0LlsgmFWCtBiYs8n73m5MaPIC2ndrm+7y9Mev+QL+eJ4rKi
         ZsKOzF642ucHmO52XBBKF74y+hyCf5+ECJUll6z83rw70m4UF7YpgTAJuIVTPVLj0wKF
         +gP4clKnqExlTkD00hTlTpWL0KEUcFMj/EvcIn2e8YCi/t+3cNMSSgjJ+dyIj99PeLBI
         bpkUOVg2XkcZZds6Q/qQawM2/8b1xCvaOU9CPmo5eQbidUfNgMjAu0bCW9w2obv9zhVr
         eF0w==
X-Gm-Message-State: AOJu0YzO/kDSoSxHWcs17AFFA4RG6DqJyVwd3RW2MeDX7xlm81Zn5IbW
	zKk3koQSreqKMZbB8uH0D00D58trDNLFGLFTsSo=
X-Google-Smtp-Source: AGHT+IG8TlZt8c9XB+xWcUSN7rLMNDTZC9lw1mcxvEwPoFUnI8rak2g64ISSADC9xi/Mc/dyZ0APZUoroeA3g7wu+l4=
X-Received: by 2002:a05:6122:309e:b0:49d:3e4c:6168 with SMTP id
 cd30-20020a056122309e00b0049d3e4c6168mr10232768vkb.7.1698103109582; Mon, 23
 Oct 2023 16:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
 <pull.1602.v2.git.1698088990478.gitgitgadget@gmail.com> <CAPig+cQuBwzaG7ZssGUY6k8wf8pcGZHAGLnbRy579uTPMKqwKQ@mail.gmail.com>
 <CAH1-q0hNSKgr1-dtZac=z7Bx15gON0Y-1pyBM57zuXaFPaJJKQ@mail.gmail.com>
In-Reply-To: <CAH1-q0hNSKgr1-dtZac=z7Bx15gON0Y-1pyBM57zuXaFPaJJKQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Oct 2023 19:18:18 -0400
Message-ID: <CAPig+cS7-YrWf=cxbq6V8FH1BdtoqAS-EKzxF-ha-A0A6_91ew@mail.gmail.com>
Subject: Re: [PATCH v2] doc/git-bisect: clarify `git bisect run` syntax
To: Javier Mora <cousteaulecommandant@gmail.com>
Cc: cousteau via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 6:53=E2=80=AFPM Javier Mora
<cousteaulecommandant@gmail.com> wrote:
> > the patch subject becomes a bit outdated with this addition.
>
> Right; I wanted to change it to something like "clarify `git bisect
> run` syntax and other minor changes" but wanted to keep the title
> concise.
> I guess I could change it to just "clarify `git bisect` syntax" though
> remove the "run").

Yup.

> > the following two lines are already referencing placeholders
> > <term-new> and <term-old>
>
> That's why I added it; that `(bad|new|<term-new>)` felt a bit awkward
> with no previous explanation of what <term-new> was.
>
> > ...now we have an inconsistency again since this text just uses the
> > generic <term>. However, I haven't convinced myself that we need to
> > care about this inconsistency.
>
> I thought about that, but in THAT case it wasn't necessary because
> <term-new> and <term-old> are never used there (and I wanted to avoid
> making -h too long).  But it's true that it feels inconsistent; I may
> add it just for the sake of consistency.

I don't feel strongly about the inconsistency at this point.

> Overall, maybe I should leave that change to a separate patch, even if
> it's a minor correction.  (This made more sense when I had in mind the
> plan to move everything from description to synopsis so I would need
> to touch all those lines anyway.)  The changes will be compatible
> anyway (they're far away enough to not cause merge conflicts).  What
> do you think?

I can certainly see the "{new,bad}" to "(new|bad") and <term> to
<new-term>/<old-term> changes being separated out, making this a two-
or three-patch series.
