Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772427728
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="V+r+w/bk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n3vaXGLQ"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB5DC
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:47:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id B2C1332006F5;
	Sat, 14 Oct 2023 17:47:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 14 Oct 2023 17:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697320030; x=
	1697406430; bh=GlI9+jnasEXKAi7Z8lO4DjwxOp+lxHMh/ecBbySfRxI=; b=V
	+r+w/bkK4TLRJYjmNMWcIrOZDU24wWly2Nf53xozI9aR5oTd7VwOlQ7KBne+Rc9B
	mmBk7W/LxG0ro6SC0dhM3O9rz3ago2j/+I9457UJKCbrE8kgeB0x/vqs0zQJIazm
	sfsw1R04upcs+oE4CgU9rtBAT7BmLoxUovTr5wNgNSSywjvtVP90P+7ptyX29/J0
	pt5wu5Aay4DocDRxe8n2XJizf/fPKj9AL0SeD1ICXA/RdjD1WizRCX8v6iHgBgs2
	BW6wZG2WaicVc7ewuDELWj6KTanAY1UG8H+fouN3E0y0X8miCTTaDzJtnVZwAp+Q
	maSCbmzdp1y2hoW6r9E+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697320030; x=
	1697406430; bh=GlI9+jnasEXKAi7Z8lO4DjwxOp+lxHMh/ecBbySfRxI=; b=n
	3vaXGLQQFl+VqyyaWXFmdqwlOitURM8kDekHA9M9ZBAUtRQ1drzn60mTn1fPR44u
	uW5w1RTfcV0tPBZlA00+FE/UnZjLqZrwji+QOFhUhaaXzGiDBuX6tpBNT9ELVJ9a
	xyxYURZ8Qy2eyviBAsGkB4/DBojLLuBv9te9SEltWhelXlGRPYbF8CsVSV11d+v1
	FptVuHY97hLOFZXsVclZp0xCXRNGzPW+lHlOu3qxw7fsoYPls3GJtuv3WO3iFekx
	ReKdIvQ0VkRtaSUi3uTrDvFXiBfQyzrU967rQyyZi3O2gyOaM/RfMBuGcNwcOcmw
	w8EqZS02P5RtNZNU6GjQw==
X-ME-Sender: <xms:XgwrZV0Bfrh5vAvLfYgIWQqeiLIAZ5muRLFPxopTMQB4yGSYHd_rYJ0>
    <xme:XgwrZcE-kvKeZvNF3lOaZKq2IJWQsrCVFKIa_4lIRZgwkHbCVF6R2VF_-gm4ziUwV
    l6I_FrSWyYqsv75Ug>
X-ME-Received: <xmr:XgwrZV528tvEW716csQcU5-dwV1Wy22o7INEvUYiVPRT9f1VU_2iTWi2VKvzCDnNQqgk6wNyd3reZGGf_NezjjoYIyZKMsQwaFrflG8xz7mEjDZeqwOcVhQviw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeekleffke
    ekvdevfeekvddtudehvdffgfeiffdtudeutdefteeltdeijeekhedtteenucffohhmrghi
    nheplhhoohhsvgdqohgsjhgvtghtshdrrghuthhonecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgv
X-ME-Proxy: <xmx:XgwrZS1GIGQfsyF40ot09n0_gc2yfXLBNrwl_rqnelZQUIDmT0o6yQ>
    <xmx:XgwrZYETipTHSzsezDiVvXUMoyiee1qYUOm-a8D1DfJx9bSnMWiMrw>
    <xmx:XgwrZT_QIqYgFYlon7TXtomCUsaAaLLlA5DWb5FspoWOxaF72UcP2w>
    <xmx:XgwrZSMKlyZrN_3I8uCwd3jqY68ilfucERWjJk6bb5sHD4g0cPlbKA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:47:09 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 8/8] t7900: factor out packfile dependency
Date: Sat, 14 Oct 2023 23:45:59 +0200
Message-ID: <ec4caa88fd2dd9d5ffb96b3cecf6ed89797266dd.1697319294.git.code@khaugsbakk.name>
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

Tests `'--schedule inheritance weekly -> daily -> hourly` and
`maintenance.strategy inheritance` depend on the packfile made in
`incremental-repack task`.

Factor out the packfile creation.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t7900-maintenance.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 99279e41787..bc417b518b5 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -257,13 +257,15 @@ test_expect_success 'maintenance.loose-objects.auto' '
 	test_subcommand git prune-packed --quiet <trace-loC
 '
 
-test_expect_success 'incremental-repack task' '
+test_expect_success 'setup packfile' '
 	packDir=.git/objects/pack &&
 	for i in $(test_seq 1 5)
 	do
 		test_commit $i || return 1
-	done &&
+	done
+'
 
+test_expect_success 'incremental-repack task' '
 	# Create three disjoint pack-files with size BIG, small, small.
 	echo HEAD~2 | git pack-objects --revs $packDir/test-1 &&
 	test_tick &&
-- 
2.42.0.2.g879ad04204

