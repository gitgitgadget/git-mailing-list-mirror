Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187497;
	b=q7C9f6LyG+Ehw+m3nZpGxMU/dQnCnktPt34HakzgKvhUidgX4XEh8BC1QMwfykE9l0FT
	 C0zqskEvxl/x6SKpIRY/K97urD8COb8jyhIXmRlN8Kth1EypkStIImEXAwNi9QrLohxRl
	 46vQk9N89qiF2ric2cTZPZNmI/W7mjvduCDERXQpOmyrAZ1CmyO6ow9u1Ux536ThNoboz
	 aorgaxnVGgCp1aLF3ky+2z7aA0w3+GHaS8bbB8KfOIwu0JFjv3GTvRxrKV9r4gNAgmYys
	 GcDq9sx2SPkaUiZsBe07S3uj08yWGX/Tn07npIpZBw/aeBhmBGlOel7vMXabLsUMi3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187497;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=d3wUblH0kROiV36ahBM5GtwJ1+5BIivDtU6iuQnCko8=;
	b=gRewtpKaSDO+kJuQYOxSSxP69FhMUHYSTnOknvNUJjo9mS9fl905WKQsOOHzaIqRh2w0
	 Y1TiziCeI3kuqBdHD6zGSFC9L9uU0L6N6MoK1gwlcLLj8Lm+GkgJHH3y+TwyQRx6xgfLr
	 a+i2E5Y+kZO885GMBXlejOUtv380kyrsu928grzyWGu1uL3IVAryzBTTW8iWucyv4MxmL
	 KG1Nvh/sxgn75Tr1W83pbhW1Quo44hj0jUXVBb0Lfbc+SiLc5I4hRIHcgHnfEH+9iCN9C
	 EvZsIFfF0fIdo5O9vW59tXNGteaSU1m9azYyB1ucNxjexpe6HoErahoUG9QcoBlmSWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=NICYq35U;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615F606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4615F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=NICYq35U
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKFBTTd2082197
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 16:11:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795187491; bh=d3wUblH0kROiV36ahBM5GtwJ1+5BIivDtU6iuQnCko8=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc;
	b=NICYq35UB5yOF4zwU2dkDs7xmpFYCMV2HjTPhxbnbmJHnezVh+F8wVT69i9ceopGj
	 AgKAq3BGvVCvLNe8XR2equzbsf3bVF7H81kGu6sepOINsRunfZlK45dLBVd534W8JT
	 cFYKE/dcRQB/WW0hHjP0g128O9KHOSP4qXCba044=
From: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v4 0/5] utf8: bounds-related fixes and a doc fix
Date: Fri, 20 Nov 2026 16:11:23 +0100
Message-Id: <20261120-master-v4-0-5ff523db7285@gouders.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNQQ6CMBQE0KuQrq3p/5WCrryHcVHaD9REMC0QD
 eHuUkwIhuUk82ZGFsg7CuySjMzT4IJrmzmcDgkztW4q4s7OmaFABQCKP3XoyHN1LiADBZijZHP
 55al072Xodv/l0BcPMl3UsVG70LX+szwNEHu70QG44NagToUhobW4Vm1vyYdjQx2LswNuYb5Cn
 KEsUWsykFoJeyg3EMUKZXzEnHKTpRaV/YfTNH0BDSx+WyIBAAA=
X-Change-ID: 20261116-master-69b171612823
In-Reply-To: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>,
        Andy Koppe <andy.koppe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6424; i=dirk@gouders.net;
 h=from:subject:message-id; bh=f8+tcoYYFviZ/52xNUv3WcGasFHlUrzo5WoIZn+9mUA=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZkhW3vngoMjfSVrx3pa/pTpf0D12dbhlz5wobrNM21
 Zjzsi69k3ECCwMjF0OVmCLL0klFdmkqK16UfVPNhBnEygQyRVqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHSMHiBw/g0Z6QbpDen5pSmpRsV5eaomjqaWRuZGxq5mZkYmjhauFuZmbmZGpmaWjiam5q6O
 LmbG5samJo6UzAxenAMy684Xs/xT/TkmPc3j/+0en8rtDyhIhlziWqXEoPrviVmb5LvqNwF/3jZ
 9PNUad9jjPqqk6OeaVZUC0X+9SV3293mnOmx2XKJ9mbM27mRCh+d+9SiveMDuwaVXQSi5OV4nI6
 n05uZ94/ySEb/ty3nq1r8+3WTtS3P3EZarC70hrG9Tw+e18GS8yKYrLKzeW2e5dyPytfpuMHzY+
 77B1C/nV/EDi2I/1iWxyPW6HrNPyeoNU/p8s8ZJXubnl1J2iCR3ljFrSiuLbs61FErdf2c1WXvx
 Rxfbzjd+/ORKzX3Uyrncs+jtxgaF/QOoEOZ0Vah/MSo+01Snc4VBKesZ9Msmx6pGWB2+KuN66Ra
 JveXZ9rQcA
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
Dirk Gouders (4):
      utf8: fix comment for utf8_strnwidth()
      utf8: respect string boundaries after skipping ANSI escape sequences
      utf8: respect boundaries in utf8_strnwidth()
      utf8: introduce display_mode_esc_sequence_len_all()

Junio C Hamano (1):
      utf8: introduce bounds for display_mode_esc_sequence_len()

 Makefile                    |  1 +
 pretty.c                    |  2 +-
 t/meson.build               |  1 +
 t/unit-tests/u-utf8-ansi.c  | 85 +++++++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/u-utf8-width.c | 20 +++++++++++
 utf8.c                      | 78 +++++++++++++++++++++++++++++------------
 utf8.h                      |  3 +-
 7 files changed, 165 insertions(+), 25 deletions(-)

Range-diff versus v3:

1:  122df176a3 = 1:  ce2736da52 utf8: introduce bounds for display_mode_esc_sequence_len()
2:  6cb2da91ae = 2:  ec70d5e553 utf8: fix comment for utf8_strnwidth()
3:  d62360d690 = 3:  0e09e16822 utf8: respect string boundaries after skipping ANSI escape sequences
-:  ---------- > 4:  f49010e6c5 utf8: respect boundaries in utf8_strnwidth()
4:  caca770f8b ! 5:  eb428dfc47 utf8: respect boundaries in utf8_strnwidth()
    @@ Metadata
     Author: Dirk Gouders <dirk@gouders.net>
     
      ## Commit message ##
    -    utf8: respect boundaries in utf8_strnwidth()
    +    utf8: introduce display_mode_esc_sequence_len_all()
     
    -    utf8_strnwidth() can be called with boundaries that effectively cause
    -    incomplete multibyte sequences and we should return "len" in such
    -    cases.
    +    Most users of display_mode_esc_sequence_len() need to know the length
    +    of *all* leading ANSI display mode escape sequences and use
    +    display_mode_esc_sequence_len() in a loop.
     
    -    But, utf8_width is used without its optional boundary argument and
    -    will thus work beyond the given boundary.
    +    Introduce display_mode_esc_sequence_len_all() for convenience and
    +    to reduce the risk of bugs.
     
    -    Fix this by using the boundary argument for utf8_width.
    -    Add some tests that cover such situations.
    +    Add tests for this function as well.
     
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
    @@ t/unit-tests/u-utf8-ansi.c
       * Test display_mode_esc_sequence_len() for NUL terminated strings.
       */
     
    - ## t/unit-tests/u-utf8-width.c ##
    -@@
    - #include "utf8.h"
    - #include "strbuf.h"
    - 
    -+/*
    -+ * Test utf8_strnwidth for cjk characters invalidated by len argument.
    -+ */
    -+void test_utf8_width__strnwidth_cjk_chopped(void)
    -+{
    -+	cl_assert_equal_i(1, utf8_strnwidth("三bytes long, 二columns wide", 1, 1));
    -+	cl_assert_equal_i(2, utf8_strnwidth("三bytes long, 二columns wide", 3, 1));
    -+}
    -+
    - /*
    -  * Test utf8_strnwidth for strings with SGR sequences and corner case length
    -  * arguments.
    -
      ## utf8.c ##
     @@ utf8.c: size_t display_mode_esc_sequence_len(const char *start, const char *end)
      	return p - start;
    @@ utf8.c: size_t display_mode_esc_sequence_len(const char *start, const char *end)
      static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
      {
     @@ utf8.c: int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
    - 
    - 	while (string && string < end) {
    - 		int glyph_width;
    --		size_t skip;
    -+		size_t remainder;
    + 		size_t remainder;
      
      		if (skip_ansi) {
     -			while ((skip = display_mode_esc_sequence_len(string, end)))
    @@ utf8.c: int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
      
      			if (string >= end)
      				break;
    - 		}
    - 
    --		glyph_width = utf8_width(&string, NULL);
    -+		remainder = end - string;
    -+
    -+		glyph_width = utf8_width(&string, &remainder);
    - 		if (glyph_width > 0)
    - 			width += glyph_width;
    - 	}
     @@ utf8.c: void strbuf_add_wrapped_text(struct strbuf *buf,
      
      	for (;;) {

---
base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
change-id: 20261116-master-69b171612823

