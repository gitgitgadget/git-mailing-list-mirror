Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674281;
	b=0i2VR212TSYXsMFcyKeNnLRYMKf5TlZvYW7NnrBpZwfq9pdrHYySea/tSsE0mfWpbcJj
	 1lR647qGFVNf995hPZC3AnUzCCJjNhQHleKW7OVDzpgBzEcZps/QG3hoafZf0ij+v4mkH
	 BoVRVWsHpLvvR/yn1IOw04fbxdrECntMXNKGA6aDi2NVdErEsI7DJ0o1KKdBdSWxbCHoz
	 JJpZjF6fOKifsMhFPEhRf/k3Ctz9iKFFfce6fyu4g4ymTenikwJIhnOf66jneW6suzeeK
	 lOVMy7qZj2P8zEmxVX7PhDT0eEhpLoSIFHa9tlehAGBx5gQTcXRGCWE+m6c+7Qx12ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bx0IK+ksPf/M20z9VcXFJAv6YU5Tb7/2m3nHrqTgZOw=;
	b=Wq5lLyJuqh7chy+ATslzPA52pbpFsYdk/keLlYyk9h757qfCgkCfCNXlXI2Jtagq5LcG
	 R5ejCaXXKLTL4A5GZ8ervragTAIQUGlOerYmvmQdASVVgy6ndhUeIkONV66uupNbfmfO7
	 BdHuSKqj5Is+WOOI5zGf2ssLDwN/EOtx98yHnix85mpx/I1dRqfv+pSc5juRsEiwrXNcB
	 jFn6zww8kCPXqJRsbfictr/YXRfwAozPBope29tC86rBw2D1DTdnjPnNzBywk72UKRW3D
	 cK1sqNC/8MQI3Z5WqA0UHd92x8hFIw1095ea+jfYvhWoM3xLs4FlZxeTUwhcEadPfgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wUOUBlc8;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56892606A32E
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 16:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56892606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wUOUBlc8
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37986eb6fa2so1713426eec.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794674279; x=1795279079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bx0IK+ksPf/M20z9VcXFJAv6YU5Tb7/2m3nHrqTgZOw=;
        b=wUOUBlc8tU5IR4HhmoCICcfXwnEx0dj7zGZgQVYfWJwaH4dZtEqof8By138Q9xj3u3
         ber8QJE89JOHMg6ebNWCkT/KbxeKKc1RFbgjLkKZIJNqB2Zi0BAyN0J7pvtYPN3MPmV7
         T/r7ssqNYh4iBptJDD6cVmYknxqC6ZOgDWjmyh7zFQxHPvmByzMAKG9wGLuok+Boi0az
         77xjPtSMEmB1vscvTSVOZ/MqosWykqYNgJ3VpY7/78VOZo+8hkgovrMvlzfCJpOiRi4r
         gEHClp4YfOL/5qlpVLEYzpX51PlDR1neEmu24Im/aof/8st2fQyQWBthuAqRjfMN7tXH
         Z1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674279; x=1795279079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bx0IK+ksPf/M20z9VcXFJAv6YU5Tb7/2m3nHrqTgZOw=;
        b=KiWzOlv2pUyk9qluyuCt93xL7rHjlOhQp+P2iTuUQV7NZ/DNBOmBkT+O5C0C9Qn3wS
         nOgbTqvSP1c0DfU/b+CoOCCDN+4hQ9vxtEAdghgyTMb/163CfiE30p1KCl76ZWjMfMWz
         HXX+VGWOlPizNrsWtNRyaXW59eaKFPXBIiSM/IwHeoR3wljXTz7vysIV3af78fIq3gsH
         kevfwLPpASRftfKKkhFg4E/0xhPfHIQkaDcigABI8Bej6f3s4EiDWeFX/OdUgX97h4nT
         jkM8nJdmE8nK12W5LFT29BsILhedXLDWjbad19yd7u9++59K6F1vnG4jQMoBtuCQljXd
         UWdw==
X-Gm-Message-State: APuU4Z9c7pJjZr5Xq0FLKTGkHfGZbTlwye+hWnB7m967Zt/uP++iU/Xf
	2s0cW7FFj4AAD6h+ceGKE+A+Y1f1fcU3JTRj/u5nzWNF9fRtpGoPBqfK
X-Gm-Gg: AYBFou3wh0r8hSwd1oh8IcARmywUNTBiEsnzwBj9jiyAwOsgfSYSGKyOOIzD6IKyopa
	XGAwEL80HLdLSdChwQkMiOVROQdVYWnrjrtwDXEbPh+cu1m58oDRiPcD0j5kV+W4uEXEgt5OhmX
	RtX8FjDxtpi0O72fYMNhg1/3T3WIGAo/JjGP/YHIYSBnypZAi3HmmerDQhvD63VrNWGVARx+gy7
	+XghSpijuedpeDJTRZ+COULyeN/LIsBDobvuNn+sUhyzf3ipLZR56aKRZSaIFIaVl+mp4KZn3j0
	yQWB7oR+7JAXI9UVgBtxWiW56Y8Vy444dK1Z/dX9AE+OJU5eU/Y2HDS6pMJGIbwNwhdyTuELRW5
	iaIlUDbei8vPBiScfajL7s36VX14UsTW9Ma9zY6s9LMBcrr5CPLpC0xlzAq4qxIV3csJpZw65Fg
	q1EVtUXy8XZyhWfoBYlzqQyQ8CJOSIA9lTChOav5fsQXK9x3y3zMPyOlHq69/pOfrDIpXpHbQPJ
	9bMcUsp8MW9glJop8z0lYxBYkx+o7HnSCjYDoZPHoyad11YLZIa3FRnzgam34gNCplLE/wAQspR
	rKm8fexWJWRxtQkDioxHoQTnzkynd2FY+8mXXouX6m6Yh77VyO2U2unqNEaG5QPcUlOsk563LwN
	qxBpYt/v1arEFw1hirmerEF5rAWRIfiVfg4Y=
X-Received: by 2002:a05:701b:4512:20b0:1b4:fecf:4ec5 with SMTP id a92af1059eb24-1b5031737a5mr5611934c88.18.1794674279208;
        Sat, 14 Nov 2026 08:37:59 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm18093657c88.14.2026.11.14.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:37:58 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [GSoC Patch v9 2/5] submodule: use repository to find superproject
Date: Sat, 14 Nov 2026 22:07:12 +0530
Message-ID: <20261114163715.257705-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`get_superproject_working_tree()` currently uses `xgetcwd()` to
determine the repository whose superproject should be checked.

This is incorrect when `--git-dir` points to a repository different
from the one associated with the current working directory. In that
case, the current working directory may cause the function to return
the wrong superproject or an empty result.

Pass the `repository` to `get_superproject_working_tree()` so that the
superproject is determined from the repository being inspected rather
than the current working directory.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/rev-parse.c  |  2 +-
 submodule.c          | 43 ++++++++++++++++++++++---------------------
 submodule.h          |  2 +-
 t/t1500-rev-parse.sh | 20 ++++++++++++++++++++
 4 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 43693454d5..e1a6da0076 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -997,7 +997,7 @@ int cmd_rev_parse(int argc,
 			}
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
 				struct strbuf superproject = STRBUF_INIT;
-				if (get_superproject_working_tree(&superproject))
+				if (get_superproject_working_tree(the_repository, &superproject))
 					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
 				strbuf_release(&superproject);
 				continue;
diff --git a/submodule.c b/submodule.c
index 6fcb606f7e..4db90ef9b0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2610,34 +2610,35 @@ void absorb_git_dir_into_superproject(const char *path,
 	absorb_git_dir_into_superproject_recurse(path, super_prefix);
 }
 
-int get_superproject_working_tree(struct strbuf *buf)
+int get_superproject_working_tree(struct repository *r, struct strbuf *buf)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf one_up = STRBUF_INIT;
-	char *cwd = xgetcwd();
+	struct strbuf target_wt = STRBUF_INIT;
+	const char *worktree;
 	int ret = 0;
 	const char *subpath;
 	int code;
 	ssize_t len;
 
-	if (!is_inside_work_tree(the_repository))
-		/*
-		 * FIXME:
-		 * We might have a superproject, but it is harder
-		 * to determine.
-		 */
+	worktree = repo_get_work_tree(r);
+	if (!worktree)
+		goto out;
+
+	if (!strbuf_realpath(&target_wt, worktree, 0))
 		goto out;
 
-	if (!strbuf_realpath(&one_up, "../", 0))
+	strbuf_addf(&one_up, "%s/..", target_wt.buf);
+	if (!strbuf_realpath(&one_up, one_up.buf, 0))
 		goto out;
 
-	subpath = relative_path(cwd, one_up.buf, &sb);
+	subpath = relative_path(target_wt.buf, one_up.buf, &sb);
 
 	prepare_submodule_repo_env(&cp.env);
 	strvec_pop(&cp.env);
 
-	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
+	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", one_up.buf,
 		     "ls-files", "-z", "--stage", "--full-name", "--",
 		     subpath, NULL);
 	strbuf_reset(&sb);
@@ -2648,14 +2649,14 @@ int get_superproject_working_tree(struct strbuf *buf)
 	cp.git_cmd = 1;
 
 	if (start_command(&cp))
-		die(_("could not start ls-files in .."));
+		die(_("could not start ls-files in %s"), one_up.buf);
 
 	len = strbuf_read(&sb, cp.out, PATH_MAX);
 	close(cp.out);
 
 	if (starts_with(sb.buf, "160000")) {
 		int super_sub_len;
-		int cwd_len = strlen(cwd);
+		int wt_len = target_wt.len;
 		char *super_sub, *super_wt;
 
 		/*
@@ -2666,12 +2667,12 @@ int get_superproject_working_tree(struct strbuf *buf)
 		super_sub = strchr(sb.buf, '\t') + 1;
 		super_sub_len = strlen(super_sub);
 
-		if (super_sub_len > cwd_len ||
-		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
-			BUG("returned path string doesn't match cwd?");
+		if (super_sub_len > wt_len ||
+		    strcmp(&target_wt.buf[wt_len - super_sub_len], super_sub))
+			BUG("returned path string doesn't match worktree?");
 
-		super_wt = xstrdup(cwd);
-		super_wt[cwd_len - super_sub_len] = '\0';
+		super_wt = xstrdup(target_wt.buf);
+		super_wt[wt_len - super_sub_len] = '\0';
 
 		strbuf_realpath(buf, super_wt, 1);
 		ret = 1;
@@ -2681,10 +2682,10 @@ int get_superproject_working_tree(struct strbuf *buf)
 	code = finish_command(&cp);
 
 	if (code == 128)
-		/* '../' is not a git repository */
+		/* parent directory is not a git repository */
 		ret = 0;
 	else if (code == 0 && len == 0)
-		/* There is an unrelated git repository at '../' */
+		/* There is an unrelated git repository at parent directory */
 		ret = 0;
 	else if (code)
 		die(_("ls-tree returned unexpected return code %d"), code);
@@ -2692,7 +2693,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 out:
 	strbuf_release(&sb);
 	strbuf_release(&one_up);
-	free(cwd);
+	strbuf_release(&target_wt);
 	return ret;
 }
 
diff --git a/submodule.h b/submodule.h
index b10e16e6c0..1a465a1208 100644
--- a/submodule.h
+++ b/submodule.h
@@ -170,6 +170,6 @@ void absorb_git_dir_into_superproject(const char *path,
  * project is a submodule of. If this repository is not a submodule of
  * another repository, return 0.
  */
-int get_superproject_working_tree(struct strbuf *buf);
+int get_superproject_working_tree(struct repository *r, struct strbuf *buf);
 
 #endif
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 4174ca40c3..98e139f478 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -383,4 +383,24 @@ test_expect_success ':/ and HEAD^{/} favor more recent matching commits' '
 	)
 '
 
+test_expect_success '--show-superproject-working-tree works with --git-dir' '
+	rm -rf sub super &&
+	test_when_finished "rm -rf sub super" &&
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	(
+		cd super &&
+		git -c protocol.file.allow=always submodule add "../sub" sub &&
+		git commit -m "add submodule" &&
+
+		SUPER_ROOT="$(test-tool path-utils real_path .)" &&
+		MODULE_DIR="$SUPER_ROOT/.git/modules/sub" &&
+
+		echo "$SUPER_ROOT" >expect &&
+		git --git-dir="$MODULE_DIR" rev-parse --show-superproject-working-tree >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.56.0-rc2

