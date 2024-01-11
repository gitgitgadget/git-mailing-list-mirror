Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346481641B
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL3eMguq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e613b6afbso4200765e9.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 04:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704976839; x=1705581639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijFvg/zkRgHKR3g72KKNllyHHQBh2nUNmsMB9KF5uxk=;
        b=VL3eMguqnvEWbw4ZwO7QhQWEOTBZVhjvXSMU/cc/vw4fnZyWMVQiLFzsFLWl+8R6cS
         HpWEpUTLa0FglWVw8wLfQ08XOxNouvBRpMJ6qhUwrAKO1IBRLclZeZLfh5/y1HEGqKXl
         3+XGRdrPiXAlS8aKr6fMOn8HIYXuJB0fwiQlZUh8/q5ANvf7onMp6y4Hdf6M2LphczLr
         SwRHh/51lUJz2GZDCpdW5xH620QbS6ki7tySNrx4LhJBA1pkl4n/78tkbIYAu0hWVYzC
         4tPkJ/aTIhgfCbme4NgEMA4365VToD83alr48mmdXUnmVLjvdG5lX1DQvqGzdmuhbAJS
         1UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976839; x=1705581639;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijFvg/zkRgHKR3g72KKNllyHHQBh2nUNmsMB9KF5uxk=;
        b=TlP4pHMAQV1L20YvknCHvmOxbRogx7IWiN+sUtX3LOejIRN17eW7y1ONEnAFRLoYTc
         4EZVHEsJSV0WC/jwnw/o98bif1973ea56JnfubBCK4B8vPAYesJMf42AH+xB20uWC6ua
         F2y0VxK7qCna/2Hde9Cc2iosDp6G5eqZKt9CS/EpiWFRVstImppHF/babCEDZ670oAKk
         JEbA6vdinya8RmhsnT3N4wAaKAqL6ZQdnPhdE0u7t3qz9q/qGyf1mKda63S60EUpv0Nu
         5A5glt0Kk8aHD4Njv+AoQKS6tT6r13640CDH9Q7+Od8Mji+E97/bIAOpHDKIgB0PDNzT
         JRhg==
X-Gm-Message-State: AOJu0Yz4c3r4lKHIPK2yeq/3r/FUNL3AAcUb4e/yCaCftVrVICTGe0i4
	jBO8ccgqGDP5G55jZRm9ypAyQTZTvhc=
X-Google-Smtp-Source: AGHT+IEQB9fr155i/Rxw1MN0ol9NUSsyz1rOCEz9rWm4zICG+A7Mah0ozwg2BRa4FWO7XoHSwLrZTw==
X-Received: by 2002:a05:600c:3b8e:b0:40e:49c6:45e0 with SMTP id n14-20020a05600c3b8e00b0040e49c645e0mr420665wms.23.1704976839250;
        Thu, 11 Jan 2024 04:40:39 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id fm23-20020a05600c0c1700b0040e612aa673sm1575390wmb.17.2024.01.11.04.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 04:40:38 -0800 (PST)
Message-ID: <6c86e8b8-92eb-44d8-875c-27c92aa02266@gmail.com>
Date: Thu, 11 Jan 2024 13:40:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/3] branch: make the advice to force-deleting a
 conditional one
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
 <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
In-Reply-To: <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The error message we show when the user tries to delete a not fully
merged branch describes the error and gives a hint to the user:

	error: the branch 'foo' is not fully merged.
	If you are sure you want to delete it, run 'git branch -D foo'.

Let's move the hint part so that it is displayed using the advice
machinery:

	error: the branch 'foo' is not fully merged
	hint: If you are sure you want to delete it, run 'git branch -D foo'
	hint: Disable this message with "git config advice.forceDeleteBranch false"

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 Documentation/config/advice.txt | 3 +++
 advice.c                        | 1 +
 advice.h                        | 1 +
 builtin/branch.c                | 8 +++++---
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index e0deaf3144..25c0917524 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -45,6 +45,9 @@ advice.*::
 		Advice shown when linkgit:git-fetch[1] takes a long time
 		to calculate forced updates after ref updates, or to warn
 		that the check is disabled.
+	forceDeleteBranch::
+		Advice shown when a user tries to delete a not fully merged
+		branch without the force option set.
 	ignoredHook::
 		Advice shown if a hook is ignored because the hook is not
 		set as executable.
diff --git a/advice.c b/advice.c
index 03322caba0..f6e4c2f302 100644
--- a/advice.c
+++ b/advice.c
@@ -47,6 +47,7 @@ static struct {
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
 	[ADVICE_DIVERGING]				= { "diverging", 1 },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
+	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch", 1 },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity", 1 },
diff --git a/advice.h b/advice.h
index 74d44d1156..9d4f49ae38 100644
--- a/advice.h
+++ b/advice.h
@@ -21,6 +21,7 @@ enum advice_type {
 	ADVICE_DETACHED_HEAD,
 	ADVICE_DIVERGING,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
+	ADVICE_FORCE_DELETE_BRANCH,
 	ADVICE_GRAFT_FILE_DEPRECATED,
 	ADVICE_IGNORED_HOOK,
 	ADVICE_IMPLICIT_IDENTITY,
diff --git a/builtin/branch.c b/builtin/branch.c
index 0a32d1b6c8..cfb63cce5f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -24,6 +24,7 @@
 #include "ref-filter.h"
 #include "worktree.h"
 #include "help.h"
+#include "advice.h"
 #include "commit-reach.h"
 
 static const char * const builtin_branch_usage[] = {
@@ -190,9 +191,10 @@ static int check_branch_commit(const char *branchname, const char *refname,
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged.\n"
-		      "If you are sure you want to delete it, "
-		      "run 'git branch -D %s'"), branchname, branchname);
+		error(_("the branch '%s' is not fully merged"), branchname);
+		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+				  _("If you are sure you want to delete it, "
+				  "run 'git branch -D %s'"), branchname);
 		return -1;
 	}
 	return 0;
-- 
2.42.0
