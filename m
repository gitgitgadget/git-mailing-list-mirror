From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 11/11] i18n: bundle: mark strings for translation
Date: Mon, 16 Apr 2012 19:50:03 +0700
Message-ID: <1334580603-11577-12-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:53:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlQR-0007fs-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab2DPMwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:52:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52864 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab2DPMwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:52:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6309124pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F0rUKp83WukJ2HXXijTup+T642SnqtYhQCeES4DKvYg=;
        b=JafS4r/SVDyMNSk7AiniZC6ivr4yVsVGBPNj03McmikzXgfd7Ic+XcyOrW930+uUyf
         OS3A60MJNTO+gRo2ArHj+ukimF/As8kvVuOEtx7YJ32owiiOsn6wFrzak3iEMTcRdhfN
         cPijc+o5/1qQhd1nuSmrSxYJVHHvHEgoqvUSTsX7MiDntCll7WyUYgcEe+WKnKo6Mqq9
         ziscxgCNMM2dWVdNBKTqSB1WDjv6Ew09L76HFrZiiztxWGkBv+J8U8cVusdmLD3nLgF5
         YYATGdfE0XRq7JQ3/kbehhA9JWPNp/psVa4GZysJhHGvnvaBba8jpndozFz47P0Zu4U4
         2NUA==
Received: by 10.68.212.163 with SMTP id nl3mr27442584pbc.112.1334580773307;
        Mon, 16 Apr 2012 05:52:53 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id q5sm17637821pbp.28.2012.04.16.05.52.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:52:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:52:02 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195634>

---
 bundle.c |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/bundle.c b/bundle.c
index d9cfd90..6d21c77 100644
--- a/bundle.c
+++ b/bundle.c
@@ -33,7 +33,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
 	    strcmp(buf.buf, bundle_signature)) {
 		if (report_path)
-			error("'%s' does not look like a v2 bundle file",
+			error(_("'%s' does not look like a v2 bundle file"),
 			      report_path);
 		status = -1;
 		goto abort;
@@ -60,7 +60,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		    (40 <= buf.len && !isspace(buf.buf[40])) ||
 		    (!is_prereq && buf.len <= 40)) {
 			if (report_path)
-				error("unrecognized header: %s%s (%d)",
+				error(_("unrecognized header: %s%s (%d)"),
 				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
 			status = -1;
 			break;
@@ -86,7 +86,7 @@ int read_bundle_header(const char *path, struct bundle_header *header)
 	int fd = open(path, O_RDONLY);
 
 	if (fd < 0)
-		return error("could not open '%s'", path);
+		return error(_("could not open '%s'"), path);
 	return parse_bundle_header(fd, header, path);
 }
 
@@ -137,7 +137,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	struct object_array refs;
 	struct commit *commit;
 	int i, ret = 0, req_nr;
-	const char *message = "Repository lacks these prerequisite commits:";
+	const char *message = _("Repository lacks these prerequisite commits:");
 
 	init_revisions(&revs, NULL);
 	for (i = 0; i < p->nr; i++) {
@@ -161,7 +161,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	revs.leak_pending = 1;
 
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 
 	i = req_nr;
 	while (i && (commit = get_revision(&revs)))
@@ -183,12 +183,16 @@ int verify_bundle(struct bundle_header *header, int verbose)
 		struct ref_list *r;
 
 		r = &header->references;
-		printf("The bundle contains %d ref%s\n",
-		       r->nr, (1 < r->nr) ? "s" : "");
+		printf_ln(Q_("The bundle contains %d ref",
+			     "The bundle contains %d refs",
+			     r->nr),
+			  r->nr);
 		list_refs(r, 0, NULL);
 		r = &header->prerequisites;
-		printf("The bundle requires these %d ref%s\n",
-		       r->nr, (1 < r->nr) ? "s" : "");
+		printf_ln(Q_("The bundle requires this ref",
+			     "The bundle requires these %d refs",
+			     r->nr),
+			  r->nr);
 		list_refs(r, 0, NULL);
 	}
 	return ret;
@@ -283,13 +287,13 @@ int create_bundle(struct bundle_header *header, const char *path,
 	strbuf_release(&buf);
 	fclose(rls_fout);
 	if (finish_command(&rls))
-		return error("rev-list died");
+		return error(_("rev-list died"));
 
 	/* write references */
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	if (argc > 1)
-		return error("unrecognized argument: %s'", argv[1]);
+		return error(_("unrecognized argument: %s'"), argv[1]);
 
 	object_array_remove_duplicates(&revs.pending);
 
@@ -324,7 +328,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 		 * constraints.
 		 */
 		if (!(e->item->flags & SHOWN) && e->item->type == OBJ_COMMIT) {
-			warning("ref '%s' is excluded by the rev-list options",
+			warning(_("ref '%s' is excluded by the rev-list options"),
 				e->name);
 			free(ref);
 			continue;
@@ -369,7 +373,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 		free(ref);
 	}
 	if (!ref_count)
-		die ("Refusing to create empty bundle.");
+		die(_("Refusing to create empty bundle."));
 
 	/* end header */
 	write_or_die(bundle_fd, "\n", 1);
@@ -387,7 +391,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	rls.out = bundle_fd;
 	rls.git_cmd = 1;
 	if (start_command(&rls))
-		return error("Could not spawn pack-objects");
+		return error(_("Could not spawn pack-objects"));
 
 	/*
 	 * start_command closed bundle_fd if it was > 1
@@ -405,10 +409,10 @@ int create_bundle(struct bundle_header *header, const char *path,
 	}
 	close(rls.in);
 	if (finish_command(&rls))
-		return error ("pack-objects died");
+		return error(_("pack-objects died"));
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
-			die_errno("cannot create '%s'", path);
+			die_errno(_("cannot create '%s'"), path);
 	}
 	return 0;
 }
@@ -430,6 +434,6 @@ int unbundle(struct bundle_header *header, int bundle_fd, int flags)
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
 	if (run_command(&ip))
-		return error("index-pack died");
+		return error(_("index-pack died"));
 	return 0;
 }
-- 
1.7.3.1.256.g2539c.dirty
