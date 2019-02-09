Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25131F453
	for <e@80x24.org>; Sat,  9 Feb 2019 18:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfBIS7s (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 13:59:48 -0500
Received: from sonic309.consmr.mail.bf2.yahoo.com ([74.6.129.253]:35776 "EHLO
        sonic309-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727013AbfBIS7q (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Feb 2019 13:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549738785; bh=Qjz8hZhOVxSUV9F563Yo1KVIMkhGKCFT8zd5e5USt5k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=D07U/UjYSmaRBmZm5y1VlRfqJtN6xi2FtA7jO6OEXF1PKnmWgnDo9WUejNuTkgYK2HEon2KsjZ9eWKIhnmoyU3yLDPxQsNeLiLe9aih4+5h6vQVf5Ah6Yhmuq6Lu4Yf8f0afeKYyUqGKjNMQ3kCwR9YDbHM2AVZ3BCCDWwU7KqxfZxGsZLPSJ+mZRYyog03tqPSCO6Oc+gKZxkQ5nQK8uKUKUDP49dAMXa0u+Z69N5Nf9R9TnnylZIfRU2SH6HhiBntYvCKrVW7v0M3OFdO/Ci/vyo1Ncy/swAsVl2ajW0iBsJKfq3I2Va0xAG5JN/X3+8b9suO4B++MKajYoquzuw==
X-YMail-OSG: YX60u5IVM1kcLuSMtyFQuqmSQf1.NZorlaOzptZ3OKAZkTWEySfB2wv.X15lyjF
 v3dq8LxVCFyJruRPQHGf8GCCE696p9hPB009Ozr99eIC_DL81B_kjkYj1LUVKVxzg_n33VJse5VJ
 BjafVFnxZJbANuq7qcw9Hj1xB6xOsgNlHyxRmeYl5fLpXzwFODpJNOEZSpm1BJPufEAsG_hC.X7z
 lPA87RIbKiy0QMZGP2NkYY2GvfwE.lBh65fhQLrLKjNMqBprri5Chsxl8ZMSdSuu_r._p1giAZXW
 0hr3SipQckMev86q7ziKQnh7XQhKFcsWOnMpRcHEINEXz8ppcVduAH8866EAyHBSdummYbWqYfPT
 gkARafGll.ZrD5MmXGKRaNhvNxwB1UZnbfBI2VCLsxXjiHltfANISQ7PQSHEF..bMAU__XV.LjiI
 LVboAdKwrndwIkPB3I03bkjDItal6o4DwKFsKmx0adakFZLdEEnaokn5X3sYwDE.dBKaDZ.wFQ0r
 98GD5y0aIJTLSTOARl6VaQUotWWKzcSJbPsJlPQtB86iR5RGLcxVmDSTc_X0it_e2mbd.M9pGtP7
 wg4PE_dLJ50mdbNBMMaoHunlVPlY1Fa3_aDpjzHiw_h_EcBWciOl47kQ165.XGQZylIWtbuCqVhh
 YAI5C_M_R2eNY__S59SjWyQCpkahCqKzQxSFdEacSVQXEUqB7idSchKcViFkAsjmHQPQVfg.ZDCx
 lijw8spEnoVg1.LIszdBSWsKsOaRWsQTAodHG0wD3pgwp5msQ14IjnMJytgFXTSqyNmFueOI.c6r
 vU68LuEuXPRqreBOAKGhRefItWGl1jK9xwVW37hZrjp08RECp4mdQ8SHpEYcZs4uXARREejFrVmX
 o82t05U6qhBz3kJUkf90jByzq4QrcjsW8Cs0ca41z6p1SNy4JGRsY0BB6t_Rm0iTXLYJjxWNSrTN
 TzXnkat0PeXvq1XuKlWHnE9zgKs823q70Dwm3XbKY5XE0l6Uo_PYa2HOCvBaQ1Fyw1ZKV7Sgn.y8
 ZoQxeKzdsa30slTW3onc3XuK7tYS7iwk.W85zsVEQnLk9RuA7UFmhAznMEfeJxZbbZnA4caBC200
 kB_IDv0uabgHILvMDX3LX_ModgC0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Sat, 9 Feb 2019 18:59:45 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 84a16d171cb60baba1591047a4493b27;
          Sat, 09 Feb 2019 18:59:43 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Patch v1 3/3] t5562: replace /dev/zero with a pipe from generate_zero_bytes
Date:   Sat,  9 Feb 2019 13:59:30 -0500
Message-Id: <20190209185930.5256-4-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190209185930.5256-1-randall.s.becker@rogers.com>
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This change removes the dependency on /dev/zero with an equivalent  pipe of
deliberately NUL bytes. This allows tests to proceed where /dev/zero
does not exist.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t5562-http-backend-content-length.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 90d890d02..bbadde2c6 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '
 
 test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 	NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
-	env \
+	generate_zero_bytes infinity  | env \
 		CONTENT_TYPE=application/x-git-upload-pack-request \
 		QUERY_STRING=/repo.git/git-upload-pack \
 		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
 		GIT_HTTP_EXPORT_ALL=TRUE \
 		REQUEST_METHOD=POST \
 		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
-		git http-backend </dev/zero >/dev/null 2>err &&
+		git http-backend >/dev/null 2>err &&
 	grep "fatal:.*CONTENT_LENGTH" err
 '
 
-- 
2.12.3

