Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795359095;
	b=NYlDAucUAyrmFVDFyo3LX3lngBl/B17/RnMbcnAbNQ1VR9JEZ/pazlrcGVNx+wMm4WC6
	 YdiQ4GVKzQe7AHMtW/6ZiuZrwhpTcCbNoKqtBcFgmS9wGh6N/SzJGiLVJBVtS/iUDc5Bq
	 NQyxv1W/BSjF/6fUr9VHZQh2mNCYOXU5/SG3EV4Zac7rN3U/S/Zdj6PBmAr/nUuwZNp2f
	 mYatiDzslQpTWPIfC3/tk5mqMctIfXZAECPWdOYN9pFU+ZZB1XJWASffxrhrUVrgkAQGy
	 30iuSPDpRH6uIltMzPQjBcJtG2U9nUvkDVGjNqLFaPX4BQwycvT9KwnHh+Gg31CdCAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795359095;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=3zu5cF1MvmxFDdOO8c/b15CLsyCjgFiHf4BT+dNBfxE=;
	b=vXjgA1u2oUsY2EDkEr1ij+gBjkX5mPIgpcUSlooTdhWGyBZjBQlzrB26TEOtAZq33CF+
	 rdE58yvkpQSehwizWJkhre48aiTiPNWbe0jXJO0mlLd5v4M8Z2+wyS3CZR3FbPIfM2Zf5
	 6PYG8SG2D72hFYTTauhUxL62CThpbcMLGcRU9lJAqwmZOy4/m5bYeGf7nVVl0KZinfO5D
	 90/wBg9jWMqMScStIs8pA3QMHR8poVUptrYTU2GPocEUjP/8MaYbmbzsFFnOrQX1AcPsa
	 gwWULcuHGBAIjdKvahH57faIFxjEdbY5wItOOckubhbaCsBa/P35zKFQLWY7XR2g+Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=LBX181eQ;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B4606A683
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE8B4606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=LBX181eQ
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AMEpQ7q2232929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 15:51:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795359087; bh=3zu5cF1MvmxFDdOO8c/b15CLsyCjgFiHf4BT+dNBfxE=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc;
	b=LBX181eQ3Ajl6sV70RLiHCvOqhugmv2UsisVeRJZBrsFrFTjfWdIJ17uCFsrr9GQE
	 Ae25xDGH9QdVuZ4B+hW0v3uEdrG09TZ6LKff+k2x6GS/r7Exfhz5MZha3DySVUI30U
	 N72pFbuSMKVBxR8A7z65e5v/ZYoevJYoAuSlOHHU=
From: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v5 0/4] utf8: bounds-related fixes and a doc fix
Date: Sun, 22 Nov 2026 15:51:23 +0100
Message-Id: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQrCMBQE0KtI1kbyf0waXXkPcZEmvxrBVpK2K
 NK7myiIUpcD82YeLFEMlNh28WCRxpBC1+aglgvmTrY9Eg8+Z4YCNQBofrGpp8j1poYKNKBByXL
 5GqkJt9fQ/vDOaajP5PqiS+MUUt/F++tphNKbjY7ABfcOrRKOhLVid+wGTzGtWupZmR3xG5oPx
 Axlg9aSA+UlzKH8gig+UJZHNGRcpTxqP4fr/3CdoWoahdLXFRr1C6dpegLNGdN6WwEAAA==
X-Change-ID: 20261116-master-69b171612823
In-Reply-To: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
To: git@vger.kernel.org
Cc: "Junio C Hamano <gitster@pobox.com>, Andy Koppe" <andy.koppe@gmail.com>,
        Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6761; i=dirk@gouders.net;
 h=from:subject:message-id; bh=LEfMFvQQFQoBkION42YvHXXmIUfM8JtyUAuecnQyjPY=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLKZGfMUnZYdWPA4qLW8OXXOpgjdrFnL+B9oL+ifq2541
 4W1jnVVJ+MEFgZGLoYqMUWWpZOK7NJUVrwo+6aaCTOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkYOEDl+Bo30gnSH9PzSlNSiYr281BJHU0sjcyNjVzMzIxNHC1cLczM3MyNTM0tHE1NzV0c
 XM2NzY1MTR0tnBi5OAZh1hZPY/2dXK2oyKZvffcKadeOA79t1US4B3//1SK2W37PWfcrhz8wZM4
 6c3nOI5WNF2Mqo0H/C2+On71qj+W+q5PT/juK+HEkzlmcu/lwVvcvtSsjsI7Xz/FOXLPfcu9RsO
 v+BU72dAfutHMKbd9Rcehsjdj72jsDdybt/rzYI2FPlwtozr+mooraW7LKc+sDnc3dq3jeLZz7E
 E/Z9/g2+hmmN6aoPJl3OqJ46ecXLa4/MasslmyRnGB/+Hfhie9mES/OsGx77ZEVVrZEzPLBnFqs
 6Uwz3z+37ky5NP7OsNOjQp465DWJJ/dl6yZoH38xIrPl+6HHJ43r3i9UfTXb+/lQqf6KPNTvn+6
 XHKhcir7gFTX0EAA==
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
      utf8: respect boundaries in utf8_strnwidth()

Junio C Hamano (1):
      utf8: add display_mode_esc_sequence_len_counted()

 Makefile                    |  1 +
 t/meson.build               |  1 +
 t/unit-tests/u-utf8-ansi.c  | 86 +++++++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/u-utf8-width.c | 20 +++++++++++
 utf8.c                      | 56 ++++++++++++++++++++---------
 utf8.h                      |  1 +
 6 files changed, 149 insertions(+), 16 deletions(-)

Range-diff versus v4:

1:  9d485b3d85 < -:  ---------- utf8: introduce bounds for display_mode_esc_sequence_len()
-:  ---------- > 1:  1a45a2c68d utf8: add display_mode_esc_sequence_len_counted()
2:  804d6e33e2 ! 2:  8a39f7d1ef utf8: fix comment for utf8_strnwidth()
    @@ Metadata
      ## Commit message ##
         utf8: fix comment for utf8_strnwidth()
     
    -    The comment for utf8_strnwidth() states it works on a NUL terminated
    +    The comment for utf8_strnwidth() states it works on a NUL-terminated
         string whereas the string is bounded by len.
         It also states it returns strlen() for cases when the given string
         doesn't look like valid utf8, but it returns its argument len in such
3:  04779942c0 ! 3:  c131754368 utf8: respect string boundaries after skipping ANSI escape sequences
    @@ utf8.c: int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
      		size_t skip;
      
     -		while (skip_ansi &&
    --		       (skip = display_mode_esc_sequence_len(string, end)))
    +-		       (skip = display_mode_esc_sequence_len_counted(string,
    +-							orig + len - string)) != 0)
     -			string += skip;
     +		if (skip_ansi) {
    -+			while ((skip = display_mode_esc_sequence_len(string, end)))
    ++			while ((skip = display_mode_esc_sequence_len_counted(string,
    ++									     orig + len - string)))
     +				string += skip;
     +
    -+			if (string >= end)
    ++			if (string >= orig + len)
     +				break;
     +		}
      
4:  dad74fb874 ! 4:  a64dbf4eeb utf8: respect boundaries in utf8_strnwidth()
    @@ t/unit-tests/u-utf8-width.c
     
      ## utf8.c ##
     @@ utf8.c: int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
    - 
    - 	while (string && string < end) {
    + 	while (string && string < orig + len) {
      		int glyph_width;
    --		size_t skip;
    + 		size_t skip;
     +		size_t remainder;
      
      		if (skip_ansi) {
    - 			while ((skip = display_mode_esc_sequence_len(string, end)))
    + 			while ((skip = display_mode_esc_sequence_len_counted(string,
     @@ utf8.c: int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
      				break;
      		}
      
     -		glyph_width = utf8_width(&string, NULL);
    -+		remainder = end - string;
    ++		remainder = orig + len - string;
     +
     +		glyph_width = utf8_width(&string, &remainder);
      		if (glyph_width > 0)
5:  1a3fc65005 < -:  ---------- utf8: introduce display_mode_esc_sequence_len_all()

---
base-commit: f7de81456940dd6f3274e461149bba12965de609
change-id: 20261116-master-69b171612823

