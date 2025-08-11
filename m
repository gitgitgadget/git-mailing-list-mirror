Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381D2DE70E
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949083; cv=none; b=rjwTfeF1XhPlru+ZqsYR2CYdtmSNPfV3kQu+edKYuvj6CBDUGJxyFKSJO13rZevWfBgdubIMMWZ4U6RP9lVyFc0XR3ooKXQWIGORojnv5sECrryZwBupS9Bsp3BElWrFnYmhvcVNnpp0/eDSICqf7NgZ6OLXwYopeNr4gqJtYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949083; c=relaxed/simple;
	bh=za/ukFKQGqA36EPz1/OuDEbzJFgoW9BziIJMv34+xwI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FJAMhQwGwq8wgru0OkxMegp5p6XmhQaGNbNdTFl+2ypt0D5DVmNiTndpQ8/ezf2/EMxzXa3avihY/BQOq+/HYfhWPKZgInACUmu3D5EtPwUQozUJ/jd0jLeGxYzKuQf07qi9/S/pbN2WoNMV97yKqfKeMcrA+ZnjIszVKlwwcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUwtWF5s; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUwtWF5s"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so4935457f8f.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949079; x=1755553879; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxMO6H2NhV3OshelcB7U0Qq9bv/miJ2JN23nmRaw7LI=;
        b=LUwtWF5sIZQIUdptqJFd6p/BCHWqv9Wd1KpkZJu3Fhee/7BfP14PrPNMD0aQmo5+GE
         cgoRizHjpnNbzgmUpBnebxiIQlcQDArC9PiGSYIL9scmRzoLjYZ0nZYbEd7t5EX69AiV
         v30FXZJsuIG7f/2Uyac6SeFbrDPDLTWNEUt8925nMuMcdxtj2iVboRoWMwsH+ei1PMlg
         u5zHWL4lET9qAPzNaHdmz1GbRhPoJjsw9907Yqbv3X8WWrXVGsa4Y4FeyfExN9ofqHEZ
         Zk/oyAA8mVjeo0zu6ROgtqrRuE+dwceEv44ESCGwzYFAXl0Z1ojZobn9wTjo+eW5rSpu
         AO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949079; x=1755553879;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxMO6H2NhV3OshelcB7U0Qq9bv/miJ2JN23nmRaw7LI=;
        b=g1yhdqz0CU5QcLwCavUmNEnnl1oZEYDjFoFmc3JHj6wm1YevvvFca8UFL/8s14FXhr
         RsTBpwxjEkp+gwUUgwRFUKjIdr+u/IEEMWkCU6/Pm+UPs4qvq3rkrPvWdQKUCVzRGhAI
         k3OBFc0aHTUsq2yAnX+bMeMwVC6Lde4SxkkpKHVzA3IIieLP1TLE14NmSdIOX7NIIuEV
         QMIxoSckULlvt/wYxvGhJEiC4eAHyNu45o4bh+ceJ5n4v6woueZBmIU0ZGA2fSrPgUiO
         nUDrSbAmFyFJdPjmiAtTcCv6fsEaJjZU854E9wxDhN+nbCJVabloXN8QxNjJjdZEsVyh
         Ojfw==
X-Gm-Message-State: AOJu0YwR3j9uBhK1/XtlIXIxM1YZiRbD9BCXmxZtEsGa/DoP6GBe/92R
	dr1zuklPqrBXaBRyN5Ed0rTnIcSyRUT19KGa65iEHd/+r6NfPAIJUvwahwpbdg==
X-Gm-Gg: ASbGncvXivI+mIJw0ylkYXsC9jxIFFTJtN0Mqh78J8bfWl/gWYoTVN4+FExiDsX8J5v
	ymFURtlrHlS0m2CW3k1mq92k1DJINliUfgs1s9+V5m4E/zexLwn1f+k26SYtOBdI5Qzo5u0xkuC
	FEGdkgIDJ91XFku8YSZGSl+pb4mCDubOImnkzf+2at1pbbAN5P3oAik4lTpTxCNLr6oxVUX0O3Z
	QsjIW0ap8hvIWt9B52q168EdJnCFslOHAEzlbXHgpo5hTB++aBUc/xaRIDD3E+1ZunWTq1tvh7z
	du8fmRD3PUDrS01rtfTcNuHe0c3xXHjEhaLsX4BH1+zEIQZ3yd2YzPERfsTh3TO1LWEQRYfJUXx
	8McsJlLwLAdfn+AIgdBGruUU=
X-Google-Smtp-Source: AGHT+IE2vhgm1hD7IBjVl5pwiAM/OTaNkE3fNcv3t63QNzRnH3HESoZnMDAOfF3+K9oVita7fxCvGw==
X-Received: by 2002:a05:6000:2507:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3b911012192mr874211f8f.58.1754949079054;
        Mon, 11 Aug 2025 14:51:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm40877280f8f.57.2025.08.11.14.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:51:18 -0700 (PDT)
Message-Id: <ad63f69918df0130b6b0236d04e27f8529115cd4.1754949075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 21:51:12 +0000
Subject: [PATCH v6 2/5] doc: git rebase: dedup merge conflict discussion
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

Previously there were two explanations, this combines them both into a
single explanation.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 49 ++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index bb5a3ff7f828..e82ceb9cbfce 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -42,6 +42,26 @@ shortcut for `git checkout topic && git rebase master`.
 ------------
 
 
+If there is a merge conflict during this process, `git rebase` will stop at the
+first problematic commit and leave conflict markers. If this happens, you can do
+one of these things:
+
+1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
+   and make edits to resolve the conflict. For each file you edit, you need to
+   tell Git that the conflict has been resolved. You can mark the conflict as
+   resolved with  `git add <filename>`. After resolving all of the conflicts,
+   you can continue the rebasing process with
+
+   git rebase --continue
+
+2. Stop the `git rebase` and return your branch to its original state with
+
+   git rebase --abort
+
+3. Skip the commit that caused the merge conflict with
+
+   git rebase --skip
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -77,13 +97,6 @@ any commits in `HEAD` which introduce the same textual changes as a commit
 in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
 with a different commit message or timestamp will be skipped).
 
-It is possible that a merge failure will prevent this process from being
-completely automatic.  You will have to resolve any such merge failure
-and run `git rebase --continue`.  Another option is to bypass the commit
-that caused the merge failure with `git rebase --skip`.  To check out the
-original `<branch>` and remove the `.git/rebase-apply` working files, use
-the command `git rebase --abort` instead.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
@@ -186,28 +199,6 @@ This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to `--onto` and the `<upstream>`
 parameter can be any valid commit-ish.
 
-In case of conflict, `git rebase` will stop at the first problematic commit
-and leave conflict markers in the tree.  You can use `git diff` to locate
-the markers (<<<<<<) and make edits to resolve the conflict.  For each
-file you edit, you need to tell Git that the conflict has been resolved,
-typically this would be done with
-
-
-    git add <filename>
-
-
-After resolving the conflict manually and updating the index with the
-desired resolution, you can continue the rebasing process with
-
-
-    git rebase --continue
-
-
-Alternatively, you can undo the 'git rebase' with
-
-
-    git rebase --abort
-
 MODE OPTIONS
 ------------
 
-- 
gitgitgadget

