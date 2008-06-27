Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MSGID_FROM_MTA_HEADER,
	MSGID_NOFQDN1,RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 32038 invoked by uid 111); 27 Jun 2008 06:55:36 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 27 Jun 2008 02:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759336AbYF0GyO (ORCPT <rfc822;peff@peff.net>);
	Fri, 27 Jun 2008 02:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756266AbYF0GyN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 02:54:13 -0400
Received: from w2.willowmail.com ([64.243.175.54]:32888 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758923AbYF0GyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 02:54:12 -0400
Received: (qmail 22013 invoked by uid 90); 27 Jun 2008 06:54:01 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@willowmail.com>
To:	Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:	git@vger.kernel.org
Subject: Re: is rebase the same as merging every commit?
X-Mailer: Willow v0.02
Date:	Fri, 27 Jun 2008 06:46:57 -0000
Message-ID: <willow-jeske-01l7GnVAFEDjCe9c>
Received: from 67.160.239.249 at Fri, 27 Jun 2008 06:46:57 -0000
References: <vpqfxqz5qzj.fsf@bauges.imag.fr>
	<willow-jeske-01l78ZaJFEDjCYTA-01l7GOyLFEDjCV8E>
In-Reply-To: <vpqfxqz5qzj.fsf@bauges.imag.fr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

-- Matthieu Moy wrote:

> > (3) If it only has (G) as a parent, does the rebase explicitly remove the
> > source A,B,C nodes from the repository?
>
> Most commands, and this includes rebase, are
> "add-only". The objects will remain unreferenced and
> will be pruned by the next git gc --prune. Unreferenced
> objects do not harm, they just eat your disk space.

I see. So it would be reasonable for the documentation to be altered slightly
to show that the original nodes are still there, and that the primary
difference between merging those changes one-by-one and rebasing is that rebase
does not connect the new to the old. If you want to keep the old, you can toss
a branch name on it, and if not, it still lives until the gc timeout.

The current docs showing those nodes missing tells me that they disappear,
which is both scarry, and apparently inaccurate.
