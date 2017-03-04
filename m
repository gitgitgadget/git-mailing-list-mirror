Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA3072013E
	for <e@80x24.org>; Sat,  4 Mar 2017 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdCDHHV (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 02:07:21 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40728 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdCDHHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 02:07:20 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4DED32013E;
        Sat,  4 Mar 2017 06:55:48 +0000 (UTC)
Date:   Sat, 4 Mar 2017 06:55:48 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jann Horn <jannh@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH] http: inform about alternates-as-redirects behavior
Message-ID: <20170304065548.GA20734@whir>
References: <20170304013504.GA27183@untitled>
 <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> The warning itself:
> 
> > +		warning("alternate disabled by http.followRedirects!=true: %s",
> 
> feels like it could use some whitespace around the "!=", but maybe
> that's just me.

Yeah, I kinda wanted to emulate the command-line syntax.

Maybe rewording it a bit and showing how to enable it will
make more sense:

		warning("alternate: %s", url);
		warning(" may be enabled by -c http.followRedirects=true");

As well as keeping individual lines shorter and hopefully
easier-to-read.
