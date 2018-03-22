Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B031F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeCVQ57 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:57:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33362 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeCVQ5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:55 -0400
Received: by mail-pl0-f66.google.com with SMTP id c11-v6so5689111plo.0
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6f2TWRnBQHVjfmIFgBWVRzRunntWMTDZlHLmitTilYk=;
        b=hsxYhnP6lBm3csFwgYxX1Gm6ZYnyCz7atXEptYbb1mTonRKw9xyZUD7QkiSrMH3aN/
         vEjzXmRkRMKFU0dYTHkpD3nCDs2YGA/xt+Tpmy0BidrS85q6uodEEGZM5BPssybwUE7g
         WvUsd82V4xNgkcghc4D4XvM/o2fDzrKU3hN+LlICLfiEPseAIGF2hsjP+bNyCVjuezYE
         yJg6LBb/HOgtM8jhZB2K3OBKDuoveSqj0skz8pJ1keQw1k+D9FWSwgKfWtXtxcUn2uuE
         XZofPCN0qhj+l3l1wInlY/F4bxEh2BAkNEaiIIOtAAx7wk2OpYPHaZHdX5PfdqnbDKUP
         kIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6f2TWRnBQHVjfmIFgBWVRzRunntWMTDZlHLmitTilYk=;
        b=CE/ZkK8NCrE6TH125FpnNxtYzsnIq7db1hFMoXrO/NR91TktwkSomKdI2WuQ8HtpIV
         jaekX5OqPxsMyiCMUAXDdn6pMVcXoNebhb7ZSnAqnZxN0OdxtKL6OltpjtJWFu84iGtJ
         FJcKNABsVVWtKaGuiq/7Ful7VfYv00nB6DNpDueehK+nJaIUC99PD6IidGaoFmlsSZ/j
         164dXlphiNZbATmGvEzbkH6QRM/uC8IERYUVNYZX2ckYrXdPoAwsbew4NnU2MYr2wwjK
         0z8UGpc1m5hNzKNFyjedO1T/jdFafJAOyhuvVNNZUgs+aWLcxpdnk18QEiR7LO1lXH69
         1j+A==
X-Gm-Message-State: AElRT7GkLPuITJoRwwfphgb87QGWuSo9sTtB3g7JuUw7emS5Nmr+PBkF
        /ONhMyxX8/nwMlBp4Y/OeqlXow08Aus=
X-Google-Smtp-Source: AG47ELt+8ObF05SAIgpv4jB9QUzpqjg72/lYTX0VT+UYmx7VaLG+Ns2good5Qa9G0vj7DDsBJcBn6w==
X-Received: by 2002:a17:902:3181:: with SMTP id x1-v6mr8366816plb.2.1521737873953;
        Thu, 22 Mar 2018 09:57:53 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:52 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 8/9] Remove unused code paths from git_rebase__interactive__preserve_merges
Date:   Thu, 22 Mar 2018 09:57:28 -0700
Message-Id: <83c4c853725abd80b0f3db9ea4eff4fdfde7634f.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since git_rebase__interactive__preserve_merges is now always called with
$preserve_merges = t we can remove the unused code paths.

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 152 ++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 83 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 346da0f67..ddbd126f2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -982,100 +982,86 @@ git_rebase__interactive__preserve_merges () {
 	setup_reflog_action
 	init_basic_state
 
-	if test t = "$preserve_merges"
+	if test -z "$rebase_root"
 	then
-		if test -z "$rebase_root"
-		then
-			mkdir "$rewritten" &&
-			for c in $(git merge-base --all $orig_head $upstream)
-			do
-				echo $onto > "$rewritten"/$c ||
-					die "$(gettext "Could not init rewritten commits")"
-			done
-		else
-			mkdir "$rewritten" &&
-			echo $onto > "$rewritten"/root ||
+		mkdir "$rewritten" &&
+		for c in $(git merge-base --all $orig_head $upstream)
+		do
+			echo $onto > "$rewritten"/$c ||
 				die "$(gettext "Could not init rewritten commits")"
-		fi
-		# No cherry-pick because our first pass is to determine
-		# parents to rewrite and skipping dropped commits would
-		# prematurely end our probe
-		merges_option=
+		done
 	else
-		merges_option="--no-merges --cherry-pick"
+		mkdir "$rewritten" &&
+		echo $onto > "$rewritten"/root ||
+			die "$(gettext "Could not init rewritten commits")"
 	fi
 
+	# No cherry-pick because our first pass is to determine
+	# parents to rewrite and skipping dropped commits would
+	# prematurely end our probe
+	merges_option=
+
 	init_revisions_and_shortrevisions
 
-	if test t != "$preserve_merges"
-	then
-		git rebase--helper --make-script ${keep_empty:+--keep-empty} \
-			$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
-		die "$(gettext "Could not generate todo list")"
-	else
-		format=$(git config --get rebase.instructionFormat)
-		# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
-		git rev-list $merges_option --format="%m%H ${format:-%s}" \
-			--reverse --left-right --topo-order \
-			$revisions ${restrict_revision+^$restrict_revision} | \
-			sed -n "s/^>//p" |
-		while read -r sha1 rest
-		do
+	format=$(git config --get rebase.instructionFormat)
+	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
+	git rev-list $merges_option --format="%m%H ${format:-%s}" \
+		--reverse --left-right --topo-order \
+		$revisions ${restrict_revision+^$restrict_revision} | \
+		sed -n "s/^>//p" |
+	while read -r sha1 rest
+	do
 
-			if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
-			then
-				comment_out="$comment_char "
-			else
-				comment_out=
-			fi
+		if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
+		then
+			comment_out="$comment_char "
+		else
+			comment_out=
+		fi
 
-			if test -z "$rebase_root"
-			then
-				preserve=t
-				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
-				do
-					if test -f "$rewritten"/$p
-					then
-						preserve=f
-					fi
-				done
-			else
-				preserve=f
-			fi
-			if test f = "$preserve"
-			then
-				touch "$rewritten"/$sha1
-				printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
-			fi
-		done
-	fi
+		if test -z "$rebase_root"
+		then
+			preserve=t
+			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
+			do
+				if test -f "$rewritten"/$p
+				then
+					preserve=f
+				fi
+			done
+		else
+			preserve=f
+		fi
+		if test f = "$preserve"
+		then
+			touch "$rewritten"/$sha1
+			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
+		fi
+	done
 
 	# Watch for commits that been dropped by --cherry-pick
-	if test t = "$preserve_merges"
-	then
-		mkdir "$dropped"
-		# Save all non-cherry-picked changes
-		git rev-list $revisions --left-right --cherry-pick | \
-			sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
-		# Now all commits and note which ones are missing in
-		# not-cherry-picks and hence being dropped
-		git rev-list $revisions |
-		while read rev
-		do
-			if test -f "$rewritten"/$rev &&
-			   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
-			then
-				# Use -f2 because if rev-list is telling us this commit is
-				# not worthwhile, we don't want to track its multiple heads,
-				# just the history of its first-parent for others that will
-				# be rebasing on top of it
-				git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
-				sha1=$(git rev-list -1 $rev)
-				sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
-				rm "$rewritten"/$rev
-			fi
-		done
-	fi
+	mkdir "$dropped"
+	# Save all non-cherry-picked changes
+	git rev-list $revisions --left-right --cherry-pick | \
+		sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
+	# Now all commits and note which ones are missing in
+	# not-cherry-picks and hence being dropped
+	git rev-list $revisions |
+	while read rev
+	do
+		if test -f "$rewritten"/$rev &&
+		   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
+		then
+			# Use -f2 because if rev-list is telling us this commit is
+			# not worthwhile, we don't want to track its multiple heads,
+			# just the history of its first-parent for others that will
+			# be rebasing on top of it
+			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
+			sha1=$(git rev-list -1 $rev)
+			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
+			rm "$rewritten"/$rev
+		fi
+	done
 
 	complete_action
 }
-- 
2.16.2

