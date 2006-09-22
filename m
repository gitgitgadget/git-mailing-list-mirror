From: Jeff King <peff@peff.net>
Subject: [PATCH] git-repack: allow git-repack to run in subdirectory
Date: Fri, 22 Sep 2006 11:10:54 -0400
Message-ID: <20060922151054.GA29198@coredump.intra.peff.net>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 22 17:13:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQmg8-0005u1-MS
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 17:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWIVPK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 11:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWIVPK5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 11:10:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:55511 "HELO
	peff.net") by vger.kernel.org with SMTP id S932579AbWIVPK5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 11:10:57 -0400
Received: (qmail 29578 invoked from network); 22 Sep 2006 11:10:54 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 22 Sep 2006 11:10:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2006 11:10:54 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27529>

Now that we explicitly create all tmpfiles below $GIT_DIR, there's no reason
to care about which directory we're in.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-repack.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 9ae5092..f2c9071 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -4,6 +4,7 @@ # Copyright (c) 2005 Linus Torvalds
 #
 
 USAGE='[-a] [-d] [-f] [-l] [-n] [-q]'
+SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
 no_update_info= all_into_one= remove_redundant=
-- 
1.4.2.1.gb6052-dirty
