Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704586;
	b=jnjVnlp4856et3lAjc7cU5s1G+3/ABWEA6TL1LsQMP6PIzimq9N2s+QqRMt9i1iclbGd
	 Ri2GeiDUTHTOcnbMssyfN3JN/M7WlV2+JZn8gKVYtZIeoc28GTnQd2WwrsvWZpFrn+ueu
	 zAfTYwTmyorJWM8piumxzhT9BYq1LjNWA9pLkW1K0dCOY6TRRhNkNhX6WfjHIztLXp9e8
	 vMXXuefrrxelXH/SrKhskURHcFACPnnDVDWNe3typw7MM0MCEk6f5F1kvASgq5eHEG1jF
	 xGxkdq6viPmOoIgKC4D4TQp1RwrXpP7GTlMPlTlpjR8QBv2FsKMrFrgoCDaDjBn62WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M6XVBns5NqJeydZN3vvGDhgWGZnONGrrbQBZmJyLaok=;
	b=dnKSlR5A4cTehH/zRk6dEAY1q2juLAMH2bTuCCNuByQJOlgP3djnqHKh7RAUvQffc4RU
	 +ilN0Y7gsI7oBHJ7OqwqcWp7gmq7AJLysK40IMtrvXJUp0GK/wYjmMcAthboW7AKO5u/K
	 ZkzxJjhvpl/LE9ydAHt9Qaa+bxcI4OAeHtKQkuYBrM+Qrg+axwb3yOSnCmT9XTpCB0393
	 84xSlwqQnmJtxn10bmjf2RRAeWMv6z2F1d3M77oAbgjegshUBIvZJUJllmcViwAVoqqQG
	 M7kOcyXKTXXBGtI9ni8PkOfcnivsVeXz8gDDJFSuq+XpoJIuid3AQ4phK7feErswAhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mN9+XH6K;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA9606A325
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92EA9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mN9+XH6K
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4956869750eso1511315e9.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792704584; x=1793309384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M6XVBns5NqJeydZN3vvGDhgWGZnONGrrbQBZmJyLaok=;
        b=mN9+XH6KtSBLiEwQt6YA/oOja6sM4Xu6ZCPfBytQAX76JGow/P+c0KW7q6wZtj8vD2
         8l9bK5Lys7puNTV+3HBegQQ9gHgtRXngsZxvbVDthpO2tRKbn92ZRlT0G9JartCGdMKv
         XwUjJyKZfxg1QrfyBqjbea8+wGwWfCVODN0lZmnOksvqAkeEdfgEsc+wQs/x9UaflT2m
         Rbd8IA/+22ccVvbdYyjB/HzhBBaKHS9LLMq4NNfzn+PB+O0VwD3JVDhZSWl+ZsBXQcpQ
         dBpW3Tj+SWAa0FoYn0zcWMS8t5I52p77qPZJMSdmYtLNg7yXxnK8AwklxnPkxkN9nLmp
         PcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792704584; x=1793309384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M6XVBns5NqJeydZN3vvGDhgWGZnONGrrbQBZmJyLaok=;
        b=G2vJzYNnA6wh6xX6xtUGD5YGQRCG7FH7pFTYcZE/HBoN2hICjbK5dIYVKzeTojQ8H6
         GHWeCEODze3Wp/R0Ic9aG3NZMqVC//VRJDBKLHDh9TehzYdBCk7t18Q+MQ7MBfq1nIQO
         1TvzWI9eCjU7Wca2XmmfiD/8Og+t35OjYK8hJGmzPYt/PoxXeYWG0W7P5gfbFmCc4URl
         4RvVjJTeyrb/Tjzpw8Cg0FD40dgtMR/12NvD5VioP41UuGd88m7NihWVKDA3PuFb06LW
         /1zutLkz+f6II8+bizW315CrXGBmPrE1HCJPS4gM0lwTQVJwj7Otf250b7RIBXrKA63K
         HxIw==
X-Gm-Message-State: AFq9FYJFgosapVP+iWLi3dQX0+MYjr5HhnJ0fdMBnYj3F5TAPfyC42M/
	Y0vmwH6EiT/+nn75AXaLcHFJumpaoFY+Uw72Z5ZrW4CRMsW3zdlaS+nE2BK7ERAy
X-Gm-Gg: AYBFou0tuYbkXv1tuLWs6XpCv5ahPxwgJg89mjfzl0DcKW3gMAO1WxJRNepzGd3TXww
	ju7NjflX+wXjLAUZKzO9URfss5yXuVvVWEJUR3XS8OMiHjIZXBfGYEnVvMFTGzaAveB8rcBjhbf
	rkeyqBxujEj+n9M3vyWF1fSWIoLI8FOGc13Vmy0WqzUiPiDsxgEo4joCEK2ayymUzdvev5gT72e
	u1IczKfdPuLG9pn+t4iGFvDidZJjkKWt3doYG/7dSU3g8ZqAHPxO8W52DBqj1x9Min6068dBI1v
	oB/X5iEuAzxK2s8QPuhwJhEHXXK9Bvj8uvZu7TO/3tTjeTbvvhsMHSk+tTLpQ49GfwAdVq38v9k
	VSBRnfugR5fdocVKyWBmtGfAsomSq1sR4d1G8HKmOANlAUhbBpAT+s/2QzoQCEfr35KdEaWAcsk
	3c9jBXvDuprKK9+pFTyXkQQWRTv9eKN8Dvs6tEUUPz7yg2wQ9/cF6GrsS2SulwZKOkNd3yabSsI
	3DAl2Wu7VyDT+448lAzPdx7G1k9lBPNPlfbOTcvUbosVjCQ8A8x5acAVC+NvB1T3H9arYpH8w4z
	oVf87TQ9nnQHZTkStvq8BVJJOWSxHkA8M8+YVCilArYvaO0H
X-Received: by 2002:a05:600c:83c9:b0:4a1:e46d:1bd4 with SMTP id 5b1f17b1804b1-4a211ef7badmr3850895e9.29.1792704583871;
        Thu, 22 Oct 2026 14:29:43 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38044e8fsm739355f8f.31.2026.10.22.14.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:29:43 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 3/5] doc: stop calling root refs pseudorefs
Date: Thu, 22 Oct 2026 22:28:51 +0100
Message-ID: <20261022212903.177261-4-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
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

Several manual pages still use "pseudoref" in its old sense of any ref
outside of "refs/", which the glossary now calls a root ref. Pseudorefs
have since been restricted to FETCH_HEAD and MERGE_HEAD, which are not
considered root refs.

Replace "pseudoref" with "root ref" in those pages, giving HEAD and
ORIG_HEAD as examples. In git-worktree(1), say that both root refs and
pseudorefs are per-worktree, and drop the description of them as being
directly under $GIT_DIR, because that does not apply to the reftable
backend.

In git-ls-remote(1), describe --refs as omitting refs outside "refs/",
since that is what it actually checks. In the example, refer to HEAD,
which is the only root ref that git-upload-pack(1) advertises. While
there, correct "symbolics" to "symbolic refs".

In git-update-ref(1), drop the incorrect mention of ORIG_HEAD. HEAD is
the only root ref that gets a reflog by default. Also restructure the
sentence to make it easier to parse.

In the description of core.logAllRefUpdates, correct the claim that
"always" only applies to refs under "refs/". It applies to root refs
too.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/core.adoc          |  2 +-
 Documentation/for-each-ref-options.adoc |  2 +-
 Documentation/git-ls-remote.adoc        |  4 ++--
 Documentation/git-update-ref.adoc       | 13 ++++++-------
 Documentation/git-worktree.adoc         |  9 ++++-----
 Documentation/rev-list-options.adoc     |  4 ++--
 6 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index bdc74d291c..8f8fe36a58 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -376,7 +376,7 @@ core.logAllRefUpdates::
 	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),
 	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.
 	If it is set to `always`, then a missing reflog is automatically
-	created for any ref under `refs/`.
+	created for any ref, including root refs such as `ORIG_HEAD`.
 +
 This information can be used to determine what commit
 was the tip of a branch "2 days ago".
diff --git a/Documentation/for-each-ref-options.adoc b/Documentation/for-each-ref-options.adoc
index 54e2fa95c2..2b6d4ede0b 100644
--- a/Documentation/for-each-ref-options.adoc
+++ b/Documentation/for-each-ref-options.adoc
@@ -73,7 +73,7 @@ TAB %(refname)`.
 	using the same rules as _<pattern>_ above.
 
 `--include-root-refs`::
-	List root refs (`HEAD` and pseudorefs) apart from regular refs.
+	Also list root refs, such as `HEAD` or `ORIG_HEAD`.
 
 `--start-after=<marker>`::
     Allows paginating the output by skipping references up to and including the
diff --git a/Documentation/git-ls-remote.adoc b/Documentation/git-ls-remote.adoc
index d71c4ab3e2..7ce7df3149 100644
--- a/Documentation/git-ls-remote.adoc
+++ b/Documentation/git-ls-remote.adoc
@@ -35,7 +35,7 @@ OPTIONS
 	with other git subcommands.
 
 --refs::
-	Do not show peeled tags or pseudorefs like `HEAD` in the output.
+	Do not show peeled tags or refs outside `refs/`.
 
 -q::
 --quiet::
@@ -118,7 +118,7 @@ line shows the name of the object the tag points at.
 EXAMPLES
 --------
 
-* List all references (including symbolics and pseudorefs), peeling
+* List all references (including `HEAD` and symbolic refs), peeling
   tags:
 +
 ----
diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 37a5019a8b..c775334230 100644
--- a/Documentation/git-update-ref.adoc
+++ b/Documentation/git-update-ref.adoc
@@ -163,13 +163,12 @@ still see a subset of the modifications.
 
 LOGGING UPDATES
 ---------------
-If config parameter "core.logAllRefUpdates" is true and the ref is one
-under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
-like HEAD or ORIG_HEAD; or the file "$GIT_DIR/logs/<ref>" exists then
-`git update-ref` will append a line to the log file
-"$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before creating
-the log name) describing the change in ref value.  Log lines are
-formatted as:
+If config parameter "core.logAllRefUpdates" is true and the ref is
+HEAD or one under "refs/heads/", "refs/remotes/" or "refs/notes/", or
+if the file "$GIT_DIR/logs/<ref>" exists, then `git update-ref` will
+append a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
+symbolic refs before creating the log name) describing the change in
+ref value.  Log lines are formatted as:
 
     oldsha1 SP newsha1 SP committer LF
 
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index e6e77252ab..f0eb6d4137 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -303,11 +303,10 @@ but others are specific to an individual worktree. One example is `HEAD`,
 which is different for each worktree. This section is about the sharing
 rules and how to access refs of one worktree from another.
 
-In general, all pseudo refs are per-worktree and all refs starting with
-`refs/` are shared. Pseudo refs are ones like `HEAD` which are directly
-under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are exceptions,
-however: refs inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are
-not shared.
+In general, all root refs and pseudorefs are per-worktree and all refs
+starting with `refs/` are shared. There are exceptions, however: refs
+inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are not
+shared.
 
 Refs that are per-worktree can still be accessed from another worktree via
 two special paths, `main-worktree` and `worktrees`. The former gives
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index bd9f345690..822604278a 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -350,8 +350,8 @@ Under `--pretty=reference`, this information will not be shown at all.
 
 `--merge`::
 	Show commits touching conflicted paths in the range `HEAD...<other>`,
-	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
-	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
+	where `<other>` is the first of `MERGE_HEAD`, `CHERRY_PICK_HEAD`,
+	`REVERT_HEAD` or `REBASE_HEAD` that exists. Only works
 	when the index has unmerged entries. This option can be used to show
 	relevant commits when resolving conflicts from a 3-way merge.
 
-- 
2.56.0

