Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 18048 invoked by uid 111); 30 Oct 2008 18:21:04 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 30 Oct 2008 14:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbYJ3SUy (ORCPT <rfc822;peff@peff.net>);
	Thu, 30 Oct 2008 14:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbYJ3SUx
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 14:20:53 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:55613 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222AbYJ3SUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 14:20:53 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 6790421C610; Fri, 31 Oct 2008 07:20:51 +1300 (NZDT)
Received: from localhost.localdomain (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	by mail.utsl.gen.nz (Postfix) with ESMTP id BF31E21C42A;
	Fri, 31 Oct 2008 07:20:41 +1300 (NZDT)
From:	Sam Vilain <sam@vilain.net>
To:	git@vger.kernel.org
Cc:	Sam Vilain <sam@vilain.net>,
	"_vi@list.ru, git@vger.kernel.org, gitster@pobox.com, Vitaly _Vi Shukela" 
	<public_vi@tut.by>, "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
Subject: Re: [PATCH] Documented --no-checkout option in git-svn
Date:	Thu, 30 Oct 2008 11:20:41 -0700
Message-Id: <1225390505.19891.41.camel@maia.lan>
X-Mailer: git-send-email debian.1.5.6.1
To:	Deskin Miller <deskinm@umich.edu>
In-Reply-To: <20081030180736.GA20322@euler>
References: <1225382900-22482-1-git-send-email-_vi@list.ru>
X-Mailer: Evolution 2.22.3.1 
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Old-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5

On Thu, 2008-10-30 at 14:07 -0400, Deskin Miller wrote:
> > +--no-checkout
> > +	Do not checkout latest revision after fetching.
> 
> This isn't quite how the other options are listed in the source; for one, this
> ends up formatted in the final manpage like
> 
> --no-checkout Do not checkout latest revision after fetching.
> 
> Instead of
> 
> --no-checkout
> 	Do not checkout latest revision after fetching.
> 
> Also, the wording seems slightly imprecise; in fact, if the repository already
> has a checkout, git svn fetch would not attempt to check anything out in its
> place, nor will it check anything out if there is a local master branch
> already.  With clone this is not typically a problem, but in fact it is
> possible to clone into a preexisting git repository, so the same concerns
> exist.

I think the wording is close enough; here's a version which looks good
to me and fixes the asciidoc differences.

Subject: git-svn: document --no-checkout option

From: Vitaly "_Vi" Shukela <public_vi@tut.by>

Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>
Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/git-svn.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 84c8f3c..2298512 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -91,6 +91,9 @@ COMMANDS
 	tracking.  The name of the [svn-remote "..."] section in the
 	.git/config file may be specified as an optional command-line
 	argument.
+	
+--no-checkout;;
+	Do not checkout the latest revision after fetching.
 
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
@@ -103,6 +106,9 @@ COMMANDS
 	the working tree; and the 'rebase' command will be able
 	to update the working tree with the latest changes.
 
+--no-checkout;;
+	Do not checkout the latest revision after cloning.
+
 'rebase'::
 	This fetches revisions from the SVN parent of the current HEAD
 	and rebases the current (uncommitted to SVN) work against it.
-- 
debian.1.5.6.1

