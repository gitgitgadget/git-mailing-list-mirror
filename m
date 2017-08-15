Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A41F208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbdHOMxt (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:53:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33711 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbdHOMxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:53:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id q189so1380272wmd.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AzUowRaJ1wbvbLTWs7DnizgHCoRtyJHh7BuibNMi6vg=;
        b=Lz6g0S5LirPT/Cj3bNaPTIsXOUi7C6Eu3BCi3cn4fIOjgu8KeDF34gKT++xoamDbc1
         2ehO5iTjueVC2K1ptW+/NThamO/zDBGypQ0wM1riKQMfupMFwpxkJULZG9mo9KfN10jh
         HmutOAmVk+cYDYaSVCdknoEDieys1Ht6fVFeWrBDN0IuRgO9kqruZWLp6+Y8qLG2kNe0
         xoXkBK468lAuSrf49qhGGtEhIGDsgp0/B7FQv3Cxid66uhIHMCJErLdJalNC2uUxr0JT
         3lxdBzsT00ea3RdwJ88BiqqgJdctQAh8Mftb9DIRIrNDY0KoMFtuqT1lNP5hPT2QXiB+
         k+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzUowRaJ1wbvbLTWs7DnizgHCoRtyJHh7BuibNMi6vg=;
        b=iIdIWZmxeOwVFfvBS6VKiezMw5AgyWvKUVgVQ4L7WhP3Ri6YUfyaRSJ7whb72nGyc0
         nPyuh25jeKRPQLHJdVUZdS7uxMCtepDYOJBgm80u83yYz6b8VHHo52HN7SrruHLbg3M2
         VX6Sn7FffdmBSUQLKnQj8QLUITkUeNNRfnbPXg22zqVzo5glBYwbBndukIHVGwHSQED2
         1+HBgQ6oCZ3HTMTIy9Ss0tnLhpSIR0y7n5BVUC9SS32/cAw8h+877rs6a6v4QZ2fuIPB
         rYQVdVNc9v+PbTA3RZLuhz8FS5wTeWP22D8Wnju9eGyhPSAQeqnqpwKEn7wYok2OcYUH
         DGqg==
X-Gm-Message-State: AHYfb5jRdBu2xbn7cc56CrO7lHyWONRgYREgF695akQ2swsLXc936P/k
        qP1wnGawTarJvtuM
X-Received: by 10.28.175.8 with SMTP id y8mr1238279wme.42.1502801623995;
        Tue, 15 Aug 2017 05:53:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id k14sm4006617wrg.11.2017.08.15.05.53.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 05:53:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] ThreadSanitizer: add suppressions
Date:   Tue, 15 Aug 2017 14:53:05 +0200
Message-Id: <51dfd9e8ac7ec1d9019342bda89466c8fe133106.1502780344.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1502780343.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add .tsan-suppressions for want_color() and transfer_debug(). Both of
these use the pattern

	static int foo = -1;
	if (foo == -1)
		foo = func();

where func always returns the same value. This can cause ThreadSanitizer
to diagnose a race when foo is written from two threads, although it
doesn't matter in practice since it's always the same value that is
written.

The suppressions-file is used by setting the environment variable
TSAN_OPTIONS to, e.g., "suppressions=$(pwd)/.tsan-suppressions". Observe
that relative paths such as ".tsan-suppressions" might not work.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I am no memory-model expert. Maybe (aligned) stores and loads of int are
not actually atomic on all the various hardware that Git wants to run
on. Or maybe the compiler is allowed to compile them into 4 1-byte
accesses anyway...

 .tsan-suppressions | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 .tsan-suppressions

diff --git a/.tsan-suppressions b/.tsan-suppressions
new file mode 100644
index 000000000..910c02e59
--- /dev/null
+++ b/.tsan-suppressions
@@ -0,0 +1,12 @@
+# Suppressions for ThreadSanitizer (tsan).
+#
+# This file is used by setting the environment variable TSAN_OPTIONS to, e.g.,
+# "suppressions=$(pwd)/.tsan-suppressions". Observe that relative paths such as
+# ".tsan-suppressions" might not work.
+#
+# These suppressions can be, e.g., that a static variable is written to and it
+# is always the same value being written, so it doesn't really matter that two
+# or more such writes race.
+
+race:^want_color$
+race:^transfer_debug$
-- 
2.14.1.151.gdfeca7a7e

