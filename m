Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24230B50C
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144823; cv=none; b=S4gWEF+zI6yS+J6fciSZ2c9h3O48MrDfBW5sD+TMw1FMYyV6H7QoL1nrRQsa0IE6QRWMZ9exwWH7QH9KJZsUxguAY9W1OAwoLrSqo3fedW01FpR47NtLKIuDPAkyB66TTTSEH9vZIwZrPIkSJp60njbRj9M3MULeCMS/U38NkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144823; c=relaxed/simple;
	bh=1bL8sCF1/lN0Mq63XOdT+ydNwlC8BVXuUMNBg8ylj1s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VDWuVFrIIMWLv5Yp3j6mhel42uZqeeLEpFupaOsLCiEoiue+k72ne0XqOltytBQt0VexVAkHDlafQbVMGokZa5XfrYfF8KrfzlSfTxU94g4FHN5sK3/55smyrzxFn84spnMMI+0jvNK/JaRQkqtEFdOyfF5bKuLbacrn+E0Ht7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVhYGbIR; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVhYGbIR"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-88432e29adcso10818539f.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758144820; x=1758749620; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sLMgSAWD7UJq0/pueGygONMWzPMsUGfcTP1e+jckQw=;
        b=XVhYGbIRkfMVLZftQwQn4oYwLiIwBov085aRNCSp3uLfqERG4njm3UMBQrxN7+qne+
         sxgEnjv6FgGC9ui9ctAA1by081nPuUCncWGHBD96znSsb8aGg+j4RNYmtjidgnnIxG5O
         0dSEmw1kDQoJ+TbQ/ELyOLF8UZta9lQlH95udlJRZ1ZWMXyAGaIqPx1TeFftMDdmp5Gq
         oPeDLPdg2UltRzzcwRRdafJiXHM4qRzlEMAVq+8nHJycz2B7ZDGbnKHZnaGx5BP/7l4p
         Iae09wNyR+/KjxDyKB+dEZPRvSxnv0RUFQjxNacAjDbP8QI7t3wJrgF4GSYujyEE+8m1
         5e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758144820; x=1758749620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sLMgSAWD7UJq0/pueGygONMWzPMsUGfcTP1e+jckQw=;
        b=eo1LbEf7C1kvDwVxo01+zJLqtBIR0mf/xpqWWgYoKER7eiEvbPEAZ1KumvYylatVK1
         kJVFVAGCO/eRNMzQG/lXnUWwLR5kCGU4KLM3aDkamjr0/pvnWChK1bALcXfY4if3ZLSF
         Yh28IgBDJob2OUJfNSjTeEUybfn1cZEBmhF+ZBci4EKmGfji6HZXpfw9BCe5Hm406Wv1
         MdykyRRwvBGv4Iig0krurOzP6fn+bdZlMzKyJvoZPSA412iOp3qbQP/11Y9fE1iRs4+r
         sWjcYXhs77BytjR2pTL53iphWz1sHyMok/DneN8ZtzIqAWFyuvodRcMDOwo2FuKEZAHo
         o7NQ==
X-Gm-Message-State: AOJu0YyyDeratnuMfLnUUVClzej8IB1fy6kctUKWmcoKbeT/ssMZ8Qfz
	6O5x/Xg72ZQx3HsL6YcP1GQB+Dk4jSg5Feju50Zcz8ZdEmbRsAejlyYZNa/Csvj/
X-Gm-Gg: ASbGncvWsY0n5UiH/x3SPydurMZaiw6+B+lXY7rni9tmTKt4LDPALH66ACPS5nAJjQo
	T8aeBC+qAGs/5EQSGYPcl6XdKh/krAy59WNuXPhCJStM/7QdGHUEqcjyEVlEAPab+E5dLZeDT6k
	CSQxGfoDHcmqPauujC6uBsbALTH5PjRVjH9JznZ6xjzjUEBt+CpldQPohBPrKvNK4nPxPB2eis5
	h+RY36F7SQOvX9yZL04Sw1ul8mnuAUj1F/9yQW0+q7kurdHvg7Jnk2FyEYdcu55yarbsd5htZtP
	tWNUaFfMs5VjAKvOJ7CMegqN+trnsBdaGUWvcz6XjOsIHsq0/YZL6Oj3qQWOPg7xXkH8aVeOdKb
	0DwoQCV3b/YzF+Eu2U/c87rShtqg2kduxcaxsoGgNc8armTpZgM1lW/k=
X-Google-Smtp-Source: AGHT+IH86yJtCw/koBarxDUUYmWiSQw4As5vLx1CJuhlbMJ+h7cRS8umyD66m7YbQSWXUedO9CrVGA==
X-Received: by 2002:a6b:7f43:0:b0:887:7723:3c72 with SMTP id ca18e2360f4ac-89d1e4f5efbmr503912239f.8.1758144820086;
        Wed, 17 Sep 2025 14:33:40 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.184])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f315asm23219939f.3.2025.09.17.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:33:38 -0700 (PDT)
Message-Id: <2f2dc22c47530445bce50f1bdef9630b046677bd.1758144815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 21:33:34 +0000
Subject: [PATCH 1/2] doc: git-push: create PUSH RULES section
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Right now the rules for when a `git push` is allowed are buried at the
bottom of the description of `<refspec>`. Put them in their own section
so that we can reference them from `--force` and give some context for
why they exist.

Having the "PUSH RULES" section also lets us be a little bit more
specific with the rule in `--force`: we can just focus on the rule
for pushing for a branch (which is likely the one that's most relevant)
and leave the details about what happens when you push to a tag or a ref
that isn't a branch to the later section.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 93 ++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index d1978650d6..193016e291 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -91,48 +91,6 @@ is ambiguous.
   configuration (see linkgit:git-config[1]) suggest what refs/
   namespace you may have wanted to push to.
 
---
-+
-The object referenced by <src> is used to update the <dst> reference
-on the remote side. Whether this is allowed depends on where in
-`refs/*` the <dst> reference lives as described in detail below, in
-those sections "update" means any modifications except deletes, which
-as noted after the next few sections are treated differently.
-+
-The `refs/heads/*` namespace will only accept commit objects, and
-updates only if they can be fast-forwarded.
-+
-The `refs/tags/*` namespace will accept any kind of object (as
-commits, trees and blobs can be tagged), and any updates to them will
-be rejected.
-+
-It's possible to push any type of object to any namespace outside of
-`refs/{tags,heads}/*`. In the case of tags and commits, these will be
-treated as if they were the commits inside `refs/heads/*` for the
-purposes of whether the update is allowed.
-+
-I.e. a fast-forward of commits and tags outside `refs/{tags,heads}/*`
-is allowed, even in cases where what's being fast-forwarded is not a
-commit, but a tag object which happens to point to a new commit which
-is a fast-forward of the commit the last tag (or commit) it's
-replacing. Replacing a tag with an entirely different tag is also
-allowed, if it points to the same commit, as well as pushing a peeled
-tag, i.e. pushing the commit that existing tag object points to, or a
-new tag object which an existing commit points to.
-+
-Tree and blob objects outside of `refs/{tags,heads}/*` will be treated
-the same way as if they were inside `refs/tags/*`, any update of them
-will be rejected.
-+
-All of the rules described above about what's not allowed as an update
-can be overridden by adding an the optional leading `+` to a refspec
-(or using `--force` command line option). The only exception to this
-is that no amount of forcing will make the `refs/heads/*` namespace
-accept a non-commit object. Hooks and configuration can also override
-or amend these rules, see e.g. `receive.denyNonFastForwards` in
-linkgit:git-config[1] and `pre-receive` and `update` in
-linkgit:githooks[5].
-+
 Pushing an empty <src> allows you to delete the <dst> ref from the
 remote repository. Deletions are always accepted without a leading `+`
 in the refspec (or `--force`), except when forbidden by configuration
@@ -145,6 +103,7 @@ the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
+Not all updates are allowed: see PUSH RULES below for the details.
 
 --all::
 --branches::
@@ -332,14 +291,12 @@ allowing a forced update.
 
 -f::
 --force::
-	Usually, the command refuses to update a remote ref that is
-	not an ancestor of the local ref used to overwrite it.
-	Also, when `--force-with-lease` option is used, the command refuses
-	to update a remote ref whose current value does not match
-	what is expected.
+	Usually, `git push` will refuse to update a branch that is not an
+	ancestor of the local branch or commit being pushed.
 +
-This flag disables these checks, and can cause the remote repository
-to lose commits; use it with care.
+This flag disables that check, the other safety checks in PUSH RULES
+below, and the checks in --force-with-lease. It can cause the remote
+repository to lose commits; use it with care.
 +
 Note that `--force` applies to all the refs that are pushed, hence
 using it with `push.default` set to `matching` or with multiple push
@@ -508,6 +465,44 @@ reason::
 	refs, no explanation is needed. For a failed ref, the reason for
 	failure is described.
 
+PUSH RULES
+----------
+
+As a safety feature, the `git push` command only allows certain kinds of
+updates to prevent you from accidentally losing data on the remote.
+
+Because branches and tags are intended to be used differently, the
+safety rules for pushing to a branch are different from the rules
+for pushing to a tag. In the following rules "update" means any
+modifications except deletes. Deletions are always allowed, except when
+forbidden by configuration or hooks.
+
+1. If the push destination is a **branch** (`refs/heads/*`): only
+   fast-forward updates are allowed: the destination must be an ancestor
+   of the source commit. The source must be a commit.
+2. If the push destination is a **tag** (`refs/tags/*`): all updates will
+   be rejected. The source can be any object
+   (since commits, trees and blobs can be tagged).
+3. If the push destination is not a branch or tag:
+   * If the source is a tree or blob object, any updates will be rejected
+   * If the source is a tag or commit object, any fast-forward update
+     is allowed, even in cases where what's being fast-forwarded is not a
+     commit, but a tag object which happens to point to a new commit which
+     is a fast-forward of the commit the last tag (or commit) it's
+     replacing. Replacing a tag with an entirely different tag is also
+     allowed, if it points to the same commit, as well as pushing a peeled
+     tag, i.e. pushing the commit that existing tag object points to, or a
+     new tag object which an existing commit points to.
+
+You can override these rules by passing `--force` or by adding the
+optional leading `+` to a refspec. The only exception to this is that no
+amount of forcing will make a branch accept a non-commit object.
+
+Hooks and configuration can also override or amend these rules,
+see e.g. `receive.denyNonFastForwards` and `receive.denyDeletes`
+in linkgit:git-config[1] and `pre-receive` and `update` in
+linkgit:githooks[5].
+
 NOTE ABOUT FAST-FORWARDS
 ------------------------
 
-- 
gitgitgadget

