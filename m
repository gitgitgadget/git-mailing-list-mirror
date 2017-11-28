Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E1C20954
	for <e@80x24.org>; Tue, 28 Nov 2017 21:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbdK1Vch (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 16:32:37 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38467 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdK1Vcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 16:32:32 -0500
Received: by mail-wm0-f66.google.com with SMTP id 64so2202732wme.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 13:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNsAxxQI9lHkVQWcYAVPexZzOWqeyMVvKoYNjXz2s6c=;
        b=tNdVbDAhFnv3scD16ONcjMfdA9y2p1yjSbbjcjJAHD6cW0I4uQAqkM8DgskszYn6zp
         cjHTKvGGEf8VD/RH3i/ZdxGX/tYdETVIj9qiLGlq95HKslqnOn03r5DuufGSDNBeilw0
         umYjuK2A8Dj9FG7+d3dZiaMdB/GQ2HESxv34LvPsQjSsNfIJrPhEwlw9h/0mOrCQ6KFi
         xTZEhsE45jU1zTGpTPUfBdEw3Z8V+3X+JjHO1ho+kacFG3UcWw72vfRtsDloMyrDBFk3
         JkGIj/HeGzbqMLMj31cH6FbrDfIPfiWqkVLYqZNii9qQCmEwzovp3orcbm0yjZ2vl99e
         ChRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNsAxxQI9lHkVQWcYAVPexZzOWqeyMVvKoYNjXz2s6c=;
        b=QPEytrQDBsQlseRW+BLXRSWTj8VQmk6bZ9tU5d/DY8JsCfSwBtnGa2QmWGR9kBBIuK
         /rP8S8iP4yDBQiT1WLl2xeOj0rafxeWuB6Dw10feyoVmPjEsPZLoZBq+R4UwFXB//+EJ
         dP04iFiDletLWZx9S0dASPbxi+7RtNP1moAsdrMx5p/ZMW3FJKO1l1fy/+9H3y9ko24j
         ZvCUKTYjPY7+Y2t6sNaz2ZpKtjuRnADK9B3fMpbe99mBKnDRtb42Q2/VJuZ+x7+7LQNQ
         raqAFeKndKWfJaDlMKNXx7wuDi1dZeWb33OSSkxgo6sBGU4dq+Q7sAW/bnY7LmlAvVx9
         k4lg==
X-Gm-Message-State: AJaThX7AWjKnSPwh9bvo+46pPlve/+Px76NXC+LKAHgzRLstsKFHEjOU
        fTSOL6SBls2BVjTxYZqoxsD0VRtw
X-Google-Smtp-Source: AGs4zMaT2PWKRSD9LA2Ibd8ZBoHpM27gbKVjX+T5ZGFMjvZw+pCylA17z5XMGkbOy8ivd5Q8tVjWoA==
X-Received: by 10.28.146.76 with SMTP id u73mr812977wmd.28.1511904750984;
        Tue, 28 Nov 2017 13:32:30 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d18sm147361wrd.54.2017.11.28.13.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 13:32:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] Makefile: use the sha1collisiondetection submodule by default
Date:   Tue, 28 Nov 2017 21:32:13 +0000
Message-Id: <20171128213214.12477-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
In-Reply-To: <20171128213214.12477-1-avarab@gmail.com>
References: <20171128213214.12477-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the build process so that instead of needing to supply
DC_SHA1_SUBMODULE=YesPlease to use the sha1collisiondetection
submodule instead of the copy of the same code shipped in the sha1dc
directory, it uses the submodule by default unless
NO_DC_SHA1_SUBMODULE=UnfortunatelyYes is supplied.

This reverses the logic added by me in 86cfd61e6b ("sha1dc: optionally
use sha1collisiondetection as a submodule", 2017-07-01). Git has now
shipped with the submodule in git.git for two major releases, if we're
ever going to migrate to fully using it instead of perpetually
maintaining both sha1collisiondetection and the sha1dc directory this
is a logical first step.

This change removes the "auto" logic Junio added in
cac87dc01d ("sha1collisiondetection: automatically enable when
submodule is populated", 2017-07-01), I feel that automatically
falling back to using sha1dc would defeat the point, which is to smoke
out any remaining users of git.git who have issues cloning the
submodule for whatever reason.

Instead the Makefile will emit an error if the contents of the
submodule aren't checked out (line-wrapped. GNU make emits this all on
one line):

    Makefile:1031: *** The sha1collisiondetection submodule is not
    checked out. Please make it available, either by cloning with
    --recurse-submodules, or by running "git submodule update
    --init". If you can't use it for whatever reason you can define
    NO_DC_SHA1_SUBMODULE=UnfortunatelyYes.  Stop.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     | 32 +++++++++++++++++++-------------
 sha1dc_git.h |  2 +-
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 8fe8278126..b5308bc3ca 100644
--- a/Makefile
+++ b/Makefile
@@ -167,11 +167,12 @@ all::
 # Without this option, i.e. the default behavior is to build git with its
 # own built-in code (or submodule).
 #
-# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
-# sha1collisiondetection shipped as a submodule instead of the
-# non-submodule copy in sha1dc/. This is an experimental option used
-# by the git project to migrate to using sha1collisiondetection as a
-# submodule.
+# Define NO_DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
+# sha1collisiondetection library shipped as a non-submodule copy in
+# sha1dc/, instead of using the sha1collisiondetection submodule. This
+# option will eventually go away. Clone git with
+# "--recurse-submodules" or run "git submodule update --init" after
+# cloning.
 #
 # Define OPENSSL_SHA1 environment variable when running make to link
 # with the SHA1 routine from openssl library.
@@ -1025,8 +1026,15 @@ EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
-ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
-DC_SHA1_SUBMODULE = auto
+ifndef NO_DC_SHA1_SUBMODULE
+ifndef DC_SHA1_EXTERNAL
+ifneq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
+$(error The sha1collisiondetection submodule is not checked out. \
+Please make it available, either by cloning with --recurse-submodules, \
+or by running "git submodule update --init". If you can't use it for \
+whatever reason define NO_DC_SHA1_SUBMODULE=UnfortunatelyYes)
+endif
+endif
 endif
 
 include config.mak.uname
@@ -1496,19 +1504,17 @@ else
 	BASIC_CFLAGS += -DSHA1_DC
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
-	ifdef DC_SHA1_SUBMODULE
-ifneq ($(DC_SHA1_SUBMODULE),auto)
-$(error Only set DC_SHA1_EXTERNAL or DC_SHA1_SUBMODULE, not both)
-endif
+	ifdef NO_DC_SHA1_SUBMODULE
+$(error Only set DC_SHA1_EXTERNAL or NO_DC_SHA1_SUBMODULE, not both)
 	endif
 	BASIC_CFLAGS += -DDC_SHA1_EXTERNAL
 	EXTLIBS += -lsha1detectcoll
 else
-ifdef DC_SHA1_SUBMODULE
+ifndef NO_DC_SHA1_SUBMODULE
 	LIB_OBJS += sha1collisiondetection/lib/sha1.o
 	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
-	BASIC_CFLAGS += -DDC_SHA1_SUBMODULE
 else
+	BASIC_CFLAGS += -DNO_DC_SHA1_SUBMODULE
 	LIB_OBJS += sha1dc/sha1.o
 	LIB_OBJS += sha1dc/ubc_check.o
 endif
diff --git a/sha1dc_git.h b/sha1dc_git.h
index 41e1c3fd3f..1bcc4c473c 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -2,7 +2,7 @@
 
 #ifdef DC_SHA1_EXTERNAL
 #include <sha1dc/sha1.h>
-#elif defined(DC_SHA1_SUBMODULE)
+#elif !defined(NO_DC_SHA1_SUBMODULE)
 #include "sha1collisiondetection/lib/sha1.h"
 #else
 #include "sha1dc/sha1.h"
-- 
2.15.0.403.gc27cc4dac6

