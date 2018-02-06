Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	TVD_SPACE_RATIO,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2E21F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeBFATA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:19:00 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44592 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeBFAS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:18:57 -0500
Received: by mail-pl0-f68.google.com with SMTP id f8so113012plk.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YYCbPRydpRMt81g1uWkOC/GBNvdHZCTnx2DvVJpvt8w=;
        b=n00xg+xpbF4Q/ZWEkMKtQ5Q2FIOskNkPV8pxb3AebQ3CywAYzXSqAHzEb5/adgzQ6n
         iQ63rSQy3SMmuRVyPLzHgtKs5YIsVOtn4tuBIG4CINR23oAr+H9shdKuz4qMCE7w6Uz6
         KwjHLKZf8C+2TSylpj9qMST3YsoAWjO9hEBUljTM+oyzUjSQV4bmM6CQ9qddVmjHbfxQ
         /23S6yoLCOK/jOnWMEmVv4iU2DNkBAUwnpeNFC37lCWk+qBfvPzfCEIszaBTqqB1KuQE
         g4Jiky6VGu1T8w0/C5kRnuY1ws9GvU2s0/B2pyW8Wl+4hTcduYGe/ZUZC8LGLpOIlu64
         5h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YYCbPRydpRMt81g1uWkOC/GBNvdHZCTnx2DvVJpvt8w=;
        b=tOxOhDH1wGYG8Z55DqfuqR8K+zx9mCT28nAit47BoAtdXNPQbybpuHT9USxdBRnZ7H
         viZG8QoctephLTfW0quMTJjNFkBqW/WYKk+lZUdteo0TTd3G1yOOwNSa/newJQypT0O/
         exVhw7XLm5bSPlHpwcydavLDaKBP1CPqLECMoECi0UJFo0l06iF4iC1CVtmvkVbq7aIw
         8B9NBMvBQAt9gF45IHnAPZOrjK2WNT2vrD2FLmYbLpyPlhEkrQfa/fxod3y80PyWYhCx
         jpkZzwyBygDpCS3mPOIBCmxe5pVcYW2/R/DCVWUESJVMiyNLvjYZbRjobiHK656UeRbX
         zS9A==
X-Gm-Message-State: APf1xPBJI+xAyGLlzoB5AlSw8zilBEmi6psdAAmn/CAiPhaKQYHbnx9U
        oHSJcvpLlRv4LHLZT/I1SirSrohjPjg=
X-Google-Smtp-Source: AH8x22665PQCbU83NGGOhrZa60O8ZaCA/cC/nz6rkpmD9C2+igWFlTbf9LZLmunu38bjz86VQ5jqOQ==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10-v6mr534956plb.181.1517876336689;
        Mon, 05 Feb 2018 16:18:56 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id x67sm12614622pgb.4.2018.02.05.16.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:18:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 106/194] Rename sha1_object_info.cocci to object_store.cocci
Date:   Mon,  5 Feb 2018 16:16:21 -0800
Message-Id: <20180206001749.218943-8-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/coccinelle/{sha1_object_info.cocci => object_store.cocci} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename contrib/coccinelle/{sha1_object_info.cocci => object_store.cocci} (100%)

diff --git a/contrib/coccinelle/sha1_object_info.cocci b/contrib/coccinelle/object_store.cocci
similarity index 100%
rename from contrib/coccinelle/sha1_object_info.cocci
rename to contrib/coccinelle/object_store.cocci
-- 
2.15.1.433.g936d1b9894.dirty

