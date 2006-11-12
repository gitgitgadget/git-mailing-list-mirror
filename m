X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: gitweb some known issues
Date: Sat, 11 Nov 2006 22:28:44 -0800
Message-ID: <7virhlgov7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 06:29:23 +0000 (UTC)
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Luben Tuikov <ltuikov@yahoo.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31257>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj8q9-0000rw-4l for gcvg-git@gmane.org; Sun, 12 Nov
 2006 07:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754987AbWKLG2q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 01:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754989AbWKLG2q
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 01:28:46 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7152 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1754987AbWKLG2p
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 01:28:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061112062845.BRWX27894.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 01:28:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id liUK1V00E1kojtg0000000; Sun, 12 Nov 2006
 01:28:20 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Visit git.git gitweb page (http://repo.or.cz/w/git.git would
work fine if git.kernel.org is too busy), and click on "GIT 1.4.4-rc1"
to view the tag (not the commit).

The navigation bar has commit/commitdiff/tree with explicit h
and hb object names that point at 'master', which feels wrong.
When the tag that is displayed points at a commit, perhaps we
would want to use that commit for commit and commitdiff?  When
the tag does not point at a commit (which is admittably very
rare), probably not showing these links is the right thing to do
(if tag points at tree it might make sense to give tree,
though).

Also shortlog/log links do not say where to begin the log with,
which means start digging from HEAD.  When we display a commit
or commitdiff, we seem to give a link to start log at that
commit, so doing the same as above for shortlog/log may make
them more consistent.
