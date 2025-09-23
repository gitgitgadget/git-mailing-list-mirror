Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6E86359
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651059; cv=none; b=gQGP6xfYeCFH1w6OYrxzX/WpfP61uWcRNtb/kn8pnynMAtUbIA13dx9kunec/MrTBhRCIULEEqUungYK1xIsR01nUDyp9RTOLb1j/dit/G185zxIlnIyc0euIasyMyHv+E+llv1P8pOZgagVqubi4v6D1YZ8LuPXMendnLndmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651059; c=relaxed/simple;
	bh=sIG1tLtGSjqk7MrOebTqiuoN7yLj/cvFM0JG+knK+DQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pofRJhVo9rTOP5jj/iBdS6RW+VubPjQud8Ct+x1veM8Y+TPWRRaM6UDWhjtYyRDv33p1dK6pMxtSqiWtwB9jlwrvADklUQHQdxW6UIGs6hPh2O7iI3LkfCIWEC3u/5Wf88jpgmHr6jSjz+l3Izc6JEvoTLrEkqt2X57h+InzSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/4TdfFn; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/4TdfFn"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-42571046185so18352055ab.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758651056; x=1759255856; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWz763opHteEWbpvjgA1q/+qQxg7uYsqe4Qdz7e5UoU=;
        b=J/4TdfFnUcC55OmbSPuHTYuAHBmUPo4p34Ynpp5CTpNXc7nW/28qiMQhe4ZhgcHxFj
         pCuBUAdBTm1HTl8XCfWaCamFIApamrD/rxuvtrBNZJxHDVxB+gBRxUIwB0tQGjnnuLLs
         OT75oeQDfbjI0G/Su7NFc2XhlUWh0unWoSnhBqNzqgttYjY45IZRmXWaHrw04jbWtSKs
         tSJrg1PMEdalecD5PQPZK+qoWzgy9q0l0HQDSNJZW0VaNCwk5Jw/dOkSDdz23TqjCM8L
         LQQI7QBmWu0/f90E2aNoAk+Y5A6Ui3/u3Bx4LVe25jppmEkzOqiiGZJpkwy43xPq4aWA
         dYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758651056; x=1759255856;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWz763opHteEWbpvjgA1q/+qQxg7uYsqe4Qdz7e5UoU=;
        b=oc+32NKobfe7pAac6bojwlnrWzec9t8LhD/UBaYBJ6zp9BhZ1kkO96s4cwkQhFLF8p
         8RVzqelOrziVajFlSp8AW4lT9zVdX/d9mYHdSMRqfBPT1AvttkkVFuH5LeOaszvmN94w
         lAyV57zZqygbk2db/vwdLTcKXv4pHUkdelQUudUGm9DkSqNl86NFf/RHmrEuQJsd/zzF
         LimAmKMUTJCSyexohwX3bnA/XEgSw13SG94BEsk7GB2QvllVe2V0eQBf9X5sSIkSgWdd
         ulmHkVAVEGh13CqAIg3ayFYtYOChD7WKab1mH1i1/fVmSkMBXqPWs64TkChU5Oq/ST/2
         3L7g==
X-Gm-Message-State: AOJu0YyNmWlPQbZqVdO6EAqkwVtQoI2OYlQtvQ8WBmhSO/QPFdN4Z6wr
	wyIxGTS8WhtBujQbbh2832VWnB9wS5qG8l7CmobRhG2t3cAnAKYNGjBjOSE4rrSy
X-Gm-Gg: ASbGncsNzqDgHSThg8xrkAE87T7bJCOIsXO8cRIcFs99fvghYgC8KPdGDnFGGit2Bbc
	/kHBynag6HRvC3NYFCAP8aryHH4iExuDLt0B2M+d3vkdfXOPThMVCx2CrDloQJR66vxWbTAMQ6R
	OCDM52lMR5TB666bpKQH5AIp6e+vKm4ekuZGR1FfGWuLTZ5gSHukBCEXSKqONp0BSrkTXfwUwFI
	/tEPb9EF0F1OTInGDVN2idAfxSbq8Vkc0/kXeg4rll+pIdTCkoIQeJQMiuEZwIhPVBYO8QsG8hB
	hu5zoux/U8hmSCzyfeVF/XuBy9eiw0XO5eXBTjfjeCJKJleeqYAGNLvIOwj6n6N0leZMW/1C9RI
	9mkbgz45ZLxy31pz/GGaCQlmkvQ==
X-Google-Smtp-Source: AGHT+IHvydpW7BMAzjkbleUfLFsWqWJFVgQB+uZMXcZEyu9MRB3AOL9ertDlpBAGyoloWIG4Q1UY/Q==
X-Received: by 2002:a05:6e02:12e4:b0:425:7974:fe32 with SMTP id e9e14a558f8ab-42581e97a79mr59299705ab.23.1758651056065;
        Tue, 23 Sep 2025 11:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.121])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-424819d4f74sm64189155ab.34.2025.09.23.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:10:55 -0700 (PDT)
Message-Id: <11ad190c3ea457352a7f3a589bebba97d20f7ee8.1758651049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
	<pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 18:10:49 +0000
Subject: [PATCH v2 2/2] doc: git-push: rewrite refspec specification
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Julia Evans <julia@jvns.ca>,
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
index 4faf915f94..ff125297b0 100644
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
