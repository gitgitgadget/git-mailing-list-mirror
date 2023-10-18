Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B13DFE6
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="TbXpmV/j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWxalzYx"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E601B9
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 13:29:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E02735C01F7;
	Wed, 18 Oct 2023 16:29:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 16:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697660958; x=
	1697747358; bh=62aWoPylZCqih6z4kx4qnentc7+P/sN58F7+grESGnU=; b=T
	bXpmV/jsjvr5/+hoDYhVgfNIZM+7zbQ9Zmelfk0fDgv16PYbDhIxzPvjBdzAjlBH
	xOnV0q8Ke/LElGh/lAv+2dkMhYDFLFbv0AK7NOeR/sXZzmpMY5kYVNVbEwLqmw7D
	9uJYXnTMVxm83ogIygIliMGvIjM1h+qFRdk9YV3FjWo6GI7DCPqYhddrj3v1xKlb
	hsnkn1LX8BMdLkgX5zl4Sve8Bv+pRFGG64KvL5mdb79RLB6Eo0Us1BMS+eDfUptT
	IezTKk8wCgSNtNOgj4aKt9lIVlpsmxecvZDphL/lQ/2DZg7OyeM/fYP2p776df7E
	4jEIk7UbbA74do9/LOlHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697660958; x=
	1697747358; bh=62aWoPylZCqih6z4kx4qnentc7+P/sN58F7+grESGnU=; b=c
	WxalzYxVHe817g5hRX9a/ZD4BYREohDUMIpAl+pQ6vauIQOP+nQvxolODWIhvgLC
	2Xbnq5I0qFbetXJBovBTEs9dVotS7LAMs0zzhUoXjW6wjA4IjyC54AUu9AFq6c2O
	4pBPay37A5dB9RXoOvVw1G+hw+MehV9gbbDqltwR5FLT5+nXDC+E9l3uhQN3TWaH
	ud4fob4yVlbXH7+kgdk7Do8+f3jDtEUjsmg+FcDfuiVlqFsdL5pJuw1Y5nTqUbpY
	BKJiTxTWeBmyLS76mkLRyOIKYtV5MDaUUKpxV28K+G1puaIjz2poXs++w/jo8ao1
	rdKQytelwc5l0CW9QA4wA==
X-ME-Sender: <xms:HkAwZVACexMIb4nBHMxr2eLmE0RyIXp2qIPiJwfwSAYTEDMjPVNg35E>
    <xme:HkAwZTj4KZmo9MQA9jicuhHT-iZmNEXDJ42SXuxRFOlHTFt3e-hCUETchHZdjzl3H
    csmrzbIrEHRGOs94w>
X-ME-Received: <xmr:HkAwZQlY4UYljTTRTffeKknsPm3qrm3p9L31yfjxgS1or188GWpsOAvUAEMCt1TgXptzmhLjH5-w83sGyB4dAscnW3-WrSieVG_a-UI3Iggye0Q1uWF0Zv41qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduie
    ehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:HkAwZfz9Od7yxgqcFKM2VCuees-HZyI6IyYhMVZZFnTHt5B4-oR1Pg>
    <xmx:HkAwZaRQdaEzaLBuHl0AFebhAfSOiW4-8jCAufQE1zC1YMDPM0WFhw>
    <xmx:HkAwZSZKfTUWE2GEv6ZoJX9FzosSKoMBMfUn11n-oU86EIKUq0yKiQ>
    <xmx:HkAwZVdOtO1OJCxe2wYYSiKqMQQ0C4v6yli55HvcppRGKRx5Np6AIA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 16:29:17 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com
Subject: [PATCH v1 1/4] config: format newlines
Date: Wed, 18 Oct 2023 22:28:38 +0200
Message-ID: <39934cb7e50ad0a5b287b13d0cdcf2f87a96d6f6.1697660181.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <cover.1697660181.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Remove unneeded newlines according to `clang-format`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Honestly the formatter changing these lines over and over again was just
    annoying. And we're visiting the file anyway.

 builtin/config.c | 1 -
 config.c         | 2 --
 2 files changed, 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 11a4d4ef141..87d0dc92d99 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -760,7 +760,6 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		given_config_source.scope = CONFIG_SCOPE_COMMAND;
 	}
 
-
 	if (respect_includes_opt == -1)
 		config_options.respect_includes = !given_config_source.file;
 	else
diff --git a/config.c b/config.c
index 3846a37be97..19f832818f1 100644
--- a/config.c
+++ b/config.c
@@ -96,7 +96,6 @@ static long config_file_ftell(struct config_source *conf)
 	return ftell(conf->u.file);
 }
 
-
 static int config_buf_fgetc(struct config_source *conf)
 {
 	if (conf->u.buf.pos < conf->u.buf.len)
@@ -3564,7 +3563,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 write_err_out:
 	ret = write_error(get_lock_file_path(&lock));
 	goto out_free;
-
 }
 
 void git_config_set_multivar_in_file(const char *config_filename,
-- 
2.42.0.2.g879ad04204

