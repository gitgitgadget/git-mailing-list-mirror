Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87A31F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeIAATa (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:19:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37344 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeIAATa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so12234564wrr.4
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1wl9bIzYTXz4mAVGzBepowCuPPiMvBEBs3a9CeOaU4=;
        b=n+Z7D/ZVSZfHsmLh0pp+F59HiXYtXqhWc/3H5b4hR9hZ4NYdSKloviDVFvF1byfGZL
         KUmTo0SccXwpG+b70TwEktr7yJwlZ/oMi6xfsrP7hCdZeiJJwJxoXLq+AZR7ZUpejKoU
         Us5AZNCr4Tx9UJfoptMtanQAyjTZ31oKp4dMHpHQuJcw+AWIEDNHWXNU0b7XRE4TVr9p
         VhY3+xiFNjq90AQrI3xq866c005uJYMGbTyPeKyUFf5Xm+3I22nE65VMlpZ4br1EpKBV
         a0fnuVmIyIz6oG+W7vL5GzgzqDwMb6DIWwVyqibICyzRttRWID/h4lhhOyaVf3RaMmbF
         M8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1wl9bIzYTXz4mAVGzBepowCuPPiMvBEBs3a9CeOaU4=;
        b=o8mmxb08ClNhosFDvGLqb87Rm7X55PWCORslK1/58/2BTy9J33Yaeba5QufmFlJ60q
         RrxQ2xHN00biZD8K2WIAn6MlfcFyTVCXEdugWegvErmG6ZZ2ykdaumajU9ox8gUv2ZPu
         p/LY+JZYoUGR4bhl38Sme5XG0MSnpKjWEBJxHm5AoGgf2NYQi5hdmrR+K/l3c2USlvq0
         r5b4adJtrGL8NN4HYrhktkRHPMOH4gyG2LczS9f2CGpxAspy1ZZsReI8G0w7sxDT/pUM
         F/MbvBEeT+ui6rYQPa2/pzL/lEr9RcyrJZuSmm9IivL3EG5WYWY4nfeSWujY/PtIjqig
         KqjQ==
X-Gm-Message-State: APzg51AQiG288Qb6gB7nqT4b0swmMLedQTr3n1d/HC8bAhFZGcAfck8D
        +Jnx7GhOsBvtmvVbfLY/y9OzJE0JLG8=
X-Google-Smtp-Source: ANB0VdaWRNECOZ83xLFDRfpJ/wpz8PJfxF+hjMASOTkQ3Mgy6ekhcZ3luAAzviqMT5CAT2DuDhLiOg==
X-Received: by 2002:adf:d245:: with SMTP id o5-v6mr11743839wri.91.1535746225059;
        Fri, 31 Aug 2018 13:10:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4486753wmc.38.2018.08.31.13.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:10:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/9] push doc: remove confusing mention of remote merger
Date:   Fri, 31 Aug 2018 20:10:00 +0000
Message-Id: <20180831201004.12087-6-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180830201244.25759-1-avarab@gmail.com>
References: <20180830201244.25759-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Saying that "git push <remote> <src>:<dst>" won't push a merger of
<src> and <dst> to <dst> is clear from the rest of the context here,
so mentioning it is redundant, furthermore the mention of "EXAMPLES
below" isn't specific or useful.

This phrase was originally added in 149f6ddfb3 ("Docs: Expand
explanation of the use of + in git push refspecs.", 2009-02-19), as
can be seen in that change the point of the example being cited was to
show that force pushing can leave unreferenced commits on the
remote. It's enough that we explain that in its own section, it
doesn't need to be mentioned here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-push.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 55277a9781..83e499ee97 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -78,8 +78,7 @@ on the remote side.  By default this is only allowed if <dst> is not
 a tag (annotated or lightweight), and then only if it can fast-forward
 <dst>.  By having the optional leading `+`, you can tell Git to update
 the <dst> ref even if it is not allowed by default (e.g., it is not a
-fast-forward.)  This does *not* attempt to merge <src> into <dst>.  See
-EXAMPLES below for details.
+fast-forward.).
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
-- 
2.19.0.rc1.350.ge57e33dbd1

