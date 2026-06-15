Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D82E542C
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551175; cv=none; b=r+Ersp2yFgB9zBTNFmnspkdxuZXHHuIFEXiXZGi0mo8x2EB6bXK9t1+DamhN4Xf9dmK5RpXIHkFXtVSzCWpRmO7vmrpKWyrYe0hg2zL/nn8ENwb2xGycGlf0qDvK3w7lpCM4hhfJ2Wv9PEpG+bjyKpfbKBXyEeIQmMCAn6VA8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551175; c=relaxed/simple;
	bh=N4Goz6h9AngOPOL8qbxh7rLfBWOK9WZ32PF9hGCKCUc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=h8joIUvQ4D3TxBaB3j1txREVUGSD70E+dZo/3O9osJRLKVS/5/wkkId20Mxs51hkUnCBFPwJcGsfM4eZXkzbeDINUoK38coRxEPycuVzQIhRi73ZTobotbXEEQ+NxbYZ65ds7I/quWlMXEpAONB3AZFZV2YQY3ZcHuQvZnx2GVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvKtROLq; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvKtROLq"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51764768c36so52040421cf.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781551172; x=1782155972; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DSC8ztias4oNxUP/S1FwFTrACzARvOKmrnoFDpzBtNg=;
        b=HvKtROLqMKdStrt3NKmAERJ5vQ7HNadxzGZyhJjXYkm0GfUzCFTspWTFJpxd5jqO6D
         jNUDTBADIefgBUZZGKm1RDXoEDKm0Erj3bqF34nCD1zebQc1jVethHgq7OcUk5uKGCrS
         msDhaqkJy9ihfk42OTg2AZeGqA338jz8EueKyZCRIivj0DJTiEFyjH/OS4oj/00G3kTN
         8SGcCFRX1EV/HnKB8xK6mNjW8bzfsjj+4nzgt0cLVbg3TdKTtG6NXTgmiq4+8s5aDc88
         UcOHq8VGkPek/PI35k9rFehViiSQ4Pht5KagWNuWel1cY0g6POQG3OjQeQwelQ8uGw14
         +LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781551172; x=1782155972;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSC8ztias4oNxUP/S1FwFTrACzARvOKmrnoFDpzBtNg=;
        b=rdPTeTaYzGbeCpHPJGMlh4P/HGG3VU8MK1qt18GCqsOAtGuxgvS8nN0IJVhrqLKslI
         HDvRrR5PgWu1Nd+R//UozXknRLRm5RZ56E6uHhbHNMhsbLy0utdptHTMTnSAUoGWZ4aO
         qRL/ZzcHn+Fl02JPuRtwFFrCWYHWTW63tHFpRY866DBD/rkewoQzaqI4mGGm6/XLoeQ5
         02yzcn8XV6krmLO1Pc45njVV1gMKxrhDllE7Fc2KvvXSWQDMh3KN0gsntgFh5EPkgK2X
         sFU9/d8EKiXpf/6UuRgHfGRMJ0iu4HAdbCQFQ6mhMLISK3lBtw0d8X+xOHkZinZjFk5Y
         6KeA==
X-Gm-Message-State: AOJu0Yzqe/x7eDtAGeJaRVqaebDoAfcUByWZ532i/mPpYE84o5bJ3JVI
	U7gsKaMB/zBVH6sU3NjDer39aIo2tai0JEzFLpBUkGS6BoLjDSdagWXibPtq/Q==
X-Gm-Gg: Acq92OEN4HOLvBO0ULy02tzzVWNY+kmI1sbw9t4R0XC5XEwy3oRi5kaBrPJq5KhCwIz
	XUmWTqKMKw64e+hG5qUw/7HgK46b7XWVkwapAND2hT6PwFV7PqLNIpioqk3NlCN1hhLEzH6DP+5
	F2HtesLSIlUDtxRUB/A8XA+QGgbhulxRSheARYMyg3O+aeGSRzNmr2SIzuFo97Tw84f5NrknrOv
	MPUJ44Vn0Exj8TjF4ojmMqPVxZnWhcEE5ohy9Y6n35xtttzR6rJnaxA+vKTqYTd4wYdVjnBb/os
	Dx2jvR2JXWUPXMBebbOqXgUEh0kOweaq8pp4S/LsR+2bH9LVC4sPCURXVZY9XNvGHcGQfftLFbr
	PgTjCNTkYHDREafTuZAZO+KIO2D1e/TRCoS38xrskW78Mk5GwWx8zrvsYFfLRG4XS1Bvj4kWSs9
	ljnkxRQzZ/0+TnCu3TKL+v5D7ZTNtfuigN3Qk=
X-Received: by 2002:a05:622a:2592:b0:517:875a:d619 with SMTP id d75a77b69052e-519534dbf71mr189543061cf.6.1781551172024;
        Mon, 15 Jun 2026 12:19:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.71.57])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb79df4dsm115486381cf.15.2026.06.15.12.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:19:31 -0700 (PDT)
Message-Id: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 19:19:30 +0000
Subject: [PATCH] rebase: mention --abort alongside --continue
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The warning shown when an "exec" step fails and the "git status"
advice while splitting or editing a commit pointed users at "git
rebase --continue" but not "--abort". Mention it in both, matching
the conflict case.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    rebase: mention --abort when an exec step fails
    
    Mention git rebase --abort both in the warning shown when an exec step
    fails and in the git status advice while splitting or editing a commit,
    since rebase pointed users at --continue there without saying how to
    bail out, unlike every comparable command.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2330%2FHaraldNordgren%2Frebase-exec-abort-hint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2330/HaraldNordgren/rebase-exec-abort-hint-v1
Pull-Request: https://github.com/git/git/pull/2330

 sequencer.c            |  8 ++++++--
 t/t7512-status-help.sh | 17 +++++++++++++++++
 wt-status.c            |  7 ++++++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 57855b0066..c46e5b95bc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3884,7 +3884,9 @@ static int do_exec(struct repository *r, const char *command_line, int quiet)
 			  "You can fix the problem, and then run\n"
 			  "\n"
 			  "  git rebase --continue\n"
-			  "\n"),
+			  "\n"
+			  "To abort and get back to the state before \"git rebase\", run "
+			  "\"git rebase --abort\".\n"),
 			command_line,
 			dirty ? _("and made changes to the index and/or the "
 				"working tree.\n") : "");
@@ -3897,7 +3899,9 @@ static int do_exec(struct repository *r, const char *command_line, int quiet)
 			  "Commit or stash your changes, and then run\n"
 			  "\n"
 			  "  git rebase --continue\n"
-			  "\n"), command_line);
+			  "\n"
+			  "To abort and get back to the state before \"git rebase\", run "
+			  "\"git rebase --abort\".\n"), command_line);
 		status = 1;
 	}
 
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 08e82f7914..ca7ef66ae3 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -206,6 +206,7 @@ No commands remaining.
 You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -240,6 +241,7 @@ Next command to do (1 remaining command):
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
+  (use "git rebase --abort" to check out the original branch)
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
@@ -278,6 +280,7 @@ No commands remaining.
 You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -317,6 +320,7 @@ Next command to do (1 remaining command):
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -347,6 +351,7 @@ Next command to do (1 remaining command):
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
+  (use "git rebase --abort" to check out the original branch)
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
@@ -383,6 +388,7 @@ Next command to do (1 remaining command):
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -414,6 +420,7 @@ Next command to do (1 remaining command):
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -445,6 +452,7 @@ Next command to do (1 remaining command):
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
+  (use "git rebase --abort" to check out the original branch)
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
@@ -482,6 +490,7 @@ Next command to do (1 remaining command):
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -515,6 +524,7 @@ Next command to do (1 remaining command):
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -548,6 +558,7 @@ Next command to do (1 remaining command):
   (use "git rebase --edit-todo" to view and edit)
 You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
+  (use "git rebase --abort" to check out the original branch)
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
@@ -587,6 +598,7 @@ Next command to do (1 remaining command):
 You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -718,6 +730,7 @@ No commands remaining.
 You are currently editing a commit while rebasing branch '\''bisect'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 You are currently bisecting, started from branch '\''bisect_while_rebasing'\''.
   (use "git bisect reset" to get back to the original branch)
@@ -987,6 +1000,7 @@ No commands remaining.
 You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -1015,6 +1029,7 @@ Next commands to do (2 remaining commands):
 You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -1044,6 +1059,7 @@ Next commands to do (2 remaining commands):
 You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
@@ -1064,6 +1080,7 @@ Next command to do (1 remaining command):
 You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your changes)
+  (use "git rebase --abort" to check out the original branch)
 
 nothing to commit (use -u to show untracked files)
 EOF
diff --git a/wt-status.c b/wt-status.c
index b17372390c..94fd14a058 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1527,9 +1527,12 @@ static void show_rebase_in_progress(struct wt_status *s,
 		else
 			status_printf_ln(s, color,
 					 _("You are currently splitting a commit during a rebase."));
-		if (s->hints)
+		if (s->hints) {
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
+			status_printf_ln(s, color,
+				_("  (use \"git rebase --abort\" to check out the original branch)"));
+		}
 	} else {
 		if (s->state.branch)
 			status_printf_ln(s, color,
@@ -1544,6 +1547,8 @@ static void show_rebase_in_progress(struct wt_status *s,
 				_("  (use \"git commit --amend\" to amend the current commit)"));
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --continue\" once you are satisfied with your changes)"));
+			status_printf_ln(s, color,
+				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
 	}
 	wt_longstatus_print_trailer(s);

base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
-- 
gitgitgadget
