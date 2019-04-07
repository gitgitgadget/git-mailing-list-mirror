Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A91820248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDGTwv (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34809 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfDGTws (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so13681193wmf.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+IpTTkNwfSkvettm3Bzi8sNFtULOkYZCCkjUQUhHcQ=;
        b=HCI9fHQLdlWQKJ2BjeSjRAvu7le6tv5IR2QE1H2eJXItKClzne/JgtJier8QovRUiM
         A3QetDEAjofWxWkKMGuFcijVlHYQxLpaa/pg3qcyQCQvUTIlxrwgnxh0mcJI4XIfVo8Z
         Zieq/AioTd5LyRyQ82zcFvF2+AUjuRjkT2goY1l1dSKJT1PRF5uwK3cx53Tc/0YBAU/F
         m+LNmSPZXXsQE//HDbKblViVQuNAno14YpRw4rwFCfFxncGAzRnjF822esk06LnIYRHs
         SpUo/Ki4zTTDQUsIsYettMKsMA1drYBbiHaLatcBgGaOWAF20OCM+VXPywL3upORMDe1
         GO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+IpTTkNwfSkvettm3Bzi8sNFtULOkYZCCkjUQUhHcQ=;
        b=daafcAGqlHsglqlOkp3gYSbzeRDvHk3lAAxKxwXQLdyqLCk428rsmEMO01hOt/UkjQ
         mI6EuTRpxAfewTQlr2in2hiUY/DfVKbggF8wtOcW7icI5ErEr+Mq8O2jUdeYgxdAMTwf
         CSmM53oFdccAoAOCpQOkozoJE5RZCyEmNQfJkqIGAZHHwb6h0pczo22plw257ZJ8EQAr
         3rbBBRgCR5uKDveM/xCMto4EMqIqJJqAkPy254/Ryt9LVKmzUOO5JqGCT25rimRhFcqf
         E6SO1Qbn/q6r0T2MVC1ab3bYwBOCVvaN7aDsbhZy08AhJHRl6Ztr2JYP2XKujYpp4yXO
         pKwQ==
X-Gm-Message-State: APjAAAXzwrhr7nW3/c/m1tdk5/r7xCqH/CS/Vxhsg0boE+BogAQOoVPq
        flSmpsITvdgRG+57lECvDtz+ExZXuok=
X-Google-Smtp-Source: APXvYqzvzL9VinoB8u0VuZbCgUg0xJZ5VRt/H510JeAj0HNYW55ERYtEecyqU99sxTrLd+8r/7Mzvg==
X-Received: by 2002:a1c:7a03:: with SMTP id v3mr15935604wmc.58.1554666766478;
        Sun, 07 Apr 2019 12:52:46 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:45 -0700 (PDT)
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
        Johannes Sixt <j6t@kdbg.org>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/11] gc docs: downplay the usefulness of --aggressive
Date:   Sun,  7 Apr 2019 21:52:14 +0200
Message-Id: <20190407195217.3607-9-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190322093242.5508-5-avarab@gmail.com>
References: <20190322093242.5508-5-avarab@gmail.com>
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
index 37c4d26a76..5e80f306e7 100644
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
2.21.0.392.gf8f6787159e

