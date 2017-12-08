Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DD21FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbdLHWa3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:30:29 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44149 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdLHWaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:30:23 -0500
Received: by mail-wr0-f195.google.com with SMTP id l22so12100981wrc.11
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 14:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7e71zmyAVQbA/g9gr9OWfN+VsM+sG752P0uA6zonX2o=;
        b=S1GO21GYKphIrxVcjwfGB3ICjdofS3LXNR9HmibxRW/8nKKyQ+j3bjz+KRB7qZAOhQ
         ec/znr6z6X+MLXtr6BkIShfplqy5fozQu6zQtvxxCslJXy63p6HJGLyh3DkFdR/ekH8b
         PeqhmIApKjRvSVbIUZilTOp7ljSIe2fjwwhXy3KKh6/HlspRHD6Y4R72U9v+oT0NvBqz
         UfeLaovFtTal7sFcHPXdBODuVj2xSpDsKdfOm3Nu8aWwXGNEq5/282fJySfGY6cXKAfY
         mU3aqQY9K3/ZFO1MOmnV5zbStS2oqt620BcZKJ+0XDtcN6YiqRkUlxA1VLeSbJWpb4pe
         uXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7e71zmyAVQbA/g9gr9OWfN+VsM+sG752P0uA6zonX2o=;
        b=CPeROPNlikhaLhqV2S3izemrwo987CLtdlSRf7akC/0lI8HKKdCO36zFRRxpA9QKbf
         UC5oJYC+PNj499VmA4EShe0FmdwNdP2Qe5EuY/Z/mheIdlaZc63PGHkRa0RUM2SV4XZg
         fQqThPagoeM7Qh2xPpjRRF8EbtzuvAl5+ayLKsWs6jK941nS8wgxs6Gee6HmhTlIzJ7A
         0SS3YICjzNr4lshb1P7DWAy0qGTXcosNwBldsxLPttsGFXwuAY8+r4X5FW26ZG47f+3r
         Ntm3XbTbPjMuIMstU6HHqdqrnSFhWmSHuZP5nu6DOWBvp7GjpDb0IKmNP09h499hFDdo
         T+Ow==
X-Gm-Message-State: AJaThX7RDzy4NN5gQIgu2O5PjhFiTYZVtoZClVEbjyAMIywZ+60XdUSq
        4dPpcwojyISRy1tha0PeyJAJnqAc
X-Google-Smtp-Source: AGs4zMZdWGLWhpPKrlSQlAHaqP4USF09fIV7v2Fg8GrsfO5ONml1b3gTXeks1dW36MtP2+Tj7Lys4A==
X-Received: by 10.223.132.194 with SMTP id 60mr29563098wrg.249.1512772221235;
        Fri, 08 Dec 2017 14:30:21 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o48sm9688661wrf.85.2017.12.08.14.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 14:30:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] Makefile: use the sha1collisiondetection submodule by default
Date:   Fri,  8 Dec 2017 22:30:00 +0000
Message-Id: <20171208223001.556-5-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171208223001.556-1-avarab@gmail.com>
References: <20171208223001.556-1-avarab@gmail.com>
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
NO_DC_SHA1_SUBMODULE=NoThanks is supplied.

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
    NO_DC_SHA1_SUBMODULE=NoThanks.  Stop.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     | 34 ++++++++++++++++++++--------------
 sha1dc_git.h |  2 +-
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 3955b02b6a..aed9d3001d 100644
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
+# option might eventually go away in favor a hard dependency on
+# cloning git.git with "--recurse-submodules" or on running "git
+# submodule update --init" after cloning.
 #
 # Define OPENSSL_SHA1 environment variable when running make to link
 # with the SHA1 routine from openssl library.
@@ -1026,8 +1027,15 @@ EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
-ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
-DC_SHA1_SUBMODULE = auto
+ifndef NO_DC_SHA1_SUBMODULE
+	ifndef DC_SHA1_EXTERNAL
+		ifneq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
+$(error The sha1collisiondetection submodule is not checked out. \
+Please make it available, either by cloning with --recurse-submodules, \
+or by running "git submodule update --init". If you can't use it for \
+whatever reason define NO_DC_SHA1_SUBMODULE=NoThanks)
+		endif
+	endif
 endif
 
 include config.mak.uname
@@ -1497,19 +1505,17 @@ else
 	BASIC_CFLAGS += -DSHA1_DC
 	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
-	ifdef DC_SHA1_SUBMODULE
-		ifneq ($(DC_SHA1_SUBMODULE),auto)
-$(error Only set DC_SHA1_EXTERNAL or DC_SHA1_SUBMODULE, not both)
-		endif
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
@@ -2643,7 +2649,7 @@ dist: git-archive$(X) configure
 		$(GIT_TARNAME)/configure \
 		$(GIT_TARNAME)/version \
 		$(GIT_TARNAME)/git-gui/version
-ifdef DC_SHA1_SUBMODULE
+ifndef NO_DC_SHA1_SUBMODULE
 	@mkdir -p $(GIT_TARNAME)/sha1collisiondetection/lib
 	@cp sha1collisiondetection/LICENSE.txt \
 		$(GIT_TARNAME)/sha1collisiondetection/
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
2.15.1.424.g9478a66081

