Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223BF2018A
	for <e@80x24.org>; Wed, 29 Jun 2016 04:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbcF2EpM (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 00:45:12 -0400
Received: from [104.236.5.163] ([104.236.5.163]:45037 "EHLO brennie.ca"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbcF2EpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 00:45:09 -0400
Received: from [192.168.1.38] (142-165-34-81.sktn.hsdb.sasknet.sk.ca [142.165.34.81])
	by brennie.ca (Postfix) with ESMTPSA id 275AC40326;
	Tue, 28 Jun 2016 22:45:07 -0600 (CST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
From:	Barret Rennie <barret@brennie.ca>
In-Reply-To: <CAPig+cSEwib1iFyWE5h8-qTbsAC+zsaSDSYQnv6otWoOOjWAeA@mail.gmail.com>
Date:	Tue, 28 Jun 2016 22:45:05 -0600
Cc:	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Git List <git@vger.kernel.org>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= 
	<pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <89E234AF-9498-4425-812B-BB0DED4216DA@brennie.ca>
References: <20160625051548.95564-1-barret@brennie.ca> <576E2FA9.7070008@kdbg.org> <1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca> <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com> <CAPig+cRNUZZBw=F-Q2f3Ehc-8T2iBp4kvDusNRGv4ea5nihQVQ@mail.gmail.com> <A2F194FC-281D-44DF-88CA-E0B8221A3E68@brennie.ca> <CAPig+cSEwib1iFyWE5h8-qTbsAC+zsaSDSYQnv6otWoOOjWAeA@mail.gmail.com>
To:	Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On Jun 27, 2016, at 5:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> 
> [snip]
> 
> My knee-jerk reaction is that the directory name under .git/worktrees
> is an implementation detail (and could easily have been an arbitrary
> ID, such as .git/worktrees/7ba84ec0) and rather than exposing it
> further and encouraging people to muck around in it manually, we
> should be providing higher-level solutions so that they don't have to.
> 
> Even without the higher-level solutions, it seems like "git rev-parse
> --git-dir" should satisfy your needs, and if someone enhances "git
> worktree list" to provide the additional worktree tag name (as
> envisioned all along), then you'd likewise have sufficient information
> to "fix" your worktrees.
> 
> As an example of higher-level solutions, Duy's "git worktree move"
> series[1] would, I think, be exactly what you need to avoid such
> breakage in the first place (assuming you can retrain your fingers or
> fix your scripts, if they are doing the worktree renaming).
> 
> I don't know how Duy and Junio feel about it, but my response to this
> patch and what it wants to accomplish (even with Junio's input) is
> fairly negative. I'd much rather see more missing high-level worktree
> features implemented rather than see patches further exposing
> git-worktree's internals.
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/298194
Yes, it does seem like `git worktree move` will  solve all my issues and
is a much more elegant solution. Thanks for pointing it out to me and
looking at this patch.

I may write a patch to print out the worktree tag name instead and submit
that later.

Regards,
Barret Rennie
