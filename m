Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D635920248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfDQKY4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:24:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33505 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQKY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:24:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so31255350wrp.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=+KODscbYO1gGml6B0XfUizVXSk+DhqO7h8dzbbx0Hug=;
        b=VwYqgzwLlvsBT3Srx+jCKRCVGndba+wY5Xl1Fy030Tgfh6dFGJbCPXwMOUXCXz9Pko
         LPFWeXPUryNoy1yd4tYieQDdsb4ZDIVg3zb2BHB0NH64oIOKqomfH3NROzSySSCcq1TT
         HbN5yBNSjFltSKJFdMUM5pebP9MgYh/mGYOmgaJC3ukse2Hfm1qb/AbVrVU/zBMOfkO3
         nMs165xnbd1uqCuzsfMBPG67KSJwiMUdWoL8G1iQKlp2Zwr3QDToronCJWBmszRtOHgj
         JkmoUUqwhzAZT8l5Goo5kdFeghahNziywsM+uSBmdz8YA2kBYelR1h88sHtdSYfXDb37
         e7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=+KODscbYO1gGml6B0XfUizVXSk+DhqO7h8dzbbx0Hug=;
        b=S41pYCm/IqFM1fSpKR8MwrbzS51yXAvUW8TsP+N2SEZhC05fXWkB0bv3E8/lxAGMOQ
         AAytZzcArHymg7/CtOhjLim9OWCdLrmGLKYWvp8ezocP7YIKQ+8Hxz2+dsC4jJ+Td70r
         F8wWstKeU6ZkmQHpubMCCd6zyaNOchDHIIjUMOCIC55QETkqr/kEe/hOpVmb2tVO3gMs
         C1tnu4OLv/eI6UP4JWg8GnJkUeqUUpbg0i/0BF+fu8lyxiyQX8gYkEYox7XonZPOVPva
         QEBjdyKXVMbDhOpoXl14/yWzdNTuLbrQYmHEy2JI2t3MnCcQtjoXCRnjWqb/UA3TwrnW
         CDfw==
X-Gm-Message-State: APjAAAXQ2qQm2rAqlABNlK9Y+nG0w/DfuDQpU0/S1XUyOf6mX2N70Uw7
        WDEeeLjsBqYcKN1KWJOuenVGQ2WH7/I=
X-Google-Smtp-Source: APXvYqy67HxZb17lkNGyRljqvhc8isTumKEsIvsW2TUxLneptN+de9BXB/Dm0pR2QJOT/cDO7NyuKA==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr57610723wrr.190.1555496694623;
        Wed, 17 Apr 2019 03:24:54 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:24:53 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v10 01/10] t7600: clean up style
Date:   Wed, 17 Apr 2019 11:23:21 +0100
Message-Id: <20190417102330.24434-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

Clean up the 'merge --squash c3 with c7' test by removing some
unnecessary braces and removing a pipe.

Also, generally cleanup style by unindenting a here-doc, removing stray
spaces after a redirection operator and allowing sed to open its own
input instead of redirecting input from the shell.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7600-merge.sh | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..2f4c2801fb 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -233,17 +233,16 @@ test_expect_success 'merge --squash c3 with c7' '
 	cat result.9z >file &&
 	git commit --no-edit -a &&
 
-	{
-		cat <<-EOF
-		Squashed commit of the following:
+	cat >expect <<-EOF &&
+	Squashed commit of the following:
 
-		$(git show -s c7)
+	$(git show -s c7)
 
-		# Conflicts:
-		#	file
-		EOF
-	} >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
 	test_cmp expect actual
 '
 
@@ -680,10 +679,10 @@ cat >editor <<\EOF
 (
 	echo "Merge work done on the side branch c1"
 	echo
-	cat <"$1"
+	cat "$1"
 ) >"$1.tmp" && mv "$1.tmp" "$1"
 # strip comments and blank lines from end of message
-sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > expected
+sed -e '/^#/d' "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' >expected
 EOF
 chmod 755 editor
 
@@ -768,14 +767,14 @@ test_expect_success 'set up mod-256 conflict scenario' '
 	git commit -m base &&
 
 	# one side changes the first line of each to "master"
-	sed s/-1/-master/ <file >tmp &&
+	sed s/-1/-master/ file >tmp &&
 	mv tmp file &&
 	git commit -am master &&
 
 	# and the other to "side"; merging the two will
 	# yield 256 separate conflicts
 	git checkout -b side HEAD^ &&
-	sed s/-1/-side/ <file >tmp &&
+	sed s/-1/-side/ file >tmp &&
 	mv tmp file &&
 	git commit -am side
 '
@@ -814,7 +813,7 @@ EOF
 test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue' '
 	git reset --hard c0 &&
 	! "$SHELL_PATH" -c '\''
-	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  echo kill -TERM $$ >>.git/FAKE_EDITOR
 	  GIT_EDITOR=.git/FAKE_EDITOR
 	  export GIT_EDITOR
 	  exec git merge --no-ff --edit c1'\'' &&
-- 
2.21.0

