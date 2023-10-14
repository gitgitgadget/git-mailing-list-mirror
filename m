Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B6273FA
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="XI+1OqT+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g13J38du"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BABD6
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:47:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 6C8CB320092F;
	Sat, 14 Oct 2023 17:47:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 14 Oct 2023 17:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697320025; x=
	1697406425; bh=N+cHj9fbTU4/Zwh9ewntX5RxenxS3ohB6+mPzVEDkDg=; b=X
	I+1OqT+xZ3g5SPwYsmSh6Q+U05hfKNJz0HsxxcJp3B1FboJIo5PcXaOgw9yui0d/
	scH7+vvqa6cEP7+GV2uXMpvqd1aCS8TQZ4QJVu9BLdQ+ijTLC6eEwtq/TNa4PM0Y
	3OPJaDj5Lr27gODBQqcEcaPVL6mGkQq7KKJCQ1kwLU7kSSetmo02LWIXRoRWvmpJ
	ynGxmuh+Snoy+PvIdsNYxveJ2zkg40u3i8EQjVipgkWHsGbuIIEIfFcTvKXaivB1
	YERGZxvhSM05jcZTUpGKCAf1YPTfGSrKZVqw3StCDEj8vnLLa2X4nwUAfi8kCOT9
	SJTMkrQCxrt6PMwd0d5Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697320025; x=
	1697406425; bh=N+cHj9fbTU4/Zwh9ewntX5RxenxS3ohB6+mPzVEDkDg=; b=g
	13J38du2aggCRjKQO7bRKGEYK6KRr4zPXeEeLqDXjo12xHPINbpUQpUp9uwTrTfa
	XnLbt+kdiqVX9wkkh8x0aiWQ+ucj0Wd/KVGzxesoxp7JRUOvCoWw4BwxiqtvrUNW
	p8PeoIko2IDucnTxgLcomJn3zyCv2qML0Wm/R8mC0tuthGvnI1fYJwzEMm+64cCB
	h8M1nUDAct5cqZueoz5tix4Qq0Q8j5vmQ0hJs6auky1lMJs7X2PDNwV/gzC50bZf
	w9FUYKzJHTe28qFIv+EiPS7OiJ3o2xCG65/18r46oJUY4P54HiSN8mnYg1xux+hn
	x8JmDOn+7MlX8D34ZHHhQ==
X-ME-Sender: <xms:WQwrZbxoSdoHI-yS7O17hG-ggSvH7W4CPfpfZt9RoyBkFA27Nn87yPg>
    <xme:WQwrZTScoMJZXrgsev3S2P86T_IH2VjL9OyhLdJFaPOf5bW6wr8Hv_gRu2KolVwFy
    BURXkc92cQaN_3I5A>
X-ME-Received: <xmr:WQwrZVWSCTpDt-FYjTMHn8Y8l6VIYpXRfU_QcukWsYXZJtMnJxiMOfL3l4IAEfgYTn0w04Kjk_rarFZvBatqe9-swjE-hW2HVWxxfN1V-HMdqUhjHNmYssegqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetudeihe
    eguddtgfduveekhfevudeiieetjefhffetiedtgeejieehtdfhjefgteenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghugh
    hssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:WQwrZVgYyzBLmDIO8eD6bc-pwrdw0FKeY5bOrQuTu_2z2-peZyLYcg>
    <xmx:WQwrZdAxvDuW6zSabRSRlXWRbnOYP2Bdz-MiZJlx5HORWGHE8yaK7A>
    <xmx:WQwrZeKxiFCimvYsLiwjkcf2tFiS0xICI57gLCodd6MsmhGihq7O8g>
    <xmx:WQwrZa7WW7aa4hXxfGp41Ph3g6zvBbjoekcFNDoOUF_eIC4qtYCPxg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:47:04 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 6/8] t7900: fix `pfx` dependency
Date: Sat, 14 Oct 2023 23:45:57 +0200
Message-ID: <5b70e635e2bdd8fc16ff6ff3c1eaecd10ba66634.1697319294.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <cover.1697319294.git.code@khaugsbakk.name>
References: <cover.1697319294.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Test `start and stop when several schedulers are available` depends on
`pfx` from `start and stop macOS maintenance`.

Duplicate the behavior.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t7900-maintenance.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ebde3e8a212..15a8653b583 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -794,6 +794,7 @@ test_expect_success 'start and stop Linux/systemd maintenance' '
 '
 
 test_expect_success 'start and stop when several schedulers are available' '
+	pfx=$(cd "$HOME" && pwd) &&
 	write_script print-args <<-\EOF &&
 	printf "%s\n" "$*" | sed "s:gui/[0-9][0-9]*:gui/[UID]:; s:\(schtasks /create .* /xml\).*:\1:;" >>args
 	EOF
-- 
2.42.0.2.g879ad04204

