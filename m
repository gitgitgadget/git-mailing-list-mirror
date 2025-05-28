Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A71FBE80
	for <git@vger.kernel.org>; Wed, 28 May 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437345; cv=none; b=SpMxnYmMu9k1MBHY+NUfNBy7/i3kKz4aNEhYWn4t1jpGRJY4Xl8mNdokTlbA6Iu6nBNU1Ha8ksKl1epoZidbGEKdU0RuxOHyHYZQ1bFpj6/2DF+vsfn/fzZVn2gGVuwfeQc0ioE+bQWFN53ZNOA1rsYwxQTHtgBbX15FM5a7Zhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437345; c=relaxed/simple;
	bh=ezQwc+knZtOxukvAjBRke3RumJ59DYOGhJy++3gKw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nC+eKdjZ8POMXuxjJTQJAF1VTqmtqtdzItkVNKLSfOcdHbxaEl+Po0o0ULL65NJhr9pIwb0sLwVD5k5yX1FlZZh2gm6Ul3OFeKCR2udtP5PpCZapfuNVI45sl904+z/TsWB0obRmAPJ12AOm7gWCifVzsVceJe2m+FoC9XzBw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pspdfkit.com; spf=pass smtp.mailfrom=pspdfkit.com; dkim=pass (1024-bit key) header.d=pspdfkit.com header.i=@pspdfkit.com header.b=H0avVyow; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pspdfkit.com header.i=@pspdfkit.com header.b="H0avVyow"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c55500cf80so350573585a.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pspdfkit.com; s=google; t=1748437342; x=1749042142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuH2E8mQug8BUByoTdFubAxogUVIP2GeUPlVBLZnhnw=;
        b=H0avVyowNxFEDrNt1YJN0L1WYJFJoebdnz2wZVZ8nLiV5QWxY3iGlvHOINyiLXp0X4
         lCJrRBlRJLdm1NgrQIJr7qz8FXILOOe/4gu0bmKiAH30WlZgXhTPnADO0juAan10z1LM
         /TBK7CiS++CcCt92idcsV7mX5Z4lN5xBDeqJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748437342; x=1749042142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuH2E8mQug8BUByoTdFubAxogUVIP2GeUPlVBLZnhnw=;
        b=k5H656SvGdeOEhWSF29U6D16iYtUIAVXp8MqXBCGRYufk6hyCN7eQb5ZATjzlavbBG
         a29mvYWGHojnDI3xSXQzC2+ZGng+2h5x/hnvOlvWeTNDD8QSFMzl0T+GZpn/mftNUY9s
         9SaixiB2cOMbq8aR9kmMLQs59eaPz/jH6iNq58SjM5DPRPcSu0BVscwusamYYoYmqE5I
         4jINcRmX+4ORZWykVNM/3538DhozyDjTMRLr3hvpk4SUMbh/TZbneSR3Egf8nrVJBadq
         ZcmsbFm/9H5PV3ZARVZrtXPWVV62Mwqdnoa2lwQJdO8S/exvFJp0OK6M7zyG3NBM9CYs
         fMKw==
X-Gm-Message-State: AOJu0YwXzU4zRyWO54CfZ8FcOq5yAUQLBFVxoMRmFAwlRCZstFCnNeNx
	P6jAdWXIEl4+g0oRqoXFUqNYX/2HJLG9RBSBkmpDJfCfnE/BPpAOpJ9NqVZQ0BWsDFBD6vkp8Ov
	kZRlhC5rJdMYEhYkdv43Xv2aD61EDRUBsmF4vvtdocr4oYVaMBdX7HTh8QsBJCzIPob7sODEIbJ
	CCeZcs8+SLKDtVyc5m4fv/kH1Cv04clxKxwDsfH9M=
X-Gm-Gg: ASbGnctkiyQ1BOf8IIYYKxQw2nE04vBvvf4HX9rppvd6/xI1UP4S3SiJWArZNI3FBVl
	hU3LoO9Fi4ax5vIqSwlCEiBZ+RQaBqcYisXzKL9RkIb181qmW0DgUz7EeUOJMkXj6ZnMBKDIQiA
	mjuvoxn2s8cPzHuU/jR3GqEM87l8aF5zh0zhxO5hyKTD03wZUfUGpiR8bAIqOVzFefDzTLA1h47
	gTaxZocjDiofBRcJylNvfg1yPI37UIXZiK2SqjHAuPOcCz88s7ELukNAMAL2CZp9l95nc9antid
	oZ4lgVugk9KdbFKdTVIYkwq1lhNEDmdfojs0NYZJNXEzIs95SxhC3jVDBm6OsyAEDh0xVmLAVeB
	PDthYZSues5y1y+e4XvdUIGCrwv3azcVPGZPPTfc=
X-Google-Smtp-Source: AGHT+IEs9Yxk22MT6WKNQkR7idReBYKhCILfxJRWQk2gIZJsei/CQ3oMHD+Dp2koPuLRMy5mkpGSHg==
X-Received: by 2002:a05:620a:40cc:b0:7c7:766d:9b00 with SMTP id af79cd13be357-7ceecc7937emr2587280485a.36.1748437341813;
        Wed, 28 May 2025 06:02:21 -0700 (PDT)
Received: from localhost.localdomain (syn-024-208-163-239.res.spectrum.com. [24.208.163.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d06801f3d8sm54269585a.14.2025.05.28.06.02.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 May 2025 06:02:21 -0700 (PDT)
From: Patrik Weiskircher <patrik@pspdfkit.com>
To: git@vger.kernel.org
Cc: apenwarr@gmail.com,
	Patrik Weiskircher <patrik@pspdfkit.com>
Subject: [PATCH 1/2] contrib/subtree: Add -S/--gpg-sign option
Date: Wed, 28 May 2025 09:01:15 -0400
Message-ID: <20250528130116.21534-2-patrik@pspdfkit.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528130116.21534-1-patrik@pspdfkit.com>
References: <20250528130116.21534-1-patrik@pspdfkit.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If set, forwards the options to commit-tree and merge.

Signed-off-by: Patrik Weiskircher <patrik@pspdfkit.com>
---
 contrib/subtree/git-subtree.adoc | 20 +++++++++----
 contrib/subtree/git-subtree.sh   | 50 +++++++++++++++++++++++---------
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/contrib/subtree/git-subtree.adoc b/contrib/subtree/git-subtree.adoc
index 004abf415b..f550be1a86 100644
--- a/contrib/subtree/git-subtree.adoc
+++ b/contrib/subtree/git-subtree.adoc
@@ -9,14 +9,14 @@ git-subtree - Merge subtrees together and split repository into subtrees
 SYNOPSIS
 --------
 [verse]
-'git subtree' [<options>] -P <prefix> add <local-commit>
-'git subtree' [<options>] -P <prefix> add <repository> <remote-ref>
-'git subtree' [<options>] -P <prefix> merge <local-commit> [<repository>]
-'git subtree' [<options>] -P <prefix> split [<local-commit>]
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] add <local-commit>
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] add <repository> <remote-ref>
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] merge <local-commit> [<repository>]
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] split [<local-commit>]
 
 [verse]
-'git subtree' [<options>] -P <prefix> pull <repository> <remote-ref>
-'git subtree' [<options>] -P <prefix> push <repository> <refspec>
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] pull <repository> <remote-ref>
+'git subtree' [<options>] -P <prefix> [-S[<keyid>]] push <repository> <refspec>
 
 DESCRIPTION
 -----------
@@ -149,6 +149,14 @@ OPTIONS FOR ALL COMMANDS
 	want to manipulate.  This option is mandatory
 	for all commands.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+--no-gpg-sign::
+	GPG-sign commits. The `keyid` argument is optional and
+	defaults to the committer identity; if specified, it must be
+	stuck to the option without a space. `--no-gpg-sign` is useful to
+	countermand a `--gpg-sign` option given earlier on the command line.
+
 OPTIONS FOR 'add' AND 'merge' (ALSO: 'pull', 'split --rejoin', AND 'push --rejoin')
 -----------------------------------------------------------------------------------
 These options for 'add' and 'merge' may also be given to 'pull' (which
diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 15ae86db1b..b98a708c10 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -26,12 +26,12 @@ then
 fi
 
 OPTS_SPEC="\
-git subtree add   --prefix=<prefix> <commit>
-git subtree add   --prefix=<prefix> <repository> <ref>
-git subtree merge --prefix=<prefix> <commit>
-git subtree split --prefix=<prefix> [<commit>]
-git subtree pull  --prefix=<prefix> <repository> <ref>
-git subtree push  --prefix=<prefix> <repository> <refspec>
+git subtree add   --prefix=<prefix> [-S[<keyid>]] <commit>
+git subtree add   --prefix=<prefix> [-S[<keyid>]] <repository> <ref>
+git subtree merge --prefix=<prefix> [-S[<keyid>]] <commit>
+git subtree split --prefix=<prefix> [-S[<keyid>]] [<commit>]
+git subtree pull  --prefix=<prefix> [-S[<keyid>]] <repository> <ref>
+git subtree push  --prefix=<prefix> [-S[<keyid>]] <repository> <refspec>
 --
 h,help!       show the help
 q,quiet!      quiet
@@ -46,6 +46,7 @@ rejoin        merge the new branch back into HEAD
  options for 'add' and 'merge' (also: 'pull', 'split --rejoin', and 'push --rejoin')
 squash        merge subtree changes as a single commit
 m,message!=   use the given message as the commit message for the merge commit
+S,gpg-sign?key-id   GPG-sign commits. The keyid argument is optional and defaults to the committer identity; if specified, it must be stuck to the option without a space.
 "
 
 indent=0
@@ -102,6 +103,20 @@ assert () {
 	fi
 }
 
+# Usage: gpg_sign_opt
+# Returns the GPG signing option for git commit-tree
+gpg_sign_opt () {
+	if test "${arg_gpg_sign+set}" = "set"
+	then
+		if test -n "$arg_gpg_sign"
+		then
+			printf " -S%s" "$arg_gpg_sign"
+		else
+			printf " -S"
+		fi
+	fi
+}
+
 # Usage: die_incompatible_opt OPTION COMMAND
 die_incompatible_opt () {
 	assert test "$#" = 2
@@ -240,6 +255,15 @@ main () {
 			test -n "$allow_addmerge" || die_incompatible_opt "$opt" "$arg_command"
 			arg_addmerge_squash=
 			;;
+		-S)
+			if test $# -gt 0 && test "${1#-}" = "$1"
+			then
+				arg_gpg_sign="$1"
+				shift
+			else
+				arg_gpg_sign=""
+			fi
+			;;
 		--)
 			break
 			;;
@@ -537,7 +561,7 @@ copy_commit () {
 			printf "%s" "$arg_split_annotate"
 			cat
 		) |
-		git commit-tree "$2" $3  # reads the rest of stdin
+		git commit-tree "$2" $(gpg_sign_opt) $3  # reads the rest of stdin
 	) || die "fatal: can't copy commit $1"
 }
 
@@ -683,10 +707,10 @@ new_squash_commit () {
 	if test -n "$old"
 	then
 		squash_msg "$dir" "$oldsub" "$newsub" |
-		git commit-tree "$tree" -p "$old" || exit $?
+		git commit-tree "$tree" $(gpg_sign_opt) -p "$old" || exit $?
 	else
 		squash_msg "$dir" "" "$newsub" |
-		git commit-tree "$tree" || exit $?
+		git commit-tree "$tree" $(gpg_sign_opt) || exit $?
 	fi
 }
 
@@ -925,11 +949,11 @@ cmd_add_commit () {
 	then
 		rev=$(new_squash_commit "" "" "$rev") || exit $?
 		commit=$(add_squashed_msg "$rev" "$dir" |
-			git commit-tree "$tree" $headp -p "$rev") || exit $?
+			git commit-tree "$tree" $(gpg_sign_opt) $headp -p "$rev") || exit $?
 	else
 		revp=$(peel_committish "$rev") || exit $?
 		commit=$(add_msg "$dir" $headrev "$rev" |
-			git commit-tree "$tree" $headp -p "$revp") || exit $?
+			git commit-tree "$tree" $(gpg_sign_opt) $headp -p "$revp") || exit $?
 	fi
 	git reset "$commit" || exit $?
 
@@ -1080,9 +1104,9 @@ cmd_merge () {
 	if test -n "$arg_addmerge_message"
 	then
 		git merge --no-ff -Xsubtree="$arg_prefix" \
-			--message="$arg_addmerge_message" "$rev"
+			--message="$arg_addmerge_message" $(gpg_sign_opt) "$rev"
 	else
-		git merge --no-ff -Xsubtree="$arg_prefix" $rev
+		git merge --no-ff -Xsubtree="$arg_prefix" $(gpg_sign_opt) "$rev"
 	fi
 }
 
-- 
2.49.0

