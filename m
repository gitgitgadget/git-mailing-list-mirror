Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC7C208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 14:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbdIGOCs (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 10:02:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:64071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755396AbdIGOCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 10:02:41 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MI8Ug-1dtp0L2vXy-003vXX; Thu, 07
 Sep 2017 16:02:31 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] t6120: clean up state after breaking repo
Date:   Thu,  7 Sep 2017 16:02:22 +0200
Message-Id: <3c51bd03dd26a495845887b1213aca2af2fce8c0.1504792601.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.603.gf58147c36e
In-Reply-To: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
References: <c1cb526d-a567-b598-d980-5dbe695b7d6a@grubix.eu>
In-Reply-To: <cover.1504792601.git.git@grubix.eu>
References: <cover.1504792601.git.git@grubix.eu>
X-Provags-ID: V03:K0:RH8F3sBM/UBgoyYbJvoBKWZQrBWuEr4Nl8JmkWIjrf21tWiL4gw
 pvKmTLuB8Txr/zx1KrBLjDs0njqqOgp/souXOQgBff1hBxPClD/pmSXIGRF6mdPG7/WJ9HP
 m1zyPTLyT/0NGatS26pdMYivQSn12NPpPlPY7n30mtKTS3BACEI5uc8H30fZg4S3hRXg0UE
 gHVuYrtIYnk3+P/1hOv3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V+a1yITRu/4=:ehmWJVAN00K29Q6qpGJRF9
 Ilo/1NEcco/zyBUjlnvOp9MqLWogt6f278VxcdF2pfXXfAW5mgDBn6d9+uBVOwIFzLQoHHzZe
 2OKqFU2CzMuLMW70Z7sL97t2UkDtEwkwS5Mn4Xiwrlg4EqCr+l4cnGjc3li690w/IlvolXlzl
 IdQpQb4zdZTpJqIfRlbXX62lHCWVMOVboEs/CuWkTmLSdJf5vVvzKRvCfwwwMwHuN0SCQrvnP
 etXxSr8vAAN8nLOKhkrWwBc+svbz139KM7+4WB2yIoc5Co5SK8AnzqJko4WivpOJdKaAGoS37
 6nB+vmQto9W1QoukRaJ1xS1lVMpY6FHkGuR4J5MJx2qZNzywCE6/xYusPGaejsTY5kcUxfC9e
 rA+Ti0f/crL2yNJnHfE7tvBgRUtofWT+PEMUYime2Gjsdf1d0zVZkmFoYM86YXVGCUD8/8slf
 wBqYDC8U7T3yX2IO6XOFLUkiPurGrrkimBt9LWyjXDLC+gcPY/ahtTQcKOKUstAtv13/sBqga
 SGErGWCq6cDHfra3RMFmvE0jVDAE57C8BaBLNBnrmsCGQsVpq3gOk3fQg1WGK42iFVFLBJSgk
 plBxTc1lMwWJVHZZyEcl7a+IGzlWuYXr8WKProWLgiH5Oyi0R5qY+hIREz/7dVcOJ6OgUVvmv
 gt7eZ1w3sK+dm7VF6lysVyndb7CnPLI1gfIJ/lLJmBiRjkVslA0gOYbXkZn0L4OeRqEbn2VOj
 qfx4OU/Prq0X/bEK2844QhOc2UNQ6GjOHemehQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t6120 breaks the repo state intentionally in the last tests.

Clean up the breakage afterwards (and before adding more tests).

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/t6120-describe.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 7c5728ebd5..1997ccde56 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -275,6 +275,7 @@ test_expect_success 'describe chokes on severely broken submodules' '
 '
 test_expect_success 'describe ignoring a borken submodule' '
 	git describe --broken >out &&
+	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
 	grep broken out
 '
 
-- 
2.14.1.603.gf58147c36e

