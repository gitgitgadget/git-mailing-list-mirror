Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3D61F403
	for <e@80x24.org>; Tue, 19 Jun 2018 15:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966534AbeFSP5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 11:57:01 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:37427 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966257AbeFSP5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 11:57:00 -0400
Received: by mail-wr0-f179.google.com with SMTP id d8-v6so196174wro.4
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QbKD4M2TYdPb5GbxLB9pLiyhfR7RnYHiu8h6W8u46y8=;
        b=pAL6dj4+yMSQf/1zO2+y97up7mCE0N05Pu9ky/UH9sKPfvdB4OxzhH1FKfu6TcFGfW
         4zMnB4TeX1ZnydDGSuM69+TMg/+QkiSQ9CVZUbkCbEe5El2SwgF6D7YXPhuATL5gguBk
         eUM0M4KDzs78HNIStoblgA2QZOg5tC9ZG6gzgn2AYetYGFXEeYRz97rxCqArm1X0o/3M
         UV+74s8SAEVFqRySJl5AZ+BNMMhXkskoImLpvJgdPmK9P4lgBLoJv/o1SajtdnVoNhDd
         rIqbr9l20d4ARah1Bg00vjUJP1OhLMHLJ067CSDxjyQdMzcxqDfOftVKjFkWHfyiSrni
         LzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QbKD4M2TYdPb5GbxLB9pLiyhfR7RnYHiu8h6W8u46y8=;
        b=G7h91tAtqA8OJ0Nai20nCMjoOIgHPlFXkj7hRe+X/WzHFSM59YE2WuI6Ti6yB1PPv2
         fjo79xVZJjJWBpkDf80Gu0KArR+KvBeJS0Nf/QvMXSmAeiZwxc71bTGw0lcW7oZ12TkO
         WmqO+Q3aAeLE9ONwVn3ZMqRYYTijAhMRcQf3Btzwmgte0BRI3BSrShUI0q1XQEhJtHlp
         qYBuytYVcRwaSARGRa/njJ2HiADEHWYSeh7NKcEkeGMthTTnAC0goWKjOyuLHk5ggnXy
         kHAt2hQya3fUATziPVm88itzppOKCKy2IkfymzwUxREjxXNVaTsEbq1KjfBFniB1PeLR
         Wt6w==
X-Gm-Message-State: APt69E32tjx5tb9+NDI3s53qGh1pdNA3ewyXtSpmck+ims2lfJ6wr9Rv
        MmpK8Ljh4ynMijBXc80qqVQ=
X-Google-Smtp-Source: ADUXVKJYD/QU1eiTCPk/LM/8eduyygWjQLZBn8V0tHIQXO7wLKUtGKHSuWTsfepZ2z5U94o3/feCww==
X-Received: by 2002:adf:e687:: with SMTP id r7-v6mr14035130wrm.14.1529423818917;
        Tue, 19 Jun 2018 08:56:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m16-v6sm5501wro.91.2018.06.19.08.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 08:56:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
References: <20180618111919.GA10085@book.hvoigt.net>
        <CACsJy8CJGditaq4CZfJctVAe9QCdapWQW=W--AumH-4RWWd=vA@mail.gmail.com>
        <20180618181215.GB73085@google.com>
        <20180619103632.GC10085@book.hvoigt.net>
        <CACsJy8DQ-GGEDiV0iA2kTgNgHcT1sSX2Oqb7VZcjyK1nBOFv+A@mail.gmail.com>
Date:   Tue, 19 Jun 2018 08:56:56 -0700
In-Reply-To: <CACsJy8DQ-GGEDiV0iA2kTgNgHcT1sSX2Oqb7VZcjyK1nBOFv+A@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 19 Jun 2018 17:16:17 +0200")
Message-ID: <xmqqmuvqwz07.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jun 19, 2018 at 12:36 PM Heiko Voigt <hvoigt@hvoigt.net> wrote:
>>
>> On Mon, Jun 18, 2018 at 11:12:15AM -0700, Brandon Williams wrote:
>> > On 06/18, Duy Nguyen wrote:
>> > > This sounds like the submodule specific code in pathspec.c, which has
>> > > been replaced with something else in bw/pathspec-sans-the-index. If
>> > > you have time, try a version without those changes (e.g. v2.13 or
>> > > before) to see if it's a possible culprit.
>> >
>> > I just tested this with v2.13 and saw the same issue.  I don't actually
>> > think this ever worked in the way you want it to Heiko.  Maybe git add
>> > needs to be taught to be more intelligent when trying to add a submodule
>> > which doesn't exist in the index.
>>
>> That was also my guess, since my feeling is that this is a quite rare
>> use case. Adding submodules alone is not a daily thing, let alone
>> selecting different changes after 'git submodule add'.
>>
>> I also think git could be more intelligent here.
>
> Ah.. the "submodule not registered in index" case. I think I remember
> this (because I remember complaining about it once or two times).
> Definitely agreed that git-add should do the right thing here.

I am not sure if this even needs to be implemented as "look for the
submodule in the index".  Even before submodule was added, we knew
that "git add foo/bar" should reject the request if we find foo is a
symbolic link, and we should do the same when foo/ is a directory
that is the top of a working tree under control of another
repository, no?

Hmm, what happens when we do this?

	git init
	ln -s /tmp foo
	>foo/bar
	git add foo/

I think we should say either "let's add foo symlink" or
"foo/. (directory) is beyond symlink" (the latter is preferrable,
but the former is acceptable as long as foo is pointing at a
directory; but foo could be a dangling symlink whose pointee's type
may not be discernable by "git add").

Shouldn't we be reacting pretty much the same when we see this?

	git init
	git init foo
	>foo/bar
	git add foo/

That is, either drop '/' and add 'foo' as a submodule, or say
"foo/. (directory) belongs to another repository, cannot add here"
(again, the latter is preferrable for consistency with the symlink
behaviour above).

