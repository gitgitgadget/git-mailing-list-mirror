Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB10B1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 12:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeCLMFI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 08:05:08 -0400
Received: from mail.javad.com ([54.86.164.124]:41964 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeCLMFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 08:05:07 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 816B33E896;
        Mon, 12 Mar 2018 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520856306;
        bh=r7B+uVLAHplyruijeiVoeYWIJ2bvDwyOqRIuTxa2i9w=; l=3689;
        h=Received:From:To:Subject;
        b=rK9JZOSWiicMt8DO5u+2+1nwl+0wacrLnSBCkHKRHa5uoayHV3JreGMbezd/7bLF3
         AuSx/AsaJ01VKXCt3df9t4LbmzJkp+aT6CX/lvmx1eih3mwLLf8/ZE+pJjuaUHn5oo
         ElYuWRuh6u6l88S8ne3l4WT1rvGp7ltQ7vdjJOtM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520856306;
        bh=r7B+uVLAHplyruijeiVoeYWIJ2bvDwyOqRIuTxa2i9w=; l=3689;
        h=Received:From:To:Subject;
        b=rK9JZOSWiicMt8DO5u+2+1nwl+0wacrLnSBCkHKRHa5uoayHV3JreGMbezd/7bLF3
         AuSx/AsaJ01VKXCt3df9t4LbmzJkp+aT6CX/lvmx1eih3mwLLf8/ZE+pJjuaUHn5oo
         ElYuWRuh6u6l88S8ne3l4WT1rvGp7ltQ7vdjJOtM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520856306;
        bh=r7B+uVLAHplyruijeiVoeYWIJ2bvDwyOqRIuTxa2i9w=; l=3689;
        h=Received:From:To:Subject;
        b=rK9JZOSWiicMt8DO5u+2+1nwl+0wacrLnSBCkHKRHa5uoayHV3JreGMbezd/7bLF3
         AuSx/AsaJ01VKXCt3df9t4LbmzJkp+aT6CX/lvmx1eih3mwLLf8/ZE+pJjuaUHn5oo
         ElYuWRuh6u6l88S8ne3l4WT1rvGp7ltQ7vdjJOtM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520856306;
        bh=r7B+uVLAHplyruijeiVoeYWIJ2bvDwyOqRIuTxa2i9w=; l=3689;
        h=Received:From:To:Subject;
        b=rK9JZOSWiicMt8DO5u+2+1nwl+0wacrLnSBCkHKRHa5uoayHV3JreGMbezd/7bLF3
         AuSx/AsaJ01VKXCt3df9t4LbmzJkp+aT6CX/lvmx1eih3mwLLf8/ZE+pJjuaUHn5oo
         ElYuWRuh6u6l88S8ne3l4WT1rvGp7ltQ7vdjJOtM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520856306;
        bh=r7B+uVLAHplyruijeiVoeYWIJ2bvDwyOqRIuTxa2i9w=; l=3689;
        h=Received:From:To:Subject;
        b=rK9JZOSWiicMt8DO5u+2+1nwl+0wacrLnSBCkHKRHa5uoayHV3JreGMbezd/7bLF3
         AuSx/AsaJ01VKXCt3df9t4LbmzJkp+aT6CX/lvmx1eih3mwLLf8/ZE+pJjuaUHn5oo
         ElYuWRuh6u6l88S8ne3l4WT1rvGp7ltQ7vdjJOtM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520856306;
        bh=r7B+uVLAHplyruijeiVoeYWIJ2bvDwyOqRIuTxa2i9w=; l=3689;
        h=Received:From:To:Subject;
        b=rK9JZOSWiicMt8DO5u+2+1nwl+0wacrLnSBCkHKRHa5uoayHV3JreGMbezd/7bLF3
         AuSx/AsaJ01VKXCt3df9t4LbmzJkp+aT6CX/lvmx1eih3mwLLf8/ZE+pJjuaUHn5oo
         ElYuWRuh6u6l88S8ne3l4WT1rvGp7ltQ7vdjJOtM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520856306;
        bh=r7B+uVLAHplyruijeiVoeYWIJ2bvDwyOqRIuTxa2i9w=; l=3689;
        h=Received:From:To:Subject;
        b=rK9JZOSWiicMt8DO5u+2+1nwl+0wacrLnSBCkHKRHa5uoayHV3JreGMbezd/7bLF3
         AuSx/AsaJ01VKXCt3df9t4LbmzJkp+aT6CX/lvmx1eih3mwLLf8/ZE+pJjuaUHn5oo
         ElYuWRuh6u6l88S8ne3l4WT1rvGp7ltQ7vdjJOtM=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1evMCN-0001Hg-VF; Mon, 12 Mar 2018 15:05:04 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae8yq15.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
        <nycvar.QRO.7.76.6.1803111324390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <d18a6e73-ce6f-b4aa-8ead-7aaabddf454d@gmail.com>
Date:   Mon, 12 Mar 2018 15:05:03 +0300
In-Reply-To: <d18a6e73-ce6f-b4aa-8ead-7aaabddf454d@gmail.com> (Igor
        Djordjevic's message of "Sun, 11 Mar 2018 23:04:27 +0100")
Message-ID: <87zi3dh53k.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

[...]

> That said, *if* we decide we like temporary commit U1' == U2' consistency 
> check (especially for non-interactive rebase, maybe), we can produce 
> these after the fact for the sake of the check only.

I don't believe interactive vs. non-interactive split is actually
helpful. I'd consider non-interactive just a special case of interactive
when user didn't edit the todo list, nothing more. No special treatment
should be required.

For one, consistency checks in both modes has similar importance, even
if only because there could be parts of history being interactively
rebased which the user didn't intend to edit, nor actually edited during
given session.

Now let me get back to pros and cons of the two approaches to rebasing
merges we have. Below I still advocate my approach by further discussing
the differences, but simultaneously I'd like to emphasize that whatever
particular way of rebasing merges will finally be used, it will be a
huge step forward and I'm glad I've raised the issue in the first place.

First, please consider the fact that my "rebase sides" method has yet
another nice property: it reduces back to original "rebase the commit"
operation when you apply it to a non-merge commit. In other words, it's
true generalization on top of rebasing of simple commit.

OTOH, Phillip's approach, when reduced to non-merge commit, still does a
version of rebase, but very specific one, and in inverse manner. I.e.,
rather than merging changes of the commit to be rebased into the new
base, it merges changes introduced by the new base into the commit being
rebased.

One consequence is that when conflict occurs, Phillip's approach will
give surprising order of ours vs theirs changes, inverted with respect
to those of the usual rebase of non-merge commit, while my approach will
give exact non-merge commit semantics. It could likely be fixed by
slightly modifying Phillip's approach, but it will make its
implementation more complex.

Another consequence is that, provided my version is used, all options
that tune "simple commit rebase" behavior will automagically work for
rebasing merge commits, in exactly the same manner. OTOH, Phillip's
approach, without special attention in implementation, will do the same
thing no matter what -m -s, or -X options say.

Yet another consequence is that my approach will likely result in better
code reuse. Even though mine seems to be harder to implement stand-alone
than Phillip's one, it should be actually easier to implement inside the
"git rebase", as it will use exactly the same machinery that "git
rebase" already uses to rebase simple commits, adding only final "git
merge-recursive" (or "git merge-resolve", or "git merge-octopus", -- any
of them  will do the job), which current implementation already performs
as well, for re-creating merges from scratch.

Second thought, unrelated to the above. To me it seems that my "rebasing
sides" approach, being entirely symmetric, is cleaner than incremental
merging suggested by Phillip, as with my approach one will still deal
with branches independently, in the same way as for simple commits,
until the single final merge operation. This comes with drawback of 1
additional step in my approach when compared to the Phillip's one
though, but then mine has definitely no issues with the exact order of
merges.

Overall, to me it seems that unmodified Phillip's approach will bring
unnecessarily wide set of new user experiences, and fixing it will
require some tricks in implementation, for no apparent reason.

-- Sergey
