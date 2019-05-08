Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F8A1F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEHANP (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40728 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfEHANO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so5396808wre.7
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mW95Bixz7bOPz/qmybxKm8FFwa0JVR3RfZw8PN98iV8=;
        b=eDMu7Hc9ymU+KEuK7hb5717ovVp+tViCDzbFVHg5CcsFpPHXYM+++yK/gEu0kU+kVk
         mibXkzYvb1eW4bEgjqdrOVAkWIR1ut6cPLf480VDcJNSgZoifRPjqAfhdD2QC/oNqi7T
         mjhuXKRqrQ2rbZoSulLA/GHy6y6oSj20sjdi6gnLbsshsqzMDNAD8BvDKHqoR7TUl2nQ
         Cpw8nXil/F9EPdf3V4FQvGhfqw+LkuM3Byqu4AN0ZZddWnvavCiBBloqVJBYR62O6Fya
         3USlvq0OEkNuKBcmqFGo7DugJWUwxPunwmAYhmjgyR2SHrmXla+VgD3xe63tUZyCQRzN
         lCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mW95Bixz7bOPz/qmybxKm8FFwa0JVR3RfZw8PN98iV8=;
        b=psJ2PZXpjAZkSq/0j3+V+CFWOjOULwPG9eUwCYH+ArVIvJKoZU5Bg3cvoCRTcr+9Cu
         nYNEy0nP/NUYSGQpHw7W1HqiDuFMZT6CCJgbU0hxkmmKMN3asH79kcTIgsInWNpw75MC
         ORexkxfQeBmuQEmmowyyjcOg5XBnDqw9rQnpRsaBqPv3hOhPrLgqNHGEUhTzKNZA6xVy
         lc6+1kONdf+sHUp8KMeCS0s5Urqo2EfHn2MNPnwWCAvX7RimGX7pkvsZz8pWMWqWfMNV
         0JAtliEEUKO/aR34yUPph2XK8Dx6irEcqbFd8T+8qaR4LE5CurY+vDL9eGwOCR+s2Jde
         DR8g==
X-Gm-Message-State: APjAAAWjfRZk80+KRTGxKORM+UCmY9/WejdU3X5Wr9k5YjXn3tpntHYJ
        mIiTZ5O1a0h03bmpaiBSRmOVGeOTyAA=
X-Google-Smtp-Source: APXvYqwEkE899koDlrxG9mjKLyWMMrT38+Y1DdI4+8l6ax9saundBM2RAZjYirb29UA8o1o7o9gEnw==
X-Received: by 2002:a5d:624d:: with SMTP id m13mr922966wrv.305.1557274392247;
        Tue, 07 May 2019 17:13:12 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC WIP PATCH v8 04/13] t3432: test for --no-ff's interaction with fast-forward
Date:   Wed,  8 May 2019 02:12:43 +0200
Message-Id: <20190508001252.15752-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more stress tests for the can_fast_forward() case in
rebase.c. These tests are getting rather verbose, but now we can see
under --ff and --no-ff whether we skip work, or whether we're forced
to run the rebase.

These tests aren't supposed to endorse the status quo, just test for
what we're currently doing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3432-rebase-fast-forward.sh | 83 ++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index dd51e28b56..e20a8ab9c4 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -16,22 +16,47 @@ test_expect_success setup '
 '
 
 test_rebase_same_head () {
+	status_n="$1" &&
+	shift &&
+	what_n="$1" &&
+	shift &&
+	cmp_n="$1" &&
+	shift &&
+	status_f="$1" &&
+	shift &&
+	what_f="$1" &&
+	shift &&
+	cmp_f="$1" &&
+	shift &&
+	test_rebase_same_head_ $status_n $what_n $cmp_n  "" "$*" &&
+	test_rebase_same_head_ $status_f $what_f $cmp_f " --no-ff" "$*"
+}
+
+test_rebase_same_head_ () {
 	status="$1" &&
 	shift &&
 	what="$1" &&
 	shift &&
 	cmp="$1" &&
 	shift &&
-	test_expect_$status "git rebase $* with $changes is $what" "
+	flag="$1"
+	shift &&
+	test_expect_$status "git rebase$flag $* with $changes is $what with $cmp HEAD" "
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
-		git rebase $* >stdout &&
+		git rebase$flag $* >stdout &&
 		if test $what = work
 		then
+			# Must check this case first, for 'is up to
+			# date, rebase forced[...]rewinding head' cases
 			test_i18ngrep 'rewinding head' stdout
 		elif test $what = noop
 		then
-			test_i18ngrep 'is up to date' stdout
+			test_i18ngrep 'is up to date' stdout &&
+			! test_i18ngrep 'rebase forced' stdout
+		elif test $what = noop-force
+		then
+			test_i18ngrep 'is up to date, rebase forced' stdout
 		fi &&
 		newhead=\$(git rev-parse HEAD) &&
 		if test $cmp = same
@@ -45,32 +70,32 @@ test_rebase_same_head () {
 }
 
 changes='no changes'
-test_rebase_same_head success work same
-test_rebase_same_head success noop same master
-test_rebase_same_head success noop same --onto B B
-test_rebase_same_head success noop same --onto B... B
-test_rebase_same_head success noop same --onto master... master
-test_rebase_same_head success noop same --no-fork-point
-test_rebase_same_head success work same --fork-point master
-test_rebase_same_head failure noop same --fork-point --onto B B
-test_rebase_same_head failure work same --fork-point --onto B... B
-test_rebase_same_head success work same --fork-point --onto master... master
+test_rebase_same_head success work same success work same
+test_rebase_same_head success noop same success noop-force same master
+test_rebase_same_head success noop same success noop-force diff --onto B B
+test_rebase_same_head success noop same success noop-force diff --onto B... B
+test_rebase_same_head success noop same success noop-force same --onto master... master
+test_rebase_same_head success noop same success noop-force same --no-fork-point
+test_rebase_same_head success work same success work same --fork-point master
+test_rebase_same_head failure noop same success work diff --fork-point --onto B B
+test_rebase_same_head failure work same success work diff --fork-point --onto B... B
+test_rebase_same_head success work same success work same --fork-point --onto master... master
 
 test_expect_success 'add work same  to side' '
 	test_commit E
 '
 
 changes='our changes'
-test_rebase_same_head success work same
-test_rebase_same_head success noop same master
-test_rebase_same_head success noop same --onto B B
-test_rebase_same_head success noop same --onto B... B
-test_rebase_same_head success noop same --onto master... master
-test_rebase_same_head success noop same --no-fork-point
-test_rebase_same_head success work same --fork-point master
-test_rebase_same_head failure work same --fork-point --onto B B
-test_rebase_same_head failure work same --fork-point --onto B... B
-test_rebase_same_head success work same --fork-point --onto master... master
+test_rebase_same_head success work same success work same
+test_rebase_same_head success noop same success noop-force same master
+test_rebase_same_head success noop same success noop-force diff --onto B B
+test_rebase_same_head success noop same success noop-force diff --onto B... B
+test_rebase_same_head success noop same success noop-force same --onto master... master
+test_rebase_same_head success noop same success noop-force same --no-fork-point
+test_rebase_same_head success work same success work same --fork-point master
+test_rebase_same_head failure work same success work diff --fork-point --onto B B
+test_rebase_same_head failure work same success work diff --fork-point --onto B... B
+test_rebase_same_head success work same success work same --fork-point --onto master... master
 
 test_expect_success 'add work same  to upstream' '
 	git checkout master &&
@@ -79,11 +104,11 @@ test_expect_success 'add work same  to upstream' '
 '
 
 changes='our and their changes'
-test_rebase_same_head success noop same --onto B B
-test_rebase_same_head success noop same --onto B... B
-test_rebase_same_head failure work same --onto master... master
-test_rebase_same_head failure work same --fork-point --onto B B
-test_rebase_same_head failure work same --fork-point --onto B... B
-test_rebase_same_head failure work same --fork-point --onto master... master
+test_rebase_same_head success noop same success noop-force diff --onto B B
+test_rebase_same_head success noop same success noop-force diff --onto B... B
+test_rebase_same_head failure work same success work diff --onto master... master
+test_rebase_same_head failure work same success work diff --fork-point --onto B B
+test_rebase_same_head failure work same success work diff --fork-point --onto B... B
+test_rebase_same_head failure work same success work diff --fork-point --onto master... master
 
 test_done
-- 
2.21.0.1020.gf2820cf01a

