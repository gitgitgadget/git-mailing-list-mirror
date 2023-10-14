Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC826E00
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="UB8GH20a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UiumWBTi"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70156D8
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:47:00 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id B61F0320092F;
	Sat, 14 Oct 2023 17:46:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 14 Oct 2023 17:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697320019; x=
	1697406419; bh=QysTTnd6+x8dgUeA2sV8hCc09c37MPkT4fm0PaXbuL8=; b=U
	B8GH20aOGZcsutD+APjyPoPq2qtSCM4gf1P74gA42RkudjxPHCatmh2iHIqJ9ZTT
	UInUdvpFKq4VkLLDedwdIlQB/bEY2JuYcALaqT1NQZKp/VOi1MxKWSVeJ5VdYXrX
	doX4CG4TGDjZp8pq+SGGsSHjDI4ouoceoSw//PnSxSevl7b/gDw+p7HacsxHfIjp
	X5Z71RiA6Ev2QdzHebH4YpdCCoX2Ei1XrBw7SxMipOR0t/K5zdEE7fD7s9TcvABo
	dPES+XW1CDvN4U/kDzAqQypfFXmr3orDJhi5c8TNxwjkT69g94/LejEg/wtn5VxG
	x1LubZz7czVhvahiRNdNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697320019; x=
	1697406419; bh=QysTTnd6+x8dgUeA2sV8hCc09c37MPkT4fm0PaXbuL8=; b=U
	iumWBTipjDAEDC/LVTr+Ix4DltzCcXuEPpCo72D/Hg0xVYMwBWDLzgLcOZPPW55R
	RxHBtwCT6hUHAHIDX5UOAJaghljWfyXSI1OTpnQfWod3Q2dZi4LUN9dWFqO1lN32
	1+mfE581dJ7+Q85e1U4U9AeFduGXT27mIeXH7cgce4SjRQ16flpr3jSBQW/B4Xbn
	3aCyUiFQO1tvrmsqbDmFVemUsNAxqpFKwdPo4diUEjIXD+ucYKQjcJE+dubxt1kc
	MrUltF3sYO0AsdQZqRKk41ICYgRmoCNXcVzxRN1+RrbOWT+Q9jcG+7pT101MMIkk
	7UO+h755AefMqSiLQP4SQ==
X-ME-Sender: <xms:UwwrZRZSy17GyzP3mJX-onPJ-19CLZ8WY0Bg6gyD9SFcv-8oiOEMgho>
    <xme:UwwrZYbTjxBlkci-YrHWMdFTQnPEA_4P11xmudQWrix-Icy9mB_XOe-LfwOW5Tbn8
    iC1CxrjNMGj5b-wKA>
X-ME-Received: <xmr:UwwrZT_ML3A9DFBivM-RjWEplbR7bexJh49W1IvLLcfN27NWhMa4BILRar9BG1TaKjCSCUTuAUnTdpR51HnEgAUvehMsvYt6UyMcaBYC99L8GB4apN3zwrzJAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeiucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertd
    dtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdelueduteduff
    ejjeeuudfgvddukeeiveeiudffieevudehtdefgefhvddvgfegnecuffhomhgrihhnpehi
    nhgtrhgvmhgvnhhtrghlqdhrvghprggtkhdrrghuthhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgv
X-ME-Proxy: <xmx:UwwrZfr80eb1E87m8WqjyEBtArslD_MPEFpqVzxszib52Li4OYBjsQ>
    <xmx:UwwrZcoWbS8uWFzbVL2lcHNtRZp1-8cch67cPanepMkwtPKXA-CBew>
    <xmx:UwwrZVTMCuMVkab6U3o_CwSNDxPKc_E0jV1Mf3942BWGV6WiqO-kGg>
    <xmx:UwwrZZDtqR6xDXlF28Pc1dWdiiJHMhLSpvDI1knEzIaxkXWsu5FllA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:46:58 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 3/8] t7900: create commit so that branch is born
Date: Sat, 14 Oct 2023 23:45:54 +0200
Message-ID: <ba932076d8a14745f32fbdf63ed0e8cc74774869.1697319294.git.code@khaugsbakk.name>
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

`pack-refs task` cannot be run in isolation but does pass if
`maintenance.auto config option` is run first.

Create a commit so that `HEAD` does not point to an unborn branch.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t7900-maintenance.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ebc207f1a58..4bfb4ec5cf6 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -388,6 +388,7 @@ test_expect_success 'maintenance.incremental-repack.auto (when config is unset)'
 '
 
 test_expect_success 'pack-refs task' '
+	test_commit message &&
 	for n in $(test_seq 1 5)
 	do
 		git branch -f to-pack/$n HEAD || return 1
-- 
2.42.0.2.g879ad04204

