Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793B31F404
	for <e@80x24.org>; Sat, 23 Dec 2017 18:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbdLWS7k (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 13:59:40 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:45804 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbdLWS7i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 13:59:38 -0500
Received: by mail-wm0-f49.google.com with SMTP id 9so26912680wme.4
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 10:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=qk7IkdUsEBJBKxWGxMQxkNL+/UKR7fJOZyQOyw4yBzI=;
        b=hdeA7Qfl59Yd0kJ/dgeq2fb18pJno1d5lalxNl5YhdZMOJ4YLg0PVJHCGIo/EF9QKz
         M/Z2XrWgqAYGclHXMIjDUJr2jeXYaTQcUAREixw5Re3RWCGOhvcRBFdqa32cOM1dPFPt
         7YvJJk/7+vMjMi1ChnjpMJiHyhdpXpA48GfJMSHTkFQWBqV7PdfDO+lgGD0kfusjouPt
         /B34zoupvueqX312ZCPZJt+9rGzRqDCHIG++fsTF+4cV+peH39UgED6KsiLePLsD5fnE
         vY0bkuGocoOkJpp2ybkb0ULTwVm9gfGIQ6D/W64Ba2RTbpeExgej1SNHrfNe0RXRZDPa
         0GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=qk7IkdUsEBJBKxWGxMQxkNL+/UKR7fJOZyQOyw4yBzI=;
        b=SzyN32Rul0Chf+HnNBz8tgDisbDHGazySyK1JNyaouR4vyMPNnHw8RzuPFxsunMy+/
         h/UbzjElrjMOKZJXsmnflMGWGAskIeF4abWVBcg5k+lT4GJLXmBStN09Fx13hnCZ/xg1
         OGNPMS5RH0/s6JLFL5HbI4LkEpFusoB3KdFAif8ooH2N1+4+dKjG6mQIIshCClZmA8kw
         gCrCI97X/odWqmR1ZYTKTxXI9nc4KJUSWP6BWPWXWL0v0Kg9FFxkpCE/4lbncyPs+O7A
         5iVMGhB8U9fdhK4kJ8aKoURAF/QuAD+Tt8INm9TPBvMsSan1VrRZzKQEgOLUzpT0kKUW
         qPjQ==
X-Gm-Message-State: AKGB3mJOLYQgK2syM3ZS2klKX6DE1rMfegbhLjtz/WLak+OMczXafpQS
        heZNTupnLdgBPi01F/WU3IA=
X-Google-Smtp-Source: ACJfBosLLeSnIoGQD1miLytTOC4dVrMkBBYhoVkoPYFw1gStGvy4LTlcs1G9lWczUIdrwy/FNvzkuw==
X-Received: by 10.80.164.241 with SMTP id x46mr20197382edb.247.1514055577029;
        Sat, 23 Dec 2017 10:59:37 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id b7sm21052719eda.60.2017.12.23.10.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Dec 2017 10:59:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
Date:   Sat, 23 Dec 2017 19:59:35 +0100
Message-ID: <877etds220.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 23 2017, Carl Baldwin jotted:

> The big contention among git users is whether to rebase or to merge
> changes [2][3] while iterating. I used to firmly believe that merging
> was the way to go and rebase was harmful. More recently, I have worked
> in some environments where I saw rebase used very effectively while
> iterating on changes and I relaxed my stance a lot. Now, I'm on the
> fence. I appreciate the strengths and weaknesses of both approaches. I
> waffle between the two depending on the situation, the tools being
> used, and I guess, to some extent, my mood.
>
> I think what git needs is something brand new that brings the two
> together and has all of the advantages of both approaches. Let me
> explain what I've got in mind...
>
> I've been calling this proposal `git replay` or `git replace` but I'd
> like to hear other suggestions for what to name it. It works like
> rebase except with one very important difference. Instead of orphaning
> the original commit, it keeps a pointer to it in the commit just like
> a `parent` entry but calls it `replaces` instead to distinguish it
> from regular history. In the resulting commit history, following
> `parent` pointers shows exactly the same history as if the commit had
> been rebased. Meanwhile, the history of iterating on the change itself
> is available by following `replaces` pointers. The new commit replaces
> the old one but keeps it around to record how the change evolved.
>
> The git history now has two dimensions. The first shows a cleaned up
> history where fix ups and code review feedback have been rolled into
> the original changes and changes can possibly be ordered in a nice
> linear progression that is much easier to understand. The second
> drills into the history of a change. There is no loss and you don't
> change history in a way that will cause problems for others who have
> the older commits.
>
> Replay handles collaboration between multiple authors on a single
> change. This is difficult and prone to accidental loss when using
> rebase and it results in a complex history when done with merge. With
> replay, collaborators could merge while collaborating on a single
> change and a record of each one's contributions can be preserved.
> Attempting this level of collaboration caused me many headaches when I
> worked with the gerrit workflow (which in many ways, I like a lot).
>
> I blogged about this proposal earlier this year when I first thought
> of it [1]. I got busy and didn't think about it for a while. Now with
> a little time off of work, I've come back to revisit it. The blog
> entry has a few examples showing how it works and how the history will
> look in a few examples. Take a look.
>
> Various git commands will have to learn how to handle this kind of
> history. For example, things like fetch, push, gc, and others that
> move history around and clean out orphaned history should treat
> anything reachable through `replaces` pointers as precious. Log and
> related history commands may need new switches to traverse the history
> differently in different situations. Bisect is a interesting one. I
> tend to think that bisect should prefer the regular commit history but
> have the ability to drill into the change history if necessary.
>
> In my opinion, this proposal would bring together rebase and merge in
> a powerful way and could end the contention. Thanks for your
> consideration.
>
> Carl Baldwin
>
> [1] http://blog.episodicgenius.com/post/merge-or-rebase--neither/
> [2] https://git-scm.com/book/en/v2/Git-Branching-Rebasing
> [3] http://changelog.complete.org/archives/586-rebase-considered-harmful

I think this is a worthwhile thing to implement, there are certainly
use-cases where you'd like to have your cake & eat it too as it were,
i.e. have a nice rebased history in "git log", but also have the "raw"
history for all the reasons the fossil people like to talk about, or for
some compliance reasons.

But I don't see why you think this needs a new "replaces" parent pointer
orthagonal to parent pointers, i.e. something that would need to be a
new field in the commit object (I may have misread the proposal, it's
not heavy on technical details).

Consider a merge use case like this:

          A---B---C topic
         /         \
    D---E---F---G---H master

Here we worked on a topic with commits A,B & C, maybe we regret not
squashing B into A, but it gives us the "raw" history. Instead we might
rebase it like this:

          A+B---C topic
         /
    G---H master

Now we can push "topic" to master, but as you've noted this loses the
raw history, but now consider doing this instead:

          A---B---C   A2+B2---C2 topic
         /         \ /
    D---E---F---G---G master

I.e. you could have started working on commit A/B/C, now you "git
replace" them (which would be some fancy rebase alias), and what it'll
do is create a merge commit that entirely resolves the conflict so that
hte tree is equivalent to what "master" was already at. Then you rewrite
them and re-apply them on top.

If you run "git log" it will already ignore A,B,C unless you specify
--full-history, so git already knows to ignore these sort of side
histories that result in no changes on the branch they got merged
into. I don't know about bisect, but if it's not doing something similar
already it would be easy to make it do so.

You could even add a new field to the commit object of A2+B2 & C2 which
would be one or more of "replaces <sha1 of A/B/C>", commit objects
support adding arbitrary new fields without anything breaking.

But most importantly, while I think this gives you the same things from
a UX level, it doesn't need any changes to fetch, push, gc or whatever,
since it's all stuff we support today, someone just needs to hack
"rebase" to create this sort of no-op merge commit to take advantage of
it.
