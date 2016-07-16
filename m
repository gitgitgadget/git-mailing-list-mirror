Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB642018F
	for <e@80x24.org>; Sat, 16 Jul 2016 21:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbcGPVE4 (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 17:04:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44678 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbcGPVEz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 17:04:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CBBD2018F;
	Sat, 16 Jul 2016 21:04:54 +0000 (UTC)
Date:	Sat, 16 Jul 2016 21:04:54 +0000
From:	Eric Wong <e@80x24.org>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
Message-ID: <20160716210454.GA7849@starla>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
 <FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FB76544F-16F7-45CA-9649-FD62EE44B0DE@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> wrote:
> > On 13 Jul 2016, at 18:56, Junio C Hamano <gitster@pobox.com> wrote:
> > * ew/http-walker (2016-07-12) 3 commits
> > - http-walker: reduce O(n) ops with doubly-linked list
> > - http: avoid disconnecting on 404s for loose objects
> > - http-walker: remove unused parameter from fetch_object
> > 
> > Optimize dumb http transport on the client side.
> 
> It looks like as if this topic breaks the OS X build because 
> it defines LIST_HEAD. LIST_HEAD is already defined in 
> /usr/include/sys/queue.h. 

Oops, I suppose GIT_LIST_HEAD is an acceptable name?
(looks a bit like a refname, though...).

Or maybe CDS_LIST_HEAD (since I originally took it from the cds
namespace under urcu)

I also wonder where we use sys/queue.h, since I use
LIST_HEAD from ccan/list/list.h in a different project
without conflicts...

> See: https://travis-ci.org/git/git/jobs/145121761

Is there a way to get plain-text logs?  No JavaScript, here.
Thanks.
