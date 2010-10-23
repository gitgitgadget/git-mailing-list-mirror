From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 05/10] Change "tracking branch" to "remote-tracking branch" in C code
Date: Sat, 23 Oct 2010 18:31:16 +0200
Message-ID: <1287851481-27952-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 23 18:32:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9h1O-0005ip-3x
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 18:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948Ab0JWQcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 12:32:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51617 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757924Ab0JWQcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 12:32:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9NGPCbC027296
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 18:25:13 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h0C-0006cN-84; Sat, 23 Oct 2010 18:31:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h0C-0007Hp-5O; Sat, 23 Oct 2010 18:31:28 +0200
X-Mailer: git-send-email 1.7.3.2.537.g7e355
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 23 Oct 2010 18:25:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9NGPCbC027296
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288455914.15863@O6NSdAcRNAX5pYnrBqIcEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159793>

(Just like we did for documentation already)

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/checkout.c |    2 +-
 builtin/fetch.c    |    4 ++--
 remote.c           |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9a934af..1fa9ce4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -784,7 +784,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 *   between A and B, A...B names that merge base.
 	 *
 	 *   With no paths, if <something> is _not_ a commit, no -t nor -b
-	 *   was given, and there is a tracking branch whose name is
+	 *   was given, and there is a remote-tracking branch whose name is
 	 *   <something> in one and only one remote, then this is a short-hand
 	 *   to fork local <something> from that remote-tracking branch.
 	 *
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d35f000..3b0b614 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -52,7 +52,7 @@ static struct option builtin_fetch_options[] = {
 	OPT_SET_INT('n', NULL, &tags,
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('p', "prune", &prune,
-		    "prune tracking branches no longer on remote"),
+		    "prune remote-tracking branches no longer on remote"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
@@ -98,7 +98,7 @@ static void add_merge_config(struct ref **head,
 			continue;
 
 		/*
-		 * Not fetched to a tracking branch?  We need to fetch
+		 * Not fetched to a remote-tracking branch?  We need to fetch
 		 * it anyway to allow this branch's "branch.$name.merge"
 		 * to be honored by 'git pull', but we do not have to
 		 * fail if branch.$name.merge is misconfigured to point
diff --git a/remote.c b/remote.c
index 9143ec7..ca42a12 100644
--- a/remote.c
+++ b/remote.c
@@ -493,7 +493,7 @@ static void read_config(void)
 }
 
 /*
- * We need to make sure the tracking branches are well formed, but a
+ * We need to make sure the remote-tracking branches are well formed, but a
  * wildcard refspec in "struct refspec" must have a trailing slash. We
  * temporarily drop the trailing '/' while calling check_ref_format(),
  * and put it back.  The caller knows that a CHECK_REF_FORMAT_ONELEVEL
-- 
1.7.3.2.537.g7e355
