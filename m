Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5726CE11
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307468; cv=none; b=c8JHxz7GB7dRZ0KyekzI8u3Pp9bt30w0R0VjjDXpUBmIH95t2G72lypnoNdtMBhr5wG7776GyVmAKqHGD3cQrSgYOGd5vey2rRVV+KSbQ+XmrFigCO7L8MHl/Lw3xMle7wQm1JwMkGTOovemjOjx1HC0UCmAlmnfnOcL6yNDNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307468; c=relaxed/simple;
	bh=svy690DdERAQqC8ATjpkNCoIQDyeJIababmVjrZqKJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTFafixUX05L0xQy1ANFMExK7YFE58YAcbLqg8Futy0x6ks0M8/fXXaafPcLkmlFEK+us+SgVEju8S/hsmMlfEvqX3W7I7ruPZklhRbYppgMUEu34m8OoLhlXXvNuuDKpMmhkl34SlMcVYTunZg1EkZygGijdBKAk3H7EyDyuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMm5nHnp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMm5nHnp"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-790647da8cbso3675767b3.1
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 14:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767307466; x=1767912266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMolAwu0sttJ7JsqLPChiVZJF9EBIUSYPkNH2rbg1hU=;
        b=SMm5nHnpn8I/F+nq7K1ClUw0sHKU9G9RG+bytupOJC8dfN9U2sdqP/Hzh1gZlRhobF
         Hvl522bcKyrxm9RvDTX3Z1Yj1wH82EIADadM89u0HfpOrI2h7utHxydq/Z38I9q3Usky
         9/50cu5RqmdThg8zIiRKxL+7Y36oPMGNi34ahFl1l08qhnH/bwCk3QqdxYLSMh99HdhH
         DxZWEU1nAUiyeTAxFHAejaUKH2m8hDxulxnPrxOWO7NE2bXDxIEqTcZS6nPqmpSUog92
         EvWsAYGPQocybetUHDPffGpKXrr31FxmBihReY9UUBw24RKWrq5BqKCe6OQV+/ZO4ERr
         wM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767307466; x=1767912266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMolAwu0sttJ7JsqLPChiVZJF9EBIUSYPkNH2rbg1hU=;
        b=glG4V5d4WunUWOl1AkcAIAZaaBv4LWRelmuPYfbxbxzgusaRNXto+nkPPx8upLy9Mr
         HgDmWLksWLFhBe6UCFrccmLkIarjr2yv0fRUm9VWMMXJxMwlWc29gGp4j5OQWGpcZSAV
         5MpWTVo7X7cQYt7j4ulDT3hkMGBMsy5liMtrOYYnuUaCln0A665o/rKrxf5yeSEc0cCN
         PhhVhxQlzCQ4UGaL5UdUgjU9DbBeRQFt6VF0ihPo2/3uB8q0sZ+HNyMP/1wUtIYGIFOT
         MK1r43Gx4NQFl6nYf+wWNBJKgpoONbcK2LEqgQthDnTu0p/y0LgIqsEdfI7ubr57KdnZ
         NHMQ==
X-Gm-Message-State: AOJu0Yw//zFXpLBmRnQA7WCj7CJ07cInFOBgh1ewdScjuiwp6s1C/f23
	aRi/KqgHXAetmB/K3N6Ns8HbRdWedibdQiRj/+LMj5fGhVPk+0bS2osr9OE7wA==
X-Gm-Gg: AY/fxX40FyXXcVX577gGaoDvWyILOQyO6XH5zVOATDKH3S6J9203CWvHx0kB4H2sFcY
	6btpSU5jfyHr16moywckZ+QauMNmBjdKqtGka+cI9iJYHgArrzh8ycpJ96IaQRHpq9PuDjV2lPb
	dOHYM/G2oUkBC/TLR7Y9H3lye7Yl+RAEJg3gAJ+EYVB73FVWuRX1TAmXIG8APt7iMdrVOXj9ams
	wmAKzPjt2j3/PtvTqx/t/tkcnfYBscnlr/A5q6iq01Uq7Ut8ytZgKCUj9YweZpc2TT7U+q4tyDu
	sDymXHxtDtvYIf5JhNQ3weiWVYYL7vRxVwa/7AHqhURHOedFX7QcJCwpRCyRlUYqhjqzw/pEzGS
	t2c3L0M30aVgshey24wr6Z3T4PrdooAq8bAyGznIbniBx6OZJyt36VPkgIL4KbYIxoAwN18B6l7
	zQH+/Bvpk16s+cDhM=
X-Google-Smtp-Source: AGHT+IHLreP0Rw9oaZGfYzmMAl9b5BGQBhU8IrBltqSAuY2UPQWjV+1GnoQC+mFuavghmCeDjDIAPw==
X-Received: by 2002:a53:bdc5:0:b0:63f:2bc7:7074 with SMTP id 956f58d0204a3-6466a8aba62mr25620204d50.60.1767307465848;
        Thu, 01 Jan 2026 14:44:25 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43790dcsm150521117b3.11.2026.01.01.14.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 14:44:25 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 4/4] doc: git-reset: clarify `git reset <pathspec>`
Date: Thu,  1 Jan 2026 17:43:59 -0500
Message-ID: <96566265d89d62689388080283800712a182867c.1767307382.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.426.g1df11fb20d.dirty
In-Reply-To: <cover.1767307382.git.ben.knoble+github@gmail.com>
References: <cover.1766103827.git.ben.knoble+github@gmail.com> <cover.1767307382.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julia Evans <julia@jvns.ca>

From user feedback:

- Continued confusion about the terms "tree-ish" and "pathspec"
- The word "hunks" is confusing folks, use "changes" instead.
- On the part about `git restore`, there were a few comments to the
  effect of "wait, this doesn't actually update any files? What? Why?"
  Be more direct that `git reset` does not update files: there's no
  obvious reason to suggest that folks use `git reset` followed by `git
  restore`, instead suggest just using `git restore`.

Continue avoiding the use of the word "reset" to
describe what "git reset" does.

Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-reset.adoc | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 6de0d524c3..770f08c7f8 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -81,29 +81,25 @@ linkgit:git-add[1]).
 
 `git reset [-q] [<tree-ish>] [--] <pathspec>...`::
 `git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
-	These forms reset the index entries for all paths that match the
-	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
-	the working tree or the current branch.)
+	For all specified files or directories, set the staged version to
+	the version from the given commit or tree (which defaults to `HEAD`).
 +
 This means that `git reset <pathspec>` is the opposite of `git add
-<pathspec>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <pathspec>...`.
+<pathspec>`: it unstages all changes to the specified file(s) or
+directories. This is equivalent to `git restore --staged <pathspec>...`.
 +
-After running `git reset <pathspec>` to update the index entry, you can
-use linkgit:git-restore[1] to check the contents out of the index to
-the working tree. Alternatively, using linkgit:git-restore[1]
-and specifying a commit with `--source`, you
-can copy the contents of a path out of a commit to the index and to the
-working tree in one go.
+In this mode, `git reset` updates only the index (without updating the HEAD or
+working tree files). If you want to update the files as well as the index
+entries, use linkgit:git-restore[1].
 
 `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
-	Interactively select hunks in the difference between the index
-	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
-	in reverse to the index.
+	Interactively select changes from the difference between the index
+	and the specified commit or tree (which defaults to `HEAD`).
+	The index is modified using the chosen changes.
 +
 This means that `git reset -p` is the opposite of `git add -p`, i.e.
-you can use it to selectively reset hunks. See the "Interactive Mode"
-section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+you can use it to selectively unstage changes. See the "Interactive Mode"
+section of linkgit:git-add[1] to learn how to use the `--patch` option.
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
-- 
2.52.0.rc0.426.g1df11fb20d.dirty

