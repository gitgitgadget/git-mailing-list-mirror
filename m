Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630814;
	b=U0hkrdob8PPJXgKrQbv4pwfy+zkC+95hf06KoEHcxiOKP19+uDFq6zq81OVZspVDk3hi
	 iPoguYW9DHGXmXCnQp4TZE5mv5VNZbtn7zadC4nrEToao4mKS3egPnABXDzNqea38HOZu
	 JdJk2Qsp/387RHkb2KB1aO/4Hpk95OF+v5edn2FOtn8K/OgqsSFmTLbtVmfUXN7NT3099
	 BQQ3WJRPUZfk1kJudqyslV/nyHun4j0ijNKF0OUlvKlGTPI/IU+u4PI4jhY3IYX5pgK7Y
	 Ke7OaBNyeyIX9QUOOF0rZWYAjU1QMzfXWZ/Vkw9Kx3W5u50FWohY5xsinJLRpdZlSJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630814;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=rVDEkXsLoTg4wZ5kHjVkPHrSS+vBY9cIxzLVnGCXG2g=;
	b=A0EC6y5iNHrADvhsBXkK1zS0c/Z//CVWRHPa+SKYCvNrRNDLfc74JLbva8CslhzVCv7U
	 pTIEjm5tsH1zM6gBhUmba8gS+LtqHFHQ63sVwKOfV/UahhrgZdn4QgYa+IwvUzu4n0x3T
	 D54v/KGpK9Xb8ZYzN5FEnR8k4s5ybqUgLgQnSxKdBfsF/odb3LP0M4I7e2D4ITKIQLPC2
	 KJrBzCMXjo65EOC7xqkdNKyWZ49ASHby8skr89Y4gcG18RHT7DMeVgqYPrgFPQivqSed3
	 DlVCfEiKMtuN3vr0mU++9BYjcZQnx/q6wUS+c886WIYtn6qcLXsLAK39CuKrvGWfdlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=fKd3geH5;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFAB606A32A
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DFAB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=fKd3geH5
Received: from lena.gouders.net (ip-109-41-50-35.web.vodafone.de [109.41.50.35])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6APIJxx22481769
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 25 Nov 2026 19:20:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795630806; bh=rVDEkXsLoTg4wZ5kHjVkPHrSS+vBY9cIxzLVnGCXG2g=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc;
	b=fKd3geH5OIfd4UtGUX0AKHfsmMmE7/L880U0059fXKgASulcFmE4X4RyUfCmuUmg6
	 a21IbAzZvofbnqs6VhV9QgqSqmsCuBfimZGJ5CrlrUVsYgGcEWoXi84kHaUf2De+yw
	 ZI3Mm0b5rwUQh2YFurHiTW2qIuxp2Ned7Mt2XobA=
From: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v6 0/4] utf8: bounds-related fixes and a doc fix
Date: Wed, 25 Nov 2026 19:19:40 +0100
Message-Id: <20261125-master-v6-0-cb60af83d189@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OTWrDMBAF4KsEraOiGVmyklXvUbLQzzhRoXaQH
 JMQfPdIKRhTd/ngfW/myTKlSJkdd0+WaIo5Dn0Jer9j/mL7M/EYSmYoUAOA5j82j5S4PjhoQQM
 alKyUr4m6eH8PfZ1+c765b/Jj1bVxiXkc0uN9aYLa24xOwAUPHq0SnoS14vM83AKl/NHTyOrsh
 GtoFogFyg6tJQ8qSNhCuYIoFijrRTRkfKsC6rCFzf+wKVB1nUIZXItGbaFaQ1ygqq+CdAGck77
 5A+d5fgHLHfldlAEAAA==
X-Change-ID: 20261116-master-69b171612823
In-Reply-To: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21153; i=dirk@gouders.net;
 h=from:subject:message-id; bh=rhVN8TbzzHHP8IoXZ1xpwsRbXSV/GLVWkh3720hGEFo=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLLZ1S78VS6578Fdvrps/gTL/fFBl1bWnDvG2pk8Oc1J8
 GPpxsU+nYwTWBgYuRiqxBRZlk4qsktTWfGi7JtqJswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6Bg5QOT4GTTSC9Id0vNLU1KLivXyUkscTS2NzI2MXc3MjEwcLVwtzM3czIxMzSwdTUzNXR1
 dzIzNjU1NHC2dGbg4BWDWdXuz/3dO1uedfmQ3uyPD8sOFD1qupZaEzrvw+QtH6Aoer6j09/WVTK
 HHGz7HnF//Y9WGr5dD+MXD2P/GXe4UvT5tH8OxfGa/+3UrLE+JBbZ+OhiUFH3Z8Moeq5VbzXUyB
 R5Nsz0twrnQed2SJsG7ybFeCb713xPWTP2z1zDtaNYWeabljoyb/kel/rc4K/w29QB7u+LhgoWx
 CxR2bmOPO7hue1+ii1lGrkQAw9Sz/1+cNW5zWtnG7Nam47pOdu+djRe0nX62KmziMjDyfXBNmXN
 bSRPPkj8rZY93OH1pP6yQqPrYdl2EN/eaxLaaHc++WaQwu83N6vL+4FwzbY+QTRc362xn9dVBFz
 fJpTXxHN9hDwA=
X-Developer-Key: i=dirk@gouders.net; a=openpgp;
 fpr=943B4FA3CAB8EBC55754E5EA0DA2395F431875F6

A patch here on the list made me look at
display_mode_esc_sequence_len() in utf8.c and I found two details in
the file that are perhaps worth a fix:

1) utf8_strnwidth() disregards the given len argument when fed
   with proper string and len.

2) The comment for utf8_strnwidth() is incorrect: it states the
   function returns strlen() for cases when it actually returns its
   len argument.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
Changes in v6:
- 1/4: According to review comments:
       • Re-order credits in the commit message.
       • Don't include strbuf.h in the new unit-tests.
       • Use test functions matching the return-type of the tested functions.
       • Fix a comment.
       • Adhere to the "textual order reflects actual order" principle.
       • Don't use the _counted variant in strbuf_add_wrapped_text() where
         a NUL terminator is the string's boundary.
         Reword the commit message, accordingly.
- 2/4: Change "terminated by len" to "bounded by len".
- 3/4: • In the commit message, provide an example for the problem
         that is taken care of.
       • Leave a comment in the test for when the interfaces of the
         tested functions will be changed to return size_t.
- 4/4: Rework commit message:
       • Tighten the subject a bit.
       • Consistently use parentheses with function names.
       • Add some words to the commit message as to why 3/4 is still
         valid although utf8_width() is now called with a border argument.
- Link to v5: https://patch.msgid.link/20261122-master-v5-0-313bd1bb3c45@gouders.net

Changes in v5:
This version moves back much closer to Junio's suggestion:

Keep Junio's functions but take care for the risk of O(n²)
degradation.  For NUL-terminated strings, do not calculate exact
lengths with strlen(), but:

1. In the _counted variant, ensure we never calculate `s + len` but
   instead, we work with an array index to ensure it stays <= len and
   we never touch s[len] or beyond.
2. Because of 1. we can pass SIZE_MAX in the wrapper for
   NUL-terminated strings.

Further, I dropped 5/5 of v4.  This series should stick with actually
fixing issues and not introduce noise.

- 1/4: Change this back to Junio's suggestion and modify it to work
       with an array index.

       I added more tests so that the wrapper function is tested, as
       well.

       Arrays initialized with string constants are now used so that
       sizeof() can be used when testing the ends of such strings.
       Andy also reviewed that doing sizeof() on pointers is a bad idea.
- 2/4: "NUL-terminated" instead of "NUL terminated"
- 3/4: Back to display_mode_esc_sequence_len_counted()
- 4/4: Restore the variable "skip" according to Andy's review.
- Link to v4: https://patch.msgid.link/20261120-master-v4-0-5ff523db7285@gouders.net

Changes in v4:
- Resend un-squashed v3

Changes in v3:
- 1/5: * fix sorting order in t/meson.build
       * fix risk of O(n²) degradation:
         drop the wrapper function and introduce an end pointer to
         display_mode_esc_sequence_len()
         (I was so used to len arguments for string handling functions
          that I only now realized the beauty of optionally optional
          end pointers for string handling. I know: beauty is in the
          eye of the beholder ;-))
       * try to fix an overly long line
- 2/5: also fix a further error concerning "null-terminated"
- 3/5: * drop excess SP in if-statement
- 5/5: this actually is a POC, not fixing a bug:
       users of display_mode_esc_sequence_len() often need the length
       of all leading SGR sequences and here is a function that does that.
       I mentioned such a function in the discussion for v1.
- Link to v2: https://patch.msgid.link/20261118-master-v2-0-3f2aaec15d31@gouders.net

Changes in v2:
- Add a patch by Junio that introduces a bounded function display_mode_esc_sequence_len_counted()
  I added some tests for this new function.
- 2/2 became 2/4
- 3/4 is the modified 1/2 and uses the new
  display_mode_esc_sequence_len_counted() so that the while loop stays
  within the given bounds.
  The commit message was adjusted.
  One of the tests was wrong: "\033" has width 0, so the sum must be 3 instead of 4.
- 4/4 is an addition to fix a similar problem with utf8_width().
  That function is used without its optional bounds argument and
  can violate boundaries as well.  Test for such cases are added.
- Link to v1: https://patch.msgid.link/20261116-master-v1-0-dc2a50ce0aa0@gouders.net

---
Dirk Gouders (3):
      utf8: fix comment for utf8_strnwidth()
      utf8: respect string boundaries after skipping ANSI escape sequences
      utf8: use bound for utf8_width() calls in utf8_strnwidth()

Junio C Hamano (1):
      utf8: add display_mode_esc_sequence_len_counted()

 Makefile                    |  1 +
 t/meson.build               |  1 +
 t/unit-tests/u-utf8-ansi.c  | 85 +++++++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/u-utf8-width.c | 26 ++++++++++++++
 utf8.c                      | 52 +++++++++++++++++++--------
 utf8.h                      |  1 +
 6 files changed, 151 insertions(+), 15 deletions(-)

Range-diff versus v5:

1:  11acf54e68 ! 1:  174a444f09 utf8: add display_mode_esc_sequence_len_counted()
    @@ Commit message
         escape sequence (e.g. "ESC [ 1 ; 31 m") at the start of a string,
         relying on NUL termination to stop.  Some callers, however, work on
         a counted buffer: utf8_strnwidth() takes <string, len> and must not
    -    scan past it, while strbuf_utf8_replace() and
    -    strbuf_add_wrapped_text() know (or can cheaply learn) the end.
    +    scan past it, while strbuf_utf8_replace() knows the end.
     
         Add display_mode_esc_sequence_len_counted() taking <ptr, len>,
         which never reads at or beyond ptr[len], and make
    @@ Commit message
         strings.
     
         Use the counted variant in utf8_strnwidth() for correctness, and in
    -    strbuf_utf8_replace() and strbuf_add_wrapped_text() (computing the
    -    end once upfront in the latter) to avoid measuring the remaining
    -    text in each iteration.
    +    strbuf_utf8_replace() where the length can easily be calculated.
     
    -    [Dirk Gouders: allow SIZE_MAX to be passed for NUL-terminated strings
    -     to avoid O(n²) degradation as suggested by Andy Koppe.  Also add
    -     tests for these functions.]
    -
    -    Helped-by: Andy Koppe <andy.koppe@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Andy Koppe <andy.koppe@gmail.com>
    +    [ak: warned against O(n²) degradation and suggested to use SIZE_MAX]
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
      ## Makefile ##
    @@ t/unit-tests/u-utf8-ansi.c (new)
     @@
     +#include "unit-test.h"
     +#include "utf8.h"
    -+#include "strbuf.h"
     +
     +/*
     + * Test display_mode_esc_sequence_len_counted() for NUL-terminated strings.
     + */
     +void test_utf8_ansi__sgr_len_counted(void)
     +{
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("", SIZE_MAX));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("", SIZE_MAX));
     +
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033", SIZE_MAX));
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[", SIZE_MAX));
    -+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[m", SIZE_MAX));
    -+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[ma", SIZE_MAX));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033", SIZE_MAX));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033[", SIZE_MAX));
    ++	cl_assert_equal_u(3, display_mode_esc_sequence_len_counted("\033[m", SIZE_MAX));
    ++	cl_assert_equal_u(3, display_mode_esc_sequence_len_counted("\033[ma", SIZE_MAX));
     +
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[3", SIZE_MAX));
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[31", SIZE_MAX));
    -+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted("\033[31m", SIZE_MAX));
    -+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted("\033[31ma", SIZE_MAX));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033[3", SIZE_MAX));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033[31", SIZE_MAX));
    ++	cl_assert_equal_u(5, display_mode_esc_sequence_len_counted("\033[31m", SIZE_MAX));
    ++	cl_assert_equal_u(5, display_mode_esc_sequence_len_counted("\033[31ma", SIZE_MAX));
     +
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[31;", SIZE_MAX));
    -+	cl_assert_equal_i(6, display_mode_esc_sequence_len_counted("\033[31;m", SIZE_MAX));
    -+	cl_assert_equal_i(6, display_mode_esc_sequence_len_counted("\033[31;ma", SIZE_MAX));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted("\033[31;", SIZE_MAX));
    ++	cl_assert_equal_u(6, display_mode_esc_sequence_len_counted("\033[31;m", SIZE_MAX));
    ++	cl_assert_equal_u(6, display_mode_esc_sequence_len_counted("\033[31;ma", SIZE_MAX));
     +
    -+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[31;0m", SIZE_MAX));
    -+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[31;0ma", SIZE_MAX));
    ++	cl_assert_equal_u(7, display_mode_esc_sequence_len_counted("\033[31;0m", SIZE_MAX));
    ++	cl_assert_equal_u(7, display_mode_esc_sequence_len_counted("\033[31;0ma", SIZE_MAX));
     +}
     +
     +/*
    @@ t/unit-tests/u-utf8-ansi.c (new)
     + */
     +void test_utf8_ansi__sgr_len(void)
     +{
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len(""));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len(""));
     +
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033"));
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033["));
    -+	cl_assert_equal_i(3, display_mode_esc_sequence_len("\033[m"));
    -+	cl_assert_equal_i(3, display_mode_esc_sequence_len("\033[ma"));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033"));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033["));
    ++	cl_assert_equal_u(3, display_mode_esc_sequence_len("\033[m"));
    ++	cl_assert_equal_u(3, display_mode_esc_sequence_len("\033[ma"));
     +
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[3"));
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[31"));
    -+	cl_assert_equal_i(5, display_mode_esc_sequence_len("\033[31m"));
    -+	cl_assert_equal_i(5, display_mode_esc_sequence_len("\033[31ma"));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033[3"));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033[31"));
    ++	cl_assert_equal_u(5, display_mode_esc_sequence_len("\033[31m"));
    ++	cl_assert_equal_u(5, display_mode_esc_sequence_len("\033[31ma"));
     +
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len("\033[31;"));
    -+	cl_assert_equal_i(6, display_mode_esc_sequence_len("\033[31;m"));
    -+	cl_assert_equal_i(6, display_mode_esc_sequence_len("\033[31;ma"));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len("\033[31;"));
    ++	cl_assert_equal_u(6, display_mode_esc_sequence_len("\033[31;m"));
    ++	cl_assert_equal_u(6, display_mode_esc_sequence_len("\033[31;ma"));
     +
    -+	cl_assert_equal_i(7, display_mode_esc_sequence_len("\033[31;0m"));
    -+	cl_assert_equal_i(7, display_mode_esc_sequence_len("\033[31;0ma"));
    ++	cl_assert_equal_u(7, display_mode_esc_sequence_len("\033[31;0m"));
    ++	cl_assert_equal_u(7, display_mode_esc_sequence_len("\033[31;0ma"));
     +}
     +
     +/*
    -+ * Test display_mode_esc_sequence_len_counted() with end pointers.
    ++ * Test display_mode_esc_sequence_len_counted() with length limits.
     + */
     +void test_utf8_ansi__sgr_len_limited(void)
     +{
    @@ t/unit-tests/u-utf8-ansi.c (new)
     +	char sgr_3[] = "\033[31;ma";
     +	char sgr_4[] = "\033[31;0ma";
     +
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_1, 0));
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_1, 1));
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_1, 2));
    -+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted(sgr_1, 3));
    -+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted(sgr_1, 4));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_1, 0));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_1, 1));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_1, 2));
    ++	cl_assert_equal_u(3, display_mode_esc_sequence_len_counted(sgr_1, 3));
    ++	cl_assert_equal_u(3, display_mode_esc_sequence_len_counted(sgr_1, 4));
     +
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_2, 3));
    -+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted(sgr_2, 4));
    -+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted(sgr_2, 5));
    -+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted(sgr_2, 6));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_2, 3));
    ++	cl_assert_equal_u(0, display_mode_esc_sequence_len_counted(sgr_2, 4));
    ++	cl_assert_equal_u(5, display_mode_esc_sequence_len_counted(sgr_2, 5));
    ++	cl_assert_equal_u(5, display_mode_esc_sequence_len_counted(sgr_2, 6));
     +
    -+	cl_assert_equal_i(6, display_mode_esc_sequence_len_counted(sgr_3,
    ++	cl_assert_equal_u(6, display_mode_esc_sequence_len_counted(sgr_3,
     +								   sizeof(sgr_3) - 2));
    -+	cl_assert_equal_i(6, display_mode_esc_sequence_len_counted(sgr_3,
    ++	cl_assert_equal_u(6, display_mode_esc_sequence_len_counted(sgr_3,
     +								   sizeof(sgr_3) - 1));
     +
    -+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted(sgr_4,
    ++	cl_assert_equal_u(7, display_mode_esc_sequence_len_counted(sgr_4,
     +								   sizeof(sgr_4) - 2));
    -+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted(sgr_4,
    ++	cl_assert_equal_u(7, display_mode_esc_sequence_len_counted(sgr_4,
     +								   sizeof(sgr_4) - 1));
     +}
     
    @@ utf8.c: struct interval {
     -	if (*p++ != '\033')
     +	size_t i = 0;
     +
    -+	if (i >= len || s[i++] != '\033')
    ++	if (len <= i || s[i++] != '\033')
      		return 0;
     -	if (*p++ != '[')
    -+	if (i >= len || s[i++] != '[')
    ++	if (len <= i || s[i++] != '[')
      		return 0;
     -	while (isdigit(*p) || *p == ';')
     -		p++;
     -	if (*p++ != 'm')
     +	while (i < len && (isdigit(s[i]) || s[i] == ';'))
     +		i++;
    -+	if (i >= len || s[i++] != 'm')
    ++	if (len <= i || s[i++] != 'm')
      		return 0;
     -	return p - s;
     +	return i;
    @@ utf8.c: int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
      			string += skip;
      
      		glyph_width = utf8_width(&string, NULL);
    -@@ utf8.c: void strbuf_add_wrapped_text(struct strbuf *buf,
    - {
    - 	int indent, w, assume_utf8 = 1;
    - 	const char *bol, *space, *start = text;
    -+	const char *end = text + strlen(text);
    - 	size_t orig_len = buf->len;
    - 
    - 	if (width <= 0) {
    -@@ utf8.c: void strbuf_add_wrapped_text(struct strbuf *buf,
    - 		char c;
    - 		size_t skip;
    - 
    --		while ((skip = display_mode_esc_sequence_len(text)))
    -+		while ((skip = display_mode_esc_sequence_len_counted(text,
    -+								end - text)))
    - 			text += skip;
    - 
    - 		c = *text;
     @@ utf8.c: void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
      		int glyph_width;
      		size_t n;
2:  2fc9ddc9b9 ! 2:  e50ca91f8a utf8: fix comment for utf8_strnwidth()
    @@ utf8.c: int utf8_width(const char **start, size_t *remainder_p)
      /*
     - * Returns the total number of columns required by a null-terminated
     - * string, assuming that the string is utf8.  Returns strlen() instead
    -+ * Returns the total number of columns required by a string terminated by len,
    ++ * Returns the total number of columns required by a string bounded by len,
     + * assuming that the string is utf8.  Returns len instead
       * if the string does not look like a valid utf8 string.
       */
3:  c268c98a6a ! 3:  8fabe1d98a utf8: respect string boundaries after skipping ANSI escape sequences
    @@ Commit message
         utf8_strnwidth() can skip ANSI escape sequences and it is possible
         that such sequences end the string within the given boundary.
     
    +    For example, if the escape sequence "\033[31m" of length 5 bytes is
    +                 part of a string
    +
    +                      "\033[31mdon't touch me"
    +                       ^       ^
    +                       |       |
    +                       0       5
    +
    +    and this is passed to utf8_strnwidth(), len arguments that limit the
    +    length of the string near the end of the escape sequence are
    +    interesting:
    +
    +    len = 4: in this case, display_mode_esc_sequence_len_counted() will
    +             return 0, because it inspects an incomplete sequence
    +             "\033[31" (the 'm' is missing).
    +             utf8_strnwidth() will then accumulate the widths of all four
    +             characters in "\033[31" which will be 3, because "\033" has
    +             width 0.  Correct.
    +
    +    len = 5: in this case, display_mode_esc_sequence_len_counted() returns
    +             5, because it detects a valid sequence and the string pointer
    +             is advanced to "dont't touch me".
    +
    +             Here, we should be done with the loop but this string is then
    +             passed to utf8_width() before the loop can be exited.
    +             utf8_width() sees a character 'd' (outside of the given
    +             bound) of width 1.
    +
    +             1 is returned for a string that should result in width 0.
    +
    +    len = 6: in this case, display_mode_esc_sequence_len_counted() also
    +             returns the length of the escape sequence but this time, one
    +             byte ('d') of the string is left for width calculation and 1
    +             is returned which also is correct.
    +
    +    And, the situation can be very different from the example; we never
    +    know what exactly is at or beyond string[len].
    +
         Check for such situations before proceeding and calling utf8_width().
     
         Add tests that test such corner cases.
    @@ t/unit-tests/u-utf8-width.c
      #include "utf8.h"
      #include "strbuf.h"
      
    ++/*
    ++ * TODO: When the interfaces of utf8_strwidth and utf8_strnwidth are fixed to
    ++ * return `size_t`, cl_assert_equal_u must be used instead of
    ++ * cl_assert_equal_i, for the tests.
    ++ */
    ++
     +/*
     + * Test utf8_strnwidth for strings with SGR sequences and corner case length
     + * arguments.
4:  107a0c03ac ! 4:  b6eb13dc60 utf8: respect boundaries in utf8_strnwidth()
    @@ Metadata
     Author: Dirk Gouders <dirk@gouders.net>
     
      ## Commit message ##
    -    utf8: respect boundaries in utf8_strnwidth()
    +    utf8: use bound for utf8_width() calls in utf8_strnwidth()
     
         utf8_strnwidth() can be called with boundaries that effectively cause
         incomplete multibyte sequences and we should return "len" in such
         cases.
     
    -    But, utf8_width is used without its optional boundary argument and
    +    But, utf8_width() is called without its optional boundary argument and
         will thus work beyond the given boundary.
     
    -    Fix this by using the boundary argument for utf8_width.
    -    Add some tests that cover such situations.
    +    Fix this by using the boundary argument for utf8_width()
    +    and add some tests that cover such situations.
    +
    +    One might ask whether we can now drop the bounds-check in the
    +    skip_ansi case.  No, that test is still needed, because utf8_width()
    +    considers strings passed with *remainder = 0 as invalid UTF-8 and we
    +    would then return len (and not width) for strings that end with escape
    +    sequences.
     
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
      ## t/unit-tests/u-utf8-width.c ##
     @@
    - #include "utf8.h"
    - #include "strbuf.h"
    +  * cl_assert_equal_i, for the tests.
    +  */
      
     +/*
     + * Test utf8_strnwidth for cjk characters invalidated by len argument.

---
base-commit: f7de81456940dd6f3274e461149bba12965de609
change-id: 20261116-master-69b171612823

