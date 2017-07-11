Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8EB2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 17:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756282AbdGKR1o (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 13:27:44 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35575 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756277AbdGKR1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 13:27:43 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so659056pgc.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4HQYCkirQzYyJyCR/6Y3EIoaAfC2yWkN7wFYDErPK1I=;
        b=efgK966AmJvNATU2U4mGuKo5kc6Q67Epf2d+OgFbRYivGcSy9NYOqhMR04humZdYvR
         iuSfEJciTOdEgzCgPBPTn+uywtTIGNNiTVp1pXw3z8pTFjSTsCExvFMh93E+Bbp4XpYd
         AfxcEgtJ8DvSClWqGnCwrQNdTzeSMfodJNmXlonftzUwLwFN0uyyhMd6eA+4aYzCXkVR
         8ZPLG1Z+Cz+88/ru/OBJ0s9LFZ2ufJ3Gz0Ig9PYzNjn8Lvwqip+NiaWH0WdFSnTDhpMq
         /rdxL6PHt/d50mDLxOZLEimum97gGgRJr+x//ruOx/kkdvOkM1kUtJZtCYJ0OSmfaaWw
         rJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4HQYCkirQzYyJyCR/6Y3EIoaAfC2yWkN7wFYDErPK1I=;
        b=bGU+Vpjdz8IxTLt5l95hQsk9dqSjKL0KrNBWxYdJBNwnOutsrJZT4SSoZoj+93dvb3
         AARrpt1VIrAUAKNyAFqUuMX9YL6voPrnimaJmGaEEW+X2ORDtOKQ9ZeDYhS7ko1BYleC
         iQDhmSke3xx3Bm8tPQ47jQs2Yy37jJG2mMLkDNaLd0WnSnI4U8kIw476rcs6e1a3rbY7
         ZyrUE/9QvCJQZWpBKt9WbGOUe/gZls7NHwGzRBJID1pv6fGJC0aH2jKXJa1cgIFEBHUc
         z+XcLIBtYbq4gtMt2FM5IEbdH/ZIDugaO0uJySL9v8uomXfbuB57UtCweBW3LvBn5lzP
         ldeg==
X-Gm-Message-State: AIVw112BwKKJM3Ctyd7j0I9B5mHhxgr824/SnSTqcyra9LrH3k2oJzts
        F/SLLYctXxArxQi7STw=
X-Received: by 10.98.65.198 with SMTP id g67mr50859478pfd.196.1499794062255;
        Tue, 11 Jul 2017 10:27:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id t83sm802253pfg.91.2017.07.11.10.27.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 10:27:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nikolay Shustov <nikolay.shustov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "groups of files" in Git?
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
Date:   Tue, 11 Jul 2017 10:27:40 -0700
In-Reply-To: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
        (Nikolay Shustov's message of "Tue, 11 Jul 2017 11:45:13 -0400")
Message-ID: <xmqqh8yi3mur.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikolay Shustov <nikolay.shustov@gmail.com> writes:

> I have to work on several features in the same code tree parallel, in
> the same Perforce workspace. The major reason why I cannot work on one
> feature then on another is just because I have to make sure that the
> changes in the related areas of the product play together well.
>
> With Perforce, I can have multiple changelists opened, that group the
> changed files as needed.
>
> With Git I cannot seem to finding the possibility to figure out how to
> achieve the same result. And the problem is that putting change sets
> on different Git branches (or workdirs, or whatever Git offers that
> makes the changes to be NOT in the same source tree) is not a viable
> option from me ...

Naturally.  If these separate changes need to work together, it is
way too inconvenient if these changes do not appear in a single
unified working tree to be built and tested.

> Is it worth considering adding to Git a feature like "group of files"
> that would offer some virtutal grouping of the locally changed files
> in the checked-out branch?

Let's step back and let me make sure if I understand you correctly.
You want to work on a system with two distinct areas (say, the
frontend and the backend), that have to work together, but you want
to make two commits, one for each area.  You make changes for both
areas in your working tree, build and test them to make sure the
whole thing works well together, and at the end, you make two
commits.  

In your real project, you may be doing more than two areas and more
than two commits, but is the above a good degenerative case that
shows the basic idea?  If not, then please disregard all of the
following.

You can make partial commits in Git.  In the simplest case, you may
have two separate files backend.py and frontend.py, you make edits
to both files and then make two commits:

	$ git commit backend.py
	$ git commit frontend.py

Changes to some files may contain both changes for the backend and
for the frontend that does not allow you to separate commits at file
boundary, and Git even lets you handle such a case.  If you have the
third file in addition to the above two, called common.py, you could
instead

	$ git add backend.py
	$ git add -p common.py

to prepare the index to contain only the changes for the backend
part ("add -p" lets you interactively pick and choose the hunks
relevant to the backend part), and conclude the commit for the
backend part with

	$ git commit ;# no paths arguments

and then when all the remaining changes are for the frontend part,
you can follow it with

	$ git commit -a

to make another commit for the frontend part.

A short answer to your question, provided if I understood you
correctly, is "no, there is no way to say 'backend.py, backend-2.py,
...' are the backend things and call it a filegroup", accompanied by
"a filegroup would only be effective when changes align with file
boundary".

And if your response is "but most of the time changes align with
file boundary", a counter-response is "and most of the time changes
align with directory boundary (in well structured project, at
least), so you can do 'git commit backend/' for all the backend part
without having to name all the paths anyway".

There is an experimental "attributes-limited pathspec" feature in
recent versions of Git, which lets you assign arbitrary sets of
labels to each paths, and using that you may be able to do

	$ git commit ':(attr:filegroup=backend).'

and I suspect that would be the closest thing you would want (read
about 'pathspec' in 'git help glossary')

