Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E7A1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeGHSvU (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:51:20 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47285 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932688AbeGHSvU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 14:51:20 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Jul 2018 14:51:20 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 10D89292;
        Sun,  8 Jul 2018 14:42:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 08 Jul 2018 14:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=cc:date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9gEoLDEVd+uTpIxYS
        CXg9jyrjVyKFB2OJ/Fq1hTIv3U=; b=SGUyNzcjDkgA+XYIopEQ2RJKg05nRixok
        TBbXUCwWIsLVifb9bQ64hC+B0DIYjFeTukSanXoN9LqYBMqUc68w7zpDnESjEbPh
        jm4I5DmAVmiEY0zkMwojX9tQJHBVUNRUYwusAv/EV6A3RvXy1rqpwvhA8JhOVgX/
        K4PuoQrRUpgxe22raNGSaufegaQ/tDd05SsZ/lKfq1J4paUCQHV8JnWp7W3ZEG2h
        x6Ms2PNQEOoEVZgIrYLYesGQCidsNTMw9gBzbpfoPXdbSZ8J1ZHeY4dBfLxedTFw
        Eimwmw1Zqu6INCxTB0UEEMKurf1jlQo0BoKUGs54PUMRWf0CD2zaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9gEoLDEVd+uTpIxYSCXg9jyrjVyKFB2OJ/Fq1hTIv3U=; b=ir0wYAJD
        6P6omvZMpO+/r2NK2oLac/esgnadlVNIQrDM6GQAhAySdEYQiatGYkKlBVWac5gh
        ySiUJ6amuQv9pY+VbAHeCYsKO4HcbzQxJWgIfCj+EZ7vekGikxnDtKT5g8T47IQr
        Hdj3pCumS9gNi0NgMFHyNRVKn2p4a6y5fZC1LkS+U4616I8ipwsSKsV0OTyIV6FC
        oKBzRzyJrPjdgOAtc+im/u9CQHfPN39wlwBz0EVChGjwMKVnXs33VY9B84yXkCIW
        AxhJROClhmpjq7WWx+/C+xDqtNPasX+922gWAKWQE2EpRqZvhggIGkTTAivBesxg
        z9gHM+UvTPvQMg==
X-ME-Proxy: <xmx:E1tCW6qCTG5p8qgWvX4-Id3G7yafYaUlM9D1VkRD5G_foDyGmYeCJQ>
    <xmx:E1tCW2M69H94FU9ILOHHfEefnnBiVP2HTgLedoTghdRBgaHFXF_h7A>
    <xmx:E1tCW1o8ZSN5vk-QaCHNrAe49HcLKuUHrlRB7b5AnRvdd3x835N6cg>
    <xmx:E1tCW7diAP2JwzXWrgCIwvnlt-oFELGWPc6wfMC0yaExIfL5YLiIQw>
    <xmx:E1tCW7TR2xbdh1b6Ti6tjQbt5Vm11u1FHgRFVYJNngANxVvK1Xg_lQ>
    <xmx:E1tCW6mHd17_u5bxrH2FFsxrQXDnlSe2ZuumR-P9Un8mKQcSHBZcGg>
X-ME-Sender: <xms:E1tCW9VUtafsX7vbMWt2v2tVr_66TkvBaROErZOsUxix8aafCcX5sw>
Received: from localhost (unknown [46.185.196.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 87A1B10266;
        Sun,  8 Jul 2018 14:42:26 -0400 (EDT)
From:   Daniel Harding <dharding@living180.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Daniel Harding <dharding@living180.net>
Subject: [PATCH 2/2] t3430: update to test with custom commentChar
Date:   Sun,  8 Jul 2018 21:41:11 +0300
Message-Id: <20180708184110.14792-3-dharding@living180.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708184110.14792-1-dharding@living180.net>
References: <20180708184110.14792-1-dharding@living180.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Daniel Harding <dharding@living180.net>
---
 t/t3430-rebase-merges.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 78f7c9958..ff474d033 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -56,12 +56,12 @@ test_expect_success 'create completely different structure' '
 	cat >script-from-scratch <<-\EOF &&
 	label onto
 
-	# onebranch
+	> onebranch
 	pick G
 	pick D
 	label onebranch
 
-	# second
+	> second
 	reset onto
 	pick B
 	label second
@@ -70,6 +70,7 @@ test_expect_success 'create completely different structure' '
 	merge -C H second
 	merge onebranch # Merge the topic branch '\''onebranch'\''
 	EOF
+	test_config core.commentChar ">" &&
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
 	git rebase -i -r A &&
@@ -107,10 +108,10 @@ test_expect_success 'generate correct todo list' '
 	pick 12bd07b D
 	merge -C 2051b56 E # E
 	merge -C 233d48a H # H
-
 	EOF
 
-	grep -v "^#" <.git/ORIGINAL-TODO >output &&
+	test_config core.commentChar ">" &&
+	git stripspace -s <.git/ORIGINAL-TODO >output &&
 	test_cmp expect output
 '
 
-- 
2.18.0

