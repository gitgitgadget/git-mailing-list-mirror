Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAAAC76196
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 09:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDBJol (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 05:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBJok (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 05:44:40 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC6E199B
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 02:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680428671; i=l.s.r@web.de;
        bh=BjC28764vPzN/Nz/ZW9FCe7AngG6wAxv8jTC93aBN/A=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=VTMSshQCJWPpgRW/+lxTIYwBVe1VwDdVEDQkGFN6b76n2Iv1iLTmswUwzDuETVuxY
         2l22Vm2G1hAM5oBzydxLdw3WHYJD16T9ShVyn8XMqzC0jNSgTHEA/vanQniUfYbZoe
         wPE/pr64vzhmnjLCg8q/WDOPTF+wht5BLtUoVx5s00rkjM2Z5iLaVPhEAA+Dzz6Qni
         CYmj4WvGNmI8PywhUUwy9tlLEIf7sF1HDWK1ayxGF5fd/qdVo2e6SiLAr5zz764Xk2
         En8R7Nzfse/M9TNu2cAcu17NysCiGmQDy/G8dDeH78VXlsasXnhjLLRJLjeM3n8BSP
         xzVVEPCfIqeqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1qXpzA0OE7-00tdO4; Sun, 02
 Apr 2023 11:44:31 +0200
Message-ID: <c4728fac-bea9-3794-077e-c978d99f46bf@web.de>
Date:   Sun, 2 Apr 2023 11:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: regex compilation error with --color-words
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
 <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
 <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
Content-Language: en-US
In-Reply-To: <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZWUpb53FRpyh3gh5XSoNNl81QYBcwHMqII6wilUYkmd8oNg2bDG
 K/3bqZv9CganmBpiPqg7WiTddMiUx+YHZUdij49L2f7XkJLbBScegq7ck9TnhXpg6BxYY0l
 JgZ0NETR6DwLaorw9nd7+FhNsLALn8tbclk0pH5rtZ6d4Um/8MTwE86mOuCWvsFbjSjoYbV
 VXFLdf+oc7tSrfwNsOzBw==
UI-OutboundReport: notjunk:1;M01:P0:x1YhemePopo=;8e48FxJHD+MUvHDfmyUxXMv93RT
 q57ulpG2o8CTTmky3LKqZ3zJs941OoqN4tCWDa4Pjrp/ZwwSiVgNStoV+Vx6QtYkY4tAnCKkR
 B4KbUDGOklJKT832ZvKUNX8kWPn8BZ62gouehnKJj5mD7jZU+B5neCna2+9G0ndmpELllKjf3
 s9VC6xpOlh+I9pnupYdtvPd+KpAE1akvCIleQ7GqPVVPOP68Xysy7+LA01GeIi0NQ26ACcEEK
 3BCe997Kag3RYIEMim3hEW/fRECyIw7uoL7EYRjw14QMJIA8aZfSeOAWWeEfX7AfLN/diih0Z
 Fdc8UbEcN3SgwR5iFAIiF+t4/B5YgnssT08alAaVAXPjJVveeRN/1wl02GEi7brT8vrTiH7He
 q2+/nJ12KdA3nMUV5sGY7ud/uuVHoq5fgQL32OPomFb8pPCB6YJEBpY01aih5mrgTNMmVUQnq
 05Cza6U3gTN10ShSIQkAd9LazKOaoPJLP+sUUMhbKmwQ6I7vumxWkc36+yLFYpBWsdxiaPa1X
 5hy0oykq/7plHBfjxZ2hNyVj0PUv2LOjLQAe8xlqaX3VCt2EA4haPyC/wbvi4KRHjtJpMfyRV
 RmSitg46u2vJaRgZ3Zd9RJb2/KNMv/v4QZx0jpkclfz/mKERq8+Zoo9P8cdpuesAZh/FavxcJ
 VWNnfDXgzskK84LRC83wwJ7cOtIE+EoinidFJ4ZAvXBvTY2MgxSHVjuJxPrgKd7eTAsvoTJEa
 PLdtkphl9cWach56EGhhdUsePTIi3851/adfwUftfffK97JEio2hKxwZ7ILdQ+HjtAbapfctp
 s2hde60jRaFDU3LKbd4Uwmy7K0jIjF8qpXyspZ9eLLYHPdFDYOTWmLy6BA5HtJ5navrjPpZsq
 xc0QmKuINQPPqi5JA/2lXBxIRfVx7+gG8W9h2f8Ck4PAgf8wlAqitqB+Hdz1JlXkKIZh9ltK1
 qub6PA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.03.23 um 22:44 schrieb Ren=C3=A9 Scharfe:
> Am 30.03.23 um 09:55 schrieb Diomidis Spinellis:
>> On 30-Mar-23 1:55, Eric Sunshine wrote:
>>> I'm encountering a failure on macOS High Sierra 10.13.6 when using
>>> --color-words:
>>
>> The built-in word separation regular expression pattern for the Perl la=
nguage fails to work with the macOS regex engine.=C2=A0 The same also happ=
ens with the FreeBSD one (tested on 14.0).
>>
>> The issue can be replicated through the following sequence of commands.
>>
>> git init color-words
>> cd color-words
>> echo '*.pl=C2=A0=C2=A0 diff=3Dperl' >.gitattributes
>> echo 'print 42;' >t.pl
>> git add t.pl
>> git commit -am Add
>> git show --color-words
>
> Or in Git's own repo:
>
>    $ git log -p --color-words --no-merges '*.c'
>    Schwerwiegend: invalid regular expression: [a-zA-Z_][a-zA-Z0-9_]*|[0-=
9][0-9.]*([Ee][-+]?[0-9]+)?[fFlLuU]*|0[xXbB][0-9a-fA-F]+[lLuU]*|\.[0-9][0-=
9]*([Ee][-+]?[0-9]+)?[fFlL]?|[-+*/<>%&^|=3D!]=3D|--|\+\+|<<=3D?|>>=3D?|&&|=
\|\||::|->\*?|\.\*|<=3D>|[^[:space:]]|[<C0>-<FF>][<80>-<BF>]+
>    commit 14b9a044798ebb3858a1f1a1377309a3d6054ac8
>    [...]
>
> The error disappears when localization is turned off:
>
>    $ LANG=3DC git log -p --color-words --no-merges '*.c' >/dev/null
>    # just finishes without an error
>
> The issue also vanishes when the "|[\xc0-\xff][\x80-\xbf]+" part is
> removed that the macros PATTERNS and IPATTERN in userdiff.c append.
>
> So it seems regcomp(1) on macOS doesn't like invalid Unicode characters
> unless it's in ASCII mode (LANG=3DC).  664d44ee7f (userdiff: simplify
> word-diff safeguard, 2011-01-11) explains that this part exists to match
> a multi-byte UTF-8 character.  With a regcomp(1) that supports
> multi-byte characters natively they need to be specified differently, I
> guess, perhaps like this "[^\x00-\x7f]"?

Actually we can drop the "|[\xc0-\xff][\x80-\xbf]+" part in that case
because the "[^[:space:]]" suffices.  And we probably need to do that at
runtime because it depends on the locale.  The rather elaborate patch
below does that.  It leaks the truncated word_regex, which isn't that
bad because it's done only once per run, but certainly untidy.

I suspect/hope this can be done simpler and cleaner after refactoring
the userdiff code to allow for runtime assembly of regular expressions.

And it's regcomp(3), or rather regexec(3), not regcomp(1).

=2D--
 userdiff.c | 38 ++++++++++++++++++++++++++++++++++++--
 userdiff.h |  2 ++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 09203fbc35..aa2cd150ba 100644
=2D-- a/userdiff.c
+++ b/userdiff.c
@@ -9,6 +9,8 @@ static struct userdiff_driver *drivers;
 static int ndrivers;
 static int drivers_alloc;

+#define OR_MULTI_BYTE_CHAR "|[\xc0-\xff][\x80-\xbf]+"
+
 #define PATTERNS(lang, rx, wrx) { \
 	.name =3D lang, \
 	.binary =3D -1, \
@@ -16,7 +18,9 @@ static int drivers_alloc;
 		.pattern =3D rx, \
 		.cflags =3D REG_EXTENDED, \
 	}, \
-	.word_regex =3D wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
+	.word_regex =3D wrx "|[^[:space:]]" OR_MULTI_BYTE_CHAR, \
+	.is_builtin =3D 1, \
+	.has_multi_byte_char_fallback =3D 1, \
 }
 #define IPATTERN(lang, rx, wrx) { \
 	.name =3D lang, \
@@ -25,7 +29,9 @@ static int drivers_alloc;
 		.pattern =3D rx, \
 		.cflags =3D REG_EXTENDED | REG_ICASE, \
 	}, \
-	.word_regex =3D wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
+	.word_regex =3D wrx "|[^[:space:]]" OR_MULTI_BYTE_CHAR, \
+	.is_builtin =3D 1, \
+	.has_multi_byte_char_fallback =3D 1, \
 }

 /*
@@ -330,6 +336,25 @@ static int userdiff_find_by_namelen_cb(struct userdif=
f_driver *driver,
 	return 0;
 }

+static int regexec_support_multi_byte_chars(void)
+{
+	static const char not_space[] =3D "[^[:space:]]";
+	static const char utf8_multi_byte_char[] =3D "\xc2\xa3";
+	regex_t re;
+	regmatch_t match;
+	static int result =3D -1;
+
+	if (result !=3D -1)
+		return result;
+	if (regcomp(&re, not_space, REG_EXTENDED))
+		BUG("invalid regular expression: %s", not_space);
+	result =3D !regexec(&re, utf8_multi_byte_char, 1, &match, 0) &&
+		match.rm_so =3D=3D 0 &&
+		match.rm_eo =3D=3D strlen(utf8_multi_byte_char);
+	regfree(&re);
+	return result;
+}
+
 static struct userdiff_driver *userdiff_find_by_namelen(const char *name,=
 size_t len)
 {
 	struct find_by_namelen_data udcbdata =3D {
@@ -337,6 +362,15 @@ static struct userdiff_driver *userdiff_find_by_namel=
en(const char *name, size_t
 		.len =3D len,
 	};
 	for_each_userdiff_driver(userdiff_find_by_namelen_cb, &udcbdata);
+	if (udcbdata.driver &&
+	    udcbdata.driver->is_builtin &&
+	    udcbdata.driver->has_multi_byte_char_fallback &&
+	    regexec_support_multi_byte_chars()) {
+		const char *word_regex =3D udcbdata.driver->word_regex;
+		udcbdata.driver->word_regex =3D xmemdupz(word_regex,
+			strlen(word_regex) - strlen(OR_MULTI_BYTE_CHAR));
+		udcbdata.driver->has_multi_byte_char_fallback =3D 0;
+	}
 	return udcbdata.driver;
 }

diff --git a/userdiff.h b/userdiff.h
index 24419db697..83f5863d58 100644
=2D-- a/userdiff.h
+++ b/userdiff.h
@@ -21,6 +21,8 @@ struct userdiff_driver {
 	const char *textconv;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
+	int is_builtin;
+	int has_multi_byte_char_fallback;
 };
 enum userdiff_driver_type {
 	USERDIFF_DRIVER_TYPE_BUILTIN =3D 1<<0,
=2D-
2.40.0
