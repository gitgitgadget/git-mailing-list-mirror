Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA35D478
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679699; cv=none; b=XpfsRW1L4QLojJ1d8C+o/tCSjgs5rofE2iF/PV/aYmhHFLL2/vb0hzCk4LzVz03U7bJAvXdv7FHlIDNIxBB8ORjtHNlLy6ZBka/U8EWRTfom08FhzXdYXdDEoc/6QB8BFFJKL3Zy/pvrI1Zu+xzoH4gAEhX//nbiPHL4SJEK2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679699; c=relaxed/simple;
	bh=9CQEk+oSUh/XyPFH5IeX9sUKed/+kUG+5FOw1Q9gy0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/1fc/Ee0YWUid0/UWhckc0cseG8wPWtE6y4xvs5APO46LwVnpkGkP15AZy3hZ34OL81EsBcwLlKhD8wvF+qkd6125MjZZzs+r8QdZhSTwG7oRCBikVPL+aNaImgJhpFAbMoNa7W4a5W11hb39iZe5CEcRAp09X+5plcv/e4HUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=ZjNTCvS2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s6HVVyEi; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="ZjNTCvS2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s6HVVyEi"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9FEBB5C0071;
	Sun, 11 Feb 2024 14:28:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 11 Feb 2024 14:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707679695; x=1707766095; bh=gZ9vqh55Y6nUmo8IeAEX5YgPg+FTPbQl
	kId9lYpfCOE=; b=ZjNTCvS2251LlXwfPv0FXGGH0NqTO36oPUNdgEeMduTqerAx
	NpSkxdX7pg2FBnTDsHuYgXRFlEG8doBUO9XEga4FHY74EYGm1HMb8TdPthvkYutd
	N4+oizr/Zi/sAK0bGg6wFLokcLmNUyIEN52NadBah4pgnNPOn83QLbq3uA6IBUlU
	pr6C0XLIU12KPXcqdCVkdF3efQxGMmpDgxdB0H577fLMVgoDyv5q06wL9w5jnfDK
	ufdFm4kTO0NBAn8izCzaoPS2yNeDNL0ZQgml2H03zxpdCV303MVk4qpzRZolDrTv
	In0c6r+GeNlvsn/IkFE4+V++NGC+2Dk6dKTyJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707679695; x=
	1707766095; bh=gZ9vqh55Y6nUmo8IeAEX5YgPg+FTPbQlkId9lYpfCOE=; b=s
	6HVVyEifsd9GQ4eCVdtKZ5VO5kwoakopmEoHSqoX9EeN/zIelyaqUsSPSyqPQN2S
	xHCjDeV3KMxAeUTfwlLXPinJDtHOKFXbTKT+oPsOy7vht37cBLWRebai7RpHEDfy
	SpTJfYRz66mPY3OkT7G5JNXs5nC/dVzJQL5RAzUaFuzq6UksGY1wOX9wS9ypvDAu
	cAXHC28YCg+sYAqzE2MsK5GHr6bG5l59X/q/6R9OxAX/G06SjT6O/CvhBVH4K+Ah
	Vir0ybExSfDMM2Fv8MQ6h/Ac/QIwvLqt5VJV+IoMUbVsOrLwwanElXzNdCYkePWY
	kjDkLpYhK2L8hq0riHlJA==
X-ME-Sender: <xms:zx_JZduvT6ajTxRk1fggMah2d9fH1hLm8yjbGUcOiw8ffoVNy3NohCQ>
    <xme:zx_JZWe-xrftQx_qykeFs8R9O-gzFXkKJlzd_bNYfm4rJPvKnwK9iF4Afpi2gizgg
    IvxH96FM1uAplRQng>
X-ME-Received: <xmr:zx_JZQz0A58pjRKdsP9lCI-anoUuyX36uMBOEc35WI0EOS3xBkQp1nOB-_QsRMqAXpvklEMLtMX_xwK-sv80duZBN36JryCWRIjc4fWhedq6iNWdTF39ljKiGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:zx_JZUMd5emANbhVuRLiwVqxyxIutlzhUyOFPlRqQ0riup5ZN_ZZ2w>
    <xmx:zx_JZd9r3778CZCR2ScuJ52cuctz9QD71MQ4H5CWD-txIaD0RdSWAQ>
    <xmx:zx_JZUXkhVRCh-_N1Y2W0S85ykONRrFSsUdlsHqbbmdxy0PyY94CNQ>
    <xmx:zx_JZZblrYCbWk0Xd182Oir5q9Wfob8JpwGBuROmjEOKh3uljklbUg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Feb 2024 14:28:13 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Tiago Pascoal  <tiago@pascoal.net>,
	Chris Torek <chris.torek@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] column: disallow negative padding
Date: Sun, 11 Feb 2024 20:27:49 +0100
Message-ID: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
References: <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A negative padding does not make sense and can cause errors in the
memory allocator since it’s interpreted as an unsigned integer.

Disallow negative padding. Also guard against negative padding in
`column.c` where it is conditionally used.

Reported-by: Tiago Pascoal <tiago@pascoal.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Incorporate Junio’s changes (guard against negative padding in
      `column.c`)
    • Tweak commit message based on Junio’s analysis
    • Use gettext for error message
      • However I noticed that the “translation string” from `fast-import`
        isn’t a translation string. So let’s invent a new one and use a
        parameter so that it can be used elsewhere.
    • Make a test

 builtin/column.c  |  2 ++
 column.c          |  4 ++--
 t/t9002-column.sh | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/column.c b/builtin/column.c
index e80218f81f9..10ff7e01668 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -45,6 +45,8 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 	memset(&copts, 0, sizeof(copts));
 	copts.padding = 1;
 	argc = parse_options(argc, argv, prefix, options, builtin_column_usage, 0);
+	if (copts.padding < 0)
+		die(_("%s must be non-negative"), "--padding");
 	if (argc)
 		usage_with_options(builtin_column_usage, options);
 	if (real_command || command) {
diff --git a/column.c b/column.c
index ff2f0abf399..c723428bc70 100644
--- a/column.c
+++ b/column.c
@@ -189,7 +189,7 @@ void print_columns(const struct string_list *list, unsigned int colopts,
 	memset(&nopts, 0, sizeof(nopts));
 	nopts.indent = opts && opts->indent ? opts->indent : "";
 	nopts.nl = opts && opts->nl ? opts->nl : "\n";
-	nopts.padding = opts ? opts->padding : 1;
+	nopts.padding = (opts && 0 <= opts->padding) ? opts->padding : 1;
 	nopts.width = opts && opts->width ? opts->width : term_columns() - 1;
 	if (!column_active(colopts)) {
 		display_plain(list, "", "\n");
@@ -373,7 +373,7 @@ int run_column_filter(int colopts, const struct column_options *opts)
 		strvec_pushf(argv, "--width=%d", opts->width);
 	if (opts && opts->indent)
 		strvec_pushf(argv, "--indent=%s", opts->indent);
-	if (opts && opts->padding)
+	if (opts && 0 <= opts->padding)
 		strvec_pushf(argv, "--padding=%d", opts->padding);
 
 	fflush(stdout);
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index 348cc406582..d5b98e615bc 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -196,4 +196,15 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'padding must be non-negative' '
+	cat >input <<\EOF &&
+1 2 3 4 5 6
+EOF
+	cat >expected <<\EOF &&
+fatal: --padding must be non-negative
+EOF
+	test_must_fail git column --mode=column --padding=-1 <input >actual 2>&1 &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.43.0

