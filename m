Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF139FF4
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710100267; cv=none; b=LGLAHnhqXu7R3npguoYtbMJw52WR3P0Ya/zdNe7qfM1YZhIUA/+b/sp+Zm/cGrcVUKyswFjdQsmp74Ii049EGe4YDNgqtd4NyHi6iMf4wTm6yIeIXe/XnNqdAD7UyUdhB0WXVz4e6VtZ2ZDA+dG0YCKaCK0l4OGKl10pXT4yLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710100267; c=relaxed/simple;
	bh=BAZyCD2YWxmS+SRCp33rpFEOeYXcWQr+hS+FV6rTnZo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MSkvNp9zeKOxdwzQWoOyb9qKmrO2sxlKSalssDueO1e5IOqJGgE9EYeXD7TYsPWiZO/tHVwwBBzNLsZzj8OXDgrDG0JG6iOMLsk26eFEh+FfEFmuAkbmFPkvYUz7jX0CJeyXQ55reB8trdYdRdGpzoDDecZrRMyypU0nY3UMVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef94RHtc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef94RHtc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4132953e13dso1824885e9.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710100263; x=1710705063; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Enm8yxs4tRoP9Y84J9kayMcFq+wsLljzIb5YV5Un3CY=;
        b=Ef94RHtc3McTn3uS30LhJIz1Tdft9k0W2UafzO2NK6guDnnPH9QEX3CPrApw90AE/7
         YzQdS95qrCaARse1K9bIK4QQm/T5B5bde1l5b5nSLTI2JZ1zCVV1bKfXN/8suG4n50Dc
         2lQdpV29oevDWaYtmWQ2xJYNFCUM4PjFwJiEpNAAxCghER5JuPtBPHMOzPScRFx7nOhO
         8fHWUHPU4w2p5/JM554mvnr1ZsvnO4u1c6LF4JNK6Gaqm5q7ZNaAlpupXHeb0D2FRIWS
         QlfIS/SVNPXiN/EqTjuuD0u4fkD+gQVLr34/ecg9KYk8MS2vHkS8XHtgAHkUDuWRLQ9l
         GFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710100263; x=1710705063;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Enm8yxs4tRoP9Y84J9kayMcFq+wsLljzIb5YV5Un3CY=;
        b=YAUQuuzeoidBq1wmJKWsxDUWAjmzx/0cI68vPpxA12/GUw6dZxVKWANZ2WoCTVLqn2
         0w4eygeuzL0IpQFr6eS33aHHoOtNbPtkj2QHh/1HiypaxOj5eJMmkw3JdLsCVcfxyTYm
         bJG3wKIOlMf6CL8PWlhx2EOHqYAMNrVbhgiKY/iX0rfVRMS4kMPmXqr/bpnPqyxjYvnK
         J8jJjsy3OdbnByXQJvyt3yybYHKQBIcHItgMkuI/l32y//a7csH7a4383dALEkEuqVcg
         hne27kV5Y7C7FU41cCUtK2LPP4AGYrKb79ESeVvtZqGrk2/bRb6gb3YQtMV2VvyHifDU
         U3HQ==
X-Gm-Message-State: AOJu0Yy4ldpLWE2LDAg5kWKekRWOgkjd43itqQUVn9Ksuu4+nVJq1NHf
	MelLk3wNaXrkw9sCLLNRM53TyzrMXO9Sfkl+eu0TEtOOyw+1ur5rfbWIE+Cx
X-Google-Smtp-Source: AGHT+IEgE0U/wvRZSjxHpHHwvCed4Fwrb10C87AV0sfhq/OnzhAfZzB1DYwoLwmhw3Zh/HuVVbk/LQ==
X-Received: by 2002:a05:600c:1c82:b0:413:1ee8:aa0d with SMTP id k2-20020a05600c1c8200b004131ee8aa0dmr3376464wms.11.1710100263388;
        Sun, 10 Mar 2024 12:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ea4-20020a0560000ec400b0033e891d97d6sm3143208wrb.107.2024.03.10.12.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:51:03 -0700 (PDT)
Message-ID: <a2ce6fd24c270fcc89439cd7d119c701dd262ec5.1710100261.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
	<pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:51:00 +0000
Subject: [PATCH v2 1/2] sequencer: allow disabling conflict advice
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
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    ZheNing Hu <adlternative@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Allow disabling the advice shown when a squencer operation results in a
merge conflict through a new config 'advice.mergeConflict', which is
named generically such that it can be used by other commands eventually.

Note that we use 'advise_if_enabled' for each message in the second hunk
in sequencer.c, instead of using 'if (show_hints &&
advice_enabled(...)', because the former instructs the user how to
disable the advice, which is more user-friendly.

Update the tests accordingly. Note that the body of the second test in
t3507-cherry-pick-conflict.sh is enclosed in double quotes, so we must
escape them in the added line.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/config/advice.txt |  2 ++
 advice.c                        |  1 +
 advice.h                        |  1 +
 sequencer.c                     | 33 ++++++++++++++++++---------------
 t/t3501-revert-cherry-pick.sh   |  1 +
 t/t3507-cherry-pick-conflict.sh |  2 ++
 6 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c7ea70f2e2e..a1178284b23 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -56,6 +56,8 @@ advice.*::
 		Advice on how to set your identity configuration when
 		your information is guessed from the system username and
 		domain name.
+	mergeConflict::
+		Advice shown when various commands stop because of conflicts.
 	nestedTag::
 		Advice shown if a user attempts to recursively tag a tag object.
 	pushAlreadyExists::
diff --git a/advice.c b/advice.c
index 6e9098ff089..ecce0f5a803 100644
--- a/advice.c
+++ b/advice.c
@@ -57,6 +57,7 @@ static struct {
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
+	[ADVICE_MERGE_CONFLICT]				= { "mergeConflict" },
 	[ADVICE_NESTED_TAG]				= { "nestedTag" },
 	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning" },
 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists" },
diff --git a/advice.h b/advice.h
index 9d4f49ae38b..89117cdeb77 100644
--- a/advice.h
+++ b/advice.h
@@ -26,6 +26,7 @@ enum advice_type {
 	ADVICE_IGNORED_HOOK,
 	ADVICE_IMPLICIT_IDENTITY,
 	ADVICE_NESTED_TAG,
+	ADVICE_MERGE_CONFLICT,
 	ADVICE_OBJECT_NAME_WARNING,
 	ADVICE_PUSH_ALREADY_EXISTS,
 	ADVICE_PUSH_FETCH_FIRST,
diff --git a/sequencer.c b/sequencer.c
index f49a871ac06..d61bbe37c8c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -467,7 +467,7 @@ static void print_advice(struct repository *r, int show_hint,
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
 	if (msg) {
-		advise("%s\n", msg);
+		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s\n", msg);
 		/*
 		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
@@ -480,22 +480,25 @@ static void print_advice(struct repository *r, int show_hint,
 
 	if (show_hint) {
 		if (opts->no_commit)
-			advise(_("after resolving the conflicts, mark the corrected paths\n"
-				 "with 'git add <paths>' or 'git rm <paths>'"));
+			advise_if_enabled(ADVICE_MERGE_CONFLICT,
+					  _("after resolving the conflicts, mark the corrected paths\n"
+					    "with 'git add <paths>' or 'git rm <paths>'"));
 		else if (opts->action == REPLAY_PICK)
-			advise(_("After resolving the conflicts, mark them with\n"
-				 "\"git add/rm <pathspec>\", then run\n"
-				 "\"git cherry-pick --continue\".\n"
-				 "You can instead skip this commit with \"git cherry-pick --skip\".\n"
-				 "To abort and get back to the state before \"git cherry-pick\",\n"
-				 "run \"git cherry-pick --abort\"."));
+			advise_if_enabled(ADVICE_MERGE_CONFLICT,
+					  _("After resolving the conflicts, mark them with\n"
+					    "\"git add/rm <pathspec>\", then run\n"
+					    "\"git cherry-pick --continue\".\n"
+					    "You can instead skip this commit with \"git cherry-pick --skip\".\n"
+					    "To abort and get back to the state before \"git cherry-pick\",\n"
+					    "run \"git cherry-pick --abort\"."));
 		else if (opts->action == REPLAY_REVERT)
-			advise(_("After resolving the conflicts, mark them with\n"
-				 "\"git add/rm <pathspec>\", then run\n"
-				 "\"git revert --continue\".\n"
-				 "You can instead skip this commit with \"git revert --skip\".\n"
-				 "To abort and get back to the state before \"git revert\",\n"
-				 "run \"git revert --abort\"."));
+			advise_if_enabled(ADVICE_MERGE_CONFLICT,
+					  _("After resolving the conflicts, mark them with\n"
+					    "\"git add/rm <pathspec>\", then run\n"
+					    "\"git revert --continue\".\n"
+					    "You can instead skip this commit with \"git revert --skip\".\n"
+					    "To abort and get back to the state before \"git revert\",\n"
+					    "run \"git revert --abort\"."));
 		else
 			BUG("unexpected pick action in print_advice()");
 	}
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index aeab689a98d..43c579ea53a 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -170,6 +170,7 @@ test_expect_success 'advice from failed revert' '
 	hint: You can instead skip this commit with "git revert --skip".
 	hint: To abort and get back to the state before "git revert",
 	hint: run "git revert --abort".
+	hint: Disable this message with "git config advice.mergeConflict false"
 	EOF
 	test_commit --append --no-tag "double-add dream" dream dream &&
 	test_must_fail git revert HEAD^ 2>actual &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index c88d597b126..f3947b400a3 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -60,6 +60,7 @@ test_expect_success 'advice from failed cherry-pick' '
 	hint: You can instead skip this commit with "git cherry-pick --skip".
 	hint: To abort and get back to the state before "git cherry-pick",
 	hint: run "git cherry-pick --abort".
+	hint: Disable this message with "git config advice.mergeConflict false"
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
@@ -74,6 +75,7 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	error: could not apply \$picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
 	hint: with 'git add <paths>' or 'git rm <paths>'
+	hint: Disable this message with \"git config advice.mergeConflict false\"
 	EOF
 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
 
-- 
gitgitgadget

