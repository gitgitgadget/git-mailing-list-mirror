Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF522D63F
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594426; cv=none; b=EpQETu97V30hj5WJCwZDWT9iZ2wIfg80UwY4W4b16ASl6zChBI7SjI9Alwhc4UaJJDDWmvYnDI1H1KKHequf7dFU5WQ4JmnxrCJhdrBpB90xscIkEDRynaARt5z/3v6ZP7Bu4eg2nSPdMX1EJZdg9MMGfsVYWvoOmcPJpnGwrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594426; c=relaxed/simple;
	bh=j61b5x9RQ4liFjnavtOQOkRll34uKeCQ+O6dBUFkoQc=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=Q1JNTTnyPErLoX99LiA2xgPG/kZhY/CzTGr02MeTu9dNwJot4U2ODKTwkyf1zyb7pU2rPd6IhQnOZ5ITFkIHculSnYANnEn22p9VmWKGUTl5wsrBoV5L13TPe4Sh9e1vQKspuNNTZGxdDpzDWTGwFw8RY4o5wKBr5Mu+ZlvtmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=C9WFemTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t7w0JlUo; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="C9WFemTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t7w0JlUo"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CDA515C00D5;
	Thu, 18 Jan 2024 11:13:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 18 Jan 2024 11:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705594423; x=
	1705680823; bh=3PMwYZ3TK+aS0letAdpJMqPmC2YZhQB8Jz2gw+rBO/A=; b=C
	9WFemTPfGlkazwS+h4Ud12UKOZo4h6fztq8YahIe+nvwdWuDrzikI8/WkgxPcsBi
	AXIy1f9deEtDKxOn+xc4xVHkAytpRdoflV8NH4k/f8AYF6AiQA3EhcZlBrk8X3lg
	7telRqKKRy0CtqY+kmIpoM3onwi5mbSF4cP7jH8ZZyZghAT+FtGXBce84VIvY50X
	1/y6FtbCvJFc/EfbCtKxQNmFhpsvjmFsZlp79kL/p9QCrdGpkT9eQxTZPkIQmunL
	28+N50Sl7yCzgB7VThczqRrn+LESemqQYyto8YAi8FoiyIPF+ITQCctWlrcc40/p
	OnTb6Es+X0z7eFiInZAhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705594423; x=
	1705680823; bh=3PMwYZ3TK+aS0letAdpJMqPmC2YZhQB8Jz2gw+rBO/A=; b=t
	7w0JlUoSykK+HKrOEs4Cl/gA4UdREXnv2JOG9OAOrIaqKnWrUtK9s+qmeNZ7yDFJ
	7UryKnPOgrsac3LBH9CqugVxE7xoB15DTL+kyYPfcGJnDSHCboGl1FaC6/SHe2LD
	t52bwat1vO16BmfqBT22d3HVKBX2CgKtaTKYWfdMZYxTMaB4Qo8UOnGqmWHoA931
	Ev0NQgGsBC8IUe6BPPQnyGDL1LGzUWqpg40Z7XimtYy127AoVrxug1tRaptDVMa5
	nMeH5DEi207B92v8AwTZlqhfTRfqwwhHVvVP/FEp4fATVmF/27VKGX5OVhhq/5Tw
	fg8sIyBw4qDWu3Yp4WyHw==
X-ME-Sender: <xms:N06pZa-dCRV_QwcNrbO-gz28RUQnXlmhU53WDITx3y7ZdCSHvWgYViE>
    <xme:N06pZat5DQBaBh0xjvbG_4VycUQrNe5b9p0Odw4ZxGbRr9wiRVjWVqY_PyI0tT52Q
    VodbdsFDBrfa0BStw>
X-ME-Received: <xmr:N06pZQDIEIwDAlvR-7LzkNcVHX3ayroConNNBFl2c88pZuhXy1iTEvZ8Yed-vVtD8z6Bn7xTg-zfn_TWwT9hLsIZG2rjietq1QUhneB0Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetudeiheeguddtgfduveekhfevudeiieetjefh
    ffetiedtgeejieehtdfhjefgteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:N06pZSeUuFsfpnqBN_qDuQA00mMBe2b2Bq5YkZgLVyb34fYqsb6VNA>
    <xmx:N06pZfPi6YT9cTezT1rCVTZEIKlS5CdPNYgSQS6p2oTWaD0PmardHA>
    <xmx:N06pZcmPZixllwPtIYzZ_Nvtb_Lc-cZoBZlGk-Gv2BOgvlj7KOghRQ>
    <xmx:N06pZa1803A_y-JQ3qiTnOKBBCNz5-OMG5jjjJfmEv46zB7eoMcBUw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 11:13:42 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] config: format newlines
Date: Thu, 18 Jan 2024 17:12:49 +0100
Message-ID: <1c92b772ef48a91e76b51fd58d941cfdcad93aec.1705593810.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705593810.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name> <cover.1705593810.git.code@khaugsbakk.name>
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
index 9ff6ae1cb90..d26e16e3ce3 100644
--- a/config.c
+++ b/config.c
@@ -95,7 +95,6 @@ static long config_file_ftell(struct config_source *conf)
 	return ftell(conf->u.file);
 }
 
-
 static int config_buf_fgetc(struct config_source *conf)
 {
 	if (conf->u.buf.pos < conf->u.buf.len)
@@ -3418,7 +3417,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 write_err_out:
 	ret = write_error(get_lock_file_path(&lock));
 	goto out_free;
-
 }
 
 void git_config_set_multivar_in_file(const char *config_filename,
-- 
2.43.0

