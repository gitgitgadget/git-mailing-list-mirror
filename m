Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C131FD09
	for <e@80x24.org>; Tue, 30 May 2017 07:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdE3HMw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 03:12:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34985 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdE3HMu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 03:12:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so22848080wmc.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9AKHIGelLK+WFQAHa2cSoPiR+65FEmQ2HmO6fqXqQo=;
        b=R26Z6uwSv/dVsIaEWV/9cwLpo0s98fStklCrd+1Zhu6LDQD+lGIpdAAA+p4ujZDiBv
         BcbMCz7gOX6r4gopfLy5v7MK0Ma1fjKSkFq7pajJ+NLiJqaTbfkPh1y4rOxNDmmQgkjQ
         pgVdT7/3do3it4x1+J8AePj4N8M0rrlyyTLnzneLDQlgiiO6AtrwBl0NVDLWcVsDHaDp
         7Oq64LJTd/0oqgAFbqoPaDnj7dsTDw/BdF7WNINoHc9+KsVeqLRkOHs2tnOKJnlK8Oio
         FuIhSjuQOtdKx39NCYKQunk/v6dUUDu1g8d7Z0xhaM4hhGM4upVAdj8Eh/yppMfooWz5
         V1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9AKHIGelLK+WFQAHa2cSoPiR+65FEmQ2HmO6fqXqQo=;
        b=G7qvyF5y5rxWkubsQ2lGgOtKV4p1YkNbM4wknxGrGON3crTCIM9TtWlfiGGmKpXJ/b
         cKfvbJRmurxwQ/3NpkchLNIqcEaPnAQCHKVF+mlhb7dw2r4GooKBtmDw1mXGhTIOgYUx
         DEBYwfTpm47DKpE5UQANaN/1uYOCHQrVjYzq6qWswLB4M3W4KEwje1XlemNlbCbyboT/
         mgfVD9y95gaJYtdZB0WS5wmv/D1YpfGumuc3ETKCt7lvqOQt5n67cxUl6unrWCHG+ATy
         7cKY3DMGUHkuMVRup6vGjasXmvbUuZ6OLIa/cpH/5L1dDdl6FKVVzmQdSryFMSR6pkWo
         ysTA==
X-Gm-Message-State: AODbwcB5CskLh8IJQjR/7ANY+1HgT88LgziOhcF22FMF5DiE5cWTXIdF
        LWG3sx9quJjNvA==
X-Received: by 10.80.180.155 with SMTP id w27mr15520677edd.42.1496128369657;
        Tue, 30 May 2017 00:12:49 -0700 (PDT)
Received: from localhost.localdomain (x590e041b.dyn.telefonica.de. [89.14.4.27])
        by smtp.gmail.com with ESMTPSA id h33sm4524245edh.50.2017.05.30.00.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 00:12:49 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv4 2/2] Documentation/clone: document ignored configuration variables
Date:   Tue, 30 May 2017 09:12:44 +0200
Message-Id: <20170530071244.32257-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.35.g14b6294b1
In-Reply-To: <20170530071244.32257-1-szeder.dev@gmail.com>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to limitations/bugs in the current implementation, some
configuration variables specified via 'git clone -c var=val' (or 'git
-c var=val clone') are ignored during the initial fetch and checkout.

Let the users know which configuration variables are known to be
ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
documentation of 'git clone -c'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-clone.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index ec41d3d69..4f1e7d4ba 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -186,6 +186,10 @@ objects from the source repository into a pack in the cloned repository.
 	values are given for the same key, each value will be written to
 	the config file. This makes it safe, for example, to add
 	additional fetch refspecs to the origin remote.
+	Note that due to limitations of the current implementation some
+	configuration variables don't take effect during the initial
+	fetch and checkout.  Configuration variables known to not take
+	effect are: `remote.<name>.mirror` and `remote.<name>.tagOpt`.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-- 
2.13.0.35.g14b6294b1

