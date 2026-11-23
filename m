Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460590;
	b=J9gJW7WjrxveTib7P2Wmrra2uKC8Xw0VPNDdwkT2L5NQtBeobQ19GNYsFhsfZ2pKVRy2
	 4L7zswO27qOWmFKA1Psa/QLyEJU/Jhw/1Z6gtQZ86oFl9me1KpgvDwt6IF/Sq2YMvlV9a
	 nuB2xMllhf63afP7BjHk2RmTbm51srkcTVo+65wGSgzycY37mZT7WjGmXS0EyMXKcfbut
	 3sVJjx1tKeDq6DpCYhhNIZHlN44nDtW9bgdtmvKbp/vFGRlxFtsZm+1+/Eie9zD9eWOOH
	 liOa+XTBm9oIrpTU/jTE0jZGsAw+wRFfKkxL4hUxDZtTJtZa2inxH9Qa9yhE3EbHlLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460590;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kTMnDpUafFj1T0Q81zREi1aijxP+FdY5c4aeOBrx9Ow=;
	b=4B5mC6BBwZexUYPFZ48uPwd6E4gEQ3XM5zp6V0BwJqcSXbO0i4tPK1a1jnkC8CaHGs4E
	 QhNQSafWdJhlLlWpScOxOabKLsgivR79qdrNdjKkKWFL7rRP/zWxrvSgxtUkRalNEVBEj
	 WgWhQ8NB83b2Hk0/HOlXlQt+Q+gtLrqCSNfS/l2xV1gYTuRSjr+gb9VtWMdfW8dMxGSSd
	 JPBX4N7LfUaE8ElttTIILf+WxZEP2ZyE2QgT4aqNPeYyDs4ezDlz5CYZ87PcVEtFBWi2x
	 tMSYfhnt+K3/Wazm1HqFHYpQIXmHtI96ztrcngPjZFsgcgbr8XSdv5T2w26TPqlMDkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=hsdW3P+t;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF19606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 19:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF19606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=hsdW3P+t
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6ANJ2swW2327133
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 23 Nov 2026 20:02:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795460575; bh=kTMnDpUafFj1T0Q81zREi1aijxP+FdY5c4aeOBrx9Ow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hsdW3P+tBYiCV9BVbRzg87SKS8cj7Rp34QrU06Bfi7Je2g80NU7WqaSxeNITwO9Ly
	 9nLay0SdHqmgDkNyAwEkTqog+sDwGVid8uVfgw//tsOmLx3FLi9Db+VKqVevBHBuBN
	 ZwRIjbVozFAJJQf20oXNpFWsxhHn21E1iqlvErYY=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
        "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v5 1/4] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <xmqqa4mza399.fsf@gitster.g>
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
	<20261122-master-v5-1-313bd1bb3c45@gouders.net>
	<xmqqa4mza399.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 23 Nov 2026 20:02:54 +0100
Message-ID: <ghh5h7l6ap.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23 2026, Junio C Hamano wrote:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> From: Junio C Hamano <gitster@pobox.com>
>>
>> display_mode_esc_sequence_len() scans for an ANSI display mode
>> escape sequence (e.g. "ESC [ 1 ; 31 m") at the start of a string,
>> relying on NUL termination to stop.  Some callers, however, work on
>> a counted buffer: utf8_strnwidth() takes <string, len> and must not
>> scan past it, while strbuf_utf8_replace() and
>> strbuf_add_wrapped_text() know (or can cheaply learn) the end.
>>
>> Add display_mode_esc_sequence_len_counted() taking <ptr, len>,
>> which never reads at or beyond ptr[len], and make
>> display_mode_esc_sequence_len() a thin wrapper for NUL-terminated
>> strings.
>
> Good.
>
>> Use the counted variant in utf8_strnwidth() for correctness, and in
>> strbuf_utf8_replace() and strbuf_add_wrapped_text() (computing the
>> end once upfront in the latter) to avoid measuring the remaining
>> text in each iteration.
>
> OK, but the latter needs a slight fix (see below).
>
>> [Dirk Gouders: allow SIZE_MAX to be passed for NUL-terminated strings
>>  to avoid O(n=C2=B2) degradation as suggested by Andy Koppe.  Also add
>>  tests for these functions.]
>>
>> Helped-by: Andy Koppe <andy.koppe@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Dirk Gouders <dirk@gouders.net>
>
> Minor nit.  These ought to be a chronological record of custodial chain.
> The original author's sign-off comes first, then Helped-by and [note on
> the help in square brackets], and finally the sign-off of person who is
> relaying the final package.

OK, I will search for an example in the log.

>> diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
>> new file mode 100644
>> index 0000000000..d969737000
>> --- /dev/null
>> +++ b/t/unit-tests/u-utf8-ansi.c
>> @@ -0,0 +1,86 @@
>> +#include "unit-test.h"
>> +#include "utf8.h"
>> +#include "strbuf.h"
>
> Do we use <strbuf.h> at this stage?  I do not think so (and
> <unit-test.h> includes it anyway).
>
>> +
>> +/*
>> + * Test display_mode_esc_sequence_len_counted() for NUL-terminated stri=
ngs.
>> + */
>> +void test_utf8_ansi__sgr_len_counted(void)
>> +{
>> +	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("", SIZE_MA=
X));
>> +
>> +	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033", SIZ=
E_MAX));
>> +...
>> +	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[31;0m=
a", SIZE_MAX));
>
> It is sad that these lines have to become this long.

Two possible ways to make it prettier (in my eyes) would be to #1 rename
the function or #2 do something like:

diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
index d969737000..e22916ea87 100644
--- a/t/unit-tests/u-utf8-ansi.c
+++ b/t/unit-tests/u-utf8-ansi.c
@@ -5,26 +5,29 @@
 /*
  * Test display_mode_esc_sequence_len_counted() for NUL-terminated strings.
  */
+size_t (*test_function)(const char *, size_t) =3D
+       display_mode_esc_sequence_len_counted;
+
 void test_utf8_ansi__sgr_len_counted(void)
 {
-       cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("", SIZE=
_MAX));
+       cl_assert_equal_i(0, test_function("", SIZE_MAX));
=20
-       cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033", =
SIZE_MAX));
-       cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[",=
 SIZE_MAX));
-       cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[m"=
, SIZE_MAX));
-       cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[ma=
", SIZE_MAX));
+       cl_assert_equal_i(0, test_function("\033", SIZE_MAX));
+       cl_assert_equal_i(0, test_function("\033[", SIZE_MAX));
+       cl_assert_equal_i(3, test_function("\033[m", SIZE_MAX));
+       cl_assert_equal_i(3, test_function("\033[ma", SIZE_MAX));
=20
...

> As the values returned from display_mode_esc_sequence_len_counted() and
> friends are all size_t, not signed, cl_assert_equal_u() would be a much
> more appropriate assertion here.
>
> See how t/unit-tests/u-odb-inmemory.c:cl_assert_object_info() nearby
> uses it to check values of type size_t.
>
>> +/*
>> + * Test display_mode_esc_sequence_len_counted() with end pointers.
>
> Probably with "length limits" instead of "end pointers" in this
> iteration.
>
>> diff --git a/utf8.c b/utf8.c
>> index 96460cc414..503edb8edc 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>> @@ -16,18 +16,31 @@ struct interval {
>>  	ucs_char_t last;
>>  };
>>=20=20
>> -size_t display_mode_esc_sequence_len(const char *s)
>> +/*
>> + * Return the length of the ANSI display mode escape sequence (e.g.,
>> + * "\033[1;31m") that appears at the beginning of the "len" bytes
>> + * of string "s", or 0 if the bytes do not begin with a complete
>> + * such sequence.  Never looks at s[len] or beyond.
>> + */
>> +size_t display_mode_esc_sequence_len_counted(const char *s, size_t len)
>>  {
>> -	const char *p =3D s;
>> -	if (*p++ !=3D '\033')
>> +	size_t i =3D 0;
>> +
>> +	if (i >=3D len || s[i++] !=3D '\033')
>>  		return 0;
>> -	if (*p++ !=3D '[')
>> +	if (i >=3D len || s[i++] !=3D '[')
>>  		return 0;
>> -	while (isdigit(*p) || *p =3D=3D ';')
>> -		p++;
>> -	if (*p++ !=3D 'm')
>> +	while (i < len && (isdigit(s[i]) || s[i] =3D=3D ';'))
>> +		i++;
>> +	if (i >=3D len || s[i++] !=3D 'm')
>>  		return 0;
>
> Among 4 comparisons between i and len, only one of them follow the
> "textual order reflects actual order" principle.  Can we revert it back
> to the version I gave you to compare (len <=3D i) instead, if we allow the
> commit to claim to be from me, as I wouldn't write (i >=3D len) in these
> places if I were writing this patch myself.
>
>> +	return i;
>> +}
>
>>  /* auxiliary function for binary search in interval table */
>> @@ -218,7 +231,8 @@ int utf8_strnwidth(const char *string, size_t len, i=
nt skip_ansi)
>>  		size_t skip;
>>=20=20
>>  		while (skip_ansi &&
>> -		       (skip =3D display_mode_esc_sequence_len(string)) !=3D 0)
>> +		       (skip =3D display_mode_esc_sequence_len_counted(string,
>> +							orig + len - string)) !=3D 0)
>>  			string +=3D skip;
>>=20=20
>>  		glyph_width =3D utf8_width(&string, NULL);
>> @@ -279,6 +293,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
>>  {
>>  	int indent, w, assume_utf8 =3D 1;
>>  	const char *bol, *space, *start =3D text;
>> +	const char *end =3D text + strlen(text);
>
> This strlen() call is unconditionally made, even before the check to see
> if we divert to strbuf_add_indented_text() with "if (width <=3D 0)";
> measuring the length of text in that code path is wasted.
>
>>  	size_t orig_len =3D buf->len;
>>=20=20
>>  	if (width <=3D 0) {
>> @@ -299,7 +314,8 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
>>  		char c;
>>  		size_t skip;
>>=20=20
>> -		while ((skip =3D display_mode_esc_sequence_len(text)))
>> +		while ((skip =3D display_mode_esc_sequence_len_counted(text,
>> +								end - text)))
>>  			text +=3D skip;
>
> OK, I guess.
>
> It is a bit sad that we cannot use the trick similar to passing SIZE_MAX
> to avoid having to prescan to find "end", though.

Now that you mention it: if we can do strlen(text) then we can avoid the
_counted variant.  I have to test it but I'm pretty sure.

Dirk

>>  		c =3D *text;
>> @@ -378,7 +394,8 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int =
pos, int width,
>>  		int glyph_width;
>>  		size_t n;
>>=20=20
>> -		while ((n =3D display_mode_esc_sequence_len(src))) {
>> +		while ((n =3D display_mode_esc_sequence_len_counted(src,
>> +								  end - src))) {
>>  			strbuf_add(&dst, src, n);
>>  			src +=3D n;
>>  		}
>> diff --git a/utf8.h b/utf8.h
>> index cf8ecb0f21..57ca2ab270 100644
>> --- a/utf8.h
>> +++ b/utf8.h
>> @@ -6,6 +6,7 @@ struct strbuf;
>>  typedef unsigned int ucs_char_t;  /* assuming 32bit int */
>>=20=20
>>  size_t display_mode_esc_sequence_len(const char *s);
>> +size_t display_mode_esc_sequence_len_counted(const char *s, size_t len);
>>  int utf8_width(const char **start, size_t *remainder_p);
>>  int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
>>  int utf8_strwidth(const char *string);
