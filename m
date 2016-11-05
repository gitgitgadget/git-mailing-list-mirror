Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D468B2022C
	for <e@80x24.org>; Sat,  5 Nov 2016 20:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756349AbcKEU0D (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 16:26:03 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51078 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755844AbcKEU0C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 16:26:02 -0400
Received: from mfilter9-d.gandi.net (mfilter9-d.gandi.net [217.70.178.138])
        by relay5-d.mail.gandi.net (Postfix) with ESMTP id 370AE41C084;
        Sat,  5 Nov 2016 21:26:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter9-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
        by mfilter9-d.gandi.net (mfilter9-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id I1UIlfWaIwA1; Sat,  5 Nov 2016 21:25:59 +0100 (CET)
X-Originating-IP: 216.234.200.180
Received: from x (unknown [216.234.200.180])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1610441C089;
        Sat,  5 Nov 2016 21:25:56 +0100 (CET)
Date:   Sat, 5 Nov 2016 14:25:54 -0600
From:   Josh Triplett <josh@joshtriplett.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161105202553.migx75gfuujakqyk@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
 <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
 <20161105151836.wztypzrdywyltvrc@x>
 <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2016 at 09:21:58PM +0100, Christian Couder wrote:
> On Sat, Nov 5, 2016 at 4:18 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Sat, Nov 05, 2016 at 01:45:27PM +0100, Christian Couder wrote:
> >> And with what Peff says above it looks like we will need ways
> >> configure and tweak commit reachability with gitlink/gitref anyway. So
> >> the point of gitref compared to gitlink would be that they just have a
> >> different reachability by default. But couldn't that be replaced by a
> >> default rule saying that when a gitlink is reached "this way or that
> >> way" then the commit reachability should be enforced, and otherwise it
> >> should not be?
> >
> > Any version of git unaware of that rule, though, would consider objects
> > only reachable by gitlink as unreachable and delete them, causing data
> > loss.  Likewise for a server not aware of that rule.  And a server
> > unaware of that rule would not supply those objects to a client pulling
> > such a branch.
> 
> Yeah, so you would really need an up-to-date server and client to
> store the git-series data.
> But anyway if we create a gitref object, you would also need
> up-to-date servers and clients to make it work.

Agreed, but gitrefs have the advantage of failing safe, rather than
failing with dataloss.

- Josh Triplett
