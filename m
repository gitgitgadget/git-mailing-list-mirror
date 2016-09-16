Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066C5207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 17:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbcIPRhg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:37:36 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33242 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934524AbcIPRhc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:37:32 -0400
Received: by mail-pf0-f176.google.com with SMTP id 21so18591641pfy.0
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cvLS45bJ2+GDxgTNW/mksd3bWrHXXbSSADnJoFmeHKw=;
        b=i9PR8GNkmFzDCDYWiMMKqlzJs9yKcSm+19LUplFIaUEEE7j24QI6L72OkwSsByPd+P
         dinw+dY3VPHmE4ro8v8PVBuOTmWNJnEOopfsqOUzjVfZkCLvViTCH8xxT7eBNVSg35rY
         KFlJg423lv7XQ8A68/osx8v1FbhIcjloObB8rJYP/7EQOtB1jhB7bDVlBFgqu0SGCVVw
         rUwZUNB26GC1ZQlLoP18gkfctLV9KfzijQUfyEG289hg94+QTYa3ZcKlMb8LOTCchNh3
         fIf3qhqsX39Bv76SeQ+8Qqvlwhj+AMkmoEhjEzeq87U7QQEugT1caCYmI5+NnnU2tsIZ
         DsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cvLS45bJ2+GDxgTNW/mksd3bWrHXXbSSADnJoFmeHKw=;
        b=ZeBj18OLDGhKGWNnzjUotcW4t4RFj4jcV9OID+DMJit3bExloWa6Tkd3hRqIlYbLZM
         iS3Yw6QHhMm4spwTBbdZ/ltV7NZs5/ZZDfZya/6KuiDTAwq3eyqJH2zLCPWw9btx7kqT
         e7cLoCud1mBJafT+AXBp4OCtMyFIpzf034zrzzLKWfcnRzD506pGg7p7iXzPNugc8d13
         2pSnteSvFd0JeeHmyPrULpOaMV/BGCArGlT+1INI9iNtKjRZHINXGmJ0DF/+mPAhpmY/
         vGpYpLKpolFuwjaMTlNQwj1kkubsBQF3Jts3wffuxNQe5T5lqsxZIUPTe+dGzMQeRpc4
         Ubkg==
X-Gm-Message-State: AE9vXwP+2SrZ4r9ZQLAf3u9Looy5sWxb6aUAd3dLv8wFA0zh9pPNpN60rzlq1PE5D27troe3
X-Received: by 10.98.13.149 with SMTP id 21mr13066029pfn.19.1474047451216;
        Fri, 16 Sep 2016 10:37:31 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id m128sm53664348pfm.42.2016.09.16.10.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Sep 2016 10:37:30 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Subject: [RFC/PATCH 2/3] mailinfo: correct malformed test example
Date:   Fri, 16 Sep 2016 10:37:23 -0700
Message-Id: <5dbb0b0f64906fd18c217908cd2c04e74d80fa68.1474047135.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474047135.git.jonathantanmy@google.com>
References: <cover.1474047135.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474047135.git.jonathantanmy@google.com>
References: <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net> <cover.1474047135.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An existing sample message (0015) in the tests for mailinfo contains an
indented line immediately after an in-body header (without any
intervening blank line). Correct this by adding the blank line, in
preparation for a subsequent patch that will treat such indented lines
as RFC 2822 continuation lines (instead of as part of the commit
message).

To ensure that non-indented lines immediately after an in-body header
are still treated correctly (now and in the future), 0008 has been
updated to test both the case when in-body headers are used and the case
when they are not used.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5100/info0008--no-inbody-headers  | 5 +++++
 t/t5100/msg0008--no-inbody-headers   | 6 ++++++
 t/t5100/msg0015--no-inbody-headers   | 1 +
 t/t5100/patch0008--no-inbody-headers | 0
 t/t5100/sample.mbox                  | 1 +
 5 files changed, 13 insertions(+)
 create mode 100644 t/t5100/info0008--no-inbody-headers
 create mode 100644 t/t5100/msg0008--no-inbody-headers
 create mode 100644 t/t5100/patch0008--no-inbody-headers

diff --git a/t/t5100/info0008--no-inbody-headers b/t/t5100/info0008--no-inbody-headers
new file mode 100644
index 0000000..e8a2951
--- /dev/null
+++ b/t/t5100/info0008--no-inbody-headers
@@ -0,0 +1,5 @@
+Author: Junio C Hamano
+Email: junio@kernel.org
+Subject: another patch
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/msg0008--no-inbody-headers b/t/t5100/msg0008--no-inbody-headers
new file mode 100644
index 0000000..d6e950e
--- /dev/null
+++ b/t/t5100/msg0008--no-inbody-headers
@@ -0,0 +1,6 @@
+From: A U Thor <a.u.thor@example.com>
+Subject: [PATCH] another patch
+>Here is an empty patch from A U Thor.
+
+Hey you forgot the patch!
+
diff --git a/t/t5100/msg0015--no-inbody-headers b/t/t5100/msg0015--no-inbody-headers
index be5115b..44a6ce7 100644
--- a/t/t5100/msg0015--no-inbody-headers
+++ b/t/t5100/msg0015--no-inbody-headers
@@ -1,3 +1,4 @@
 From: bogosity
+
   - a list
   - of stuff
diff --git a/t/t5100/patch0008--no-inbody-headers b/t/t5100/patch0008--no-inbody-headers
new file mode 100644
index 0000000..e69de29
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 8b2ae06..ba8b208 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -656,6 +656,7 @@ Subject: check bogus body header (from)
 Date: Fri, 9 Jun 2006 00:44:16 -0700
 
 From: bogosity
+
   - a list
   - of stuff
 ---
-- 
2.10.0.rc2.20.g5b18e70

