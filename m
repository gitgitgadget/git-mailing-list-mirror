Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036147;
	b=DHnpj5Z0x8IP75LWIrRLu8XuAAZcBqjMu1n6B0UA+fJivCgSIjsud2cfAaAwrD+5Vqeo
	 8x2NbnjjZTPzDCQ0QOauLw3vBOuOZySjdePq+ly5MkF4H6Yq+K1QAGh1TYh2sYBR0lTgm
	 RbrFiidDif8clbZHjwGjBzfuSX+0sXCoFsnT8A367ZLkCde7RbQ2nTcxSgU0iih1uvyis
	 paI1Iy2KG2H78Kkl8j9F2M/38dK3+URguM1wg3/7bJlpAQ/HrTg2UCFtpZV35bshzCT1m
	 nP+Asz4cOJvVHt28BsNS4geRIe0tRE7PU67X63+F9TPhB2UENxHtf9WJpABEoi6UwOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036147;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=9u75i3u6b267+HRsJxr0DminIyienRlz5O40ifv8ifM=;
	b=lrnYYcKO3BE+admxerplePzofNVYFSBYCB8XaN/3pTxzUcv7BG2e3X6nTgpWK0BkjYne
	 YPOoSMomYcpnZDJppZGgbQkmUSpxTrxeUQ4Y/NDlgzpjzerl61HZXhTKzslI4H2GFrsOP
	 0DQgB/00jeIKzGAyB1NzZogUUvU3jioY+9mraFAYQgiMBhjK18+oesd9BqtSv3J6abBu0
	 EW0x4cXGWZ2hB+M5OxcjHIAU4KFeB/QOEnaT39EkaHFZ9IDY8AB2fAZguO8AHWUsHREu8
	 61YQTxJ4X0U+fPN5GCUlOQlGp3aMVrTAWTMGRER62Wah/LQfk29TxwoKVT7uqUHO4fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=qdy7LvvP;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DC606A337
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB3DC606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=qdy7LvvP
Received: from lena.gouders.net (ip-109-41-49-52.web.vodafone.de [109.41.49.52])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AIL8tdM1931210
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 22:09:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795036142; bh=9u75i3u6b267+HRsJxr0DminIyienRlz5O40ifv8ifM=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc;
	b=qdy7LvvP18jNYYfqCRgHYXeKTTKjs8+APLKAZ/T/eozN2pkAwdX59uA8rs94XxCYx
	 SfnCOw9ryGKPJtn8AhUbQWfIZWUwuzLs3GnparLBCbioNKs6Qrhjdl++BgF/D+copz
	 CR1ij6Vfcu8RTQJPV5tP9JMr9X/+ATFpPelyeDTo=
From: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v2 0/4] utf8: bounds-related fixes and a doc fix
Date: Wed, 18 Nov 2026 22:08:49 +0100
Message-Id: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNyw7CIBBFf6WZtRgGIz5W/ofpgtKxxURoGEo0D
 f8urUuXJzn33AWYoiOGa7NApOzYBV9B7Rqwo/EDCddXBiWVRkQtXoYTRaEvHZ5QozqrA1R5ivR
 w7y10b3/Mc/ckm9b1aoyOU4if7Snj6v1FMwopeqvMUVqSxsjbEOaeIu89JWhLKV9A9lqcsAAAA
 A==
X-Change-ID: 20261116-master-69b171612823
In-Reply-To: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5194; i=dirk@gouders.net;
 h=from:subject:message-id; bh=L4fnSlg2y1GA5Z6Teo9CaWVU5P1ZuPg5Z5afAQZElYw=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLL+CT//tNWvPuOJ8fXK8zY3fX5u1f68Te/BUZldotwSV
 zpMxLaJdDJOYGFg5GKoElNkWTqpyC5NZcWLsm+qmTCDWJlApkiLNDAAAQsDX25iXqmRjpGeqbah
 niGQoWPkAJHjZ9BIL0h3SM8vTUktKtbLSy1xNLU0MjcydjUzMzJxtHC1MDdzMzMyNbN0NDE1d3V
 0MTM2NzY1cbR0ZuDiFIBZJ6bBwTBj18OJfxdmWUY/ffrYVPRbXOtpho1TLKZd4kr6m8e34OwfAy
 VNhwt9tUbZxctlTucGPcxsr3b9WlNrpd5wIIjx1uecoJb3j/+7BWy++2Ghmswk1a78wnoR3jCWS
 NleN70d7K1zCypYX4t////50fLQXTmRj58s4Ljybzl3yh6R2isnrxdoTxZfGvnm12177fCrUz85
 SgXG2btvEosKyk/4y7isUpp3Xec6gysfT3kd9dTbaB23Xj6m3jUmzGiv+Wujy8cEU2dysFllFJ6
 +9VbyxZqL+c8aivNtFQqrbIRWHQw2fObRz7DoTI638rn7xf9y/qt+WmRXemZmwyTmbZvFt/m4m/
 7zVxPRy5KIAwA=
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
 t/unit-tests/u-utf8-ansi.c  | 14 +++++++++++++
 t/unit-tests/u-utf8-width.c | 20 ++++++++++++++++++
 utf8.c                      | 50 +++++++++++++++++++++++++++++++++------------
 utf8.h                      |  1 +
 6 files changed, 74 insertions(+), 13 deletions(-)

Range-diff versus v1:

-:  ---------- > 1:  3b2ab53858 utf8: add display_mode_esc_sequence_len_counted()
2:  aab04775f6 = 2:  efeff5cfd7 utf8: fix comment for utf8_strnwidth()
1:  21baf82731 ! 3:  152210dd15 utf8: respect bounds in utf8_strnwidth()
    @@ Metadata
     Author: Dirk Gouders <dirk@gouders.net>
     
      ## Commit message ##
    -    utf8: respect bounds in utf8_strnwidth()
    +    utf8: respect string boundaries after skipping ANSI escape sequences
     
    -    utf8_strnwidth() takes a len argument, but because
    -    display_mode_esc_sequence_len() works without an explicit boundary,
    -    there are cases when utf8_strnwidth() operates beyond the given len
    -    boundary.
    +    utf8_strnwidth() can skip ANSI escape sequences and it is possible
    +    that such sequences end the string within the given boundary.
     
    -    Fix this by adding a boundary-check after looping with
    -    display_mode_esc_sequence_len() to ensure we operate strictly within
    -    the given len.
    +    Check for such situations before proceeding and calling utf8_width().
     
    -    Further, add three corner case tests of which two will fail without
    -    the fix:
    -    ------------------------------------------------------------------------
    -    not ok 257 - utf8_width::strnwidth_ansi
    -        ---
    -        reason: |
    -          Expected comparison to hold: 0 == utf8_strnwidth("\033[31mhello", 4, 1)
    -          0 != 1
    -        at:
    -          file: 't/unit-tests/u-utf8-width.c'
    -          line: 11
    -          function: 'test_utf8_width__strnwidth_ansi'
    -        ...
    -    ------------------------------------------------------------------------
    -
    -    With the fix:
    -    ------------------------------------------------------------------------
    -    ok 257 - utf8_width::strnwidth_ansi
    -    ------------------------------------------------------------------------
    +    Add tests that test such corner cases.
     
         Signed-off-by: Dirk Gouders <dirk@gouders.net>
     
    @@ t/unit-tests/u-utf8-width.c
     + */
     +void test_utf8_width__strnwidth_ansi(void)
     +{
    -+	cl_assert_equal_i(0, utf8_strnwidth("\033[31mhello", 4, 1));
    ++	cl_assert_equal_i(3, utf8_strnwidth("\033[31mhello", 4, 1));
     +	cl_assert_equal_i(0, utf8_strnwidth("\033[31mhello", 5, 1));
     +	cl_assert_equal_i(1, utf8_strnwidth("\033[31mhello", 6, 1));
     +}
    @@ utf8.c: int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
      		size_t skip;
      
     -		while (skip_ansi &&
    --		       (skip = display_mode_esc_sequence_len(string)) != 0)
    +-		       (skip = display_mode_esc_sequence_len_counted(string,
    +-							orig + len - string)) != 0)
     -			string += skip;
    -+		if (skip_ansi) {
    -+			while ((skip = display_mode_esc_sequence_len(string)) != 0)
    ++		if (skip_ansi ) {
    ++			while ((skip = display_mode_esc_sequence_len_counted(string,
    ++									     orig + len - string)) != 0)
     +				string += skip;
     +
     +			if (string >= orig + len)
-:  ---------- > 4:  044d188fa8 utf8: respect boundaries in utf8_strnwidth()

---
base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
change-id: 20261116-master-69b171612823

