Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953A3A8735
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382599; cv=none; b=Dxj/AwNRBq78HgEiUXy84dzWFAa9G1Llp+Olz35wErU9XGi+a45M1IX+e6lB9dGxG1VsSV+/Cn3zS1x/6lFH+U4o1ZHLa85GG6I/5hZkUqhKLq4jBlEpDqxbBZHoQGq61/m+a2UeX8h2wjBNwPhW6tXh8kwCZLPx8MUsm5UQxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382599; c=relaxed/simple;
	bh=6X8IIIqS7vRCQ/Lf0Xpjzyka8zB3swtAuIdi+gIvrxY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HARvisIFuE/KQKKwwejroAMn4ahxkotkoCU0OEVcCer0Qbh4x60HdyFtoCPcj0Gx7MlgaRuhbSFcZR7CoiJfavXquN4BobkgwWuIfdh0MLkRZuCVWrtThfVMUqUY1G5iOJetaR87z8GQWN74FQ5VDcSAS2ae12pCSBp46ZX2rVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5Glcn9K; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5Glcn9K"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d868d014a5so69244eec.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382594; x=1776987394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEt9LogO1fFyWlBEuwq4Ctrv9Wl8Wk8/edcZhTZAbLE=;
        b=k5Glcn9KeY8ahT35oGlxMmx67GKFz+BBiZKHjzg9sVaUVq+xEqj/+CT7KuaO5DDUZw
         zBU1hLKvfK//fBCO1GaqDysfqp68V424n1LKre9wUnK30tM3p1GXsOkJqPlYS4MOyXZ8
         l/Ewl9tt+nzm5X2uivo4ckgrZi2GUtrQz0mteS+KpG4a3j3I4E3Hr0kNv33fO2MIWOA0
         bCIMM6U81kWLmWdIEB3fNBVd2ea1WJLV0CHE1D2RPy20IKnqlmIT2hxX/LO+O27fYvHX
         53Ko6TpQfwSFlNsJZqQV4+GNSGf5YKJ7xHE1MHn6PTD65b+FGI6bQIw6gcfYif9FoSeG
         yADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382594; x=1776987394;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bEt9LogO1fFyWlBEuwq4Ctrv9Wl8Wk8/edcZhTZAbLE=;
        b=cWibetVi/itUf25I7u/zU3b7kzW+wYSaTBGL7JtijXXK2OXGFN37JOJncijVbmg6lm
         5t3JXZVSvUIAayalZBUXmhnnEcHyQBghvsDX/rgTpz0G1dSpCA1PHyHUAhI0mz8UWJo7
         M0/GesTHxe8ZqSqiJq1L6qqXSp8NtWgt0A5N/YMOkX8eNPM5lQrwzGxRFsoL+eeBh+d2
         91MzA1hsb4Nefr7wFrMt7MR/cXieLkkTckYFuDHFH6N8WuiTZ/iGEWU8swcwRsV6wnY3
         Z0ooUmMt6WQfe/P1QuCPpItWD0DXkZ8h2XXJxypjRr88FVrmoHhRKuFMvYrcYseAddGb
         1caA==
X-Gm-Message-State: AOJu0YzrP1dCY4gY934iMGzK0V5bUmAn9ZWRwIL1I2R1LNQ9Cd+msdmH
	kVvnci9swNxcHYCYMPx6/qPfKyFBS4apH4dFnyGqAaXexuR2OGMMOdscWJrWEg==
X-Gm-Gg: AeBDieswb0qDJsIbiNrEw1PHMfjW8kVP3rfeE2CfmhNfFehLeDnAJYKNylgDjeLSCte
	JYX/YM/YD2yqZlR2SwRCwsAar7tBgVSrHUPxkFJ2lHlqky2Ka5GUpJyHvi2NmsivOeJqLyzjtPX
	kmO4EHvSsoccJXcHzBQWA7mpyI9DMwEPt+ESteK6aUFXAeucX9ulz/Vd63V2uxH5FKx1qzkFeI7
	7v3Z1GF/Xqi//kALvNhWm4KwyMMrTaZpuXKKXBtvg6OOJf7sl198tOI0CBgXUoRLkD1BYfqhQdM
	cevma0dgo5m0uoU8o5sZv2mpsGqSwsm61iuPHKli22A0qyupvWVWu0qg1xgyKjSYeSlAARdbyzJ
	xdD7lEJMJduXw6Blgc+eEn68cdTOwirIWItfNaDu4bxB3atV3sbkc7KsGpfSersrGUstJyb1NFU
	Wi0Fj0RivPjuvzqYUaxCZd55hOT1uImFmI9LM=
X-Received: by 2002:a05:7300:b905:b0:2dd:5641:f01 with SMTP id 5a478bee46e88-2e479110b4emr204023eec.28.1776382594212;
        Thu, 16 Apr 2026 16:36:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.51.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e4d69b7306sm183478eec.30.2026.04.16.16.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:36:33 -0700 (PDT)
Message-Id: <d0cfc298870405cda95d382f3eab827c5034bf68.1776382591.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
References: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 23:36:26 +0000
Subject: [PATCH 1/6] RelNotes/2.54.0: fix typos and grammar
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Fix various issues in the release notes -- missing/wrong articles, typo,
indentation, quote consistency, and wording improvement or corrections.

Other than the indentation fix for "The way combined list-object filter
options...", this patch is much easier to view with --color-words.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/RelNotes/2.54.0.adoc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/RelNotes/2.54.0.adoc b/Documentation/RelNotes/2.54.0.adoc
index 2ad73ff473..7bfc351c9a 100644
--- a/Documentation/RelNotes/2.54.0.adoc
+++ b/Documentation/RelNotes/2.54.0.adoc
@@ -36,7 +36,7 @@ UI, Workflows & Features
  * Extend the alias configuration syntax to allow aliases using
    characters outside ASCII alphanumeric (plus '-').
 
- * A signature on a commit that was GPG signed long time ago ought to
+ * A signature on a commit that was GPG signed a long time ago ought to
    be still valid after the key that was used to sign it has expired,
    but we showed them in alarming red.
 
@@ -88,7 +88,7 @@ UI, Workflows & Features
  * "git repo structure" command learns to report maximum values on
    various aspects of objects it inspects.
 
- * "git rebase" learns "--trailer" command to drive the
+ * "git rebase" learns "--trailer" option to drive the
    interpret-trailers machinery.
 
  * "git fast-import" learned to optionally replace signature on
@@ -119,7 +119,7 @@ UI, Workflows & Features
  * "git replay" (experimental) learns, in addition to "pick" and
    "replay", a new operating mode "revert".
 
- * git replay now supports replaying down to the root commit.
+ * "git replay" now supports replaying down to the root commit.
 
  * Handling of signed commits and tags in fast-import has been made more
    configurable.
@@ -207,7 +207,7 @@ Performance, Internal Implementation, Development Support etc.
    from getting added.
 
  * The core.attributesfile is intended to be set per repository, but
-   were kept track of by a single global variable in-core, which has
+   was kept track of by a single global variable in-core, which has
    been corrected by moving it to per-repository data structure.
 
  * Use the hook API to replace ad-hoc invocation of hook scripts via
@@ -232,8 +232,8 @@ Performance, Internal Implementation, Development Support etc.
  * Reduce dependence on the global the_hash_algo and the_repository
    variables of wt-status code path.
 
-  * The way combined list-object filter options are parsed has been
-    revamped.
+ * The way combined list-object filter options are parsed has been
+   revamped.
 
  * Editorconfig filename patterns were specified incorrectly, making
    many source files inside subdirectories unaffected, which has been
@@ -272,7 +272,7 @@ Performance, Internal Implementation, Development Support etc.
  * split-index.c has been updated to not use the global the_repository
    and the_hash_algo variables.
 
- * The unsigned integer that is used as an bitset to specify the kind
+ * The unsigned integer that is used as a bitset to specify the kind
    of branches interpret_branch_name() function has been changed to
    use a dedicated enum type.
 
@@ -282,7 +282,7 @@ Performance, Internal Implementation, Development Support etc.
  * Code paths that loop over another array to push each element into a
    strvec have been rewritten to use strvec_pushv() instead.
 
- * In case homebrew breaks REG_ENHANCED again, leave a in-code comment
+ * In case homebrew breaks REG_ENHANCED again, leave an in-code comment
    to suggest use of our replacement regex as a workaround.
 
  * MinGW build updates.
@@ -382,7 +382,7 @@ Fixes since v2.53
    (merge f4eff7116d ps/pack-concat-wo-backfill later to maint).
 
  * "git switch <name>", in an attempt to create a local branch <name>
-   after a remote tracking branch of the same name gave an advise
+   after a remote tracking branch of the same name gave an advice
    message to disambiguate using "git checkout", which has been
    updated to use "git switch".
    (merge 12fee11f21 jc/checkout-switch-restore later to maint).
@@ -396,7 +396,7 @@ Fixes since v2.53
  * "git format-patch --from=<me>" did not honor the command line
    option when writing out the cover letter, which has been corrected.
 
- * Update build precedure for mergetool documentation in meson-based builds.
+ * Update build procedure for mergetool documentation in meson-based builds.
    (merge 58e4eeeeb5 pw/meson-doc-mergetool later to maint).
 
  * An earlier attempt to optimize "git subtree" discarded too much
-- 
gitgitgadget

