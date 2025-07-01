Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E9279788
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382903; cv=none; b=L1OkjeAFVZFeB9SOEcXqkU4ty47R8os6UsgTUXH5eWVBl3aJzHKkwpuDcAaHLLRVyyc2f4gok28PrUhcByYbwV3kcKq3LCo1nJ7R79peVM2x/fMvLoWWBGXxYF2x0aBdI7m9raCqMUmf1RyO/uafYDkCvtXtiNtH6rkNBE8DXfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382903; c=relaxed/simple;
	bh=919hFyTovuxijRVqHIPMXgTB3A2NfZdMuH+Z5rEHHtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUu3Ud5QsiGBW5nm23kMIlDZvF33nQBR4WBSv88nqyzyS2UicVaYZ3tvbpfNk/vGW9W4tEsRFKWTShT/P48AvKLbhnIjVQGGDCvFS3fPSvSlHdsvdh3c2tY1QlC7m3wLK+n3TDJFYhOGVw+URdrig1UhJXhZGnqgsiFKNUrYIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=r5fyO9Eu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OU7Q7Gwa; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="r5fyO9Eu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OU7Q7Gwa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CBA11400166;
	Tue,  1 Jul 2025 11:15:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 01 Jul 2025 11:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751382901;
	 x=1751469301; bh=0SM2GCwhB7dvdR/2DRaJFIA4LYnunQMelgPFhkMrlYE=; b=
	r5fyO9EulWzMCMDAQO2MfMUS5DZIXhhLGh47O0xjoBKsNaRWNazY5FYCCJvNgGKF
	YIB9NBQTP4pnK1aPHG0LdFVEnqf6zmfAIxV3ytZR/TjCO8Rbm6FQBQb9F3emWGuu
	KTnBP8VkTPkbynvJBBoxdeYFZZOVV6/dX5ckylXqpXA1NGBom9ClDk63968MGpmv
	cs0EgTGF+IkFhTDefLlAOyHukflzA337yCsDtzGIszZjK5Wv3gIGO6DqVsu54Kih
	hlC4oWc4+GvMA28DVK3F18q0fc1NLUTZEaDG3WpVwycrgaPtN9yyqzSaRuS+KPJm
	ROs2+MRXqknhVNzKjfrAVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751382901; x=
	1751469301; bh=0SM2GCwhB7dvdR/2DRaJFIA4LYnunQMelgPFhkMrlYE=; b=O
	U7Q7Gwa1MoCBn3+MtzzM+bmEU77kPxwXFRFbfjN5bngsYkTgpuN/1aILlsgb+VdN
	j0bpDcJKGTDoEBtmdu1JddkO0BTlc742rWcGA1zcECbed6z6I0QFVRI50y7Jy2ns
	QNQypGRDajsHeeREeVkStNdhrLmounnOKiG6ytQf44vIY0ZgA1UbNETfIXgl6Dj7
	d1JxHVcLQQZAGKHcGv4GOxy6qPEKV4b8Wr5XMYpdlUqmseYE7WoWmKgInQytkqBZ
	RWXGZW9m1GNPQHlQM5bQXTvVaxMN2hqCH1Ce9uWNm7EP1ri11rhleFVWeUMZyAcF
	+aXLoRsXr8Ukytu7e9QOA==
X-ME-Sender: <xms:dPtjaJsx8gzkzvZdxCEBTSDFEzJBvi4nrxuClNdyg0-0X7vMJWfcaWk>
    <xme:dPtjaCd9iohh6AbXW2pBPdR_8Cyw73h3-CfwX7tIG1RGJdujGD99F5DbvL5Xbpkun
    wGO1ajWaGlv7JioxA>
X-ME-Received: <xmr:dPtjaMyrvLjVR7hHhBuVrwTGSgZ1N7Xl1HJsv1c6Z_y8pRfUPLbDeq1RK-EsoxwFr-sr1A6-aMjCJ7yasy2jCLnOPfJX_PieQ1uFRlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgv
    tghordgtohhm
X-ME-Proxy: <xmx:dPtjaAPaobcQjk89pXZsxdcpEwrS7CsqtsFVm_nK_Pf5wFM17oLHzA>
    <xmx:dPtjaJ9J0GrBZIR2g6XGLZ0xd_qXye3oMeSuoFQkoEjlaxJNe0zkPQ>
    <xmx:dPtjaAXPTt5Ou5c5bCrag-tigyXNlhgh6DlfpNKKmHklrB2ktjw9qQ>
    <xmx:dPtjaKc0xhb5Pw-_S_Bckprwc24Z5Mm3pt8coExwTArV7D05uo5Jcg>
    <xmx:dftjaFLQN-G93a8j5_ksEjLI9WFex78q5TpXKT3u1YUpZ9aZYo-lW6q4>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 11:14:59 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] config: use --value=<pattern> consistently
Date: Tue,  1 Jul 2025 17:14:29 +0200
Message-ID: <fa183e470c52aed223d284f17a222a02edaeaad2.1751382830.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.136.g907b27ebd9e
In-Reply-To: <cover.1751382830.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name> <cover.1751382830.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This option was introduced in a series of commits from fe3ccc7aab (Merge
branch 'ps/config-subcommands', 2024-05-15).  But two styles were used
for the value provided to the option:

1. Synopsis: `--value=<value>`
2. Deprecated Modes: `--value=<pattern>`

(2) is also used in the synopsis on the command.

Use (2) consistently throughout since it’s a pattern in the general
case (`value` sounds more generic).

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Unbreak t/t0450-txt-doc-vs-help.sh caused by source/doc synopsis being
      out of synch
    • Replaced the rest that I missed

 Documentation/git-config.adoc |  6 +++---
 builtin/config.c              | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index e05bf813d46..d3ddc538555 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -10,9 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
-'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>
-'git config set' [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>
-'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>
+'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>
+'git config set' [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>
+'git config unset' [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>
 'git config rename-section' [<file-option>] <old-name> <new-name>
 'git config remove-section' [<file-option>] <name>
 'git config edit' [<file-option>]
diff --git a/builtin/config.c b/builtin/config.c
index f70d6354772..706269647e5 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -17,9 +17,9 @@
 
 static const char *const builtin_config_usage[] = {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
-	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
-	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
+	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>"),
+	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>"),
+	N_("git config unset [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>"),
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
 	N_("git config remove-section [<file-option>] <name>"),
 	N_("git config edit [<file-option>]"),
@@ -33,17 +33,17 @@ static const char *const builtin_config_list_usage[] = {
 };
 
 static const char *const builtin_config_get_usage[] = {
-	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
+	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>"),
 	NULL
 };
 
 static const char *const builtin_config_set_usage[] = {
-	N_("git config set [<file-option>] [--type=<type>] [--comment=<message>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
+	N_("git config set [<file-option>] [--type=<type>] [--comment=<message>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>"),
 	NULL
 };
 
 static const char *const builtin_config_unset_usage[] = {
-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
+	N_("git config unset [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>"),
 	NULL
 };
 
-- 
2.50.0.136.g303b50f9132

