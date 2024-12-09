Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40E153BFC
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763094; cv=none; b=jWvV1mSp7bu28x8UCqXa3qZ+G4lE0JAMbdyoDutSYsq2VAaC6nbpfxQwk6oixhF0OEJPTZepqM925+lJ9GYtCPeBarMdFB/t/Cc/8lO322kdExRela5SzmfZGfjaT+F5qPd5Y7XOVl66Aof2Siok2L5fpyu3kj6OXWY9ilq9kxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763094; c=relaxed/simple;
	bh=RMBMffDdEdqj8+bhulqeskzLcLyvQFUHieibROZS0t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bb342EXuHBn9ic+q0p1E9sOKoG7ISSMU1IPqQrlGXldnJd1vUqK341em0Fc9lUPfTL/8BDbWac88bI7b/l5ypNhTeGaNZXedHVayDHdH1CJ/OCcvcsL9YOHkHTioijnPQTI58o56PvHKQZbZeIjBKryCPL/+o+eFCDfx2DWmHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5afUC8s; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5afUC8s"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6954ec439so9782666b.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763091; x=1734367891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+bsiR4NaUmzID1amv6uyVGy7kQ7PwgPazZygJy/unE=;
        b=E5afUC8sVft0qe9VWpMz3HfKXMcu3aJJ9TQrcxH4LujTTpZxWQwmM77H5udvaPGm5r
         TViGdBOLYzYEAI81MrBaYP/CyGxj3oysDQrHLMwXyOa6xejouecsgqEHH0jCRORtnGOS
         Txgf6ht+iVr2bUQIyA42WfOAwjg3shgJwqiAdzAiFuujj66qoY1btFuGYIvIZtMBAl9J
         PCjfLTdAUT0mYNkJwRkQfMToy0oFB5r3TdcGhsga2LyMqtNPmtLLnRd2uWnIYPS3sJSH
         yVBFZOww9t23F4HOQWQeNUSqlbRQqMUkZSYEAJcFzfg7cuUPFHR4Lv1XTqKDFPcT9klk
         MKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763091; x=1734367891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+bsiR4NaUmzID1amv6uyVGy7kQ7PwgPazZygJy/unE=;
        b=kOkwvOwPaT7U2vmm7D+OW3osThfIyz7lzP+nFA0suJ4M4iNE09ZOi+P5nMytPAxayc
         HslmctjLfmZhvMSsZc/V0M7ukenpL71tCIz1fkYZ8yan1nDBLxZMq2UybxRtHXjdm7E1
         N1iKJlURJzKfNL9Zp9HtInMTTGBTcnpUaH935ZvbKCtvJ8gjQbTL0ubdqdxkvLSd6iYi
         tzlXt9LlqoL9UXwjvfFlBboYzApDFhiuoksgi7Jctc7IIpZ81mR5+QMwHWTVFVqGtMi7
         vhKTRS+SMp1WrVXYPTvo3aKWTAao5ugLnAXBM253O3+zHK5odFMMfeKTKi9vayLxdV5W
         vKWw==
X-Gm-Message-State: AOJu0YyNVuCT51CQWnaTwxcIVbKiO7B3d6biG+FIjCSJnivT8tyRRzvZ
	k2f5Vln6wOhWM2O0SieKlpIhzR8E3etgHSzfo7bvw8bS4xhvApUTG237Tug2
X-Gm-Gg: ASbGnctyFycK/Ef8Hg29s2yi/PPCOpc0wzYIMnG4LJDzA25GxiJ7J3BUc4L4BQY/QBD
	w/Y/ljRpHEusT14Hawv2Zr6uTaVWhzhkAFCe7gnaDN/WPJ0somVux4n+S5/oMLHsmIC042XWQ6w
	z303OvGmFkr0ucpMkz6MHXVSid9B49h8ZxLGjGYfV37gbJtl1pnUPiax0h0UDtgWv6I743o59cU
	gBHB7hnyz39QlNl9mco3H+4suxEsDBu3wI3/xGcwrKN0/7thtOK6CS1buKLODc=
X-Google-Smtp-Source: AGHT+IF8oYMmZuRsBkFN4nMvqFrx+DGsQbgPBTDgfZ8U6b3qyuU5yExgWOFtsAHYSIo0qHRgt7eLxw==
X-Received: by 2002:a17:907:9694:b0:a9a:410d:f86f with SMTP id a640c23a62f3a-aa69f29c1fbmr14890266b.14.1733763090785;
        Mon, 09 Dec 2024 08:51:30 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm300539766b.102.2024.12.09.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:51:30 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v2 7/8] git-submodule.sh: improve variables readability
Date: Mon,  9 Dec 2024 18:50:08 +0200
Message-Id: <20241209165009.40653-8-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241209165009.40653-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
 <20241209165009.40653-1-royeldar0@gmail.com>
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
 git-submodule.sh | 219 +++++++++++++++++++++--------------------------
 1 file changed, 98 insertions(+), 121 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3b44aeddbf..2da4d55d64 100755
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
+		-b* | --branch*)
+			branch="$1"
 			;;
 		-f | --force)
-			force=1
+			force=$1
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
@@ -230,18 +230,17 @@ cmd_init()
 cmd_deinit()
 {
 	# parse $args after "submodule ... deinit".
-	deinit_all=
 	while test $# -ne 0
 	do
 		case "$1" in
 		-f|--force)
-			force=1
+			force=$1
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
-			force=1
+			force=$1
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
+		-j*|--jobs*)
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
-			files=1
+			files=$1
 			;;
 		--for-status)
-			for_status=1
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

