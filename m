Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C52501FF40
	for <e@80x24.org>; Mon, 27 Jun 2016 05:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbcF0FwI (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 01:52:08 -0400
Received: from [104.236.5.163] ([104.236.5.163]:44776 "EHLO brennie.ca"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbcF0FwG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 01:52:06 -0400
Received: from [192.168.1.38] (142-165-34-81.sktn.hsdb.sasknet.sk.ca [142.165.34.81])
	by brennie.ca (Postfix) with ESMTPSA id DFEF440384;
	Sun, 26 Jun 2016 23:52:04 -0600 (CST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
From:	Barret Rennie <barret@brennie.ca>
In-Reply-To: <CAPig+cRNUZZBw=F-Q2f3Ehc-8T2iBp4kvDusNRGv4ea5nihQVQ@mail.gmail.com>
Date:	Sun, 26 Jun 2016 23:52:03 -0600
Cc:	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Git List <git@vger.kernel.org>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= 
	<pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A2F194FC-281D-44DF-88CA-E0B8221A3E68@brennie.ca>
References: <20160625051548.95564-1-barret@brennie.ca> <576E2FA9.7070008@kdbg.org> <1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca> <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com> <CAPig+cRNUZZBw=F-Q2f3Ehc-8T2iBp4kvDusNRGv4ea5nihQVQ@mail.gmail.com>
To:	Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On Jun 26, 2016, at 5:00 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> 
> On Sat, Jun 25, 2016 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> [...snip...]
>> And explained that way, it becomes clearer that you would want to
>> name $HOME/xyzzy-1/frotz worktree after "topic-1", not the default
>> name you would get "frotz" (because the default gives you the leaf
>> level name of the newly created worktree).
>> 
>> After the discussion above (which may or may not match what you
>> raised this topic for), I think a feature to let you override the
>> default name makes sense.
> 
> One thing which hasn't been explained, and about which I'm still
> confused even after reading this thread in its entirety, is what
> Barret means when he says that he "breaks" his worktrees. What is the
> nature of this breakage? Depending upon that answer, would "git
> rev-parse --git-dir" be sufficient for your needs? Or, would "git
> worktree list" be able to give you the desired information? (As
> envisioned, "git worktree list" was intended to provide much more
> information than it currently does, such as the .git/worktree dir
> name, and such an enhancement might be welcome.)

My worktree breakages are usually the result of my reorganizing my projects,
usually because a branch changes name (for example, if branch release-1 gets
pushed back to release-2). Then I go and rename all my directories and git 
gets unhappy and I have to manually fix them or re-create the worktrees.

Having `git worktree list` give the worktree directory would be very useful,
but I still would like the ability to change the name of a worktree.
