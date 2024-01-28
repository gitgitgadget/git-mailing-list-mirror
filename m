Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FF2030D
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706466776; cv=none; b=MuxtWvFRc9sq+JRLnlG2n8dTCy0NhNy9XRqFTjhL93yFXvtHfyfGg/QH2+meINAzhgg5VMYD2cyZhPM4+vPVrzu/NMXfh5UBSM2z55VNi9M648LwCcsjauStygKdopTZK4l8wfCUC/KduLkeqn6P8yiUfDBlpt7u8XCtgk9+iaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706466776; c=relaxed/simple;
	bh=owUooDrKe4egMeU1v8CIwnY20XOvTaYuHF/rShncpEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkV65pxVLnLow07Ffhq0PtZXUms71yDCvq4IFuTuTNbgaAJCidFrhbwwFGc8D4wBqtBitJ4o2a15Hy6EQrp/S5EQe10gb83hhng1XdXPgOcJSulhhevpoU+L9UckAHhkbAlOOS3IHnPHWUaUmilBNzPZ909TVaqy/UZNoCCUgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=UFjZFjzJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lcg8mE8Y; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="UFjZFjzJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lcg8mE8Y"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3CCFD3200AE1;
	Sun, 28 Jan 2024 13:32:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 28 Jan 2024 13:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706466772; x=
	1706553172; bh=3sCSs32YvrrvOXV12kNsBcmcBCj5lINPtZE8iTNMEbs=; b=U
	FjZFjzJCLCrjQEVbrhRDz9vvG9jfxVM0C7sR1kELKY1aSt2mYUH0YChRC20YkFwA
	a9YHE+skidV4LAKG3+ALStFuG/KF/BrQG+GWXBrKwt9dSiw9keKY/lSquoQqzXB+
	wwrlmPVrgLeNnKI3H2bKEnAo4TUTw680FMhpA23i9NjQUbKYxf6nCWq0F27GH065
	3OsWvSpvqEGOBsrsfpksOwMd9A6/q7panFr1oJ709XX3L4+TW94PsswvcHf5j25I
	nvLfgshay2JFiR2F57PdRyc0a0nOQUMC/Rk5jtb8LZ81Kh1aOwjiU/8yDKsMzxXa
	1PvqlOOnJ7idWUgFk9chg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706466772; x=
	1706553172; bh=3sCSs32YvrrvOXV12kNsBcmcBCj5lINPtZE8iTNMEbs=; b=L
	cg8mE8Y7/MskhCgTRJpM63vm2u5YU/hguezYgcn0vOzf4Pkg13Wg8BL9OvuJR3WW
	ktWKzkDbi1mU+H9m/g2F9WHaVLbdSEXzpG+TMKCam6OJxMouaDnDnx3MdfxCY/cO
	H98Nw4JfU6D0DxM93GhhML4puiJTPdMMCcXfvQqQJm5uxgxFvwfzBoNqQtx2eNTO
	LEH/J3aj0pe72jC7k96N/JefmCZw/mbDMSzX6OjhN+TwCQFqQuFZCXGwf5ftsjTk
	N+IqQTLZbgeN0r0HBrxmCYlGUnIP8ICxOAGX4GNNvSN87uUjFB7647TYqui5XSmK
	36CcX+8IVJSsRyGkcYZdw==
X-ME-Sender: <xms:1J22ZTHJ7d2FPD3YUtD9177fOhecWVCypGZnGap0-FUSRFSevjM1dJ8>
    <xme:1J22ZQXMImAeScnXCZ_upXGBjC9S8uRlEkEIkQQq2-pMPrlaWD_KDWnZ709yHepiI
    QuZpwEHUszBxlN-Dg>
X-ME-Received: <xmr:1J22ZVK0GZTvgZ-55Lrb0D_C3VDmiWcM8-_0n7etLRHX7OaT2Il6iVetK-n0fqk5MyXIFpVvk6BvITevBWkx-7QpFowjahrzr3-94vksF6PyvSRhVjAlZiXUxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetud
    eiheeguddtgfduveekhfevudeiieetjefhffetiedtgeejieehtdfhjefgteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:1J22ZRHfbsOhskL1GKfRmwcVnpcRw7xQLeP_2G-4DxZubOMziEktZw>
    <xmx:1J22ZZUEjnBf0uXtSr3wvClhawRc9NJoMUswWaKZUk89VLGNJTycsw>
    <xmx:1J22ZcNt2HRrD4czvuBl_-amzp19tOj1M-4DJMCM8_pVyw4T35_Xrg>
    <xmx:1J22ZadJdjQFQ9DYHYyhxyY465W-dT4tnTJo2g8mjheEPpQmIt1spw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 13:32:51 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/1] config: add back code comment
Date: Sun, 28 Jan 2024 19:31:40 +0100
Message-ID: <48d66e94ece3b763acbe933561d82157c02a5f58.1706466321.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706466321.git.code@khaugsbakk.name>
References: <cover.1706466321.git.code@khaugsbakk.name>
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

