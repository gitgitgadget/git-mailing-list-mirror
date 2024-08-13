Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521661A38D5
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578953; cv=none; b=JrPMv6R0/9wB3NIHmoWcpvpNi6kq5w575e5A0VtLD3ojnDAiFTCKAbjAg8iLuFV+uKED7mkKqhnaDAUOVN3KWgWvClu5YLp8PbVpxdNciDNDGb47i19TIFPa4o0UxWnRdBgmszpFaLkWE+SqsJztzexVsXMT4/DCdbNkpvZaUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578953; c=relaxed/simple;
	bh=cueEdBWDQdghrsU/wic13BJO6Z79C5ppXORMX3wLx34=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cniQDVxOCDcyK6/gYTB2I6e7KmwVEk5BIIExeDu7G28EVbFnDPowTDLqWffRRCD/Qk6FQB7rHfTxLeaWNZrJvrG3uYmm5GRcftmMTTnAUr4WfRiSznYDauhCycjzt149UNV7lhwEgLUpCfl1x57lhdACOwO0J1gimMW/nmfL/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4iVUI3E; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4iVUI3E"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42816ca797fso43422615e9.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723578949; x=1724183749; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzeJ5UVl22C6e9JWDL/DtRy2hS/BOW9LkcdHgQJ+c0A=;
        b=g4iVUI3ErCx/MfXbHMvizD+H8TnIErycmbyfFALkihGvww1K4aGVBXr78LaTwEksRZ
         dDloePE225xZAXYck/hJIhg4Yt1moQsg5Wf7M5i44lHSPqYrzoWIr2fnqBaiq2VneFn0
         YKYdFBp+tl6kZM0uW4UhXqQxYSgxwKnzV5CmFizCYKZMYpsDWcFE/+6LOs0ppzekJbRY
         cE0tZEnekM/XmeesXqvko4814PQDV6ZUJURzINw5eicHN8MUx8JxqM5Q0A4IeN5AmrUd
         UtBxFipZO/islae1OXEz3Eol7iBATAblAfwbVmjjBO6u3LUnpP6JmHmdmEGb3551v12l
         elzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723578949; x=1724183749;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzeJ5UVl22C6e9JWDL/DtRy2hS/BOW9LkcdHgQJ+c0A=;
        b=OwiTTQ3YcFDvfrmLcBgFsZc6LIOiBuUDfICSflp5jfiv98cfHgsvL14cN+asaLHGlW
         hLAzFEdW0hnbulMT/nOVNZx+idrSnJ98GLk7s0LEb4LryQITUh+79GSbuCo0RURPvR3i
         uDqNp+KNv/y5hQeRIPxxbnGFhmTZsFCBF5B0OiJShhL4+T0giBJhVsSnOpUNyEiWfmMg
         nRQnSYx/tvBd3BMJ9D0yUZv/2Ozx/4FrcmpHgiIuNRcGZJ9ZZfEMDvuo3ubZKIM3DCIs
         TSQih+L/bqCJ1Fn/2aT3LakCDzZCgyeeZRNcrvvxbl1MP+MucrcKIVw/CX+z8px81O8B
         AGLQ==
X-Gm-Message-State: AOJu0YzHZmuRtYLiOnfsmGcmK96i+llw9sAVVgbx37KrRdkmV6dmjc4Z
	snah1aSj/ipTZS5efaEVURXZE29YzJ1RcEpQ9UHygiqKLM9dX5+fjd2B3w==
X-Google-Smtp-Source: AGHT+IHF3GJ3bP6EA14p9BR6IQe1wsQ2Ilg5x8Z2c4P8H298/tVC62GikrsGihWNZTuo8ZL8pDQrsQ==
X-Received: by 2002:a05:600c:3b20:b0:426:62c5:473e with SMTP id 5b1f17b1804b1-429dd264729mr3907375e9.26.1723578948686;
        Tue, 13 Aug 2024 12:55:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeedc8sm11276839f8f.55.2024.08.13.12.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:55:47 -0700 (PDT)
Message-Id: <pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.git.git.1723500383989.gitgitgadget@gmail.com>
References: <pull.1766.git.git.1723500383989.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Aug 2024 19:55:46 +0000
Subject: [PATCH v2] git-svn: mention `svn:global-ignores` in help+docs
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
Cc: Alex Galvin <agalvin@comqi.com>,
    Alex Galvin <alex.v.galvin@gmail.com>

From: Alex Galvin <alex.v.galvin@gmail.com>

Git-SVN was previously taught to use the svn:global-ignores attribute
as well as svn:ignore when creating or showing .gitignore files from a
Subversion repository. However, the documentation and help message
still only mentioned svn:ignore. This commit updates Git-SVN's
documentation and help command to mention support for the new attribute.

Signed-off-by: Alex Galvin <agalvin@comqi.com>
---
    git-svn: mention svn:global-ignores in help+docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1766%2Fav-gal%2Fgit-svn-doc-globalignores-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1766/av-gal/git-svn-doc-globalignores-v2
Pull-Request: https://github.com/git/git/pull/1766

Range-diff vs v1:

 1:  9850e80684f ! 1:  d0b5df150e9 git-svn: mention `svn:globalignores` in help+docs
     @@ Metadata
      Author: Alex Galvin <alex.v.galvin@gmail.com>
      
       ## Commit message ##
     -    git-svn: mention `svn:globalignores` in help+docs
     +    git-svn: mention `svn:global-ignores` in help+docs
      
     -    Git-SVN was previously taught to use the svn:globalignores attribute
     -    as well as svn:ignore when creating or showing .gitignore files from
     -    a Subversion repository. However, the documentation and help message
     +    Git-SVN was previously taught to use the svn:global-ignores attribute
     +    as well as svn:ignore when creating or showing .gitignore files from a
     +    Subversion repository. However, the documentation and help message
          still only mentioned svn:ignore. This commit updates Git-SVN's
     -    documentation and help command to mention the newly supported attribute.
     +    documentation and help command to mention support for the new attribute.
      
     -    Signed-off-by: Alex Galvin <alex.v.galvin@gmail.com>
     +    Signed-off-by: Alex Galvin <agalvin@comqi.com>
      
       ## Documentation/git-svn.txt ##
      @@ Documentation/git-svn.txt: Any other arguments are passed directly to 'git log'
     @@ Documentation/git-svn.txt: Any other arguments are passed directly to 'git log'
      -	creates matching .gitignore files. The resulting files are staged to
      -	be committed, but are not committed. Use -r/--revision to refer to a
      -	specific revision.
     -+	Recursively finds the svn:ignore and svn:globalignores properties on
     -+	directories and creates matching .gitignore files. The resulting
     ++	Recursively finds the svn:ignore and svn:global-ignores properties
     ++	on directories and creates matching .gitignore files. The resulting
      +	files are staged to be committed, but are not committed. Use
      +	-r/--revision to refer to a specific revision.
       
       'show-ignore'::
      -	Recursively finds and lists the svn:ignore property on
      -	directories.  The output is suitable for appending to
     -+	Recursively finds and lists the svn:ignore and svn:globalignores
     ++	Recursively finds and lists the svn:ignore and svn:global-ignores
      +	properties on directories. The output is suitable for appending to
       	the $GIT_DIR/info/exclude file.
       
     @@ Documentation/git-svn.txt: Tracking and contributing to the trunk of a Subversio
       # as well as automatically updating your working HEAD:
       	git svn dcommit
      -# Append svn:ignore settings to the default Git exclude file:
     -+# Append svn:ignore and svn:globalignores settings to the default Git exclude file:
     ++# Append svn:ignore and svn:global-ignores settings to the default Git exclude file:
       	git svn show-ignore >> .git/info/exclude
       ------------------------------------------------------------------------
       
     @@ git-svn.perl: my %cmd = (
       			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
       	'create-ignore' => [ \&cmd_create_ignore,
      -			     'Create a .gitignore per svn:ignore',
     -+			     'Create a .gitignore per directory with svn:ignore and svn:globalignores',
     ++			     "Create a .gitignore per directory with an SVN ignore property",
       			     { 'revision|r=i' => \$_revision
       			     } ],
       	'mkdirs' => [ \&cmd_mkdirs ,
     +-	              "recreate empty directories after a checkout",
     ++	              "Recreate empty directories after a checkout",
     + 	              { 'revision|r=i' => \$_revision } ],
     +         'propget' => [ \&cmd_propget,
     + 		       'Print the value of a property on a file or directory',
      @@ git-svn.perl: my %cmd = (
               'proplist' => [ \&cmd_proplist,
       		       'List all properties of a file or directory',
       		       { 'revision|r=i' => \$_revision } ],
      -	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
     -+	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore and svn:globalignores listings",
     ++	'show-ignore' => [ \&cmd_show_ignore, "Show .gitignore patterns from SVN ignore properties",
       			{ 'revision|r=i' => \$_revision
       			} ],
       	'show-externals' => [ \&cmd_show_externals, "Show svn:externals listings",


 Documentation/git-svn.txt | 14 +++++++-------
 git-svn.perl              |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 43c68c2ec44..bcf7d84a87d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -431,14 +431,14 @@ Any other arguments are passed directly to 'git log'
 	independently of 'git svn' functions.
 
 'create-ignore'::
-	Recursively finds the svn:ignore property on directories and
-	creates matching .gitignore files. The resulting files are staged to
-	be committed, but are not committed. Use -r/--revision to refer to a
-	specific revision.
+	Recursively finds the svn:ignore and svn:global-ignores properties
+	on directories and creates matching .gitignore files. The resulting
+	files are staged to be committed, but are not committed. Use
+	-r/--revision to refer to a specific revision.
 
 'show-ignore'::
-	Recursively finds and lists the svn:ignore property on
-	directories.  The output is suitable for appending to
+	Recursively finds and lists the svn:ignore and svn:global-ignores
+	properties on directories. The output is suitable for appending to
 	the $GIT_DIR/info/exclude file.
 
 'mkdirs'::
@@ -871,7 +871,7 @@ Tracking and contributing to the trunk of a Subversion-managed project
 # Now commit your changes (that were committed previously using Git) to SVN,
 # as well as automatically updating your working HEAD:
 	git svn dcommit
-# Append svn:ignore settings to the default Git exclude file:
+# Append svn:ignore and svn:global-ignores settings to the default Git exclude file:
 	git svn show-ignore >> .git/info/exclude
 ------------------------------------------------------------------------
 
diff --git a/git-svn.perl b/git-svn.perl
index a2a46608c9b..d8dc485e50d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -219,11 +219,11 @@ my %cmd = (
 	                "Set an SVN repository to a git tree-ish",
 			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
 	'create-ignore' => [ \&cmd_create_ignore,
-			     'Create a .gitignore per svn:ignore',
+			     "Create a .gitignore per directory with an SVN ignore property",
 			     { 'revision|r=i' => \$_revision
 			     } ],
 	'mkdirs' => [ \&cmd_mkdirs ,
-	              "recreate empty directories after a checkout",
+	              "Recreate empty directories after a checkout",
 	              { 'revision|r=i' => \$_revision } ],
         'propget' => [ \&cmd_propget,
 		       'Print the value of a property on a file or directory',
@@ -234,7 +234,7 @@ my %cmd = (
         'proplist' => [ \&cmd_proplist,
 		       'List all properties of a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
-	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
+	'show-ignore' => [ \&cmd_show_ignore, "Show .gitignore patterns from SVN ignore properties",
 			{ 'revision|r=i' => \$_revision
 			} ],
 	'show-externals' => [ \&cmd_show_externals, "Show svn:externals listings",

base-commit: cabe67c0d1819fd1e33079e92615c6c7a3dc560d
-- 
gitgitgadget
