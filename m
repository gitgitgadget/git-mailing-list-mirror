Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 21630 invoked by uid 111); 2 Apr 2008 20:58:34 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 02 Apr 2008 16:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbYDBU6S (ORCPT <rfc822;peff@peff.net>);
	Wed, 2 Apr 2008 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbYDBU6R
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 16:58:17 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:45845 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbYDBU6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 16:58:16 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 3D0B8180311EF; Wed,  2 Apr 2008 22:58:15 +0200 (CEST)
From:	Jan Engelhardt <jengelh@computergmbh.de>
To:	git@vger.kernel.org
Cc:	jnareb@gmail.com, kzak@redhat.com
Subject: [announce+patch] git-forest 20080402
Date:	Wed,  2 Apr 2008 22:58:14 +0200
Message-Id: <1207169895-25949-1-git-send-email-jengelh@computergmbh.de>
X-Mailer: git-send-email 1.5.4.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Status: A


Hi,


here is the current snapshot of git-forest, a text-based tree 
visualizer, as a patch to the git.git/contrib/ directory.

What's new since the last posting is that it now displays [HEAD]
along with a commit, since HEAD does not always need to be the
first commit that is graphed.
    The --all option now includes graphing a detached HEAD, as can
happen on switching to a non-branch and during rebases.
    Speaking of rebases, git-forest will now also show where you are in 
a rebase operation -- quite handy if you forget whether you actually are 
in one (happened to me time and again and when you finally notice, you 
need to play with HEAD@{x} to restore it) -- it can be suppressed 
with --no-rebase.

I updated the screenshot at 
http://jengelh.hopto.org/images/git-forest.png (URL unchanged).
Color-agnostic people may use the --no-color option. (Tag colors 
follow gitk as far as the 16 colors permit.)

The direct grab URL for the script is still
http://dev.computergmbh.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest
but of course a patch is provided below with the intent of getting it 
into contrib/ at least.


thanks,
Jan

N.B.: This was a ridiculous command to get it right...
can't this be done easier?
`git-format-patch -C -M --stat=72 --summary -p --thread -n HEAD^..HEAD &&
git-send-email --suppress-from --no-chain --compose --to git@xxx 00*`
