Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,
	MSGID_FROM_MTA_HEADER,MSGID_NOFQDN1,PLING_QUERY,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: (qmail 32437 invoked by uid 111); 24 Jun 2008 04:53:26 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 00:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYFXExP (ORCPT <rfc822;peff@peff.net>);
	Tue, 24 Jun 2008 00:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbYFXExP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 00:53:15 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60006 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750751AbYFXExP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 00:53:15 -0400
Received: (qmail 8118 invoked by uid 90); 24 Jun 2008 04:52:53 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@google.com>
To:	Nicolas Pitre <nico@cam.org>
Cc:	git@vger.kernel.org
Subject: Re: why is git destructive by default? (i suggest it not be!)
X-Mailer: Willow v0.02
Date:	Tue, 24 Jun 2008 04:40:16 -0000
Message-ID: <willow-jeske-01l5g9o4FEDjCXMB>
Received: from 67.188.42.104 at Tue, 24 Jun 2008 04:40:16 -0000
References: <alpine.LFD.1.10.0806232356340.2979@xanadu.home>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5fAcTFEDjCWA4>
In-Reply-To: <alpine.LFD.1.10.0806232356340.2979@xanadu.home>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

-- Nicolas Pitre wrote:
> I hope you'll feel much safer then.

I moved a branch around and then deleted it, and I don't see any record in the
reflog of where it was, or that it ever was.

Am I missing something about how branches are used? I see some language in "git
tag" about how attempts are made to assure that others can't move around
semi-immutable tags during push, but I don't see any such language about
branches. What prevents someone from accidentally deleting an old branch that
nobody is watching, but is important to the history and then not noticing as gc
silently deletes the old deltas?

I've had need to pull out versions several years old multiple times in my
career, so this is the kind of thing I'm thinking about.

git config --global gc.reflogexpire            "10 years"'
git config --global gc.reflogexpireunreachable "10 years"

Makes me feel safer that the data will be in there, but even with the reflog
and access to the repository, I doubt I could FIND the place an old branch was
supposed to be if it was inadvertently deleted in a 2-million line source tree.
Am I just looking in the wrong places?
