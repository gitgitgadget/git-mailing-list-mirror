Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E01246783
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943220; cv=none; b=S+AisgnDHhpADslfW6p1nbSnmgX6yQ8oUuOB/RCJ5d0OcDKYJWvLo3jsINRRdqULaf/VRDwf21EsGP5QGov69GBqkw5sQ3qKmRLs8jy6h4dGSXZ3htb7EOJVilGXU4DXtw3l57Cy5JdG+BT3+NZfF194jvMkOobQvYrAs3CpCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943220; c=relaxed/simple;
	bh=y9M70ecC9tKjDmjkKIT/09aTgjrPbjOLQ4s4kHaxYnk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PDNfNR5L9m2jO/Z2JMw6Rr37gTttBOkHX2lO/m823lBQYnHt/gSlKIpcPro3FoiqIDucuvSmBJV02XkLXRY91x/p0OwsRuX4FC0rWnaO4aDe3ncJbUr25hM/rd7HWbU7RAdVfje8tqt6oWHvD4IxVslF2tU4uHtMSUw/cqhO4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FixRgluK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FixRgluK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a0dc77a15so6521315e9.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943216; x=1755548016; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h81/YCqddAWpxLV12KU3NgIIDzoK12fDtPclKJ1SgCc=;
        b=FixRgluKU/OphbZpnIroOngaw36XgBA06kBHE5GxI8Pb8i5lrD3icTkrPeMCMm5Gc3
         u0EnBJU25+qGVHcO+bP30IJNI9yugI4YztU3jbPrFvhrWfkbv+/5jkPdTzvRjxYefMGE
         J68LxJE3ell8S8b3uc6f+OJ2i0rAaR+yMJG5YK4HM9eS7vJN2Cp3oTphzYUd8/cDKPho
         XBwe27zfLio+3qiS9ui8PaeUueq1Hk/tDev0d4AB2CxeqQDLL218mLwGZvIcSFjw8yOR
         JRRa2ltQ0ymsyvyIPinhzL9telfwE95+q1drL0509seiGCP7s+nutgeWEU/Cas8yQMfi
         m+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943216; x=1755548016;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h81/YCqddAWpxLV12KU3NgIIDzoK12fDtPclKJ1SgCc=;
        b=pROB34uja168n9aWjfNKjuK84YmFcVa9KZSM9PpHeLMTJiD1NsTVASGzVOFa1GT9Vk
         2E8on9zirrGY9pKQwx87xZn5qqrOM7adldWJh+3YJSiAWoC7znTdTJM58em8pg8sVC/4
         jy1psbxdpa+ZyzAJtkcNRQMXIrGH7vTFrOqbBdf9D9nHO94EzNjhwR66OXbqvGzOonDd
         zqORlFm1lcl8c2vMONGzavvfNMsgOKXx8DBtsAASra5GX6QcXvdxP/Ff2Dq+5dq/luZK
         qgXu4pSqu787uocBE9IveaIT4CMTIsA4KbA90HOR666lVtTLpZnP7ehMQlXdAIzlwBMa
         Xm2g==
X-Gm-Message-State: AOJu0YwNgo96SIqJBHFlO3fvbdm1mbToKUuS4EQU+rf+pR/CSVggXMbN
	G96UuFmZzqTEb9vAkyZ1n9pdtK6FF7iWzumrIJ55xAe+/4pdRcdOe/jJN4+1Ng==
X-Gm-Gg: ASbGnctYci3IrwDKt6vpccUXk+2b7AjUZINF3xTbe67apq3do/F/JGNTBjcdC5mpdgb
	xWDY6dC2zQCGVmUsavAsJuXslyPawZLE9NWdTyovuwDn+rvWMhA/DwGZgjM9ceHux97v9XvrcOs
	hNvtyyJtxvxAWCy8XtbJC0OJklQblUHl9xTMkQ5VJTc+ljE9HdGnrCqaEv2FYDTGHE0lAbO1qa7
	ebB1RIHgNaNiUZrNn+bNohk+pGYOYdFKCazfs7qxD48GuKLuKBJimrbzEMP+A4gQxliaCP8a+2k
	Gd0rzosm9GP42SQO8unVuSYYOhJkmsEOIQMm8aEMCv1stIno3bV/nRT+b0Adceqmw03+WaT12m9
	EQ1sR/Uw04yVqQlWuqjn68Lg=
X-Google-Smtp-Source: AGHT+IG35bkn8IxUZGALorS0VFy1BXkAu5T6u3G3DduuyWvM5yKHWV7VMnrGIXSDAnRGKf2aq3nVKA==
X-Received: by 2002:a05:600c:1f95:b0:459:dde3:1a27 with SMTP id 5b1f17b1804b1-45a10c0f767mr8239545e9.26.1754943215945;
        Mon, 11 Aug 2025 13:13:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c475067sm41253659f8f.58.2025.08.11.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:13:31 -0700 (PDT)
Message-Id: <e229b9fccb20d61853dd7bce457937d186401242.1754943127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
References: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
	<pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:12:06 +0000
Subject: [PATCH v5 4/5] doc: git-rebase: move --onto explanation down
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
index 117c3f43719f..750f5e67e4c3 100644
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

