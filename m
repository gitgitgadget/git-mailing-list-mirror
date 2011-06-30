From: David Fries <david@fries.net>
Subject: Re: [PATCH] (trivial) add helpful "use --soft" for bare reset
Date: Thu, 30 Jun 2011 14:06:08 -0500
Message-ID: <20110630190608.GB26701@spacedout.fries.net>
References: <20110626221428.GA26780@spacedout.fries.net>
 <7vk4c3qlqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Bronson <bronson@rinspin.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 21:06:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcMZG-0003Zh-F2
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 21:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab1F3TGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 15:06:18 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:49740 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab1F3TGP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 15:06:15 -0400
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id p5UJ69PR021702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 Jun 2011 14:06:09 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id p5UJ68ol021701;
	Thu, 30 Jun 2011 14:06:08 -0500
Content-Disposition: inline
In-Reply-To: <7vk4c3qlqa.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Thu, 30 Jun 2011 14:06:09 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176501>

Instead of,
fatal: mixed reset is not allowed in a bare repository
print,
fatal: mixed reset is not allowed in a bare repository, see update-ref
To tell the user what they can do, instead of just what they can't.

Signed-off-by: David Fries <David@Fries.net>
---
 builtin/reset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 98bca04..d0d4d66 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -332,7 +332,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		setup_work_tree();
 
 	if (reset_type == MIXED && is_bare_repository())
-		die(_("%s reset is not allowed in a bare repository"),
+		die(_("%s reset is not allowed in a bare repository, see update-ref"),
 		    _(reset_type_names[reset_type]));
 
 	/* Soft reset does not touch the index file nor the working tree
-- 
1.7.2.3
