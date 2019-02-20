Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621441F453
	for <e@80x24.org>; Wed, 20 Feb 2019 22:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfBTWdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 17:33:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42842 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfBTWdC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 17:33:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so14478816wrg.9
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 14:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PKVyYBZP4M4LaOe3A7LurKKlGh2uzWJD/IAihg4W4FI=;
        b=gdvDhmEjIUzyhGaw9ya4olM30hAP2R5XZJd1hJbLxL7l4x+n6Mu1LrrWRJ8jW5gDnc
         wTl4HNtl0Z60Uq9Y1e9I6qGRw5uB7CL47jk0kTkAH72o6jKqs+iGvDvAp1pAj9vzIYK6
         eu7Gp9Thicg/H3pnvedjeEp55Y76QYKoij1RGRLnF80DCGBTOMGjM1atzTqo05A0Exqk
         GatkxH6t9AN1kBYoGJ1D3mZJF/Hn3U5ue+wl/8FNOKaJ/C7CzdVZ5JCPeBlwO8Rvonkl
         TBpfIzDQDTKwt74COcYi0Z/cD6o0Zitl5dzYfXiTNLPNYvTyqB92sCWt69Pls17gfF5D
         hstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PKVyYBZP4M4LaOe3A7LurKKlGh2uzWJD/IAihg4W4FI=;
        b=Sc7X/qyTNnyiUaZQoQbI6xBXYB+PrJHjhii6EaB+BEk3v8eDP4cUGsgxqhB+v/WDb+
         geOJGoLp4efuGCLpBGQQJOkyn+bXApi8LTpqCpUuSkM48KzEvVN+8qVTmNvREhubqGhw
         WbhTtDuotm2W1vsvSYSS3mI5GMtxGlcHMTamyCBrht6GOwOZYMev26Up5d81CG1PXWwi
         1nLCOxz4c4X5ZKiqtagDQhrYwqwYyao4hfFQoJHpDeigRftuMo4+iB8BfwkpEVlNNBy7
         J6tqp+ZiJ+9ydrsQdaVlgBGfusORP5pZdCg86o/RbPNfXqBSz5QJJRVb01bA2PFnLXiS
         RbSA==
X-Gm-Message-State: AHQUAuahYWq1ZXXE1a2zF/8eD6/q7h3jaEZnNb+MXTF3znERZMD0UDXW
        N8kVIGS+iQ5W1LvWyRys7tE=
X-Google-Smtp-Source: AHgI3IZ85Hx7+83ExbqO3OSllBfMdSep6poazsLd+9XMIM37fmkKor7aRjHWk5Nggm692wUYYkk7vw==
X-Received: by 2002:adf:f145:: with SMTP id y5mr27787001wro.240.1550701980600;
        Wed, 20 Feb 2019 14:33:00 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v6sm6305137wml.42.2019.02.20.14.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 14:32:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
References: <20190216114938.18843-1-pclouds@gmail.com>
        <20190216114938.18843-2-pclouds@gmail.com>
        <87wolzo7a1.fsf@evledraar.gmail.com>
        <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
        <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
        <CACsJy8Dq9_uFofs40XwjLkmiBNWXCpic96W1MK_tjLQyaF0+BA@mail.gmail.com>
Date:   Wed, 20 Feb 2019 14:32:59 -0800
In-Reply-To: <CACsJy8Dq9_uFofs40XwjLkmiBNWXCpic96W1MK_tjLQyaF0+BA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 20 Feb 2019 08:35:41 +0700")
Message-ID: <xmqqsgwium3o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>  - surprises sometimes, but in known classes. This is the main use
> case of backup log, where I may accidentally do "git commit
> -amsomething" after carefully preparing the index. Saving overwritten
> files by merge/checkout could be done here as an alternative to
> "garbage" attribute.

The problem with either of these is not the "saving" half, but
"restoring".  For different people, and for different cases even to
the same person, granularity of what is perceived as a single action
is different, so "give me the state of my working tree files before
the last operation" is a request that does not have a good
definition.  After finishing "git rebase" that replays 3 changes,
one of which needs manual conflict resolution, you may realize that
you made an incorrect resolution for one path but not others.  How
would you let the user say "no, I do not want to undo the whole
rebase, I want to go back to the state where I replayed the first
change, saw the conflicts while replaying the second change, and
resolved them in these files, but before touching that last one I
screwed up resolving, so that I can correct"?

Piling many "backups" (or "snapshots") on top of each other is the
easier part; I'd expect that it would be a much harder design
problem to let users make use of them in meaningful ways, and that
is the primary reason why I am skeptical.

