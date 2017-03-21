Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989532095B
	for <e@80x24.org>; Tue, 21 Mar 2017 00:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755613AbdCUA4d (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:56:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61149 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755307AbdCUA4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:56:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 473B57FDE5;
        Mon, 20 Mar 2017 20:56:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=9jSG
        ZfM3cYPF/L9MIiXBdpCWWbg=; b=VwUu9/El8dk80deecluYFnJm/o9IuRTZdBYB
        Zms8p5ovk+II18dHCKbTfgOk4HSFf/kRQiNuKnM7km4RNaIdr71Aml4DJ3pHkbTp
        r0KI+MO3CPUBFjCY4NryAvrKnIMZqkgFQ7/s6DKy0mK5W329bkas6j3GuQxU88IZ
        9DY3pEE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B26C7FDE4;
        Mon, 20 Mar 2017 20:56:30 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E2387FDDB;
        Mon, 20 Mar 2017 20:56:28 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH 4/5] t1400: remove a set of unused output files
Date:   Mon, 20 Mar 2017 20:56:15 -0400
Message-Id: <20170321005616.31324-5-kyle@kyleam.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170321005616.31324-1-kyle@kyleam.com>
References: <20170321005616.31324-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 37FF05BA-0DD1-11E7-8B62-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=9jSGZfM3cYPF/L9MIiXBdpCWWbg=;
 b=WqPKQBcNrPkvYrCuTOe3WOuCbkU9fdcfr6i5j/MecxTVNVnCJSlXJnsln0P+C8pIAh4HatOOFFeCEQht6aZaZH26QmkMVK/uiXMqdOTlshWpjfdnZ42a54HHGbk5fvZH8p52oGIrYZuJ2CDOy2s56Y3uOVj7cyaroOaLGJ7khEM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test case redirects stdout and stderr to output files, but,
unlike the other cases of redirection in the t1400 tests, these files
are not examined downstream.  Remove the redirection so that the
output is visible when running the tests verbosely.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 t/t1400-update-ref.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index c5c8e95fc..9e7e0227e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -64,8 +64,8 @@ rm -f .git/$m
 test_expect_success \
 	"fail to create $n" \
 	"touch .git/$n_dir &&
-	 test_must_fail git update-ref $n $A >out 2>err"
-rm -f .git/$n_dir out err
+	 test_must_fail git update-ref $n $A"
+rm -f .git/$n_dir
 
 test_expect_success \
 	"create $m (by HEAD)" \
-- 
2.12.0

