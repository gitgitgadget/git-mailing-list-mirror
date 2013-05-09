From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Wed,  8 May 2013 20:16:57 -0500
Message-ID: <1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:18:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFVM-0000py-S7
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab3EIBSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:18:40 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:44657 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab3EIBSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:18:35 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so1741131oag.4
        for <git@vger.kernel.org>; Wed, 08 May 2013 18:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=c0bPtHQ5zd4fH9gSLapDMb022pNgYeHkdgy13c2BtmA=;
        b=np8O/LHIHHJ6WVHhtHRuHKmrvgJy9vcp4s8dG70akCYEVcsxuJTFOpe8dPbEjE657k
         a3bk3kAXr7i9sfptGHPq6Kdx6FImCe2FB4OR8f+PNeiuWvc7JKDbRQgjg6coCN4XiZ58
         kzmWOLkgz0Po/qVhQLLZUKpWGFfH4axb5doUhOOiC8xFDRb88tLzX2F8dxFdr5gD8qTs
         wGDgZwAtsUmQtJohVh9yXERP5WOphvL5B644kDeELgNMn5AOidnHYmPz18A+Q6hlmxan
         VYqS47nGI7LDDVTStHU8F5hv60RM8cDcNcJtnMxCYerfH8Ax+sAdD38ng/zioDZwXmX8
         YgJg==
X-Received: by 10.182.236.202 with SMTP id uw10mr3142534obc.14.1368062314509;
        Wed, 08 May 2013 18:18:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm1043085obb.13.2013.05.08.18.18.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 18:18:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
In-Reply-To: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223697>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d60d675..8091354 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -135,7 +135,7 @@ static void export_blob(const unsigned char *sha1)
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-		die ("Could not read blob %s", sha1_to_hex(sha1));
+		die("Could not read blob %s", sha1_to_hex(sha1));
 	if (check_sha1_signature(sha1, buf, size, typename(type)) < 0)
 		die("sha1 mismatch in blob %s", sha1_to_hex(sha1));
 	object = parse_object_buffer(sha1, type, size, buf, &eaten);
@@ -146,7 +146,7 @@ static void export_blob(const unsigned char *sha1)
 
 	printf("blob\nmark :%"PRIu32"\ndata %lu\n", last_idnum, size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
-		die_errno ("Could not write blob '%s'", sha1_to_hex(sha1));
+		die_errno("Could not write blob '%s'", sha1_to_hex(sha1));
 	printf("\n");
 
 	show_progress();
@@ -289,13 +289,13 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	parse_commit(commit);
 	author = strstr(commit->buffer, "\nauthor ");
 	if (!author)
-		die ("Could not find author in commit %s",
+		die("Could not find author in commit %s",
 		     sha1_to_hex(commit->object.sha1));
 	author++;
 	author_end = strchrnul(author, '\n');
 	committer = strstr(author_end, "\ncommitter ");
 	if (!committer)
-		die ("Could not find committer in commit %s",
+		die("Could not find committer in commit %s",
 		     sha1_to_hex(commit->object.sha1));
 	committer++;
 	committer_end = strchrnul(committer, '\n');
@@ -395,7 +395,7 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	buf = read_sha1_file(tag->object.sha1, &type, &size);
 	if (!buf)
-		die ("Could not read tag %s", sha1_to_hex(tag->object.sha1));
+		die("Could not read tag %s", sha1_to_hex(tag->object.sha1));
 	message = memmem(buf, size, "\n\n", 2);
 	if (message) {
 		message += 2;
@@ -421,11 +421,11 @@ static void handle_tag(const char *name, struct tag *tag)
 		if (signature)
 			switch(signed_tag_mode) {
 			case ABORT:
-				die ("Encountered signed tag %s; use "
+				die("Encountered signed tag %s; use "
 				     "--signed-tags=<mode> to handle it.",
 				     sha1_to_hex(tag->object.sha1));
 			case WARN:
-				warning ("Exporting signed tag %s",
+				warning("Exporting signed tag %s",
 					 sha1_to_hex(tag->object.sha1));
 				/* fallthru */
 			case VERBATIM:
@@ -446,7 +446,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	if (!tagged_mark) {
 		switch(tag_of_filtered_mode) {
 		case ABORT:
-			die ("Tag %s tags unexported object; use "
+			die("Tag %s tags unexported object; use "
 			     "--tag-of-filtered-object=<mode> to handle it.",
 			     sha1_to_hex(tag->object.sha1));
 		case DROP:
@@ -454,7 +454,7 @@ static void handle_tag(const char *name, struct tag *tag)
 			return;
 		case REWRITE:
 			if (tagged->type != OBJ_COMMIT) {
-				die ("Tag %s tags unexported %s!",
+				die("Tag %s tags unexported %s!",
 				     sha1_to_hex(tag->object.sha1),
 				     typename(tagged->type));
 			}
@@ -467,7 +467,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				if (!(p->object.flags & TREESAME))
 					break;
 				if (!p->parents)
-					die ("Can't find replacement commit for tag %s\n",
+					die("Can't find replacement commit for tag %s\n",
 					     sha1_to_hex(tag->object.sha1));
 				p = p->parents->item;
 			}
@@ -677,7 +677,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	};
 
 	if (argc == 1)
-		usage_with_options (fast_export_usage, options);
+		usage_with_options(fast_export_usage, options);
 
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
@@ -689,7 +689,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &revs, NULL);
 	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
 	if (argc > 1)
-		usage_with_options (fast_export_usage, options);
+		usage_with_options(fast_export_usage, options);
 
 	if (use_done_feature)
 		printf("feature done\n");
-- 
1.8.3.rc1.553.gac13664
