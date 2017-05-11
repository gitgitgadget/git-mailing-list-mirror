Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2B11FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755204AbdEKJTZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33682 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbdEKJTW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so5502156wmh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUFWKtGTkvuyVDwDO9tW91ONRVXBud0CZDopLHeAz1Y=;
        b=dohpiFA9lY3hQwcbubkmphYjoY9eD1ZABb2o46Kg19Yl8ZjLWuL14Twvpr+9SIMcdy
         4c7LZf1jTalZgjOlCTsYfItMf4fwKDxj5MDj+bEsihFNqui71LSJ4RM1IRJ6IJg/aVR4
         G4PtmEgXGR8oUpydpm63FFHw/bPn7Z0HKinSIYJBAgpOHW+QmDojTLhkTqurk+bIOkM5
         4p68N8Nw0Q9g0aSdCLmKPxLt7hXAvNRHK6pJWlg3rZE8SStTO02GgvdiUly38XO8dy01
         wN/YkYNdPJ4qt4PcRIgMzhFXAKDAeFRervV+fr2TCN4KNNbiNURD1Ou6OxA6Nk6bL2eO
         INAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUFWKtGTkvuyVDwDO9tW91ONRVXBud0CZDopLHeAz1Y=;
        b=QrLfhKLyxNNa5UYCWkB+fpo2SbOiUWyWBhngp580kThJJJUGAHakGCoC7pHLT+cwA5
         v/cAme4UjUbEWk2g/Yd52yp7FrhkrARqLD9OZ0eTrWcE+2hQDWQsgZNMmsZJ/NcI1Pt1
         hpp1eWRnkHo+FdnDGsmFy+DXTN6pjLGxNUcskL0YX2ALPE6e5kyVE8VokKQBq0iFsYnY
         SuTEmsli8eyhVCZbWdOyw+h2GNZGEDy0J7G1/iQXKfuQ87/d3SGbpYYNWpWL0RjPD0II
         4Ofb6JGRDoXYtl+79oYbhqXBzQpAcq8ijvnFqbs2Ch495H/51Flq8Rrp1WTHD1Ev8CDp
         4P2Q==
X-Gm-Message-State: AODbwcBmxi6yyu46i1u+PulazUQztPgZsaMj68/g6FZKsJj/oCIPeaAG
        9NufsXmA8U5amA==
X-Received: by 10.80.205.212 with SMTP id h20mr42485edj.58.1494494349937;
        Thu, 11 May 2017 02:19:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/29] grep: change non-ASCII -i test to stop using --debug
Date:   Thu, 11 May 2017 09:18:07 +0000
Message-Id: <20170511091829.5634-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a non-ASCII case-insensitive test case to stop using --debug,
and instead simply test for the expected results.

The test coverage remains the same with this change, but the test
won't break due to internal refactoring.

This test was added in commit 793dc676e0 ("grep/icase: avoid kwsset
when -F is specified", 2016-06-25). It was asserting that the regex
must be compiled with compile_fixed_regexp(), instead test for the
expected results, allowing the underlying implementation to change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7812-grep-icase-non-ascii.sh | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 04a61cb8e0..969e7c0dda 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -36,29 +36,14 @@ test_expect_success GETTEXT_LOCALE,PCRE 'grep pcre utf-8 string with "+"' '
 '
 
 test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
-	git grep --debug -i -F "TILRAUN: Halló Heimur!"  2>&1 >/dev/null |
-		 grep fixed >debug1 &&
-	test_write_lines "fixed TILRAUN: Halló Heimur!" >expect1 &&
-	test_cmp expect1 debug1 &&
-
-	git grep --debug -i -F "TILRAUN: HALLÓ HEIMUR!"  2>&1 >/dev/null |
-		 grep fixed >debug2 &&
-	test_write_lines "fixed TILRAUN: HALLÓ HEIMUR!" >expect2 &&
-	test_cmp expect2 debug2
+	git grep -i -F "TILRAUN: Halló Heimur!" &&
+	git grep -i -F "TILRAUN: HALLÓ HEIMUR!"
 '
 
 test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
-	test_write_lines "^*TILR^AUN:.* \\Halló \$He[]imur!\$" >file &&
-
-	git grep --debug -i -F "^*TILR^AUN:.* \\Halló \$He[]imur!\$" 2>&1 >/dev/null |
-		 grep fixed >debug1 &&
-	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\Halló \$He\\[]imur!\\\$" >expect1 &&
-	test_cmp expect1 debug1 &&
-
-	git grep --debug -i -F "^*TILR^AUN:.* \\HALLÓ \$HE[]IMUR!\$"  2>&1 >/dev/null |
-		 grep fixed >debug2 &&
-	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\HALLÓ \$HE\\[]IMUR!\\\$" >expect2 &&
-	test_cmp expect2 debug2
+	test_write_lines "TILRAUN: Halló Heimur [abc]!" >file3 &&
+	git add file3 &&
+	git grep --debug -i -F "TILRAUN: Halló Heimur [abc]!" file3
 '
 
 test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
-- 
2.11.0

