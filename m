From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] new git check-ignore sub-command
Date: Fri, 21 Sep 2012 12:00:55 -0700
Message-ID: <7vehlv5hg8.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 21:01:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF8TP-0006zX-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 21:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933085Ab2IUTBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 15:01:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933014Ab2IUTA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 15:00:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DB5893A1;
	Fri, 21 Sep 2012 15:00:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zG1cV+gNCmx5b+rLYFlZers7SuE=; b=TrWii2
	hYAFbrTJpvChFPoCtsO2AfbPRacMEoM2Mp6tB4lSzJfclGoUuzQtdeE1MqRVQz23
	gRHQ0aNP6ftrYdyUbvhL0EY/eKvMb9yxmBGVW4rlg0pDkegWPH6hKKuoPXxu5Wn0
	tN+niTGzeZ347kvhg7p8BAhb3SdCZ1ZpKbtyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DAyiHFQ6HYvAWsP7tphN68BSIJ4BYa2r
	4PHb4diRZ+TGhSFN7bEig/xhX+OBpUUINx0ms7IEU4J4sNWbPfAaQWr6oN8tst0E
	WPkQpfHvVJc1szNeZexv/DtBUbAygsYnfO2ImIXt1xfrImk21mfVclYXs/jT+LDQ
	jTbGyh9Jj0U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE59A93A0;
	Fri, 21 Sep 2012 15:00:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0683D939F; Fri, 21 Sep 2012
 15:00:56 -0400 (EDT)
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 20 Sep 2012 20:46:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACDED890-041E-11E2-B19D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206149>

Adam Spiers <git@adamspiers.org> writes:

> It has been rebased on the latest master, and passed a full test run.

FYI, I applied the attached on top before queuing it in 'pu'.

Points to note:

 * We match the underline and the title of documentation header;

 * a few type mismatches (constness of full_path and treat_gitlink()
   signature) that broke compilation;

 * decl-after-stmt;

 * multi-line comment style;

Thanks.

-- >8 --
Subject: check-ignore: minimum compilation fix

---
 Documentation/git-check-ignore.txt |  2 +-
 builtin/check-ignore.c             | 11 +++++++----
 dir.c                              | 12 ++++++------
 pathspec.c                         |  4 ++--
 pathspec.h                         |  2 +-
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 2de4e17..96fa7bc 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -1,5 +1,5 @@
 git-check-ignore(1)
-=================
+===================
 
 NAME
 ----
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 74ea2fc..3cbd3b9 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -77,9 +77,10 @@ static int check_ignore(const char *prefix, const char **pathspec)
 		if (!seen)
 			seen = find_used_pathspec(pathspec);
 		for (i = 0; pathspec[i]; i++) {
+			const char *full_path;
 			path = pathspec[i];
-			char *full_path =
-				prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
+			full_path = prefix_path(prefix, prefix
+						? strlen(prefix) : 0, path);
 			full_path = treat_gitlink(full_path);
 			validate_path(prefix, full_path);
 			if (!seen[i] && path[0]) {
@@ -108,6 +109,7 @@ static int check_ignore_stdin_paths(const char *prefix)
 	char **pathspec = NULL;
 	size_t nr = 0, alloc = 0;
 	int line_termination = null_term_line ? 0 : '\n';
+	int num_ignored;
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
@@ -124,7 +126,7 @@ static int check_ignore_stdin_paths(const char *prefix)
 	}
 	ALLOC_GROW(pathspec, nr + 1, alloc);
 	pathspec[nr] = NULL;
-	int num_ignored = check_ignore(prefix, (const char **)pathspec);
+	num_ignored = check_ignore(prefix, (const char **)pathspec);
 	maybe_flush_or_die(stdout, "attribute to stdout");
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
@@ -134,6 +136,8 @@ static int check_ignore_stdin_paths(const char *prefix)
 
 int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 {
+	int num_ignored = 0;
+
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, check_ignore_options,
@@ -155,7 +159,6 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 			die(_("cannot have both --quiet and --verbose"));
 	}
 
-	int num_ignored = 0;
 	if (stdin_paths) {
 		num_ignored = check_ignore_stdin_paths(prefix);
 	} else {
diff --git a/dir.c b/dir.c
index d516ddf..8fc162c 100644
--- a/dir.c
+++ b/dir.c
@@ -511,14 +511,13 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		       stk->baselen - current);
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
 
-		/* dir->basebuf gets reused by the traversal, but we
+		/*
+		 * dir->basebuf gets reused by the traversal, but we
 		 * need fname to remain unchanged to ensure the src
 		 * member of each struct exclude correctly back-references
 		 * its source file.
 		 */
-		char *fname = strdup(dir->basebuf);
-
-		add_excludes_from_file_to_list(fname,
+		add_excludes_from_file_to_list(strdup(dir->basebuf),
 					       dir->basebuf, stk->baselen,
 					       &stk->filebuf, el, 1);
 		dir->exclude_stack = stk;
@@ -1479,13 +1478,14 @@ void free_pathspec(struct pathspec *pathspec)
 
 void free_directory(struct dir_struct *dir)
 {
+	struct exclude_stack *stk;
 	int st;
 	for (st = EXC_CMDL; st <= EXC_FILE; st++)
 		free_excludes(&dir->exclude_list[st]);
 
-	struct exclude_stack *prev, *stk = dir->exclude_stack;
+	stk = dir->exclude_stack;
 	while (stk) {
-		prev = stk->prev;
+		struct exclude_stack *prev = stk->prev;
 		free_exclude_stack(stk);
 		stk = prev;
 	}
diff --git a/pathspec.c b/pathspec.c
index 10f6643..9525c7c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -88,10 +88,10 @@ const char *treat_gitlink(const char *path)
 
 void treat_gitlinks(const char **pathspec)
 {
+	int i;
+
 	if (!pathspec || !*pathspec)
 		return;
-
-	int i;
 	for (i = 0; pathspec[i]; i++)
 		pathspec[i] = treat_gitlink(pathspec[i]);
 }
diff --git a/pathspec.h b/pathspec.h
index 4ed40a5..b7c053a 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -2,5 +2,5 @@ extern void validate_path(const char *prefix, const char *path);
 extern const char **validate_pathspec(const char *prefix, const char **files);
 extern char *find_used_pathspec(const char **pathspec);
 extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
-extern const char *treat_gitlink(const char **path);
+extern const char *treat_gitlink(const char *path);
 extern void treat_gitlinks(const char **pathspec);
-- 
1.7.12.1.441.gae568b5
