X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Remove COLLISION_CHECK from Makefile since it's not used.
Date: Tue, 19 Dec 2006 22:25:13 -0500
Message-ID: <20061220032513.GA12119@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 03:25:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34905>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gws52-00078a-TP for gcvg-git@gmane.org; Wed, 20 Dec
 2006 04:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964838AbWLTDZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 22:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWLTDZQ
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 22:25:16 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:34772 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S964838AbWLTDZP (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 22:25:15 -0500
Received: from localhost.localdomain (localhost [127.0.0.1]) by
 silverinsanity.com (Postfix) with ESMTP id 596AD1FFC02B for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 03:25:14 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2 
 (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

It's rather misleading to have configuration options that don't do
anything.  If someone adds collision checking they might also want to
restore this option.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Subject: Re: Change in git-svn dcommit semantics?

 On Dec 19, 2006, at 7:38 PM, Brian Gernhardt wrote:

 > On Dec 19, 2006, at 6:57 PM, Johannes Schindelin wrote:
 > 
 >>> Mine also has a few variables like "COLLISION_CHECK=paranoid" and my own
 >>> prefix.
 >> 
 >> Just to wake sleeping tigers: have you done a "grep COLLISION_CHECK *"
 >> recently (where recently means any date after May 3rd, 2005)?
 > 
 > Oh, well, that's cute.  It's a configuration option that doesn't touch any
 > code at all...  

 Makefile     |    4 ----
 configure.ac |    4 ----
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 8919dab..7651104 100644
--- a/Makefile
+++ b/Makefile
@@ -82,10 +82,6 @@ all:
 # Define NO_ACCURATE_DIFF if your diff program at least sometimes misses
 # a missing newline at the end of the file.
 #
-# Define COLLISION_CHECK below if you believe that SHA1's
-# 1461501637330902918203684832716283019655932542976 hashes do not give you
-# sufficient guarantee that no collisions between objects will ever happen.
-#
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
diff --git a/configure.ac b/configure.ac
index 34e3478..e153d53 100644
--- a/configure.ac
+++ b/configure.ac
@@ -316,10 +316,6 @@ GIT_PARSE_WITH(iconv))
 
 ## --enable-FEATURE[=ARG] and --disable-FEATURE
 #
-# Define COLLISION_CHECK below if you believe that SHA1's
-# 1461501637330902918203684832716283019655932542976 hashes do not give you
-# sufficient guarantee that no collisions between objects will ever happen.
-#
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
-- 
1.4.4.1.GIT
