Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067311;
	b=pZWku1X4ytV94q4mZ5h+nuSBLYNiXd/inQ6jk4mbvJYYqj7s4bl4fu6nXHEHqvfoDFUc
	 9wlJ06uARyviboyuhdSRvCAab8asY16ZiusAIQTXKgnM8L3cyNrJIk8vN++/tN7/C+P7T
	 9sLG16b3wtojhepo8iZL5axEyLYYiptWaXa4/l2C3ZumtWSuwTyVdxYzA9q9AOctNZ/mK
	 TyOGJvyXGtNRp9PhcJVsVMOssZR1i6NgTpOLLgGsG34MKyGDmoAVk3a3U4gWWr1Z5eR1s
	 efu4Z6cGvMFbKdFFH5QZtqMT3kwu5RhmCgdaIfYYnCzos5DmsrxBDoEV+bqMUZ2pYBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bx0IK+ksPf/M20z9VcXFJAv6YU5Tb7/2m3nHrqTgZOw=;
	b=xKMWex2JoyAQXABiM0R62PAPkTSDKcUdHxYnVaoN07sEbaL1+/YE86rmCpHJWRHrwZ5b
	 CmOY80WQzlWbi+mk0SVp2cmpR7CMrZrR2WZe9BjhmZeKf74mUVnbemRMJxV9hypzIsRQp
	 yt280xbilmfW25vZOGsMoDE36Q1YMXw0X59e7d2LqvYJJcLfWpvZxxmOZX8tcoqRoidHg
	 vsz4CCyyxIT8p35PJR7zXeG4jSNGkKinM/lXZssa7nbaGYKlNpjBUWyIn/dPZuyOFCuL2
	 ZkQBigUaSitRZx5HBEXYTebG+BuFcbAZA+f4TwQjKEYx96oVCEeDE/h9Ey6g3TR4lQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MPJpJ6K9;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8756606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 16:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8756606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MPJpJ6K9
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1adbf62dd31so2064760c88.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 08:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067310; x=1794672110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bx0IK+ksPf/M20z9VcXFJAv6YU5Tb7/2m3nHrqTgZOw=;
        b=MPJpJ6K9tl5hcgIAINEQthqhmt1EgYvRpZLiX5k+MMBcP8JgciYeGBTw/n0Zgs/JPX
         1xe69ihLyNDj1xGC4SeAO9EDZVfkLcKTW1pL/vM1MmS0BiXLYD7GbF4hEMoEQhbDbZEa
         4m+lpzdPQ1X1DwhZCG6y97nQyFCa9hsdC4koM6zaib89guBWLhabRrA2Ckx++mOpvIUE
         +w0lqDjONyRAJYAfpxHG6FzVbj1hGTtxTbgCbrTcUdB/rEndV06aNR2d2P+oUZRzU2oX
         kXx55oWkzW1r4+w+PmtPr2C1Z6BDgnk5vVJAIockT3Zqs1zpa9eNCQs/3oK8EBOC7TVC
         nTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067310; x=1794672110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bx0IK+ksPf/M20z9VcXFJAv6YU5Tb7/2m3nHrqTgZOw=;
        b=tTUPeDoxCALhgyEoX0kQd8pFASgqu6CSrNtpFrstIVg0jLBrByy2G5AXl10FHfJEVa
         R1j0PWOZnZ3QviCRUWpX5CPPAkm7BXcV4CcMonoUFtdq1rz71ulAXJpWFeFaDEwBVMWD
         KNnxNtnf+OUAtasqZ3tJC0ae1ez3XaEAMmo2voof80/lchkHz4fcbG2RZYOrOluSRgz5
         m4n5xNt2JkfpVboIGOmEhNTjZkmB+xhyhdaaA8aAZqd8SFCoua9yp7ukf4+hctUS2FA/
         JXQJ579dSvNo6ROjr5p6veeaG/NPYR8mlOc26o8eyKDrIWVeiFGmV2qa/bPowyp8WUq4
         I4hg==
X-Gm-Message-State: APuU4Z/mWRihwKUDf7FhoiYNG35UFLfVucxaqtAs2xhfGUIFeCvrR3QU
	p/6aPlUPJKY4uw2IHVDElkUdnp/AXjhJTZUOhqWXHiCH4dkYhGWzUlDA
X-Gm-Gg: AYBFou27hEn9gT6T7eb8kxKvRPzkPEMNbJqMY581WWKNRQDOGd1qv6VgtOMjPPuECSn
	B7HpMg22CjlTocqtwNVFR8pr40FgDqWKc87KJaS/CmrAclbUf/AFFRzWWjfu9glU2um9I3saagS
	2lZIO6m9cx6hnTvgb9WRNjgc6DrxkwkBbLX8v8BD7pBH1z75ne30ls5+N6obZFOXNskaflL8au2
	OKn5PDDmytEXq/o7bR1DLHhp3hNME6K0TJ9BhpPXb2jXDqk55insZGNn+exyKsfbKw8h2t79cH8
	Dfo1Of9Sm15GiiD5BsbXPZ6XIsAHzuWYx/DPen7g4Ll6OBVgXaJSLDFnhG2Krq/4fEdVEh/UHcY
	IfzAZQmk+EO4VMdzHx2Ns++pRGga4RVgK3Hasz6mBuSWLY0jFADvtZw7BYLxe2G6AniYJ8K7Cbr
	6qUprOzdTO65yNMU4CH727eYN9LeYoRifKIRlTjRSsjP+eEgYvuVxpmw0KlhPg7L7UbwZbHn3jb
	7B/TMEX+lrBZXn/jAOrZHC+Xc178TrHa6xn26ZtZt5b+bqLNVAISVyJZATtdC1OL7fzNi2nqOpP
	Wjb29mjjhyU6/j5UbtSAj0/owR4Bl/jzLTPowfUjYJEAOHzl3PUjUGa7cY0iWZRDTHw4jrGoAKK
	bk3De4WiYLjx1sqsewlU7fgF+Q8rSbrztOsM=
X-Received: by 2002:a05:7022:294:20b0:19f:527d:96da with SMTP id a92af1059eb24-1b25d38771amr7292370c88.33.1794067309852;
        Sat, 07 Nov 2026 08:01:49 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a5628sm16264618c88.10.2026.11.07.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:01:49 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v8 2/7] submodule: use repository to find superproject
Date: Sat,  7 Nov 2026 21:30:55 +0530
Message-ID: <20261107160100.122243-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
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

