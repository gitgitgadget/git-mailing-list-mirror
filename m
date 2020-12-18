Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA20C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9378723A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgLRFuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:50:35 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:39160 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgLRFuf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:50:35 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kq8eG-004X5K-AQ; Thu, 17 Dec 2020 22:49:52 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1kq8eF-0007NM-EV; Thu, 17 Dec 2020 22:49:52 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 1D81A1280F30;
        Thu, 17 Dec 2020 22:49:51 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NcKFLEpipsB0; Thu, 17 Dec 2020 22:49:51 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id B958C128058D;
        Thu, 17 Dec 2020 22:49:49 -0700 (MST)
Date:   Thu, 17 Dec 2020 22:49:47 -0700
From:   Seth House <seth@eseth.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <20201218054947.GA123376@ellen>
References: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fdc18a91c402_f2faf20837@natae.notmuch>
X-XM-SPF: eid=1kq8eF-0007NM-EV;;;mid=<20201218054947.GA123376@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 17, 2020 at 08:49:13PM -0600, Felipe Contreras wrote:
> And no person is the sole arbiter of truth, in this list, or anywhere.
> People have managed to change Junio's mind.

I'm not worried about Junio but I am wondering if anyone has managed to
change your mind. You and I have been going back and forth on this list
and on Reddit for two solid days and, to be frank, I'm running out of
steam.

> You said you would provide a list of tools that would be affected.

No, I said I would provide a list of before/after screenshots so people
in this thread that haven't been following the entire discussion can
more easily see the differences and benefits of this change.

I can't speak for the preferences of all the mergetool authors out there
but I will try to convince you of the merit of adding a configuration
flag in two places instead of just one. This took me a long time to
write; I would appreciate it if you read it slowly and carefully.

There are three broad classifications of mergetools that I've seen so
far. I've only collected notes for seventeen of them but there are many,
many others. I mentioned those classifications earlier in this thread
but to repeat them here:

1.  Tools that ignore conflict resolution and simply diff LOCAL and
    REMOTE. This accounts for most of them.
2.  Tools that perform their own, internal conflict resolution. Examples
    are tkdiff, WinMerge, IntelliJ.
3.  Tools that reuse Git's conflict resolution by splitting MERGED.
    Examples are Emacs + Magit, vim-mergetool, diffconflicts.

This patch *will* (probably) always benefit the first group. Because
this patch *overwrites* LOCAL and REMOTE those tools will see immediate
benefit without having to make any changes at all.

This patch *may* benefit the second group, or it may not affect them at
all, or they may want it off. If they keep it on they will run conflict
resolution against files that have already undergone that process in Git
and likely turn up no additional resolutions since Git is quite good at
doing that. It is also possible that some of them may do a better job
than Git, or that some of them may want Git to tackle some of the
conflict resolution (things that require access to the file history such
as renames or recursive parents), but also want to perform even more
sophisticated conflict resolution on top of that. Some of those tools
are very clever and innovation in this space is still happening.

This patch *may* benefit the third group or it may make them no longer
necessary. Speaking as the author of one of them: I see that as a good
thing.

This patch *may* prevent tools in the second and third groups from
having all the information they desire to show users without also
running additional Git commands. Because this patch *overwrites* LOCAL
and REMOTE any tool that wishes to show the state of the file before the
merge was started will need to use Git to generate a new copy of those
files. Although this is a negative I think benefiting the large number
of tools in the first group outweighs this negative. Because the second
and third groups of tools are more sophisticated, I think the authors of
those tools are better suited to navigating these pros and cons.

In closing, below are several use-cases for having both a tool-level
flag and a global flag:

I, as the author of diffconflicts, *will* want to disable this flag for
diffconflicts because that tool already does what this flag does *and*
because that tool makes use of the original versions of LOCAL and
REMOTE which this patch destroys.

I, as a user of diffconflicts, *may* want to disable this flag because
in practice I don't actually reference LOCAL and REMOTE very often.
Other users may reference LOCAL and REMOTE every time. You yourself
said, "Even if I were using diffconflict, I would want this option on."
Other users may choose differently than you because you are also not the
"sole arbiter of truth" and because this is entirely about personal
preference and is decidedly not about objective truth. If this patch
always benefited everyone then we would make it default and not put it
behind an opt-in flag.

I, as a user of diffconflicts, may want to both disable this flag for
diffconflicts but enable this flag for VS Code and kdiff3. It is not
unusual for people to use more than one mergetool. Some of them are
better or worse at visualizing different kinds of conflicts. Sometimes
a conflict is small and straightforward; othertimes a conflict is
complicated and requires deep knowledge of the history of both branches.
If we force this to be a global flag only then users will not be able to
make different choices for different tools.

Someone who does use multiple mergetools but only uses tools from group
one may appreciate a single global flag so s/he doesn't need to set it
for each tool.

Someone who is actively developing a new mergetool may want to enable or
disable this flag for that tool while still keeping the flag enabled or
disabled for tools that s/he uses for work or school. Someone who is
comparing and contrasting multiple mergetools for work or school may
want to selectively enable or disable the flag for one tool or another
in order to do the comparison. Someone may want the same mergetool
configured twice, once with this flag and once without, in order to
contrast the difference.

An end-user may want to use a mergetool differently than the author
intended. You said, "This should be a setting in the tool driver, not
a user-visible setting," and then you said, "Even if I were using
diffconflict, I would want this option on." But I said, "I, as the
author of diffconflicts, *will* want to disable this flag." and there's
no reason we can't have both. I can't presume what preference other
mergetool authors will have. We can make some educated guesses and even
default the option to true for some mergetool wrappers that ship with
Git but there's every possibility that a user will prefer it a different
way or that a mergetool author will. And there's every possibility that
there will be differing opinions between users and authors like there is
between you and me. But that's ok! Because it's just a configuration
option.

