Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463DE1F424
	for <e@80x24.org>; Sun,  8 Apr 2018 09:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeDHJfe (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 05:35:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46588 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeDHJfc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 05:35:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1so5304251wrj.13
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MO5s/2hWqIhuYhl/jiRL3UJ6i20KSph867bNXTndvYs=;
        b=qGSDg3xetLBZKZdsiXB8YfHt8FB7rxX0qGxtwHqLO8PIuCQgw2ApEc0GcbU6gNXd0F
         tcxqP4i8BVGlYnJ3UUjyGofUsZc6QoYvzBrfH4c4ScnBksWo+1gmsP1cEPLLIZyTFsJQ
         M4wS3K9WQXUQ9FKS6noehaBsJLYNyKLqd0pTzte5lyX7h4a3oTgR0INK+gJOP25SmwlI
         pab2+5Z30+AQtgPefoXPRgv7uZCS+oetNczIyvXV4KP6L4FZDEGtDwS18OW0NONWGR9R
         iO/xo4792XJS0DsKvdkcFVCOXXJI/1JJI60m2+R9oV9JOuC6j1dwbhKf80TBowg0SsJy
         KcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MO5s/2hWqIhuYhl/jiRL3UJ6i20KSph867bNXTndvYs=;
        b=V3RSiqw3fgtl3pHq89A5KUwRHmt4NK59mZaqC3cUiBKnrovAqxMK7ifA1DeUblzmOw
         IDbD6+HKIWZkevgyFND7n0wtKY1c0G6fmpYtVz0QJGZnoO3uS7CiNVs/dT6ZQ51KW1dN
         pZKYZyXyAoPy9eAFAzrVgr7HFG34mWaoRiViYgXBSnN34Gc1SMxR6g48Q6K8MYxQrTYg
         SxGfJn+xbForUN6qPMUNauAIH8c+E1ZGYLbYTnKSQNVHUIC/9RSPsDKpdDZZpOgqmtzZ
         ArLdE/4/n+UY0Eb9VX/N8t9d+IcqU58oVAA3axuNPaNgG/MFCfu80NfvQQxAYb9ULVfE
         8J1A==
X-Gm-Message-State: AElRT7FW2jN+hxTgqb5s1dPFcct5n2ue0rj/h1D/nNFB/coEqja7tHQh
        72XrHkfU+giosdABVStMByFIq2vK
X-Google-Smtp-Source: AIpwx4+imEwUWAy0C26MyGVRwFC78npi367Ndjnzdfapj8e6dv8YaZMXnU9AZxmM5EtfugUWU79jSg==
X-Received: by 10.223.210.13 with SMTP id g13mr22196802wri.59.1523180131173;
        Sun, 08 Apr 2018 02:35:31 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v75sm13910014wrc.90.2018.04.08.02.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 02:35:30 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 1/2] perf/run: add --subsection option
Date:   Sun,  8 Apr 2018 11:35:12 +0200
Message-Id: <20180408093513.17769-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc1.36.g098d832c9.dirty
In-Reply-To: <20180408093513.17769-1-chriscool@tuxfamily.org>
References: <20180408093513.17769-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option makes it possible to run perf tests as defined
in only one subsection of a config file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 56 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/t/perf/run b/t/perf/run
index 213da5d6b9..9aaa733c77 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -1,21 +1,34 @@
 #!/bin/sh
 
-case "$1" in
+die () {
+	echo >&2 "error: $*"
+	exit 1
+}
+
+while [ $# -gt 0 ]; do
+	arg="$1"
+	case "$arg" in
+	--)
+		break ;;
 	--help)
-		echo "usage: $0 [--config file] [other_git_tree...] [--] [test_scripts]"
-		exit 0
-		;;
+		echo "usage: $0 [--config file] [--subsection subsec] [other_git_tree...] [--] [test_scripts]"
+		exit 0 ;;
 	--config)
 		shift
 		GIT_PERF_CONFIG_FILE=$(cd "$(dirname "$1")"; pwd)/$(basename "$1")
 		export GIT_PERF_CONFIG_FILE
 		shift ;;
-esac
-
-die () {
-	echo >&2 "error: $*"
-	exit 1
-}
+	--subsection)
+		shift
+		GIT_PERF_SUBSECTION="$1"
+		export GIT_PERF_SUBSECTION
+		shift ;;
+	--*)
+		die "unrecognised option: '$arg'" ;;
+	*)
+		break ;;
+	esac
+done
 
 run_one_dir () {
 	if test $# -eq 0; then
@@ -172,9 +185,32 @@ get_subsections "perf" >test-results/run_subsections.names
 
 if test $(wc -l <test-results/run_subsections.names) -eq 0
 then
+	if test -n "$GIT_PERF_SUBSECTION"
+	then
+		if test -n "$GIT_PERF_CONFIG_FILE"
+		then
+			die "no subsections are defined in config file '$GIT_PERF_CONFIG_FILE'"
+		else
+			die "subsection '$GIT_PERF_SUBSECTION' defined without a config file"
+		fi
+	fi
 	(
 		run_subsection "$@"
 	)
+elif test -n "$GIT_PERF_SUBSECTION"
+then
+	egrep "^$GIT_PERF_SUBSECTION\$" test-results/run_subsections.names >/dev/null ||
+		die "subsection '$GIT_PERF_SUBSECTION' not found in '$GIT_PERF_CONFIG_FILE'"
+
+	egrep "^$GIT_PERF_SUBSECTION\$" test-results/run_subsections.names | while read -r subsec
+	do
+		(
+			GIT_PERF_SUBSECTION="$subsec"
+			export GIT_PERF_SUBSECTION
+			echo "======== Run for subsection '$GIT_PERF_SUBSECTION' ========"
+			run_subsection "$@"
+		)
+	done
 else
 	while read -r subsec
 	do
-- 
2.17.0.rc1.36.g098d832c9.dirty

