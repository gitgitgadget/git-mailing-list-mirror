Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000876;
	b=QBeUMwlUZdOBvEB76B8g/riSkYUqI9f6UpvPFEElPWK0PDutQDjt8uEenVo6XjSWqu5c
	 yPsqdl+kMvyIO22ToYifVv4JQSU0zwpUWgELHZkRjRcw9uxlF3i2d+s54GKEP6i41/bcw
	 W3VfFdbV5QPPr/PASl+t4vYODseq4vK2TnXbZqy+IiW4/pWKud/a+DlSf+Az1IqtVtAM1
	 lLmATdPhR+urU8htmwVwHQvFcRq5hzAQBKQUb2NfDcUERzu7X0E2qQ7Yl2VuuKmwS1Dwk
	 SHOmcEZnsGdQ+nL/4qkB0k3YiwckKStQF0O932yPPXRYJxZAdgoi0URv20RadgMYoBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yoRj+7D6h8jhEdWz8keXnXTzfRksa85Za5arCpheenU=;
	b=RcoTSjKPa0wRQAR6Hcy68xvfI4pYnrnyK3q8frRV1MyQTVybRwYo7gNef7Bpgv5raV/a
	 +2jGcnl2cyPrxQsh3qNtIEFueejeBBmu5i05M8k1WPJvLBDPyrg7sgODau66m8JMdxkns
	 KIIu8fLNaAGmmoDOlLm7G6tyXwxjy6XXhV7d1J0p6J69aWmbPRbJDpWDQDqhlw+buycOL
	 R9H3GafIOEnhkp7584ecUW0J8/v1RevkfoKN9lzEe5tp5ykznVplhcmpbVuHydvRShS/M
	 /+kH8pTJYdCcEEm02150x6DmhEssbduJv54twUb5jKXqUyO5aQYLIGreVCFcznDrWMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d317+MST;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7777606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7777606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d317+MST
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso507425f8f.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 13:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000874; x=1794605674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yoRj+7D6h8jhEdWz8keXnXTzfRksa85Za5arCpheenU=;
        b=d317+MSTiTHXYQe60QANdKYPTwGUqnYt+8rn1S2Z51jrpriRtNevx4b+67QuIVAfky
         5SvdrY73kZ5mkU21rVbuIGzhazKASrLiprf9tNzozbxAzxNT45NebR9V5TAFFqk2TzL1
         8NuWZDT1Paq4Acv/uZMooQTGeKVP+fvqQHFzSF2RGNqiiOjdwSrGmfR8hGkedxaOxgvn
         nj2u9r+bgd16UL3jIXVVYEs8oj/MAwQY6HpChRzfNNBeD/8vhh7qW63OsaLamsw3BLzR
         jR2VuvxIOcmsyac3bGiGFcLC5lz1F/Ec8vD1+rJEgs3t2EO9LZOgq1KEyuIxuoqAHqcp
         raLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000874; x=1794605674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yoRj+7D6h8jhEdWz8keXnXTzfRksa85Za5arCpheenU=;
        b=bb9SRqAaTCVdGSdHPAXY4NYoIzRc5SixiQUj6B+x/oxLts1w/M1oAo8/D19q5sDOIp
         pzF3Qj18VoBawJEarZ7tektlPY+jve397NnzNMlZlJTD6+Kr8z1N7JLWsuIsI7bIIe1n
         WO5hcmzP9tLMXnD3mdAZYH2vZuTFYjwkVjaxQuXlrhPnX4+IMMBoDzQVNKKIPCGu4Jhn
         V5T+6AJQ4az/U1ErWOdNOQ2JCNTsmwK2gYibInSihnKHCp47y1EqGmFe/NyWzINP3TkK
         VjFPl/Oig84nK4bV2oMMgnEZTTdOf3lMQVQZK9TUpAH1HvZJxNDsc2PAUF4SYkqHo5Tk
         IfEg==
X-Gm-Message-State: APuU4Z/K3wDyHjSFfzh2gxVYrBcZx7COP2ttkA78OmaNhA+ht9EEz2ia
	uMTVeAFgYT84s2w4KwNXDLL6pkOThKApNJqhceOaS2M0gs+0ytpsdETgkZ1YE0wB
X-Gm-Gg: AYBFou1aTNnvD+ztl1ebcG63KCo2Up8Lx7NpALV9MS4V4c+Cw6jEbWVOVIogELAa+/k
	Jlqp1ncnPOSXAlpNhQLJHeSdIuMtmssNLO0N3yzfNJTVAY23fLdOHHGBS31sW9Eu9s5/Gth5Tg2
	Pr8e8KQdT4fI5AI9g6wC7Qcvx8bd3NXVrJBVYnYgkf7MUckZDyy+OA5gwhvleJ01nTsW4dwo4zX
	W6YEcKdemsUd7H6IfTa1PSvvxngZtg/o6l/dxqdi2W+xqZKnsYOu6NKWvTE2ykaiUUA2PmFUsBq
	jFpqoJEi2+T2yr1zLEJl/iVaQSYsiUBqxKr1rig1ZZKznB7RVtVqgd7Xs9d55b5bSm1jrKrP6Gu
	+Wv8sNTBwPZt4UE4q+uceXlgctT6qjEOn4/IH5Xn5R5BYumWojw5R/67IJh5MeBtAHeVkXI9XhV
	dxGISp4bIhNyNN3bEhzMdpFUBF101XIrvntEetaRB5gSHpZ5vTRRHnWYgmpJCYKP7T7mAk42/PV
	Xwe8Xqo7GakDqU4RbIuWS15UZ1naJ14qdzTszBmTEB4fYfnl5NjMTnM6noyE55HvfwctTrE8smk
	mCAHRdfVJdW6x5k/mSFGWyDT2A9ep8wh3Gr3azW8upEErNT3XabfrPDzD170euaqBwYKekpa91v
	qpneJSHlYp9g9MbtyJsdk9g==
X-Received: by 2002:a05:600c:630c:b0:4a2:fe11:9a8a with SMTP id 5b1f17b1804b1-4b6d82b3d9fmr69190865e9.0.1794000874142;
        Fri, 06 Nov 2026 13:34:34 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3271867sm9994385e9.6.2026.11.06.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:34:32 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 3/5] doc: stop calling root refs pseudorefs
Date: Fri,  6 Nov 2026 21:31:06 +0000
Message-ID: <ac3ed53867d868c36a91f4c5c6be1fe2d874651d.1794000450.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794000450.git.andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com> <cover.1794000450.git.andy.koppe@gmail.com>
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
 Documentation/gitdatamodel.adoc         | 21 +++++++++++++++++----
 Documentation/rev-list-options.adoc     |  4 ++--
 7 files changed, 37 insertions(+), 22 deletions(-)

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
index 8d9be02036..2e44cc5003 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -211,15 +211,28 @@ remote-tracking branches: `refs/remotes/<remote>/<branch>`::
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
+    for example `ORIG_HEAD` or `REBASE_HEAD`.
+
+[[pseudorefs]]
+pseudorefs::
+    linkgit:git-fetch[1], linkgit:git-merge[1] and linkgit:git-pull[1]
+    create the so-called pseudorefs `FETCH_HEAD` and `MERGE_HEAD`.
+    They are not references as such, because they are not stored by the
+    ref backend, but they can nevertheless be used to refer to objects in
+    commands such as linkgit:git-log[1] and linkgit:git-diff[1].
+
+See linkgit:gitglossary[7] for further details on root refs and
+pseudorefs.
 
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

