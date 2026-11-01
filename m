Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574280;
	b=2bbN1o4QLHDE/Tb+ghQNO5GwPn/P1oH+ZBfgQq43dFFwmc+P5DvuQvU3aT06ThD4Gdjr
	 kvgJCXPuFK7r3Sa4G7Wg/JQh8sTOdTc3kBLSFyZLkwH0DDxBHbPvWI0HimUT/TqHsRp1y
	 EDkYhZBkoIMXtlajPzek/FIJ5nSPCMWLa6xuWspYeyaEIhh+iqEMIiZNWFyQB9JX2LMUU
	 TMF3T2eLAXmRxPP2CqHYSaUvWeiCbbajjAs5o4ZEMHqHoxLsJ6r3vf0SGDLpD4czwn4Ec
	 U2nHl5Ujdr+TjvwDTel3wk7QpgjxMyrBj/0/N9Xca8XTmzXWRbfz9y7aqbKliRVb2eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0AHZuqIfH9PvfSwHRnm0JWRWO+b5WZYSy6EGNxGG8UA=;
	b=rffcl+b9zZQYwguZtX/ZDm/aHKm7J93/FZUUCrfrCwAOo1Z8qMkEq7q4uDnWOyfEsOEu
	 GUERe/hteLqt9qcjKr6u+HGMdDvoVM/cTyshD3FwCA+4ecZkoPcu6Tbfx2RzeDqbrqDj6
	 RK+dwYK6EmxpmWLLVO3DnRW8f5suuKT/yi6RaFezi/BTal3ENUej9rnJDOn8B8ojKPW8b
	 a7g6UBMJVXR7v208oxS7Ao9mneBvgskvbT7iGcPMObKXEk1ZquKAtUTi2WRZzVGL2kcIa
	 Cvommj2OnTF8612mVe86WO/1pa77Fs8CG3CkPTln0C9/I+9aJ5rg+ps2DTAJrsrOinQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvvnuY5t;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37B606A336
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F37B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvvnuY5t
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso10270555e9.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793574279; x=1794179079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0AHZuqIfH9PvfSwHRnm0JWRWO+b5WZYSy6EGNxGG8UA=;
        b=BvvnuY5tfC/i1+jDqGXHGhn+JEnu0dV/5kGYRmCvFJALNLylRPp3USmCHeI/yQ07k+
         yIGyCz2e8CDRlouCI71TjjJq4jYx2cv9GNA1CD9WL7AbMG1/FE6B/AAO/Qvx8OcXu5ku
         CZrIBC6AXBfkPDTZ47/SnfKbiDyvzPhAw9zQ7bQwB5oPwfOVIkF4s4GEZ/VIfDlAho8r
         vZ2Z38nCwE1cz1P82aV7cf/M/SKK3zVoK6ozEdcs/luFvNlPLRu5IlqtcFbIQcUS99+g
         u+89EDS5H5+2s05pC00aeLu6rt3HwnGy9oI9k4TVL1OLn621wx1u1SJ3BgiW91Ftd7Kb
         NXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793574279; x=1794179079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0AHZuqIfH9PvfSwHRnm0JWRWO+b5WZYSy6EGNxGG8UA=;
        b=PjYHB+JicVPAPxvvCmCEn33ExF8Prlc+POpzUWEtvAZCt5oeOZy4ZxQD3deT/G5V6a
         j269fziDBGerTFFQY1el8EtabJORd5GdXRZ7gYtqYisIwcyX7hguSRy6cYKHVMc1zjdj
         Ei/2R5DmWBelhOJHdUl9Hsj5WlefSGNWYSYOM351dcCUqlyLnxoj9CG82KPebJ+q3x0J
         Ag+5t+2u5NHfF3AiMzdn+kaPFDGpwQ9MnsfD+LnMv0JSYLr/nZo4lyL1q4Bv4IyXleOp
         Q/iT8lC29uZLNlpsv3iBSl5Iu7+A3PzRmNIBbuPygUnw6rmZxjR5y28U/1FJczKhAaNP
         aIwA==
X-Gm-Message-State: AFq9FYI2lrP7tUZNsPHYUsQrIuzRVI5WX3+3bdBIwmB/7CGDNKkPgSwo
	9DBzMa+U/7ZxDL2r9i2njqVYxRIjkZ0my3ol2yfc8RpLqXG2v3qtkRhMIOZUZEvc
X-Gm-Gg: AYBFou19JvritGQY9HME6XV+FK27VmSo7poCwYISIsGwui138gO93iNDWX+aPsSwBOJ
	CmOab9BIQpEpUgjoNz64YBsKHpeIbkKryBzxjcCIrQsgx67o58tTnGNGb6NNjHLr9sD7K1nNtuq
	5ObRb60EHZx7c9+JO8AEPCGY2pvrLyThORfMtHzMrUZ0740UA470Fs6KP1wUd7llmy14NQ7LjBE
	vYRWM0zHdn2L//i/crXeY4AOrnIKJJSNduyhmFGJU6PVqmOwU55R23N+JpqlkRCwohZPFHJPdbR
	EUuixKQT/7NnWegAF56TXpcwuMHriWkQemsJOQSYWnQQYCKev1uAnanzK3X+na63p2vTqElA5gF
	kI8rLG9ZbDrbhiQ8HvojhGK1/dFONYYf/WtdZ+hAqopnCxi23QPf0/w75JJzdf79I7cW9HVS8CK
	BV88Uy3fq+D0uJsM5uuQPdubHnvOGwIuW3raYiqZaWotQOvQXhV5ttoXYspxOEwpkOdRC3jwPqF
	OruM+PjSroMI3NU6hYW/gWZoYVJbU85Nw/vLgkbvki24Et+s5zYsPfVHg9veCB6x43R7c9ffDUd
	Xc3w/3TqvSgusY34P68tl6/kRdF7ngmon6uKdBPjJhDtYmTwgc0rwi52j2vDvtrAnYbUezn+WF1
	BgaypdEdTo0MjJbF2e6douw==
X-Received: by 2002:a05:600c:638f:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4ac150b304cmr195905725e9.4.1793574278657;
        Sun, 01 Nov 2026 15:04:38 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm135151125e9.4.2026.11.01.15.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:04:38 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 3/5] doc: stop calling root refs pseudorefs
Date: Sun,  1 Nov 2026 23:03:21 +0000
Message-ID: <20261101230326.3675597-4-andy.koppe@gmail.com>
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
the only root ref that gets a reflog by default. In the description of
core.logAllRefUpdates, correct the claim that "always" only applies to
refs under "refs/". It applies to root refs too.

Distinguish root refs and pseudorefs in gitdatamodel(7). Lowercase the
"other references" list entry there to match the others.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/core.adoc          |  2 +-
 Documentation/for-each-ref-options.adoc |  2 +-
 Documentation/git-ls-remote.adoc        |  4 ++--
 Documentation/git-update-ref.adoc       | 13 ++++++-------
 Documentation/git-worktree.adoc         | 13 ++++++++-----
 Documentation/gitdatamodel.adoc         | 18 ++++++++++++++----
 Documentation/rev-list-options.adoc     |  4 ++--
 7 files changed, 34 insertions(+), 22 deletions(-)

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
index e6e77252ab..ba620d8ace 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -303,11 +303,14 @@ but others are specific to an individual worktree. One example is `HEAD`,
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
 
 Refs that are per-worktree can still be accessed from another worktree via
 two special paths, `main-worktree` and `worktrees`. The former gives
diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index 8d9be02036..6958ac033c 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -211,15 +211,25 @@ remote-tracking branches: `refs/remotes/<remote>/<branch>`::
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
+    Git may also create references other than `HEAD` at the root of the
+    hierarchy, for example `ORIG_HEAD` or `REBASE_HEAD`.
+
+[[pseudorefs]]
+pseudorefs::
+    linkgit:git-fetch[1] and linkgit:git-merge[1] create the so-called
+    pseudorefs `FETCH_HEAD` and `MERGE_HEAD`. They are not references as
+    such, as they are not stored in the same way, but they can nevertheless
+    be used to refer to objects in commands such as linkgit:git-log[1] and
+    linkgit:git-diff[1].
 
 NOTE: Git may delete objects that aren't "reachable" from any reference
 or <<reflogs,reflog>>.
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

