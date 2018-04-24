Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6341F424
	for <e@80x24.org>; Tue, 24 Apr 2018 01:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbeDXBob (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 21:44:31 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44997 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932665AbeDXBoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 21:44:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id o15-v6so46121280wro.11
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 18:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P3gPv8oXufGfgkJIEs9Bfzml2nrQvLvSVZkfZL5EdTo=;
        b=KohlVNh9PYDAeyjUOe37liR9HmT5MaWlY7RY+xLomwM+ahp/bgI6/c2su4cUUuFrmg
         Eznx3c8f7Oqfjhh7yoFeoTfeMxdng3HF1MtPWj3lwoB4QSMW7gSz06YxmsYpE/QFpNOd
         Lvar4wrBxCrWEN8k3waxeo5+Qbh5E//YbhU4G6hP79rYXFyjRqVaG9Kt9ZPrsVgLNdhJ
         BsLLZJtWsO3IvdKrpLnrJPpw4Jg0Ksbg6LWlR3gGrehEZDZrM/9fLm48Ifqg+tJjknls
         yrP5axIGY/j3sUdXh44BQWk/tA6tMXG+BdYjE/jVNv15Ei0HbooT2694NSREDbVhlZY4
         SO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P3gPv8oXufGfgkJIEs9Bfzml2nrQvLvSVZkfZL5EdTo=;
        b=af1D05oi2VY0GMFblNBaVIICtNoywtxvwXjlTysOhOdqfD1qxG31ZKl6t22RMoQOrR
         YvEK+g+Fks7odf68+ZBAF05DQ2AWxX+JXbc/khwpyzAqz/8KMC2CygROytibVHjqYxPf
         RpS/S27oNDUARWhVGzx0yv4qLoelFwaatOIfnDltAm9lczQcxyFBs28kSaPiwC5KeOlV
         uy1KUuoOd4ykEQZQhuhjeasQxI3jF4cgKbYgcoQv4LO6VDz/akttw4Tv+diQqYjGQUYu
         ZGsT9JsUrjPs21Ky6ewMnM/Anx1mKMcmA6W2t0s9o5oTOgLQWQ5lPQN5i7RB2KMFZGMC
         SXQA==
X-Gm-Message-State: ALQs6tATaZIhx+58B/lsjYivrVA+OgerwMmVMnhoJjRf9dPZnoMd2KnK
        qfVUr9bv5pNXmLAOXNphbG8=
X-Google-Smtp-Source: AIpwx4/jb8hZt44RIlZrU48wYEk4D8mK5yvHy6PdDUoDwMo4w7VWvIyd62eRiAJ3naGWX1Ju7oguOQ==
X-Received: by 10.28.148.129 with SMTP id w123mr11214263wmd.116.1524534269026;
        Mon, 23 Apr 2018 18:44:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q34-v6sm11619656wrb.27.2018.04.23.18.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 18:44:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Dan Jacques <dnj@google.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Some add-on patches on top of dj/runtime-prefix
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
        <cover.1524309209.git.johannes.schindelin@gmx.de>
Date:   Tue, 24 Apr 2018 10:44:27 +0900
In-Reply-To: <cover.1524309209.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Sat, 21 Apr 2018 13:13:48 +0200 (DST)")
Message-ID: <xmqqzi1t74zo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We carried a slightly different version of the git_setup_gettext() patch
> (which took care of releasing the buffer allocated by system_path()),
> and we carry two more patches that touch the same area, so now that
> dj/runtime-prefix hit `next`, it seems a good time to contribute those,
> too.
>
> Changes since v1:
>
> - clarified in v1 why we cannot simply force users to recompile with NO_GETTEXT
>   instead.
>
>
> Johannes Schindelin (2):
>   gettext: avoid initialization if the locale dir is not present
>   git_setup_gettext: plug memory leak
>
> Philip Oakley (1):
>   Avoid multiple PREFIX definitions
>
>  Makefile   |  2 +-
>  exec-cmd.c |  4 ++--
>  gettext.c  | 10 +++++++++-
>  sideband.c | 10 +++++-----
>  4 files changed, 17 insertions(+), 9 deletions(-)
>
>
> base-commit: b46fe60e1d7235603a29499822493bd3791195da

Basing your work on the tip of 'next' is good for discussion, but
not readily usable for final application.  Let me see if I can
untangle the dependents to come up with a reasonable base.

The changes themselves looked reasonable.  Thanks.
