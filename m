Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348EC20248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCUUvR (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42984 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfCUUvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so52901wrx.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7MUOzoinUH+dakHOnaP8IBFkNo1KZRRa18U2IhUNSg=;
        b=rGm9hqedLECqnUcgcO3nU6AVXp2s+t4FESXUmB/U7ChUKbGN5HKMdd/MmsGB0UgG1i
         HNpAnsbDXTIVTzRmNdkHSygDN/de53bpVoeI4qM1gBYvggANyk0+EjT84Pz9JnhdpkkK
         aI2UX21omu7LS02wxGF1oKaaWJMiiIDWvEI3v1OTtlJNP8Dpy36XCMaz0b/UuAjbMjB5
         K4HnRJ3+l1wfhuxUp7RxsijR+5JORtmWtAqLpKKvAMna9qs7h6qSDBHYTq6Q+Dgqt7nb
         GSJhgg0k1LCUFLsy7a5r/ixPMEPOTXsm+ZHFoFwaumC3IFEf9XQT+iPVyQKyci4s+64G
         AzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7MUOzoinUH+dakHOnaP8IBFkNo1KZRRa18U2IhUNSg=;
        b=UTYsUYVevUee52T+mjPaSsTpKUjBQ7FupcDjIROAydzcTIC36ZAE7F35NK0crpC5Fn
         OWKyfkhJ1J6UxswaXrduX0DTVxAZgzzODpuxhnnTnX3BfpErwhnRIXiu1Jsq603Cp4g/
         PNW6vybcwB4fNOh+Li4TBJOQerTcQBJPF7Xrv8fJqegXXID1ub/5LikL4VcIkaQwFXPM
         kWZ18m/HzZwmY0kEzxqHVpqpmB034kaagNDGAzI/Jj5TdBWbNSaePpq3umV2deDLCQwS
         StXl1TWlZKoLQRodkTnvFm8l3T7hI5o+AdWqi0C82zD7Up99xjcvlgbkooIQRg37OImA
         nKYQ==
X-Gm-Message-State: APjAAAXVG6MAdcVWkMse039mra6oP7WFp5V/BCU0/VIaG7R2GFefqTw5
        KB7MyyzImmdQUTW4gBweVgVeWc03
X-Google-Smtp-Source: APXvYqzYV+xRmsBCdU62OTeP2IyQaAAIN8pKRXjv/mZST1gkfqwXefIncXOKWM/TWGSEFgJwVTUY5A==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr4150359wrm.322.1553201474356;
        Thu, 21 Mar 2019 13:51:14 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:12 -0700 (PDT)
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
Subject: [PATCH v2 07/10] gc docs: downplay the usefulness of --aggressive
Date:   Thu, 21 Mar 2019 21:50:51 +0100
Message-Id: <20190321205054.17109-8-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
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
index ba1ff9b4cf..c50ec30c83 100644
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

