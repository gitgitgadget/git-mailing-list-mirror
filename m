Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F661258A
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767350; cv=none; b=hAuUdH7ZfydkO/EtxrWYHzbdbfwnFbHHQNMfPGgDJSQvz81A1TJThVNLHuOfOCl6XW/lxl8gpTh9dLTw0CbDl8Lg1qMDlVj0H9rbR5OTy86NTm4b+55NWDAAfXtxudcdFpLKn5koi3M6qxRbgQm2A1HVYoXtcLT5ENP1aWqqQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767350; c=relaxed/simple;
	bh=sQnaC/exLSk/QQN0U7EADf6+XVjCWIjNKIWGN5afXv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zi4908hmyrj1T35ReRUcK3Jhb7Jd20cq0RVjBKH003F06ekotMP+i+PHM94OLJcIjTsol8oa8NdXrqJOnHB0vj8fjlyJNHfeypFKxXbGkE3nSLL224B6K8tl4UYXqehYp6ULAAKjyCBXdAFUO3J6sUJSycFM/z1kQePxvFUTwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJauGNMJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJauGNMJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2255003f4c6so69468135ad.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 01:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741767348; x=1742372148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPW65+fi8qGd/cHAqG6Y5vOY94E6d5+OPAyI4SF47w4=;
        b=eJauGNMJjmPsTdCdLRmzsep0Kr8w1zd3IdgU6NuvKmsc4JmnuUqoQkvbhMGDaYH3c3
         TW+kJul4MUd2Oh/qIW/a0rOkzcrQjMlXfdGA5tb3vdbzFVnslONG24SZSXhl9wlc9/xl
         rGnUzFRuJdHQlJTfJipTha3tJVeLSszwkrKckmQNuounQWhmZK6tEJ2cj6zduAKI4AyC
         y1xCH/GfwdJ3S/DaqHCwl78ngNDHZmQ5o1nE0Xx29hf0Pz2d/CVUwlwMrN3xjDURqCE8
         4YCsNO9lPaJirR909dcNs97krmhm+2uxf8Q5gEAL5ap2ciSYkFV8SiPXbUD/55IX20gk
         /riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741767348; x=1742372148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPW65+fi8qGd/cHAqG6Y5vOY94E6d5+OPAyI4SF47w4=;
        b=Wd12ZCbG2gGl+LGwyJniAJLoCRCew9m0sEzZ2bQ9U2P1yDWP3rNZz6b8+DypslRJ17
         eRv+Jydzg8FRzz9A6gU2b+MshvpMA8kDAt9jVylg9uwYjNyPLOsSGOdw4MzRQnR8p8sl
         wTkTcl3EVZqcWHbVqkiEsOLhlXpn9Vk6fnNfR68fmkoxsrrw6qL9xPmUaVl2mWmxfAbB
         VKRTXhYE0gsO8Ku7/gU124kssseWZri/rC3stGm9pezkNBf54ZbB9n6FD/Pn4Cr9TYo0
         YAmQnkAydf/thkHdMF2WKr452KJ6d9gYYhicRfg2iaFnwkBvSG0bqhexXpQ9xEiPvgT4
         WTYA==
X-Gm-Message-State: AOJu0YytnFjp4LxxmmR5W6mN16ToSEEmvovUEzZUdPXqdQpytuuAq/oD
	Bbnw3oq5q3aoa39O/6TnFAMe2s3ZrFf4SGKrJY+OfHDSBmkDhfqLvdPHXw8e
X-Gm-Gg: ASbGncuWbgp6kn7sY/cXGSZSWsiQ3oGU9iY9ffoqb9QtsvYetJGDgdLW4VgvTcUGWaF
	uTF2jWr3dqGoa8dO1qO+gGPUrc1h4AqkWn8b/ybBgYGRm8TcKHRGZQJvms1Xv/xISCVljThT3D4
	0VtYnZJbzItaJ2he6jFQwJ+JbIzPIfNm4YHhqTtx6x5R5YaVocxkY9N9s/D3ZESXQE1gOu3aUSR
	1f18pkd1To7M6EBA3NbLOFKFGKJgQBhG9XbJMkpltxx0fCFHvyiOGDmuzf7p+IfPNZwKlN+zuUf
	o37qBEiwTfMYA7YvJfsYEDrsOfXE6Glu4nbsyxhb5XR4sV7dymsREF2xWMKqCIUgkp8Br/EO6DR
	7xQ4=
X-Google-Smtp-Source: AGHT+IFsMzO3TJ8VNW7EW1Jbo+QPC4peJl01Na/aMpnF8JAlGzHhH1YUYJ8Ph9bvTvmbDaDzwTK2kQ==
X-Received: by 2002:a05:6a21:e90:b0:1f5:7c6f:6c8a with SMTP id adf61e73a8af0-1f58cbef8afmr11576433637.35.1741767347907;
        Wed, 12 Mar 2025 01:15:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2894e3cdasm9980204a12.24.2025.03.12.01.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:15:47 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH] [GSOC] Update MyFirstContribution.adoc to current codebase
Date: Wed, 12 Mar 2025 13:45:34 +0530
Message-ID: <20250312081534.75536-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates MyFirstContribution.adoc to correct outdated information,
improve clarity for new contributors following the guide.

Key changes:
- Updated the function signature of `cmd_psuh` to match the current Git
  codebase, adding `struct repository *repo` as required.
- Added a note on using the `UNUSED` macro to suppress compiler
  warnings for unused function parameters.
- Replaced `git_config(...)` with `repo_config(...)` in documentation,
  aligning with modern Git practices.
- Removed mention of the deprecated
  `git-mentoring@googlegroups.com`.
- Renamed `Documentation/git-psuh.txt` to
  `Documentation/git-psuh.adoc` to follow the
  correct documentation format.
- Updated `.txt` references to `.adoc`
  wherever applicable for consistency.

These changes make it easier for
new contributors to follow the tutorial without
running into compilation errors or outdated references.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 83 +++++++++++++++++---------
 1 file changed, 55 insertions(+), 28 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index afcf4b46c1..4236c9ae3e 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -13,6 +13,7 @@ the Git tree, sending it for review, and making changes based on comments.
 
 This tutorial assumes you're already fairly familiar with using Git to manage
 source code.  The Git workflow steps will largely remain unexplained.
+This tutorial also assumes you know/understand C programming language in a good capacity.
 
 [[related-reading]]
 === Related Reading
@@ -40,13 +41,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
 The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
-==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
-
-This mailing list is targeted to new contributors and was created as a place to
-post questions and receive answers outside of the public eye of the main list.
-Veteran contributors who are especially interested in helping mentor newcomers
-are present on the list. In order to avoid search indexers, group membership is
-required to view messages; anyone can join and no approval is required.
 
 ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
@@ -149,8 +143,14 @@ subcommand and contained within `builtin/`. So it makes sense to implement your
 command in `builtin/psuh.c`. Create that file, and within it, write the entry
 point for your command in a function matching the style and signature:
 
+The following line represents the function signature for any builtin/<filename.c> file that we add:
+----
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+Before proceeding further, we should use the UNUSED macro to suppress warnings about unused parameters in the function.
+This prevents the compiler from generating warnings when certain parameters are not used within the function body:
+----
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
 ----
 
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
@@ -158,7 +158,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix);
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -174,7 +174,7 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
@@ -205,6 +205,9 @@ with the command name, a function pointer to the command implementation, and a
 setup option flag. For now, let's keep mimicking `push`. Find the line where
 `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
 line in alphabetical order (immediately before `cmd_pull`).
+----
+{ "psuh", cmd_psuh, RUN_SETUP}
+----
 
 The options are documented in `builtin.h` under "Adding a new built-in." Since
 we hope to print some data about the user's current workspace context later,
@@ -291,6 +294,8 @@ Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
 existing `printf()` calls in place:
 
 ----
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
+{
 	int i;
 
 	...
@@ -304,6 +309,7 @@ existing `printf()` calls in place:
 
 	printf(_("Your current working directory:\n<top-level>%s%s\n"),
 	       prefix ? "/" : "", prefix ? prefix : "");
+	...
 
 ----
 
@@ -312,26 +318,47 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"`. Then, add the following bits to the
+Add `#include "config.h"` and `#include "repository.h"`. Then, add the following bits to the
 function body:
 
 ----
-	const char *cfg_name;
+#include "builtin.h"
+#include "gettext.h"
+#include "config.h"
+#include "repository.h"  // Required for repo_config_get_string_tmp()
 
-...
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
+{
+    const char *cfg_name;
+
+    printf(Q_("Your args (there is %d):\n",
+              "Your args (there are %d):\n",
+              argc),
+           argc);
+
+    for (int i = 0; i < argc; i++) {
+        printf("%d: %s\n", i, argv[i]);
+    }
+
+    printf(_("Your current working directory:\n<top-level>%s%s\n"),
+           prefix ? "/" : "", prefix ? prefix : "");
 
-	git_config(git_default_config, NULL);
-	if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
-		printf(_("No name is found in config\n"));
-	else
-		printf(_("Your name: %s\n"), cfg_name);
+    repo_config(repo, git_default_config, NULL);
+
+    if (repo_config_get_string_tmp(repo, "user.name", &cfg_name))
+        printf(_("No name is found in config\n"));
+    else
+        printf(_("Your name: %s\n"), cfg_name);
+
+    return 0;
+}
 ----
 
-`git_config()` will grab the configuration from config files known to Git and
-apply standard precedence rules. `git_config_get_string_tmp()` will look up
+`repo_config()` will grab the configuration from config files known to Git and
+apply standard precedence rules. `repo_config_get_string_tmp()` will look up
 a specific key ("user.name") and give you the value. There are a number of
 single-key lookup functions like this one; you can see them all (and more info
-about how to use `git_config()`) in `Documentation/technical/api-config.adoc`.
+about how to use `repo_config()` ) in `Documentation/git-config.adoc`.
 
 You should see that the name printed matches the one you see when you run:
 
@@ -379,8 +406,8 @@ prepare it, and print its contents:
 
 ...
 
-	wt_status_prepare(the_repository, &status);
-	git_config(git_default_config, &status);
+	wt_status_prepare(repo, &status);
+	repo_config(repo, git_default_config, &status);
 
 ...
 
@@ -1089,11 +1116,11 @@ The one generated for `psuh` from the sample implementation looks like this:
 
 ----
  Documentation/git-psuh.adoc | 40 +++++++++++++++++++++
- Makefile                    |  1 +
- builtin.h                   |  1 +
- builtin/psuh.c              | 73 ++++++++++++++++++++++++++++++++++++++
- git.c                       |  1 +
- t/t9999-psuh-tutorial.sh    | 12 +++++++
+ Makefile                   |  1 +
+ builtin.h                  |  1 +
+ builtin/psuh.c             | 73 ++++++++++++++++++++++++++++++++++++++
+ git.c                      |  1 +
+ t/t9999-psuh-tutorial.sh   | 12 +++++++
  6 files changed, 128 insertions(+)
  create mode 100644 Documentation/git-psuh.adoc
  create mode 100644 builtin/psuh.c
-- 
2.48.1

