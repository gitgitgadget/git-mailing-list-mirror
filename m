Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1601F516
	for <e@80x24.org>; Sat, 30 Jun 2018 08:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934127AbeF3Igg (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:36:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37176 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933883AbeF3IgO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:36:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so4156760wmh.2
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=focbYFsTd5KHClz9Jshbl45BcrMnDIfuRdX+JdWWQJM=;
        b=PbKGhpxRunz7681vrUhpIvuztYMniu9nkBeQ9EeTu7dHHXpHkHQ9q6TweTS1fQ90jS
         6AW/HbTBL/ZbLKU2tWrswa3Gv9awAfCblMd0Tbb99lhLDnmJE4IzhQ+NkiGHTv3Ky24v
         CsY05i+zN/uFlbtRSvYLAoMkSQRAdhzCKKxqfmyzH0B1VVa/TUf29ihOQWwPZc85x5Rd
         zVmd6MknNVguvedWQzA9Kbu/p1RoloXYIVU+zDf6Ozohie1Er2xjwIj74707e7JcztDh
         9OinhUjz/1FpdZ/Wn7jPRLjSmlApu015GCdrMHylvM4T7jueEFiis1NO//NqGNWoBkub
         SUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=focbYFsTd5KHClz9Jshbl45BcrMnDIfuRdX+JdWWQJM=;
        b=pgXgZct3bwz8Aahpd0aVSZ5tLLKnIRsCtmtY0s5OCHeIEQ5fHZE433U2oZPqwsUt76
         /Pi3Yzcm9RQH8K+gDI5bARivf6QxFncpqhrVRsVi9+t1fxCcQWcaLELHYF9IL2yHzRq9
         CKS8guI1XqQpWEdEvrt/BotzO8ZhGOhYkbBafaMidkIj+nTX19qVKLnxruVoBwWolAc7
         5x8r/GhNPUOgkGLQeUwDa49FG+sVnkFVClMW3aXD+1H2x2JDJgutH5/xX+MLePGWdC5Y
         jEBnNhxVcOxnTs6xJ2tJUi/B4/YdmrHzYpS+je5wZvY1HYeVxUZb7QIMrhzZVdstqaKW
         6r7A==
X-Gm-Message-State: APt69E2OHKa58nJvdQ/XyyLRFdhHww5RjrvxtDYOFDv54OeJvcsCFytF
        ZUa6nujLcoQ4eLR/73dFfG05oQ6J
X-Google-Smtp-Source: AAOMgpeaiFQR1TrN1eaXtyvqE/clEmNvvuvGT0D39EZQm8jtQ0oREYmWr8OfbqpViDqfwT7juagsTQ==
X-Received: by 2002:a1c:ab02:: with SMTP id u2-v6mr3826461wme.10.1530347772940;
        Sat, 30 Jun 2018 01:36:12 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u70-v6sm5338356wmd.3.2018.06.30.01.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:36:12 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 9/9] Documentation/config: add odb.<name>.promisorRemote
Date:   Sat, 30 Jun 2018 10:35:42 +0200
Message-Id: <20180630083542.20347-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g8117677157
In-Reply-To: <20180630083542.20347-1-chriscool@tuxfamily.org>
References: <20180630083542.20347-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/config.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1cc18a828c..066858886b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2505,6 +2505,11 @@ This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
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
2.18.0.138.gac082779dc

