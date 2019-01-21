Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D141F453
	for <e@80x24.org>; Mon, 21 Jan 2019 15:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfAUPPT (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 10:15:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:49329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbfAUPPS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 10:15:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPppG-1gqZMk4AfS-0054v1; Mon, 21
 Jan 2019 16:15:09 +0100
Date:   Mon, 21 Jan 2019 16:14:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matthew Kraai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH 1/1] stash: fix segmentation fault when files were added
 with intent
In-Reply-To: <xmqq5zulk88e.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901211556150.41@tvgsbejvaqbjf.bet>
References: <pull.110.git.gitgitgadget@gmail.com>        <b5bbc7793c50991c7cb5a5188f53ccc3a14b23f6.1547805015.git.gitgitgadget@gmail.com> <xmqq5zulk88e.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TyYyXnVPbkdGgVoUc2wMYJ7L5lDgu9/JVSBvofnDs8VYQU66CIO
 37ODQRxro4rU85mEaobfvoiGMpYBTNKCfPn27oN5ddJjICoS7k2fPwr1pGFyC7LQ5XRN0YZ
 ck9uP3QNuQ9KTFFHeQMWATN7NxOd36QmT+12h9/ldqmBnDgaDugN+yLJ/8khramoySWEmrM
 eJlSXKlQTG8FvHfM89+5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eOayR+70lrI=:l5lOvbsZNgnYuaY0BpyWcB
 RmLNUriADkK/53gmUtYuHivXJq4tF00JK+28952XPPPfdujJJT0iohu8N6rppIaHIlXQhXxeq
 V583/GdZhH+JA4OvnW+QM80JJXK5svE7eK/QgSyaQSxQhgZD1PR3MIIu6egizcbBkuHzrVbXi
 ctZBY4KyxgmcEMXs4gaPmyLvrmkMMzFIQbSczGNHVZfMDj3WHzqEzOSNEr5kJNf7tXzWqcc3H
 4UphNzg8mTGFs6fGCHCuC1eC0MKuccApiOT90rSAiMZdWoucSLejBpjfs7HAYS/yrjm+irMNn
 z7xZWiyFHDWKqxxV7JHD1+8uz5L1Y5hhgYSytSnhGgQNUF5hYrViCZt6DWon1aMT5LGYH7/Kn
 PWZvB6owH2GddPCJgNyk0rW8WN0ykFtOEBL5WY6+T3m17tlodFK3my2TnJehxULrV5eEY9szC
 cHkrVKuQurJGvXwxUTV81w9IncR4psg+anbdM/YjcPXhgX5quEcJfPF2FwL0kvPP3V2mCrllJ
 CwZwoeUs9lCAmJjogssWhMeSJwr8GBhXTgksmUe7rR0lwFEkFccOnX8210k1Hu1dGMWr3nCez
 LPdH8h2wo+xIIKEh+7aKbOdG1wBVNojIrHS88vLuT7Ckm7f/6Y4fI2MITR1kwFFRtPi6RnyCx
 t4GDfi0rgDDh117kUD7LrTeBrQQG8ObC5pq90YwUP/+BztNbnVwzUvWyhW4cksnfSzo8EMSdM
 uyzEn3N299MEFccz9PlW1qZjFF/XmxIcsWUysTK8OfKq9COv/1ciIYM3U/p0vNYiRWdmCoYpm
 B7IETTeW+UUzL/53ZRyjVIETxF7XwuMYwaLN1ZDgD3KAUBYG0NQz8xS0Gi3XNaGgd1PBrG7Un
 Pojii8WHU7wo23wJoXBhdLwpcOot6NmmlBS0vj1WCywoJ32bA5VzvXOia6bt35MljMjKJgJfU
 U8JyI+5lfEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 18 Jan 2019, Junio C Hamano wrote:

> "Matthew Kraai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Matthew Kraai <mkraai@its.jnj.com>
> >
> > After `git add -N <file>`, the index is in a special state. A state for
> > which the built-in stash was not prepared, as it failed to initialize
> > the `rev` structure in that case before using `&rev.pending`.
> >
> > Detailed explanation: If `reset_tree()` returns a non-zero value,
> > `stash_working_tree()` calls `object_array_clear()` with `&rev.pending`.
> > If `rev` is not initialized, this causes a segmentation fault.
> 
> It is a bit strange that the paragraph for "detailed explanation" is
> shorter than the paragraph it attempts to clarify.
> 
> Dropping those two words "Detailed explanation:" easily fixes
> awkwardness ;-).

If you must.

For me, it is not the quantity, but the quality of the words that makes it
a detailed explanation. You see, as a mathematician, I can give you a very
condensed, super detailed, complicated proof for many a lemma which is
substantially shorter than the understandable, English explanation that
I would want to give to non-mathematicians.

Likewise, if you take a step back, and try to forget for a moment that you
are very familiar with Git's source code, you will without any doubt
*have* to admit that the detailed explanation requires a *lot* of
knowledge already, while the paragraph before that does not.

So if you find that awkward, I respectfully disagree. And if you insist on
removing those "two words" (to make the paragraph *even* shorter, which is
apparently something you took exception with), I have no tools to stop
you.

Just let it be known that it is against the wish of the author of those
lines.

> > +test_expect_success 'stash --intent-to-add file' '
> > +	git reset --hard &&
> > +	echo new >file4 &&
> > +	git add --intent-to-add file4 &&
> > +	test_when_finished "git rm -f file4" &&
> > +	test_must_fail git stash
> > +'
> 
> This still must fail because an index with an I-T-A cannot be
> included in a stash, but test_must_fail will make sure that the
> command does not suffer an uncontrolled crash.  Good.

Indeed. And Matthew even adopted your preferred strategy of combining the
demonstration of the bug with the fix. In the meantime, I have found the
totally intuitive (and equally documented) command line that I can use
when I want to see whether a given branch is buggy and when I cannot
simply `git cherry-pick <commit-demonstrating-a-bug>`:

	git cherry-pick <commit-fixing-the-bug-and-adding-a-test>
	git checkout HEAD^ -- :^/t/

Ciao,
Johannes
