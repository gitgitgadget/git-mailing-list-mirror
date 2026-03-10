Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBEC3806C9
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140370; cv=none; b=SdrXlIYXsXQ/VZBVOY42A6faozpQPpQW/o4idmyaWqb+9g0Nw4dKbmfqrFYZe+cDrP7FaPKUmJ9o6haNFk9iqlwMRFctfFjgRTPGCoQ9dzjrJl6Xk8zGhJ4w56jIqiehTBoG3shozeIYGLeeAs/8XKyHJjZXs1BftL9FmzbEoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140370; c=relaxed/simple;
	bh=1PB6XQkx0z9sEGdO0zluLpO8gh6vdN3mUJnd0vRcWD8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TjUFZymBhHk4QFw2mNJkVU0OyOwGi72kMDyZ5H5fwwKCagNp+hFcS1d6JSSkGJn/8xSVGuRf6G1uYkwLaCGgNxmZOeezdw4CK/13L2XySJ/SEMjOD4jMI3O1WoAqMBoEdbBrTJQciYovHjXuHNTrazpK02bbW8XjYRFHBOVIyfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/d+9eI+; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/d+9eI+"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a133cdd4aso91888256d6.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773140366; x=1773745166; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKruVj9jB8HY9uicIVTrKJnlElPWztNwT3iFNTz5IMs=;
        b=I/d+9eI+LHchKk+n6OPTn7HJ4Xx3+38DylMlzjEeGBjpXB0BZyha42lWPVXqVhQ9Cy
         QOR6uQVrkV2EhkRsy+y13Y+Yg7z3GoL8FE44cjxiSCRgijqdQwzXvXK4O1g4Dz4IlkjE
         O1oJeQtnGmlpNthPx08Zqfvx2+ekz2gamC89S9ikUv/2ofLrgo/Vw3HmcBxUY2WRfAfT
         U8bqOJAjn8JNdrpp1HeJKhKahagp6z4JKaUIwNpmpfxMbOs3vnAy3zv108TUMsVoDCk0
         Vu4QmcZsJM+W0drFaqIAyyHFHzBnGHZi/3NBOm/6q05wAjowYk7+RiseC6MEW5oWonUc
         Y/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140366; x=1773745166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKruVj9jB8HY9uicIVTrKJnlElPWztNwT3iFNTz5IMs=;
        b=HgvF60w2c/0J/bnzrfgqSxQSiSS0FMHYu9RycFlAPphf3j/xxP4sw7SpZv9UYPBRQG
         Jiu+TIglJfclJPR6cveZCIgJrOJ6GIa+O3rA6CLEzYjO79FACJdawRc8l2MYz0g9l7se
         0PXZuVGlAbfvNYm1CN54noiuCWnyQ0ijuFEHMso1e4Jm19UufMlUsBfc1MY7m31TvGvU
         MMH1bLs69GapMcmWNVCFkj0VZFL0ZcSLtYQGt5A0yVlRxDh4DZCe9yhDL+//9+Zq2UiE
         xRWLC7lMcGVyrbU1p1PXqxQFSQdZQbHw8Z2p9SY3AWaGn6pXTz8ErAbXp0FYsD590Woh
         cPgA==
X-Gm-Message-State: AOJu0Yx7h/4EgkvX7xciPxdz66OQCh//WnjPgnSVLaMk4it8u22Jb2ZQ
	jbX6BC03qZYs/GWJ2gThI2K+Qyt0E7t2lfZvUXufdIp7AUqOkW5wlsuQ/mudWw==
X-Gm-Gg: ATEYQzz1H+oYXaGg2DNW5Z3Rsx/awHlaShfYteW85L2/GhMJLQyLcHVaJt9Lf0f1mqV
	udBGnjb+Lti9IXRyXTzByxLqt/Nvm+JCTcJcxYkR6l4szK1pTe5K/3n4c3Rsqj06J6RAa0dlL2S
	Wy4rdaheYLXWQNV1xsjMKjXMKOtUE8GYrkK+G8JjeUJ3Nmhf1CtDAqptm+v92IVlD5mxfL4dTRZ
	MSyu8VnUidGyV03hL6kvoKVCZQKJ4nJ3+GEHk8+KXm5hcyzq7Oow7yKfBABnpAB23YdhTvn/sV0
	v4Isnt6zClcbmIugJlXZO3+q4gM23LgJEz3IjsZ0J4q9hKiVFIlrAFwhJnGaNolpBR5B2MpIges
	dcd/Imv+boDNOCJSQYDPCj4yByt0wGKKGfprtBsAbUFFGyDt+NdnATFmuE98PHbNqI+1A36M5eu
	hnFDbJlb0joe9eLw7GnT4U0sIkeI0=
X-Received: by 2002:ad4:5c68:0:b0:899:f51e:1ac4 with SMTP id 6a1803df08f44-89a30c19a70mr199548636d6.57.1773140365805;
        Tue, 10 Mar 2026 03:59:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.135.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c4a0c6sm19800516d6.52.2026.03.10.03.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:59:25 -0700 (PDT)
Message-Id: <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 10:59:24 +0000
Subject: [PATCH v2] advice: add stashBeforeCheckout advice for dirty branch
 switches
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
when they attempt to switch branches with local modifications that
would be overwritten by the operation.

This includes:
> New ADVICE_STASH_BEFORE_CHECKOUT enum value in advice.h
> Corresponding "stashBeforeCheckout" entry in advice_setting[]
> New advise_on_checkout_dirty_files() function that lists the
  affected files and suggests using git stash push/pop
> Documentation entry in Documentation/config/advice.txt

The advice follows existing patterns established by
advise_on_updating_sparse_paths() and can be silenced with:

  git config set advice.stashBeforeCheckout false

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
    Advice on checkout dirty files
    
    This is my submission for microproject [GSOC]
    
    This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to help
    users when they attempt to switch branches with local modifications that
    would be overwritten by the operation.
    
    The new advice follows the same patterns established by existing advice
    functions such as advise_on_updating_sparse_paths(). When triggered, it
    lists the affected files and suggests using git stash push/pop to save
    and restore local changes.
    
    The advice can be silenced with:
    
    git config set advice.stashBeforeCheckout false
    
    Changes:
    
    > advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
    > "stashBeforeCheckout" to advice_setting[] and implement
    > advise_on_checkout_dirty_files() function
    > Documentation/config/advice.adoc: document the new advice key
    
    Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v2
Pull-Request: https://github.com/git/git/pull/2233

Range-diff vs v1:

 1:  0ed992956e < -:  ---------- diff: handle ANSI escape codes in prefix when calculating diffstat width
 2:  c70043a2c0 < -:  ---------- t4052: test for diffstat width when prefix contains ANSI escape codes
 3:  185356a454 < -:  ---------- repo: remove unnecessary variable shadow
 4:  acebdd714b < -:  ---------- The 13th batch
 5:  9ec447e3cb = 1:  eb5639dbc3 advice: add stashBeforeCheckout advice for dirty branch switches


 Documentation/config/advice.adoc |  5 +++++
 advice.c                         | 27 +++++++++++++++++++++++++++
 advice.h                         |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 257db58918..8752e05636 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -126,6 +126,11 @@ all advice messages.
 		Shown when a sparse index is expanded to a full index, which is likely
 		due to an unexpected set of files existing outside of the
 		sparse-checkout.
+	stashBeforeCheckout::
+		Shown when the user attempts to switch branches but has
+		local modifications that would be overwritten by the
+		operation, to suggest using linkgit:git-stash[1] to
+		save changes before switching.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/advice.c b/advice.c
index 0018501b7b..e1264f525c 100644
--- a/advice.c
+++ b/advice.c
@@ -81,6 +81,7 @@ static struct {
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
 	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
+	[ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
 	[ADVICE_STATUS_HINTS]				= { "statusHints" },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
@@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
 			    "* Use \"git add --sparse <paths>\" to update the index\n"
 			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
 }
+
+void advise_on_checkout_dirty_files(struct string_list *file_list)
+{
+    struct string_list_item *item;
+
+    if (!file_list->nr)
+	return;
+
+    fprintf(stderr, _("The following files have local modifications that would\n"
+		      "be overwritten by switching branches:\n"));
+    for_each_string_list_item(item, file_list)
+	fprintf(stderr, "\t%s\n", item->string);
+
+    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
+		      _("You can save your local changes before switching by running:\n"
+			"\n"
+			"\tgit stash push\n"
+			"\n"
+			"Then restore them after switching with:\n"
+			"\n"
+			"\tgit stash pop\n"
+			"\n"
+			"Or to discard your local changes, use:\n"
+			"\n"
+			"\tgit checkout -- <file>"));
+}
diff --git a/advice.h b/advice.h
index 8def280688..c035b5d8e3 100644
--- a/advice.h
+++ b/advice.h
@@ -48,6 +48,7 @@ enum advice_type {
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_SPARSE_INDEX_EXPANDED,
+	ADVICE_STASH_BEFORE_CHECKOUT,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
@@ -83,5 +84,6 @@ void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
 void advise_on_moving_dirty_path(struct string_list *pathspec_list);
+void advise_on_checkout_dirty_files(struct string_list *file_list);
 
 #endif /* ADVICE_H */

base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
-- 
gitgitgadget
