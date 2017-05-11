Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC212018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756150AbdEKNsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:65535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756133AbdEKNss (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:48:48 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0y47-1e1axm1zah-00vAwl; Thu, 11
 May 2017 15:48:29 +0200
Date:   Thu, 11 May 2017 15:48:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/11] PREVIEW: remove support for .git/remotes/ and
 .git/branches/
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <c73881261cc3021410695126989c6f1596f638b0.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1n0V7lsTvt8bzS1oU7io8jaaeRRkr6ua8SFSrqORgpv/9KWhMX3
 oLlU3AtZI+pgmYhYa1YEeyxvMGXg6QGVEqsMqOHzt2xxi6xrsJU1gLZrbQEqWwyri4vWDsA
 16ZlkWK1n5vj+zvVtZMtQv82L3OyGMnZlPL9fLyeo/uojmVsX6lLvCR+le4XyJL0iqNlgsH
 xsO+Tq5H/Tw8MPISL8Dxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FzsMcYq6j1A=:pM9Ez2PKZQBsN3UfJvm0M8
 /xO3w7Q0GkKjMYhzB1Rk6UFHQmthYytaeVAFbPNyhW4Th0DYdPd7HjAwA7NyFfBhjqc/rNdhx
 bSJ/ifB7XRIuFQ4SJY2CJhdZv0b7JizYMOwlMMYdhxAThnq0Okze9TkUdlyK0Z9oiQgDDpIjO
 5WQxAyH3qZKGDe6bv2qFmaw/NlMb31UrUVyk+0Mtui8JVmKDR+bPN02pjfbk4iUZmvaxZR/rO
 NHxs33nunJFwD8YQjUFhA5YRSqPf/f/CLJuTA3tA2fHSmyY4SNUOZVhidDLgknwpYgnZULVPe
 653huMGVdoBIPrjyfMgGTBJzQqAQohEBp7vKAKYhNdsfPXW/DLaIy0phSZ7zChV7k7NJIzkZw
 dUIq4vypcgfq0xpLLhaQzrKil8ziYEgihQg3Uk4Pv9d5K/DwdksjsBBHrfb4BSAozpIAicX8j
 YKjLD/bBtHCt5Ds5M/NbzHJtVP5U6RBXrJSaNy9LAE1vnHCGCUgM3ruZ7zdhd1NXgsH3sqxPb
 4hCfC/LXVHYBBPXS2j5EhxyVfm92294EexHr6aQbetKFJkBnBnUCAveZjJyA4nPr5jo/rDfjx
 7LEciuEseAm88fdE2SgGtT/psckf+Qiyp8/r+w28YtfvMhGa78BzLyKiRNb1P2BCrdSsOWpOS
 rH2915pQcaAN3O3Y/QnyCBPYu/Utp10IJO3DTz4b37OK6qOIOPFYIvjJIfK201QKWHsHnbQUs
 ZbZ/grVvQEJ3gwbiBu0WKsFThbnX+JyonSq7oCWU+bdt9cIacYwVFF9uVhTPVvtCoteL2M79m
 cqnn44h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At long last, after a cycle or three of warning users who *still* use
the ancient feature of .git/remotes/ and .git/branches/, it is time to
retire the code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 path.c   |  2 --
 remote.c | 96 ----------------------------------------------------------------
 remote.h |  4 +--
 3 files changed, 1 insertion(+), 101 deletions(-)

diff --git a/path.c b/path.c
index c1cb1cf6273..ee709bb2337 100644
--- a/path.c
+++ b/path.c
@@ -104,7 +104,6 @@ struct common_dir {
 };
 
 static struct common_dir common_list[] = {
-	{ 0, 1, 0, "branches" },
 	{ 0, 1, 0, "hooks" },
 	{ 0, 1, 0, "info" },
 	{ 0, 0, 1, "info/sparse-checkout" },
@@ -115,7 +114,6 @@ static struct common_dir common_list[] = {
 	{ 0, 1, 0, "objects" },
 	{ 0, 1, 0, "refs" },
 	{ 0, 1, 1, "refs/bisect" },
-	{ 0, 1, 0, "remotes" },
 	{ 0, 1, 0, "worktrees" },
 	{ 0, 1, 0, "rr-cache" },
 	{ 0, 1, 0, "svn" },
diff --git a/remote.c b/remote.c
index b2ae168035e..914ff74c0d2 100644
--- a/remote.c
+++ b/remote.c
@@ -241,89 +241,6 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 	rewrite->instead_of_nr++;
 }
 
-static const char *skip_spaces(const char *s)
-{
-	while (isspace(*s))
-		s++;
-	return s;
-}
-
-static void read_remotes_file(struct remote *remote)
-{
-	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
-
-	if (!f)
-		return;
-
-	warning(_("the remote '%s' uses the long-deprecated '%s' file"),
-		remote->name, git_path("branches/%s", remote->name));
-
-	remote->configured_in_repo = 1;
-	remote->origin = REMOTE_REMOTES;
-	while (strbuf_getline(&buf, f) != EOF) {
-		const char *v;
-
-		strbuf_rtrim(&buf);
-
-		if (skip_prefix(buf.buf, "URL:", &v))
-			add_url_alias(remote, xstrdup(skip_spaces(v)));
-		else if (skip_prefix(buf.buf, "Push:", &v))
-			add_push_refspec(remote, xstrdup(skip_spaces(v)));
-		else if (skip_prefix(buf.buf, "Pull:", &v))
-			add_fetch_refspec(remote, xstrdup(skip_spaces(v)));
-	}
-	strbuf_release(&buf);
-	fclose(f);
-}
-
-static void read_branches_file(struct remote *remote)
-{
-	char *frag;
-	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(git_path("branches/%s", remote->name), "r");
-
-	if (!f)
-		return;
-
-	strbuf_getline_lf(&buf, f);
-	fclose(f);
-	strbuf_trim(&buf);
-	if (!buf.len) {
-		strbuf_release(&buf);
-		return;
-	}
-
-	warning(_("the branch '%s' uses the long-deprecated '%s' file"),
-		remote->name, git_path("branches/%s", remote->name));
-
-	remote->configured_in_repo = 1;
-	remote->origin = REMOTE_BRANCHES;
-
-	/*
-	 * The branches file would have URL and optionally
-	 * #branch specified.  The "master" (or specified) branch is
-	 * fetched and stored in the local branch matching the
-	 * remote name.
-	 */
-	frag = strchr(buf.buf, '#');
-	if (frag)
-		*(frag++) = '\0';
-	else
-		frag = "master";
-
-	add_url_alias(remote, strbuf_detach(&buf, NULL));
-	add_fetch_refspec(remote, xstrfmt("refs/heads/%s:refs/heads/%s",
-					  frag, remote->name));
-
-	/*
-	 * Cogito compatible push: push current HEAD to remote #branch
-	 * (master if missing)
-	 */
-	add_push_refspec(remote, xstrfmt("HEAD:refs/heads/%s", frag));
-	remote->fetch_tags = 1; /* always auto-follow */
-}
-
 static int handle_config(const char *key, const char *value, void *cb)
 {
 	const char *name;
@@ -652,13 +569,6 @@ void free_refspec(int nr_refspec, struct refspec *refspec)
 	free(refspec);
 }
 
-static int valid_remote_nick(const char *name)
-{
-	if (!name[0] || is_dot_or_dotdot(name))
-		return 0;
-	return !strchr(name, '/'); /* no slash */
-}
-
 const char *remote_for_branch(struct branch *branch, int *explicit)
 {
 	if (branch && branch->remote_name) {
@@ -700,12 +610,6 @@ static struct remote *remote_get_1(const char *name,
 		name = get_default(current_branch, &name_given);
 
 	ret = make_remote(name, 0);
-	if (valid_remote_nick(name) && have_git_dir()) {
-		if (!valid_remote(ret))
-			read_remotes_file(ret);
-		if (!valid_remote(ret))
-			read_branches_file(ret);
-	}
 	if (name_given && !valid_remote(ret))
 		add_url_alias(ret, name);
 	if (!valid_remote(ret))
diff --git a/remote.h b/remote.h
index 6c28cd3e4bf..921b3d43356 100644
--- a/remote.h
+++ b/remote.h
@@ -6,9 +6,7 @@
 
 enum {
 	REMOTE_UNCONFIGURED = 0,
-	REMOTE_CONFIG,
-	REMOTE_REMOTES,
-	REMOTE_BRANCHES
+	REMOTE_CONFIG
 };
 
 struct remote {
-- 
2.12.2.windows.2.800.gede8f145e06
