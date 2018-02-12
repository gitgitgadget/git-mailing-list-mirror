Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB731F576
	for <e@80x24.org>; Mon, 12 Feb 2018 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeBLHid (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 02:38:33 -0500
Received: from mail.javad.com ([54.86.164.124]:39719 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbeBLHic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 02:38:32 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 2430741B1D;
        Mon, 12 Feb 2018 07:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518421111;
        bh=e79/am2P4jqSy+L2rUlQ1xQaDBner8l5HtPD+8noZzU=; l=2577;
        h=Received:From:To:Subject;
        b=a18gtLD3WAJIbJMAqy7RfWtuXopqJ+0LZEeUgTY5RP2DTnlHwnZIYodIGTqkIn+ld
         qVCADlOzx2eZZZuXJxbm1Yd0gnrwdikq6KQzzqEibIqGI9fQQEH/K+JEvrVMffpRRu
         PG3g26GzetVODjG1eZcjyVoHHaiHydNs+HcU90GI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518421111;
        bh=e79/am2P4jqSy+L2rUlQ1xQaDBner8l5HtPD+8noZzU=; l=2577;
        h=Received:From:To:Subject;
        b=a18gtLD3WAJIbJMAqy7RfWtuXopqJ+0LZEeUgTY5RP2DTnlHwnZIYodIGTqkIn+ld
         qVCADlOzx2eZZZuXJxbm1Yd0gnrwdikq6KQzzqEibIqGI9fQQEH/K+JEvrVMffpRRu
         PG3g26GzetVODjG1eZcjyVoHHaiHydNs+HcU90GI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518421111;
        bh=e79/am2P4jqSy+L2rUlQ1xQaDBner8l5HtPD+8noZzU=; l=2577;
        h=Received:From:To:Subject;
        b=a18gtLD3WAJIbJMAqy7RfWtuXopqJ+0LZEeUgTY5RP2DTnlHwnZIYodIGTqkIn+ld
         qVCADlOzx2eZZZuXJxbm1Yd0gnrwdikq6KQzzqEibIqGI9fQQEH/K+JEvrVMffpRRu
         PG3g26GzetVODjG1eZcjyVoHHaiHydNs+HcU90GI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518421111;
        bh=e79/am2P4jqSy+L2rUlQ1xQaDBner8l5HtPD+8noZzU=; l=2577;
        h=Received:From:To:Subject;
        b=a18gtLD3WAJIbJMAqy7RfWtuXopqJ+0LZEeUgTY5RP2DTnlHwnZIYodIGTqkIn+ld
         qVCADlOzx2eZZZuXJxbm1Yd0gnrwdikq6KQzzqEibIqGI9fQQEH/K+JEvrVMffpRRu
         PG3g26GzetVODjG1eZcjyVoHHaiHydNs+HcU90GI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518421111;
        bh=e79/am2P4jqSy+L2rUlQ1xQaDBner8l5HtPD+8noZzU=; l=2577;
        h=Received:From:To:Subject;
        b=a18gtLD3WAJIbJMAqy7RfWtuXopqJ+0LZEeUgTY5RP2DTnlHwnZIYodIGTqkIn+ld
         qVCADlOzx2eZZZuXJxbm1Yd0gnrwdikq6KQzzqEibIqGI9fQQEH/K+JEvrVMffpRRu
         PG3g26GzetVODjG1eZcjyVoHHaiHydNs+HcU90GI=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1el8h3-0008SO-6S; Mon, 12 Feb 2018 10:38:29 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <87k1vpqq85.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87o9kyitf7.fsf@javad.com>
        <ec5c7aa2-b36b-aca8-d82f-9d131ac83b41@kdbg.org>
Date:   Mon, 12 Feb 2018 10:38:29 +0300
In-Reply-To: <ec5c7aa2-b36b-aca8-d82f-9d131ac83b41@kdbg.org> (Johannes Sixt's
        message of "Fri, 9 Feb 2018 08:13:07 +0100")
Message-ID: <87a7wed5e2.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 09.02.2018 um 07:11 schrieb Sergey Organov:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>> Let me explain the scenario which comes up plenty of times in my work with
>>> Git for Windows. We have a thicket of some 70 branches on top of git.git's
>>> latest release. These branches often include fixup! and squash! commits
>>> and even more complicated constructs that rebase cannot handle at all at
>>> the moment, such as reorder-before! and reorder-after! (for commits that
>>> really need to go into a different branch).
>>
>> I sympathize, but a solution that breaks even in simple cases can't be
>> used reliably to solve more complex problems, sorry. Being so deep
>> into your problems, I think you maybe just aren't seeing forest for the
>> trees [1].
>
> Hold your horses! Dscho has a point here. --preserve-merges
> --first-parent works only as long as you don't tamper with the side
> branches. If you make changes in the side branches during the same
> rebase operation, this --first-parent mode would undo that change.

He has a point indeed, but it must not be used as an excuse to silently
damage user data, as if there are no other options!

Simple --first-parent won't always fit, it's obvious. I used
--first-parent patch as mere illustration of concept, it's rather
"rebase [-i] --keep-the-f*g-shape" itself that should behave. There
should be no need for actual --first-parent that only fits
no-manual-editing use-cases.

Look at it as if it's a scale where --first-parent is on one side, and
"blind re-merge" is on the other. The right answer(s) lie somewhere
in-between, but I think they are much closer to --first-parent than they
are to "blind re-merge".

> (And, yes, its result would be called an "evil merge", and that scary
> name _should_ frighten you!)

(It won't always be "evil merge", and it still doesn't frighten even if
it will, provided git stops making them more evil then they actually
deserve, and it isn't an excuse to silently distort user data anyway!)

-- Sergey

[1] The "--first-parent" here would rather keep that change from
propagation to the main-line, not undo it, and sometimes it's even the
right thing to do ("-x ours" for the original merge being one example).
Frequently though it is needed on main-line indeed, and there should be
a way to tell git to propagate the change to the main-line, but even
then automatic blind unattended re-merge is wrong answer and I'm sure
git can be made to do better than that.
