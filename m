Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC4D1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 00:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932954AbeBMAgM (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 19:36:12 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40526 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932904AbeBMAgL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 19:36:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id v123so13071587wmd.5
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 16:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIk7Sa4isVvs89wRkXPortpsAVVmEjJ3OrzE9JpN7W8=;
        b=cRKWHpQYKB6KyrHKcHW4QH/AzhEciduDyZpYfIceh0J3XPz36KqL9gB4Yz0tKu1yl8
         tD8APEloEEQkwC8qyzbodOnYa1hyWLzZQSOmk6p4g3tHESR/lp4hZspVIH0rim2J1b3x
         FNTWi861OgDviIcrKSHANB1k5GbScSX0Jzs42j0ht4F7SJ1mhKjdcPt/uWpj+mDiBpo1
         3f7SL0EN+HmEUbuIkN2F/Ul97sBiIGANJa5Uu4WJ9QlROYI1Piawsf2g5mtsKhxYcL1m
         L2HhytEt1dlPuYcaAvW3BMhZwspaCvAa2KxDpe34ptdh1bkHVCRfncEHV/jH21VnAPuX
         QZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIk7Sa4isVvs89wRkXPortpsAVVmEjJ3OrzE9JpN7W8=;
        b=n2UFAmK1UbGPWQThhGyi/M2w+hbZMOARgayZ1OfHytqpS7EVU1KwxpcOW7WDhWMLUk
         gQAIA59lGVJLTyxH1Dode4RVqqxFrzfs8QQsgQIq4X3zH3Y0bzqcXTUOeDGUp8aofVdD
         WWzbC7Bo3xF9wEN2zAJSsn2ar8WNvoaZM6Uy7lPJw4LrUTdcg2CpYidS8JL/fv2xuwNr
         TlTXcB2y0+BDC7STkQBKfi1HhNXfaepelJtdZChyiJqGVPyi630Z57AaTAfsmtAStymg
         fwWE+HpVJHzQwy0fB4eFhE6ZLHRHI2G9pJZZSLSQfmEz8cLLiHES7DcaJiKCzOoQj4Yl
         8WpQ==
X-Gm-Message-State: APf1xPC2mS+A6Nq4i8ziPGU1oB/5/9PG5klIm+ERcuwLhsSle7e0VWot
        q3a1Dp8diIZy+bxRW9+gEv8=
X-Google-Smtp-Source: AH8x224KY9xwSQAmZnn3qfniAS+9MD5OLmt3wpg0E/VEew79O7qJgyRapurNJcNvVKpAAOzVFzEgcg==
X-Received: by 10.28.199.201 with SMTP id x192mr219049wmf.45.1518482169942;
        Mon, 12 Feb 2018 16:36:09 -0800 (PST)
Received: from localhost.localdomain (x4db19afd.dyn.telefonica.de. [77.177.154.253])
        by smtp.gmail.com with ESMTPSA id d73sm8484566wma.25.2018.02.12.16.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Feb 2018 16:36:09 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t6300-for-each-ref: fix "more than one quoting style" tests
Date:   Tue, 13 Feb 2018 01:36:01 +0100
Message-Id: <20180213003601.7396-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.181.g4b60b0bfb6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git for-each-ref' should error out when invoked with more than one
quoting style options.  The tests checking this have two issues:

  - They run 'git for-each-ref' upstream of a pipe, hiding its exit
    code, thus don't actually checking that 'git for-each-ref' exits
    with error code.

  - They check the error message in a rather roundabout way.

Ensure that 'git for-each-ref' exits with an error code using the
'test_must_fail' helper function, and check its error message by
grepping its saved standard error.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Those tests were like this since ancient times, c9ecf4f12a
(for-each-ref: Fix quoting style constants., 2007-12-06).


 t/t6300-for-each-ref.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c128dfc579..295d1475bd 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -373,11 +373,8 @@ test_expect_success 'Quoting style: tcl' '
 
 for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
 	test_expect_success "more than one quoting style: $i" "
-		git for-each-ref $i 2>&1 | (read line &&
-		case \$line in
-		\"error: more than one quoting style\"*) : happy;;
-		*) false
-		esac)
+		test_must_fail git for-each-ref $i 2>err &&
+		grep '^error: more than one quoting style' err
 	"
 done
 
-- 
2.16.1.181.g4b60b0bfb6

