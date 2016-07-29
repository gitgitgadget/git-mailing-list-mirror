Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD0E1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbcG2AEr (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:04:47 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52137 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbcG2AEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:04:46 -0400
Received: from mfilter45-d.gandi.net (mfilter45-d.gandi.net [217.70.178.176])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 1836EA80C2;
	Fri, 29 Jul 2016 02:04:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter45-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter45-d.gandi.net (mfilter45-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 1u0-ky3xMCSF; Fri, 29 Jul 2016 02:04:42 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7C250A80CD;
	Fri, 29 Jul 2016 02:04:41 +0200 (CEST)
Date:	Thu, 28 Jul 2016 17:04:39 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160729000439.GC3676@x>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160728215603.GA22865@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 05:56:03PM -0400, Jeff King wrote:
> Another way to think about it is that "--from" is a no-brainer when you
> really are going to email the patches (and that's why it is has always
> been the default behavior in git-send-email). But if you _aren't_ going
> to mail the patches, retaining the original headers is more convenient.
> It's not clear to me how many non-mail users of format-patch there are
> (certainly rebase is one of them, but because it uses "am" on the
> receiving side, I think everything should Just Work).

I've seen various people use git format-patch to produce a patch file to
email around, or a patch file to commit to a patches directory in a
distribution package.  I don't think any such tools would work
incorrectly with the --from output, though for purely aesthetic reasons,
I can imagine not wanting to include your own email address when not
sending the patch by email.
