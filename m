Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE075266A1
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="nnn9qZWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vs0mOe9Z"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B42BDF
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:47:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 78567320092F;
	Sat, 14 Oct 2023 17:47:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 14 Oct 2023 17:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697320028; x=
	1697406428; bh=hDXQVwV95eOFaJC0511x+iJeioNlkhfNw1fCU5CxuAc=; b=n
	nn9qZWcDEDfYO8QkeZA7qdsTDVVbMuJWS80tDXUlvuruFfUZvsGYh2WjEiQ1wIS6
	j9DBL5WqDbUysf2uOTX49pTw4Kks2nx5i+cwQIiNYo6BjczE5ClIsZd3g9XkuGjZ
	eqw3eg61ykxGEYr7l9bKINsr1FJxheFK0QOGqJpy6UdefaabB03+bnMhLUjPz4a9
	rv7k3hDMwgGO9YIlCxVJIMyQzfJRpUdy/C2pIu/RAkACCvlNjApElBbXvTRRyCCX
	czZUayVT4YtxIpuN0bwJ+TGXeYxPwv8PwY7qpirN6thAIuP3yiASrhM0J3F6P+4n
	DZ25iNXeX/evmepnbtTIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697320028; x=
	1697406428; bh=hDXQVwV95eOFaJC0511x+iJeioNlkhfNw1fCU5CxuAc=; b=V
	s0mOe9ZlN+seuuOIT9AFOj3ffTOmqMbj+sbMXHOnqDmAEcK3nryFNHteuEC7ohBT
	J7Q+RmX2okM+ADLeu38ZH12uruFB/BG7hbrndihTQQqOwebiYvC3LUyqL46IQMKU
	MzZfdlnVUyaKUWJ2r4phOIzzu8B/zk4rOxedTk4f1z95OpKEG4Ipz0PVlQjXJErg
	G/wVMNiu47/eyVr+CcVKyu+0Bq+CJ8+mtfUe9OmoW0fqJfY2kDY/2wFonrtcZCE4
	fob7BI3Us95+aUUaHHemkB7M53H6bp/0/R6HTcrVO9QfPfhN6TnvGe7unQsAcbrE
	DYhzC4+wrrdUPMwOiYWnQ==
X-ME-Sender: <xms:WwwrZRm1_TR5s45tjd7F5feWV8SltTE_sLk0YPUuffcxgsjPg4WGbzI>
    <xme:WwwrZc2tvGm2V8kYXSKTWdA-MHg84LQ--ZWrxtzm4XIemwRBQx-NscCCzEWdI-Bs-
    ex7pqO-lT06dSwWcg>
X-ME-Received: <xmr:WwwrZXqG2H9BkCmXhHt7SOu2ZEEHPa2CdssNIYQMyZD0VKhgpxkVFCgQYw1YoFIo5cd5qp2vp4LautMIm0uPox8ZcBfrsaoOVUAeAH6J8rVg44VTmCesXS_ihA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetudeihe
    eguddtgfduveekhfevudeiieetjefhffetiedtgeejieehtdfhjefgteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghugh
    hssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:WwwrZRlKXgG9x1bdxDlIup77Ql8cj0E7RP-1ogWobTHU_KXVnQtvsA>
    <xmx:WwwrZf3GB4V0hrl9NYQaVP0nfQhos0m0RD-UvjjT--gE80uvJ4rWVw>
    <xmx:WwwrZQukOfml32z0d77-mmqDpOKj_ufx9ga9hVVMumzClF9lhVsAeA>
    <xmx:XAwrZY8fIRUAXqYoZx9ZtDL2XOA2XVaJQpbSRfW0icvw2T2x-Qxr2w>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:47:07 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: [PATCH 7/8] t7900: fix `print-args` dependency
Date: Sat, 14 Oct 2023 23:45:58 +0200
Message-ID: <c22183d7cdd0442dfef139b79e9e37f5c070de44.1697319294.git.code@khaugsbakk.name>
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

Test `use launchctl list to prevent extra work` depends on `print-args`
from `start and stop macOS maintenance`.

Duplicate the script writing.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t7900-maintenance.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 15a8653b583..99279e41787 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -709,6 +709,9 @@ test_expect_success 'start and stop macOS maintenance' '
 '
 
 test_expect_success 'use launchctl list to prevent extra work' '
+	write_script print-args <<-\EOF &&
+	echo $* | sed "s:gui/[0-9][0-9]*:gui/[UID]:" >>args
+	EOF
 	# ensure we are registered
 	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start --scheduler=launchctl &&
 
-- 
2.42.0.2.g879ad04204

