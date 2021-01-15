Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE99AC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 06:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C343823A23
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 06:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAOGGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 01:06:25 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:42169 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAOGGY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 01:06:24 -0500
Received: by mail-ed1-f47.google.com with SMTP id g24so8263997edw.9
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 22:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkNb4BCpNUlvWAc6Cbez681ny72njGVCyvGlw770E6Q=;
        b=KqzbNmz/bIV/IcafBQNY1hR2ShDll2V0CyN+q7+5BwVR3ta4l2NJxNPyUhAhp6melW
         oIzWaKmSY4ybzcdvmWxnwKMNYAFPrvZ9oRby0Wh83ifod9EV+1F/05tsmtPnb6BdLohz
         qZqy5/UJehEJE8AtcFBjrltjwPTiBoT7eGg/6yKsQTUW7J1QbvkLj2/XQH2DZgbBUPBf
         bBkg7aQniPxUowVy2r9gYLzuBQIJ7/yz5IdxkD8US3AqrT4aRYn0GCO1LGSymrZYNIhW
         sojNVA5DU8zldf6DLLBxniYKP+QNhAfQeXhw+xYF4l6PDyX+YSbp1Y4bvchQLEHc8pGp
         /SgQ==
X-Gm-Message-State: AOAM531DLoWwq8su1hVyUVIjRTIKNfPR5pWi9qNiRMKP85StdGMEmHU9
        UC8TXNbJ4fxrUFg5WW1cSM1aOgBEwG/GQKxGcfk=
X-Google-Smtp-Source: ABdhPJwxjItvscYeAxbqe/tg7Jj5bRfWuFN0FNKYdbe5GLqRLmiYzo+cR6wiBZS06lKl5jeAULQceM4qxi9KKcPDYyM=
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr4635555edz.89.1610690742335;
 Thu, 14 Jan 2021 22:05:42 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com> <xmqqa6tavjgm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6tavjgm.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Jan 2021 01:05:31 -0500
Message-ID: <CAPig+cTSbwURNUEoUk8UCtVM69NuWg545zavJkyCYw8T6aG1SQ@mail.gmail.com>
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 12:50 AM Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > It seems that homebrew suddenly started giving us trouble, like this:
> > https://github.com/git/git/runs/1705953982?check_suite_focus=true#step:3:70
> >
> After seeing 'seen' with this patch at its tip pass the tests [*1*],
> I prepared a merge of this change into the tip of 'next' and
> tentatively updated 'seen' with it.
>
> The test is still running [*2*], but the problematic part in the
> macOS build has already passed, so I am planning to fast-track this
> change down to 'next', 'master' and eventually down to 'maint' to
> keep the CI going to help other platforms catch more interesting
> problems.
>
> Help from those who are more familiar with macOS and homebrew is
> still appreciated, though.

I looked over your Homebrew-related changes, and they seem fine.

The `brew install homebrew/cask/perforce` command could be shortened
to `brew install perforce`, at least at the present, but being
explicit with the long identifier is probably better anyhow.
