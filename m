Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA7420248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfCVJdS (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42969 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbfCVJdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so1523955wrx.9
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTTQxMmGI7f0QN1UVXgcYOBv68WULak0tHw22nssWfU=;
        b=jwv4w9rw9JfSezgLo9QNgGQgXyv+DK7Twd/yMurOTrUuxJCS7LkrtFgMjS+KBpsWl+
         zhMvZDnghXRTuv2gkzkX0NO/oN71gpEY5aqHoGUAihz96z417zM4PiozLrZDxYHlDnYz
         yTr62nFrtXJRX8P7tmms4m4ZKm3IpUHEhoNxLsMGOAGF7vHoZw7BJHfhjMDOUTabRzKg
         XBXAsf3tTKJ+hDsVbeqCfGtSYGsVuOTB5fNlCAh8Ig4C4bcBoMYcXw1TB44f2DgOaajs
         pS8vnNHNQlO5leGp2uJBLTXn8hYn5I7s9m3BUE264wyzQUC+eX1tMpQmlRayDvQDnA5W
         Zicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTTQxMmGI7f0QN1UVXgcYOBv68WULak0tHw22nssWfU=;
        b=L6XG8aeCyI7iwj3mDRGvjLndZFMOGjyF3N2Hwk4DNRgB0aabLMavuYjYqMyzyr66Ak
         nohL9nfLlkxMIvfxIIHv5vlRbup2MV2/9gm/tUsrTFu1pHMItEZnPK1mT/pB+KeHTMfy
         uiqU4Mla+blhFVxV0ygnkrhp1JcWlXR4y3WL6GI2rmTbXs6H/7rkEWfGKUBglenKT36x
         MQlXlFPlq3XEHZM1DplP7OneSiVivXu4xZ6iorhsIQuJ1MFz5vFFzitJrwTqnz7Ise7M
         URqq4EgjpwhgFhej3v9oJeemV97fW5GxnQmwJqcKx59f5tibzNX2F+9JfoG4m7QcfzIX
         86gg==
X-Gm-Message-State: APjAAAU0KItQu3wKBGU8WyI0DrgXgf2qq2+dSQmNa6lbTBme24NEDMBS
        Y+F5eQK21lxMuomRPq32m2mob6G8Njg=
X-Google-Smtp-Source: APXvYqwChULFCaYOjVCwOLrbzyC0JMrkXr9Pp9+2CBakHFJ4Lmc5a6XmwBUGMNiAitNk0FqQRnXqXg==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr2216607wrp.317.1553247190099;
        Fri, 22 Mar 2019 02:33:10 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/11] gc docs: downplay the usefulness of --aggressive
Date:   Fri, 22 Mar 2019 10:32:39 +0100
Message-Id: <20190322093242.5508-9-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing "gc --aggressive" docs come just short of recommending to
users that they run it regularly. I've personally talked to many users
who've taken these docs as an advice to use this option, and have,
usually it's (mostly) a waste of time.

So let's clarify what it really does, and let the user draw their own
conclusions.

Let's also clarify the "The effects [...] are persistent" to
paraphrase a brief version of Jeff King's explanation at [1].

1. https://public-inbox.org/git/20190318235356.GK29661@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index c037a46b09..165f05e999 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -39,8 +39,7 @@ OPTIONS
 	space utilization and performance.  This option will cause
 	'git gc' to more aggressively optimize the repository at the expense
 	of taking much more time.  The effects of this optimization are
-	persistent, so this option only needs to be used occasionally; every
-	few hundred changesets or so.
+	mostly persistent. See the "AGGRESSIVE" section below for details.
 
 --auto::
 	With this option, 'git gc' checks whether any housekeeping is
@@ -78,6 +77,32 @@ be performed as well.
 	`.keep` files are consolidated into a single pack. When this
 	option is used, `gc.bigPackThreshold` is ignored.
 
+AGGRESSIVE
+----------
+
+When the `--aggressive` option is supplied, linkgit:git-repack[1] will
+be invoked with the `-f` flag, which in turn will pass
+`--no-reuse-delta` to linkgit:git-pack-objects[1]. This will throw
+away any existing deltas and re-compute them, at the expense of
+spending much more time on the repacking.
+
+The effects of this are mostly persistent, e.g. when packs and loose
+objects are coalesced into one another pack the existing deltas in
+that pack might get re-used, but there are also various cases where we
+might pick a sub-optimal delta from a newer pack instead.
+
+Furthermore, supplying `--aggressive` will tweak the `--depth` and
+`--window` options passed to linkgit:git-repack[1]. See the
+`gc.aggressiveDepth` and `gc.aggressiveWindow` settings below. By
+using a larger window size we're more likely to find more optimal
+deltas.
+
+It's probably not worth it to use this option on a given repository
+without running tailored performance benchmarks on it. It takes a lot
+more time, and the resulting space/delta optimization may or may not
+be worth it. Not using this at all is the right trade-off for most
+users and their repositories.
+
 CONFIGURATION
 -------------
 
-- 
2.21.0.360.g471c308f928

