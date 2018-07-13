Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3CBD1F90A
	for <e@80x24.org>; Fri, 13 Jul 2018 17:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbeGMSGL (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:06:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37162 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbeGMSGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 14:06:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so25897215wrd.4
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/R0JIhxHbJSnLCmAlprL9z/fNV84/OqGKdPP05g4E/o=;
        b=r38OO7/qYCAYrJCAEahyKpbthuEGglFPpxJVvkEW14xoFRXu+9FsJO5/LGKGQxS5GC
         OVD7Ic3jvknxRhcCJuPGmp3SToqGV9jVPcYWAAG89eYo7rgxGPdnZmTbxBF9JMYKRvyf
         i/H/x0ziVa4AmivWhgAlFOMAzOsAOEysRz1UV6xU4j+/SKgiLb7sWtEnMnZlJEZY3Wlr
         /Ibj+T3hvp+W4jH7lWe/ID0NkkDTylkFlYS4mcn0ak/hHMR+ibDwu1g5Jbb2k5xNzuA7
         fCyyW7T5gqKLfJlGFWvjFyuBAc4d6BYI9o6HgAdTtF8tg5U2UzLI+nh1KHahJbIVQF6C
         I28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/R0JIhxHbJSnLCmAlprL9z/fNV84/OqGKdPP05g4E/o=;
        b=XDjvHY/Wyx+wZJyrl1LwbfnE3xPKu+IzzXfUwGwkLchMuS/Zr+gHnn0I4Mmp3Jpr/e
         SPfnk61ZH/tgLwdKHiv2EFkuVa/BUaACYLR7/biktDw+Vf7JVpuzSDK5u7ldz7MfsMLb
         htYerYZnrgsh0g9FmokiOJXqPGUpWmJe9rJDJyKTA5etIZDWyTmf8bVIB9VOvavk9MIv
         W5+UESkrzQGwo1yGFoxO8Vh1zCUrLaZ/gbu7+P//3tDGm7S/Jfmp3xJm4XW7gCAF7iqT
         67HS9s3UARUMK0x2jiT9ld119Ct9F29enqEOhonPdzrcyuwylWiGj3VwXFzvhRqB9bhW
         TxEg==
X-Gm-Message-State: AOUpUlGWIg7Nor1CRwiqq/RrntlXSjKyOG37AepZE2L+JP6E049DvYJl
        ucRFtsMEz9v8R1/hev0m1N0NWCFq
X-Google-Smtp-Source: AAOMgpccYf182rMjATF+Ai+bfIesCPXQAPt2hOkVmviqir/Mfuug4+kZVYBK/hWILn4mB6tXbMRNHw==
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr5927442wrf.46.1531504231638;
        Fri, 13 Jul 2018 10:50:31 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id v15-v6sm6556862wmc.16.2018.07.13.10.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 10:50:31 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 9/9] Documentation/config: add odb.<name>.promisorRemote
Date:   Fri, 13 Jul 2018 19:49:59 +0200
Message-Id: <20180713174959.16748-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g7076a5fae1
In-Reply-To: <20180713174959.16748-1-chriscool@tuxfamily.org>
References: <20180713174959.16748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.18.0.171.ge260395bfe

