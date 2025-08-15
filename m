Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BC25782D
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276760; cv=none; b=Vt5EUg8Q45gMg2DRWYKhUxqRFUGxXrFq26obIX/4Mr/dKXyKIgkjvVWbFIzocS0bc1pwNtI+KYOVyfI0Y3vHMZpO26ucD2KljENKvHj5jWIlJDnOg++i/22bcIH4B1P1emzAChiB5y0nQCR9jW4eCenFupn5tYp+sVzUXlGSyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276760; c=relaxed/simple;
	bh=DV0RE0LuOmQ5WZcn2WDmG8Ap0E2kUBX0y6dIYZk8cdU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K4dXGCxWGyJ6lwX8JetnQsMeHHDoVQZhxLdT5uetJT6N2mwuxJyqB9QjlNqEq9vXVQzga1zcqlpugWxXn2d3SmAyo1gG6iPUAQS7xrXkYygS5qEFJLXm0F1pRFyaY20hOvuyKtU1C4l4EY9Q/w2qgv6GyuN6ifcctjgj2403zWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtsduOeN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtsduOeN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9edf36838so1379008f8f.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755276756; x=1755881556; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06mxZlMd6Ld6PBCaiMg0tF5UZv74Pr340bDXqAEbmMI=;
        b=TtsduOeN+K1HDWmu9IPQ4u9iaSv8YaeQiu0B65AItcJ6FFEAtFjTJ7YM8mRvnat+bd
         oH75hG3kOf/Rc534j95vLBYU8q83fiwHEDONkZglpAoXkXtWOrIsaTYcpbF0hKQiqfoM
         lwBK1yokAnz0XT24xEuUk8AAiGcTkQD+/Lnn9Th9qbfwZPqC3vCtyK12/TJsmlK/nSKM
         gjY9NmS/rMhHssY1YNIqsu4Hcqvx6L/5365LAo+Abo3W1cayN/uRDjSfKAm10QWv1RiA
         W1z3/q0/KCy3Bsqpzd2Znngb0L7OT2+0mUEfBBu13AA/uiXoqxWjWEgeAc4jKHlq9PZ7
         lK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276756; x=1755881556;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06mxZlMd6Ld6PBCaiMg0tF5UZv74Pr340bDXqAEbmMI=;
        b=SC6PN5IWSSr9BlUSlWGG/IgltEm9aUuOYeyoSHrRlBG4aMTBJ9F+RuWNJ1NhjgccTD
         daNMgN/tW8dlDJoxURhYKVEOnxoREo/8z0kLFa1IGUP4LX0jPvG8n/hJkr2boSxU48vJ
         xe8RmSMJZOtwOZesPpuVKF6CvLXUroPsT0/ceG8CKLjkQk78pEbhHrI2S7Kvi6vx4dT4
         7pWqFFf7v2I/RZtzXvknW+0QYS8NIEJvNMpEps/7zHXIiqQ8fNbLBug6LWv8wOWL1W+B
         BuUzPPfcbAY+DfWxkcJOckVyRj+MESjX/6yKADuZpNuRiH+amTKBnkEmPffSves+vYOY
         V5Qg==
X-Gm-Message-State: AOJu0YyoZUQ3GGnGFiIJY58uljNzt8x8Gvosezu1z6jtAQIwm+ZTKbTI
	lT6/JE5/MicmLUoCuJ2WSK5E+wtVD/iyhQMAx7MKMY9Lssmr6RQw6IjCqLFSeA==
X-Gm-Gg: ASbGncvtITdR0o5d5F03U69wlPUyKzGxAB0G3nz0rG1X6y/YSfcymnBjj8ZRXAGcz0g
	WKVZB2j3H5LZkAnXelNskcxRNdu25iZKXviTUv/wMAsk112TjeCuOb/XvanzU0om4nBKv+3ybnw
	ba1OxOHN5gzgDqAQlmhoa64x3g8qd13VddUjysiSsoRE95sFEe9Kp1RB4bgZtnvV781GAiiOPra
	OChNcuZuClp0QTtTytvTIoJ/LpNsv6kwsCM44YPAmOD209OViethVYcfXfo2wLEQt+e14WYAxT9
	lnTd3zAGGsznQMat2I+GRlC251NBV83GRSher6v3zdYMMO09swV8BPd51d6pbW5Okhn2I123N4y
	S2HxKOFmvRkZr1uvT+nucq14=
X-Google-Smtp-Source: AGHT+IEtLdzAueajjc/SmAVU5hJN6B9PIw0fdBkxUy4qT3+4fit0rl72wiqW3wOLK1C8rH4DtcSlfg==
X-Received: by 2002:a05:6000:2002:b0:3b8:d79a:6a35 with SMTP id ffacd0b85a97d-3bb66e16f8amr2228590f8f.20.1755276756136;
        Fri, 15 Aug 2025 09:52:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a233257b7sm12364095e9.3.2025.08.15.09.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:52:35 -0700 (PDT)
Message-Id: <4686417b28e4ab386983ad68e4d4d4798a467811.1755276751.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
	<pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 16:52:29 +0000
Subject: [PATCH v8 4/5] doc: git-rebase: move --onto explanation down
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

