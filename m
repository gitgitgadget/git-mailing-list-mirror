Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2AF17DFE8
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318275; cv=none; b=bhZyyhaWPlByrU1FgXHlOxuO+vbKY5FGcv5JWtU1NmHLEdpUBde0Qk0Xk3cjxvRGPts2R9qNO9YYQyiRRF6lPZt2Wgk1RF/PbrDQBAHJzliw2JCh27yjq2r4ad4igxRdxMFGn51t0u+iMR2rdQ2H4At5ATUgcFKC1ocHdU0KySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318275; c=relaxed/simple;
	bh=4Y4zeuGh7V0E83InyVTCDl1J8f90huuPPuiwEZnG/3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRLqxSGhhRQboSnu3yA6B8Qng+CiFhnV5Mw1XFCXurplzEABx36OMoZgxK9Sw3/LAIw0T6DDyPRpFJv/DmwAdvWQkbEEsiL0H3GBIGUhwxIbwdTA6Y8L19hdYQYar0S/nnW5UF0UmS8IXDOdgfyVH7lcS8tfXVcctOtSHqwxAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TQQHn35b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbheaVkl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TQQHn35b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbheaVkl"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 959DA1151A66;
	Thu, 22 Aug 2024 05:17:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 22 Aug 2024 05:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318272; x=1724404672; bh=OT/ILweivx
	G7JsgdgnAFGi+dS6Stjb4IqAXdKHsxg1Y=; b=TQQHn35bbVF622UBT2fZ3hl4Qv
	5mSaLx1aT0YfF2GWMbXNNfdkC+577ORLuxJateNqqsU4pLjarJetNMwCbn+EcEfP
	GZrmio/69NKF51ewCvn7350nXtlBLrEUZzpPmi9YpsSGV/vCwR093KjUvwY7ZNB9
	VOo6MpvIp1wz7dP7lvm3jMbh7S8fFsTMqYclnAZp+UfqKqB93UufuN2uo77AsyY9
	hERu/hmP51eP1NKnxeUPvBY36m2ykScLG54UX6CUGDdDOxVCjZoWmsdm0s89decR
	5J3IepZE/b9nZbwZCM2CNR7aqk8Zkft5gI2U87KAqsBsPDhnfxbuGs9+16Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318272; x=1724404672; bh=OT/ILweivxG7JsgdgnAFGi+dS6St
	jb4IqAXdKHsxg1Y=; b=CbheaVklvLZmeczcPCG1X0E6kwkjay32lF7Wy0LU03UL
	ArOOLfB8Tg2AdML/3vLCeFEWgHX5rV2zHBdrr7HQLn5TtMFT+0feuKMDeAhrEJQt
	H/4wMPmRr8DWuKBfZzsLd2J8BPs7uVAqAYERR+1RyS9hEKZlcbgFGrD88BGH1Ngu
	+q08Mkgnb41zyaoagh8IICeY9ygfwpB1kJKLkF/dpKt38R56O7o03t/0sSh6p/sV
	ohoKZeBKdXkTl9jYyVGgGNX5xjjgOjo0nxeJa8HD6Qg79NnsJVcjgkOHZVLylnVb
	GdkbW3DHhI4/E8F04XT8ZnkW58kx7yqnm5fb4eAY2A==
X-ME-Sender: <xms:QALHZmFQz3237ed07VJOwM8G9W1-ALdx40Y-JUXDoz7Yao4K9lwCRw>
    <xme:QALHZnV73lIhfPk-3EpJAASzoO6-LGa1qiSGIxxrInVBHeVbsP_NKoMCwrsbU7P3e
    WeH2sjBxLpXFOwBKQ>
X-ME-Received: <xmr:QALHZgIH4mjMWkJ5uf_P6IDG5SMkouBKSsMvUhwlGS5WEiWyLJrXLRe3AIlyoCGahykgVoDjtb439_cFSGcne1HkImczn-MGnUxMnBD6igPB2-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:QALHZgE0RDGJy6AZAdl6-h3baEXCVG6vk8ao_B3W71g5NoRYYL-U0A>
    <xmx:QALHZsXO8ksHm2PfeOIPo3SavISOd5CHuV1JrtDFCy3w4ad-3RmKpQ>
    <xmx:QALHZjOkqXDYywREohLqo7UkHJv-wFIc8E0x53Yr9csfMjEK0_Ioaw>
    <xmx:QALHZj1NYm04YvTh3d_8FG9-WMWgZR4FTPRLcJJVoKEj6mD5iylxsQ>
    <xmx:QALHZpgP_ZISAGEcNhPNwSOEsxa19zTPxa55jx9btkCeeoHXUXo13IRn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 57e234e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:16 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/20] sideband: fix leaks when configuring sideband colors
Message-ID: <28805c15a425f822ef1851affa14803a5499b6d4.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

We read a bunch of configs in `use_sideband_colors()` to configure the
colors that Git should use. We never free the strings read from the
config though, causing memory leaks.

Refactor the code to use `git_config_get_string_tmp()` instead, which
does not allocate memory. As we throw the strings away after parsing
them anyway there is no need to use allocated strings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sideband.c                          | 15 +++++++--------
 t/t5409-colorize-remote-messages.sh |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sideband.c b/sideband.c
index 5d8907151fe..27853736901 100644
--- a/sideband.c
+++ b/sideband.c
@@ -30,28 +30,27 @@ static int use_sideband_colors(void)
 
 	const char *key = "color.remote";
 	struct strbuf sb = STRBUF_INIT;
-	char *value;
+	const char *value;
 	int i;
 
 	if (use_sideband_colors_cached >= 0)
 		return use_sideband_colors_cached;
 
-	if (!git_config_get_string(key, &value)) {
+	if (!git_config_get_string_tmp(key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
-	} else if (!git_config_get_string("color.ui", &value)) {
+	else if (!git_config_get_string_tmp("color.ui", &value))
 		use_sideband_colors_cached = git_config_colorbool("color.ui", value);
-	} else {
+	else
 		use_sideband_colors_cached = GIT_COLOR_AUTO;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
 		strbuf_reset(&sb);
 		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
-		if (git_config_get_string(sb.buf, &value))
-			continue;
-		if (color_parse(value, keywords[i].color))
+		if (git_config_get_string_tmp(sb.buf, &value))
 			continue;
+		color_parse(value, keywords[i].color);
 	}
+
 	strbuf_release(&sb);
 	return use_sideband_colors_cached;
 }
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index fa5de4500a4..516b22fd963 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -2,6 +2,7 @@
 
 test_description='remote messages are colorized on the client'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.0.164.g477ce5ccd6.dirty

