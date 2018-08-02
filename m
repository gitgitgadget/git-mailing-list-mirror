Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8059B1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeHBWnv (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 18:43:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37497 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbeHBWnv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 18:43:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so4037281wmc.2
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhaUacQ7XGMY8GpwHRuPJwzcC+UvLlKVKg3drN/yP6Q=;
        b=oW0pB163pKB54uHkymO2t9k+8g3lHzM0UFEXfOiDjwqlB7yNreqnmC9MMh6/JaphfK
         9NBzNBd3AdMcKLLUeYnHLCVfj3WCpNatOgUGKseqHIcQ6jz9BkkY2z75MBsNZ3pEdvUh
         +hGkztB2H70ckyQfBaFE/y6936m6LAzN9J8GLslSitatRoKIhZBbmTFGLGKhwr2hAI/R
         HJ8f8Mf6sUfvGKAo8Bd1PxmNxkdHslqw2AHddSlcMDMRWwyZsYX4kn05LEPLa6bYPcCs
         HoZ+ONXPdN6p0ZcYwS4EB1enTYyTbqK1vVxqIayZ9TDYbK+Nuka0epW6ifClpBWZ61M6
         5cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhaUacQ7XGMY8GpwHRuPJwzcC+UvLlKVKg3drN/yP6Q=;
        b=lQWwPOAeZeHhyJK+8nHEY9oFyIDB3ENcEPU30uREBIXzlny5zdcBHMtWgpvMBY3Mi6
         hHRkvY3hgrsXX+3MjJD2auSWAgo1/N8S/AqnV42X9i2VJQ/MDR//8zJpe7Whe2RYlABm
         svFqZwPk+d28Bds7KZn8Nlfvpd3LhPezEqFyXELBY8ri3dnbylJnxT814cb+gM/IvAgu
         eONVC4MgXc1s1zQmQjoH0Zh2VhCnboprteKAodjuNO5k7DdKwsdIL5ea3hA3o+KPAGDP
         xPD0cBQNeViS6c3meDIqWIjMGnrwBhHGlZQwRjuVCoC8NAIr0mvhtcYEyrWXOoqExjd7
         4PQQ==
X-Gm-Message-State: AOUpUlHiG4kgAqnLrJZOGj0P456VK7XD8G2IA/AhK64OjsuS2jn/wkiU
        TThYUA5HvrykNgXp7x908hlfEE4d
X-Google-Smtp-Source: AAOMgpeg8h61qnUsFc1y05fgGP1iOc3nEyyqzEVr4KGCGY3Yl3qcFEG86mAE8+BoiJ9bRGU9Pr58ew==
X-Received: by 2002:a1c:ec86:: with SMTP id h6-v6mr3019055wmi.53.1533243060625;
        Thu, 02 Aug 2018 13:51:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s16-v6sm1883705wrq.20.2018.08.02.13.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 13:50:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Felt <aixtools@felt.demon.nl>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Dan Shumow <shumow@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] sha1dc: update from upstream
Date:   Thu,  2 Aug 2018 20:50:44 +0000
Message-Id: <20180802205044.23631-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <87o9emtuf6.fsf@evledraar.gmail.com>
References: <87o9emtuf6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update sha1dc from the latest version by the upstream
maintainer[1]. See 2db87328ef ("Merge branch 'ab/sha1dc'", 2017-07-10)
for the last update.

This fixes an issue where AIX was wrongly detected as a Little-endian
instead of a Big-endian system. See [2][3][4].

1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/232357eb2ea0397388254a4b188333a227bf5b10
2. https://github.com/cr-marcstevens/sha1collisiondetection/pull/45
3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/42
4. https://public-inbox.org/git/20180729200623.GF945730@genre.crustytoothpaste.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Aug 01 2018, Ævar Arnfjörð Bjarmason wrote:
> https://github.com/cr-marcstevens/sha1collisiondetection/pull/45
>[...]
> It should work, but as noted in the MR please test it so we can make
> sure, and then (if you have a GitHub account) comment on the MR saying
> it works for you.

This got merged upstream, and as noted in that upstream PR I've
personally tested this on AIX under both GCC and IBM's xlc on the GCC
compile farm, it works.

 sha1collisiondetection |  2 +-
 sha1dc/sha1.c          | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sha1collisiondetection b/sha1collisiondetection
index 19d97bf5af..232357eb2e 160000
--- a/sha1collisiondetection
+++ b/sha1collisiondetection
@@ -1 +1 @@
-Subproject commit 19d97bf5af05312267c2e874ee6bcf584d9e9681
+Subproject commit 232357eb2ea0397388254a4b188333a227bf5b10
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 25eded1399..df0630bc6d 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -93,13 +93,23 @@
 #define SHA1DC_BIGENDIAN
 
 /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> */
+#elif (defined(_AIX))
+
+/*
+ * Defines Big Endian on a whitelist of OSs that are known to be Big
+ * Endian-only. See
+ * https://public-inbox.org/git/93056823-2740-d072-1ebd-46b440b33d7e@felt.demon.nl/
+ */
+#define SHA1DC_BIGENDIAN
+
+/* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> or <os whitelist> */
 #elif defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
 /*
  * As a last resort before we do anything else we're not 100% sure
  * about below, we blacklist specific processors here. We could add
  * more, see e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
  */
-#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist>  or <processor blacklist> */
+#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> or <os whitelist> or <processor blacklist> */
 
 /* We do nothing more here for now */
 /*#error "Uncomment this to see if you fall through all the detection"*/
-- 
2.18.0.345.g5c9ce644c3

