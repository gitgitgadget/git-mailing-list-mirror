Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F42E1F516
	for <e@80x24.org>; Sat, 23 Jun 2018 12:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeFWMTZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:19:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38251 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeFWMTP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so5297915wmf.3
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0jjQl8JQQACc5eKQCwo3MyR0JgieP22Uu5WKpdDm8iE=;
        b=lE9iUoTx6lLOsVI1ew2jA14IxvMHT3tLrTy4ND7kbDczEhMIoUiWXvW2B9+0OgZB/h
         gbsYHZ/gfuQVcuDNAPxdua77Z3jp7XfvvMFAuanHCUHmryXPiHkLNEWl0q9PeZhg1LKD
         QbTQvxf0ghEeohAI4JQBSSh9fkgFvMXyWEV0Sehs126p0h75LdA58Z+Ir5aZ6axHORhQ
         u9JKZO2toRKTlNJ6ajuMjrIiSe0fP4demXSFdsIFqfjGmEC/RTEqMrxoHGNSa/P0ZYoO
         3BD88yklzPQr3HvafHOh9v3VvUMAsl6xJRfRTFyKB1pb/NYHi34pEVtdsDZb2xBUAuDI
         4PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0jjQl8JQQACc5eKQCwo3MyR0JgieP22Uu5WKpdDm8iE=;
        b=V2GIFsM5ljefM59RJeLmLTzitQUPoD4Bp8Xioz5YQvv95R6GzfwOgsnmY/70FTZRTU
         6szN9psSFTTTspFAzohj8oPxlJwAfk8ZanvDIdMSEkDqiLj/dzuZZ7s82K9OIeH9Qvd2
         Y/Ij0LKPJK8AFftEhJCM2rs5YsZs9Cm6xXmeuexFjj8AKoFp9ouZRmyD+IVseRBWorC4
         IY7g2bdjH6Ev0RvYPYm/Cl3Gav7roR0j6zkJgJZ0b0UMmoI8KjvYZ6aniKjMe/uYeY1j
         6SfpsJq9Enw4oWdcp+30e9PwR9y2SHmbJu0rPwzCebHwBZLVcXH2CH06aI/0VUCeE8vg
         WXDA==
X-Gm-Message-State: APt69E3wBzX5ugdEfQwKr5D9oqdB8Vka32r7RafGsO3pq4g6sW5pp1kw
        loGOyqx/z0uckEhUgpNlEdk8cnVe
X-Google-Smtp-Source: AAOMgpfppVL1w2rdDA29EsgsrrH7tNqaloXpV22AE+Bm5LHJtiGwTNIJvWkfGzkO1AixB8v1egwfWg==
X-Received: by 2002:a1c:3b82:: with SMTP id i124-v6mr1780698wma.57.1529756353498;
        Sat, 23 Jun 2018 05:19:13 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5527731wmd.20.2018.06.23.05.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 05:19:12 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 09/11] Documentation/config: add odb.<name>.promisorRemote
Date:   Sat, 23 Jun 2018 14:18:46 +0200
Message-Id: <20180623121846.19750-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.762.g886f54ea46
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/config.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..8df0c7177e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2504,6 +2504,11 @@ This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
 environment variable, which must be a colon separated list of refs or
 globs.
 
+odb.<name>.promisorRemote::
+	The name of a promisor remote. For now promisor remotes are
+	the only kind of remote object database (odb) that is
+	supported.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
-- 
2.17.0.762.g886f54ea46

