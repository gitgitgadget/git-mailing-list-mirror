Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E40C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeCWV0F (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:26:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46755 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752223AbeCWV0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:26:02 -0400
Received: by mail-pf0-f196.google.com with SMTP id z10so5203057pfh.13
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6f2TWRnBQHVjfmIFgBWVRzRunntWMTDZlHLmitTilYk=;
        b=ch0E4jHO5FRn4nWeiUhmscRKVPm2NLnmFjaimW0riqKN9Q4skzqXDXhrqEpcuwkmEA
         ed15TcfgZL7slXG4Yws+70S6kPE/3OoYWmRFwPb2V5MqelTqQX2ixyx0tqexAwmP0aT5
         QbBYgZi5oaqbSAYOiN6nUCFkehjvv6AyhWtaeP8DMjjPfxERzg4FiAaUr6bgRPqrfne8
         SezClYnFbP0iMVYhvJUfPheo71N2opcfNihjsDp4jWvjShK7RV6FC8DTsxk1Id02cyMy
         MbcU0qiDZkTMyh+W94KBFe1t70Cg0xVi+MsHzLac9j990goq6IGzGfA9hbQuazkwpthR
         37fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6f2TWRnBQHVjfmIFgBWVRzRunntWMTDZlHLmitTilYk=;
        b=EQPkZyTxfRGtfBgWC2VWZkl9Oiv3lXUTLMk+0gFZZBZPC3HNZGjae1lI/G02TTFYg9
         r+gjaFOieTN5rf8SS6KKhtjZzWClJV+ACK8qaUYZA1evbStn72oMtLAPsUpL+okH1K7P
         Zrb7pN3kSPFURjlixfRiA/JNvvVAnBh2MIM3Hv7c3KwT5UhioM2p7rEuyU6c3kSFn+YQ
         Q1pNTNwc1Jsm7wEVImqVAV3RG7Ldy6qAFLu7/slR1oTn5BFP/462h0038PoBtG7iTVn0
         uuVxYPjPq9mUzW9CO4YBK0Gi6wPSgoD81reO9ImfSgvwxIys5LSICFDkQg8sblSslY6w
         6UXg==
X-Gm-Message-State: AElRT7GhKexMvfTl5lo1ATduUy4p9yyBJJ5m26pKdFljbqlb3e7pfkpr
        l0r19wV20sqmR7q8iV5Pgq6ia5PvG1g=
X-Google-Smtp-Source: AG47ELsHsfIghbVkogttpwbvA1rvroNgyhKO/JOmjJSLC1Tiu31qCfOqwIGOh5ps3ifjHugn2h7SIA==
X-Received: by 10.99.172.84 with SMTP id z20mr21667699pgn.273.1521840361518;
        Fri, 23 Mar 2018 14:26:01 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id z28sm15380096pgc.15.2018.03.23.14.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:26:00 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gister@pobox.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v5 7/8] Remove unused code paths from git_rebase__interactive__preserve_merges
Date:   Fri, 23 Mar 2018 14:25:28 -0700
Message-Id: <d1e69af862ff0e7a3f04d2c1a73243f5057e804b.1521839546.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521839546.git.wink@saville.com>
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
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

