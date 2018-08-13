Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044481F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbeHMWGu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:06:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44167 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeHMWGt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:06:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so15186857wrt.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gad08ztTNtN7venR57GLlOyfwn66glBxqPMqOd2qNvA=;
        b=MwmpMfGw62cMaLs3QG7GSixmuDGDMtjvKTOg332GZqY3iVn5XSojbxV+JdKelRCZxl
         NFWX6JGOdqz3YlEG/Czv5PP0VfJ0SlfLq42xmnDi8gdcQSIcZdPJMMCR5ZmFzjzm6j/l
         QP9xFpvuXgG9bTt1MDAcoJJbatBVkTQT0GJMUhjXqBucXKG/9Lg9RfOq+uTJgZQdZflX
         sQtXNiMoydnarhcRFXsyL9XEfc/2YeOfhbHE0BC4F9yBT6hgdjBGSlWPaGR9nKm7T8qq
         Y5r1RpGati06vuL+MmcdWIIUhNBDMujrSAbI1R/qCyVnKp7NMjrzPDUeBjJUAmuS6Mup
         lk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gad08ztTNtN7venR57GLlOyfwn66glBxqPMqOd2qNvA=;
        b=MKYKXA84bg3VvbyY3Irnzs4tx9+R7uE5FtcuKHXXydbCQEcZtJ+dmhqueMMj4PLXaa
         BKNn51Z7VwMoPsd3JD/UNnJO1628cAruNFU8B8oXaoDuAv/qK9RFJ5/9KLDWJlgpsHlc
         9fBwi7rm1nwWQETrocU4YAouSCW5OUh3ihdSzX2GzNTPCLlLZXc6/IvcIL8MxdRo7aji
         MiYgCu43RoFNq36p5vCuXOAEvn5NTHXOfnZxv4vZsj5gEQ2X4PKMsMJqoB2VYU5r2Up6
         E+0/G8r8wOAO1M8IvzJs9/b7WvjNy/ctsoo6Gr6qH8e90d58+m4qwMHbtkD6MfpSvZ+z
         KvbQ==
X-Gm-Message-State: AOUpUlF9rnNhaYqf0NJ2UKsxy31TOLMrMopLcLoIOY/Eagio/BYIZrBw
        /eWXd/xrFU8l6A8yeT0StOSmNj78
X-Google-Smtp-Source: AA+uWPz5CeNoKalsba4EnTfnbsZI4mkQqLmyAnseY/dmVA1aprdOIJdOvWvoqm6RkBvbA0sh357/OA==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr11803504wrq.61.1534188194203;
        Mon, 13 Aug 2018 12:23:14 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l72-v6sm34929545wma.17.2018.08.13.12.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:23:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/7] fetch tests: correct a comment "remove it" -> "remove them"
Date:   Mon, 13 Aug 2018 19:22:48 +0000
Message-Id: <20180813192249.27585-7-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180731130718.25222-1-avarab@gmail.com>
References: <20180731130718.25222-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a comment referring to the removal of just the branch to also
refer to the tag. This should have been changed in my
ca3065e7e7 ("fetch tests: add a tag to be deleted to the pruning
tests", 2018-02-09) when the tag deletion was added, but I missed it
at the time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 62308be499..fdb73b3971 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -613,7 +613,7 @@ test_configured_prune_type () {
 			git rev-parse --verify refs/tags/newtag
 		) &&
 
-		# now remove it
+		# now remove them
 		git branch -d newbranch &&
 		git tag -d newtag &&
 
-- 
2.18.0.345.g5c9ce644c3

