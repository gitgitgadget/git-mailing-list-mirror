Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA41519A0
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909792; cv=none; b=MI5WLUcLYvsrJS/rODwOPKlKBqZtE+3QYExmYZzhR4GwbKaeqbkk9f0LVUIq6WdauPmficpTe/mZkVILDJwgz90lgRLwBCfucppggLdF5Y0V3O+hC2/iHyDcY45NXmHfPu8lG5KBFqn8suaGTsBq1giF797MgDapQ5DFaJFhxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909792; c=relaxed/simple;
	bh=0w/gsguNe4EqpRmWi8D6suSPyRfju59PreEfNLHXwWY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rK1AXwKk7FB+fdHeJFWRAShBqKbw7Adk6imAYqykOp0VqTh4AEUX291Ye61fhNwzrGQ8QwkbzXm6vANhC9iFQwsB4zpGoRYTZsl25d4IvhlsiRZbrfviaH/XNwEBM79pO9ZQLzyUsX7xZzcxZ7e+H9MctQ4SjOri6buoMrmEVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJFBxKHS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJFBxKHS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so20311085e9.2
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755909789; x=1756514589; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LHOBFVONSzEUDKacprWbX2m3trEFNLgPo7mw1WPMw4=;
        b=VJFBxKHSKERQp4aCDY/P6xatp2ZivuVKqg6mAw0Nzb7V7S7etNYssDVWTkdhReABbI
         /GhqwThjx+9z5hqZc1fSoq9JZLY+DVyrA2+H/XqGEPqPh/X8EYomFKBMQ/QuoPN6wjz8
         AVCJKXfCmgZ6M/qGqgL1gS6Pzn2vgoxN04Gv7DqfgPSqTuElVAts+XR1xezj9lNEMiJg
         jGMthaAgV6mA6qrleZ/GIU0nFjmMiacQ5nuSpjTzsCZyaeLkMlMVjwEtIIRIwaeTwUNR
         tNYT1SJpnsj6mmLhbZZHKZUZkRtn4yo12gY5yMaPn1k0Yxv80/NZD2uCfOUqi7JF31F2
         mgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909789; x=1756514589;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LHOBFVONSzEUDKacprWbX2m3trEFNLgPo7mw1WPMw4=;
        b=jIwlMMnTwOSyBat1L+Jkp/HV2lSc9ASmfIHHReBtPEE8WXe+LLvf8WRVocZ5mfA2c6
         8fN7efjRMJ7M9xn7Jg9RCrnZ+mGrW+A1m9sJHfxiBW2ViVcRaI/0xC2blC35jtdz4Kh6
         N1tLLizvcJ9NNsfx8RqGLrYxl+eC+sZolroO6OH7MuPn8r91sG4w2TxO3J97Cl++9/4I
         jgxDHQjGNztmiPnOFGmN5VrZBPBZO1xqZZGIHfHRjn5g8x3oWYAwGyxkvcXDsK5RYIKY
         HeuS3s2AcGBqKPYHCt9R4soWaQhEag7qSJTAUqO8IlIC67r2CBXSnTpnM6pMuzm637bs
         EcRA==
X-Gm-Message-State: AOJu0YzkX9ILLjvExETnKMkdq/El/SCz6krtKyIFjFA1NU9zmbC2HqE6
	/DVrcGI+6XdpBHDgWcH7nqUnw/LNfxyfofLP/qEB0oEruBMsMtcRols/MGJP/g==
X-Gm-Gg: ASbGnctrZ9Aq7xfG9EZGCrKi08sMTOaA9SpYwrf55jd89vRG/r57lwPk8/LCUo+q5Zb
	JwIK9GlPG0U0uLufldBvt4KlnpiK+wUqlHfetmM+Kss4WOVv/PgXTrDPzKb8mOn7h/CDyfUo4wu
	TSxgAf7LhLWQbrzxQn31jiY0O2snaOJ19WoOmzCWMclBqmVyKyU942ZXNHNrufBmUch26IJ8uvc
	mCDP2yEu8oj7mqz7S7djWM53YrZbF2OQL2HuaczozoruCKoDFGm+yj756NwiJw0qndhvwwjC0Ij
	FhxL0f/9r6Ha0VMLHAuiJyZjyA1YUhz7U5dvsxx0lTZri3wulCXjD4we0ej29tuQ2DKthAUu8m6
	MVjPXK1PiSshR3ugwDRQurX2145k=
X-Google-Smtp-Source: AGHT+IHhsOSTGqbMyQSjXzLGaswTFnhaYwwHwK0gSVPjnxhPGjiFI8OG/Y6gqyfhUxms2Qk2WPbRJg==
X-Received: by 2002:a05:600c:3149:b0:45b:47e1:ef73 with SMTP id 5b1f17b1804b1-45b517df336mr31698285e9.34.1755909789007;
        Fri, 22 Aug 2025 17:43:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57449e72sm16685675e9.7.2025.08.22.17.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 17:43:08 -0700 (PDT)
Message-Id: <5a1dd8df29baf68c780d76880a5eb586e20102fa.1755909782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
References: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
	<pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 00:43:02 +0000
Subject: [PATCH v9 5/5] doc: git-rebase: update discussion of internals
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- make it clearer that we're talking about a multistep process
- give a more technically accurate description how rebase works with the
  merge backend.
- condense the explanation of how git rebase skips commits with the same
  textual changes into a single bullet point and remove the explanatory
  diagram. Lots of things which are more complicated are already being
  explained without a diagram.
- remove the explanation of how exactly `--fork-point` and `--root`
  work since that information is in the OPTIONS section
- put all discussion of `ORIG_HEAD` inside the note

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 61 +++++++++++------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index b3354e0e4f82..d2f760af6866 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -68,51 +68,26 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
 branch does not have a configured upstream, the rebase will abort.
 
-All changes made by commits in the current branch but that are not
-in `<upstream>` are saved to a temporary area.  This is the same set
-of commits that would be shown by `git log <upstream>..HEAD`; or by
-`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
-description on `--fork-point` below); or by `git log HEAD`, if the
-`--root` option is specified.
-
-The current branch is reset to `<upstream>` or `<newbase>` if the
-`--onto` option was supplied.  This has the exact same effect as
-`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
-to point at the tip of the branch before the reset.
+Here is a simplified description of what `git rebase <upstream>` does:
+
+1. Make a list of all commits on your current branch since it branched
+   off from `<upstream>` that do not have an equivalent commit in
+   `<upstream>`.
+2. Check out `<upstream>` with the equivalent of
+   `git checkout --detach <upstream>`.
+3. Replay the commits, one by one, in order. This is similar to running
+   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
+   are handled.
+4. Update your branch to point to the final commit with the equivalent
+   of `git checkout -B <branch>`.
 
 [NOTE]
-`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
-at the end of the rebase if other commands that write that pseudo-ref
-(e.g. `git reset`) are used during the rebase. The previous branch tip,
-however, is accessible using the reflog of the current branch
-(i.e. `@{1}`, see linkgit:gitrevisions[7]).
-
-The commits that were previously saved into the temporary area are
-then reapplied to the current branch, one by one, in order. Note that
-any commits in `HEAD` which introduce the same textual changes as a commit
-in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
-with a different commit message or timestamp will be skipped).
-
-If the upstream branch already contains a change you have made (e.g.,
-because you mailed a patch which was applied upstream), then that commit
-will be skipped and warnings will be issued (if the 'merge' backend is
-used).  For example, running `git rebase master` on the following
-history (in which `A'` and `A` introduce the same set of changes, but
-have different committer information):
-
-------------
-          A---B---C topic
-         /
-    D---E---A'---F master
-------------
-
-will result in:
-
-------------
-                   B'---C' topic
-                  /
-    D---E---A'---F master
-------------
+When starting the rebase, `ORIG_HEAD` is set to point to the commit at the tip
+of the to-be-rebased branch. However, `ORIG_HEAD` is not guaranteed to still
+point to that commit at the end of the rebase if other commands that change
+`ORIG_HEAD` (like `git reset`) are used during the rebase. The previous branch
+tip, however, is accessible using the reflog of the current branch (i.e. `@{1}`,
+see linkgit:gitrevisions[7].
 
 TRANSPLANTING A TOPIC BRANCH WITH --ONTO
 ----------------------------------------
-- 
gitgitgadget
