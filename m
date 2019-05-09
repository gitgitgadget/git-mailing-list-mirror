Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3775D1F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEIOWh (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37833 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEIOWg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so2205034edw.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sv5vmWbc5juRCAMsYYTWzW/PZHLWJqBOAvm+GWswM1Q=;
        b=kn8SIihooLn+wj/xGcs42SOyEt0gBTNW7qvd19DG16FGv3z5cOtKUVFKntjRqmpKKa
         JvuztAsEx38KUoqcrxfSzch4EZ4qc1hoyS5GJTzn7lE0RFzEQDdvd9gfEu/78F0zPf47
         p5eLZR219llX0z/vUQ76B42WPPi+63st/Z6iP0es7Cnk7OfOuyCLoOgHtYmLL0Uou4qF
         Y7zf5OXXXoCSuDI6idAKsNCL9Du90Atz3VMMhxtsSJVsLKtoYQ8zQaavNHEliuRGFx95
         5q+l9ACNl1XXrW1+IXL6CR/8g0jUp6QX6wniQrdRoTQL6Lgzy0I6I/edRaZETO0S+Kl7
         TPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sv5vmWbc5juRCAMsYYTWzW/PZHLWJqBOAvm+GWswM1Q=;
        b=YviI+Jt6HTKJuSDVzQyC1arjY50zpUDcN11wmXtt6GnSuC2PzOuPXu/xaufS1qs1tS
         937mIXd89WxQCzpowHb/HwClaO6UbBHdvLxbarsBLd/v8qH9OlgqXq6ZARRnHotAVkys
         eQTpPBnOCZM9Qvk3hfcDOYOPsGRD5Uq6dkt6FiJiVuJs8FO4Th8iwdafEEO+f2XSNhZF
         HUopdf3V98/3gPsZ/vLDFTuGvhqmpFx6Uz/9+2oAnzlHpxXk6XDRmYYrZylc0mOzFfj+
         3NyWgROlqRuElDC9vfHJ2dxRLtWEUH0lpeO2r2RyXweSUXtXqs7cRX9btwOfmhj2GZpJ
         2p5w==
X-Gm-Message-State: APjAAAX4QwedS4hK6HXOt12pZAN5dJbS4qMzkunO8rsEH+z3iF4Ko6Zf
        Ub6HuQaG59H+jlRwwakak5ynkCE2
X-Google-Smtp-Source: APXvYqz7QBW9SmQirl2VLypLBUQrwXoeOkSDaMWlmZWEJSOofM9qAiAWBvbPc0POLvz7Snu3gewmWg==
X-Received: by 2002:aa7:c387:: with SMTP id k7mr4351976edq.73.1557411754809;
        Thu, 09 May 2019 07:22:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v26sm343361eju.42.2019.05.09.07.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:34 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:34 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:22 GMT
Message-Id: <130007d0e1ba274e5260aacd510c8104073fd7d1.1557411749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 04/11] commit-graph: remove Future Work section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph feature began with a long list of planned
benefits, most of which are now complete. The future work
section has only a few items left.

As for making more algorithms aware of generation numbers,
some are only waiting for generation number v2 to ensure the
performance matches the existing behavior using commit date.

It is unlikely that we will ever send a commit-graph file
as part of the protocol, since we would need to verify the
data, and that is expensive. If we want to start trusting
remote content, then that item can be investigated again.

While there is more work to be done on the feature, having
a section of the docs devoted to a TODO list is wasteful and
hard to keep up-to-date.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 7805b0968c..fb53341d5e 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -127,23 +127,6 @@ Design Details
   helpful for these clones, anyway. The commit-graph will not be read or
   written when shallow commits are present.
 
-Future Work
------------
-
-- After computing and storing generation numbers, we must make graph
-  walks aware of generation numbers to gain the performance benefits they
-  enable. This will mostly be accomplished by swapping a commit-date-ordered
-  priority queue with one ordered by generation number. The following
-  operations are important candidates:
-
-    - 'log --topo-order'
-    - 'tag --merged'
-
-- A server could provide a commit-graph file as part of the network protocol
-  to avoid extra calculations by clients. This feature is only of benefit if
-  the user is willing to trust the file, because verifying the file is correct
-  is as hard as computing it from scratch.
-
 Related Links
 -------------
 [0] https://bugs.chromium.org/p/git/issues/detail?id=8
-- 
gitgitgadget

