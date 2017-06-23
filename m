Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC6A2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 04:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbdFWERZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 00:17:25 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36016 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdFWERY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 00:17:24 -0400
Received: by mail-pf0-f169.google.com with SMTP id q86so18269534pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 21:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a870aKq8nxI36VSkQw2VGigT9r+EhUkTVUdZEdhGOOY=;
        b=u0YHgbShsC5AjYQdhhP6Pjc9j+qdtNXMXi6oznbI5o+kNguv/ft6NoNnMd8HiezZZ0
         YTE19HRM69ZWdwER42wCQj2PygJf1urEpRhsCwE+qjf0lXUWDGZQxkxzGQW2gziFDuxu
         jgUG8xHgtnnKndOJrzC9ZZmV4Ps3skPrTacuH9EFQ2ZDqVOksEqRO2KlKrLWVNDozXxq
         Lgw9GwQuqvHp60g6+gf/iguOVY8YGfKlTvVsjpvNd0PMddS+JUyieIJ/D0IRM5NNN03g
         wKwxpvh6TdRTZ+Dy7HH5WNXQ7d6nkUVqEYB0m5a1X0YmR5hWCR6NMn85o9CJSrNyoIdy
         fl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a870aKq8nxI36VSkQw2VGigT9r+EhUkTVUdZEdhGOOY=;
        b=TG1dgbEBTHclCCKcFS3OFUqJxJpKXCU41+2sgHoQsPhxGR8Gqj1eG1IgJXSLP6yDEI
         DGzadw8Ni4bRuqgKbqx5d7VE+B6Luvbm/j9yg47Y984tEYi0d7ErKT5o7zYMREEOgoyO
         z48VwhMbk6wQOeDI3h/YDt9YaKVRTOYIP75idigt8y/vTNNVBDiWmoIIqVrsR5jviN3G
         f+z8n4FAIBOk7vmHoyDYcLw9pE0nuiZBztfEVzXTti3EbonxDtRdsbegdSfEMBXqyqL/
         09f+cVK5upRDxLIEBPk1hJiY3rcP8D/0Lrmbpxcp7uNZRik8kZqaUQNNQu4drVP5oCfs
         PypA==
X-Gm-Message-State: AKS2vOxLYL1abHZkYpwlE23CCOLAfAKIJpL4ngMMYP790h/qevOynv/4
        ShfvH/847o0RzQ==
X-Received: by 10.99.176.1 with SMTP id h1mr6050945pgf.152.1498191443475;
        Thu, 22 Jun 2017 21:17:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id d2sm3571636pfb.49.2017.06.22.21.17.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 21:17:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/4] Add regression tests for recent rebase -i fixes
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170619175605.27864-1-phillip.wood@talktalk.net>
Date:   Thu, 22 Jun 2017 21:17:22 -0700
In-Reply-To: <20170619175605.27864-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 19 Jun 2017 18:56:01 +0100")
Message-ID: <xmqqa84zgwx9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> I've updated the second two tests to be portable using q_to_cr() as
> Johannes suggested and added his patch to fix the autostash messages
> going to stdout rather than stderr. The reflog message test is
> unchanged. Thanks to Johannes for his help and to Junio for picking up
> the bashism in the last iteration.
>
> Johannes Schindelin (1):
>   sequencer: print autostash messages to stderr
>
> Phillip Wood (3):
>   rebase -i: Add test for reflog message
>   rebase: Add regression tests for console output
>   rebase: Add more regression tests for console output
>
>  git-rebase.sh                 |   4 +-
>  sequencer.c                   |  11 ++--
>  t/t3404-rebase-interactive.sh |   7 +++
>  t/t3420-rebase-autostash.sh   | 136 ++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 147 insertions(+), 11 deletions(-)

I've merged this to 'next' but I probably shouldn't have before
making sure that Travis tests passes 'pu' while this was still in
there.  

At least t3420 seems to fail under GETTEXT_POISON build.

  https://travis-ci.org/git/git/jobs/245990993

