Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A7B1FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 08:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753817AbdBDIAs (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 03:00:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35421 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbdBDIAr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 03:00:47 -0500
Received: by mail-pg0-f67.google.com with SMTP id 204so4002576pge.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 00:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9mThGfZAX9RAKgA361tpxadavhno//i2YEss5gqIWK0=;
        b=VIuzV7nlU5G+ZMabzeBHq/ASXNpzdzXi3PXN7lvzlhAD9s2utgjVK94CZy33Jbh16e
         ubXNBVWRGr02S7xNZvhqoRsq+ioJvp0P2yP/kOSU9t927voZh69k2YCvexg+2QPfmV9a
         ivCj13Ca2RIxU/dSicmAmDVBO4lQAwB4wTCuEpA7ssBDg5yEafhIINnP5umZsaby434f
         S1FkjPH3Qv8qZSWqTPkmzGwOABmJqSWxRKYrzlAwGiWpYM0qsaS5if/I0aTd3O2OwSBT
         uz7hKKjQrGfSiEMOIXJLqoz+yiGB9KwB7a7PejFdv0Cp956LMsWU9cnxp8/3ys8VNlsu
         3yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9mThGfZAX9RAKgA361tpxadavhno//i2YEss5gqIWK0=;
        b=M+KZa0HnJL38T3f34xo8GRlHrorLexfH/FM2cyTi+eFOKZ/sxm1BjrVX0+d/U07iiW
         jZYVFVa45O9xq/M8D+SdNMdViLnT7gHfzORmt7zdgSqmg7LDy5xJxEUjkAAhud/xgMY8
         SyplKp2ZZwo3VoJa2BvC4SdPwi0nVnNmMRblgcdEmFsvRULzKDJZGm5YxzHpVktLhtVa
         Wfa8w3l0eqh+k19MPOHP0UF89tTc2P1cqHUaufmQoIUxE2j78VxWG4PQxCCRNFOk2+4g
         eJoNbn34KjiXZldI0ETvC8PL3sK2Ay+Igw0H/hC2uVPYOcgdw74ZKmctWgE0Kiv1n7Wt
         KxTQ==
X-Gm-Message-State: AIkVDXL9uOQRXC1wATXozjgxKyPRS93KN3WXTdLNpDebXys6Cu1zpuzzHcJHzd74YotHfA==
X-Received: by 10.84.231.205 with SMTP id g13mr1754084pln.118.1486195246588;
        Sat, 04 Feb 2017 00:00:46 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id k76sm72548487pfg.42.2017.02.04.00.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Feb 2017 00:00:46 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     pranit.bauva@gmail.com,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH v2] parse-remote: Remove reference to unused op_prep
Date:   Sat,  4 Feb 2017 08:00:04 +0000
Message-Id: <1486195204-26901-1-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error_on_missing_default_upstream helper function learned to
take op_prep argument with 15a147e618 ("rebase: use @{upstream}
if no upstream specified", 2011-02-09), but as of 045fac5845
("i18n: git-parse-remote.sh: mark strings for translation",
 2016-04-19), the argument is no longer used.  Remove it.

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
Thanks a lot, Pranit and Junio for your reviews on the first version of this
patch. I have changed the messages accordingly.

 contrib/examples/git-pull.sh | 2 +-
 git-parse-remote.sh          | 3 +--
 git-rebase.sh                | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
index 6b3a03f..1d51dc3 100755
--- a/contrib/examples/git-pull.sh
+++ b/contrib/examples/git-pull.sh
@@ -267,7 +267,7 @@ error_on_no_merge_candidates () {
 		echo "for your current branch, you must specify a branch on the command line."
 	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
 		. git-parse-remote
-		error_on_missing_default_upstream "pull" $op_type $op_prep \
+		error_on_missing_default_upstream "pull" $op_type \
 			"git pull <remote> <branch>"
 	else
 		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index d3c3998..9698a05 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -56,8 +56,7 @@ get_remote_merge_branch () {
 error_on_missing_default_upstream () {
 	cmd="$1"
 	op_type="$2"
-	op_prep="$3" # FIXME: op_prep is no longer used
-	example="$4"
+	example="$3"
 	branch_name=$(git symbolic-ref -q HEAD)
 	display_branch_name="${branch_name#refs/heads/}"
 	# If there's only one remote, use that in the suggestion
diff --git a/git-rebase.sh b/git-rebase.sh
index 04f6e44..b89f960 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -448,7 +448,7 @@ then
 		then
 			. git-parse-remote
 			error_on_missing_default_upstream "rebase" "rebase" \
-				"against" "git rebase $(gettext '<branch>')"
+				"git rebase $(gettext '<branch>')"
 		fi
 
 		test "$fork_point" = auto && fork_point=t
-- 
2.1.4

