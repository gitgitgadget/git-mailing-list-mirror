Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3959220248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfC1QOw (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:14:52 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51336 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1QOu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:50 -0400
Received: by mail-wm1-f49.google.com with SMTP id 4so4204064wmf.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EMAcE/X1m7BcvyXZHuHHhBEhMHnX15dn/fKh//SV49U=;
        b=EtJi2Lxn99Tfz/6BTYIeyGw3udHyXdNClQlvzwxQK8IOzUiYYFWmDkOLmpTpbBWwul
         9EcT3M+5UlY6I55PfBr6XSWST5LCPRN4/S0IViRzbqJ7NX4/qkeyCJsCP3BhXGuKU6BO
         GMi6qX/MeJyUlpQzOKOYUl72GnNxhdNFZ8EB7ricvj0W/Dtyag4mdJ1C3gsRk7nnPBrJ
         kPjn6ZHCE0NNqCKm4SjlYJmpy/fnF5LsDZW1ErP++HurbRvmBCf4CvH389tq/a1+oUCy
         QePknJ1nOR5fW9Xko2Oii2rt8veRs8w6BiHalEI9DnHnvMSo5QB0LQ0u5zLfZ1vQTJgj
         1lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EMAcE/X1m7BcvyXZHuHHhBEhMHnX15dn/fKh//SV49U=;
        b=GC5dja+tqlg0/osGiUhp0Gc5/TVStajgEYpy61Ku6W2yYp2byE/K9mpgkxJG0ct89T
         7gT0X5bt7DvVDdMHFnEKeWBvc242ZOPzgpqE4FtsuyJrRhYz+fpSed5hIui/X3DzCoy0
         T3q0IFKR9+hN1GBsLU4AVqHPR5P3VQHLF4U+H5QbIg88eaB+qcF/5j8VaPHC203dr0/M
         ymtLQDNOmidPrLAkddJzDyvdJRcN/f0o74K1Z8RVlqudJPx83FOxwvFalz4p6mzsF7TL
         ZVtOBpMp7XW4ibe764rTXYqEHpAH9qH1YkcKgeTrtVs5OReYafXPdzgFA7qN0yUNgCMn
         clkA==
X-Gm-Message-State: APjAAAUXJD1yAWha6TZg9nKy9mnUmL+SU7uBIQPkMqtfzyTu0wyve7+S
        y7hvodh/LPhWZORFNgLZilPsWKB1
X-Google-Smtp-Source: APXvYqwTxR61RZYspdpbJBqlUAqOS+SsAm8jFRmPibxg/8pIGFMnIOQ3bKO+JrENXwfuXRIBWyIANw==
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr559162wme.28.1553789688304;
        Thu, 28 Mar 2019 09:14:48 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm25519089wro.79.2019.03.28.09.14.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 09:14:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/7] gc: convert to using the_hash_algo
Date:   Thu, 28 Mar 2019 17:14:29 +0100
Message-Id: <20190328161434.19200-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190315155959.12390-1-avarab@gmail.com>
References: <20190315155959.12390-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's been a lot of changing of the hardcoded "40" values to
the_hash_algo->hexsz, but we've so far missed this one where we
hardcoded 38 for the loose object file length.

This is because a SHA-1 like abcde[...] gets turned into
objects/ab/cde[...]. There's no reason to suppose the same won't be
the case for SHA-256, and reading between the lines in
hash-function-transition.txt the format is planned to be the same.

In the future we may want to further modify this code for the hash
function transition. There's a potential pathological case here where
we'll only consider the loose objects for the currently active hash,
but objects for that hash will share a directory storage with the
other hash.

Thus we could theoretically have e.g. 1k SHA-1 loose objects, and 1
million SHA-256 objects. Then not notice that we need to pack them
because we're currently using SHA-1, even though our FS may be
straining under the stress of such humongous directories.

So assuming that "gc" eventually learns to pack up both SHA-1 and
SHA-256 objects regardless of what the current the_hash_algo is,
perhaps this check should be changed to consider all files in
objects/17/ matching [0-9a-f] 38 or 62 characters in length (i.e. both
SHA-1 and SHA-256).

But none of that is something we need to worry about now, and
supporting both 38 and 62 characters depending on "the_hash_algo"
removes another case of SHA-1 hardcoding.

As noted in [1] I'm making no effort to somehow remove the hardcoding
for "2" as in "use the first two hexdigits for the directory
name". There's no indication that that'll ever change, and somehow
generalizing it here would be a drop in the ocean, so there's no point
in doing that. It also couldn't be done without coming up with some
generalized version of the magical "objects/17" directory. See [2] for
a discussion of that directory.

1. https://public-inbox.org/git/874l84ber7.fsf@evledraar.gmail.com/

2. https://public-inbox.org/git/87k1mta9x5.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8c2312681c..733bd7bdf4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -156,6 +156,7 @@ static int too_many_loose_objects(void)
 	int auto_threshold;
 	int num_loose = 0;
 	int needed = 0;
+	const unsigned hexsz_loose = the_hash_algo->hexsz - 2;
 
 	dir = opendir(git_path("objects/17"));
 	if (!dir)
@@ -163,8 +164,8 @@ static int too_many_loose_objects(void)
 
 	auto_threshold = DIV_ROUND_UP(gc_auto_threshold, 256);
 	while ((ent = readdir(dir)) != NULL) {
-		if (strspn(ent->d_name, "0123456789abcdef") != 38 ||
-		    ent->d_name[38] != '\0')
+		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
+		    ent->d_name[hexsz_loose] != '\0')
 			continue;
 		if (++num_loose > auto_threshold) {
 			needed = 1;
-- 
2.21.0.392.gf8f6787159e

