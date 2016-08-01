Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C94D1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 19:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbcHAT71 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 15:59:27 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43961 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbcHAT70 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 15:59:26 -0400
Received: from mfilter29-d.gandi.net (mfilter29-d.gandi.net [217.70.178.160])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id 7CA14C5A61;
	Mon,  1 Aug 2016 21:58:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter29-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter29-d.gandi.net (mfilter29-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id a3EXfW9WaGBd; Mon,  1 Aug 2016 21:58:18 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 02BC2C5A60;
	Mon,  1 Aug 2016 21:58:16 +0200 (CEST)
Date:	Mon, 1 Aug 2016 12:58:15 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] format-patch: Transition the default to --from to
 avoid spoofed mails
Message-ID: <20160801195815.7krmjszhzw32vtmo@x>
References: <20160730181246.4aifnvqfeenddzdl@x>
 <20160730191104.2ps5k7eji7aqgufg@x>
 <20160801174724.m4ags4ag4ftwoafj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801174724.m4ags4ag4ftwoafj@sigill.intra.peff.net>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 01:47:24PM -0400, Jeff King wrote:
> On Sat, Jul 30, 2016 at 12:11:05PM -0700, Josh Triplett wrote:
> 
> > Josh Triplett (2):
> >   format-patch: Add a config option format.from to set the default for --from
> >   format-patch: Default to --from
> 
> By the way, I notice that the threading between your patches and cover
> letter are broken. Since I see you are also working on a tool for
> handling such things, I'd suspect the tool (or your workflow) has a bug.
> :)

My workflow, fortunately. :)

> The message-id of this message is:
> 
>   <20160730191104.2ps5k7eji7aqgufg@x>
> 
> but the patches have both "References" and "In-Reply-To" set to:
> 
>   <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
> 
> I also see your MUA is mutt, and I think I saw you mention using "mutt
> -H" elsewhere. IIRC, when I started using a similar workflow years ago,
> I tried the same thing and had the same problem: "-H" treats the input
> file as a template, not a message, and thus generates a new message-id.
> 
> I switched to using mutt's internal "resend-message" function, which
> does a more literal re-send. I don't think I ever found a way to
> convince mutt to do a resend from the command line.

I actually tried using mutt's resend function (alt-e) with an mbox; I
checked the Message-Id and In-Reply-To headers, and they looked correct.
I've used mutt -H successfully before without breaking threads.  The
Debian mutt packages recently upgraded to the "neomutt" fork; I wonder
if something broke recently?

Thanks for letting me know; I'll investigate and try to figure out the
problem.

- Josh Triplett
