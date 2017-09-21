Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88864202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 12:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdIUMoZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 08:44:25 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46344 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdIUMoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 08:44:24 -0400
Received: by mail-wm0-f47.google.com with SMTP id m72so1489378wmc.1
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ekfgUM6tPU48KoggQWTbgdZS0PzS1rdksKF95PZe5NE=;
        b=Zib19ZNhZ1k8Qq0W54wFv1XyxeIzqu9ysplO0d40xVyR37xOjehs6uWbXmCWiG99Oc
         dGCST10cGale1dJPRIXUxmrwIv4MJelPt4CwIroVE3Ouj4gBq3A0C/GhJP99rcWm14WM
         lJXnSy5RMrFx3HTr0aOL3u3gsqotDuh3lNXK8pXC9ALtxIxDZ+pCm/Saq12FSyPbU6fF
         3TMlJTUKbontTvp6BeQajt670hGTlXVTb+lykSZQ0GwOL/xRD5CzBDOdEv4SQ87Xot2x
         jgSTxyf6NTEN6lyUMxM8kon29mwV1debSPt9xyXBHTo/sV1khnaoDvSIanOGO/xWE8f1
         9VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ekfgUM6tPU48KoggQWTbgdZS0PzS1rdksKF95PZe5NE=;
        b=UisY52M8yb2eV6WEokvqBbe2Ug1zkhc2DabBswPXZ2WUJS8bX3YmdpvPo8+3+5KD++
         ufY6+XCEQiMWSBbZWgdlukoWa3VeM9vdzCMv3Pj/U3Fz/Mx6WWcrTD+YOZ9S1NkItdjZ
         yujAZTx+P0X3NL50/EUmAOitdLAWcSDNIe/0oUegLVhIHZmrO2LyyhXWh2HZSdypa7ci
         8R8PyqaL+rMb1lImUUw5sG6PCX0kM80J9KJt+NTHHTqaTTj0Tqu/5Xm+EMLOQHOva70s
         IRHF01mDg2N6mm+TVvhHJEty0wsFxG0lzV2JqIOxBf77XrKYYwmuPBUMT3uZA9q2v3/3
         vjuw==
X-Gm-Message-State: AHPjjUhZZZ8ipNodjFA6Ja/1WIowSe0+qRUqK/qFHNn0YzkVl2hUSm0z
        TslI9dMfPeiill7183nuzHxqkqtjL1w=
X-Google-Smtp-Source: AOwi7QCUmCef6lYKk+x00ZTJ0t+87Zb7mEV3wapaJuH0C+p39ueeNmviYl8jDsBk7hDhHxX21KCUMg==
X-Received: by 10.28.25.129 with SMTP id 123mr911131wmz.17.1505997862371;
        Thu, 21 Sep 2017 05:44:22 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id p59sm1494778wrc.75.2017.09.21.05.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 05:44:21 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 2/2] Document the string_list structure
Date:   Thu, 21 Sep 2017 14:43:38 +0200
Message-Id: <20170921124338.26626-3-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170921124338.26626-1-hanwen@google.com>
References: <20170921124338.26626-1-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 string-list.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/string-list.h b/string-list.h
index 29bfb7ae4..08b534166 100644
--- a/string-list.h
+++ b/string-list.h
@@ -8,6 +8,12 @@ struct string_list_item {
 
 typedef int (*compare_strings_fn)(const char *, const char *);
 
+/* A resizable array of strings. The strings are owned if
+ * 'strdup_strings' is set. It can be used as a sorted array, and a
+ * custom comparison may be given in 'cmp'. The field 'items[i].util'
+ * may be used to implement an array of pairs. In that case, the
+ * caller is responsible for managing memory pointed to by 'util'.
+ */
 struct string_list {
 	struct string_list_item *items;
 	unsigned int nr, alloc;
-- 
2.14.1.821.g8fa685d3b7-goog

