Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602231F454
	for <e@80x24.org>; Mon, 22 Oct 2018 20:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeJWEn3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:43:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40615 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWEn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:43:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id r1-v6so39231191edd.7
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+fcDj7ZfJP3kInABRlsVqqGzJy3P3k3Cx5F8SYWi14=;
        b=QnmcRcMT4s34WDY4y22i3uAW/0LuWAZ+34QNgPy/SY3CI4xXDwYW/oopL6O6nPGRkA
         6eUaNQ8C95KYF1/FxDidI2JvFrtuecJeFGfgt1nySuE9NBnNozFuEL+ZftzjN/CH0sYf
         QD5OdA1FGFj/MhkK+4vu+sB+hG7uPm2e6sj80/B/E8CvW1+hhpT922PPxpfuv6AyFDH6
         PnQzuqUvNXQKyz+XtiDNgANVB5Z2qfAZ1AJkqLjOaLc0i3hUar6DF6yL5U8pRI+jo5PQ
         fg2eaWXteWu93W97E9oFE9Vl8LEMdDy7lstmJeRjvY6gXk7czd/51WziD+Vmy9zkFfNa
         M9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+fcDj7ZfJP3kInABRlsVqqGzJy3P3k3Cx5F8SYWi14=;
        b=dsLB7JICWv4EO7qbUlatKV6D9zyw8QYpiCrp+fBDSZsK7oQQQgSkMQB3l2wePOzKCF
         F6Y3KjpC6dqQSowI3HVBjBRKUC7ZEyTzlDItEP8Gef5zceWFZRhA4BF1xP4Orms9gFxN
         tX/tAlC3ar52tQ2xKPjVgKVt47XLYG8XdofU9ZMWWRlfc05IYHxp+5A1fXbx54llMj0A
         OVo6PVlFdC0jL4zjQxmApwXM9NQ4Qf+uYzWACIaigPjGw8yEKsW665WRnR8UfB+cr0a6
         2WQudBlh3VdPDYGZeghnd2Ggix9eSBaxTmfGxi6kZdQ40xrLnYfSBFwQbo0vkxR9GrnI
         zYiQ==
X-Gm-Message-State: AGRZ1gIjzSxervftmdEUPqwR0CenbZSSG9n7SInedSoQu2TfhPfFOMLa
        eIfEq0FIp3Pu81Ww747VzIkF8hbN
X-Google-Smtp-Source: AJdET5erRCqsCIG1CSGb5I4OtG2UMSyqmWq0NuKH4eVnEJFOmqn9Vy5gokXtINrke4eoVwo6vjPjMA==
X-Received: by 2002:a05:6402:135a:: with SMTP id y26mr2463421edw.286.1540239808581;
        Mon, 22 Oct 2018 13:23:28 -0700 (PDT)
Received: from localhost.localdomain (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id h21-v6sm16882228eda.23.2018.10.22.13.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:23:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/8] test-lib.sh: preserve GIT_GETTEXT_POISON from the environment
Date:   Mon, 22 Oct 2018 22:22:34 +0200
Message-Id: <20181022202241.18629-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.681.g6bd79da3f5
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com>
References: <20181022153633.31757-1-pclouds@gmail.com>
 <20181022202241.18629-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setting GIT_GETTEXT_POISON can be useful when testing translated
builds.

However, preserving its value from the environment is not as simple as
adding it to the list of GIT_* variables that should not be scrubbed
from the environment:

  - GIT_GETTEXT_POISON should not influence git commands executed
    during initialization of test-lib and the test repo.

    Save its value before it gets scrubbed from the environment, so it
    will be unset for the duration of the initialization, and restore
    its original value after initialization is finished.

  - When testing a GETTEXT_POISON build, 'test-lib.sh' always sets
    GIT_GETTEXT_POISON to 'YesPlease'.  This was fine while all that
    mattered was whether it's set or not.  However, the following
    patches will introduce meaningful values (e.g. "set but empty" to
    disable poisoning even in a GETTEXT_POISON build), so only set it
    like this if GIT_GETTEXT_POISON was not set in the environment.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ea2bbaaa7a..282c05110d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -95,6 +95,16 @@ PAGER=cat
 TZ=UTC
 export LANG LC_ALL PAGER TZ
 EDITOR=:
+
+# GIT_GETTEXT_POISON should not influence git commands executed during
+# initialization of test-lib and the test repo.
+# Back it up, unset and then restore after initialization is finished.
+if test -n "${GIT_GETTEXT_POISON-set}"
+then
+	git_gettext_poison_backup=$GIT_GETTEXT_POISON
+	unset GIT_GETTEXT_POISON
+fi
+
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
@@ -1073,7 +1083,12 @@ test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 # Can we rely on git's output in the C locale?
 if test -n "$GETTEXT_POISON"
 then
-	GIT_GETTEXT_POISON=YesPlease
+	if test -n "${git_gettext_poison_backup-set}"
+	then
+		GIT_GETTEXT_POISON=$git_gettext_poison_backup
+	else
+		GIT_GETTEXT_POISON=YesPlease
+	fi
 	export GIT_GETTEXT_POISON
 	test_set_prereq GETTEXT_POISON
 else
-- 
2.19.1.681.g6bd79da3f5

