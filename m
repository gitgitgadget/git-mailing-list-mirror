Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83ACE1FAE3
	for <e@80x24.org>; Tue, 13 Mar 2018 06:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeCMGZe (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 02:25:34 -0400
Received: from mail.javad.com ([54.86.164.124]:34663 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbeCMGZd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 02:25:33 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id C4D503E96B;
        Tue, 13 Mar 2018 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520922332;
        bh=Dk+wRumZOIaEr3bOeNl8LGdCUOKC/3/OZdJ7F3C/upw=; l=2595;
        h=Received:From:To:Subject;
        b=BwhhAcueFpeytNz4a277jc/mLOJsw4BT+YnNGOuclpZSRlwUobGZp5WSHHwpx6Azn
         ExjChgKY3zBJ4lZo1gUoTCjPUcBp8ZlH42nEgSo8cSbJDT1WG4dFKcNQ/BdDcKL+UT
         dwvaNShW9nmHOXowqe6xu+Fu9yLKWwuquzJUsGnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520922332;
        bh=Dk+wRumZOIaEr3bOeNl8LGdCUOKC/3/OZdJ7F3C/upw=; l=2595;
        h=Received:From:To:Subject;
        b=BwhhAcueFpeytNz4a277jc/mLOJsw4BT+YnNGOuclpZSRlwUobGZp5WSHHwpx6Azn
         ExjChgKY3zBJ4lZo1gUoTCjPUcBp8ZlH42nEgSo8cSbJDT1WG4dFKcNQ/BdDcKL+UT
         dwvaNShW9nmHOXowqe6xu+Fu9yLKWwuquzJUsGnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520922332;
        bh=Dk+wRumZOIaEr3bOeNl8LGdCUOKC/3/OZdJ7F3C/upw=; l=2595;
        h=Received:From:To:Subject;
        b=BwhhAcueFpeytNz4a277jc/mLOJsw4BT+YnNGOuclpZSRlwUobGZp5WSHHwpx6Azn
         ExjChgKY3zBJ4lZo1gUoTCjPUcBp8ZlH42nEgSo8cSbJDT1WG4dFKcNQ/BdDcKL+UT
         dwvaNShW9nmHOXowqe6xu+Fu9yLKWwuquzJUsGnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520922332;
        bh=Dk+wRumZOIaEr3bOeNl8LGdCUOKC/3/OZdJ7F3C/upw=; l=2595;
        h=Received:From:To:Subject;
        b=BwhhAcueFpeytNz4a277jc/mLOJsw4BT+YnNGOuclpZSRlwUobGZp5WSHHwpx6Azn
         ExjChgKY3zBJ4lZo1gUoTCjPUcBp8ZlH42nEgSo8cSbJDT1WG4dFKcNQ/BdDcKL+UT
         dwvaNShW9nmHOXowqe6xu+Fu9yLKWwuquzJUsGnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520922332;
        bh=Dk+wRumZOIaEr3bOeNl8LGdCUOKC/3/OZdJ7F3C/upw=; l=2595;
        h=Received:From:To:Subject;
        b=BwhhAcueFpeytNz4a277jc/mLOJsw4BT+YnNGOuclpZSRlwUobGZp5WSHHwpx6Azn
         ExjChgKY3zBJ4lZo1gUoTCjPUcBp8ZlH42nEgSo8cSbJDT1WG4dFKcNQ/BdDcKL+UT
         dwvaNShW9nmHOXowqe6xu+Fu9yLKWwuquzJUsGnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520922332;
        bh=Dk+wRumZOIaEr3bOeNl8LGdCUOKC/3/OZdJ7F3C/upw=; l=2595;
        h=Received:From:To:Subject;
        b=BwhhAcueFpeytNz4a277jc/mLOJsw4BT+YnNGOuclpZSRlwUobGZp5WSHHwpx6Azn
         ExjChgKY3zBJ4lZo1gUoTCjPUcBp8ZlH42nEgSo8cSbJDT1WG4dFKcNQ/BdDcKL+UT
         dwvaNShW9nmHOXowqe6xu+Fu9yLKWwuquzJUsGnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520922332;
        bh=Dk+wRumZOIaEr3bOeNl8LGdCUOKC/3/OZdJ7F3C/upw=; l=2595;
        h=Received:From:To:Subject;
        b=BwhhAcueFpeytNz4a277jc/mLOJsw4BT+YnNGOuclpZSRlwUobGZp5WSHHwpx6Azn
         ExjChgKY3zBJ4lZo1gUoTCjPUcBp8ZlH42nEgSo8cSbJDT1WG4dFKcNQ/BdDcKL+UT
         dwvaNShW9nmHOXowqe6xu+Fu9yLKWwuquzJUsGnk=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1evdNK-0002Ic-34; Tue, 13 Mar 2018 09:25:30 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com> <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
        <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
        <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com>
        <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com>
        <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <77b695d0-7564-80d7-d9e6-70a531e66eda@gmail.com>
Date:   Tue, 13 Mar 2018 09:25:30 +0300
In-Reply-To: <77b695d0-7564-80d7-d9e6-70a531e66eda@gmail.com> (Igor
        Djordjevic's message of "Tue, 13 Mar 2018 00:54:57 +0100")
Message-ID: <87r2oocx0l.fsf@javad.com>
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

> I don`t know, I`m thinking if we are looking at todo list from
> different perspectives - to you, it seems to be a sequence of
> commands to create something new (yes, from something that already
> exists, but that`s implementation detail). In that context, using
> `merge` might have sense (even if still being a very special merge).
>
> But to me, as we already have `pick` and not `commit` to rebase
> commits, it means we are not creating but rather reusing what we have
> (being an important concept to reason about), thus `pick` would still
> fit in for picking a merge commit just nicely, and more naturally,
> too.

Exactly.

Fundamentally, a good editing tool should first be able to just safely
reproduce back what it got, only then everything else goes.

From this follows that git history-editing tool should start from sound
history representation, i.e., some text representation of the DAG that
allows to re-create the DAG back.

The simplest way is to just list all the nodes in some topological
order, along with references to the parents. Then, to simplify the list,
first parent, unless explicitly specified, could be assumed to be the
preceding item in the list.

Next, we actually need _to do_ something with this, so we convert this
to a _todo_ list by prepending action to each element of the list (isn't
it Lisp once again?). Let the action be called 'pick'. Then, e.g., the
piece of history:

           B1-------B2
          /           \
 S--M0---M1---- M2 ----M3 -- M4

from M0 to M4 will be represented like this:

skip S          # Just to have a handy reference
pick M0         # Implicit first parent (S)
pick M1         # Implicit first parent (M0)
pick M2         # Implicit first parent (M1)
pick B1 M1      # Explicit first parent
pick B2         # Implicit first parent (B1)
pick M3 M2 B2   # Explicit first and second parents
pick M4

Which basically gets us back to what you are advocating.

Here is another variant, using command options to specify parents (I
also exchanged order of branch and mainline):

skip S          # To have the base reference handy
pick M0         # Implicit first parent (S)
pick B1         # Implicit first parent (M0)
pick B2         # Implicit first parent (B1)
pick M1 -1 M0   # Explicit first parent M0
pick M2         # Implicit first parent (M1)
pick M3 -2 B2   # Implicit first parent (M2) and
                # explicit second parent B2
pick M4         # Implicit first parent (M3)

I like this one even better.

IMHO, this is indeed a good starting point. No special treatment for
merges is needed so far.

-- Sergey
