From: Paul Price <price@astro.princeton.edu>
Subject: [PATCH] fast-export: fix argument name in error messages
Date: Fri, 12 Apr 2013 10:05:55 -0400
Message-ID: <43FA6C2A-A2C3-474F-889A-8059CE24175A@astro.princeton.edu>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 12 16:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQf3L-0007gB-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 16:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab3DLOeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 10:34:06 -0400
Received: from kay.astro.Princeton.EDU ([128.112.24.221]:40598 "EHLO
	mail.astro.princeton.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab3DLOeF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 10:34:05 -0400
X-Greylist: delayed 1687 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Apr 2013 10:34:05 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astro.princeton.edu (Postfix) with ESMTP id 24F9D1BC00B91
	for <git@vger.kernel.org>; Fri, 12 Apr 2013 10:05:57 -0400 (EDT)
X-Virus-Scanned: amavisd-new at astro.princeton.edu
Received: from mail.astro.princeton.edu ([127.0.0.1])
	by localhost (kay.astro.princeton.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ret-Gw1xoYRp for <git@vger.kernel.org>;
	Fri, 12 Apr 2013 10:05:55 -0400 (EDT)
X-Submitted: to mail.astro.princeton.edu (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: price)
	 with ESMTP
	for <git@vger.kernel.org>; Fri, 12 Apr 2013 10:05:55 -0400 (EDT)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220981>

The --signed-tags argument is plural, while error messages referred
to --signed-tag (singular).  Tweak error messages to correspond to the
argument.

Signed-off-by: Paul Price <price@astro.princeton.edu>
---
First submission; please report any formatting or style errors privately.

builtin/fast-export.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 77dffd1..ad9d0c4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -43,7 +43,7 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
	else if (!strcmp(arg, "strip"))
		signed_tag_mode = STRIP;
	else
-		return error("Unknown signed-tag mode: %s", arg);
+		return error("Unknown signed-tags mode: %s", arg);
	return 0;
}

@@ -416,7 +416,7 @@ static void handle_tag(const char *name, struct tag *tag)
			switch(signed_tag_mode) {
			case ABORT:
				die ("Encountered signed tag %s; use "
-				     "--signed-tag=<mode> to handle it.",
+				     "--signed-tags=<mode> to handle it.",
				     sha1_to_hex(tag->object.sha1));
			case WARN:
				warning ("Exporting signed tag %s",
-- 
1.8.1.1
