Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C626B1F4B7
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfFYNlJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46257 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfFYNlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so27161751edr.13
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYCstU0Bggt562mLgs8/RcIkj1w9HUhQa5RxlH4Ebtw=;
        b=R6lY8vnWMXXJYVP31VdfOvb/2lEQGMrbdwpQ0Nis9gP8zaZOSmlQ2DaQYiMalqT0dF
         1I/e1+tlOlyLibQLrMGBhAMvdBYmk5O5ouQC2KCrf12EKCagpFffQRRpLnN0nyUaXBhn
         hWX+O4y7VUBcx4ZknEzf4N3TjBFNk4gDufCb82rMXoRKAMsx0XBMXlAXuzd5YSv6sJRN
         XocddED1XfSs9m/I6pGpa4QGNVJMgJiNvNsfCB8S113sCqeQx1eAeU4ar5WvBVJE6YCr
         QMMsW1R/chc2WLcxjqvlLaoM+zJ26EUodcxXblAwPFFzBy4NKlVw98dkm9YrXg+aJ++H
         NTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYCstU0Bggt562mLgs8/RcIkj1w9HUhQa5RxlH4Ebtw=;
        b=d3E2EEJLk4l97IZz/iZD4I0ZYQRU0AYibonahvNPrO7S6gmaAYxJ7GMcDC5phP5O69
         Giv0TlhuSG9CympoKVc/ALkTvDIO2zi1LslQUiNN1XHhnqIuxvxoTscA6c4pgEOIa05n
         lSWiRii+Suy8qdGnPkbUJKNuOFq6+hQBJv6zenWLSRU3Lv+cVvMtVuzYfS1DuxqPCbRH
         aw83/BZGuc2nzhaVpUU5aulf5yA1zr4zp54UsgrXhJ+/eCnbU7E3Scvv2ZTD3GGUd2ZR
         ZDU1T5mYU0F85N6FnwFGoPorf3Mr//8FlYY4mNzU7z1Jprr3LeFZnvIcGUUB8kuinlQu
         J/ow==
X-Gm-Message-State: APjAAAWNjjtFVJ3JFdBjnAtPuaMtv9aaP52ezvLaTz7j6rusBaxb5J+r
        XoIYvYPc7jW1Ho9ac5JU0C9bomYgqEs=
X-Google-Smtp-Source: APXvYqw8pPRBw51BZPnkJjCNKYaDLFAswaWF4BmLQyxi43oWhww8u3Y8nLLnsfXfB1jKHacactTq6g==
X-Received: by 2002:a50:90af:: with SMTP id c44mr143020229eda.126.1561470066668;
        Tue, 25 Jun 2019 06:41:06 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:05 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 01/15] t0410: remove pipes after git commands
Date:   Tue, 25 Jun 2019 15:40:25 +0200
Message-Id: <20190625134039.21707-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's not run a git command, especially one with "verify" in its
name, upstream of a pipe, because the pipe will hide the git
command's exit code.

While at it, let's also avoid a useless `cat` command piping
into `sed`.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-partial-clone.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 5bd892f2f7..3559313bd0 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -166,8 +166,9 @@ test_expect_success 'fetching of missing objects' '
 	# associated packfile contains the object
 	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
-	git verify-pack --verbose "$IDX" | grep "$HASH"
+	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
+	git verify-pack --verbose "$IDX" >out &&
+	grep "$HASH" out
 '
 
 test_expect_success 'fetching of missing objects works with ref-in-want enabled' '
@@ -514,8 +515,9 @@ test_expect_success 'fetching of missing objects from an HTTP server' '
 	# associated packfile contains the object
 	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
-	git verify-pack --verbose "$IDX" | grep "$HASH"
+	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
+	git verify-pack --verbose "$IDX" >out &&
+	grep "$HASH" out
 '
 
 test_done
-- 
2.22.0.229.ga13d9ffdf7.dirty

