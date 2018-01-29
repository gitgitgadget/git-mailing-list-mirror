Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFAB1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeA2WjW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:39:22 -0500
Received: from mail-qt0-f202.google.com ([209.85.216.202]:33120 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbeA2Wit (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:49 -0500
Received: by mail-qt0-f202.google.com with SMTP id l6so9642942qtj.0
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=z06GV3cXJahZJ0bBzk0p0Ax3rm4R3QLlbgsYCeOglIc=;
        b=keOIuKG6PKIfySRdjcQC33B1pJd9wwqcY3auyD9nCa8udeT9Gocb9ks8BltPSK/MIe
         J7Ck8PACbjR48yp2pJh3GbakKqK4RGwrAqXqPyU5aqBjvILmTO6naPb9gXDUsdq7TTCu
         j/X4ERtPeUuA6lQp6tLw9gvSrOqO0jSxCqstu7vJdPS8dG0ThW/41jbURQgnc1fxo2t5
         uLOUK2hdfRq89m/JVu8TQ9c3beQE17fadd4Y4P9pUmpOBNOHijHTK5XIRVQLn79H9JMO
         HbMB7X9/L4aYy6LivHmV1l23zkRpVM6+BdQxiuwuLJo+HJ5fJbuPYy2cx+boXgcIUOno
         DCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=z06GV3cXJahZJ0bBzk0p0Ax3rm4R3QLlbgsYCeOglIc=;
        b=M5nP8p2itZPbaOjL0gHTgo5lEMWTi9N6CQQBXqDhUUTlafSRSFFRSlo2G/QRj6kPlZ
         T8jTQiZFT196+laW/N+ATo48Rdeaw7gnvP6JnKImD+r0uleWO7d7D1VnSW0RePKGKOEP
         T4iXK6dI12tuTYC45h9AEZdRB6y6U2dLOWc6ljw+rTM/VB8nUl3E7HjVxU0i1oRjSXBY
         i2573wesyGN3qGpvfvicwwM8pV0Y+wd32m1pAo0IftKd1T8HlVeRYTZ9/ObFBm9axIlP
         lLGcvEmU9wVg5YClwUsVMoboafoLGM0LfWQUJmpVuhx4yFszFmKWFt57uN6WnPnGUUj5
         6Pjw==
X-Gm-Message-State: AKwxytcU4t3X3J4Cz7oITsXcaiROghlz2DLyijPEFa83UWBB7qlR8tn8
        ZC9SM+hWB3/ETLz10KCNbwF6eCv67068pnHSot+hak8y3XBZvZ/briQiV3swhcJxQq9HYPr3FF1
        vUNj4vvdGiIhnZDHLOuU2FXEc2u1LMLy/1E8MrwVbPCa94zH/LuOGrasgNw==
X-Google-Smtp-Source: AH8x224LdqLDrFP2jdA5LEqahu1EYRxv/XR1Vt7n563Qo87dPfluYlmIka4ioDsBaiDKqgH2ReEBWrJgDec=
MIME-Version: 1.0
X-Received: by 10.55.125.67 with SMTP id y64mr16822032qkc.38.1517265528752;
 Mon, 29 Jan 2018 14:38:48 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:20 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-30-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 29/37] unpack-trees: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 unpack-trees.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 96c3327f1..bdedabcd5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -194,10 +194,10 @@ static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 static struct cache_entry *dup_entry(const struct cache_entry *ce)
 {
 	unsigned int size = ce_size(ce);
-	struct cache_entry *new = xmalloc(size);
+	struct cache_entry *new_entry = xmalloc(size);
 
-	memcpy(new, ce, size);
-	return new;
+	memcpy(new_entry, ce, size);
+	return new_entry;
 }
 
 static void add_entry(struct unpack_trees_options *o,
-- 
2.16.0.rc1.238.g530d649a79-goog

