Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C69D41F404
	for <e@80x24.org>; Sat, 23 Dec 2017 22:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbdLWWKE (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 17:10:04 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35341 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdLWWKD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 17:10:03 -0500
Received: by mail-wm0-f47.google.com with SMTP id f9so27384034wmh.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 14:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wp8ij4WiD6YSYQejJGLa/oj2bJu/KAQ+hdvFAL2j4Mg=;
        b=Df13FsP2kciYg9flRTcaQpAp0cph/PKHzFAbVgvYh3ZF+1Z6tCc6f+l6TaXE3xtXKL
         UMQ03DOrDyqX0CHfI6JZILDObX7t1j5i1Uyt3YnYhhMInsAcgnj+cjF3Q4HhtpxDHTQp
         q6oOM86wiprdOaDMt7wHydPr2nImnypQJ0nikuZbL/VuqlRmhPRq9lzQwUKi5Tia56Vp
         gG61Pe3HrxiZlcHAGV8uY0IWtAk3z66fZJhtCKQkK7Bm86w/Q/2Sh1AhA0XgHWv1LFDT
         CcLDFD3LwcBgV50zXw+u3NewqibgHVGzleXKWYJ9jDE0/4UUe24XPlXO1S49UYImMOb3
         KdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=wp8ij4WiD6YSYQejJGLa/oj2bJu/KAQ+hdvFAL2j4Mg=;
        b=Re2A4JBb+e/0VO8rBNWAN+lPkYp/CQpzwtichlMAjGpar7DEq40fhnpQL1sayK8mlm
         a+JbNAvOSkwclC926Y5gf31Obcs7AytFpUtZgO17RRB5jDZBRE/mla7JQOiH7dtxwdt/
         bI4sPkRMO5y586AuAA/VAbPPUNwcasuXHHUAw+c3BXoxD9qzF00fDDNN8ggOUoeoCN2m
         JeCKRBWbTVAVW6LgWvhnY1UOteJdUkAI7bSPB+o/8pvJPVX5Tn1nINfSaf5qpMoOD9DO
         IH8kkiQOzj1iRCS7bThu6KVcnZbMYnjFxicNSOy/L9MTXPM4z0f8AmCnxxuu5x2DLHs7
         37Iw==
X-Gm-Message-State: AKGB3mJc/UYgz9Pe3Nfa5lrrDWOdmHK4VpX7eBHI10loWDpNu6D0wcfQ
        pxp04NXdDjpoHbsinWcTxpc=
X-Google-Smtp-Source: ACJfBosll8mEExlKWSxYwiq7tWxEfLhg+xu+mFyVQWIuWxlck/2I3/g+moNhS9NDK3eu3ueWIQSu4w==
X-Received: by 10.80.151.178 with SMTP id e47mr20421136edb.196.1514067001755;
        Sat, 23 Dec 2017 14:10:01 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id e49sm24084789eda.90.2017.12.23.14.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Dec 2017 14:10:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <877etds220.fsf@evledraar.gmail.com> <20171223210141.GA24715@hpz.ecbaldwin.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171223210141.GA24715@hpz.ecbaldwin.net>
Date:   Sat, 23 Dec 2017 23:09:59 +0100
Message-ID: <87608xrt8o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 23 2017, Carl Baldwin jotted:

> On Sat, Dec 23, 2017 at 07:59:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> I think this is a worthwhile thing to implement, there are certainly
>> use-cases where you'd like to have your cake & eat it too as it were,
>> i.e. have a nice rebased history in "git log", but also have the "raw"
>> history for all the reasons the fossil people like to talk about, or for
>> some compliance reasons.
>
> Thank you kindly for your reply. I do think we can have the cake and eat
> it too in this case. At a high level, what you describe above is what
> I'm after. I'm sorry if I left something out or was unclear. I hoped to
> keep my original post brief. Maybe it was too brief to be useful.
> However, I'd like to follow up and be understood.
>
>> But I don't see why you think this needs a new "replaces" parent pointer
>> orthagonal to parent pointers, i.e. something that would need to be a
>> new field in the commit object (I may have misread the proposal, it's
>> not heavy on technical details).
>
> Just to clarify, I am proposing a new "replaces" pointer in the commit
> object. Imagine starting with rebase exactly as it works today. This new
> field would be inserted into any new commit created by a rebase command
> to reference the original commit on which it was based. Though, I'm not
> sure if it would be better to change the behavior of the existing rebase
> command, provide a switch or config option to turn it on, or provide a
> new command entirely (e.g. git replay or git replace) to avoid
> compatibility issues with the existing rebase.

Yeah that sounds fine, I thought you meant that this "replaces" field
would replace the "parent" field, which would require some rather deep
incompatible changes to all git clients.

But then I don't get why you think fetch/pull/gc would need to be
altered, if it's because you thought that adding arbitrary *new* fields
to the commit object would require changes to those that's not the case.

> I imagine that a "git commit --amend" would also insert a "replaces"
> reference to the original commit but I failed to mention that in my
> original post. The amend use case is similar to adding a fixup commit
> and then doing a squash in interactive mode.
>
>> Consider a merge use case like this:
>>
>>           A---B---C topic
>>          /         \
>>     D---E---F---G---H master
>
> This is a bit different than the use cases that I've had in mind. You
> show that the topic has already merged to master. I have imagined this
> proposal being useful before the topic becomes a part of the master
> branch. I'm thinking in the context of something like a github pull
> request under active development and review or a gerrit review. So, at
> this point, we still look like this:
>
>           A---B---C topic
>          /
>     D---E---F---G

Right, I'm just mentioning this for context, i.e. "if you only used
git-merge".

>> Here we worked on a topic with commits A,B & C, maybe we regret not
>> squashing B into A, but it gives us the "raw" history. Instead we might
>> rebase it like this:
>>
>>           A+B---C topic
>>          /
>>     G---H master
>
> Since H already merged the topic. I'm not sure what the A+B and C
> commits are doing.

This means that master is at commit H, but your newly rebased topic is
at C, i.e. master has no new commits so you could `git push origin
C:master` without -f.

> At the point where I have C and G above, let's say I regret not having
> squashed A and B as you suggested. My proposal would end up as I draw
> below where the primes are the new versions of the commits (A' is A+B).
> Bare with me, I'm not sure the best way to draw this in ascii. It has
> that orthogoal dimension that makes the ascii drawings a little more
> complex: (I left out the parent of A' which is still E)
>
>        A--B---C
>         \ |    \                    <- "replaces" rather than "parent"
>          -A'----C' topic
>          /
>     D---E---F---G master
>
> We can continue by actually changing the base. All of these commits are
> kept, I just drop them from the drawings to avoid getting too complex.
>
>                 A'--C'
>                  \   \              <- "replaces" rather than "parent"
>                   A"--C" topic
>                  /
>     D---E---F---G master
>
> Normal git log operations would ignore them by default. When finally
> merging to master, it ends up very simple (by default) but the history
> is still there to support archealogic operations.
>
>     D---E---F---G---A"--C" master
>
>> Now we can push "topic" to master, but as you've noted this loses the
>> raw history, but now consider doing this instead:
>>
>>           A---B---C   A2+B2---C2 topic
>>          /         \ /
>>     D---E---F---G---G master
>
> There are two Gs in this drawing. Should the second be H? Sorry, I'm
> just trying to understanding the use case you're describing and I don't
> understand it yet which makes it difficult to comment on the rest of
> your reply.

Yes this is very confusing, sorry for not clarifying this.

What the letters in *this* diagram actually mean is they're all unique
ids for commits that parse to the same value given;

    git rev-parse $commit^{tree}

I.e. you'd merge C into the G commit, and you'd end up with a commit
that would give you the exact same tree, see "ours" under "MERGE
STRATEGIES" in git-commit(1).

You can try to create one of these with:

    (
        rm -rf /tmp/testgit &&
        git clone git@github.com:antirez/rax.git /tmp/testgit &&
        cd /tmp/testgit &&
        git checkout -b wip-rebase master &&
        for f in foo bar baz; do
            echo $f >$f &&
            git add $f &&
            git commit -m"$f"
        done &&
        git checkout master &&
        git merge --no-edit -s ours wip-rebase &&
        git rev-parse origin/master^{tree} &&
        git rev-parse HEAD^{tree}
    )

Note that the output of the two rev-parse commands is the same,
i.e. I've created a bunch of content on a side branch and merged it in,
but due to "-s ours" the end result is exactly the same as if it had
never been merged as far as the content of the tree at HEAD goes.

But I see now that I was wrong/misremembering about --full-history. In
this case if you just run "git log" you'd get those foo/bar/baz changes,
however if you run;

    git log -- foo

You get nothing, but run:

    git log --full-history -- foo

And you get that no-op merge.

But in any case, regardless of what the history simplification does
*now* I was trying to point out, with the assumption (see my comment
about pull/fetch/gc above) that you were suggesting some deep changes in
how git's object model works.

Instead, if I understand what you're actually trying to do, it could
also be done as:

 1) Just add a new replaces <sha1> field to new commit objects

 2) Make git-rebase know how to write those, e.g. add two of those
    pointing to A & B when it squashes them into AB.

 3) Write a history traversal mechanism similar to --full-history
    that'll ignore any commits on branches that yield no changes, or
    only those whose commits are referenced by this "replaces" field.

You'd then end up with:

 A) A way to "stash" these commits in the permanent history

 B) ... that wouldn't be visble in "git log" by default

 C) Would require no underlying changes to the commit model, i.e. it
    would work with all past & future git clients, if they didn't know
    about the "replaces" field they'd just show more verbose history.

>> I.e. you could have started working on commit A/B/C, now you "git
>> replace" them (which would be some fancy rebase alias), and what it'll
>> do is create a merge commit that entirely resolves the conflict so that
>> hte tree is equivalent to what "master" was already at. Then you rewrite
>> them and re-apply them on top.
>>
>> If you run "git log" it will already ignore A,B,C unless you specify
>> --full-history, so git already knows to ignore these sort of side
>> histories that result in no changes on the branch they got merged
>> into. I don't know about bisect, but if it's not doing something similar
>> already it would be easy to make it do so.
>
> I haven't had the need to use --full-history much. Let me see if I can
> play around with it to see if I can figure out how to use it in a way
> that gives me what I'm after.
>
>> You could even add a new field to the commit object of A2+B2 & C2 which
>> would be one or more of "replaces <sha1 of A/B/C>", commit objects
>> support adding arbitrary new fields without anything breaking.
>>
>> But most importantly, while I think this gives you the same things from
>> a UX level, it doesn't need any changes to fetch, push, gc or whatever,
>> since it's all stuff we support today, someone just needs to hack
>> "rebase" to create this sort of no-op merge commit to take advantage of
>> it.
>
> Avoiding changes would be very nice. I'm not convinced yet that it can
> be done but maybe when I understand your counter proposal, it will
> become clearer.
>
> Thank you,
> Carl Baldwin
