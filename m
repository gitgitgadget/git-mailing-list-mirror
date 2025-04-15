Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF028BABB
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719261; cv=none; b=r4fGaw7APMFZCj6aVPonQLWwIofnU2c4TGliceG2ZjLevybRL9SuAEEpf8ReDLuXDRTWkJbNojGw0YwUcDhWMfzd4JRNIgt0/xM1IjxuDQsfdqh+WgqTum5Yz+YgtYrJtsQHwlxCKUnKi7uSTdjxAC5Pr7aW8tW9QaWEencvBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719261; c=relaxed/simple;
	bh=GGQJj/mqPtY1mo1oCEctfrq5upTeQpqq8/Z1Wfx6UKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+BM6fF6FeACbtDPHPtgHoGhH6CkQyNqAzAHSU+lZU4rcMfGiDZ4cjU3NMizTo10S8KsOEQjNSjJsIb3lxVhXrOOd/CQ5yTZlUKg7F4YBGoNz3VkIB/yi/G0ePDrHBgsAUSH29il4jlDOkxQHLKzU8tXN2mJ4oCfTTK4/86zhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SntoPp9T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4icEBvQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SntoPp9T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4icEBvQ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 24DB71380833;
	Tue, 15 Apr 2025 08:14:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 08:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744719258;
	 x=1744805658; bh=ajB11AOukNVx70wGLBhpqFZDvROti8I+GEK9/PHJ/uQ=; b=
	SntoPp9Tb42gsSSuGaVdo7ucwPvVzkC7OjVYDB8mjKcAgonoC710umoqO46Tu0M/
	eraRcfk/2igmFuF+fWK4fmWaZ4HdXr3NMAvxYDTqaGtRzYZpFQ83+AbSl+gDQotf
	BqsyJJuBYedCo0DsP5kQhv1OUfIp9OIfaUfPw8VZou9lBBpEl4q9oHO9oeYRARyy
	WK0jjtjLhabKnfsEEV6s7mhIAMrlrleB/tvxdBII0Sc1A0E1vDbpMX4WHMoqrZjs
	q0a4CZpSz2LrRkYPEc29qog7AGVn6QwNNFlaQKCJfZ8oHaxB7UEPJmvi0U18oRai
	ZFjg8MiBQlNxpM/gPz9afA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744719258; x=
	1744805658; bh=ajB11AOukNVx70wGLBhpqFZDvROti8I+GEK9/PHJ/uQ=; b=g
	4icEBvQGPUUKY53hv8FLxtGfpfs35YlRA3zK79D4cl6veaaAs/7TvO95zdEK/1L/
	ChcssxFDBYiWP67OZhp/GjLhqLr33kfd7iUOKiS4f3GFKlu2lazfF2SfmW9OTWky
	ybzTw4FRe3+oc37rYHvw/Y9JcxFiWHY8Yrc/n1MiiW8GSe9jLr/e67V7/ycqXKbI
	uis9PKU7MdDovG3Jzy/J4XC1ViqtDlmK00xU6OSAR5UTOcO88b90UrDSGEBlMbP8
	C9HbFAwzCVWpGh2ELQe6s6TaGYoS0Gz5yhDPaA2ZXk8L1y5FE5fvRO4gbGmiiNqQ
	US9ZgcPbV4ya1uqd411+g==
X-ME-Sender: <xms:mU3-Z1vUOszepMFD_4qdXzBEAzEBx5gMge6bUHnDTMJX99M2vRlJKw>
    <xme:mU3-Z-dIsMX9fkuimIE7Tgt03ssO9PxrCcJhtQKsoBHIpOZIgvL1oMyAD4w_4TGWL
    iRAUupj_SgnGYZwyA>
X-ME-Received: <xmr:mU3-Z4zs4gtwXeCg7VaJFWKlrnz55dL03k_iJCcqQ86JlYCyNTjQJ65i55UNk2hSbT1DAfGWU_ktw69AFcI13T3ZGhpgCU4hmZbAo8Z8GFDABQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpth
    htohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mU3-Z8PrF66AU6ydyfpdHMjS1yr3soaP-jZ4wK0c0UJopY4p5W7h3w>
    <xmx:mU3-Z19YCEw4aU553pMOzfFUTnvXmSdoUIK5jt7tzRDN3hjEqZxpPQ>
    <xmx:mU3-Z8WWbTlsgBmsnZUahhlTh--NTpS7OFkHJALQYiUoT2AhJXFC_Q>
    <xmx:mU3-Z2fBVy8tHTaEUlM4UGkb3LZHs27uC2Syq9YkXtoSaMQ2vJ8K7Q>
    <xmx:mk3-Z6HMcC6vMEqdgQoWu1vS8HmJp-FWHVp-ZcXZiUWBcZqzjvaocmaS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 08:14:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 452d6bd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 12:14:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 14:14:07 +0200
Subject: [PATCH v2 3/5] parse-options: introduce precision handling for
 `OPTION_MAGNITUDE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-pks-parse-options-integers-v2-3-ce07441a1f01@pks.im>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
In-Reply-To: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

This commit is the equivalent to the preceding commit, but instead of
introducing precision handling for `OPTION_INTEGER` we introduce it for
`OPTION_MAGNITUDE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c               | 43 +++++++++++++++++++++++++++++++++----------
 parse-options.h               |  1 +
 t/helper/test-parse-options.c |  3 +++
 t/t0040-parse-options.sh      | 18 +++++++++++++++++-
 4 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 6ddebc20516..ae836c384c7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -217,21 +217,44 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		}
 	}
 	case OPTION_MAGNITUDE:
+	{
+		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
+		unsigned long value;
+
 		if (unset) {
-			*(unsigned long *)opt->value = 0;
-			return 0;
-		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
-			*(unsigned long *)opt->value = opt->defval;
-			return 0;
-		}
-		if (get_arg(p, opt, flags, &arg))
+			value = 0;
+		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			value = opt->defval;
+		} else if (get_arg(p, opt, flags, &arg)) {
 			return -1;
-		if (!git_parse_ulong(arg, opt->value))
+		} else if (!git_parse_ulong(arg, &value)) {
 			return error(_("%s expects a non-negative integer value"
 				       " with an optional k/m/g suffix"),
 				     optname(opt, flags));
-		return 0;
+		}
+
+		if (value > upper_bound)
+			return error(_("value %"PRIuMAX" for %s exceeds %"PRIuMAX),
+				     (uintmax_t) value, optname(opt, flags), upper_bound);
+
+		switch (opt->precision) {
+		case 1:
+			*(uint8_t *)opt->value = value;
+			return 0;
+		case 2:
+			*(uint16_t *)opt->value = value;
+			return 0;
+		case 4:
+			*(uint32_t *)opt->value = value;
+			return 0;
+		case 8:
+			*(uint64_t *)opt->value = value;
+			return 0;
+		default:
+			BUG("invalid precision for option %s",
+			    optname(opt, flags));
+		}
+	}
 
 	default:
 		BUG("opt->type %d should not happen", opt->type);
diff --git a/parse-options.h b/parse-options.h
index 8d5f9c95f9c..4b561679581 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -281,6 +281,7 @@ struct option {
 	.short_name = (s), \
 	.long_name = (l), \
 	.value = (v), \
+	.precision = sizeof(*v), \
 	.argh = N_("n"), \
 	.help = (h), \
 	.flags = PARSE_OPT_NONEG, \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index b1275dfade4..46deb4317ef 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -120,6 +120,7 @@ int cmd__parse_options(int argc, const char **argv)
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
 	struct string_list list = STRING_LIST_INIT_NODUP;
+	uint16_t m16 = 0;
 	int16_t i16 = 0;
 
 	struct option options[] = {
@@ -143,6 +144,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
+		OPT_MAGNITUDE(0, "m16", &m16, "get a 16 bit magnitude"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
 		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
@@ -214,6 +216,7 @@ int cmd__parse_options(int argc, const char **argv)
 	show(&expect, &ret, "integer: %d", integer);
 	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
 	show(&expect, &ret, "magnitude: %lu", magnitude);
+	show(&expect, &ret, "m16: %"PRIuMAX, (uintmax_t) m16);
 	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
 	show(&expect, &ret, "string: %s", string ? string : "(not set)");
 	show(&expect, &ret, "abbrev: %d", abbrev);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index e3ca7a27738..5f503b26cc8 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -25,6 +25,7 @@ usage: test-tool parse-options <options>
     --[no-]i16 <n>        get a 16 bit integer
     -j <n>                get a integer, too
     -m, --magnitude <n>   get a magnitude
+    --m16 <n>             get a 16 bit magnitude
     --[no-]set23          set integer to 23
     --mode1               set integer to 1 (cmdmode option)
     --mode2               set integer to 2 (cmdmode option)
@@ -139,6 +140,7 @@ boolean: 2
 integer: 1729
 i16: 0
 magnitude: 16384
+m16: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -160,6 +162,7 @@ boolean: 2
 integer: 1729
 i16: 9000
 magnitude: 16384
+m16: 32768
 timestamp: 0
 string: 321
 abbrev: 10
@@ -171,7 +174,7 @@ EOF
 
 test_expect_success 'long options' '
 	test-tool parse-options --boolean --integer 1729 --i16 9000 --magnitude 16k \
-		--boolean --string2=321 --verbose --verbose --no-dry-run \
+		--m16 32k --boolean --string2=321 --verbose --verbose --no-dry-run \
 		--abbrev=10 --file fi.le --obsolete \
 		>output 2>output.err &&
 	test_must_be_empty output.err &&
@@ -184,6 +187,7 @@ test_expect_success 'abbreviate to something longer than SHA1 length' '
 	integer: 0
 	i16: 0
 	magnitude: 0
+	m16: 0
 	timestamp: 0
 	string: (not set)
 	abbrev: 100
@@ -259,6 +263,7 @@ boolean: 1
 integer: 13
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -283,6 +288,7 @@ boolean: 0
 integer: 2
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -351,6 +357,7 @@ boolean: 5
 integer: 4
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -377,6 +384,7 @@ boolean: 1
 integer: 23
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -457,6 +465,7 @@ boolean: 0
 integer: 0
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -804,4 +813,11 @@ test_expect_success 'i16 limits range' '
 	test_grep "value -32769 for option .i16. not in range \[-32768,32767\]" err
 '
 
+test_expect_success 'm16 limits range' '
+	test-tool parse-options --m16 65535 >out &&
+	test_grep "m16: 65535" out &&
+	test_must_fail test-tool parse-options --m16 65536 2>err &&
+	test_grep "value 65536 for option .m16. exceeds 65535" err
+'
+
 test_done

-- 
2.49.0.805.g082f7c87e0.dirty

