From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 6/7] replace: allow long option names
Date: Fri, 06 Sep 2013 07:10:58 +0200
Message-ID: <20130906051100.6657.18553.chriscool@tuxfamily.org>
References: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 07:12:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHoLE-0005Jw-DB
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 07:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793Ab3IFFMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 01:12:12 -0400
Received: from [194.158.98.14] ([194.158.98.14]:38076 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750776Ab3IFFL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 01:11:57 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 105A873;
	Fri,  6 Sep 2013 07:11:36 +0200 (CEST)
X-git-sha1: 7611e23e0e5ed3f8c3a71cc07762c1d337387c9f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234025>

It is now standard practice in Git to have both short and long option
names. So let's give a long option name to the git replace options too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 3 +++
 builtin/replace.c             | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index a2bd2ee..414000e 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -54,13 +54,16 @@ achieve the same effect as the `--no-replace-objects` option.
 OPTIONS
 -------
 -f::
+--force::
 	If an existing replace ref for the same object exists, it will
 	be overwritten (instead of failing).
 
 -d::
+--delete::
 	Delete existing replace refs for the given objects.
 
 -l <pattern>::
+--list <pattern>::
 	List replace refs for objects that match the given pattern (or
 	all if no pattern is given).
 	Typing "git replace" without arguments, also lists all replace
diff --git a/builtin/replace.c b/builtin/replace.c
index 95736d9..d4d1b75 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -128,9 +128,9 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int list = 0, delete = 0, force = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('l', NULL, &list, N_("list replace refs")),
-		OPT_BOOLEAN('d', NULL, &delete, N_("delete replace refs")),
-		OPT_BOOLEAN('f', NULL, &force, N_("replace the ref if it exists")),
+		OPT_BOOLEAN('l', "list", &list, N_("list replace refs")),
+		OPT_BOOLEAN('d', "delete", &delete, N_("delete replace refs")),
+		OPT_BOOLEAN('f', "force", &force, N_("replace the ref if it exists")),
 		OPT_END()
 	};
 
-- 
1.8.4.rc1.28.ge2684af
