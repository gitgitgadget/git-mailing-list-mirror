Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4431FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 06:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbcFYG24 (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 02:28:56 -0400
Received: from [104.236.5.163] ([104.236.5.163]:44146 "EHLO brennie.ca"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbcFYG24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2016 02:28:56 -0400
Received: from [192.168.1.38] (142-165-34-81.sktn.hsdb.sasknet.sk.ca [142.165.34.81])
	by brennie.ca (Postfix) with ESMTPSA id 89EAF400DC;
	Sat, 25 Jun 2016 00:28:54 -0600 (CST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
From:	Barret Rennie <barret@brennie.ca>
In-Reply-To: <xmqq60sxeqr4.fsf@gitster.mtv.corp.google.com>
Date:	Sat, 25 Jun 2016 00:28:53 -0600
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <58A7F9CA-05A1-4BD1-A664-5B8302BFDE2F@brennie.ca>
References: <20160625051548.95564-1-barret@brennie.ca> <xmqq60sxeqr4.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is really to scratch an itch I have when I break my worktrees and can’t figure out which worktree dir is the one I’ve broken. For example, I organize my code as follows:

projects/reviewboard/branches/<branch-name>/src/
	django/
	djblets/  
	reviewboard/

for each release branch I maintain (4 or 5 of them), where each of the above is a worktree checkout of the correct branch. This is so I have all my dependencies for the project at the right development version.

However, when I inevitably break a worktree for, e.g., Review Board, I have to figure out which of reviewboard, reviewboard1, reviewboard2, etc. it is that I’ve broken, instead of being able to just go into the worktree named for the release branch.

Hope this clarifies things.

> On Jun 25, 2016, at 12:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Barret Rennie <barret@brennie.ca> writes:
> 
>> Add the --name parameter to git worktree add that allows the user to set
>> the name of the created worktree directory. A worktree must not already
>> exist with the current name or creation will fail.
> 
> Hmph.  This strongly smells like "because we can add this feature",
> not "because we need to add this feature".
> 
> What problem does it solve?  Please do not give me "currently we
> cannot give a name and instead live with the automatically given
> one, and with this patch we can give arbitrary name" as the answer.
> That is what I called "because we can".  Why is it bad that you have
> to live with the name automatically given to your new worktree?

