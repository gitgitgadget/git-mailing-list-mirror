Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853C71F461
	for <e@80x24.org>; Sun, 30 Jun 2019 18:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfF3SS6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 14:18:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46108 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF3SS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 14:18:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so11281393wrw.13
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtJV3qrcHPMwL9nKrWWkml2fWtZa5GMyNRvH2/34jYo=;
        b=BZMZrsljRM5SoL4oui1YaOTC+Lg56uAJhxK3+yxbz9m0hR9cMfASvEYmk2xaNPxDPR
         96MEAxc/VRzb/jDJsKPSI7F9mCemEBTs+Yj5jWznjWqFiSj+sabKtbCqYRSzIewKS+nJ
         g5ZsDw2XkARwAMQM0BFnAFMWUCa72MaQ3tn/TeTwFAma22k7r7g0PUwLN3egmYx2Ih8a
         5Jr1NMbMQsZrRNoYM2yEb+m8FL3YCBQTHidDqQb4GNCqfV1LRLYgTHSzAG0bK7+47FGg
         XhNiTE7KEvcfFdt1EdaKp/KGjb0311WOG7clZbKXaTzIfNc2LW/efuNgm5l8n0esUF/Z
         imow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CtJV3qrcHPMwL9nKrWWkml2fWtZa5GMyNRvH2/34jYo=;
        b=Dh3G2jsTajEK/KloSs6X3xSsI5nkdxT4LyUraQrPhWpi7I5qy3Xg1Cf/XOfpWrZHQC
         CWd5XWfJl8O88GEi3HU/jJytaphy6fJiCNZfs3jh1Zp4Fgl04a/aJTgQRHF54ZHB/axG
         TsQX1tMCggxstMJG/g5IORoXKaX6VMXwW6VFj7TYoSQlNA0wK+E37bX6263hc5oWRJfu
         72A26yqBx3QLjWE644NuLZTkQhjxxNKds6MXANhh0m7f4V8fYqSsiPS3oLsQcyS2e3bW
         9I9mR6XRwETvqI5Ucrhw4npm7CjMIiCwWL+X1xhyaJKm3taiZirZY5YQCTviajnBCFUc
         8urA==
X-Gm-Message-State: APjAAAWgjGVx7sqKGsf0zPxLT8kLBEApHaqcS8mrjRQQiPmFq3JfwVTv
        5AGiy1RGfvZHttzSFHrXm967BVxWLTuEkg==
X-Google-Smtp-Source: APXvYqyIIxvdwlQJasQw7NWoWoskYEhEzaFjaYHtf1BnAdVZVyfYWbnB70sBOMJVb84VE0NDbhU5aw==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr14664594wrv.19.1561918736010;
        Sun, 30 Jun 2019 11:18:56 -0700 (PDT)
Received: from localhost.localdomain (cpc91214-cmbg18-2-0-cust207.5-4.cable.virginm.net. [81.102.75.208])
        by smtp.gmail.com with ESMTPSA id x17sm5974911wrq.64.2019.06.30.11.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Jun 2019 11:18:55 -0700 (PDT)
From:   michael@platin.gs
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Michael Platings <michael@platin.gs>
Subject: [PATCH] t8014: remove unnecessary braces
Date:   Sun, 30 Jun 2019 19:17:32 +0100
Message-Id: <20190630181732.4128-1-michael@platin.gs>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190629171954.GG21574@szeder.dev>
References: <20190629171954.GG21574@szeder.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Platings <michael@platin.gs>

Signed-off-by: Michael Platings <michael@platin.gs>
---
 t/t8014-blame-ignore-fuzzy.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 6f1a94caef..6e61882b6f 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -298,28 +298,28 @@ EOF
 last_test=13
 
 test_expect_success setup '
-	{ for i in $(test_seq 2 $last_test)
+	for i in $(test_seq 2 $last_test)
 	do
 		# Append each line in a separate commit to make it easy to
 		# check which original line the blame output relates to.
 
 		line_count=0 &&
-		{ while IFS= read line
+		while IFS= read line
 		do
 			line_count=$((line_count+1)) &&
 			echo "$line" >>"$i" &&
 			git add "$i" &&
 			test_tick &&
 			GIT_AUTHOR_NAME="$line_count" git commit -m "$line_count"
-		done } <"a$i"
-	done } &&
+		done <"a$i"
+	done &&
 
-	{ for i in $(test_seq 2 $last_test)
+	for i in $(test_seq 2 $last_test)
 	do
 		# Overwrite the files with the final content.
 		cp b$i $i &&
 		git add $i
-	done } &&
+	done &&
 	test_tick &&
 
 	# Commit the final content all at once so it can all be
-- 
2.21.0

