Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285791F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeIRDQG (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:16:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35907 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbeIRDQF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:16:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id j192-v6so285900wmj.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHTy7sYfgj1z0VGG0qPm6khdm4dSvN0GOye07kSaYL4=;
        b=tCWRCb6hXp6xz9Lo2e1kVegnNqhrjAZdTkQ68Br/ysuwJwzmswEnA4RdCQcGhA4Pgf
         p3X7GdEPMGtjQoEZJ5htA7FWCzKszU7ooaVsgvsoIBlaMHZUW6f+yQ3nnQInorENXPs9
         /ADq0rVj5TxNAwVlKz0gdaCcDHf4jsG14X1pSIi81aDDw9jkVTZ6UBjZRpX9r5GifzOB
         YxYfh/VQOlbNiVrEW3Hu25DbjVYya1yA8Wt4O3hm5Uc3dV9dlKRRFagKPH68R6nCQ8R2
         rbfGq2Zg2rVY/t8dhQUxPWQA1ZWefdHUzOz40EMKpfEtaTkTpgaoeCH97FnHCqVG4t1v
         pYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHTy7sYfgj1z0VGG0qPm6khdm4dSvN0GOye07kSaYL4=;
        b=nL/IW8utCMR2R2X3HaZ9SWRBroA/rGjx4o6n4SvlR4gNmkT2L7o7p16GoBtb2kD02z
         yB7+PjK64yiqt+K2s+d+ciKz5V/YWxmcujKvVJCW2/VN5XqXN7o4AOWOAi/UPBdHkjSe
         mcetGHROuUhSPMoADaOP3TE2diSMmFLYnxMdk4Xl/L6JoDE4eAde4+02jXO5snMv1ouM
         YaHpeDoDuQwPtAyFpjmj3ku191A1x/i50SgA0qaGNNkDKXZA5yYhvEpCzxJtR4sVG9c5
         jhuHY61IQVrBb0CP/+7gsuDMHaKJxD5ggwqN6dSPcU98D24e2NpiGkWQyRx9v909iJ/r
         MJtg==
X-Gm-Message-State: APzg51Di1Q6nYNB8umhFGmo9+bX3dRo5P1HXa0pIb3Vewur3CjgwquCQ
        x6beVi/R2dQGxoKw2iPJcavebLTu
X-Google-Smtp-Source: ANB0VdanZ/5zt58mxnvZSkupYFmeak8ytZ08RdrVrTFQ3IpqE+m19eqCwpQ8kdUriBRn0/dNtKnZaA==
X-Received: by 2002:a1c:dd05:: with SMTP id u5-v6mr13372413wmg.107.1537220812265;
        Mon, 17 Sep 2018 14:46:52 -0700 (PDT)
Received: from localhost ([2.28.194.193])
        by smtp.gmail.com with ESMTPSA id a203-v6sm172066wmh.31.2018.09.17.14.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 14:46:51 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/2] t5551: compare sorted cookies files
Date:   Mon, 17 Sep 2018 22:46:28 +0100
Message-Id: <20180917214628.28325-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef
In-Reply-To: <20180917214628.28325-1-t.gummerer@gmail.com>
References: <20180917191806.19958-1-t.gummerer@gmail.com>
 <20180917214628.28325-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t5551 we check that we save cookies correctly to a file when
http.cookiefile and http.savecookies are set.  To do so we create an
expect file that expects the cookies in a certain order.

However after e2ef8d6fa ("cookies: support creation-time attribute for
cookies", 2018-08-28) in curl.git (released in curl 7.61.1) that order
changed.

We document the file format as "Netscape/Mozilla cookie file
format (see curl(1))", so any format produced by libcurl should be
fine here.  Sort the files, to be agnostic to the order of the
cookies, and make the test pass with both curl versions > 7.61.1 and
earlier curl versions.

Reported-by: Todd Zullinger <tmz@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t5551-http-fetch-smart.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 71535631d3..3dc8f8ecec 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -207,7 +207,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	cat >cookies.txt <<-\EOF &&
 	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
 	EOF
-	cat >expect_cookies.txt <<-\EOF &&
+	sort >expect_cookies.txt <<-\EOF &&
 
 	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
 	127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
@@ -215,7 +215,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
 	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
-	tail -3 cookies.txt >cookies_tail.txt &&
+	tail -3 cookies.txt | sort >cookies_tail.txt &&
 	test_cmp expect_cookies.txt cookies_tail.txt
 '
 
-- 
2.19.0.444.g18242da7ef

