Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A3C20193
	for <e@80x24.org>; Thu, 27 Oct 2016 20:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964999AbcJ0UnX (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 16:43:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38860 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031177AbcJ0Ula (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 16:41:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A72F920193;
        Thu, 27 Oct 2016 20:41:29 +0000 (UTC)
Date:   Thu, 27 Oct 2016 20:41:29 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161027204129.GA21619@starla>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I know you are a fan of testing things thoroughly in the test suite, but I
> have to say that it is getting out of hand, in particular due to our
> over-use of shell script idioms (which really only run fast on Linux, not
> a good idea for a portable software).

How much effort would it take to optimize a /bin/sh?

Would replacing uses of fork+execve posix_spawn be fast and
portable enough?

Even on Linux, performance sucks for me.  I've been hoping dash
can use posix_spawn (or using vfork directly) to see if that can
help things.

That won't help with subshells, though...

(I'm back to using a Centrino laptop from 2005)
