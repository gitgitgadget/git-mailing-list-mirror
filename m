Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B326E28
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="cT03ihOS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkbMExN+"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04C5D6
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:47:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 1198232009BB;
	Sat, 14 Oct 2023 17:47:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 14 Oct 2023 17:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697320021; x=
	1697406421; bh=yFOZtHDAxL/J9lBur5x6bBmlfenz6cMPvtVn3MBMwQk=; b=c
	T03ihOSzJWPG3UQu2VqyQXEC+9+L4+aZoz/SjtiO5V4XUaD7PslKca3ylIFFddNK
	mpvEp/QFqk8Q6k4abZ2dZVpfOfedVEMWiE6IQyov+rNU3aGyZPpddYUPvmavoruY
	iCe4CGva3hILCoSmSvdGQpoMoIKgvl5nT3vbtBHiV+5bX3mPMTOW0LaOtRBn+fqW
	qDhtu1rX3mlNF6a8H2YIWkuT0Yf4VY09LoRl9VRlNYGRvItINPwc9V7Gs13tkw0G
	uE6Q+GnPDa/oQ7ePk8219RyyBZ9Q767MzUrfEy27C18P4idYdvdXBI4wx1B9LjNP
	nq6YL5lYKLZ37bpCi76RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697320021; x=
	1697406421; bh=yFOZtHDAxL/J9lBur5x6bBmlfenz6cMPvtVn3MBMwQk=; b=H
	kbMExN+ZRzfeitob7dGlKwOnMSUNwnQ4GzbHpd94WRUvHTlHYwT1pM1aZXbThw2y
	bGqjmBh+6yzALObQbcoJ+uv7MG7V/PhARJr+LOfIiZdxp2o2NllyO4rsEqpi05v/
	KFtHBWb29Vmlfa8q4AaxlMYt8Vy/FWGoU58LkfTOcDZpKrrJFduB1GQoKg2qsa8s
	MeLUnOotN3KECKm6Ho7bfbmL8t5Qee7nTVndqyWPZBrGfwn0HCpR2QT7qow+eQUB
	VgpG2oZ9rl/0FwDZqpr3iPqbUgjoSlpr3jnVvwjboZUp+iWVmQG5tFQ7cCkvsG2q
	Dg8AA/iILyh6REBM1F0sA==
X-ME-Sender: <xms:VQwrZUzRRZN73QRWnu5X7vRbJfLTXVJOlIFoR4ZuFy4tmL-GTTs-OeE>
    <xme:VQwrZYSBypCRfKZ0zbjAOhS0e5ovDBoUdGGcC02u_HQ1x9uG_eviKP0bUmRxOBU0W
    4xRFPYEfREIl_5Gsw>
X-ME-Received: <xmr:VQwrZWUVpmsWg6uSlyj4BRcw_sRARQizl2QqE3aa8ZteOdQqLtQq9T8HI_9H8OfrMZp3rM-PRlRVzxvGDUWV8B_jlY-KMRS5tEXSznPVSt6V1av6NDw6Xv9h2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetudeihe
    eguddtgfduveekhfevudeiieetjefhffetiedtgeejieehtdfhjefgteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghugh
    hssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:VQwrZShG76CNs1Zu2tYi8JI2uZz2foKWHLGrdg0dWA7YZpopJhtq5g>
    <xmx:VQwrZWCTDBhojOIOfpPC0z3OglGnEziH9uH7NrHXfMvmNh4X624nyw>
    <xmx:VQwrZTKcKSd7gME3mez7pBjQGo3RN3ojFS-mKz1dtrA-Lt8nPPj2Rw>
    <xmx:VQwrZX7uiXI6nLb_dEM7hpehdEhOm677Cvw670MPogOcfTseCe-9FA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:47:00 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 4/8] t7900: factor out inheritance test dependency
Date: Sat, 14 Oct 2023 23:45:55 +0200
Message-ID: <a4491ff0411be82179a2f40c36ce427a5d7c39f6.1697319294.git.code@khaugsbakk.name>
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

Factor out the dependency that test `maintenance.strategy inheritance` has
on test `--schedule inheritance weekly -> daily -> hourly`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t7900-maintenance.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4bfb4ec5cf6..6e3ee365ccd 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -408,14 +408,16 @@ test_expect_success 'invalid --schedule value' '
 	test_i18ngrep "unrecognized --schedule" err
 '
 
-test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
+test_expect_success 'setup for inheritance' '
 	git config maintenance.loose-objects.enabled true &&
 	git config maintenance.loose-objects.schedule hourly &&
 	git config maintenance.commit-graph.enabled true &&
 	git config maintenance.commit-graph.schedule daily &&
 	git config maintenance.incremental-repack.enabled true &&
-	git config maintenance.incremental-repack.schedule weekly &&
+	git config maintenance.incremental-repack.schedule weekly
+'
 
+test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
 	GIT_TRACE2_EVENT="$(pwd)/hourly.txt" \
 		git maintenance run --schedule=hourly 2>/dev/null &&
 	test_subcommand git prune-packed --quiet <hourly.txt &&
-- 
2.42.0.2.g879ad04204

