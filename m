Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521206;
	b=iNbqx+msMmMkr5f0m06O94Xt8ayT5L/+QycGLw/03kRcZ7GIVLdxp55gdYezHOzMmttw
	 al3PooLilmGovOoEx2Vd0K4TOYq+ag74WSzHN4S1JLQ8LHIBnB4ljIwUZKe607LG48Jpa
	 UlpdlU1yVfGz0yiaQ1ers7KPdnm2/BX6N5tPNYZdHcxQ8GEeByLpR94LvODuR6TYYLup/
	 KEFnm46o2ABsltV9FDWRtJX0j1P3w3Wl8rPycmLKbgh450IfGfqX59wbmS0lVmDQaqCL/
	 5fa21sXagBjZhkJ6CkwQwu6qJiTYrR/+TeuJxKG5G0vHnb3bCp0yIbt5LBrQueppHdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MtWM4+BFAso6vINplyni7uzgQUElcolARhxZ4dnWDgQ=;
	b=m/tSM1fho0QSj1kDGaJuo9VVnKQOq4A2/yIZ2/tDPgvRjugFUIsn9ZikQF1828qC3CAP
	 2/IitdQd/0I5KLY7nnRxlipobKCtLcb0MHLejD7ceLdMjZa55RbxOKKD0QV1YbyGXWXd4
	 2Xk+149gN1ruvs2ULcUg/uCzsS+XgzL3kLvmHa7PVcA6FZQtWipDW+RrkZkfYk00fp6sb
	 6GHlqIoyzzHK81tDFsriw/f/05cXwFID5BLGr+upDrkT4bWPDL+0tAeQdDTqzOMi7GHts
	 AXDKhM3nftvGG6v1bR7NqX91Q8jijGPcITsEIpxhydTCVk8ja0UEX8S3a3erw1FStxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uVPbhXvD;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7F606A327
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AA7F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uVPbhXvD
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so4276865e9.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794521204; x=1795126004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MtWM4+BFAso6vINplyni7uzgQUElcolARhxZ4dnWDgQ=;
        b=uVPbhXvDkok5MC++FEwv/YZ400AP2cQVFOFfRiyuJYETg/uY6bnT0VtM4xw9NPaTH0
         fLtfiH0KnLlwvdosgNm5ujBjqpXB72Y9fd67v9szTqEV088PH8XhPsOSqBAV3d9AgeDJ
         EROX1p3bW7Sa1d0DmTuzxDF72wN6CgZ6vQc7+D3Mbdm/fOe+lN0w85YAMvHsp+MSCR/H
         bWigXelL+5lmIRCYG0GoRuNmq5jHeKCP775CYoS6KSX8tpGi8iJcdbVJCcTyFsPwD2Vk
         DV6WA+LGlikRnEiLLpXv/G6JB0jTHxuBExt5/OhkRuPu3FQ5tAExc/wk+0UP6QEag2uq
         Q/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521204; x=1795126004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MtWM4+BFAso6vINplyni7uzgQUElcolARhxZ4dnWDgQ=;
        b=cLkkzz3Q9vOWCWNrR010gULpt8HapFRo9FZY319gCRi7NwmFBJkL9cqnoHQuhebisv
         M8XvAIprtCKc9va9aRz5u6IpwkDnV9UXmFTA8yJyMI+m92R1u+p7eKXxHIReO4+fC77X
         3P8ULgK2jb+HKxaQqibBupI7hBbinYj2YroweiGrWL2LfPOdlsJEm55Q/RfJwGIIvxYE
         OW1WKrCj12dJOMiLLjYvkOqqPwaOJ+pwmhKx5Qhq6EFhoXBYfZbcCLfSSqn+V1gBkl0c
         HJQQwoWUDQfdc9x0KJlMffklvCe+sRc8h7LzVMxNDTqwSkUuEfzt/ydxEaxDxsVvYvME
         BWZw==
X-Gm-Message-State: APuU4Z/jjwIxdZ/GotOE/Mg5aB6ffPoXg1x71YJXe4ujOvGLc6q3slT6
	OqCxTGJ90ba0bEyH1hpUGkzR+YGU5akX7Ay/KLExVD5ohIcWOPutgoHy7SYF3XFm
X-Gm-Gg: AYBFou0ttxB+J9Pa8dMaIRrVBtzT7BuLDEyzZMuw/d8A1AhUkjwV2XLedsIdrrudOdn
	VYO6ixxUiVrZbmy3XEOSNQNrRmUASPCnjw6ZayaHm9c7ONWzeBAeV4OAG/F1XRaW8+BXqEb1VXi
	9eVuATQyVu9MFnlmiNvP9xuczqTvA/IFpk4w7zzLkNKN8kcS1uf3bB53rvJFzPHReME/xx/bxkr
	tgxIErm1mCcAqmpD3gcIhm0fFi+XBo3PLeWkdbAKaXl7Un0DC6+uRuLlw88lWPuMpTvkeG8bkPW
	Jo9Q59i1ZMnwDwzuIpvYtae/qic1RZyl7z/h8H2hEOHsRfvCDbggMl1kaxrLsXqXVjAtFLnRxSn
	ZzB0gcsjgJWjaaGQtU6eXcoMw+tNhnWidiXuVMa3V7CsjcIYgFbX/xlqzeQ9DpSCgxrAvbj7h7x
	vfpryOBcxDS2tYBfxbMMXEuuMF46Dko6Lp9ZOHjUEpQfgCRAetEd1wmksRD657rlJjFZgl+uW6o
	yYLEmwBxLsLxcXUWJG3zTOegWeFnhuCW3DkpxsF1ediHMKf2CZ/aWDDeG2rjrRewGpqAjG7+KG8
	K5/SCiyr46kMBB7VrfvAemW57WZehVcyqKup/BjhB4x99yeIqfklVeiSmyqHmaoGKHvQMQbx+Lg
	8Tn+8/c9WtJIoMe0kwhO/L7mO3vGwsX/S9PiDo1DoUaE=
X-Received: by 2002:a05:600c:2c7:b0:4a1:cfa7:e968 with SMTP id 5b1f17b1804b1-4bb55a595f7mr7904225e9.21.1794521204209;
        Thu, 12 Nov 2026 14:06:44 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29daa5sm106098995e9.12.2026.11.12.14.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:06:43 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v4 3/5] doc: stop calling root refs pseudorefs
Date: Thu, 12 Nov 2026 22:05:39 +0000
Message-ID: <bc29d66748bd649672e072bf0c4699d3dc039b88.1794520948.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794520948.git.andy.koppe@gmail.com>
References: <cover.1794000450.git.andy.koppe@gmail.com> <cover.1794520948.git.andy.koppe@gmail.com>
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
backend. As in the glossary, state that the list of per-worktree
prefixes will not be extended.

In git-ls-remote(1), state that HEAD and refs under "refs/" are shown
by default, and describe --refs and the example in those terms rather
than in terms of pseudorefs. Say "object IDs" instead of "commit IDs",
as tag objects are shown too.

In git-update-ref(1), drop the incorrect mention of ORIG_HEAD. HEAD is
the only root ref that gets a reflog by default. In the description of
core.logAllRefUpdates, correct the claim that "always" only applies to
refs under "refs/". It applies to root refs too.

Distinguish root refs and pseudorefs in gitdatamodel(7). Lowercase the
"other references" list entry there to match the others.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/core.adoc          |  2 +-
 Documentation/for-each-ref-options.adoc |  2 +-
 Documentation/git-ls-remote.adoc        |  9 +++++----
 Documentation/git-update-ref.adoc       | 13 ++++++-------
 Documentation/git-worktree.adoc         | 16 +++++++++++-----
 Documentation/gitdatamodel.adoc         | 22 ++++++++++++++++++----
 Documentation/rev-list-options.adoc     |  4 ++--
 7 files changed, 44 insertions(+), 24 deletions(-)

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
index d71c4ab3e2..717a375d05 100644
--- a/Documentation/git-ls-remote.adoc
+++ b/Documentation/git-ls-remote.adoc
@@ -16,7 +16,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Displays references available in a remote repository along with the associated
-commit IDs.
+object IDs. By default, `HEAD` and all refs under `refs/` are shown.
+Annotated tags are also shown peeled, i.e. recursively resolved to the objects
+they point at.
 
 
 OPTIONS
@@ -35,7 +37,7 @@ OPTIONS
 	with other git subcommands.
 
 --refs::
-	Do not show peeled tags or pseudorefs like `HEAD` in the output.
+	Do not show `HEAD` or peeled tags in the output.
 
 -q::
 --quiet::
@@ -118,8 +120,7 @@ line shows the name of the object the tag points at.
 EXAMPLES
 --------
 
-* List all references (including symbolics and pseudorefs), peeling
-  tags:
+* List `HEAD` and all refs under `refs/`, peeling tags:
 +
 ----
 $ git ls-remote
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
index e6e77252ab..eee645d4c2 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -303,11 +303,17 @@ but others are specific to an individual worktree. One example is `HEAD`,
 which is different for each worktree. This section is about the sharing
 rules and how to access refs of one worktree from another.
 
-In general, all pseudo refs are per-worktree and all refs starting with
-`refs/` are shared. Pseudo refs are ones like `HEAD` which are directly
-under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are exceptions,
-however: refs inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are
-not shared.
+In general, all root refs and pseudorefs are per-worktree and all refs
+starting with `refs/` are shared, except for refs with the following prefixes:
+
+ - `refs/bisect/`
+
+ - `refs/rewritten/`
+
+ - `refs/worktree/`
+
+This list will not be extended in future. Any new per-worktree refs shall be
+created under `refs/worktree/`.
 
 Refs that are per-worktree can still be accessed from another worktree via
 two special paths, `main-worktree` and `worktrees`. The former gives
diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index 8d9be02036..056b866f25 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -211,15 +211,29 @@ remote-tracking branches: `refs/remotes/<remote>/<branch>`::
 default branch. This is the branch that `git clone` checks out by default.
 
 [[other-refs]]
-Other references::
+other references::
     Git tools may create references anywhere under `refs/`.
     For example, linkgit:git-stash[1], linkgit:git-bisect[1],
     and linkgit:git-notes[1] all create their own references
     in `refs/stash`, `refs/bisect`, etc.
     Third-party Git tools may also create their own references.
-+
-Git may also create references other than `HEAD` at the base of the
-hierarchy, like `ORIG_HEAD`.
+
+[[root-refs]]
+root refs::
+    Git may create references other than `HEAD` at the root of the hierarchy,
+    for example `ORIG_HEAD` or `REBASE_HEAD`. Their names must follow
+    special rules.
+
+[[pseudorefs]]
+pseudorefs::
+    linkgit:git-fetch[1], linkgit:git-merge[1] and linkgit:git-pull[1]
+    create the pseudorefs `FETCH_HEAD` and `MERGE_HEAD`.
+    They are not references as such, because they are not stored by the
+    ref backend, but they can nevertheless be used to refer to objects in
+    commands such as linkgit:git-log[1] and linkgit:git-diff[1].
+
+See linkgit:gitglossary[7] for the root ref naming rules and further details
+on pseudorefs.
 
 NOTE: Git may delete objects that aren't "reachable" from any reference
 or <<reflogs,reflog>>.
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index bd9f345690..414765c2d8 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -350,8 +350,8 @@ Under `--pretty=reference`, this information will not be shown at all.
 
 `--merge`::
 	Show commits touching conflicted paths in the range `HEAD...<other>`,
-	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
-	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
+	where `<other>` is the first one of `MERGE_HEAD`, `CHERRY_PICK_HEAD`,
+	`REVERT_HEAD` or `REBASE_HEAD` that exists. Only works
 	when the index has unmerged entries. This option can be used to show
 	relevant commits when resolving conflicts from a 3-way merge.
 
-- 
2.56.0

