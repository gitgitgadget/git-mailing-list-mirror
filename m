Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A33F9E0
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551127; cv=none; b=PMCTg7JlG6oej+Snsp5tPHsUUp1usRy4fAwZv14nOdBkGLj/c5yRlVoQnprI16YlfMwpyZmoJ3/0ioOv06l2ofO2tqQ/gf0BcZiY4SWpPUlH2NXxYn7NHbltXv74VU10sHnDaqsgmT81VULN4McNA+FilkI1iNm1LgE1JiZiHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551127; c=relaxed/simple;
	bh=FCcUSnPThfqMr6WTIsA+NxWJKbtj/DtGo/fpJ82f7vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JStBwrOXUBOkdmXaVAFUyq9W1vpZjyI9DIiENWnvRtugIhE70HlrEn1kgJlSptBkOtX0yLOED0xNLB8Q2Aq6EJ23jYzNEZlAyr2YyObM3/FT5zak2KworAnEK2sApsmsLY7s2fa1lmJT5jMGpW5XuFoP7++qmBPhGrEpdVjXkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=a29sxAIl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KactTCb6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="a29sxAIl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KactTCb6"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3EA9E13800A7;
	Mon, 29 Jan 2024 12:58:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 12:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706551124; x=
	1706637524; bh=ZXHwab6zIpMvCg9JI+0pN0nAdrfguTbXCbGnptKYI1o=; b=a
	29sxAIlqbtEqiFjQIamUwEFaK0+6cdXmA0bg/kb+ZkA4UiBbb29+M8jX30zovScC
	aqawurFfQDUra1viDVnlUesMlkr+nOCe9iYIZ91XWUkirowkiid9SB0gH4eHVhIy
	F9+tkPY1AeTjpdKvaHXJQ9ePedmw3F7m1X9W8tJXequYQRNMvw8RbwfXYVsBJc4N
	0siCAVelDLLVhIcTr1LMAPLAFJEHDp0GN+pR6Z9uCyCsoNB6DIUmDUBg/e/VPeW5
	TCJ0o2nt08+xEPsOgwU2N4jg9C2wy/BekkYAHAhgev/HH2Z/GLT5aioavOnJUkdY
	7Z+Zp3GHPkHCxNz4zz2cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706551124; x=
	1706637524; bh=ZXHwab6zIpMvCg9JI+0pN0nAdrfguTbXCbGnptKYI1o=; b=K
	actTCb6DqmyazDybs2iOU3dZ3aMxP0w0f7bmuj87w/wmGAD+5xQNJahR3ud/pwVt
	AyIgAW/QDM/V27oDd+L3dRYRUMi+1vxccbqs8VGSk6LhdjY35FXpiWmRJoUkK9z4
	LCXu7bQ4CRpuJzj1KR/27mjTrCcjvm1KqPtxxU20r5fwTTtuQI2atnWOvpDjuA3T
	qKoS+B9SvNtOugMHotjVrDFt+S3bgLMd3617Z+nl8+K32mOGBKvzJh85khESBysD
	wrzwhbtjlloSNyyKstXys5UoYgXsRHbWKXEiAueoYgIRHaH5aWFRH47YFsW008+n
	9Tu2aKpoxt9U0WfkiJo7g==
X-ME-Sender: <xms:VOe3ZTGl2dbUtbEucrrt7naxlr2yPTCg7BD7wF1OB_kdplJIZR8HpAk>
    <xme:VOe3ZQV4NxQOCTIhuPq2CEd7R8I7sknHpofgMscZ2ZwT67RmQ6-ay9Cv1F52gE0Vy
    vqA9VeDp_BC6p4Pkw>
X-ME-Received: <xmr:VOe3ZVLwbmOwYRERie9RuPSnOqiAAXsDtHxvSv7KYqTXLk_WH4nZBZ5tjhXvr40NpuDbUNtX9rxghRLSArcQ_HkJnyFW_6laSl_SDWcFACTGZU9HUGOSa23iUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetudeiheeguddtgfduveekhfevudeiieetjefh
    ffetiedtgeejieehtdfhjefgteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:VOe3ZRFroe5YkVNXN3XIg6-4LM727XS3qrf1X-bdO2c3-mYLUOWTnQ>
    <xmx:VOe3ZZWg206ALr2hf_infDMGBmp6YUGNMeHVgrncIobQhREqWByyIw>
    <xmx:VOe3ZcPZC6ZWW0QPgg14rK5waAQ2TFe2qqfK4E2vZAasTJMLMson8g>
    <xmx:VOe3ZfwOcYUiFfqRkpd2M-aC5e-eCVfJTB9Nv3ebvQEEwA6C42iDYQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 12:58:42 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: gitster@pobox.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/1] config: add back code comment
Date: Mon, 29 Jan 2024 18:57:51 +0100
Message-ID: <24f536d575d508b0784e0adf647cb2334f6704d8.1706550761.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706550761.git.code@khaugsbakk.name>
References: <48d66e94ece3b763acbe933561d82157c02a5f58.1706466321.git.code@khaugsbakk.name> <cover.1706550761.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

c15129b699 (config: factor out global config file retrieval, 2024-01-18)
was a refactor that moved some of the code in this function to
`config.c`. However, in the process I managed to drop this code comment
which explains `$HOME not set`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Acked-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index 08fe36d499..b55bfae7d6 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -710,6 +710,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (use_global_config) {
 		given_config_source.file = git_global_config();
 		if (!given_config_source.file)
+			/*
+			 * It is unknown if HOME/.gitconfig exists, so
+			 * we do not know if we should write to XDG
+			 * location; error out even if XDG_CONFIG_HOME
+			 * is set and points at a sane location.
+			 */
 			die(_("$HOME not set"));
 		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
 	} else if (use_system_config) {
-- 
2.43.0

