Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F2261F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCVQ6E (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:58:04 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43272 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeCVQ5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id i9so3490629pgq.10
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=E65gm5Jt8trkLkXNy76UqeoVMnfICiuvI0ADfRj8ZzM=;
        b=C43v7T7U6D+7v63xXhWEf+CCXeMVD4csn6FGVdeV59tMH22xxqHplhY2LqdAkC2GjE
         Vf4BDLzdcK3RCsHcApMk55h20lYOvj9yNuJ7tXR/LX+7ICkLqRGz4c0CHZc+vgzOsZ0s
         gLY6fHvhTVbw7LI9LEJIG9J3Ypub0ZB0nXPBCP3rist9CNj9FNTAoggoXGWJW63aGG+3
         eIL9F19l7pW4yhAr9qfjWXJtbn/qPmLDTvQGxIcGIzXzQDVp9+EadKxo7gx5VCCOERVJ
         sgjR7GRta9zbIRNZvw6U8VKcp3SgYR9X+hQDn8CzS91nHda3ktrf8opQHaHGdIA2S+ou
         o5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=E65gm5Jt8trkLkXNy76UqeoVMnfICiuvI0ADfRj8ZzM=;
        b=BonacTrvr6rCcDD6L2znJOcFTMHtafg0++DJwUEeLvr/dXJLHWodiqOb2RaftgFs2z
         ic2Yq+bZOe/e2zgkJIUjZATv5RGqfXpM4IC3D4wEdIrbApkt95IWCnoHp3b5F8uZBWo/
         L/ljR86z7jYBjt//yH9hnMX9LYzbVIcErGweTaSeRq4jEPQ+hIWeK/vDwzLSzFt7t0cs
         eOQ9Lgjgr4YkLNffGDjt4xw9IaNytZ/OAsbKjaV+L7nKsznkSmBWpy/PXA3sgyjrcPpJ
         GVZLcOCq3Jd5K1ggQ2KnLAh/UYVRlj5a+uov9emTQg0OwCmpT+w1jaUh+E8KMhU49Nj6
         kBzQ==
X-Gm-Message-State: AElRT7FOl6OwWfYl4uYx/wkLtMY5LKaOIHasDgG7ia4LIA+BC/7RGVYW
        IzlflyzPtvhVcLjAn6h2V46gKSKd0bM=
X-Google-Smtp-Source: AG47ELucvDa+2gS83zEKLvrZITna7WrYVaZB30RYm6PeJnDv3x33KkMZYqdmJqif1PgUTLaeydyCaw==
X-Received: by 10.98.14.215 with SMTP id 84mr16765611pfo.168.1521737871860;
        Thu, 22 Mar 2018 09:57:51 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:50 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 7/9] Remove unused code paths from git_rebase__interactive
Date:   Thu, 22 Mar 2018 09:57:27 -0700
Message-Id: <f8acfb100bc65009843605b4ee24c39decea7ea0.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
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

