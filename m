From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH ] t4210-log-i18n: spell encoding name "UTF-8" correctly
Date: Mon, 25 Feb 2013 19:54:47 +0100
Message-ID: <512BB377.2010403@web.de>
References: <201302090052.22053.thom311@gmail.com> <7vsj56xsg5.fsf@alter.siamese.dyndns.org> <7vobfuxrns.fsf@alter.siamese.dyndns.org> <20130209002710.GA5570@sigill.intra.peff.net> <7vfw16xqvj.fsf@alter.siamese.dyndns.org> <7va9rexqii.fsf@alter.siamese.dyndns.org> <20130211191607.GA21269@sigill.intra.peff.net> <7v621ymxfv.fsf@alter.siamese.dyndns.org> <20130211205958.GA32740@sigill.intra.peff.net> <512B22DE.9070603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Haller <thom311@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:55:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3Cp-0001uI-J6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758947Ab3BYSyz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 13:54:55 -0500
Received: from mout.web.de ([212.227.15.4]:50420 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758108Ab3BYSyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:54:54 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MCZfe-1U0fGM1dMw-008xRU; Mon, 25 Feb 2013 19:54:49
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130216 Thunderbird/17.0.3
In-Reply-To: <512B22DE.9070603@viscovery.net>
X-Provags-ID: V02:K0:+Cgb8EL7z6fq1Yb/8ntdc3we2hT7Ls475XkLsuGIPDL
 cL7X/oV1vEybaxdAWFlhZRyqtPti9oEVOT3Q2yiX6T0PKs7n21
 W2/rAskXJe22IXNmvobtKdmzTqgdPW9wvxrWadEol1+u/bDyPY
 OrrDyO57FxdlxsZxhp6BDDmihrE0SXFHHgpzF0CFNiqnXs3M6/
 HEmo/yiFzVlvPp4Z5Lfcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217083>

On 25.02.13 09:37, Johannes Sixt wrote:
> From: Johannes Sixt <j6t@kdbg.org>
>=20
> iconv on Windows does not know the encoding name "utf8", and does not
> re-encode log messages when this name is given. Request "UTF-8" encod=
ing.
>=20
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I'm not sure whether I'm right to say that "UTF-8" is the correct
>  spelling. Anyway, 'iconv -l' on my old Linux box lists "UTF8", but o=
n
>  Windows it does not.
>=20
>  A more correct fix would probably be to use is_encoding_utf8() in mo=
re
>  places, but it's outside my time budget look after it.
>=20
>  -- Hannes
>=20
>  t/t4210-log-i18n.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> index 52a7472..b1956e2 100755
> --- a/t/t4210-log-i18n.sh
> +++ b/t/t4210-log-i18n.sh
> @@ -15,7 +15,7 @@ test_expect_success 'create commits in different en=
codings' '
>  	t${utf8_e}st
>  	EOF
>  	git add msg &&
> -	git -c i18n.commitencoding=3Dutf8 commit -F msg &&
> +	git -c i18n.commitencoding=3DUTF-8 commit -F msg &&
>  	cat >msg <<-EOF &&
>  	latin1
> =20
> @@ -30,7 +30,7 @@ test_expect_success 'log --grep searches in log out=
put encoding (utf8)' '
>  	latin1
>  	utf8
>  	EOF
> -	git log --encoding=3Dutf8 --format=3D%s --grep=3D$utf8_e >actual &&
> +	git log --encoding=3DUTF-8 --format=3D%s --grep=3D$utf8_e >actual &=
&
>  	test_cmp expect actual
>  '
> =20
> @@ -45,7 +45,7 @@ test_expect_success 'log --grep searches in log out=
put encoding (latin1)' '
> =20
>  test_expect_success 'log --grep does not find non-reencoded values (=
utf8)' '
>  	>expect &&
> -	git log --encoding=3Dutf8 --format=3D%s --grep=3D$latin1_e >actual =
&&
> +	git log --encoding=3DUTF-8 --format=3D%s --grep=3D$latin1_e >actual=
 &&
>  	test_cmp expect actual
>  '
> =20
>=20
Hej,
(beside that I couldn't find t4210 somewhere),
is it something like the following you are tinking of?

(Not sure if my cut-and-paste stuff applies, its's rather for review)

-- >8 --
[PATCH] iconv_open(): Use UTF-8 if UTF8 failes

When iconv_open() failes with EINVAL, it may be that "UTF-8"
is spelled wrong by mistake.
=46or example, "UTF8" is used instead of "UTF-8".
Some iconv implementations tolerate "UTF8" or "utf8".
If not, iconv_open() fails.
If is_encoding_utf8() is true change the string to the
offical string "UTF-8" with uppercase letters.

Reported-By: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 utf8.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/utf8.c b/utf8.c
index a4ee665..e9850d0 100644
--- a/utf8.c
+++ b/utf8.c
@@ -487,6 +487,10 @@ char *reencode_string(const char *in, const char *=
out_encoding, const char *in_e
 	if (!in_encoding)
 		return NULL;
 	conv =3D iconv_open(out_encoding, in_encoding);
+	if (conv =3D=3D (iconv_t) -1 && errno =3D=3D EINVAL) {
+		conv =3D iconv_open(is_encoding_utf8(out_encoding) ? "UTF-8" : out_e=
ncoding,
+											is_encoding_utf8(in_encoding) ? "UTF-8" : in_encoding);
+	}
 	if (conv =3D=3D (iconv_t) -1)
 		return NULL;
 	out =3D reencode_string_iconv(in, strlen(in), conv);
--=20
1.8.1.1
