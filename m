From: Julien Danjou <julien@danjou.info>
Subject: [PATCH] git submodule: fix add usage line
Date: Thu,  2 Apr 2009 10:47:08 +0200
Message-ID: <1238662028-9557-1-git-send-email-julien@danjou.info>
Cc: git@vger.kernel.org, Julien Danjou <julien@danjou.info>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 10:59:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpIlf-00081h-An
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 10:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760462AbZDBI5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 04:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758638AbZDBI5c
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 04:57:32 -0400
Received: from prometheus.naquadah.org ([212.85.154.174]:49335 "EHLO
	mx1.naquadah.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757795AbZDBI53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 04:57:29 -0400
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2009 04:57:29 EDT
Received: by mx1.naquadah.org (Postfix, from userid 8)
	id 8EB005C09C; Thu,  2 Apr 2009 10:47:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	prometheus.naquadah.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from abydos.adm.naquadah.org (abydos.adm.naquadah.org [192.168.2.13])
	by mx1.naquadah.org (Postfix) with ESMTPS id 396325C091;
	Thu,  2 Apr 2009 10:47:09 +0200 (CEST)
Received: from jd by abydos.adm.naquadah.org with local (Exim 4.69)
	(envelope-from <jd@abydos.adm.naquadah.org>)
	id 1LpIZo-0002Uj-Jh; Thu, 02 Apr 2009 10:47:08 +0200
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115450>

Actually, cmd_add() parse options first and stop as soon as an unknown
word is encoutered.
So we need to put the option like -b at the beginning, or the option
parsing loop will be escaped before we got the change to have our -b
option parsed.

Signed-off-by: Julien Danjou <julien@danjou.info>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 0a27232..7c2e060 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli
 
 USAGE="[--quiet] [--cached] \
-[add <repo> [-b branch] <path>]|[status|init|update [-i|--init] [-N|--no-fetch]|summary [-n|--summary-limit <n>] [<commit>]] \
+[add [-b branch] <repo> <path>]|[status|init|update [-i|--init] [-N|--no-fetch]|summary [-n|--summary-limit <n>] [<commit>]] \
 [--] [<path>...]|[foreach <command>]|[sync [--] [<path>...]]"
 OPTIONS_SPEC=
 . git-sh-setup
-- 
1.6.2.1
