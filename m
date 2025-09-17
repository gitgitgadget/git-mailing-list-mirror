Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F32AEFD
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144824; cv=none; b=ntnBoNcLs1GCz3GRsdMus5715mrZUXpvzlfR/CKe5XTivUmNC2xXuWyAkSW1zACTHjce9MDGswUc25spxBKq8e87kv1ZxHZXIcHNFj/I6AELWFI3096J8K8h7ZiyZqy26fJ/C7kT3g7BVtchSrzAz8tdPz9Rq8xnXv9wpdfSuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144824; c=relaxed/simple;
	bh=u3tWsTph04XXcpCMKgR661FuluZlT1XOhk9v/S3CIhs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZBtxK0ZgvuuGpwHRHzHhL5rNJ/v+5u/p1wDNu8M3f/oq4E8lL5ZUyqusG6Ajm6luvgcY+Ucoi3azoFQrCZb+94EYOwdwlsPuIXo0NUAa7L1rspemcLrGfyVXpZqIGWRXzzU0O0grhLMnkgIS2DqfedZm/jID35w1WM9TcJGe2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m63OwpOq; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m63OwpOq"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4234e6c0762so1087895ab.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758144821; x=1758749621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A8UtyScJvCxnTjDI1VTWFPn9N68kYmi+FIsXezcrYc=;
        b=m63OwpOqYJxl4ocTh38rQU5Pc7ZPjESvncy9J8RlTGwGkPu2g3jPqLIzndTaGETZbW
         D+jtq4RmL230h7wMsuSMNqVcXzQmkHBpkiAerbU3nztQh5vCND5yu1UsZ0LVsW2Uv51P
         x2HwXi+X5mJtr1bclP8zL77uRRUTFtUCpJw9Ht3l3tdxry9SgSBSSayx8/Kg4CauK9Di
         y4Kzdtljkj7Ue/6yWYa84R4MYlGWyoCFX8R7kUZOa3y0ByA94aEUjWAaxbv3gr3ThKjf
         Ty5Xe741feQ2EM0sd0sLI22XJdGxm7pN+kjK1iR4RvhD4fF4ENvae2mBWjZR77Xo+Nak
         mzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758144821; x=1758749621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A8UtyScJvCxnTjDI1VTWFPn9N68kYmi+FIsXezcrYc=;
        b=iW5bIUAliU3Tgrnt09iASeNDrq2lgp8pu3ZUJw+FyvjMgVL15N3+2fhgKSOoNgouf+
         W7jEEJWhHYGcz8ypJY+GDHr2zV6rATnw8r+SaAE/WfUDhutVYy2QJ2V+5d9xdTT+sf9F
         ZlHct21qqRf9C44Q0/rPfBd70mo6ElFx760M6R323CKFB+M0c1SVjAPCU9mogq837uMb
         IY0FGEJcF9BmMRNttQ4zvZEpNV4EY69OSl0c9F3viVG6QtkDM17gFQkYYtvQIxwcNHmB
         T8NqfPKFuhd+JRJ2+gqg+haUFSCsjpeaLUpMTErBHB+HhnMkLvvOpAkTocOtXA7uvySt
         WN7w==
X-Gm-Message-State: AOJu0Yy66cv+WRGI2B/H0eA3ZL49lB0VjeAzV/cdPL+VQ3lF5nnnIK+e
	1cifPnfui/MxHvyiPjzSWzd5j+XEvx8yzuIJH0QwZNmAx9uZH7XJwmce9yVXYPla
X-Gm-Gg: ASbGncuO5W672IMkh3FlLnBVk7aA++7iQ2gyDsnA35GCrJqWQovZXDXlBOA7JQESEnr
	H2OgnG+TCQveJSkgJ4+L4pojQzovUvAp5Z+/aZ5f5YHga4kiIrv5hTaD+DNZob5gLWjmi4Asx3S
	wLxP0Tbfk3aA5MJ22gCnbHUcGoWMfajohjkRZjKXIpNTxkH+4nL/60H3bIpqOAqNYR84vto0lxR
	imE897msD8FmDCbXfC3zI+zDB7srGDZ5wqrwmOFQMjVh9BHq+BqE+G7DBke63s6yT7/IK11FjEP
	wHM9vjSiOlavEtbhbRLTqhVZKuWzZRf8xD35Cggexk0QOalkOXVnJwJ+FjFJGu+wu6O0HOG9tt7
	jzKDC3tfiEVL+lK/4BPa0JRafOu9v4jfZEPVSiujzjrMV
X-Google-Smtp-Source: AGHT+IGqc8En9pw5/7vpMwalFt4UVuJ2pkHg92ulLjVJdILwKaW5R3Rmt8v5fTb9/RQBPuGXQYeSEQ==
X-Received: by 2002:a05:6e02:1d84:b0:424:bec:4a01 with SMTP id e9e14a558f8ab-4241a531ff3mr46372925ab.16.1758144821310;
        Wed, 17 Sep 2025 14:33:41 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.184])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244b299d03sm2157995ab.33.2025.09.17.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:33:40 -0700 (PDT)
Message-Id: <e1b667f64597cf6702f133f88a5ba913e2af3167.1758144815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 21:33:35 +0000
Subject: [PATCH 2/2] doc: git-push: rewrite refspec specification
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

From user feedback, there was a request for examples, as well as a
comment that one person found "If git push [<repository>] without
any <refspec> argument is set to update some ref at the destination
with <src> with remote.<repository>.push configuration variable..."
impossible to understand.

To make the section easier to navigate, create a list of every possible
refspec form, with examples for each form as well as 2 forms which were
previously missing (patterns and negative refspecs).

Made a few changes to use more familiar language, but ultimately
refspecs are a pretty advanced feature so I've mostly left the
terminology alone.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 105 ++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 47 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 193016e291..068441d09d 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -55,54 +55,65 @@ OPTIONS[[OPTIONS]]
 
 <refspec>...::
 	Specify what destination ref to update with what source object.
-	The format of a <refspec> parameter is an optional plus
-	`+`, followed by the source object <src>, followed
-	by a colon `:`, followed by the destination ref <dst>.
-+
-The <src> is often the name of the branch you would want to push, but
-it can be any arbitrary "SHA-1 expression", such as `master~4` or
-`HEAD` (see linkgit:gitrevisions[7]).
-+
-The <dst> tells which ref on the remote side is updated with this
-push. Arbitrary expressions cannot be used here, an actual ref must
-be named.
-If `git push [<repository>]` without any `<refspec>` argument is set to
-update some ref at the destination with `<src>` with
-`remote.<repository>.push` configuration variable, `:<dst>` part can
-be omitted--such a push will update a ref that `<src>` normally updates
-without any `<refspec>` on the command line.  Otherwise, missing
-`:<dst>` means to update the same ref as the `<src>`.
-+
-If <dst> doesn't start with `refs/` (e.g. `refs/heads/master`) we will
-try to infer where in `refs/*` on the destination <repository> it
-belongs based on the type of <src> being pushed and whether <dst>
-is ambiguous.
 +
---
-* If <dst> unambiguously refers to a ref on the <repository> remote,
-  then push to that ref.
-
-* If <src> resolves to a ref starting with refs/heads/ or refs/tags/,
-  then prepend that to <dst>.
-
-* Other ambiguity resolutions might be added in the future, but for
-  now any other cases will error out with an error indicating what we
-  tried, and depending on the `advice.pushUnqualifiedRefname`
-  configuration (see linkgit:git-config[1]) suggest what refs/
-  namespace you may have wanted to push to.
-
-Pushing an empty <src> allows you to delete the <dst> ref from the
-remote repository. Deletions are always accepted without a leading `+`
-in the refspec (or `--force`), except when forbidden by configuration
-or hooks. See `receive.denyDeletes` in linkgit:git-config[1] and
-`pre-receive` and `update` in linkgit:githooks[5].
-+
-The special refspec `:` (or `+:` to allow non-fast-forward updates)
-directs Git to push "matching" branches: for every branch that exists on
-the local side, the remote side is updated if a branch of the same name
-already exists on the remote side.
-+
-`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
+The format for a refspec is [+]<src>[:<dst>], for example `main`,
+`main:other`, or `HEAD^:refs/heads/main`.
++
+The `<src>` is often the name of the local branch to push, but it can be
+any arbitrary "SHA-1 expression" (see linkgit:gitrevisions[7]).
++
+The `<dst>` determines what ref to update on the remote side. It must be the
+name of a branch, tag, or other ref, not an arbitrary expression.
++
+The `+` is optional and does the same thing as `--force`.
++
+You can write a refspec using the fully expanded form (for
+example `refs/heads/main:refs/heads/main`) which specifies the exact source
+and destination, or with a shorter form (for example `main` or
+`main:other`). Here are the rules for how refspecs are expanded,
+as well as various other special refspec forms:
++
+ *  `<src>` without a `:<dst>` means to update the same ref as the
+    `<src>`, unless the `remote.<repository>.push` configuration specifies a
+    different <dst>. For example, if `main` is a branch, then the refspec
+    `main` expands to `main:refs/heads/main`.
+ *  If `<dst>` unambiguously refers to a ref on the <repository> remote,
+    then expand it to that ref. For example, if `v1.0` is a tag on the
+    remote, then `HEAD:v1.0` expands to `HEAD:refs/tags/v1.0`.
+ *  If `<src>` resolves to a ref starting with `refs/heads/` or `refs/tags/`,
+    then prepend that to <dst>. For example, if `main` is a branch, then
+    `main:other` expands to `main:refs/heads/other`
+ *  The special refspec `:` (or `+:` to allow non-fast-forward updates)
+    directs Git to push "matching" branches: for every branch that exists on
+    the local side, the remote side is updated if a branch of the same name
+    already exists on the remote side.
+ *  <src> may contain a * to indicate a simple pattern match.
+    This works like a glob that matches any ref matching the pattern.
+    There must be only one * in both the `<src>` and `<dst>`.
+    It will map refs to the destination by replacing the * with the
+    contents matched from the source. For example, `refs/heads/*:refs/heads/*`
+    will push all branches.
+ *  A refspec starting with `^` is a negative refspec.
+    This specifies refs to exclude. A ref will be considered to
+    match if it matches at least one positive refspec, and does not
+    match any negative refspec. Negative refspecs can be pattern refspecs.
+    They must only contain a `<src>`.
+    Fully spelled out hex object names are also not supported.
+    For example, `git push origin 'refs/heads/*' '^refs/heads/dev-*'`
+    will push all branches except for those starting with `dev-`
+ *  If `<src>` is empty, it deletes the `<dst>` ref from the remote
+    repository. For example, `git push origin :dev` will
+    delete the `dev` branch.
+ *  `tag <tag>` expands to `refs/tags/<tag>:refs/tags/<tag>`.
+	This is technically a special syntax for `git push` and not a refspec,
+	since in `git push origin tag v1.0` the arguments `tag` and `v1.0`
+	are separate.
+ *  If the refspec can't be expanded unambiguously, error out
+    with an error indicating what was tried, and depending
+    on the `advice.pushUnqualifiedRefname` configuration (see
+    linkgit:git-config[1]) suggest what refs/ namespace you may have
+    wanted to push to.
+
 Not all updates are allowed: see PUSH RULES below for the details.
 
 --all::
-- 
gitgitgadget
