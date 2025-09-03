Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B553148BF
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918213; cv=none; b=MLTQzwqBJywTuC0VStetblg/X8T58XTsUatMqyGCRK1c/9GCzg93zCqzUiNNKbwR1CQvg9knggQhazjD4bfzcrlgqz1ItdWA/LU4fEW/2TSYbK5uGaqY8LFE0L2HvMKc9ZuaK2UUd5cch68TYXEsaAqoXDYuZrAx8HNGNvf2V6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918213; c=relaxed/simple;
	bh=hgz8zYZmLBe11p6g/kAkVncxFk2UeSotlw/dWQW2jKY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aTthaIIXzoKAP1btemn3rDIImzYm8Yc7nOeyhEk/2jJsmS4qewBHmlGaCviHOuTUmUEs/TvWQqa7slp8ZlZD6HCjC4zqgy3oFEogFJ3cZ6qvlQsDlXWTpCNqBn6PhoSknla4JeLnv/jiPg4SqwEgou3m6FGzmOvEPjA5pRmBwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmeP/zGk; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmeP/zGk"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-80597face96so15079685a.0
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756918211; x=1757523011; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgL7KJ1Z/F5sFQZ/TrZld8LbgaC5mTAyDQXtT5YRMCg=;
        b=TmeP/zGkQoQEmq1bFVwV9NmWMSWmuNxBpoAAlj9593rAwi4MR+NJmFZXkyjU0TXPX/
         HZzUMI9K8KXS/W7TA1WIfKvn5qWc8Z5+0GzDGFMO8lx2oFqpaRtKvJCrHxjD29Ny1VAg
         JZBkHxAjl9c/aocVTnQbgs+WqhVK8GAIUNeEG9GNy4HaXj/+vMJCdsCzNYqKRXwNflZa
         3YlOeC4W3XspGri6IwYdXmZrNdsPxiHbh0eKlobgyU3KAM3frJnSaLunNJ2M1/hvUl+t
         b4Dv9/5caDuGbpbyS7c5zH6IKlCrW27aoev5xnYlCClXirHYx3e7bsGwDAGHpoksvYow
         btfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918211; x=1757523011;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgL7KJ1Z/F5sFQZ/TrZld8LbgaC5mTAyDQXtT5YRMCg=;
        b=AzsBmZDGnxUaYTO8Qd28I8o+V8nmNJFTi3ZOAOL/tv2LIkNjqCe3Hb5Kga1YLBLqWe
         2X7Wyuv6W6DUGfxOMNYryVVGOFe+hwRhK1npGzatMvhc6crygxAQsi5fp9kjHsLR0FS6
         bq56GuYpNd6FY9e4JRtJo6ibrtKVC0arNxAQyp9kAM9rUcZIqJjvZfhJSUiHNf+2ZObi
         Lytt7IQc41ee2bzrORKn+m5iG+fOfRMHYITTBmyepZtYikelGTO3975oL3iB3wqVn55o
         uQzRE8m+AHlXtwdmG+tJEjK+HK7WYSJPFRgGxPxVQauawa9NmFGPtbgpcUxMpcLeH47l
         sB4A==
X-Gm-Message-State: AOJu0Yys+cHr3dz+hNkGfQlqbu3pMcL8YAeQIL8EJR8g3zR1yIH9d0lb
	SMbfKYn6advPqN6eaiF8FnHIjkk8L8qmRR8/2b/8dzIv+1pwnvqv0tYWlh2EqA==
X-Gm-Gg: ASbGncvtRHDsK49amoVaONIb/OUAOvnH3agbRsFE+RQGMsiKuoV4ehbJIBwxUghyAiL
	gWOeoJT4qAJem0o29nQFvW377kQrscCZivbhXPkeIRPmphe7a1rXFHt0BZFvwbmnFfuSiLgLy5e
	9ti+NIX51KVUuO/cTYG2bvy9AhEWzikOMx/KL132abLjQDNROsI5vQKde+U9Pm0wOs+mqjNn1Jw
	xa6mKz5N1RkHDL2EkiHWrNYMmnlPp3IPW62IUY+imjKL0LMkrsTRs1SruFGoP5FtYoz9ypUfmT5
	cV3r3nto6bEunwYkGBNqOdiIZvBTrUqdJUgGur03yv7G8QSt9ZzAkkyNTmWPCuIUPKJJoUVAROg
	t0hAIXkW49em1hAQA0Q1P0K3Yyh9K3PScDd4=
X-Google-Smtp-Source: AGHT+IGuBooMzxcAVgWTt+lrEUx6ix6WVtFk5ddsfYwvxH8V8GWggZD9DTbmhV1YeZC/EkgMH21s2A==
X-Received: by 2002:a05:622a:511:b0:4ab:3a31:680d with SMTP id d75a77b69052e-4b31d80cb2dmr234954481cf.16.1756918210352;
        Wed, 03 Sep 2025 09:50:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f785d50sm13761331cf.40.2025.09.03.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:50:09 -0700 (PDT)
Message-Id: <24793f9a451a1b906952256bc2f67c395a02f66b.1756918202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 16:50:01 +0000
Subject: [PATCH v3 5/6] doc: git-checkout: split up restoring files section
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
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Will make it easier to explain the two versions clearly in the following
commit. As a bonus, now the structure of the DESCRIPTION
matches the SYNOPSIS.

Also remove `-f` from `git checkout <tree-ish> <pathspec>` since it's
not relevant in that context.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index d35fd32ce8..b361ff011a 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -12,8 +12,8 @@ git checkout [-q] [-f] [-m] [<branch>]
 git checkout [-q] [-f] [-m] --detach [<branch>]
 git checkout [-q] [-f] [-m] [--detach] <commit>
 git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
-git checkout [-f] <tree-ish> [--] <pathspec>...
-git checkout [-f] <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
+git checkout <tree-ish> [--] <pathspec>...
+git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
 git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
 git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]
 git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
@@ -71,14 +71,17 @@ commit would overwrite your uncommitted changes.
 +
 Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 
-`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...`::
-`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
+`git checkout <tree-ish> [--] <pathspec>...`::
+`git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]`::
 
-	Overwrite the contents of the files that match the pathspec.
-	When the _<tree-ish>_ (most often a commit) is not given,
-	overwrite working tree with the contents in the index.
-	When the _<tree-ish>_ is given, overwrite both the index and
-	the working tree with the contents at the _<tree-ish>_.
+	Overwrite both the index and the working tree with the
+	contents at the _<tree-ish>_ for the files that match the pathspec.
+
+`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...`::
+`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
+
+	Overwrite working tree with the contents in the index for the files
+	that match the pathspec.
 +
 The index may contain unmerged entries because of a previous failed merge.
 By default, if you try to check out such an entry from the index, the
@@ -89,7 +92,7 @@ using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
 `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
-	This is similar to the previous mode, but lets you use the
+	This is similar to the previous two modes, but lets you use the
 	interactive interface to show the "diff" output and choose which
 	hunks to use in the result.  See below for the description of
 	`--patch` option.
-- 
gitgitgadget

