Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C575276054
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702068; cv=none; b=eJ3uICThbJizCLUziytsY405m4so4yZ0IAsie4VD385of/vxkzprv1G7PT29HzbU3PIoj7DJc1PcE/EZ1YoNwC+wiBUwwwyIlHh5SFr7dWpC6KTRAXkc3LkaaJbi0m1cLuAhqLgent5vfw17SUDXA7hrZK+kMRQbJWFtFy7+FRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702068; c=relaxed/simple;
	bh=enuVrBAfLYvPN3FIHQXhRa+psQr4KLXoYLO6Pfo+UMk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bYMJR9J9rsjjfdcRp22COv69C0GnzdKnxJD8HCNslIypG8MWYLMYhN4zNKi6d30tJTYxwlRVKH5Z3AJEo9Gs5KYbCEWq0la7yenSG5RPFLrn6sU7rNVhYznDf/RjOucMQuE2IK3b+ogoftlw8O8cZeEXegVaScZvd5KpFtPHJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbqCEQR2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbqCEQR2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so1571045f8f.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 18:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754702065; x=1755306865; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWnZbo994yDCa/t2+mRPZIhkTJrCDewmNk1xtheKjOQ=;
        b=dbqCEQR2mecDVAk52PFIuc85fQLSDFKZgQfMl6teTe0t/azApEYsM6vi4tlBOJZyBg
         Jrpi/P83jvoYJpKeaJqg9O/C3umPjASAl5+2SoV1c9jlya5r6dGzXU/qKSRtSbdXxq7W
         eiOIB5MJMOPhhzQzF6KlmmuhnPnMHW8bCmWrpwP7J7DhDmkY9i9Qo6T8NMUR2n4bZ8S4
         ovpXCYXMg3nffvJLMJk8T4gKApM61koL16hQvKi1/BXNySYh+MC2oIGMsvcW1GZdEDrE
         w9TH+e/xWNZWoBCbXP+iudonuLziB84ck2e6Rmvxiwu2hr134V1LVcgkYhlF15uADTNO
         y/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754702065; x=1755306865;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWnZbo994yDCa/t2+mRPZIhkTJrCDewmNk1xtheKjOQ=;
        b=rqixLfY6Vw0sJDxZec93m248ltuyEize0gUV+jAooABZqvOQ9hFA857eDVls+5BNrg
         PdFxJC4CRmmLQRqtxW5yKDZUwnReBqEYpOMEm2Wlh4oPwICN6fIXXOxXCRRovXAAqtlp
         yLq7hc6U/KRXlwH4G8k1lNaw8YISCNZsfhXz2MqqnxcL3vjdr+7G1hmx5tFjj7vzBRQE
         Dgwj6jsWWrJG4/yycyYSAIsLZjs0XYT6u+z80gPRb4Mq1t6P3ZxGccIEeHcOBFFjyfnW
         +bX1c/2HK4aDTDvfycv69NRxSjgZ8C9hu/W9RG7cuakyuyAce9eGKJ8/ETJObKPWRU2W
         S9jA==
X-Gm-Message-State: AOJu0YyJihCKWLxE6mPZn2satDJ4oq5fdBTtVwyP6GJn9aAupmF5rPX9
	E+QjRms7+/cuH5+lsMt4naRr+StfKPf/eo/0rMocIHAFBOJt2Rv3qNo7n35M2g==
X-Gm-Gg: ASbGncuaQRXSKVm8REtiQ/pvmRYdWNtThOTsUJkqYQMtEfnz6EklDKGLYzY9sADr6cP
	qWwXWbi+FUF5HCHznAxCC5B42JtHmnOJSTbyNz2WXllEoeQlBXV3weBVVHvGp+U475fT2Lohmdv
	4BWz/t0JiSXhIf1FRf04eGRwmwv0bEUPtGB8+8rJXy2K1WcewOCfz4SgsNmqX0HIY1YewdqQE3I
	ytXxaNXb+2apIr8SEkOlSbPrbrll87boSgS5Oy2Se5NcbVUvgqR6XziKRppkK6sGqauFYuMxMPQ
	2r8uge72l7VW/5ZxM9vheZcO9VqNBiRWYR4/gn3RbJLSibeSK2a05oblWdtXfYfV2HyTHTL0NqE
	g4sIu3I0RYKl8jp42xsrp7xOrTp4I/leQ1g==
X-Google-Smtp-Source: AGHT+IGvwgA42gzMmSh0z1ftHBnsSGXs/am39aPxRN5fiztPfWzybFKXr9wnuoec/fT9FCkq3ADHlg==
X-Received: by 2002:a5d:5f82:0:b0:3b5:e714:9c1e with SMTP id ffacd0b85a97d-3b90092ca4bmr3524415f8f.12.1754702064519;
        Fri, 08 Aug 2025 18:14:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b95f4sm31893073f8f.23.2025.08.08.18.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 18:14:23 -0700 (PDT)
Message-Id: <b37ebc8389d1c1df0f0114d9105e774d745e4361.1754702057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
	<pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Aug 2025 01:14:16 +0000
Subject: [PATCH v4 4/5] doc: git-rebase: move --onto explanation down
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
index 914f743ae00f..50c84f138212 100644
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

