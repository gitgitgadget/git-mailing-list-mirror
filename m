Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0B11F597
	for <e@80x24.org>; Tue, 24 Jul 2018 01:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbeGXCyt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 22:54:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35657 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbeGXCyt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 22:54:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so889219wmc.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 18:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=dsRSDeqNboT2DnWBxQ6CDUAdWBpSyIkV8VQNsv45dcQ=;
        b=t0ibczqgrYT6WtL6AYxi+p18XZMiybDws1uj+SpSA5cAcOhhkUzM0uV29UK7AI40nf
         1WlWCQ+/NLk+hptRwO+dZoqVIR23gDk0mA9E+DGZlASaFFELZXVFamkh1wl550Dh56li
         hOjqUgHiajWhbJ7D24617kAdcBA5itxhAeqrtfAExJFXQJ1tMJXJDJ4vNH7dKmXRGQMO
         6T+CaEg8+uFcYNKD7R62jJg2s7+20bkY8KDyMa/sVBzX2uOqkTQljRIaW+q4TOEM/+Ez
         LDW/MwlKnXNjvtnAT1GblC/2l20YkeXDM+2SJtys8kxo5YWZcttupHtzBtED/TZvqXz2
         h44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=dsRSDeqNboT2DnWBxQ6CDUAdWBpSyIkV8VQNsv45dcQ=;
        b=VGUtYKyUzjPkhmwIHOQBJrH/Qaxk0Qga7syt3zCVnMcxwtT4OGr970q6vyAGQE50u5
         M/lGSp28oSK9zYBUnl2siR5RCElczzNGP8oAgXX3wMHd3ctrUNerXp3nFc0hdz3QYaOB
         WvlWckvcTuRMxWWwUvwRsbqgYIsm9ecrXqzTmDkTn8wac+1AnisdZXHKMWp8tytSFdzK
         egmITOSHJKsJvzgyYcsMYRpvtkZ93GY9jCM90dMhKmDiG/QJlB4xbnZJuIREPW5S6Sga
         jLZNhyFxGxZr9IHxmOOCGVJEJSMTaPBYvIimoMbBr6iXrLSG4Hi+5bc4ONFfatTf/lMg
         s3Bw==
X-Gm-Message-State: AOUpUlEcS+U9gIzWM788vDgRyLBfT28t21ohBW+MkhFOSpIbf+04nS+B
        17LrZI92Q0mhcOYiT+MTptrMmWor
X-Google-Smtp-Source: AAOMgpfEDgaiZgfBJYObRS+yyhRGg9b1Izu+VOk+qklYvfBpq0ekVn/m9coajAq4Yka0vO5llwbpyw==
X-Received: by 2002:a1c:ee5d:: with SMTP id m90-v6mr663067wmh.107.1532397048159;
        Mon, 23 Jul 2018 18:50:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b11-v6sm582460wma.34.2018.07.23.18.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 18:50:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
References: <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
        <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
        <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com>
        <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet>
        <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807212347330.71@tvgsbejvaqbjf.bet>
        <20180723012552.GA26886@sigill.intra.peff.net>
Date:   Mon, 23 Jul 2018 18:50:46 -0700
Message-ID: <xmqqlga11jwp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If I understand the situation correctly, Junio is saying that he will
> continue to produce the amlog mapping, and that it contains sufficient
> information to produce the reverse mapping (which, as an aside, I did
> not even know existed -- I mostly want to go the other way, from digging
> in history to a mailing list conversation).

Yes, the reverse mapping in amlog was an experiment that did not
work well in the end.

When I use "git am" to make a commit out of a message, a
post-applypatch hook picks up the "Message-Id:" from the original
message and adds a git note to the resulting commit.  This is in
line with how the notes are meant to be used.  We have a commit
object, and a piece of information that we want to associate with
the commit object, which is not recorded as a part of the commit
object.  So we say "git notes add -m 'that piece of info' $commit"
(the message-id happens to be that piece of info in this example).

And with notes.rewriteRef, "git commit --amend" etc. would copy the
piece of info about the original commit to the rewritten commit.

	Side Note: there are a few workflow elements I do want to
	keep using but they currently *lose* the mapping info.  An
	obvious one is

	  $ git checkout -b to/pic master &&
	  ... review in MUA and then ...
	  $ git am -s mbox &&
	  ... review in tree, attempt to build, tweak, etc.
          $ git format-patch --stdout master..to/pic >P &&
          $ edit P &&
          $ git reset --hard master &&
          $ git am P

	which is far more versatile and efficient when doing certain
	transformations on the series than running "rebase -i" and
	reopening and editing the target files of the patches one by
	one in each step.  But because format-patch does not
	generate Message-Id header of the original one out of the
	commit, the post-applypatch hook run by "am" at the end of
	the steps would not have a chance to record that for the
	newly created commit.

	For this one, I think I can use "format-patch --notes=amlog"
	to produce the patch file and then teach post-applypatch
	script to pay attention to the Notes annotation without
	changing anything else to record the message id of the
	original.  Other workflow elements that lose the notes need
	to be identified and either a fix implemented or a
	workaround found for each of them.  For example, I suspect
	there is no workaround for "cherry-pick" and it would take a
	real fix.

A reverse mapping entry used to get created by post-applypatch to
map the blob that represents the notes text added to the $commit to
another text blob that contains the 40-hex of the commit object.
This is the experiment that did not work well.  As none of the later
integrator's work e.g. "commit --amend", "rebase", "cherry-pick",
etc. is about rewriting that blob, notes.rewriteRef mechanism would
not kick in, and that is understandasble.

And these (incomplete) reverse mapping entries get in the way to
maintain and correct the forward mapping.  When a commit that got
unreachable gets expired, I want "git notes prune" to remove notes
on them, and I do not want to even think about what should happen to
the entries in the notes tree that abuse the mechanism to map blobs
that are otherwise *not* even reachable from the main history.

A much more important task is to make sure that the forward mapping
that annotates invidual commits reachable from 'pu' and/or 'master' 
is maintained correctly by various tools.  From a correctly maintained
forward mapping, it should be straight forward to get a reverse mapping
if needed.

> Though personally, I do not know if there is much point in pushing it
> out, given that receivers can reverse the mapping themselves.

Before this thread, I was planning to construct and publish the
reverse mapping at the end of the day, but do so on a separate notes
ref (see above---the hacky abuse gets in the way of maintaining and
debugging the forward mapping, but a separate notes-ref that only
contains hacks is less worrysome).  But I have changed my mind and
decided not to generate or publish one.  It is sort of similar to
the way the pack .idx is constructed only by the receiver [*1*].

> Or is there some argument that there is information in the reverse map
> that _cannot_ be generated from the forward map?

I know there is no information loss (after all I was the only one
who ran that experimental hack), but there is one objection that is
still possible, even though I admit that is a weak argument.

If a plumbing "diff-{files,tree,index}" family had a sibling
"diff-notes" to compare two notes-shaped trees while pretending that
the object-name fan-out did not exist (i.e. instead, the trees being
compared is without a subtree and full of 40-hex filenames), then it
would be less cumbersome to incrementally update the reverse mapping
by reading forward mapping with something like:

	git diff-notes --raw amlog@{1} amlog

to learn the commits whose notes have changed.  But without such a
plumbing, it is cumbersome to do so correctly.  "git diff-tree -r"
could serve as a rough substitute, until the note tree grows and get
rebalanced by reorganizing the fan-out, and on the day it happens
the reverse mapper needs to read and discard ghost changes that are
only due to tree reorganizing [*2*].


[Footnotes]

*1* Even if the sender could give one when it creates a .pack, the
    receiver would not trust that it is matches the corresponding
    .pack before using it, and the cost to validate is similar to
    the cost to generate.

*2* That makes it less efficient on that day (which hopefully would
    happen once in a blue moon) but would not affect correctness.
