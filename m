Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8E273D1
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="bytCkIlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTw+Qlgy"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC9DC
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:47:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 46F9C32006F5;
	Sat, 14 Oct 2023 17:47:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 14 Oct 2023 17:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697320023; x=
	1697406423; bh=5AeWmCF/o3xO+F331J2rIs7myLA1Y3b2PqIJbRcOhfM=; b=b
	ytCkIlhujoGSMoQa4byet/vbfVCEraLUTIWhJ7BQCCQZLcU7qkBqMGd4lGL/laPM
	bSrMobYTsxrRoUPuKO1ruhvaGaWFg00T7psw9BRMHbLlv5/fDYFsfFTcv8rKfVlj
	mp/nwGybD7iqx2VcxKWWrpPAtHenrG0Kf2javHTN/YpC8Ns/1JTlMKEH0I0o8b6L
	D4LDbuThzE33atAkahzDpJlCH8XizT65B2RAyOIcizrO2T4sW9vFsTjnYkUWpABm
	Tw+6HFy4/ZSPdARLY33VdNVZdcUbmPt4jv7q94Vy7Y4INrUj/aozGBZ9t900JHcr
	gtcvBOihjCUJm46UIRgng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697320023; x=
	1697406423; bh=5AeWmCF/o3xO+F331J2rIs7myLA1Y3b2PqIJbRcOhfM=; b=o
	Tw+QlgyFLXds/nUj38wHSCZPFL4GxvljZyY6IXAxp18c/4dx1exhcnQHy28IrIk6
	tN6FK7l08ldRx87RBoKBeKO0h+IjxwUzWTFA5dU/bFZV0S9h0KzyfaTgSHykS+V/
	h2sP/QrFm6esjkeLsz9W5e4RCju6Z8TnPjtZ4XA0hK4bfL6YBs16t5XKsk97gols
	vBPfb27U8e0CRyU0koWlU4PlLenQrdDfn91wV5MnFUL2+5m+5QuAkzQClW3Fm6px
	KT4dECyd1gVvfa38H+NBLn2BCzMvuNIhuATuxIcOOzLThQ+E4wx9CnUVTeLUExgG
	gyWHlt7rixzK6pl6kEYaA==
X-ME-Sender: <xms:VwwrZafoRctsv4UhyPICzI_ucB9F6YXmDysNFt1ljiRFC1jF3oCd1nY>
    <xme:VwwrZUM1tO_6XXgUcM2mEH8l8OhSaUs9L0GpHzLz_ERJtB7YxGpiK6v0lFaICKVIo
    IMQCXJxWQgHK8AFRA>
X-ME-Received: <xmr:VwwrZbg3uSJ7L7RNlZwNS1CEtSA6LwTj_6ITApF-AzzX5sd0BKu_rY6NRRf92snV0NQ_EdxLH7HnO4jNm6A9y4AxUpRl37WPjqFgaq5RwD1Yu0_I6CZ6JIyFYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetudeihe
    eguddtgfduveekhfevudeiieetjefhffetiedtgeejieehtdfhjefgteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghugh
    hssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:VwwrZX91b2OL1P39RWcb3JzQxKBaW6PsU0bLpODlgCfw679bzs8ySA>
    <xmx:VwwrZWvlXCnBX7EFp1C5slwEhqDGHnff_LBz3etXxmukwL7ueNcvbQ>
    <xmx:VwwrZeFsNtykHHVXOzFVR1btycNw3Huqj4SpwxompJnowK9GV8DRbw>
    <xmx:VwwrZbURCgOjMgCZJ4_K7FXb6GZ3WT_P5sTb1PzVcP3yfwKfUOsR4A>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:47:02 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 5/8] t7900: factor out common schedule setup
Date: Sat, 14 Oct 2023 23:45:56 +0200
Message-ID: <eb8dd369b4c0217d1ff55f023076e99be2bcbbd2.1697319294.git.code@khaugsbakk.name>
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

Tests `magic markers are correct` and `stop preserves surrounding
schedule` depend on some setup in `start preserves existing schedule`.

Factor out the setup code.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t7900-maintenance.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6e3ee365ccd..ebde3e8a212 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -637,9 +637,12 @@ test_expect_success 'stop from existing schedule' '
 	test_must_be_empty cron.txt
 '
 
-test_expect_success 'start preserves existing schedule' '
+test_expect_success 'setup important information for schedule' '
 	echo "Important information!" >cron.txt &&
-	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start --scheduler=crontab &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start --scheduler=crontab
+'
+
+test_expect_success 'start preserves existing schedule' '
 	grep "Important information!" cron.txt
 '
 
-- 
2.42.0.2.g879ad04204

