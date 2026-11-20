Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185883;
	b=1tUW9/dnfmFuQGwYiWSUP/YzxX/coySzyTS/xOinjDRnPfurmdufbbNFi52Ywczpf1Ib
	 1nei44ZcBA5wfs0Nhg23K6U9+qHz/jBO6Vm4d/np2IFceOYM4V7hyDgIkUgcoQWbuPWpM
	 F3TtORnpnbYGZjEM6NlQKnzt5y4LlNpJIaXvY9qGS6fLAOu8JtTjD5tdJfGWC8y0TSudo
	 wKPcGOrftC+toDUn3wTTW3TuUZeViDEgWlQMajHT7L6mOrXgEZQVaTfzp7ewpOhJ472EF
	 Cc2K7ZlZ6xk0dl4sh5fgnr51q6LDEsoXR7+8Tze2XVsoXlDB8ZzHd5jhYG6KETP3DWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185883;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=GZ4XL7hsdJKrh/P3gixwsOqtdInyCXWWeDTpSR1IW2M=;
	b=12+VDFwVcGNsVwgUGaQc6BUpWJfGt3z3JTUKGRHY8Q1PTAPwR0LDIX7X+Jvu7zTzXl47
	 RtIhfWUEEGvwz89LSV9jLoT6Diav14hVBMI3X4iS4AwHHWoMnEfoqEpy4o8PgBJpzr6Hc
	 dwlXx4KuLLx50+nlpwdsPu85F1Yq0gVH3nmqhQJj+Dmfzd51RTkRJ/nZEo3EqBeoqXDJL
	 U1fdv/m3x5+53jpHCoiOuNArtBhkMdpIT+XyuEyaRqOKwGPtinzCTZwaZuq77wzmf4EhZ
	 QAwCpIHV+7HksuIoCA1VU7pFyDTUmnR8yb/GJG85e/lypSYjpdUBJjNTxR3HelmeuGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=QJL4EvxJ;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E0606A33A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C6E0606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=QJL4EvxJ
Received: from lena.gouders.net (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKEiRt62079849
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 15:44:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795185869; bh=GZ4XL7hsdJKrh/P3gixwsOqtdInyCXWWeDTpSR1IW2M=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc;
	b=QJL4EvxJL844++Uk+fxB0Yb/bdhy1HfT+UIc0aXEg5hUhWZAmr4Ft6kvyguojIJXZ
	 wBlU8aAkcccr1QRCdXz+ylpZ04PYzbNQRTFpyDR0UKXiK5QSClZExa1e0YWv3zgRKS
	 isHpIrzqhQgrOfHokMV7nzfJUSKI38TP+CuRy5ps=
From: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH v3 0/4] utf8: bounds-related fixes and a doc fix
Date: Fri, 20 Nov 2026 15:44:23 +0100
Message-Id: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQrCMBAFf6XkbCS7obF68j/EQ5qsbQRbSdKgl
 P67SQVRPA68mTezQN5RYIdqZp6SC24cMshNxUyvh464s5kZClQAoPhNh0ieq30LO1CADUqWx3d
 PF/dYQ6fzm8PUXsnEYpdF70Ic/XN9SlB2f9EEXHBrUNfCkNBaHLtxsuTDdqDISjbht9h8RMyiv
 KDWZKC2En7FZVleqqZ/Q+kAAAA=
X-Change-ID: 20261116-master-69b171612823
In-Reply-To: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dirk Gouders <dirk@gouders.net>,
        Andy Koppe <andy.koppe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4275; i=dirk@gouders.net;
 h=from:subject:message-id; bh=F+ArsJGd/zbbmx5/Ch5rUW8TsKBsZ9u+S55+K7NZfzI=;
 b=owGbwMvMwMW4JPzVNXNTrzmMp9WSGLIZYs7YB1k2P1rDxHv/wfVlFq7qZaUvX6aZZvz4zWe87
 +q1Ras8Ohn7WRgYuRiqxBRZlk4qsktTWfGi7JtqJswgViaQKdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Zwhk6Bg5QOT4GTTSC9Id0vNLU1KLivXyUkscTS2NzI2MXc3MjEwcLVwtzM3czIxMzSwdTUzNXR1
 dzIzNjU1NHC2dGbg4BWDWOXxm/yrWf6yvXdHQ9SCfmMNOoVql+i33M4N8rvvJibycVcSw9EZnL9
 eq+Ybik63OSYSETX93zdBxLtvTzhsT/Q2cO270Bp7bfinz1mP9yj2zw380nhDb2paad4upvatqz
 /7VhtcetHF6+GxOOZVevq94itehoO5fBv9PC52c/WzuxEv2HZcis5J+2L7tdO3a80PzWaFBg+D+
 21MrhRkZ3+z/+aTGn5VXUuWjdhCvq9jL2ANTbjgc++yy9XTUyyfHT27aMnPFr7upD9tNXj3ss7W
 9JO/ZsNM41eX2ldXtomc3Bk3NPy9/8/yStNQHAcJKk7aHFW9dz8je37YzNO9BzpGstH1RLrJZm/
 fN0DfeaDx9KwA=
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
      utf8: introduce bounds for display_mode_esc_sequence_len()

 Makefile                    |  1 +
 pretty.c                    |  2 +-
 t/meson.build               |  1 +
 t/unit-tests/u-utf8-ansi.c  | 85 +++++++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/u-utf8-width.c | 20 +++++++++++
 utf8.c                      | 78 +++++++++++++++++++++++++++++------------
 utf8.h                      |  3 +-
 7 files changed, 165 insertions(+), 25 deletions(-)

Range-diff versus v2:

1:  60979dc4d6 < -:  ---------- utf8: add display_mode_esc_sequence_len_counted()
2:  b8dbf5c5bf < -:  ---------- utf8: fix comment for utf8_strnwidth()
-:  ---------- > 1:  5b938b3fa0 utf8: introduce bounds for display_mode_esc_sequence_len()
-:  ---------- > 2:  5ef8308d51 utf8: fix comment for utf8_strnwidth()
3:  12a99d1c8d ! 3:  bd7c9b0b01 utf8: respect string boundaries after skipping ANSI escape sequences
    @@ utf8.c: int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
      		size_t skip;
      
     -		while (skip_ansi &&
    --		       (skip = display_mode_esc_sequence_len_counted(string,
    --							orig + len - string)) != 0)
    +-		       (skip = display_mode_esc_sequence_len(string, end)))
     -			string += skip;
    -+		if (skip_ansi ) {
    -+			while ((skip = display_mode_esc_sequence_len_counted(string,
    -+									     orig + len - string)) != 0)
    ++		if (skip_ansi) {
    ++			while ((skip = display_mode_esc_sequence_len(string, end)))
     +				string += skip;
     +
    -+			if (string >= orig + len)
    ++			if (string >= end)
     +				break;
     +		}
      
4:  471c3d6888 < -:  ---------- utf8: respect boundaries in utf8_strnwidth()
-:  ---------- > 4:  a6cf4c99dc utf8: respect boundaries in utf8_strnwidth()

---
base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
change-id: 20261116-master-69b171612823

