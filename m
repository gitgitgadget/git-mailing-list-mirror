Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A69C433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiCASp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiCASoz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7965791
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c18-20020a7bc852000000b003806ce86c6dso1776591wml.5
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FHMNZKs576+n2YSEBmmlnXIC91fIZibgzgB6togRe14=;
        b=T56Ruzc7MjHrMkNsmngczOILu3RRSmAySSJ+3NU08aVaxJuYJ3pcbUv6QKFnkfO24C
         mCWoL0Ak+1pbxzR1frFxmnIjvuIs2a5EssVWoUK3np8Z3dnmK2jRaEWbOtZHI3i2R4nx
         YMqi7oNpXeyps7sGcNFvd6FEcSl+RcN0PAC30dB7B+4lCSfFKT0FkC4Ahyh3ZevXgsfZ
         m43lM6Ky/lJPvAD8nlZmrSgw+8kXvOQpV50L2g20gFyAxkMPs69dZx4wZkxPXY9SArIA
         g7+9szhFa+OZdIKrlCOHxjeuHAlpABK0Vmf/msK8zeem5FoRgmXlxCqbzbB1vq5lLLVP
         ejTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FHMNZKs576+n2YSEBmmlnXIC91fIZibgzgB6togRe14=;
        b=rhXIwQXCvzjZMDZgwpLfmHsCT6FNUumeuxgjCPxjZTS1z2A4dY16GpJbp4h3lHsi1P
         O8KWhKv5s+mf+4rt/0TQE05P2MWzMWqIyjZ9BjRhvGPW+VdY+i2n8jxxsUi0HTZ4QqJX
         P2Jq5CJUp5kBUthZFI4W65p6T1Scw0jiz1rfslHvwVNc6xt9T2QJRvUXFTheHN10hoMV
         Uc5eqaY/bAcTSia5E5DOu6aYBNwAqAy6SbYhE0DP6EHskp9H7r2FPLsIHlzs9nGgJlb0
         29W56FxWK80XCksUr56jKVWpJVJOngV9+JQRjZE4/pQggG7mQoD6bsWJshnQK2AuhykF
         wdsw==
X-Gm-Message-State: AOAM530Wwx4tJ6hjuwmMOb89/V0dePoGlmfEMFaESVuasnJMe/kZCZQq
        CAi+I1KqwrNnALH47CPzntsJF4V9Udg=
X-Google-Smtp-Source: ABdhPJyrS1nflOQXonnf6vLBST+RB1AezxZJtoalIrRkreWZOcI7aEwWdNeWYJXC/6rwzPkO6UPplA==
X-Received: by 2002:a05:600c:4e48:b0:381:83d8:54f6 with SMTP id e8-20020a05600c4e4800b0038183d854f6mr3943707wmq.18.1646160231085;
        Tue, 01 Mar 2022 10:43:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b003817ab146e9sm4623487wms.44.2022.03.01.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:50 -0800 (PST)
Message-Id: <bc240a9e665841a622c96b8a245ce033684394f6.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:21 +0000
Subject: [PATCH v6 19/30] help: include fsmonitor--daemon feature flag in
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
 t/test-lib.sh | 6 ++++++
 2 files changed, 10 insertions(+)

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
index e4716b0b867..46cd596e7f5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1799,3 +1799,9 @@ test_lazy_prereq SHA1 '
 # Tests that verify the scheduler integration must set this locally
 # to avoid errors.
 GIT_TEST_MAINT_SCHEDULER="none:exit 1"
+
+# Does this platform support `git fsmonitor--daemon`
+#
+test_lazy_prereq FSMONITOR_DAEMON '
+	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
+'
-- 
gitgitgadget

