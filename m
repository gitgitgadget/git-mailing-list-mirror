Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3FD1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeFHWmd (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55873 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbeFHWmH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so5723384wmh.5
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cX7SXlmor97F+GBJc+2uaJo7O4quR5JtcIi0PJ+qas8=;
        b=VJTwBL3JXBgfAZFFOGY4oZJ5dkHY1QrfDdp8NyJF40gzjXQIPnyJmX9t2nuJQ72SqH
         Agk5niiiUq4W0wpMT5t+JaZSIsY6VygGEeeF0H8C450Wtj1DQQfY5BoW5X+M+M2imp3C
         NGvK+5AqvrWI41l7cmA9xAQpywD6A8AwbibYVJ5QQf/f6UVbgzLgbavMCi0lJ8eg5QdH
         tDl7sNCHkOvXXOC8BCLjU/ZUuZ+r+kYYiu80cVZm7L+48c0hDJ9t8d24gvHoiGuLtfV5
         HWGEUaFVTb4y5Ef7Lzy6/iYxb+XFXHXXa22f9KN8L8EXXTA8u9Y2b+9X3RzV9tPAbGPR
         XtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cX7SXlmor97F+GBJc+2uaJo7O4quR5JtcIi0PJ+qas8=;
        b=C1kFAzQ6wDx3JFtldWiFP0D0z+tv68kdPHO3hkjtVCg5YVOZy9mWwTAMPNPgpc7UVE
         ZBWJuMMNIPj+QNEuYKWzfRNloJSzlAgTdN3jVZV48c5vmMLyUXqYDfTAiDkUk3wIMBuI
         icFw+ulR0dk8atKOEP9xlvtb0/Vo5D+YKm7GtWOPUgJ7JNDSp87WF3HOG1QpNYWTJ/Y8
         wWeND33YW+Er0FRHAqlFCyry31+KnI0xFCCVcSK+f4rUJ8cZsqlY8qY2IIDmrI3QGACI
         MdH75pV7VQ8Tx5aeZRwE8goNMp8aafdN9R8qxByVSwY84iSorh0BzTM2PnJdpsikxcvt
         9Fog==
X-Gm-Message-State: APt69E1mX5lM2iVhNF++vPOc4Jd/j+1f8mcwrHqJ2UPkMKtg1A8KQ7GI
        swpaX0bMWzAJ/UZVvHli/liU7xIk
X-Google-Smtp-Source: ADUXVKIo/9QeDk14VOTHHZNBl4pBnSPyEdgUtt+7/bwQVakHW3ha1O0TZG+6haud6XAFMExZWjVW8w==
X-Received: by 2002:a1c:b484:: with SMTP id d126-v6mr2677851wmf.0.1528497726471;
        Fri, 08 Jun 2018 15:42:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/20] parse-options-cb.c: convert uses of 40 to GIT_SHA1_HEXSZ
Date:   Fri,  8 Jun 2018 22:41:29 +0000
Message-Id: <20180608224136.20220-14-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ac53fe8601 ("sha1_name: convert uses of 40 to GIT_SHA1_HEXSZ",
2017-07-13) the code this is validating user input for in
find_unique_abbrev_r() was converted to GIT_SHA1_HEXSZ, but the
corresponding validation codepath wasn't change. Let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options-cb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 0f9f311a7a..298b5735c8 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -21,8 +21,8 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 			return opterror(opt, "expects a numerical value", 0);
 		if (v && v < MINIMUM_ABBREV)
 			v = MINIMUM_ABBREV;
-		else if (v > 40)
-			v = 40;
+		else if (v > GIT_SHA1_HEXSZ)
+			v = GIT_SHA1_HEXSZ;
 	}
 	*(int *)(opt->value) = v;
 	return 0;
-- 
2.17.0.290.gded63e768a

