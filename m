Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C17720248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCMXzF (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:55:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36324 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfCMXzE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:55:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id e16so984738wme.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+iL6dl1yDQlUGoOck4JvcdQ8uYxDyBjc9w2fMTfs6E=;
        b=ZpG7YwELeANCXp2QVrT67hBx/xAjne+u+SyAKwtOBOvAc8k7gcL2U33+lHYWOybZDS
         vmpeNu/xumS2b2i13ywIvhRQYIDTLXCCYr41bMJg9zdI4SpbOJpLnLo+yA2qljPo8CZD
         EG1uGjlQUHYWGnHg0J2Nhn/6xah9oHOvIRqQsKX7vMSidnhL4fKkjdQQZ189CqnZZ94e
         pzInOJeKSTNVbA9CODxzE8OMmr13cLEGsZbx85XktPNIO59BQW41+u78vFjjguqgJeAd
         HQ2/c2ZCExCqcHS0kAAiPbFw4LzT1DGUUNuvVuUCq3N65KjEJIGQwj5rpSNz43UmhGj2
         nyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+iL6dl1yDQlUGoOck4JvcdQ8uYxDyBjc9w2fMTfs6E=;
        b=TuxKJHDU9aOKq1yoyvialz6RKkQnBbpSCwfQ4erTwLN40VxVk5wXlisf5u6Q4tyv0D
         r9iwZGCYH6r7zBZvZbnE+EJtCzZ8IzzJrONBnb4WiSCzN5GcVo7vA50SvwN7pnk71jVG
         aVym8V+Q9qlihwlQB8n9jGpmDi5tF8oHkQnCyEw+750n1UMHOG+wRZ3mooz3yo/0omEm
         JeN/WnlxV8uV0NMXdd+LHObDO/aaWHPcSU0jqxbP7ZPhiu8syyHMR89gJt5DYucZgzDZ
         WTWQRZh+R8r1BcyPCETTqF0SHtggFTXchmDKBVlSHIKQQmw8k4tddr+8BvDhkcvDnWa6
         RUSQ==
X-Gm-Message-State: APjAAAUirNSHCXxZKNJdRLU/jFbFb6mB+VnPYa7QLfexIps5ictBW3jn
        xgdMV6oHOvK2LuDTJId8RRv1bUbnUek=
X-Google-Smtp-Source: APXvYqzO9zOhfvGU7Sk3znjfb8PJZoO4mFRj4igg5uBWVbqg8wSoFWltQuPmXEGkOsZbED/4MiFKAw==
X-Received: by 2002:a1c:c3c3:: with SMTP id t186mr455428wmf.8.1552521301774;
        Wed, 13 Mar 2019 16:55:01 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b10sm9998566wru.92.2019.03.13.16.55.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 16:55:00 -0700 (PDT)
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
Subject: [PATCH 2/5] gc: convert to using the_hash_algo
Date:   Thu, 14 Mar 2019 00:54:36 +0100
Message-Id: <20190313235439.30439-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <87imwmbv7l.fsf@evledraar.gmail.com>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
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

However, we may want to modify this code for the hash function
transition. There's a potential pathological case here where we'll
only consider the loose objects for the currently active hash, but
objects for that hash will share a directory storage with the other
hash.

Thus we could theoretically have 1k SHA-1 loose objects, and say 1
million SHA-256 objects, and not notice because we're currently using
SHA-1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8c2312681c..9c2c63276d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -156,6 +156,8 @@ static int too_many_loose_objects(void)
 	int auto_threshold;
 	int num_loose = 0;
 	int needed = 0;
+	const unsigned hexsz = the_hash_algo->hexsz;
+	const unsigned hexsz_loose = hexsz - 2;
 
 	dir = opendir(git_path("objects/17"));
 	if (!dir)
@@ -163,8 +165,8 @@ static int too_many_loose_objects(void)
 
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
2.21.0.360.g471c308f928

