Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEFB81F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeBUWoS (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:44:18 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:39240 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUWoR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:44:17 -0500
Received: by mail-wr0-f171.google.com with SMTP id w77so8651368wrc.6
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Yk+GKsmg1Fsj4n4bV8cCF0r1sCgkTLw3drYkUp6Gg6w=;
        b=Q6StXxq6hp5x80b7ymwjQ6CP6NcKN44C/Ywa5P9B/gr9lRBdnRALo5hfFICKnyTv/Q
         yr4iPqEtlaEXQtx/mesi49pFZOn6qjjHTHwKEd/xrFTFlIEccQRA8RPxMGJShd4Jywfp
         +9WoB3NQMuE4+oevuXDqwBqKJ32WI+hueHhxgUS0KHPbqr8Q71QZ1N0m/xqMxkMKHd0d
         WbldHAYDZT8fwiS9o7uV6IaftnqclsMiHpe6F+vIuw8zI2hdecjJlGSWbFIeDsjVYwzJ
         HzEmSHe8/2rkLTU9XzxsMeDdlhHYawJcQxSt+TTOGb2yaj+aojZCiaN8hEBSmwejLfGg
         OmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Yk+GKsmg1Fsj4n4bV8cCF0r1sCgkTLw3drYkUp6Gg6w=;
        b=XfVp85b3qytCqw/BeEJF+XuEihmTOhDGVvjO3PI5aWeWOR9pNsWYlO1xZOW0G91DbZ
         5zbZwMZofGvRJ2juz6bwi5JuB3+6oDS039ANlDuFHCnTFP/hRQYh2+RuBXARCp0vtyT3
         aRCG3h4FaIupSJWgjGgLK0KlGFPVw62JORzc2wBwrYby4fO/8t8dUW3AYhoNYBHRXJkG
         TR7VY9kOQXDSTtTl/3GboTmPuRSXQY9LrPrXttdJow/JRZ0i0nHkcdlroSv4xffPn27/
         6H/4AOOR23nIxgQNoRsgF/8B481ovu4QM2NOKJoINp5i3zEk3PoZMTTjOjIgRrERrdR6
         0jxQ==
X-Gm-Message-State: APf1xPCbEC+/tnfCMx+Y9iRtZZZgCHFpoDto6TyyFe2WnWuGnH+07Yuq
        Kds6dtHYm7nkL3hB+nzpy6By3TPn
X-Google-Smtp-Source: AH8x227wckH3MtJdxgQ9ydaD6fG0xyqxRLzCg5/iMeBmoa27h8rxDy3lOSTNd9EysS3Uwwn2qVKeIA==
X-Received: by 10.223.187.72 with SMTP id x8mr4144097wrg.217.1519253056274;
        Wed, 21 Feb 2018 14:44:16 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id a14sm11715903wra.27.2018.02.21.14.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 14:44:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Derek Fawcus <dfawcus+lists-git@employees.org>,
        git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Git should preserve modification times at least on request
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <20180221210339.GA43094@accordion.employees.org> <87bmgif2pa.fsf@evledraar.gmail.com> <20180221221420.GA7743@helen.PLASMA.Xg8.DE>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180221221420.GA7743@helen.PLASMA.Xg8.DE>
Date:   Wed, 21 Feb 2018 23:44:13 +0100
Message-ID: <87a7w2ezeq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 21 2018, Peter Backes jotted:

> On Wed, Feb 21, 2018 at 10:33:05PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> This sounds like a sensible job for a git import tool, i.e. import a
>> target directory into git, and instead of 'git add'-ing the whole thing
>> it would look at the mtimes, sort files by mtime, then add them in order
>> and only commit those files that had the same mtime in the same commit
>> (or within some boundary).
>
> I think that this would be The Wrong Thing to do.

I'm merely pointing out that if you have the use-case Derek Fawcus
describes you can get per-file mtimes via something similar to the the
hook method Theodore Ts'o described today with a simple import tool with
no changes to git or its object format required.

To the extent that there's a convention for this in git that's the
convention, e.g. if you use github or gitlab they'll render the
modification time of a file in the tree view, and that time is the time
of the commit that last touched it: https://github.com/git/git

> The commit time is just that: The time the commit was done. The commit
> is an atomic group of changes to a number of files that hopefully bring
> the tree from one usable state into the next.
>
> The mtime, in contrast, tells us when a file was most recently modified.
>
> It may well be that main.c was most recently modified yesterday, and
> feature.c was modified this morning, and that only both changes taken
> together make sense as a commit, despite the long time in between.
>
> Even worse, it may be that feature A took a long time to implement, so
> we have huge gaps in between the mtimes, but feature B was quickly done
> after A was finished.

...

> Such an algorithm would probably split feature A
> incorrectly into several commits, and group the more recently changed
> files of feature A with those of feature B.

Right, but that's a trade-off you can pick at import time in this
hypothetical tar-to-commits tool, you could decide to do no merging and
suffer to signal loss.

> And if Feature A and Feature B were developed in parallel, things get
> completely messy.
>
>> The advantage of doing this via such a tool is that you could tweak it
>> to commit by any criteria you wanted, e.g. not mtime but ctime or even
>> atime.
>
> Maybe, but it would be rather useless to commit by ctime or atime. You
> do one grep -r and the atime is different. You do one chmod or chown
> and the ctime is different. Those timestamps are really only useful for
> very limited purposes.
>
> That ctime exists seems reasonable, since it's only ever updated when
> the inode is written anyway.
>
> atime, in contrast, was clearly one of the rather nonsensical
> innovations of UNIX: Do one write to the disk for each read from the
> disk. C'mon, really? It would have been a lot more reasonable to simply
> provide a generic way for tracing read() system calls instead; then
> userspace could decide what to do with that information and which of it
> is useful and should be kept and perhaps stored on disk. Now we have
> this ugly hack called relatime to deal with the problem.

Yes, that [ac]time example was a stretch. A better example would be
committing the file mode, or extended attributes, or "this is on a
different FS", or whatever other per-file/dir attribute we're not
currently capturing.

>> You'd get the same thing as you'd get if git's tree format would change
>> to include mtimes (which isn't going to happen), but with a lot more
>> flexibility.
>
> Well, from basic logic, I don't see how a decision not to implement a
> feature could possibly increase flexility. The opposite seems to be the
> case.

I'm not trying to argue the usefulness of this mtime-per-file thing in
theory, just providing Derek Fawcus with a suggestion for a viable
workaround.

What I meant by this offhand comment, and which you may or may not know
(and I see no references to it from skimming the thread) is that there's
simply no space in the tree objects to add *anything* without breaking
the object format and requiring a major upgrade, although the plan to
switch to a new hash function is relevant to this.

Even if we suppose that git was being implemented today I don't think
this would make any sense as a first-level feature.

Empirical evidence suggests that people use git on a massive scale
largely without caring about this, and the users who do have a
workaround.

If it were added as a first-level feature to git it would present a lot
of UX confusion. E.g. you run "git add" and it'll be showing the mtime
somehow, or you get a formatted patch over E-Mail and it doesn't only
include the commit time but also times for individual files.

The VC systems that had this feature in the past were centralized, so
they could (in theory anyway) ensure that timestamps were monotonically
increasing. This won't be the case with git, we have plenty of timestamp
drift in e.g. linux.git and other git repos.

So if these mtimes were used by default they'd interact badly with stuff
like "make" in those cases, because you might check out a modified
version with a timestamp in the past.

Or maybe I've misunderstood how that worked in CVS/SVN/Bitkeeper, but in
any case, I just wanted to point out a workaround (but then digressed
into critiquing the idea above...).
