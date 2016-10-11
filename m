Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0122420989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbcJKAVg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:36 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35410 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcJKAVe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:34 -0400
Received: by mail-pa0-f45.google.com with SMTP id qn10so3902032pac.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wwhylaMWLo8edzjQOdEZS1MCn85TgAeI446YdMOta3s=;
        b=I4sg1A8ZqKJNrfUBciOOwJlkWKgLbE/GrLdRUYl6QzA44ke07zyFujsEohL+DOyLo3
         NuerewMLp+yH/6PSCbF1nv1JiXtEWhtahge4LklVvMuRnbo/PADqlprdVGVL7A+GyDOj
         6jVTU4G3gsdyYXm5mz61MwrP8j+TvpD1WBxLXmOWQSMTv7BjkwHrzZWoGQDB6JhuT0+Y
         uCIkIUM7zKDcdflBx6PYQDVqX5vD75RUDmhyanQPkbEnK/itpuLpu2RxuGLD0n5l3BT3
         7+Vw0VCi/gwcDK09wGyFa5PA2eMYApSg4/ZrgqjUKkOq9o13zmndzVk2z+fZxsxsCn8f
         KR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wwhylaMWLo8edzjQOdEZS1MCn85TgAeI446YdMOta3s=;
        b=CWvRJHKAKbeFjGeU1DTpV2EfzmNqxNsgnDaXHFlnlUf+BgeuFW6AdtdTIRZyygkLBI
         U++JmjPd6KA4JO1dAaHk3ZYB8YgaWAjwlCLCl0tnaDYJ9BVRjgyS4OV3lWp63R48SbHN
         MWc0kEhBAzWQZ+ztelxWjBTOF3sMc3p2+n+6cPYRyyOv8ER/Uhh15gb1BX5Xm1bkFOkF
         CfV6Y73IKc1aoAoeqmeVqAFWVSoI7gDDWQTgCmtnAEZUlHRSqSLNWwqmr4mEX/9vn2lU
         lyl37YrQVwpuDsy3DNxNjmCnixazblq6LhBLJEm4gq0aIDJa3De5X6sZYrq/jZspNEta
         nf3g==
X-Gm-Message-State: AA6/9RlklOmFkyIQBNqZPXNyJ6wkyqjSSfmdT/G6E/ZNOIN7PZbhwwnoVVj+I3+EMXUhZur2
X-Received: by 10.66.78.9 with SMTP id x9mr1638565paw.201.1476145293299;
        Mon, 10 Oct 2016 17:21:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id d188sm527809pfd.33.2016.10.10.17.21.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/28] attr.c: mark where #if DEBUG ends more clearly
Date:   Mon, 10 Oct 2016 17:20:53 -0700
Message-Id: <20161011002115.23312-7-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index a7f2c3f..95416d3 100644
--- a/attr.c
+++ b/attr.c
@@ -469,7 +469,7 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 #define debug_push(a) do { ; } while (0)
 #define debug_pop(a) do { ; } while (0)
 #define debug_set(a,b,c,d) do { ; } while (0)
-#endif
+#endif /* DEBUG_ATTR */
 
 static void drop_attr_stack(void)
 {
-- 
2.10.1.382.ga23ca1b.dirty

