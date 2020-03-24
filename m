Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77427C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CD62076F
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCXWFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:05:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:49992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727496AbgCXWFd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 18:05:33 -0400
Received: (qmail 19933 invoked by uid 109); 24 Mar 2020 22:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Mar 2020 22:05:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29450 invoked by uid 111); 24 Mar 2020 22:15:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Mar 2020 18:15:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Mar 2020 18:05:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
Message-ID: <20200324220532.GA647727@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com>
 <20200323173258.GA3977@coredump.intra.peff.net>
 <20200323180445.GA31401@coredump.intra.peff.net>
 <xmqq8sjq6fob.fsf@gitster.c.googlers.com>
 <20200323201547.GA35429@coredump.intra.peff.net>
 <xmqqzhc63gmd.fsf@gitster.c.googlers.com>
 <20200323213109.GA44297@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003242239300.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003242239300.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 10:41:58PM +0100, Johannes Schindelin wrote:

> > The thing I was more worried about is that it's technically a behavior
> > change to set up GNUPGHOME when we're not going to use it (as well as
> > create the directory). But I find it hard to imagine a test that would
> > be affected where my suggested solution wouldn't be "fix the test".
> 
> It is _half_ a change in behavior: in case that `gpg` was found, and does
> not have a known-bad version, we set up the environment variable, _even
> if_ the test-signing fails. In other words, we don't roll back the
> environment variable.
> 
> As such, I figure that setting it globally _before_ even evaluating the
> prereq is okay.
> 
> Therefore, it is relatively easy to turn this thing into a set of lazy
> prereqs, which is better, conceptually, I think. I am in the process of
> making it so.

Er, isn't that what my patch did? I'm fine if you have another approach
to present, but I'm worried we might be duplicating effort.

-Peff
