Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB9B1F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932467AbeAUAD6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:58 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42308 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932367AbeAUADz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:55 -0500
Received: by mail-wr0-f193.google.com with SMTP id e41so4820364wre.9
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mtpOBdSnjC9T25DSFWBYvYtOSuqUMpfMKnfTHBSex3w=;
        b=QSu1Lo/eIYx6Tmr/RDcw51A2EOdoRxk7NWmJpII7+ddyxRoenvSOCtm2wJXeTXVDe5
         ae5Ok4FEgPQfAnLYiJ+oPzDJB93XNo71CpMVf2DTbxzp05VfO6Zb0t+deH/K3zQOb7sK
         qLE7XOe59NV3sr0grQK8Q4vMLmBmeYkqGSD9PEYu3fH+StLWq5f3jw/tGzcFbUw+SRm9
         6S7A1dYR8mKi2pPYL01YQ8RMxzcyLH0n+UHBmpSS6ALAG6tYh1P1WrhOAUA2PwfW4yME
         378snr7QVNlOjjhiBeLcxhYtvMoG8tVIsIkchbslBUiVFyJfMkPKtqnNDymiWpC0pome
         XFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mtpOBdSnjC9T25DSFWBYvYtOSuqUMpfMKnfTHBSex3w=;
        b=Z6aOL6791eHLATwhbd+Erd/CNcb2qNOVWreVfQSJg8fNpwSmseLKtxDWpqhkj5u+PM
         K6zWQxQmCtkmAyYVUBMRz1ghU7FCDh6PsO8BDy9ib0JVe9Y57D3dsUzq1zWks9z3Z8Dl
         b05finBKQLpxUdugg6W7c7CncytJgHe1mtAjHUwWPTlZfGU5UZTcU9t+2je9919XMEex
         43oqlokr3CnjaY4i5yxBNtfzz0Oj3YmV13PoGac0tbSmCorA6BtEilkxkubryj8aDsBb
         YG6kcccjYxjv12W33eeN7JBa+nCXVLYbN6/dMZTnoduczEAdMrMJMupU8S4ZNpm/v73f
         RiXA==
X-Gm-Message-State: AKwxytd6H+4H5Mi1Q+JhaAqOqtjtrEnZXURvM1DQUjZwxhZxSRqjNTld
        S1FrtqKWx0CligmUeKssTD7kIWxh
X-Google-Smtp-Source: AH8x227AX8LcnMhHfSfFIcRreOnaQmdmVTcy2VaQGPvkxq6YGl5CmjBF0CSkucphOJHoyEiFA2MU8A==
X-Received: by 10.223.128.231 with SMTP id 94mr2369913wrl.64.1516493033357;
        Sat, 20 Jan 2018 16:03:53 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/12] fetch: stop accessing "remote" variable indirectly
Date:   Sun, 21 Jan 2018 00:03:02 +0000
Message-Id: <20180121000304.32323-11-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Access the "remote" variable passed to the fetch_one() directly rather
than through the gtransport wrapper struct constructed in this
function for other purposes.

This makes the code more readable, as it's now obvious that the remote
struct doesn't somehow get munged by the prepare_transport() function
above, which takes the "remote" struct as an argument and constructs
the "gtransport" struct, containing among other things the "remote"
struct.

This pattern of accessing the container struct was added in
737c5a9cde ("fetch: make --prune configurable", 2013-07-13) when this
code was initially introduced.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b34665db9e..a85c2002a9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1280,8 +1280,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 
 	if (prune < 0) {
 		/* no command line request */
-		if (0 <= gtransport->remote->prune)
-			prune = gtransport->remote->prune;
+		if (0 <= remote->prune)
+			prune = remote->prune;
 		else if (0 <= fetch_prune_config)
 			prune = fetch_prune_config;
 		else
-- 
2.15.1.424.g9478a66081

