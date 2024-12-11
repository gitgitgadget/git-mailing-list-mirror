Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AD1C4A20
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898839; cv=none; b=mcO2zfZ3RDirxV97Lpom8jcLPvCj+9KBlkGW15czywsgCSvoTfjtr5tG8ruS95koFLn1lDYitkrxC6rHEBkQi9K+6hBwPCU/5TKRb345xZ8fLTSVPEnlxhb2DqyRAbzmwla+V07uJjSme7oAMEyvIRG9Zzg6ZBocoFqLppnUA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898839; c=relaxed/simple;
	bh=GGd799+/LNobrNpLwNs5jkCyd7WRxjl7+f6FbV+3n08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqTBRdFWnoMNoWuvUo2ivJEvN1B9dFF0FeBFspWGGBRXY0SSmeDTOCw/vthcYwzt5Yho1mV5lebvWafxWrKDUFp8aOEMhkxnsZUGkRU5WM5Xq9lHtRhFUjrPST+215VUvNSLD/lCxAKvWv24MmJjlli2YoxNuelACJyMLzBnCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iandGxlT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iandGxlT"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3d69e5b63so548235a12.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898836; x=1734503636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzJw3fjqDdFMmU02C9GCkslIWKfeWanAnMs1/t22Hl0=;
        b=iandGxlTUHBblbxtDPp0CpcSx4cJ6hz+788YsuiqVSnbiVf0grxL03i9X/wVhw1vap
         KoyOe2hg56NmBNB936MDZq3GQLvmANrOGdffbShPVSsDT4hIOMybXJ+a4NZq/A3dDDJN
         CO0k2wMiq2gjDup/LzaSCoT4U6uxRM787L4aHnAM+cDbIayXskjGu9wlC/TA1Ufd5qDX
         5/AEtKpGGyeb34riHSqULQOktn62RBXGl5zJ/2DHDc/AE+xMWt/yZNt5Kd9Ra2OaPEEY
         7JC+5jNL1RCIEtvw5gn0r4mHR+kUr8aMEWHy10ivyhw5Gtst8CQ/3TcCmXPRgAjhj8EV
         EjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898836; x=1734503636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzJw3fjqDdFMmU02C9GCkslIWKfeWanAnMs1/t22Hl0=;
        b=tZ8DNLOaU7wN4BAWldS75kVc/MOR9l3pQ7lBYQcF0RJD8kytp/caDg8kW4Kr6v70kT
         FCECe/TLppys5y0/Fmi8trKh3Slp95TubHKJ3NzoRPc5OeDJxBXkiNyRhy+GS3RSHmTC
         cHzna2Y+ZS0lE+R0ZrOwnx+rGcJeMx3FVND+DBznJyhqa/avTIFFLtzQp4Fu4OJR8aby
         QiojcFQi9mZbSg6cIE4U5Jwft/Lo3v0ZhqXcvQkvWimmYnRtCaVpQP/YcJtLOYe6J860
         U0qyH9PPADSOearCqzK+tJCAH+GxFNuAWiYWFqB6CGDqx9OfvMbFt2umja4pIwMmt98L
         RJFg==
X-Gm-Message-State: AOJu0YwkMn96/KrshfTl9cyG2uVfXIZaTrNQgI284YCcTcGFYB1UgBhH
	ERhnLB+SVELqn2u5s7euhmUk9icVJaacm3FzPAHv+6NRWUuf0txrbkRnX6Sl
X-Gm-Gg: ASbGnctapcfhaNPOhYBHxlHHxeb72mqqcq7sf7cp8X/bUJbIFkNbt/7VpR22GRt7hD/
	/npyHp21BNGwxe8t9tosqv6eWj92KQm7cdSiKIonsJ+dJds6AEolRngXyUEVkyGs9TujrPMVt6i
	Y+jQJs2Y2CkBXu8Hoc9HobCFt/Cr2LoyB+5nkhE3vzxxWmRIvRLrnhqFKKdsgRr/N+TvzCk3NLW
	mbV9elc6x6QjrfS3YhAQOnN+BIg/vkHmY0nFHV0KtEzLmJdbwMzjw3Rzb9lC/w=
X-Google-Smtp-Source: AGHT+IErjizOg01cCJyEAD/N7Jz3iechG7Eu68hketAQaCUsrRQCFv9ueypb1VwvsNUJcHCPv7J3xw==
X-Received: by 2002:a05:6402:27c8:b0:5d2:d72a:7803 with SMTP id 4fb4d7f45d1cf-5d433096137mr437409a12.4.1733898835848;
        Tue, 10 Dec 2024 22:33:55 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm6875803a12.6.2024.12.10.22.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:33:54 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v4 6/7] git-submodule.sh: improve variables readability
Date: Wed, 11 Dec 2024 08:32:33 +0200
Message-Id: <20241211063234.7610-7-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241211063234.7610-1-royeldar0@gmail.com>
References: <20241210184442.10723-1-royeldar0@gmail.com>
 <20241211063234.7610-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-submodule.sh parses various options and switches, it sets some
variables to values; the variables in turn affect the options given to
git-submodule--helper.

Currently, variables which correspond to switches have boolean values
(for example, whenever "--force" is passed, force=1), while variables
which correspond to options which take arguments have string values that
sometimes contain the option name and sometimes only the option value.

Set all of the variables to strings which contain the option name (e.g.
force="--force" rather than force=1); this has a couple of advantages:
it improves consistency, readability and debuggability.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 213 +++++++++++++++++++++--------------------------
 1 file changed, 95 insertions(+), 118 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ee86e4de46..6df25efc48 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -52,6 +52,10 @@ single_branch=
 jobs=
 recommend_shallow=
 filter=
+deinit_all=
+default=
+summary_limit=
+for_status=
 
 #
 # Add a new submodule to the working tree, .gitmodules and the index
@@ -63,37 +67,33 @@ filter=
 cmd_add()
 {
 	# parse $args after "submodule ... add".
-	reference_path=
 	while test $# -ne 0
 	do
 		case "$1" in
 		-b | --branch)
 			case "$2" in '') usage ;; esac
-			branch=$2
+			branch="--branch=$2"
 			shift
 			;;
-		-b*)
-			branch="${1#-b}"
-			;;
-		--branch=*)
-			branch="${1#--branch=}"
+		-b* | --branch=*)
+			branch="$1"
 			;;
 		-f | --force)
 			force=$1
 			;;
 		-q|--quiet)
-			quiet=1
+			quiet=$1
 			;;
 		--progress)
-			progress=1
+			progress=$1
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
-			reference_path=$2
+			reference="--reference=$2"
 			shift
 			;;
 		--reference=*)
-			reference_path="${1#--reference=}"
+			reference="$1"
 			;;
 		--ref-format)
 			case "$2" in '') usage ;; esac
@@ -104,15 +104,15 @@ cmd_add()
 			ref_format="$1"
 			;;
 		--dissociate)
-			dissociate=1
+			dissociate=$1
 			;;
 		--name)
 			case "$2" in '') usage ;; esac
-			custom_name=$2
+			custom_name="--name=$2"
 			shift
 			;;
 		--name=*)
-			custom_name="${1#--name=}"
+			custom_name="$1"
 			;;
 		--depth)
 			case "$2" in '') usage ;; esac
@@ -120,7 +120,7 @@ cmd_add()
 			shift
 			;;
 		--depth=*)
-			depth=$1
+			depth="$1"
 			;;
 		--)
 			shift
@@ -142,14 +142,14 @@ cmd_add()
 	fi
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add \
-		${quiet:+--quiet} \
-		${force:+--force} \
-		${progress:+"--progress"} \
-		${branch:+--branch "$branch"} \
-		${reference_path:+--reference "$reference_path"} \
+		$quiet \
+		$force \
+		$progress \
+		${branch:+"$branch"} \
+		${reference:+"$reference"} \
 		${ref_format:+"$ref_format"} \
-		${dissociate:+--dissociate} \
-		${custom_name:+--name "$custom_name"} \
+		$dissociate \
+		${custom_name:+"$custom_name"} \
 		${depth:+"$depth"} \
 		-- \
 		"$@"
@@ -168,10 +168,10 @@ cmd_foreach()
 	do
 		case "$1" in
 		-q|--quiet)
-			quiet=1
+			quiet=$1
 			;;
 		--recursive)
-			recursive=1
+			recursive=$1
 			;;
 		-*)
 			usage
@@ -184,8 +184,8 @@ cmd_foreach()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach \
-		${quiet:+--quiet} \
-		${recursive:+--recursive} \
+		$quiet \
+		$recursive \
 		-- \
 		"$@"
 }
@@ -202,7 +202,7 @@ cmd_init()
 	do
 		case "$1" in
 		-q|--quiet)
-			quiet=1
+			quiet=$1
 			;;
 		--)
 			shift
@@ -219,7 +219,7 @@ cmd_init()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init \
-		${quiet:+--quiet} \
+		$quiet \
 		-- \
 		"$@"
 }
@@ -230,7 +230,6 @@ cmd_init()
 cmd_deinit()
 {
 	# parse $args after "submodule ... deinit".
-	deinit_all=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -238,10 +237,10 @@ cmd_deinit()
 			force=$1
 			;;
 		-q|--quiet)
-			quiet=1
+			quiet=$1
 			;;
 		--all)
-			deinit_all=t
+			deinit_all=$1
 			;;
 		--)
 			shift
@@ -258,9 +257,9 @@ cmd_deinit()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit \
-		${quiet:+--quiet} \
-		${force:+--force} \
-		${deinit_all:+--all} \
+		$quiet \
+		$force \
+		$deinit_all \
 		-- \
 		"$@"
 }
@@ -277,31 +276,31 @@ cmd_update()
 	do
 		case "$1" in
 		-q|--quiet)
-			quiet=1
+			quiet=$1
 			;;
 		-v|--verbose)
-			quiet=0
+			quiet=
 			;;
 		--progress)
-			progress=1
+			progress=$1
 			;;
 		-i|--init)
-			init=1
+			init=$1
 			;;
 		--require-init)
-			require_init=1
+			require_init=$1
 			;;
 		--remote)
-			remote=1
+			remote=$1
 			;;
 		-N|--no-fetch)
-			nofetch=1
+			nofetch=$1
 			;;
 		-f|--force)
 			force=$1
 			;;
 		-r|--rebase)
-			rebase=1
+			rebase=$1
 			;;
 		--ref-format)
 			case "$2" in '') usage ;; esac
@@ -320,22 +319,19 @@ cmd_update()
 			reference="$1"
 			;;
 		--dissociate)
-			dissociate=1
+			dissociate=$1
 			;;
 		-m|--merge)
-			merge=1
+			merge=$1
 			;;
 		--recursive)
-			recursive=1
+			recursive=$1
 			;;
 		--checkout)
-			checkout=1
-			;;
-		--recommend-shallow)
-			recommend_shallow="--recommend-shallow"
+			checkout=$1
 			;;
-		--no-recommend-shallow)
-			recommend_shallow="--no-recommend-shallow"
+		--recommend-shallow|--no-recommend-shallow)
+			recommend_shallow=$1
 			;;
 		--depth)
 			case "$2" in '') usage ;; esac
@@ -343,24 +339,18 @@ cmd_update()
 			shift
 			;;
 		--depth=*)
-			depth=$1
+			depth="$1"
 			;;
 		-j|--jobs)
 			case "$2" in '') usage ;; esac
 			jobs="--jobs=$2"
 			shift
 			;;
-		-j*)
-			jobs="--jobs=${1#-j}"
-			;;
-		--jobs=*)
-			jobs=$1
+		-j*|--jobs=*)
+			jobs="$1"
 			;;
-		--single-branch)
-			single_branch="--single-branch"
-			;;
-		--no-single-branch)
-			single_branch="--no-single-branch"
+		--single-branch|--no-single-branch)
+			single_branch=$1
 			;;
 		--filter)
 			case "$2" in '') usage ;; esac
@@ -385,22 +375,21 @@ cmd_update()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
-		${quiet:+--quiet} \
-		${force:+--force} \
-		${progress:+"--progress"} \
-		${remote:+--remote} \
-		${recursive:+--recursive} \
-		${init:+--init} \
-		${nofetch:+--no-fetch} \
-		${rebase:+--rebase} \
-		${merge:+--merge} \
-		${checkout:+--checkout} \
+		$quiet \
+		$force \
+		$progress \
+		$remote \
+		$recursive \
+		$init \
+		$nofetch \
+		$rebase \
+		$merge \
+		$checkout \
 		${ref_format:+"$ref_format"} \
 		${reference:+"$reference"} \
-		${dissociate:+"--dissociate"} \
+		$dissociate \
 		${depth:+"$depth"} \
-		${require_init:+--require-init} \
-		${dissociate:+"--dissociate"} \
+		$require_init \
 		$single_branch \
 		$recommend_shallow \
 		$jobs \
@@ -415,9 +404,6 @@ cmd_update()
 # $@ = requested path
 #
 cmd_set_branch() {
-	default=
-	branch=
-
 	# parse $args after "submodule ... set-branch".
 	while test $# -ne 0
 	do
@@ -426,18 +412,15 @@ cmd_set_branch() {
 			# we don't do anything with this but we need to accept it
 			;;
 		-d|--default)
-			default=1
+			default=$1
 			;;
 		-b|--branch)
 			case "$2" in '') usage ;; esac
-			branch=$2
+			branch="--branch=$2"
 			shift
 			;;
-		-b*)
-			branch="${1#-b}"
-			;;
-		--branch=*)
-			branch="${1#--branch=}"
+		-b*|--branch=*)
+			branch="$1"
 			;;
 		--)
 			shift
@@ -454,9 +437,9 @@ cmd_set_branch() {
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch \
-		${quiet:+--quiet} \
-		${branch:+--branch "$branch"} \
-		${default:+--default} \
+		$quiet \
+		${branch:+"$branch"} \
+		$default \
 		-- \
 		"$@"
 }
@@ -472,7 +455,7 @@ cmd_set_url() {
 	do
 		case "$1" in
 		-q|--quiet)
-			quiet=1
+			quiet=$1
 			;;
 		--)
 			shift
@@ -489,7 +472,7 @@ cmd_set_url() {
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url \
-		${quiet:+--quiet} \
+		$quiet \
 		-- \
 		"$@"
 }
@@ -503,32 +486,26 @@ cmd_set_url() {
 # $@ = [commit (default 'HEAD'),] requested paths (default all)
 #
 cmd_summary() {
-	summary_limit=-1
-	for_status=
-
 	# parse $args after "submodule ... summary".
 	while test $# -ne 0
 	do
 		case "$1" in
 		--cached)
-			cached=1
+			cached=$1
 			;;
 		--files)
-			files="$1"
+			files=$1
 			;;
 		--for-status)
-			for_status="$1"
+			for_status=$1
 			;;
 		-n|--summary-limit)
 			case "$2" in '') usage ;; esac
-			summary_limit="$2"
+			summary_limit="--summary-limit=$2"
 			shift
 			;;
-		-n*)
-			summary_limit="${1#-n}"
-			;;
-		--summary-limit=*)
-			summary_limit="${1#--summary-limit=}"
+		-n*|--summary-limit=*)
+			summary_limit="$1"
 			;;
 		--)
 			shift
@@ -545,10 +522,10 @@ cmd_summary() {
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary \
-		${files:+--files} \
-		${cached:+--cached} \
-		${for_status:+--for-status} \
-		${summary_limit:+-n "$summary_limit"} \
+		$files \
+		$cached \
+		$for_status \
+		${summary_limit:+"$summary_limit"} \
 		-- \
 		"$@"
 }
@@ -569,13 +546,13 @@ cmd_status()
 	do
 		case "$1" in
 		-q|--quiet)
-			quiet=1
+			quiet=$1
 			;;
 		--cached)
-			cached=1
+			cached=$1
 			;;
 		--recursive)
-			recursive=1
+			recursive=$1
 			;;
 		--)
 			shift
@@ -592,9 +569,9 @@ cmd_status()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status \
-		${quiet:+--quiet} \
-		${cached:+--cached} \
-		${recursive:+--recursive} \
+		$quiet \
+		$cached \
+		$recursive \
 		-- \
 		"$@"
 }
@@ -611,11 +588,11 @@ cmd_sync()
 	do
 		case "$1" in
 		-q|--quiet)
-			quiet=1
+			quiet=$1
 			shift
 			;;
 		--recursive)
-			recursive=1
+			recursive=$1
 			shift
 			;;
 		--)
@@ -632,8 +609,8 @@ cmd_sync()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync \
-		${quiet:+--quiet} \
-		${recursive:+--recursive} \
+		$quiet \
+		$recursive \
 		-- \
 		"$@"
 }
@@ -656,10 +633,10 @@ do
 		command=$1
 		;;
 	-q|--quiet)
-		quiet=1
+		quiet=$1
 		;;
 	--cached)
-		cached=1
+		cached=$1
 		;;
 	--)
 		break
-- 
2.30.2

