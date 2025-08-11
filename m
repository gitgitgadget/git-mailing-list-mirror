Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C02E2F16
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949086; cv=none; b=pFyYimvbQBgrA8bBuVHJU+ZgIcSPBPA1Dq8kV7Q28WIuXktObtdGgvV/qY8wHLLtQupc/Pv7SIxh5mh7yNQdPhN7HhxwZTvtkrkGEOKtX9lXWeqWvWx3uVKNgumY66tzJ2UwhFTnjAIKWl9v+IgguVlg1jdGDGRcqFmSXiU/0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949086; c=relaxed/simple;
	bh=DV0RE0LuOmQ5WZcn2WDmG8Ap0E2kUBX0y6dIYZk8cdU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r4O/d9Uy+32wa6087l3IjaiFNTE3+LF4qyJjPdTmT+rJ3fhROPwJLv8LUHNWjl3eRfch8pnCHtl9xw8H+BCOgiOf3r3U2Vx2k4+Zm8M4ue6Zf61xLhawK6Yhi+mrAUBc7v/f9U7UKOL1YS0KexReaS2jFIRMtweYvkdLLMdgJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnZhPB0H; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnZhPB0H"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459fdc391c6so21092045e9.3
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949083; x=1755553883; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06mxZlMd6Ld6PBCaiMg0tF5UZv74Pr340bDXqAEbmMI=;
        b=OnZhPB0H7toWqMDxnbKqwZPiljuSW5KHCkuOllbEwvtp9GVLPlgSItXWYYhMVI/uit
         wgsHKOk9DnQkpjuAm6plZaLl263Cg0m8UK98JREdXXEj8ws6pCWO0ZI8zWWrEnrA3+Jv
         YST4G2VK3D/tY+99N8shdSG2gFw3wkQ9bzrDpgfIfwwZPjxkl+QHo3+m0i6urFAfJAw6
         za7ox4XWz4RWlR2rxfwsNEytBMcUMLb7lapwre5uUjBfCR+VYOaiXy4fw+FLTMRyw6Hv
         6/5c7Hmf7YpQJeE2Dkp7j+0sz2/obI/5idLzymaii/Bq9xiSGQMxRLv+YCQIqdEjQr3d
         g7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949083; x=1755553883;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06mxZlMd6Ld6PBCaiMg0tF5UZv74Pr340bDXqAEbmMI=;
        b=rrcHv27XWV8vQKUQicSkZzKspqPLlZgly/fS5dfTz8bMrovXexLg72Y4bsEj5DGyB1
         dFbmUs/OvFAjFYW0FjlK95Ao/cQRxtYU1OFWlbFNuUwtHAHsyFPrQ1DQtKgbpf7rEVa6
         zZ807i9VwG54bqu6fJWOOg0nEiXyGACiUbTrGJdVCiMTJVHQQ0l70tCgU7WN1/tsQpQ8
         LtvCtepx70Oc4Co4SA+QRp8QLZTQxtiWKD2MzvOz/1M4/Bv175/ONbEVIMJlcB2mg/xA
         nu6XOLibGRnffU/1sRHvu20EeG+5riYKDG08SW6ZRE/6mm091iu00GTe/zNUu/L31MkZ
         Dwig==
X-Gm-Message-State: AOJu0YxjQWKJnzg+xylwcaHhdh20y64uY5ZZHvePUL7IfbBEAanuzz6q
	U+4jXH3a6mNjHknfYsd1VRzf4lbT9GAGf0z9FxLYqVaYuuMMyFqRG5W0ogVgSg==
X-Gm-Gg: ASbGnctldkgOIn0oDRFomvRgWf2E8y2U0Wl2yR9USrCYuNzzk+K6wqRYEquVza/G3Gx
	SGn9rZhdXh9bmj0Y0FRqBanWv9FI4FtE1tvMyjqcrmZPOAYtrLVAytiaAvNvXDhA9wu64fwud+q
	px/kS42UPx2I/qB9A9XuVD48XXqetZ/iIE3Jw/irSGRqiMqyquaqIGbdEzGatMatwEh6wBlejr1
	JLXL5aqTzGH0Mt2E0c0SaAjcwGpBFiFSovgRuhhUPcLEdJubOFGxtWY85K6Z6Pjw0DXY2QFHWmW
	xfHgEpujn1QWuc9vpYazxbwKi2OOhRaxB6u9lAu7sCAFCpryH1Ar4d7EPq0I4utpEaTh9AbvSMd
	o1Jh9/AfmNTCbbpP8KG9/dtI=
X-Google-Smtp-Source: AGHT+IFxEv4MaUp7IRg7UBovBu5q5yAj3H9VuVIx8/GbLnKjo77hIIn8w/2auObNPYdmgO78JCg9SQ==
X-Received: by 2002:a05:600c:46c7:b0:459:d408:d890 with SMTP id 5b1f17b1804b1-45a10c09e5cmr9860435e9.33.1754949082643;
        Mon, 11 Aug 2025 14:51:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c489e81sm42454012f8f.68.2025.08.11.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:51:22 -0700 (PDT)
Message-Id: <4686417b28e4ab386983ad68e4d4d4798a467811.1754949075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 21:51:14 +0000
Subject: [PATCH v6 4/5] doc: git-rebase: move --onto explanation down
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

There's a very clear explanation with examples of using --onto which is
currently buried in the very long DESCRIPTION section. This moves it to
its own section, so that we can reference the explanation from the
`--onto` option by name.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 168 ++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 81 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6d02648a9b3c..d041d87f270b 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -114,87 +114,6 @@ will result in:
     D---E---A'---F master
 ------------
 
-Here is how you would transplant a topic branch based on one
-branch to another, to pretend that you forked the topic branch
-from the latter branch, using `rebase --onto`.
-
-First let's assume your 'topic' is based on branch 'next'.
-For example, a feature developed in 'topic' depends on some
-functionality which is found in 'next'.
-
-------------
-    o---o---o---o---o  master
-         \
-          o---o---o---o---o  next
-                           \
-                            o---o---o  topic
-------------
-
-We want to make 'topic' forked from branch 'master'; for example,
-because the functionality on which 'topic' depends was merged into the
-more stable 'master' branch. We want our tree to look like this:
-
-------------
-    o---o---o---o---o  master
-        |            \
-        |             o'--o'--o'  topic
-         \
-          o---o---o---o---o  next
-------------
-
-We can get this using the following command:
-
-    git rebase --onto master next topic
-
-
-Another example of --onto option is to rebase part of a
-branch.  If we have the following situation:
-
-------------
-                            H---I---J topicB
-                           /
-                  E---F---G  topicA
-                 /
-    A---B---C---D  master
-------------
-
-then the command
-
-    git rebase --onto master topicA topicB
-
-would result in:
-
-------------
-                 H'--I'--J'  topicB
-                /
-                | E---F---G  topicA
-                |/
-    A---B---C---D  master
-------------
-
-This is useful when topicB does not depend on topicA.
-
-A range of commits could also be removed with rebase.  If we have
-the following situation:
-
-------------
-    E---F---G---H---I---J  topicA
-------------
-
-then the command
-
-    git rebase --onto topicA~5 topicA~3 topicA
-
-would result in the removal of commits F and G:
-
-------------
-    E---H'---I'---J'  topicA
-------------
-
-This is useful if F and G were flawed in some way, or should not be
-part of topicA.  Note that the argument to `--onto` and the `<upstream>`
-parameter can be any valid commit-ish.
-
 MODE OPTIONS
 ------------
 
@@ -240,6 +159,8 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
+See TRANSPLANTING A TOPIC BRANCH WITH --ONTO below for examples.
+
 --keep-base::
 	Set the starting point at which to create the new commits to the
 	merge base of `<upstream>` and `<branch>`. Running
@@ -1018,6 +939,91 @@ consistent (they compile, pass the testsuite, etc.) you should use
 after each commit, test, and amend the commit if fixes are necessary.
 
 
+TRANSPLANTING A TOPIC BRANCH WITH --ONTO
+----------------------------------------
+
+Here is how you would transplant a topic branch based on one
+branch to another, to pretend that you forked the topic branch
+from the latter branch, using `rebase --onto`.
+
+First let's assume your 'topic' is based on branch 'next'.
+For example, a feature developed in 'topic' depends on some
+functionality which is found in 'next'.
+
+------------
+    o---o---o---o---o  master
+         \
+          o---o---o---o---o  next
+                           \
+                            o---o---o  topic
+------------
+
+We want to make 'topic' forked from branch 'master'; for example,
+because the functionality on which 'topic' depends was merged into the
+more stable 'master' branch. We want our tree to look like this:
+
+------------
+    o---o---o---o---o  master
+        |            \
+        |             o'--o'--o'  topic
+         \
+          o---o---o---o---o  next
+------------
+
+We can get this using the following command:
+
+    git rebase --onto master next topic
+
+
+Another example of --onto option is to rebase part of a
+branch.  If we have the following situation:
+
+------------
+                            H---I---J topicB
+                           /
+                  E---F---G  topicA
+                 /
+    A---B---C---D  master
+------------
+
+then the command
+
+    git rebase --onto master topicA topicB
+
+would result in:
+
+------------
+                 H'--I'--J'  topicB
+                /
+                | E---F---G  topicA
+                |/
+    A---B---C---D  master
+------------
+
+This is useful when topicB does not depend on topicA.
+
+A range of commits could also be removed with rebase.  If we have
+the following situation:
+
+------------
+    E---F---G---H---I---J  topicA
+------------
+
+then the command
+
+    git rebase --onto topicA~5 topicA~3 topicA
+
+would result in the removal of commits F and G:
+
+------------
+    E---H'---I'---J'  topicA
+------------
+
+This is useful if F and G were flawed in some way, or should not be
+part of topicA.  Note that the argument to `--onto` and the `<upstream>`
+parameter can be any valid commit-ish.
+
+
 RECOVERING FROM UPSTREAM REBASE
 -------------------------------
 
-- 
gitgitgadget

