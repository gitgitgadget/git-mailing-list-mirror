X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Feature request: git-pull -e/--edit
Date: 19 Nov 2006 16:26:11 -0500
Message-ID: <20061119212611.13038.qmail@science.horizon.com>
NNTP-Posting-Date: Sun, 19 Nov 2006 21:26:26 +0000 (UTC)
Cc: linux@horizon.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31866>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GluB7-0002NL-M2 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 22:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933343AbWKSV0O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 16:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933344AbWKSV0O
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 16:26:14 -0500
Received: from science.horizon.com ([192.35.100.1]:26429 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S933343AbWKSV0N (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 16:26:13 -0500
Received: (qmail 13039 invoked by uid 1000); 19 Nov 2006 16:26:11 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The last end-user use I can think of for git-merge instead
of git-pull is providing a custom commit message.

Would it be possible to add -m and -e options to git-pull?

The problem I can see is that the latter would have to be added to
git-merge, and the guts there are a bit intricate; it uses git-commit-tree
directly rather than git-commit, so I can't just pass through the
arguments.

Assuming it's just as much of a pain for someone else, would it
still be worth the effort?  Can git-merge be cleaned up?

The manual option is to use "git merge --no-commit" and then supply the
arguments to git-commit in the usual way.

But I notice that --no-commit actually changes git's merging
technique.  If it's specified, the trivial in-index merge doesn't
appear to be attempted.  I don't think it makes a huge difference,
