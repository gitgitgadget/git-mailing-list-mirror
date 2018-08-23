Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126E21F954
	for <e@80x24.org>; Thu, 23 Aug 2018 12:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbeHWPaQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 11:30:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63266 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbeHWPaP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 11:30:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2B83F00B7;
        Thu, 23 Aug 2018 08:00:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=SIKi
        lLGfTMlvJTFADv/2yK0ket4=; b=M7SzE3dfisAqyiwbU5R/MMS95x5gNhqN7EGk
        7QFVHMVWOR6aLGVMDWb339OyiAQuYcpmFaZ3cj/absYmW121hGmV9jZuGiYzxVrv
        Qcuss9Scnrvls/d/D+PaYAtAdLpLS6XaZEjOyVtV9yJRsaXPT3PKJ+jXBL2nU/Od
        rW6Arpw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9B61F00B5;
        Thu, 23 Aug 2018 08:00:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=DomPz5oxJ+E0s3m8wB01nPUDQw/0qhzJqg3gFUVVXLA=;
 b=c6gWKWje0bCrFkg1Vt1CQvxi+MnTnmCkvJC2QIjCsXQ6WkKmzKKeNa8hrqIsXE1SNrnnXdXddk3hgAbFvy3orl/HAIIAv31VNmOBij1cwFqMl1GYB7Gn2dI6Tipte7qMzAiQs63sf8xSaUUfyef7g+ry9ZMQj1XOdUs7GYJruMs=
Received: from hylob.local (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E890F00B4;
        Thu, 23 Aug 2018 08:00:48 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Johannes.Schindelin@gmx.de,
        Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH v2] range-diff: update stale summary of --no-dual-color
Date:   Thu, 23 Aug 2018 08:00:26 -0400
Message-Id: <20180823120026.32127-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823082725.GB160081@aiede.svl.corp.google.com>
References: <20180823082725.GB160081@aiede.svl.corp.google.com>
X-Pobox-Relay-ID: 2C6DE24E-A6CC-11E8-8925-BFB3E64BB12D-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

275267937b (range-diff: make dual-color the default mode, 2018-08-13)
replaced --dual-color with --no-dual-color but left the option's
summary untouched.  Rewrite the summary to describe --no-dual-color
rather than dual-color.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 builtin/range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f52d45d9d6..057afdbf46 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
-			    N_("color both diff and diff-between-diffs")),
+			    N_("color only based on the diff-between-diffs")),
 		OPT_END()
 	};
 	int i, j, res = 0;
-- 
2.18.0

