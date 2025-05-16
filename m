Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387B27FB16
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421740; cv=none; b=txcrOz7/y9gnngL9ew4ijliKqwamtQbncIL7J0dG3vLWNU4KXjjfFTgoS1by+GNFwtqyPv2lmuIfHoYHGsm7rlsPFS44xdgQl+smkXxFh4cxCnooPIrmbBS6kLd9izN2Hs88lLSHnMUxjAyhSVLsIbqJib5bn/HtJfM3m+Bi6w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421740; c=relaxed/simple;
	bh=rUrRbxoDOlt1KUqev3GDHiW/x5JZJC1LqbDbiX2OzxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fklyS0g35mB0SXiaALHfzK17IJ/VndB+9Uje4hd+RBPzcGIJjxvaHztko+44HKbWUlKmgqJlizIHYKaZZV6xivOXiysYSInFO+QaccwYz6Oj5P2ZxCdCc8uMdtMS6IFJ3A/3AZTYzymfAvhlYG8sepAvfAZIZxShXOSKFtTeiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MguiwhlG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MguiwhlG"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30e8f4dbb72so785056a91.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747421738; x=1748026538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0URaE3T4Ae8bn9E0z8BPHcKY/HxWeOOpJXnS1X0bdvI=;
        b=MguiwhlGVwkauAhcefqAKUFWhMlGvuYIuKTa3+9Wv39/WpI2XvemMCufFNgOHVvfli
         9e6LeJBjCfG+A2CnR5hUkiebd5InbQ0dtbXTXkESW1cDsCLlvQZTmghXanJFo6d9gcnP
         fu0bnC8o3xO38Y2fV68MqAxrTzdDpDJ8KO7/00hEsw2GMfgoYMAgmdTfAHoZ/9enJofn
         JnmA3Bu23XKqzQ0c6IhlDGJ59acsy5g4bMm2HmRYuvjPHgwJ9bd+6qsLPDlxVLOEL1PF
         0LJc7BLynBB36HjEUODuXCU0GxaE2X7tDyuMaJybyuTj+5GjHEaqqgEPAzBgPnmXkVXZ
         XzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747421738; x=1748026538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0URaE3T4Ae8bn9E0z8BPHcKY/HxWeOOpJXnS1X0bdvI=;
        b=E/LdVZbir9rRVyEPBmbmA0km3HJKVOKYfbDpSAMXe+5ytBkqEzEwe+kK9GaAoTduiP
         7ajDnuV8PzQYYQFDvZ0PUoImsF7MJFLGKMuVOi2XogZ03hV2gh6mWm0iOcXp2pTYTZrq
         jVvFHe5jze2MPZrKSzLzH9Y3sjaaR0Pzqw/ZrKEex9amhqx8aWWiqj8eskPLOc5B1TvI
         s1P9eaDHfBx3UaJcmGgCP0GcFeLXkgoaAGFMcW7F4plhz8lyBvqz8AwsYPmDbE3WVi1k
         J9d5PGueJv4USZK68Vt4M+V35FR9NeX4eOq+oAseWekfXiKlV8Ca46beYszY80Cod1hv
         fn9Q==
X-Gm-Message-State: AOJu0YwjAdz8PWnTE6ZVuTP9uagleH5Juaqh7aFUBWX+HUmdxF9jVLvh
	AbuXOUCKSOjrtIPfXeQG8+0d1D0zr3yLbq0zsupimGDwTGlO1uh3pd51
X-Gm-Gg: ASbGnctfXYmvCOeIxNz+rEkcqV2AANZXbJDP/gg+TG6jdutAtqK4iTcwbqZx7YFht9o
	j4+0eEKfTwTzDe8wkx5rnbsRg42ceicf5nRBIsjGymNIIElsVgHHnMMmReavb9sgrOCPJkrFcMS
	AY0ZX6Fp5f3KFRnTiQOvZrhERWPKi2INww61KurDfaBgs1vBMcigZwlnTWG108UJHoZQwpXtoUg
	A/VAYLFalkmU8Uik4YuLebkHKX0zKV81fK9mSFi9K0GTrk2RdybHGVG7/TOjfprDZUiBEuGrzNz
	kRtHI2LIztsya39E60xPKbyke8vWRnI3y7HdS9R0qFH1lNZFVvbYsho59FBcTUp8Lzo=
X-Google-Smtp-Source: AGHT+IHmVTIj4GCAvLKimtfM4RVvD+XSO3jOtCBvCuN2JiJQKOcW/+WWNyEIooj/vpK4vXC35jG2tA==
X-Received: by 2002:a17:90b:4ccc:b0:30e:3718:e9d with SMTP id 98e67ed59e1d1-30e8323f00bmr5845902a91.35.1747421737912;
        Fri, 16 May 2025 11:55:37 -0700 (PDT)
Received: from fedora.. ([2409:40f0:41:81bb:63e2:a167:6132:4460])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e3343a11csm5591224a91.20.2025.05.16.11.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:55:37 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: nasamuffin@google.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH v2 2/3] docs: clarify cmd_psuh signature and explain UNUSED macro
Date: Sat, 17 May 2025 00:25:15 +0530
Message-ID: <20250516185516.52311-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
References: <aCeAIqwvEVOdrsMg@google.com>
 <20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation previously omitted the UNUSED macro,
which often led to confusion for new contributors
when they encountered compiler warnings related to unused parameters.
This commit adds a brief explanation to help clarify its
purpose and common usage in the Git codebase.

Additionally, the function signature for cmd_psuh has been updated
to include the struct repository *repo argument,
aligning it with the standard pattern for built-in commands.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ef190d8748..f4320d8869 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -142,7 +142,15 @@ command in `builtin/psuh.c`. Create that file, and within it, write the entry
 point for your command in a function matching the style and signature:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
+----
+
+We will use the UNUSED macro to make sure we don't recieve compiler warnings
+for unused arguments from the function cmd_psuh.
+
+----
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED,
+	    const char *prefix UNUSED, struct repository *repo UNUSED)
 ----
 
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
@@ -150,7 +158,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix);
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -166,7 +174,8 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, 
+	    const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
@@ -279,8 +288,9 @@ on the reference implementation linked at the top of this document.
 It's probably useful to do at least something besides printing out a string.
 Let's start by having a look at everything we get.
 
-Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
-existing `printf()` calls in place:
+Modify your `cmd_psuh` implementation to dump the args you're passed,
+keeping existing `printf()` calls in place; because the args are now
+used, remove the `UNUSED` macro from them:
 
 ----
 	int i;
-- 
2.49.GIT

