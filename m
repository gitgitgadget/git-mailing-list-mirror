Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726A5C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 15:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJJPjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJJPjF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 11:39:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8C72EEC
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 08:39:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so8777458wme.5
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFB/fuO/ptP/JUH8ysfgsySRelB+bt7EQQWc3FwLEBU=;
        b=a/3C1J96crxJ5NEJRTpdcKgZ9WTDAXKc9mt6dXRPdgctzhiuYiBCnCTzVRHRT1rpX+
         ovpc/RCxCifCOQODnfO0ZSAHI9Ervdw1cBFQWyaPW4eAdgGPHlCMdYXSOt7sql0GJYCm
         6e1IeIkF3jIB+jjwc8T8M6FWeH9vczWFADL3cDcJRnrH479X5kRCq41ugp0rhcT7+7qE
         +OBnPSC6rIKYD0X9XWPvHr7lYiPdG5K3ooTiROxOzTGty8ugS+gDyJcKbfmTQ41TP6vX
         m7BMg0H7ge1mooyuqEs/GkEAli7CI7FGDrA36d8upsR9WtAq6DyRF/R9ygFmeVpCQU+7
         3i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFB/fuO/ptP/JUH8ysfgsySRelB+bt7EQQWc3FwLEBU=;
        b=PfljAkde11X63R2LqQUpUeigoEQSCqma7KOzngx831GO1ffDJMJJSFJzOt66VDNBVz
         liG2v88csNKSrVhkBNtCGjS18D4QBC4/UWueUyR7jx7akRUzoMiir6XiNxbkzNs95zbg
         AQP56p1w/EuwDonueMs8Ggx2+efNqMNDflXkQe4KY06teNWjp1HxXtHM9LDEomS6Orii
         c9pTxfjS4ocrA9LnMHFxivqglHkwh0SXd5eB63RUCU9VDVPwZnYuv4WZ2D7vZR883pOb
         PYGr5n1FrYbCm9xlrO2i0oXnRrTf9mPvvj0lGAJ37AHIAZ3UKYr5WwXWIj8BBcMWEMuU
         8RHA==
X-Gm-Message-State: ACrzQf1hsUh9BbClDlCUTglusi+X+HyoPhLF6Nn+pkGikgIm7FTdTWZu
        oqitE0OW0jIyg51sFCao4gh7fZ1C8to=
X-Google-Smtp-Source: AMsMyM44GsaDJ26ENPqaMW+ukML6O3fAw3w+Zhm3mW01aZcDUEn58tshLM/hpap1CK6qpUZ0bYk/ng==
X-Received: by 2002:a1c:2543:0:b0:3c6:b7bd:a474 with SMTP id l64-20020a1c2543000000b003c6b7bda474mr3305100wml.95.1665416342238;
        Mon, 10 Oct 2022 08:39:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003a2e92edeccsm16506418wmi.46.2022.10.10.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:39:01 -0700 (PDT)
Message-Id: <pull.1375.v2.git.1665416340806.gitgitgadget@gmail.com>
In-Reply-To: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 15:39:00 +0000
Subject: [PATCH v2] config.mak.dev: disable suggest braces error on old clang
 versions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add the "-Wno-missing-braces" option when building with an old version
of clang to suppress the "suggest braces around initialization" error
in developer mode.

For example, using an old version of clang gives the following errors
(when in DEVELOPER=1 mode):

$ make builtin/merge-file.o
    CC builtin/merge-file.o
builtin/merge-file.c:29:23: error: suggest braces around initialization \
			    of subobject [-Werror,-Wmissing-braces]
        mmfile_t mmfs[3] = { 0 };
                             ^
                             {}
builtin/merge-file.c:31:20: error: suggest braces around initialization \
			    of subobject [-Werror,-Wmissing-braces]
        xmparam_t xmp = { 0 };
                          ^
                          {}
2 errors generated.

This example compiles without error/warning with updated versions of
clang.  Since this is an obsolete error, use the -Wno-missing-braces
option to silence the warning when using an older compiler.  This
avoids the need to update the code to use "{{0}}" style
initializations.

Upstream clang version 8 has the problem.  It was fixed in version 9.

The version of clang distributed by Apple with XCode has its own
unique set of version numbers.  Apple clang version 11 has the
problem.  It was fixed in version 12.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
    Fix syntax errors under clang 11.0.0 on MacOS
    
    Here is version 2. This version adds the "-Wno-missing-braces" compiler
    flag when we are using an old version of clang -- rather than updating
    the source files to use the "{{0}}" syntax that was expected by older
    versions of clang.
    
    I've expanded the scope to include fixes for Apple's clang 11 and below
    and non-Apple clang 8 and below.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1375%2Fjeffhostetler%2Ffix-clang11-warnings-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1375/jeffhostetler/fix-clang11-warnings-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1375

Range-diff vs v1:

 1:  7cee38788a7 < -:  ----------- builtin/merge-file: fix compiler error on MacOS with clang 11.0.0
 2:  e5009a325f2 < -:  ----------- builtin/unpack-objects.c: fix compiler error on MacOS with clang 11.0.0
 -:  ----------- > 1:  c6708ed9459 config.mak.dev: disable suggest braces error on old clang versions


 config.mak.dev | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 4fa19d361b7..981304727c5 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -69,6 +69,31 @@ DEVELOPER_CFLAGS += -Wno-missing-braces
 endif
 endif
 
+# Old versions of clang complain about initializaing a
+# struct-within-a-struct using just "{0}" rather than "{{0}}".  This
+# error is considered a false-positive and not worth fixing, because
+# new clang versions do not, so just disable it.
+#
+# The "bug" was fixed in upstream clang 9.
+#
+# Complicating this is that versions of clang released by Apple have
+# their own version numbers (associated with the corresponding version
+# of XCode) unrelated to the official clang version numbers.
+#
+# The bug was fixed in Apple clang 12.
+#
+ifneq ($(filter clang1,$(COMPILER_FEATURES)),)     # if we are using clang
+ifeq ($(uname_S),Darwin)                           # if we are on darwin
+ifeq ($(filter clang12,$(COMPILER_FEATURES)),)     # if version < 12
+DEVELOPER_CFLAGS += -Wno-missing-braces
+endif
+else                                               # not darwin
+ifeq ($(filter clang9,$(COMPILER_FEATURES)),)      # if version < 9
+DEVELOPER_CFLAGS += -Wno-missing-braces
+endif
+endif
+endif
+
 # https://bugzilla.redhat.com/show_bug.cgi?id=2075786
 ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wno-error=stringop-overread

base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
-- 
gitgitgadget
