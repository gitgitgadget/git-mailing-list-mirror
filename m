Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286F2459DB
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797754; cv=none; b=RnFBcHJtfyzor9Tx/YC9H7gSC/ehID7bDKEZmDjKRsRiJrYGvr4jfrt/b/enasgIupE5p5ayeLiAz1JGAZmxHYJWJFxjTBb0/EnsLnqtmi0jUXiHr/QE2B9gw2fgD6gCj3+tZ47K/HTUVMJ8XnFtYKR794DmZmv9J3adyXGj0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797754; c=relaxed/simple;
	bh=8BJ29en+eIXuQlQLInPtlYA/Z4dZFI33jawMnmZgkAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZHllDG0vJZcoULOq5pEa1DpH2VpKP62FLFE9Z3sEEvojphU9wFgEqK1Jv3owqtjDdl5zByZQ4edUZrjnuOuY4zofC2DJQJPvsG5jsTlXC1mwimDgdHclaFDTsXzeMKz2/vpiKBqvBMfxqDXhyCrd88QtFtWxMoXFsfdiPH1o80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XTcBcGr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p5nCFk/T; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XTcBcGr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p5nCFk/T"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15C7D114010B;
	Wed, 16 Apr 2025 06:02:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 16 Apr 2025 06:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744797752;
	 x=1744884152; bh=LBRzymms4ZFDDdq69Bv3MgBVzHizF4HsdMIzB0xW6Qo=; b=
	XTcBcGr/ny8uhBavVylu5j+NYlyrwxTOVCod0RYDrr9f4+NgMGT++116KAeSmAE3
	6Dj9lLjNQluLBmBgauqz5JFkFVxT3pgsYdbg+RWHmGd3jrOFucQ8pWqVHKzq8cs5
	NYbYtWj+xwPQDhyPmPv5Exu/LwYrN0kTQ1atWS4CgdUf/XdZzvGH+YGwgCRhpEjN
	5sUi272Fxkssml6S9KVcOES7rXBdVAAvPZQZgOF8a85J/ARz7F75nvC69USi4uaC
	Zp9emX+46XkzssaL0KpsCNC6ZXJt0OSK5K1osVIs+P+SVaZX9jddLSs59+nw3nZ7
	HIkpPHd80KUG0pgf0/NeYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744797752; x=
	1744884152; bh=LBRzymms4ZFDDdq69Bv3MgBVzHizF4HsdMIzB0xW6Qo=; b=p
	5nCFk/TeuXv4Rshj2/74jTk4l9bKEaKTiaZw/PYcZUAHYV2uveXvc3pr/URXJqgz
	RE+184Ouk584n7OdPYyx++OFxdTdQjqf3RzFTutJl70tQ5ErmeHiDdIwFXM/VmLj
	M6yI3izy+YhhJEM5ZksfTF6v400BmcfNpMLWwgI1nrQJKbhO6F99b7UN0Fs9Fg4I
	ooj8p16o62k6/wDtHvSoUpLxj24Vhd4P67beA3GxoRM74WZPbYy7sBWQ//R+yzGG
	lMEFlKnUezy5vl3kvdM1BGjvWBDDWqb8OPufRLY3FEL7f1h6uC6QwCZIehN5H+yn
	MxRDvZllJo/xOd3+d2wcg==
X-ME-Sender: <xms:N4D_Z49GqvZfc_3eyeea-98ZBDmzy-61VaG6p5dNcxzVPzjAfam6eQ>
    <xme:N4D_ZwuhrleYVqjCDl1lSLXaYrwhlkjkY300RimmawNon0Ru23PflOjiddY17vAN1
    b4JBUt-R6D41j9Y2w>
X-ME-Received: <xmr:N4D_Z-DLjjHuVJsLvH3y_mT7gazF-snvQwBBie4W3HGU4M_rosrcd6QtyxHXGzYzklwMhnkeDCHsO2rRDf8W0W1B_TmVgLDzg2wZMtN85j022g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggv
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrd
    hfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmiies
    phhosghogidrtghomh
X-ME-Proxy: <xmx:N4D_Z4d6W9xBgh24VOxPvPsPal-wEJ-HDPJH-VcA_LTkI1aoZ5eH3w>
    <xmx:N4D_Z9M5wEVHc8RV6VQnW905KkZA8H7Cukec1vYvMLnBolYmsHxg5A>
    <xmx:N4D_ZynNNjCCymWQMbFOFFwK7AEQamW0ClzBf6HmTfh4tnFEzD6otg>
    <xmx:N4D_Z_vBEebFAE91pCtcGQl62dLEWP6Hox6tvGWSim6gR0ZHKGw8KA>
    <xmx:OID_Z6jqXuA9PRpkTX7megPq_7s6N57KV6XOu7fM48m4GrNZN3tWwjdN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:02:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1da16f64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:02:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 12:02:16 +0200
Subject: [PATCH v3 7/7] parse-options: introduce bounded integer options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-b4-pks-parse-options-integers-v3-7-d390746bea79@pks.im>
References: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
In-Reply-To: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In the preceding commits we have introduced integer precisions. The
precision merely tracks bounds of the underlying data types so that we
don't try to for example write a `size_t` into an `unsigned`, which
could otherwise cause out-of-bounds writes.

Some options may have bounds that are stricter than the underlying data
type. Right now, users of any such options would have to manually verify
that the value passed to such an option is inside the expected bounds.
This is rather tedious, and it leads to code duplication across sites
that wish to perform such bounds checks.

Introduce `OPT_*_BOUNDED()` options that alleviate this issue. Users
can optionally specify both a lower and upper bound, and if set we will
verify that the value passed by the user is in that range.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c               | 40 ++++++++++++++++++++++++++++-----
 parse-options.h               | 52 +++++++++++++++++++++++++++++++++++++++++++
 t/helper/test-parse-options.c |  5 +++++
 t/t0040-parse-options.sh      | 33 +++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e4dc22464b2..d1dffcfdf5f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -177,6 +177,20 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		intmax_t lower_bound = -upper_bound - 1;
 		intmax_t value;
 
+		if (opt->lower_bound) {
+			if (opt->lower_bound < lower_bound)
+				BUG("invalid lower bound for option %s", optname(opt, flags));
+			if (opt->lower_bound > lower_bound)
+				lower_bound = opt->lower_bound;
+		}
+
+		if (opt->upper_bound) {
+			if (opt->upper_bound > (uintmax_t)upper_bound)
+				BUG("invalid upper bound for option %s", optname(opt, flags));
+			if (opt->upper_bound < (uintmax_t)upper_bound)
+				upper_bound = opt->upper_bound;
+		}
+
 		if (unset) {
 			value = 0;
 		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
@@ -225,8 +239,16 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 	case OPTION_UNSIGNED:
 	{
 		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
+		uintmax_t lower_bound = 0;
 		uintmax_t value;
 
+		if (opt->lower_bound < 0)
+			BUG("invalid lower bound for option %s", optname(opt, flags));
+		if (opt->lower_bound > 0)
+			lower_bound = opt->lower_bound;
+		if (opt->upper_bound && opt->upper_bound < upper_bound)
+			upper_bound = opt->upper_bound;
+
 		if (unset) {
 			value = 0;
 		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
@@ -247,16 +269,16 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 					     optname(opt, flags));
 			if (errno == ERANGE)
 				return error(_("value %s for %s not in range [%"PRIuMAX",%"PRIuMAX"]"),
-					     arg, optname(opt, flags), (uintmax_t)0, (uintmax_t)upper_bound);
+					     arg, optname(opt, flags), (uintmax_t)lower_bound, (uintmax_t)upper_bound);
 			if (errno)
 				return error_errno(_("value %s for %s cannot be parsed"),
 						   arg, optname(opt, flags));
 
 		}
 
-		if (value > upper_bound)
+		if (value < lower_bound || value > upper_bound)
 			return error(_("value %s for %s not in range [%"PRIuMAX",%"PRIuMAX"]"),
-				     arg, optname(opt, flags), (uintmax_t)0, (uintmax_t)upper_bound);
+				     arg, optname(opt, flags), (uintmax_t)lower_bound, (uintmax_t)upper_bound);
 
 		switch (opt->precision) {
 		case 1:
@@ -279,8 +301,16 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 	case OPTION_MAGNITUDE:
 	{
 		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
+		uintmax_t lower_bound = 0;
 		unsigned long value;
 
+		if (opt->lower_bound < 0)
+			BUG("invalid lower bound for option %s", optname(opt, flags));
+		if (opt->lower_bound > 0)
+			lower_bound = opt->lower_bound;
+		if (opt->upper_bound && opt->upper_bound < upper_bound)
+			upper_bound = opt->upper_bound;
+
 		if (unset) {
 			value = 0;
 		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
@@ -293,9 +323,9 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 				     optname(opt, flags));
 		}
 
-		if (value > upper_bound)
+		if (value < lower_bound || value > upper_bound)
 			return error(_("value %s for %s not in range [%"PRIuMAX",%"PRIuMAX"]"),
-				     arg, optname(opt, flags), (uintmax_t)0, (uintmax_t)upper_bound);
+				     arg, optname(opt, flags), (uintmax_t)lower_bound, (uintmax_t)upper_bound);
 
 		switch (opt->precision) {
 		case 1:
diff --git a/parse-options.h b/parse-options.h
index 168df642386..c1ebdaf7639 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -97,6 +97,13 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
  *   precision of the integer pointed to by `value` in number of bytes. Should
  *   typically be its `sizeof()`.
  *
+ * `lower_bound`,`upper_bound`::
+ *   lower and upper bound of the integer to further restrict the accepted
+ *   range of integer values. `0` will use the minimum and maximum values for
+ *   the integer type of the specified precision. Specifying a bound that does
+ *   not fit into an integer type of the specified precision will trigger a
+ *   bug.
+ *
  * `argh`::
  *   token to explain the kind of argument this option wants. Does not
  *   begin in capital letter, and does not end with a full stop.
@@ -157,6 +164,8 @@ struct option {
 	const char *long_name;
 	void *value;
 	size_t precision;
+	intmax_t lower_bound;
+	uintmax_t upper_bound;
 	const char *argh;
 	const char *help;
 
@@ -225,6 +234,19 @@ struct option {
 	.help = (h), \
 	.flags = (f), \
 }
+#define OPT_INTEGER_BOUNDED_F(s, l, v, lower, upper, h, f) { \
+	.type = OPTION_INTEGER, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v) + BARF_UNLESS_SIGNED(*(v)), \
+	.precision = sizeof(*v), \
+	.lower_bound = (lower), \
+	.upper_bound = (upper), \
+	.argh = N_("n"), \
+	.help = (h), \
+	.flags = (f), \
+}
+
 #define OPT_UNSIGNED_F(s, l, v, h, f) { \
 	.type = OPTION_UNSIGNED, \
 	.short_name = (s), \
@@ -235,6 +257,18 @@ struct option {
 	.help = (h), \
 	.flags = (f), \
 }
+#define OPT_UNSIGNED_BOUNDED_F(s, l, v, lower, upper, h, f) { \
+	.type = OPTION_UNSIGNED, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v) + BARF_UNLESS_UNSIGNED(*(v)), \
+	.precision = sizeof(*v), \
+	.lower_bound = (lower), \
+	.upper_bound = (upper), \
+	.argh = N_("n"), \
+	.help = (h), \
+	.flags = (f), \
+}
 
 #define OPT_END() { \
 	.type = OPTION_END, \
@@ -287,7 +321,12 @@ struct option {
 #define OPT_CMDMODE(s, l, v, h, i)  OPT_CMDMODE_F(s, l, v, h, i, 0)
 
 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
+#define OPT_INTEGER_BOUNDED(s, l, v, lower, upper, h) \
+	OPT_INTEGER_BOUNDED_F(s, l, v, lower, upper, h, 0)
 #define OPT_UNSIGNED(s, l, v, h)    OPT_UNSIGNED_F(s, l, v, h, 0)
+#define OPT_UNSIGNED_BOUNDED(s, l, v, lower, upper, h) \
+	OPT_UNSIGNED_BOUNDED_F(s, l, v, lower, upper, h, 0)
+
 #define OPT_MAGNITUDE(s, l, v, h) { \
 	.type = OPTION_MAGNITUDE, \
 	.short_name = (s), \
@@ -298,6 +337,19 @@ struct option {
 	.help = (h), \
 	.flags = PARSE_OPT_NONEG, \
 }
+#define OPT_MAGNITUDE_BOUNDED(s, l, v, lower, upper, h) { \
+	.type = OPTION_MAGNITUDE, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v) + BARF_UNLESS_UNSIGNED(*(v)), \
+	.precision = sizeof(*v), \
+	.lower_bound = (lower), \
+	.upper_bound = (upper), \
+	.argh = N_("n"), \
+	.help = (h), \
+	.flags = PARSE_OPT_NONEG, \
+}
+
 #define OPT_STRING(s, l, v, a, h)   OPT_STRING_F(s, l, v, a, h, 0)
 #define OPT_STRING_LIST(s, l, v, a, h) { \
 	.type = OPTION_CALLBACK, \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 0d559288d9c..0fcceec56a7 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -120,7 +120,9 @@ int cmd__parse_options(int argc, const char **argv)
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
 	struct string_list list = STRING_LIST_INIT_NODUP;
+	uint32_t mbounded = 0, ubounded = 0;
 	uint16_t m16 = 0, u16 = 0;
+	int32_t ibounded = 0;
 	int16_t i16 = 0;
 
 	struct option options[] = {
@@ -142,10 +144,13 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
+		OPT_INTEGER_BOUNDED(0, "ibounded", &ibounded, -10, 10, "get a bounded integer between [-10,10]"),
 		OPT_UNSIGNED(0, "u16", &u16, "get a 16 bit unsigned integer"),
+		OPT_UNSIGNED_BOUNDED(0, "ubounded", &ubounded, 10, 100, "get a bounded unsigned integer between [10,100]"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
 		OPT_MAGNITUDE(0, "m16", &m16, "get a 16 bit magnitude"),
+		OPT_MAGNITUDE_BOUNDED(0, "mbounded", &mbounded, 10, 100, "get a bounded magnitude between [10,100]"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
 		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 66875ce0586..d76165c2053 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -23,10 +23,13 @@ usage: test-tool parse-options <options>
     -i, --[no-]integer <n>
                           get a integer
     --[no-]i16 <n>        get a 16 bit integer
+    --[no-]ibounded <n>   get a bounded integer between [-10,10]
     --[no-]u16 <n>        get a 16 bit unsigned integer
+    --[no-]ubounded <n>   get a bounded unsigned integer between [10,100]
     -j <n>                get a integer, too
     -m, --magnitude <n>   get a magnitude
     --m16 <n>             get a 16 bit magnitude
+    --mbounded <n>        get a bounded magnitude between [10,100]
     --[no-]set23          set integer to 23
     --mode1               set integer to 1 (cmdmode option)
     --mode2               set integer to 2 (cmdmode option)
@@ -848,4 +851,34 @@ test_expect_success 'u16 does not accept negative value' '
 	test_must_be_empty out
 '
 
+test_expect_success 'ibounded does not accept outside range' '
+	test_must_fail test-tool parse-options --ibounded -11 >out 2>err &&
+	test_grep "value -11 for option .ibounded. not in range \[-10,10\]" err &&
+	test_must_fail test-tool parse-options --ibounded 11 >out 2>err &&
+	test_grep "value 11 for option .ibounded. not in range \[-10,10\]" err &&
+	test-tool parse-options --ibounded -10 &&
+	test-tool parse-options --ibounded 0 &&
+	test-tool parse-options --ibounded 10
+'
+
+test_expect_success 'ubounded does not accept outside range' '
+	test_must_fail test-tool parse-options --ubounded 9 >out 2>err &&
+	test_grep "value 9 for option .ubounded. not in range \[10,100\]" err &&
+	test_must_fail test-tool parse-options --ubounded 101 >out 2>err &&
+	test_grep "value 101 for option .ubounded. not in range \[10,100\]" err &&
+	test-tool parse-options --ubounded 10 &&
+	test-tool parse-options --ubounded 50 &&
+	test-tool parse-options --ubounded 100
+'
+
+test_expect_success 'mbounded does not accept outside range' '
+	test_must_fail test-tool parse-options --mbounded 9 >out 2>err &&
+	test_grep "value 9 for option .mbounded. not in range \[10,100\]" err &&
+	test_must_fail test-tool parse-options --mbounded 101 >out 2>err &&
+	test_grep "value 101 for option .mbounded. not in range \[10,100\]" err &&
+	test-tool parse-options --mbounded 10 &&
+	test-tool parse-options --mbounded 50 &&
+	test-tool parse-options --mbounded 100
+'
+
 test_done

-- 
2.49.0.805.g082f7c87e0.dirty

