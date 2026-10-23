Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767829;
	b=uqXz+HlMz+AiWYZK2WGw4k9hpHdiZDABQiX0tyK3rvYGbBP5qtAkuMpOXofXI7gIEbus
	 uO89efOQs1VPpY0fZhfKoPgBQPOFbRnJd9LhOdCHYa3v8IYy1mQ4krGiwxKf5T1dmPgnW
	 Lq/eMwXQW5+jpVuELUCJx3lqh6cEMP2U2qMX0XCOO61fpUDBj13yep+Jnsyu7MaRlCenx
	 AF20lL6z9EsX8YZJK9+66o3RIPQw9yUcRcd5+cmrysrgn+5DMZUO6tvRYI9w/FsEyFh+t
	 8pZVIi6SxBgxAbu64nRqvwB30OrYdYwbN0jVwmdiEDBf2CELVU8wwujTL05JKx60eZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nP33zGlcc5UG6ZeyRtxBEpWpQWpcYsMgBRJLL0UIMGk=;
	b=DIeQDArAhJTR7KqVjMsBTux6610E7k2w52aB29scb3JZuCSAJy9ObF2IvTFLeAoC2oau
	 1pg8Dg83PFk9GjIWUKmYwyBWfFCPVbMRI70hJxjeAvna+MUiI3Ie34pizMxen30HCLY1q
	 QdHZz9SbjmqVuSzIB56ykT66rV2WZdA2HY/Bt3oixXwgx2/Ek7FL3AI7yiqxVaoKxeFyk
	 q64J1vPNpsr3g/5jjv2557qwn4mXYNp8PoO/eF5BxZVY4DCubgl2tot+pYpfl2rQ6AriW
	 j55CSxfsWp+WO502YT8PAcUHdIMMZqWW4cXdUurxyUsngNslFSzzOoD9EtNMFzHYIMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HYbkS8x5;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CE606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D3CE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HYbkS8x5
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso10967885e9.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792767828; x=1793372628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nP33zGlcc5UG6ZeyRtxBEpWpQWpcYsMgBRJLL0UIMGk=;
        b=HYbkS8x5pAnsXFMM/8lBBRrYOYbS2guuecXFQeuCBQtBgz2VLz0O20TUkyo6SOljnp
         shkgKQ6B2Dz/einEeNIkaSsCgacOJTc0uQGx/iPVA9Nvad1ADe5I3M5mabchuTRThhyj
         73uRmH8MXJ5R70NvXrWU9jp0oK0NFl2/NPi/j61LrUVG+TJGmAKRMij/TT70Gzuta2lH
         ryMgqdlL1l0OzNM8lfvODgiKud4MwKc+iThxc/+cfEvhF/YSmF6Adc48NLkONlrdnCrm
         zo8E7gHKzdwG9RFcmdtzq5mmjso+fR/EwA1W20OOuG6kXoj0MkHs8DEiQBEr7B+OM5f2
         og5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767828; x=1793372628;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nP33zGlcc5UG6ZeyRtxBEpWpQWpcYsMgBRJLL0UIMGk=;
        b=MrVMIFILyGTYKIPKI/JXZSyh4miLdZUEghxfi5GiHpsgcIgQyKaWQvA/ci3DmleBWC
         bnuLjgjD2WRvhLx+ThiF8q/+Yv4zrmd0GTKXou0jPY80mQVozQyjlvsPcEt65PeVYPcx
         Qb50EUz0SVOWzKIceY1ZTrDRCOb41VJj1JrLtHaZsESmTWglFvAiYCEiqgDBl/E+pxaF
         UihP95GqfXk1Pdq+icybe9qjRc+XR0PtMePT926UwW7qzjQfO3KaBXT1GAQXHuXaAzNt
         OdDMu335CjPFhY3ZHQJFTReP4j9NzpO4DMj/vYClTa3kT+G41gHU3q0T7YoSS8bNXanX
         o2rg==
X-Gm-Message-State: AFq9FYKrWYkbRY+aHfrfdd4ciDVlsuWxpm05kAZQ97W0DgUrVz9rxxym
	ZGQbBXEihfNeTf4Mr1zrEtTax4TetMDkrQglX3otc7s7mxxhizpxiBIp992SiQ==
X-Gm-Gg: AYBFou2m1wucBsx1xyUx10EVmKiJABWoWwY20aB9kfjd4KUylZ5oL4jQLdSAYr35vWd
	LTq5fbzaUiRvojfC+P0ay7wrh6gu2ApVCWpn2SJJNabLWgE2eUJ5g/m9TUT+i+vCirzBStVrF7X
	5Ewr6NdS6S0O3GQ0jEh0ZjC8H7evZTbotG46PU6Nztxr+nsmC5oYitwEXGxWRQqWFw+wZXo68EA
	VihEyiwbbFtSz7BI4OlPJZZe2fzVDrg5nHu7wjiGPphS7/12N+oszAnon37wDrSiGjIheYpt63T
	20uj99xjhvAfZmVcvMnEErbpi+xiFCFv4OUHQTg7ovGFqTR2qjzc/yhgqMHgl5Lg0BcxBJBm8Gq
	9bgigcu5hkmgVK5/GZZK8Pgqu0h64FKshd3ZCDdz6U0Uw+0jRtPSVPb3ADHTnmzf8x2YO3aaHKN
	8qXHOzjmPbTzhqOgFTpKzydcsJ1n+TvhRcZueTAnUB1egfoHwoui9zatpAbxI+xff3Pzeyr6auw
	FFfIo+V2V56ieNAn3evY3oB0nOtQY4Zb9hpzFItLTsSQoZy64VAW9IWkZU=
X-Received: by 2002:a05:600c:4443:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4a211cb8a1dmr44646185e9.11.1792767827207;
        Fri, 23 Oct 2026 08:03:47 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d427e68sm296326f8f.52.2026.10.23.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:03:46 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 0/7] stash creation: avoid unecessary index loads and refreshes
Date: Fri, 23 Oct 2026 16:03:28 +0100
Message-ID: <cover.1792767794.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
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

"git stash push" and "git stash create" load and refresh the index
multiple times when they only need to do it once. This series removes
a number of calls to repo_read_preload_index() and refresh_index()
which reduces the number of lstat() calls on each changed path by
four for "git stash create" and eight for "git stash push". It also
removes a duplicate call to check_changes() so that when stashing
untracked files we only walk them once.

Thanks to Junio for his comments on V3

Changes since V3:
 - Avoid implict cast of enum create_result to int in create_stash()
 - Fixed enum initializers
 - Use switch() rather than if() when checking enum create_result
   return values

Changes since V2:
 - Fixed a typo in patch 4
 - Rewrote commit message for patch 5

Changes since V1:
 - Added an enum for the various return values from do_create_stash()
 - Fixed typos in the commit message of patch 2 (was patch 1)
 - Removed an unnecessary index refresh and several unnecessary index
   preloads

Cover letter for V1:

"git stash push" and "git stash create" check if there are
any unstaged or uncommitted changes at startup, and then again
when they try to create the stash. This short series removes
that duplication of effort which I spotted while looking at
<20260929074222.11942-1-kazumasa.shigeta@kanamei.com>.

base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fstash-optimize-check_changes-calls%2Fv4
View-Changes-At: https://github.com/phillipwood/git/compare/c46c1e377...f61ebbf9a
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/stash-optimize-check_changes-calls/v4


Phillip Wood (7):
  stash: use an enum for create status
  stash create: remove duplicate changes detection
  stash push: remove duplicate changes detection
  stash push: avoid duplicate calls to preload_index()
  stash create: rework temporary index creation
  stash create: remove unnecessary index load and refresh
  stash: simplify reset_tree() function signature

 builtin/stash.c | 167 ++++++++++++++++++++++++------------------------
 1 file changed, 85 insertions(+), 82 deletions(-)

Range-diff against v3:
1:  9e27bcd676e ! 1:  685914011f9 stash: use an enum for create status
    @@ builtin/stash.c: static int save_untracked_files(struct stash_info *info, struct
     +				  struct strbuf *out_patch, int quiet)
      {
     -	int ret = 0;
    -+	enum create_result ret = 0;
    ++	enum create_result ret = CREATE_SUCCESS;
      	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
      	struct index_state istate = INDEX_STATE_INIT(the_repository);
      
    @@ builtin/stash.c: static int stash_staged(struct stash_info *info, struct strbuf
     +		struct interactive_options *interactive_opts)
      {
     -	int ret = 0;
    -+	enum create_result ret = 0;
    ++	enum create_result ret = CREATE_SUCCESS;
      	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
      	struct commit *head_commit;
      	const struct object_id *head_tree;
    @@ builtin/stash.c: static int stash_working_tree(struct stash_info *info, const st
     +		int quiet)
      {
     -	int ret = 0;
    -+	enum create_result ret = 0;
    ++	enum create_result ret = CREATE_SUCCESS;
      	int flags = 0;
      	int untracked_commit_option = 0;
      	const char *head_short_sha1 = NULL;
    @@ builtin/stash.c: static int do_create_stash(const struct pathspec *ps, struct st
      	if (patch_mode) {
      		ret = stash_patch(info, ps, patch, quiet, interactive_opts);
     -		if (ret < 0) {
    -+		if (ret == CREATE_ERROR) {
    ++		switch (ret) {
    ++		case CREATE_ERROR:
      			if (!quiet)
      				fprintf_ln(stderr, _("Cannot save the current "
      						     "worktree state"));
    - 			goto done;
    +-			goto done;
     -		} else if (ret > 0) {
    -+		} else if (ret != CREATE_SUCCESS) {
    - 			goto done;
    +-			goto done;
    ++			/* fallthrough */
    ++		case CREATE_EMPTY:
    ++			goto done;
    ++
    ++		case CREATE_SUCCESS:
    ++			break;
      		}
      	} else if (only_staged) {
      		ret = stash_staged(info, patch, quiet);
     -		if (ret < 0) {
    -+		if (ret == CREATE_ERROR) {
    ++		switch (ret) {
    ++			case CREATE_ERROR:
      			if (!quiet)
      				fprintf_ln(stderr, _("Cannot save the current "
      						     "staged state"));
    - 			goto done;
    +-			goto done;
     -		} else if (ret > 0) {
    -+		} else if (ret != CREATE_SUCCESS) {
    - 			goto done;
    +-			goto done;
    ++			/* fallthrough */
    ++			case CREATE_EMPTY:
    ++				goto done;
    ++
    ++			case CREATE_SUCCESS:
    ++				break;
      		}
      	} else {
      		if (stash_working_tree(info, ps)) {
    @@ builtin/stash.c: static int do_create_stash(const struct pathspec *ps, struct st
      		goto done;
      	}
      
    +@@ builtin/stash.c: static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
    + static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
    + 			struct repository *repo UNUSED)
    + {
    +-	int ret;
    ++	enum create_result create_res;
    + 	struct strbuf stash_msg_buf = STRBUF_INIT;
    + 	struct stash_info info = STASH_INFO_INIT;
    + 	struct pathspec ps;
     @@ builtin/stash.c: static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
    + 	if (!check_changes_tracked_files(&ps))
    + 		return 0;
      
    - 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
    - 			      NULL, 0);
    +-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
    +-			      NULL, 0);
     -	if (!ret)
    -+	if (ret == CREATE_SUCCESS)
    ++	create_res = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
    ++				     NULL, 0);
    ++	if (create_res == CREATE_SUCCESS)
      		printf_ln("%s", oid_to_hex(&info.w_commit));
      
      	free_stash_info(&info);
      	strbuf_release(&stash_msg_buf);
     -	return ret;
     +	/* Do not return an error if there are no changes */
    -+	return ret == CREATE_ERROR ? -1 : 0;
    ++	return create_res == CREATE_ERROR ? -1 : 0;
      }
      
      static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
    @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
     +	create_res =  do_create_stash(ps, &stash_msg_buf, include_untracked,
     +				      patch_mode, interactive_opts, only_staged,
     +				      &info, &patch, quiet);
    -+	if (create_res != CREATE_SUCCESS) {
    ++	switch (create_res) {
    ++	case CREATE_ERROR:
    ++	case CREATE_EMPTY:
      		ret = -1;
      		goto done;
    ++
    ++	case CREATE_SUCCESS:
    ++		break;
      	}
    + 
    + 	if (do_store_stash(&info.w_commit, stash_msg_buf.buf, 1)) {
2:  d56b7c6f672 ! 2:  d2773fc82eb stash create: remove duplicate changes detection
    @@ builtin/stash.c: static int create_stash(int argc, const char **argv, const char
     -	if (!check_changes_tracked_files(&ps))
     -		return 0;
      
    - 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
    - 			      NULL, 0);
    + 	create_res = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
    + 				     NULL, 0);
3:  36fc0eb9130 ! 3:  785d2a663da stash push: remove duplicate changes detection
    @@ builtin/stash.c: static enum create_result do_create_stash(const struct pathspec
      		goto done;
      	}
      
    +@@ builtin/stash.c: static enum create_result do_create_stash(const struct pathspec *ps,
    + 						     "worktree state"));
    + 			/* fallthrough */
    + 		case CREATE_EMPTY:
    ++		case CREATE_NO_CHANGES:
    + 			goto done;
    + 
    + 		case CREATE_SUCCESS:
    +@@ builtin/stash.c: static enum create_result do_create_stash(const struct pathspec *ps,
    + 						     "staged state"));
    + 			/* fallthrough */
    + 			case CREATE_EMPTY:
    ++			case CREATE_NO_CHANGES:
    + 				goto done;
    + 
    + 			case CREATE_SUCCESS:
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
      		free(ps_matched);
      	}
    @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
      		ret = -1;
      		if (!quiet)
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
    - 	create_res =  do_create_stash(ps, &stash_msg_buf, include_untracked,
      				      patch_mode, interactive_opts, only_staged,
      				      &info, &patch, quiet);
    --	if (create_res != CREATE_SUCCESS) {
    -+	if (create_res == CREATE_NO_CHANGES) {
    + 	switch (create_res) {
    ++	case CREATE_NO_CHANGES:
     +		if (!quiet)
     +			printf_ln(_("No local changes to save"));
     +		ret = 0;
     +		goto done;
    -+	} else if (create_res != CREATE_SUCCESS) {
    ++
    + 	case CREATE_ERROR:
    + 	case CREATE_EMPTY:
      		ret = -1;
    - 		goto done;
    - 	}
4:  a9875ba5b35 ! 4:  32f7c97b7c0 stash push: avoid duplicate calls to preload_index()
    @@ builtin/stash.c: static int create_stash(int argc, const char **argv, const char
      	memset(&ps, 0, sizeof(ps));
      
     +	repo_read_index(the_repository);
    - 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
    - 			      NULL, 0);
    - 	if (ret == CREATE_SUCCESS)
    + 	create_res = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
    + 				     NULL, 0);
    + 	if (create_res == CREATE_SUCCESS)
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
      		goto done;
      	}
5:  de5e0c196a9 = 5:  b62d3d080a8 stash create: rework temporary index creation
6:  61e4ce22a0f = 6:  8c54c118307 stash create: remove unnecessary index load and refresh
7:  a486a625c95 = 7:  f61ebbf9a3e stash: simplify reset_tree() function signature
-- 
2.56.0.134.g299a3c16181

