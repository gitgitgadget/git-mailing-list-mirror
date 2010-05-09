From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH v2 1/2] clone: have progress report mention top level dir,
 not git dir
Date: Sun, 09 May 2010 13:10:17 -0700
Message-ID: <4BE716A9.9060608@pcharlan.com>
References: <4BE60E89.8010709@pcharlan.com> <20100509110221.GA16639@coredump.intra.peff.net> <4BE7166A.5030107@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 09 22:10:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBCpV-0002rB-OT
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 22:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab0EIUKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 16:10:20 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:40600 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750938Ab0EIUKS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 16:10:18 -0400
Received: from [192.168.0.119] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id B8A298F2C1;
	Sun,  9 May 2010 13:10:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <4BE7166A.5030107@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146742>

"git clone foo bar" currently reports "Cloning into
/path/to/bar/.git".  Change this message to "Cloning into bar" to more
closely match the user's expectation.

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---
 builtin/clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0bedde4..306aacf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -464,7 +464,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	set_git_dir(make_absolute_path(git_dir));
 
 	if (0 <= option_verbosity)
-		printf("Cloning into %s...\n", get_git_dir());
+		printf("Cloning into %s...\n", dir);
 	init_db(option_template, INIT_DB_QUIET);
 
 	/*
-- 
1.7.1.14.gcafbfa.dirty
