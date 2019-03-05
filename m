Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A143820248
	for <e@80x24.org>; Tue,  5 Mar 2019 13:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfCENLA (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 08:11:00 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50498 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfCENLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 08:11:00 -0500
Received: by mail-wm1-f46.google.com with SMTP id x7so2522581wmj.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yRo03uhRQhMjXvEYjhACpaDJUKoniiGyuhkmFftBBmg=;
        b=U/Mfk9bU30Wz5VT6qHmc5m31Id4ZpSoBpLocgGyA4Bo/sHpv0LE9o4/fB4ZoZEC67e
         7vyORxaoAyUsC7HV273sj7+XX5TtYCkWqrgS3/+z3pA2dM8ZkKu8aoCMTTUPx7/3R9w7
         nPYc9cmIvNsjG+dwS9DR9bCqk2Q2QulmSSZHiwGThKoyeyeVuGgutk/5vJhpFQSMgHtJ
         /qbceFwxffaycUD8n7j6+IXR8BloInfyWG62J7knffIBRSuSjlu1DFhYr0GVm9vzQJSg
         OvVIoyeRx2chEMEfvUaFz6IRXQ3tuBY6krYRtNjeFh6n88IPajDr2+qd4+CV5QdOTXqf
         wjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yRo03uhRQhMjXvEYjhACpaDJUKoniiGyuhkmFftBBmg=;
        b=kl06rZeIz1jWYMpgQKuJG/yUjP+sw218t2VjaVa9XrybB81Gxz9hdr056QOiGbYQAS
         3P1kI8zjo1d4sGoiXoFbonkwyzRyfM63UF0E8IyLoBQ2Rfnuld6nlLpbNQIXTF2kpGpB
         h588EVTPqPpp/lzfPqrw1cL1e94fKCSNdAAniUkQrwZFlSA9bpw2VHnk/nWzJnoWP1ai
         PEqbSc++KzMhUPcqvOtRdQD7sPEhGmNvauZB3RPDgYEKLSbOssjld+QD8EpeBpNquRLb
         mICCDqqNMHUXl0cWcw9w/WAdkf0gjXbNxWCF+YIQ5Owg/9AjROffvQJ6Pr0WUgsIi/Vm
         SFmw==
X-Gm-Message-State: APjAAAUS7vRCm3mMUA4YbtW7SAPnWdv2xr+CXcJEbC2AFJo49RBDlbcd
        2JPInyddColtKEKxNuxou6c=
X-Google-Smtp-Source: APXvYqw+XhCRjWHmLXVqQBIjfPBJhd52XjoMEtU3M4aDqfGWb1/DHlyEKoArFrwphEYfz9i6uRDGYA==
X-Received: by 2002:a1c:9684:: with SMTP id y126mr2797636wmd.124.1551791457961;
        Tue, 05 Mar 2019 05:10:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e193sm20314807wmg.18.2019.03.05.05.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 05:10:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: worth enhancing "man git-rebase" to show non-HEAD examples?
References: <alpine.LFD.2.21.1903040955540.16666@localhost.localdomain>
Date:   Tue, 05 Mar 2019 22:10:56 +0900
In-Reply-To: <alpine.LFD.2.21.1903040955540.16666@localhost.localdomain>
        (Robert P. J. Day's message of "Mon, 4 Mar 2019 10:01:32 -0500 (EST)")
Message-ID: <xmqqef7lv53z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   one of the things i've noticed about the examples in "man
> git-rebase" is that they invariably show rebasing relative to a
> branch point that has not moved. for example, there's this example:
>
>        o---o---o---o---o  master
>             \
>              o---o---o---o---o  next
>                               \
>                                o---o---o  topic
>
> with subsequent sample command:
>
>   $ git rebase --onto master next topic
>
> sure, that works, but there seem to be no examples that show that this
> is a valid starting point as well:
>
>
>        o---o---o---o---o  master
>             \
>              o---o---o---o---o  next
>                       \
>                        o---o---o  topic

You mean that the 'topic' forked from 'next', and it is OK for 'next'
to acquire further commits since 'topic' forked from it, for you to
rebase 'topic' on another history?

The very first example in Documentation/git-rebase.txt shows a
3-commit topic A-B-C, forked from the master branch at E in 4-commit
D-E-F-G sequence, gets rebased.  Those F and G are in the same place
as those rightmost two commits you have on 'next' in the above
picture.

> as in, the examples in that man page could potentially suggest to an
> inexperienced reader that the *only* valid situations are rebasing as
> long as the other branch has not developed any further. (yes, i
> realize that, if you read carefully, it *should* make it clear, but i
> think it would be helpful to at least graphically show that
> happening.)
>
>   thoughts?

So, we have both pictures, and I do not see there is much to add.

By the way, I sense a mis-perception that led you to say "... has
not developed any further".  In the topology in your second
illustration, there is nothing to say that the rightmost two commits
on the 'next' branch were created _after_ topic has forked from
'next'.  It is not just possible but also often is sensible to fork
a topic closer to what it needs to build on top of, limiting its
dependency as small as possible, so the 'topic' could have been
forked from the middle of 'next' branch when it was originally
created.

