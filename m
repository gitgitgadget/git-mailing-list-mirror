Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D5266BA
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="eF5uIaP8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQaKxPnB"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770AED6
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:46:58 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id BD68B320092F;
	Sat, 14 Oct 2023 17:46:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 14 Oct 2023 17:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697320017; x=
	1697406417; bh=SQBfZ0bVapzlo7/x3lOTQ84HKm5QH8ztq27+HGpsZdo=; b=e
	F5uIaP8HANpvFF7APpkvMJPVhRyO1vwbNMzvDe3ZbXySx6PBdEgEAhYHy/S4NI9U
	QOcGNTocxi242JmnnNHY0lsp1r63Ud1W2OOYrf67Ocz2/NkTyGRCDw94lRysShB/
	E+CipMWxiM9BkS9MV6oT7DWicBR7OBzRu69LkJbnX2MbaOSktBIxXW4vMsmIpcec
	7hpvk7tdEzPP6fMbwyao1kEV3TqHmkbE2ztuoLwPGk+VNFxH150adH1fYZu7tEPd
	iqSRGmevRHSkW0KOVFTa6vit4gWTLgt40n3el11hdE2SLRgyz+8WqWtD/3ym9/Ih
	8iWsgdeLdw1AbDFDld4PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697320017; x=
	1697406417; bh=SQBfZ0bVapzlo7/x3lOTQ84HKm5QH8ztq27+HGpsZdo=; b=P
	QaKxPnBiKuBqK3+O1W6xM+A9k/RPj8WI7VHzlhN8wp366GFTbp8fzfn6MeOAozHD
	3GHTd3sqXB8qV5hxTnxZopynRFd9tNMq5JwQBRFgD7zCXqBgIfbg67xssK84qWkI
	JTMFLdUTOTWNb+yeZYAX23+VNAgHdV9TgO5L+GyMuktRM9qyAz0xNvdFI8Wy3hqJ
	t1ZWMoT7PojISBbjq4bXyl8HqXiBkphB5TmetLcGGQRXMAnXGPsOysrV6teF0pKD
	DM6g0UgUYBemphsVYj24R0S0J6HjP9NNr52gac84TAioF2ATgSU3nU4bdksV0kgw
	8/OgdSvW5D80gD5EyEdWg==
X-ME-Sender: <xms:UQwrZb8EMHtDE0RyFEkkgoCDTdX4jw1T5EzmDXPifOZ1YAdEFAnfoqA>
    <xme:UQwrZXu7v-HsF_d3easKuhI50147WKkwFfEpHKWxsRwsbkfEiXw30Sv_c1b5M_IdP
    xVXqigrVWOUnqbZ5g>
X-ME-Received: <xmr:UQwrZZCt19fv_ska4gLIgnuH91v_GV-w1lDm3b628k0Funq13eUb7c6XlBjYTfIRkW92QFOlxLGIdZtozxtfUAGrXqs8aodHeE-EQIilvIU7CRdlNVNNm8PybA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeiucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertd
    dtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduieehgedutd
    fgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgv
X-ME-Proxy: <xmx:UQwrZXeyZ9LSe3gQxdhZzpN4VqNPuTDZYYnPs7x7dZlcpve3uD61iw>
    <xmx:UQwrZQOrdbRipvRSkZOUjWe_8t5-4WAlcfH0bdBSLT2hdHEeAr5AbA>
    <xmx:UQwrZZkeaU9YTiRD24pWShABk_HeyrGQB9ySMaWrOfRlSMvebIRuUA>
    <xmx:UQwrZa31v1a3MTcSUJWZ1HPYX4Au1CV_HG2SuCwgtJIoXBSI9LYpMg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:46:56 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 2/8] t7900: setup and tear down clones
Date: Sat, 14 Oct 2023 23:45:53 +0200
Message-ID: <e3987cda75e4db72393f85de4bbb71d2ebaa097b.1697319294.git.code@khaugsbakk.name>
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

Test `loose-objects task` depends on the two clones setup in `prefetch
multiple remotes`.

Reuse the two clones setup and tear down the clones afterwards in both
tests.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t7900-maintenance.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ca86b2ba687..ebc207f1a58 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -145,6 +145,12 @@ test_expect_success 'run --task=prefetch with no remotes' '
 '
 
 test_expect_success 'prefetch multiple remotes' '
+	test_when_finished rm -r clone1 &&
+	test_when_finished rm -r clone2 &&
+	test_when_finished git remote remove remote1 &&
+	test_when_finished git remote remove remote2 &&
+	test_when_finished git tag --delete one &&
+	test_when_finished git tag --delete two &&
 	git clone . clone1 &&
 	git clone . clone2 &&
 	git remote add remote1 "file://$(pwd)/clone1" &&
@@ -175,6 +181,22 @@ test_expect_success 'prefetch multiple remotes' '
 '
 
 test_expect_success 'loose-objects task' '
+	test_when_finished rm -r clone1 &&
+	test_when_finished rm -r clone2 &&
+	test_when_finished git remote remove remote1 &&
+	test_when_finished git remote remove remote2 &&
+	test_when_finished git tag --delete one &&
+	test_when_finished git tag --delete two &&
+	git clone . clone1 &&
+	git clone . clone2 &&
+	git remote add remote1 "file://$(pwd)/clone1" &&
+	git remote add remote2 "file://$(pwd)/clone2" &&
+	git -C clone1 switch -c one &&
+	git -C clone2 switch -c two &&
+	test_commit -C clone1 one &&
+	test_commit -C clone2 two &&
+	git fetch --all &&
+
 	# Repack everything so we know the state of the object dir
 	git repack -adk &&
 
-- 
2.42.0.2.g879ad04204

