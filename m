Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MSGID_FROM_MTA_HEADER,
	MSGID_NOFQDN1,RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 17841 invoked by uid 111); 25 Jun 2008 21:42:47 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 25 Jun 2008 17:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYFYVm1 (ORCPT <rfc822;peff@peff.net>);
	Wed, 25 Jun 2008 17:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbYFYVm1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 17:42:27 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60627 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752770AbYFYVm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 17:42:27 -0400
Received: (qmail 4325 invoked by uid 90); 25 Jun 2008 21:42:21 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@willowmail.com>
To:	"David Jeske" <jeske@willowmail.com>
Cc:	"Theodore Tso" <tytso@mit.edu>, git@vger.kernel.org
Subject: Re: policy and mechanism for less-connected clients
X-Mailer: Willow v0.02
Date:	Wed, 25 Jun 2008 21:34:16 -0000
Message-ID: <willow-jeske-01l6ZD0vFEDjCXou>
Received: from 67.188.42.104 at Wed, 25 Jun 2008 21:34:16 -0000
References: <willow-jeske-01l6XqjOFEDjC=91jv>
	<willow-jeske-01l6@3PlFEDjCVAh-01l6XqjPFEDjCY6P>
In-Reply-To: <willow-jeske-01l6XqjOFEDjC=91jv>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some answers thanks to Jakub...

-- David Jeske wrote:
> : "ncvs up" ->
> :
> : git stash; git pull; git apply;
> : git diff --stat <baseof:current branch> - un-pushed filenames
> : git-show-branch <current branch> - un-pushed comments
>
> Question: when I say "baseof:current branch", I mean "the common-ancestor
> between my local-repo tracking branch and the remote-repo branch it's
> tracking". How do I find that out?

I'm told I need...

git diff --stat `git-merge-base HEAD ORIG_HEAD`

> : "ncvs commit" -> "git commit; git push <only this branch>;"
>
> Question: how do I only push the branch I'm on? "eg" says it does this, but
> from a quick look at the code, it wasn't obvious to me how.

and...

git push HEAD


which just leaves this one....

Question: How do I create a branch on a remote repo when I'm on
my local machine, without sshing to it?
