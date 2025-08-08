Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159B2877E6
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680535; cv=none; b=MaDa/SDW3UF8WXQkNQue0V8C20detJLzGwKZDhuLXopUrpqjHq+37VEYIUDgChI9V+kiADoREXuiDLIlsodvlij1vE6XHEcqb/xQyHoaUWvCeuOOaeUJy5N0ZtkflvxIe/wjeCLqicDa1jYaEM8yih4OhMeIhyzVu4xXP2lBQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680535; c=relaxed/simple;
	bh=rjjGEdK6C57JfHWZAT6jqcC/xfjN4QSZoipQYuBhx68=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gu0XDcFnikBE4z0lIBWcOmOZcGXop0tWdnYZCEB6Gv6t2AUjmQkNL3uZQ39FLOgraUTpvUjuVdZxRTieDnDJBeQXyrsEslrJ4ESIFVcEBq6+3rgS1YwfZeHI5Ux105L2xKiCQOtmWcOO2pIxYMx0F87ko05P+7wyVDouT96chyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+KPnxit; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+KPnxit"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso17287995e9.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680531; x=1755285331; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op+6J0CEbbg1MQLl3XWMsPDYhymrMxH1gqtZqtpxllE=;
        b=Z+KPnxit1GS587bJcxJ3bWi48GZACP+SuovWmuIhJNcfGAmU0MhWCx5y26W56cBZn6
         UBcc+ovKE81Cvg29/4nO1AUv9HkDqFSuhKFZ0Ck9qM83N1Am1lbuNG+fpJgXJSLXLwjV
         /ele5vgGJgvn4o4Q2B4G+vZpDkIAcNvjRRywh0tGpw1XBAdtWPR27+dNbKChCXvtNZtG
         8m62IumqrJSke3yaGAYtDSckUbgFaQEkb+T4+IrAS19vDjRIZXA+GeGWwmEvAfuIQBZ7
         uyIleXKIBiib6id24LL5JMeUiYabAZ2umnzD6WqNCzUF4KinXixpTCdaFNCsADJlUk/D
         Dxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680531; x=1755285331;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op+6J0CEbbg1MQLl3XWMsPDYhymrMxH1gqtZqtpxllE=;
        b=vsiAjPof/E+Vw+aChNuLFY8R3HSLP5wC2MMKF3JhtJTs72Nv2pIopYOOdJzjawKIbL
         n2mme7IgZhNQtdxzTewQMlAwLQRS1SZlQjb3guiDH1hxwBapdUIO1RhU9iIiOd1FDoXO
         xY+tAC3GwYc3BEni5xSZpegSmzkBASksa/byqCWM0qxi1IUUK6bWdc15FZ4owBfe1iqO
         w6usZ0eP5z4J5zQW+xCgTxW1fCG93cCYZrAi200AJXMetdsaokWxmRDmXFgL/uwGGyxM
         uUi9+TJXH118ro0M9k0C8w1FTbT7MiSFD/Ux75DjavrM5awxMYXeubkr51dzO/1EAY3K
         C8Qg==
X-Gm-Message-State: AOJu0YxVoihGPfSESB0U1GnloQaXNQShqlbbpC+ogYhHqw4l1QErhe5A
	QNeutKHfOfNlAUR/wr3uXHt/I+IvGab2ZYTN/CtO9M8OFxa0q72DhoMvUuWD/Q==
X-Gm-Gg: ASbGncuFXGKwz6Nwpee+g3+dUMtn4Gqp0RGVsZs7IMii+Ibshaysy35ctOfCKNa7IJB
	DGqTYoIqVwa1zCqfhCSEMSCf9ZhouK5dEvyetZxUg//YFsd+6cDTfYFAnjTftJmtbzmJsZoKgzV
	7EfhV1VmYKS2JjUKae3RbgtGyCkdpC3oHPZ94phHi8N1LAj79v1s1XjwZgIlPnE84FBBXXfQI/2
	XK8B7Tu/wlT7xtXnYXgDU3gSiQ0gSooMhZK8g1jVMVugXO8/VUt0g+RmRDlsS9wT/w668X0nLxZ
	faGjl0yRLYmEva0yExgc2AZ2LTqMy11+AD7XcJllzO6hBn4ksKBbDbxSoi0QNfuet2SxPeCOCxe
	o/Zs7tAlKflS56x0bO5WhHZY=
X-Google-Smtp-Source: AGHT+IHg7ClYuJUfkCHtAMMVUO9vPpxVrbgcA15sDWH2N+MyXAdHMC0nWI93o/CJ8cA1Cj7Vt4lilg==
X-Received: by 2002:a05:600c:3b1f:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-459f4ea0e52mr35520705e9.7.1754680530899;
        Fri, 08 Aug 2025 12:15:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abec8sm32590360f8f.8.2025.08.08.12.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:15:30 -0700 (PDT)
Message-Id: <590d7486d3d5d6bf4e9542743b21727da690dd50.1754680525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 19:15:24 +0000
Subject: [PATCH v2 4/5] doc: git-rebase: move --onto explanation down
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

There's a very clear explanation with examples of using --onto which is
currently buried in the very long DESCRIPTION section. This moves it to
its own section, so that we can reference the explanation from the
`--onto` option by name.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 168 ++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 81 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index e700b92e35ac..6a4b3dbd5960 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -111,87 +111,6 @@ will result in:
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
 
@@ -237,6 +156,8 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
+See TRANSPLANTING A TOPIC BRANCH WITH --ONTO below for examples.
+
 --keep-base::
 	Set the starting point at which to create the new commits to the
 	merge base of `<upstream>` and `<branch>`. Running
@@ -1015,6 +936,91 @@ consistent (they compile, pass the testsuite, etc.) you should use
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

