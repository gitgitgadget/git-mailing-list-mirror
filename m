Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1161F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeC3Tyj (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:54:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:49308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752318AbeC3Tyi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:54:38 -0400
Received: (qmail 28222 invoked by uid 109); 30 Mar 2018 19:54:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 19:54:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32576 invoked by uid 111); 30 Mar 2018 19:55:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 15:55:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 15:54:36 -0400
Date:   Fri, 30 Mar 2018 15:54:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] trace.c: export trace_setup_key
Message-ID: <20180330195436.GA14217@sigill.intra.peff.net>
References: <20180330183425.GA30575@sigill.intra.peff.net>
 <20180330183459.GB31135@sigill.intra.peff.net>
 <xmqq8ta92vot.fsf@gitster-ct.c.googlers.com>
 <20180330194749.GA13537@sigill.intra.peff.net>
 <xmqq4lkx2vhh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4lkx2vhh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 12:50:50PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Mar 30, 2018 at 12:46:26PM -0700, Junio C Hamano wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> >> >
> >> > This is so that we can print traces based on this key outside trace.c.
> >> 
> >> "this key" meaning...?  GIT_TRACE_SETUP?
> >
> > I think "based on trace_setup_key".
> >
> > -Peff
> 
> Yeah, I read, but did not pay enough attention to, the subject X-<.

To be fair, one of our guidelines is that the commit message should not
overly rely on the subject line. Though I am certainly guilty of
starting many a message with "This".

Perhaps:

  The setup-tracing code is static-local to trace.c. In preparation for
  new GIT_TRACE_SETUP code outside of trace.c, let's make the trace_key
  globally available.

would be a better commit message.

-Peff
