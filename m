Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4EC7E770
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501224; cv=none; b=AxJnd4/cNpjUQeBIH2PgTcVe7w9C00H1eziEHR8wFiP7PFLK+g148JOrFy8lzLVssP5mDFVynalxJ58faHAWzsntp+eXi4BFAF8DBcFHc9x63pmFLtCPrGQfGVGK8wfbIDpxAynlm+JcW8XdA1UQkfBF6DDRqh6Sts0QZ3w6pN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501224; c=relaxed/simple;
	bh=m9Kq2/O47sp2z6LOMk+v9o64CBlFaMrvXlFOBQAEJps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cxh0nI7PhjIUvuA9IWCqu2HenOy8ETOvKBlGnpvVkuAQZqzXhiXbiOC9ip913CozdyV7V6727uImJ/H0OYOQTJ6Ar7s/MibJ0zDot6PO/nP5J7Q1Dc7xTWAQ5EyGRFaKU40IQ1Mqh4WV/W/sRwmEWYNyKkzgx6H68eGmWtupMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=eeUf56VX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeSs8At7; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="eeUf56VX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeSs8At7"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 5B9803200A7D;
	Fri,  9 Feb 2024 12:53:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 09 Feb 2024 12:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707501220; x=1707587620; bh=t2OR1YAz5Ci8eN9UN4gCsdKNjZeku53A
	DVKLlr3cIfM=; b=eeUf56VXd5rHpkgZ5TdYmrZwPwGN+4IPmWgO9rIwBaLXtw2m
	qWCOKqczRmiIRp8qQMTnc7MqrVLmN24Beu6fzeoBOas+2DFx2jFZowpu6cZU0574
	g3RNUM7cUvThg1JzCur/rDT9/+BPouy5g7WzA+V/mmXwcNEEpOKq11BAPk+wjjL6
	nDxCkWpbi3DIqFRjiGoje/pyS72kC2YBO7URUP0FuNYXt6rr7noIILeWl40o8bMi
	oKMyZx0YXV1EodPOR/XHx0vgdCvo8swOX5ytkDsCgrnN/dOnxPNWa25olonhrxmO
	irLa/xkCeUS4YekusWBYoS1ClUInxvvTq/4niA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707501220; x=
	1707587620; bh=t2OR1YAz5Ci8eN9UN4gCsdKNjZeku53ADVKLlr3cIfM=; b=Z
	eSs8At7UpnzkR03VokFN2kasnI12EGbVv5ZgbeLP0Ggd0HqsNpemRuonYZmiIH8+
	CW60b14XjOubs4z0+cMxjtpYJFQNLIltBvTKkAmefs1++iGeRkdDfW+dt1wyYwNe
	sYXKWLZ1q1mCjJLPhZrkNHVT24Kar6f4zKAYtzXh+UUeMqD+E3qRFiE3daqZcksK
	d3W4JPr9uWgupVChDCKftWc8ojVUsbNYwdE2jYxA8pEFl0UaHrpI94rtFlHxR1Ed
	OL+hUpiet5XbmRA2HxPJYp4XReT1zXmen+SNSZjTtqyQTV/kYhmGJX5UI3vJZt1Y
	Zp8RAI6giKfTK7Q2a0WIQ==
X-ME-Sender: <xms:pGbGZbvg5-YNp-34tieWbmy13Q8PypSnkV4HrMk7C32zYKOK0SsqqO0>
    <xme:pGbGZcfN_ELwWHHhiIW-TTMnE0_nSNANn94kxm9b4NzGj0tuhcMloKEAa2U5TmdMi
    EVIszikwT3C_as4hQ>
X-ME-Received: <xmr:pGbGZey_WONNtkNXfprebNQ7F66SU_SaMV59-FXDwNKqFTGr6poX8zFCRGeeQn5-zSvVf9hXYJ60W53xIAM1U5YYo3ZzKHfWLvDGYMfx5gg4h71033JSe3udog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:pGbGZaMrq2MowvpN8SfUBqIzLjA3GJYF7eEaxsVtPDwwqR19uiduNQ>
    <xmx:pGbGZb_KnQkDPotaqwgsX6xUijTMp61PXUy69iePeFxOwo4uduu-Tg>
    <xmx:pGbGZaWJUed0SrhcPlT8bT_Sc6Yg9pr8w0mOfG63rKQonkel0mPdGg>
    <xmx:pGbGZdLQqeknwb9rysSjdqTxA0zvh8iRXsRwxxLMiBQBrw70lM6FIg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 12:53:39 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Tiago Pascoal <tiago@pascoal.net>
Subject: [PATCH] column: disallow negative padding
Date: Fri,  9 Feb 2024 18:52:03 +0100
Message-ID: <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
References: <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A negative padding can cause some problems in the memory allocator:

• floating point exception
• data too large to fit into virtual memory space
• OOM

Disallow negative padding. Reuse a translation string from
`fast-import`.

Reported-by: Tiago Pascoal <tiago@pascoal.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/column.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/column.c b/builtin/column.c
index e80218f81f9..82902d149c2 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -45,6 +45,8 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 	memset(&copts, 0, sizeof(copts));
 	copts.padding = 1;
 	argc = parse_options(argc, argv, prefix, options, builtin_column_usage, 0);
+	if (copts.padding < 0)
+		die("%s: argument must be a non-negative integer", "padding");
 	if (argc)
 		usage_with_options(builtin_column_usage, options);
 	if (real_command || command) {
-- 
2.43.0

