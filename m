From: David Fries <david@fries.net>
Subject: [PATCH] (trivial) add helpful "use --soft" for bare reset
Date: Sun, 26 Jun 2011 17:14:28 -0500
Message-ID: <20110626221428.GA26780@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 00:30:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QaxqJ-0000oj-NT
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 00:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab1FZW1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 18:27:25 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:46599 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455Ab1FZW0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 18:26:52 -0400
X-Greylist: delayed 733 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jun 2011 18:26:52 EDT
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id p5QMETok031392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 26 Jun 2011 17:14:29 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id p5QMESdd031391;
	Sun, 26 Jun 2011 17:14:28 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Sun, 26 Jun 2011 17:14:29 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176336>

Add a helpful "use --soft" message for git-reset (mixed) in a bare
repository.  This tells the user what they can do, instead of just what
they can't.

Signed-off-by: David Fries <David@Fries.net>
---
When I was first learning how to use git and I needed to reset my bare
repository I would make it a full repository just so I could use
git-reset, a message like the above would have saved me a lot of
effort back then.

I'm not the only one, I received an e-mail yesterday confused on what
to do, found my patch via google "it saved my bacon."

 builtin/reset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 98bca04..dd0cc1e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -332,7 +332,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		setup_work_tree();
 
 	if (reset_type == MIXED && is_bare_repository())
-		die(_("%s reset is not allowed in a bare repository"),
+		die(_("%s reset is not allowed in a bare repository, use --soft"),
 		    _(reset_type_names[reset_type]));
 
 	/* Soft reset does not touch the index file nor the working tree
-- 
1.7.2.3
