Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D543C059
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132690; cv=none; b=RbTCPHrcQ7QlXjoeZu/7s9sb2mB+dGdPLRVhiEzf8VWcPq9KW9Y0gbJaMbkCe4V4BReICnMpRQReXkISE7k3dobZV+v/7UW8jLRFaS8uds/znVVlW43sMvklk0UiU0WiBU9pT8A1e+Z1Yo8mwUHpNpEgciucZGiajRBg9XOv53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132690; c=relaxed/simple;
	bh=N4bl45+ugHBhJTK8b1LEjbjDMqTcTFmnyc9du+YCtG4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LHicVYT8l+kNaB6XrVNJSuEYnL8hOV/x1kmdv3dFA+HBisPjkSkS15a5VJk2ZZCSoV1WGp3/is9vkVJA39rC0a6wgVdbHdlsCVyYTyLgBrLh74ViVDH8SqVsbZ5BKyYyeSNApAoCHBLv3h801OGwSvlw5qNTXrXli+FSyvggjcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=as480nqI; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as480nqI"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso12507891eec.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773132688; x=1773737488; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDHqb+0tAKIx6CbJXkCNT0BIOeQZL5zcuAbIjSUDvxw=;
        b=as480nqI3UituncWUDJ4laASEuXGX9Oi/6GX6B46y8qKSzGMDXCpJSV8GADgjCOb01
         hFQ3DUi01u67kDY7l2KvzwF2pEya3kRfsdydSxM4AoKBKQ/D5ywG13m+JTWtS5gLyJGa
         5hYwbDB7I4VYEvLSLB/Nl5bnUErbIVpDYLB8vXe6ss7WfCZDGveSY1g/vUs6/LhTY4gq
         P+zpQZoIGlSFwdPL6/JcqVSkCzmrX+3/1bdSvDfY8VURUDGwUohwecIfLfH9Oxgg0v+C
         VUoKXwAt85fEH6CfiVMvfs0Pbk99LESZqnUxygUOBlAHecMPA43o9gEY7hsBcMyYkM+7
         +QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132688; x=1773737488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDHqb+0tAKIx6CbJXkCNT0BIOeQZL5zcuAbIjSUDvxw=;
        b=Fwp6k21Gbpu5q4Kj3ovmtp48pUVZgzZM8g7hPBvgRpQTuJn916w9DzQ7YwpDY5FOIT
         S2z9ExujIjVbM9wSsWy4qVR/hYw4TvQtKosawF+CIDIrgPfI2hdxMZuscKlgMqnr9gSv
         6RZTklpYV+rcFZjSFepegyOFLtuJi67b4P+9h9betgmBVGfMd1t5fqsYH0Tu8nsK156t
         Ytu8oVzBzKBRmk9+ZbjIDb2RFwqH67ZFug+4sv4OLRSbzR3E0inVliQwS5CENkvvn5XE
         MpQCA4UrwE6Lnqu5RgqL0LlxnTtL2Pt01fYzuvDhV8ckY6v5GSXp1NmM2yLYmixn3IE5
         kvqQ==
X-Gm-Message-State: AOJu0YwxFL8EfTp7ZRG/EEFYCeI789KFRr2RPzdFeJ0760qtg/od5m7c
	+FI1Pm6il1Y9W5tpZ/pjxVLNQWY8TM5bqyEwaM/A9fSfQrxJdVk0+xl4bfZ2pg==
X-Gm-Gg: ATEYQzzZk3afg4JgxIaRT7AwVekLrCCB+mW52g3WahwnXAOQ75Kd2oZbPL5jYbXMzy0
	JDGv/s2kbBMbmSq9Di4U7mynXAsBkjnN78oBCtVCRU3ahsIMEFsL4rYiUklimM7ea9pcjC2x1Ye
	h/1o/g+XX+IQnhgjUqFGC1b0BcBTCGQUCU4giW74dJixa2r0sS7rzD01QmG8ZG2AehB7nlp4iAo
	kj/knXnbd5FFWV8ULE11xASimtSVoRprh6NFM2QYnYH3PckZnP1BJaDIKmL3kpEw1sFjLwwHser
	Owt+etIqStT0mz9qiNBb6PHz6nxxBoNRAt4pK54Qe02MN6vmR4YlrJx9oCZhj8vDRdLHHGjrmn+
	flJ1qeFTgxqTOyRCc7IYQDur1pK0K3Bn0FiwXVBOI10r6AFy3d9xCuc+f5FcHL7nfqOpnIS8MEf
	zMQBpZfyn0HCs0MmDusMJk+Pfr
X-Received: by 2002:a05:7300:ed0d:b0:2be:2acf:4098 with SMTP id 5a478bee46e88-2be4e0ac31amr5581465eec.31.1773132687910;
        Tue, 10 Mar 2026 01:51:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.69.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f807714sm14897565eec.1.2026.03.10.01.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:51:27 -0700 (PDT)
Message-Id: <9ec447e3cb1d5fb0a1fbb76369e186be23efab1a.1773132678.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 08:51:18 +0000
Subject: [PATCH 5/5] advice: add stashBeforeCheckout advice for dirty branch
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
Cc: Arsh Srivastava <arshsrivastava00@gmail.com>,
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
-- 
gitgitgadget
