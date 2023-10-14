Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613031845
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="YSlMh9WO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M5nlGlR6"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5D1B7
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 16:01:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 47A863200927;
	Sat, 14 Oct 2023 19:01:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 14 Oct 2023 19:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697324462; x=
	1697410862; bh=yXQYbJQVWjFGHSeLqxMc71kugvCqksjC7wd1Fww/3PY=; b=Y
	SlMh9WONQBOMdm7XiaXzEzWfFzAbI90VfYCqxWGYdIpHOiEmT2vCe4IQfn8BbnuG
	Vcs+/bEZRXClSl9U77RzNpFiWnTzvx2N9FSNJ6AA8wK8eId/8jXg4fICbsJlgDFC
	ByOF9D5BijRCG6oppsMESwpIwG8SljmBEfEDEX94cJb49UES8mHeYNhc0puOvGJn
	lg6keHA7tSJymkYqgifIslIN0a4/Dmm1NfvMd+6PqYJB85JarIanhWSkX23YeCzm
	rhIS+EFOf962sUckonzGfKOBccV2QZ2BxZ1YrSZRx9OwRvLtEuFY2XYr7gctinW7
	kqRkzMUms+jwbAv7dRwyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697324462; x=
	1697410862; bh=yXQYbJQVWjFGHSeLqxMc71kugvCqksjC7wd1Fww/3PY=; b=M
	5nlGlR6SYLKSfH4NySQQ4Dvnb6GxKZu9Xnea6Gu9HHPxP9pxG2ju3GtyB8tcw5y9
	AOL8gooK4A7Xo/tyjV4Xsw9gyXuj00oWS6VU7PWB80/8rWLY9Y8tXtyJPy9sx9GP
	azzzcZ7oXI/zI7ZT75NWCy7dDy7QY9LuavZS9kQDC7TEIOEKVcLa8G9x5O1/JOzJ
	CHfhyaOYwUWxq0CgdWluX2MtM/HuD/5sXrlYahqK2kNHBy3IuBBoGaGYDuAsChPT
	CEPrSAItVdcQjBz6P6QqgDIEO29VaNHR2YSrzOi/5QNKSY4k11wEBTxPUJUWpzHE
	4LziK6Fuu2DbyNaRsE4Mg==
X-ME-Sender: <xms:rh0rZQZVNRqOdlmpl4UlTi_dYWEqFID2BboeL5RJW7X_4F6CTMtRkXw>
    <xme:rh0rZbazlvC3HydPb-fZNAsA59Q8ORqP1gFdey0px-JKQmnVa-kpcGUbJ_a6CEld7
    HH2pgsai4RIVUjXWw>
X-ME-Received: <xmr:rh0rZa9gyEyY1pyiblfzjFHqBB2_DAQp9g6Q33yoOzKRv58Pjo754_S_txvIaEY0osbQ2J83HzkVIdMXPP3-juwlVtRe4H4Ef3XjNTj452zQrhcTpJ-oM3YHqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetudeihe
    eguddtgfduveekhfevudeiieetjefhffetiedtgeejieehtdfhjefgteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghugh
    hssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:rh0rZarQZeB8I_kG8tqIZ0RFO0fBFFB2zh027A212wLKSiBBCc5IAw>
    <xmx:rh0rZbpYzglwETMhvDjwQEU4sDS4y_cecp0OEJPftTlzelGfzC2iEQ>
    <xmx:rh0rZYR_8SgdY1QGxkU-vWmtWUx2YqxYHyyai75qAF8vsa0lcK11lA>
    <xmx:rh0rZUCHogMkMeNP6gwEAkrW31VLB7L_w4wq8X7q0KvWVRMcoBWN9A>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 19:01:01 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 9/8] t7900: fix register dependency
Date: Sun, 15 Oct 2023 01:00:44 +0200
Message-ID: <fc3dd058521ca00033509c6ffbc75017ba1ace35.1697324157.git.code@khaugsbakk.name>
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test `maintenance.auto config option` will fail if any preceding test
has run `git maintenance register` since that turns `maintenance.auto` off
for that repository and later calls to `unregister` will not turn it back
to the default `true` value.

Start with a fresh repository in this test.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I found this after publishing the series.

 t/t7900-maintenance.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index bc417b518b..dbc5e1eb44 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -55,6 +55,8 @@ test_expect_success 'run [--auto|--quiet]' '
 '
 
 test_expect_success 'maintenance.auto config option' '
+	rm -rf .git &&
+	git init &&
 	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
 	test_subcommand git maintenance run --auto --quiet <default &&
 	GIT_TRACE2_EVENT="$(pwd)/true" \
-- 
2.42.0.2.g879ad04204

