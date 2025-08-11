Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE73246783
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943197; cv=none; b=oz9Uk/qAbGS+U85ZFEz1aOBd2W2QMcHO4MmpGqnSDK03OGuunuy9daDU9JVGRgXHcHKFZXakjSNLL4X1HPMtIGyloW0OD9mjXQby2WEzpgVWKe2ip/jSNb3TgTwGpcnuGG7gVv3znx2sw/5KsV5KWGRz/kh94Afvp5L7nCpUrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943197; c=relaxed/simple;
	bh=ZnI3GtFfvfrKnYDL1eNT/4Di74XQZJPH9SvYnEI9PAY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pO4zWFUUXpcAZukQ+dEkOVWN6xqRxbDtV0YOM74j02M7BdgY9SH+cjrLAtnIEn/MpfRX9Ulop/aaND36NPm34YN+tJ2Jk7WBnXj7Bz2ehgQmWnVVruq12StdKaYhMvOjc98FM8+dBmaN7MG8XTgspchn+ycSrimbNjDeODv87NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP78la0l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP78la0l"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459e794b331so28791525e9.3
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943194; x=1755547994; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yzt61kZKvRDF9uNcYfHqWf3JhDlQdRlPdasvu5X05Wg=;
        b=hP78la0lKiN+W2p7nf7jwMvsEdiz5E7VdHdaITxRH4x9j2ckALz5ITplr2H6JH1LoP
         Zr8KkDvZ7jxmqznzXEefF7jcv60U0qB9XV5tl13/ZphsimcWSu32VKhlNVkeTf+xsgrm
         eLnAY4PDgNJOYE3G45lbbUjkQTDmuVHxe2yiFmA3HbUL0DYNBAb/+s4MPm7Z/Q0owBp9
         PKfYQVCSg3YohB0dFp+x+KmWpiq//+YuhWQU52qt6gP1QiTKK3mtfTUTLBQb10uR5THg
         gGPzxxIBmHtuCZ6eSFyv+VJZVwbI/vDOhqlh2i1rda49xtQDbHIGf1XOErJhzBpovPEm
         BG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943194; x=1755547994;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yzt61kZKvRDF9uNcYfHqWf3JhDlQdRlPdasvu5X05Wg=;
        b=UnYBkxyqSks8UAC+LrfuXfXysLRqcnr/T2egguanBnDSDLfwokqSbfjZ0WgG7lCeBF
         dwImCeUdJecI4S48EOXPqLeOgRWvbtoec9frxjNrhT8Lbyx/TwuevNiGIivvYgYt0Co7
         rv86F1NcRWCnFStB/LyIi4Xe+jqGXUCV+CLiIuQKW3Tdwb2lEnGpxBr+cTlL+hKdZQns
         nfKEsV1rQM4ne1Yzx35fTclJNdE1g8fo0xMzOMkc/QKwcXKqU0L0qiirHaPdjd/o3eL1
         0x4Du/AdUeHuTRVNIrUZcI6uPq6LCjaATkVyadcBk3nC1dtgcgC5vCD7CVOpX4N982yk
         Pi7A==
X-Gm-Message-State: AOJu0YzMLgLl2ytKUDdRvmBJDA5tCnHwq+kU5EviUkoUdeOvps+Ta+yZ
	5d2M3xKDOb65NyEoY5SqRKasnznSV1GFSS7m/fzstKu8g/r+S2Mnk77Xq3XUlw==
X-Gm-Gg: ASbGncsTEq/FI9UwlGHnqByNZ60YhwCOyqd4dDw6EGIAiB3GSQXN5rGuoOB6xqxOh6W
	IwgI5GuhAfr9NKsIJBjFmWMhGaXSNDS/U70ZzE8rkvC4ibrWSPvBDVhVdgJo5jnU6nb4TJsPeaG
	xxu8G6Tfaek6bVj0ZFy7TWVCs2PC5vxkkE6kKFfGEf78ynuxJ+d39RT+MpwLCyi0u7xqprHdXN2
	rySk4nKjvhyWij+RhxIRtPgqgi0ECnLcCpLil5wkBdQGwEkztu76pAl4qNQmWXtB4fBI9TUv+cr
	6BQ5GC1RdNp8Ilc7WtL7Rf+qkLMPt2oP07UCDOUH1UYxWkWGDO+OXpoCM0RAF+QGXKWAYCuKX/1
	uCzKMK9fIH8mmD4Ai6KWo3zW3RkUme9q37Ogj4fUtSbpH
X-Google-Smtp-Source: AGHT+IFVka03b01kXGyqWGV6rE129hpzBLYnY/O4qiRKImMh8T01/t+y7yNsE/LJ0E+xTQi/ljDagA==
X-Received: by 2002:a05:600c:450e:b0:456:161c:3d77 with SMTP id 5b1f17b1804b1-459f4f12658mr126238585e9.16.1754943193842;
        Mon, 11 Aug 2025 13:13:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c485444sm42219597f8f.66.2025.08.11.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:12:56 -0700 (PDT)
Message-Id: <5459b7ff5608580045ac02f27530e4b3919ce00f.1754943127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
References: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
	<pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:12:04 +0000
Subject: [PATCH v5 2/5] doc: git rebase: dedup merge conflict discussion
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
index 03d1b74a9a09..4ba74a8cf9ba 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -42,6 +42,26 @@ shortcut for `git checkout topic && git rebase master`.
 You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
 MODE below for how to do that.
 
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

