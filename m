Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA7C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiCXQwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351850AbiCXQvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:51:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1039996AD
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h16so3111354wmd.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6IMoORViExxPGOqXM0jiWHBPtgaquTlkmrPOCTiquVM=;
        b=MNEMF8clVhq+N5Gwv4+q1/Q/qr7KlURitRVPhHf3o9j6wv6jLe53cI4yCeGTBHKYct
         FKVflkJNd9Pyka932Dkwf+Yjgmoqg41WjIETgkpb8L+MTbhL+nHNzrF5v7LQgTpRkd3g
         Q5M21DGmBvXhe4S/pjyPbIeY0ICi3wGbo1gHm+KcT/aLGGCoaAu8c3Ijbe2lLNEsZ953
         Rz9WEE+FT7qwtvP9lzeBHFKYGF7TjjKrpfOSIrkoF/dgZMdReMRm8tbeJzrB4fHVJElG
         OD6yWs2hi+qWGTuwDcJ2tgzZPBY1Lv40W/aAMzvB99kX6aP4kBHUfaUwjylSkpqz42fF
         7X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6IMoORViExxPGOqXM0jiWHBPtgaquTlkmrPOCTiquVM=;
        b=XYiDT9Brqb1zLoLzT94CeiqCN/ulexSGlMDTYtIW6bJDzc24YDI93nt0drYmzWr/MT
         /4QDkOOXShD+xg5+FUN7pv8cJ8KDgwlMyc3IvRvDeNtZVmtoq87uOc+n+niLFonB76bb
         kPA1xVxR8HKFMf7hJQjps6i0yvn7s16QTzo4Tvzu7NCOwCTNy4Qa/9Cg4ELc0Eop58tc
         3MsrK+PuA5eRnqxu0jIK/89UVWiWf54DwD+VGv2IDBNvFtINQb6to8qCQrFXrQ3r9R9T
         RuaI96RfPwGWjGsuoBQWMyOCxmq5OWFWVBftMAgoYPUDfuxNgA1BSmVAsHYqGy0cLjD3
         ethQ==
X-Gm-Message-State: AOAM5336u2UPi/MzLPbK33lvn9mXdg1RUOcOXeN4LkaNKkdsXPrJAACN
        65GtLuOslFAf56gpMyHY0YjistrAIsU=
X-Google-Smtp-Source: ABdhPJzzprj0rIPHchVsrYYJSaCCHjl3e23A4WYFi9DjMEKyR/Mc3VbuT0FBslusylJR+7P9MkPmNw==
X-Received: by 2002:a05:600c:1c0e:b0:38c:be20:2990 with SMTP id j14-20020a05600c1c0e00b0038cbe202990mr5431727wms.86.1648140613163;
        Thu, 24 Mar 2022 09:50:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d6181000000b00203fc0e79a3sm2978137wru.46.2022.03.24.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:12 -0700 (PDT)
Message-Id: <ed338777b561ca7c2bb6753b0408da7ea3a64435.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:35 +0000
Subject: [PATCH v8 19/30] help: include fsmonitor--daemon feature flag in
 version info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add the "feature: fsmonitor--daemon" message to the output of
`git version --build-options`.

The builtin FSMonitor is only available on certain platforms and
even then only when certain Makefile flags are enabled, so print
a message in the verbose version output when it is available.

This can be used by test scripts for prereq testing.  Granted, tests
could just try `git fsmonitor--daemon status` and look for a 128 exit
code or grep for a "not supported" message on stderr, but these
methods are rather obscure.

The main advantage is that the feature message will automatically
appear in bug reports and other support requests.

This concept was also used during the development of Scalar for
similar reasons.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 help.c        | 4 ++++
 t/test-lib.sh | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/help.c b/help.c
index 71444906ddf..9112a51e84b 100644
--- a/help.c
+++ b/help.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "prompt.h"
+#include "fsmonitor-ipc.h"
 
 struct category_description {
 	uint32_t category;
@@ -695,6 +696,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+
+		if (fsmonitor_ipc__is_supported())
+			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 	}
 }
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e4716b0b867..5d819c1bc11 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1799,3 +1799,10 @@ test_lazy_prereq SHA1 '
 # Tests that verify the scheduler integration must set this locally
 # to avoid errors.
 GIT_TEST_MAINT_SCHEDULER="none:exit 1"
+
+# Does this platform support `git fsmonitor--daemon`
+#
+test_lazy_prereq FSMONITOR_DAEMON '
+	git version --build-options >output &&
+	grep "feature: fsmonitor--daemon" output
+'
-- 
gitgitgadget

