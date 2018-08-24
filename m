Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2661F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeHXSzk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:55:40 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37930 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXSzj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:55:39 -0400
Received: by mail-wr1-f43.google.com with SMTP id w11-v6so7792549wrc.5
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZMEEK8ygGclTD6dmdREKgasolZh/AYH3dCkmK7Otqk=;
        b=IgK3mcDf+uFGT8mGhH7kOBKlNILQb8Db/umIX9QySu9imJFjKGSmxa51FphngKWrqQ
         ztAuf5OzQh3WYXEmQk4RZdCaHgDWH0FEfVh7UFLDOodjaoOhIhk5eq3eDL0jVeoJSAig
         VE23B27ApY1uSsii7EKjv2d/1MRb72KcQaPsj5CljTjUGhwPaHqU/EjOkonNxqzzsbIC
         cI7imHYePlzGmU4ETvKjp4usx9mr+b/sS6Apm2v45pDvQ7XY0bYc7lwqZ228LsFlF55P
         WAXwSbtnGawWAWOJNDKfWi0nuNlBn1BMlqpjGhymXIXDHQV57xpCTFQmCZMIg2ldgmfm
         Di+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZMEEK8ygGclTD6dmdREKgasolZh/AYH3dCkmK7Otqk=;
        b=HBwjYe2iAlK76y0KlNGl6/DLTMls6DY08ld66fbMjc/lsa9x5dc3YlMO/14o58/eu9
         PpjFWjpSj7Abx5rxA4Q7ZTUwLu7OZOGqxSfHaSdJ7s4SRXjix63gRznhwmKuMmyLs75y
         4wyaPZjUVBXRYN90J8AVtv5mu2yc+CRqf3muTmIPhsOrGXfDxhDB6dZT9FYbZDLIWsxd
         Bjldz3/Q6beuPXDfrpm1687E4RbgtKGoKPQ1a5bw2Plb2NKmNYMkSJCaXH7ft9RKljtk
         1BNLssJ0OERBWO8nuF6AlHU3r9V5Hc2xhFAwtUDAZYdxhTRKktGBLFFenFWiFKuiD4Yi
         qzqw==
X-Gm-Message-State: APzg51DoAdxB47b8AehDA9xwTMG+ZYBO5OT1wUxmd1jRnZ0uTBmy1BN/
        Qw2tE6KfoKeUiwYTPydpBQXqegRdqzk=
X-Google-Smtp-Source: ANB0VdZDBHwkPYJAhzDSxsGhV2qOGjG+LisXkpgCAl/Lc4IS0/s2fO+7T0lhAU0Z3eaiqhM3cE1NhQ==
X-Received: by 2002:adf:b69a:: with SMTP id j26-v6mr1515733wre.55.1535124032706;
        Fri, 24 Aug 2018 08:20:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id z16-v6sm6689485wrq.78.2018.08.24.08.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:20:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/6] tests: fix comment syntax in chainlint.sed for AIX sed
Date:   Fri, 24 Aug 2018 15:20:13 +0000
Message-Id: <20180824152016.20286-4-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a comment in chainlint.sed to appease AIX sed, which would
previously print this error:

    sed:    # stash for later printing is not a recognized function

1. https://public-inbox.org/git/CAPig+cTTbU5HFMKgNyrxTp3+kcK46-Fn=4ZH6zDt1oQChAc3KA@mail.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/chainlint.sed | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 8544df38df..dcb4b333ed 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -131,9 +131,8 @@ b
 b
 
 :subshell
-# bare "(" line?
+# bare "(" line? -- stash for later printing
 /^[ 	]*([	]*$/ {
-	# stash for later printing
 	h
 	bnextline
 }
-- 
2.18.0.865.gffc8e1a3cd6

