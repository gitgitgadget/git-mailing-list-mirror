Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963BC20960
	for <e@80x24.org>; Wed, 12 Apr 2017 11:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbdDLLOW (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 07:14:22 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33951 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbdDLLOU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 07:14:20 -0400
Received: by mail-oi0-f51.google.com with SMTP id g204so27437291oib.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 04:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XkVHZkljUWKrjbhqF0Lj778tz5I2Od2x0YWevygIHuk=;
        b=YaGv5VGlnEkHJJ0ZRki8wYETiZOrzM+/GqscbVSqYyp/3/d76Y2DqoMfkcJRnefdFO
         2GFLZRxg6VuoBpdtHrvHdfgjsMyqNAXS6r+Co1+Vh/+NwrkLMSSzVstlit1DD6886ASL
         h9sI4U/JaT6uTf+B01Bjhi3OI7vytVAaHp7DAP7sDdyD42v2CqkpT9zj9jwAeRYmE1ER
         PrR5wqc9nU09IPAKXCOttZ5HjScgBFxLIpsjYuerDW+9DZi6CH4UPRP44i2P2JMxorOL
         bzg1zhu8EZgdvGbl30JzdbwZTe1GMXgxaXjtrZddDRbOtwkXdEG86Gst3ZN7FHutwrwq
         4O2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XkVHZkljUWKrjbhqF0Lj778tz5I2Od2x0YWevygIHuk=;
        b=ZHOny8R1X1HbS3QPzjpe1lL54dEQhYfXkX5iO3EXstsox9WSJndYcJekARk/JP17zl
         JXPaIJrb5bcz12uRbxBRCjTeeF5grmQqVtHHX/OOmy/USX9mZa75UGFkAAeFWpgJ+FeP
         JIP+Auuu7h/cKKvVczsH8Csa490AsZp412/BqIf0fD0jgYHPaUjdydJkJz7VjbDeBoQL
         SULusJf0omuqLVSW5RvmHHX+eTlnHhB79tSWHP7eNTMaZgB+BE0gpbK7b58W5d/qUz9k
         FxIhe60GMHwRilidVSjX4BPKuU6sMF0tBzUwGyxDdWqwft+XoJ+3ZxY6eWMnlBkUH+5D
         JePQ==
X-Gm-Message-State: AFeK/H0FQi/9pFYRoNyWeRKn8K2eQaxbh6UXrWirfb+q/cIpyj8lQbsel1xJPq3WoaYeqdfuW0CfGqt/H39Riw==
X-Received: by 10.157.6.78 with SMTP id 72mr18226107otn.37.1491995659567; Wed,
 12 Apr 2017 04:14:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 12 Apr 2017 04:13:49 -0700 (PDT)
In-Reply-To: <xmqqy3v6ow54.fsf@gitster.mtv.corp.google.com>
References: <20170409022128.21337-1-danny@dannysauer.com> <alpine.DEB.2.20.1704091238560.4268@virtualbox>
 <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com> <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
 <20170410171352.s7r7tzheadxjlulw@sigill.intra.peff.net> <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
 <xmqqy3v6ow54.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Apr 2017 18:13:49 +0700
Message-ID: <CACsJy8DPFzgxqvPzpMbmoM4sMP7oSZ=eO6DJa+dv4sY=QKHjoA@mail.gmail.com>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Danny Sauer <danny@dannysauer.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> I think this is much more than just .mailmap, though. For instance, I
>>> have noticed a similar problem with .gitattributes:
>>
>> Urgh. assuming that we should not read .gitattributes if there's no
>> worktree to read from (similar to the "defaults to .git" situation),
>> how about
>>
>>  - if mailmap stuff is requested, setup worktree, or die trying
>>  - if worktree is detected, but setup code does not jump to it, do it
>>  - if no worktree is detected, tell git-log to stop reading .gitattributes
>
> My gut reaction is that we are doing something wrong once we start
> saying "if mailmap stuff is requested".  This is not about .mailmap
> but is about how sanely the paths relative to the root of the
> working tree (which includes a path in the index, or comparing
> $commit:$path with $path in the working tree) can be named by any
> subcommand of Git.

I probably should phrased that as "if any worktree stuff is
requested". I was under an impression that you need to pass a command
line option to use mailmap, but I dind't check the code

> Can't we model this after how setup_git_directory_gently() gives the
> subcommands a choice?  While the majority of subcommands do not call
> the _gently() variant and die when we are not in a repository, the
> rest do use it and continue after learning that they are outside a
> repository.

It may work, but we need to be careful because paths as command line
arguments will not be relative to cwd anymore. If some code assumes
cwd unchanged, they're in trouble. I guess they're in trouble either
way because of the "sometimes chdir, sometimes not" current behavior.

> Perhaps we want a new bit GOTO_WORK_TREE_ROOT that is orthogonal to
> NEED_WORK_TREE to tell the codepath that calls cmd_foo() to always
> move to the root of the working tree (if there is one), regaredless
> of the behaviour f3bb8b4b84 documents.  I have a strong suspicion
> that we didn't _care_ about a silly use case where GIT_WORK_TREE is
> specified and the command is started from somewhere completely
> unrelated to that location, and the users with such a silly use case
> didn't care either what Git does to the files in the working tree,
> i.e. what you quoted in your previous message
>
>     "11. When user's cwd is outside worktree, cwd remains unchanged,
>         prefix is NULL."
>
>     This behavior probably started long before my topic though, mine was
>     more of documentation, making worktree detection more consistent. It's
>
> was not describing the design, but just describing whatever random
> thing the code happened to be doing.

I never said otherwise :) The only thing I was worried was how long it
had behaved that way, long enough that scripts started to depend on
it? If we can get rid of special cases in setup code, I will be the
first one to be happier.
-- 
Duy
