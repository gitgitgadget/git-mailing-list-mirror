Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950823;
	b=MJwanEISYI/aVPOlg0ZExOy8GCx8VcaAyhZ33nJ/EvNse81OXWMR0wg/qkG0ghzKim8s
	 kpiOEqVaZ54V/rvs5V7mvo6O2JrhQ9TRmkL2r7SysI2zmdnezaJLVEJL377Jp4YMWFgfy
	 PMBO/bgiev5a2pVDl3rXuKmQwqLarEWUzoaebJoOCbgRx6y/nG6wL90iQve5LbS60GVOL
	 j3No025c/xGdCRz6zb09hkOsXdPnAn7DjoSFuKfiawK84yO5g+lNpObYpjt/FEykORdBM
	 smqVbte9UvtewtO0CMDAdfEOW8ZsppK78WXEagBdvnsLKDxsIzNcqJ5DK++0kChQbDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950823;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=jiHyaqzFt7j7m+5r81Gu5xf/xImB7UHMK9kifScSPzI=;
	b=qIbnhCjnYnGxjQ+17CSWwB5x2EyxSeSImpMPuAnzJj2OjIKpKp8Aiw4YZB5wuiCRDqXT
	 JtALEhmbUZg9QfcZCyw1cfgMtNzuxJdzmlkJNaGj0C5ko1wp3J/9Ah1YpSBvQ8ZplC8Ql
	 efB5uxcuRdgiqHnD6hUx5pD+hLlmv/241zkdBcwbVVF2swWCkMI8L0gIgaP/b/Xc7yl0d
	 azxwuwXlpc0SW/KUjd9MwsIlslGuAhDhh3ltY1NJgVNAcSM9CXNzF/QxuXhk32IJmyWI3
	 sK1Qby6gkdCLUiikKfE1+hdUOOXAGbZg4qDoQig/QdoCBI25eNr4E2u6iYoOmxdrM8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=A3n2f9BC;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6184606A33D
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 21:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6184606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=A3n2f9BC
Received: from localhost (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AHLQoT71847859
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 17 Nov 2026 22:26:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1794950811; bh=jiHyaqzFt7j7m+5r81Gu5xf/xImB7UHMK9kifScSPzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=A3n2f9BCwmFTY9J8kQZSsoDCMgsrG4GX1pLdh+xbNvLAgWDrMSmwEgKLaqQtr11YB
	 1WA1gabBhTmYSPdNrd8bLPIHbGRlrGIi8tx6ZMuTKWEM0ZP/pyVVXxg8bOnLHL8IVR
	 qL/MNpvGJFqE+8VbgOQGdGiVSWuINXW518vZzoWw=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <xmqqqzgjcjes.fsf@gitster.g>
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 17 Nov 2026 22:26:50 +0100
Message-ID: <ghy0arkv39.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 17 2026, Junio C Hamano wrote:

> display_mode_esc_sequence_len() scans for an ANSI display mode
> escape sequence (e.g. "ESC [ 1 ; 31 m") at the start of a string,
> relying on NUL termination to stop.  Some callers, however, work on
> a counted buffer: utf8_strnwidth() takes <string, len> and must not
> scan past it, while strbuf_utf8_replace() and
> strbuf_add_wrapped_text() know (or can cheaply learn) the end.
>
> Add display_mode_esc_sequence_len_counted() taking <ptr, len>,
> which never reads at or beyond ptr[len], and make
> display_mode_esc_sequence_len() a thin wrapper for NUL-terminated
> strings.
>
> Use the counted variant in utf8_strnwidth() for correctness, and in
> strbuf_utf8_replace() and strbuf_add_wrapped_text() (computing the
> end once upfront in the latter) to avoid measuring the remaining
> text in each iteration.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * As there are new patches that want to add new callers to this
>    function, let's keep the original with the same API while adding
>    a new helper function that allows us to limit the scan.
>
>  utf8.c | 35 ++++++++++++++++++++++++++---------
>  utf8.h |  1 +
>  2 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/utf8.c b/utf8.c
> index 96460cc414..d0546ab31f 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -16,20 +16,33 @@ struct interval {
>  	ucs_char_t last;
>  };
>  
> -size_t display_mode_esc_sequence_len(const char *s)
> +/*
> + * Return the length of the ANSI display mode escape sequence (e.g.,
> + * "\033[1;31m") that appears at the beginning of the "len" bytes
> + * of string "s", or 0 if the bytes do not begin with a complete
> + * such sequence.  Never looks at s[len] or beyond.
> + */
> +size_t display_mode_esc_sequence_len_counted(const char *s, size_t len)
>  {
> -	const char *p = s;
> -	if (*p++ != '\033')
> +	const char *p = s, *end = s + len;

You have better knowledge of the users of this function: would an early
return perhaps handle a significant amount of cases?

        /* The shortest SGR sequence is "\033[m". */
        if (len < 3)
                return 0;


And, why not add some tests (the untested function I showed had
an off-by-one error):

diff --git a/Makefile b/Makefile
index 4c84eea6e2..3c8dc9ca40 100644
--- a/Makefile
+++ b/Makefile
@@ -1564,6 +1564,7 @@ CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
 CLAR_TEST_SUITES += u-utf8-width
+CLAR_TEST_SUITES += u-utf8-ansi
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
diff --git a/t/meson.build b/t/meson.build
index 1cf1d95f70..e224df58c8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -27,6 +27,7 @@ clar_test_suites = [
   'unit-tests/u-trailer.c',
   'unit-tests/u-urlmatch-normalization.c',
   'unit-tests/u-utf8-width.c',
+  'unit-tests/u-utf8-ansi.c',
 ]
 
 clar_sources = [
diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
new file mode 100644
index 0000000000..c19d8bce78
--- /dev/null
+++ b/t/unit-tests/u-utf8-ansi.c
@@ -0,0 +1,14 @@
+#include "unit-test.h"
+#include "utf8.h"
+#include "strbuf.h"
+
+/*
+ * Test len limited functions for ANSI SGR lengths.
+ */
+void test_utf8_ansi__sgr_len(void)
+{
+	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[m", 2));
+	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[m", 3));
+	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted("\033[31m", 5));
+	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[0;31m", 7));
+}

Regards,

Dirk

> +	if (end <= p || *p++ != '\033')
>  		return 0;
> -	if (*p++ != '[')
> +	if (end <= p || *p++ != '[')
>  		return 0;
> -	while (isdigit(*p) || *p == ';')
> +	while (p < end && (isdigit(*p) || *p == ';'))
>  		p++;
> -	if (*p++ != 'm')
> +	if (end <= p || *p++ != 'm')
>  		return 0;
>  	return p - s;
>  }
>  
> +/* Same as above, but for a NUL-terminated string "s". */
> +size_t display_mode_esc_sequence_len(const char *s)
> +{
> +	return display_mode_esc_sequence_len_counted(s, strlen(s));
> +}
> +
>  /* auxiliary function for binary search in interval table */
>  static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
>  {
> @@ -218,7 +231,8 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  		size_t skip;
>  
>  		while (skip_ansi &&
> -		       (skip = display_mode_esc_sequence_len(string)) != 0)
> +		       (skip = display_mode_esc_sequence_len_counted(string,
> +							orig + len - string)) != 0)
>  			string += skip;
>  
>  		glyph_width = utf8_width(&string, NULL);
> @@ -279,6 +293,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
>  {
>  	int indent, w, assume_utf8 = 1;
>  	const char *bol, *space, *start = text;
> +	const char *end = text + strlen(text);
>  	size_t orig_len = buf->len;
>  
>  	if (width <= 0) {
> @@ -299,7 +314,8 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
>  		char c;
>  		size_t skip;
>  
> -		while ((skip = display_mode_esc_sequence_len(text)))
> +		while ((skip = display_mode_esc_sequence_len_counted(text,
> +								end - text)))
>  			text += skip;
>  
>  		c = *text;
> @@ -378,7 +394,8 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
>  		int glyph_width;
>  		size_t n;
>  
> -		while ((n = display_mode_esc_sequence_len(src))) {
> +		while ((n = display_mode_esc_sequence_len_counted(src,
> +								  end - src))) {
>  			strbuf_add(&dst, src, n);
>  			src += n;
>  		}
> diff --git a/utf8.h b/utf8.h
> index cf8ecb0f21..57ca2ab270 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -6,6 +6,7 @@ struct strbuf;
>  typedef unsigned int ucs_char_t;  /* assuming 32bit int */
>  
>  size_t display_mode_esc_sequence_len(const char *s);
> +size_t display_mode_esc_sequence_len_counted(const char *s, size_t len);
>  int utf8_width(const char **start, size_t *remainder_p);
>  int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
>  int utf8_strwidth(const char *string);
