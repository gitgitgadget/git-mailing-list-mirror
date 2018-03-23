Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23EC21F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCWV0C (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:26:02 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36784 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeCWV0A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:26:00 -0400
Received: by mail-pg0-f68.google.com with SMTP id t9so3674969pgo.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=E65gm5Jt8trkLkXNy76UqeoVMnfICiuvI0ADfRj8ZzM=;
        b=MLj5Z3lMqqpEmJryuvt3E2ZzoGq6A+BtZdaRdsSBnU1RIApcUiwtUBsQNmY1ztfMs7
         YZ8MsxHFdk9m7SI0FGUMk6yU6b7DgaBHMDehvHAx0mpZJ2BVX2JP+rYeip6Qy7TdW8Ai
         LyeELoaUJz6DH5q+bK+T0ZMjGPF4PLyklr8iic9iWNx5o97pw7BgTIDVYZT4iw5iTsry
         jELO38WKWufefQY94uMZjbtjXY1P5YrWjXPASZ/Ro57g2Og6818drsHfK1qOsG7EvOCY
         SBjJpSRj4qE7aPRqo3lMOnsZIRv6nHRpmON3A/f5DL/6JzBy2be/S4RCmCdQ4vbj7ljt
         mbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=E65gm5Jt8trkLkXNy76UqeoVMnfICiuvI0ADfRj8ZzM=;
        b=WpvKt0w/0a9X/irYzIDpbeeRNU1SevsqP4ryynhKpf6TVtevafHyalHzpDUjPPGHQN
         inCbp5sdYAYkcXniM0TSKMHseEC38yHUJmPPdeKyZusTQwk2pHNn5O2e+W0ESoe4ylUw
         lR2bx+R9MenGRO2uNvQ81Yj4QsXYiyozT3SMCvcYHY+gwACR4Yi2rZb2O0Jil1tVP9yN
         +BiB3chTIQiUgZP7IPkm6kVee9UHAJb6gJxfzOiZ7AsMuiDl2kC85mRzmq45QSlfWSCF
         VydmDrpzqhIfmAOuYpp7CBbG1Z4rPCihsKUjTkRXADpEERuggv1AE5hRM03+Obdc5MYr
         3n7A==
X-Gm-Message-State: AElRT7FMrael4sBRo2JQR8y770bwumm33grZ3illXj+n9DmKbdBN5TH0
        PKNfF/cg5yMxjURK+B54MKjqWM2htPY=
X-Google-Smtp-Source: AG47ELuJwgld4uPFL1bFJ82r7p8yU/igSYqxmckm5EKQCaO4yM/hVidJKdmEMKKUhmmIOx63TuqZyA==
X-Received: by 10.101.97.88 with SMTP id o24mr5645885pgv.270.1521840359091;
        Fri, 23 Mar 2018 14:25:59 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id z28sm15380096pgc.15.2018.03.23.14.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:25:57 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gister@pobox.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v5 6/8] Remove unused code paths from git_rebase__interactive
Date:   Fri, 23 Mar 2018 14:25:27 -0700
Message-Id: <53cd3da5960a1c99a55959990737ca4d54989659.1521839546.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521839546.git.wink@saville.com>
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since git_rebase__interactive is now never called with
$preserve_merges = t we can remove those code paths.

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 95 ++--------------------------------------------
 1 file changed, 4 insertions(+), 91 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ab5513d80..346da0f67 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -961,100 +961,13 @@ git_rebase__interactive () {
 	setup_reflog_action
 	init_basic_state
 
-	if test t = "$preserve_merges"
-	then
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
-				die "$(gettext "Could not init rewritten commits")"
-		fi
-		# No cherry-pick because our first pass is to determine
-		# parents to rewrite and skipping dropped commits would
-		# prematurely end our probe
-		merges_option=
-	else
-		merges_option="--no-merges --cherry-pick"
-	fi
+	merges_option="--no-merges --cherry-pick"
 
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
-
-			if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
-			then
-				comment_out="$comment_char "
-			else
-				comment_out=
-			fi
-
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
-
-	# Watch for commits that been dropped by --cherry-pick
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
+	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
+	die "$(gettext "Could not generate todo list")"
 
 	complete_action
 }
-- 
2.16.2

