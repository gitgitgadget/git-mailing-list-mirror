From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] War on nbsp: a bit of retreat
Date: Fri, 27 May 2011 15:49:15 -0700
Message-ID: <7vmxi7rc7o.fsf_-_@alter.siamese.dyndns.org>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
 <7vzkm9unu0.fsf@alter.siamese.dyndns.org>
 <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
 <m262owhyuy.fsf@igel.home>
 <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com>
 <7vipswro57.fsf@alter.siamese.dyndns.org>
 <7vboyorm4i.fsf@alter.siamese.dyndns.org>
 <BANLkTinwOr5Yzp_N6BNyNK5Y1FcVtdtbUw@mail.gmail.com>
 <7vy61rrcae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:49:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ5qU-0004qZ-Ea
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 00:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301Ab1E0WtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2011 18:49:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259Ab1E0WtZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 18:49:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 128BC5AA9;
	Fri, 27 May 2011 18:51:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T7V0tNKHYaGj
	Bd4vUhInUKslRe8=; b=k8TGU/yVZcRwb0DSa1iSNJ1Dv/GtunGbIver/CwU1zZV
	pJy2CRYYsadkPjb9FEK6ydu6ws8wCEVVR5fxyCAkm3mUmkMMsCZAruqJgle3jtpo
	Tuvk5B4ttZ4wqw2eQQvub/R4zfE0rFEnuWKV4M9ntfkDKUPVEY4On7Pcr4U9vTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YSbsrO
	8FGF/IrgHmiZluBmvslYcHqP+8+0ZjsesPHso0+Z/UktyCgtD7UXMf+ywHqs1D9i
	fUsd0dIkGarDb1oVR2VFXVzJeWLR7Y71Pnzm0G0sbbulYX6B0B5prnENP4R6KRgo
	Cfo++ZmRhpJp3jDqUjuzQl6/zVKXThFT1yBVk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D643C5AA8;
	Fri, 27 May 2011 18:51:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4CADD5AA4; Fri, 27 May 2011
 18:51:23 -0400 (EDT)
In-Reply-To: <7vy61rrcae.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 27 May 2011 15:47:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB1DB7EA-88B3-11E0-91A7-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174652>

Before introducing a new whitespace breakage class "nbsp" to catch
compiler-breaking use of nbsp (UTF-8 c2a0) in place of SP, update the
current code to treat a nbsp just like SP that takes one display column=
=2E

Indenting with 6 nbsp is not an error under the indent-with-non-tab rul=
e,
as it only consumes 6 display columns even though it may occupy 12 byte=
s.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4019-diff-wserror.sh |   93 ++++++++++++++++++++++++++++++++-------=
--------
 ws.c                    |   38 ++++++++++++++++----
 2 files changed, 94 insertions(+), 37 deletions(-)

diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index a501975..665f693 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -14,6 +14,9 @@ test_expect_success setup '
 	echo "With trailing SP " >>F &&
 	echo "Carriage ReturnQ" | tr Q "\015" >>F &&
 	echo "No problem" >>F &&
+	echo "=C2=A0       Enough NBSP and Space" >>F &&
+	echo "=C2=A0=C2=A0=C2=A0=C2=A0  Bit of NBSP and Space" >>F &&
+	echo "NBSP At End=C2=A0=C2=A0" >>F &&
 	echo >>F
=20
 '
@@ -47,8 +50,10 @@ test_expect_success default '
 	grep HT error >/dev/null &&
 	grep With error >/dev/null &&
 	grep Return error >/dev/null &&
-	grep No normal >/dev/null
-
+	grep Enough normal >/dev/null &&
+	grep No normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End error >/dev/null
 '
=20
 test_expect_success 'default (attribute)' '
@@ -61,8 +66,10 @@ test_expect_success 'default (attribute)' '
 	grep HT error >/dev/null &&
 	grep With error >/dev/null &&
 	grep Return error >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough error >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End error >/dev/null
 '
=20
 test_expect_success 'default, tabwidth=3D10 (attribute)' '
@@ -75,8 +82,10 @@ test_expect_success 'default, tabwidth=3D10 (attribu=
te)' '
 	grep HT error >/dev/null &&
 	grep With error >/dev/null &&
 	grep Return error >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End error >/dev/null
 '
=20
 test_expect_success 'no check (attribute)' '
@@ -89,8 +98,10 @@ test_expect_success 'no check (attribute)' '
 	grep HT normal >/dev/null &&
 	grep With normal >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End normal >/dev/null
 '
=20
 test_expect_success 'no check, tabwidth=3D10 (attribute), must be irre=
levant' '
@@ -103,8 +114,10 @@ test_expect_success 'no check, tabwidth=3D10 (attr=
ibute), must be irrelevant' '
 	grep HT normal >/dev/null &&
 	grep With normal >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End normal >/dev/null
 '
=20
 test_expect_success 'without -trail' '
@@ -117,8 +130,10 @@ test_expect_success 'without -trail' '
 	grep HT error >/dev/null &&
 	grep With normal >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End normal >/dev/null
 '
=20
 test_expect_success 'without -trail (attribute)' '
@@ -131,8 +146,10 @@ test_expect_success 'without -trail (attribute)' '
 	grep HT error >/dev/null &&
 	grep With normal >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End normal >/dev/null
 '
=20
 test_expect_success 'without -space' '
@@ -145,8 +162,10 @@ test_expect_success 'without -space' '
 	grep HT normal >/dev/null &&
 	grep With error >/dev/null &&
 	grep Return error >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End error >/dev/null
 '
=20
 test_expect_success 'without -space (attribute)' '
@@ -159,8 +178,10 @@ test_expect_success 'without -space (attribute)' '
 	grep HT normal >/dev/null &&
 	grep With error >/dev/null &&
 	grep Return error >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End error >/dev/null
 '
=20
 test_expect_success 'with indent-non-tab only' '
@@ -173,8 +194,10 @@ test_expect_success 'with indent-non-tab only' '
 	grep HT normal >/dev/null &&
 	grep With normal >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough error >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End normal >/dev/null
 '
=20
 test_expect_success 'with indent-non-tab only (attribute)' '
@@ -187,8 +210,10 @@ test_expect_success 'with indent-non-tab only (att=
ribute)' '
 	grep HT normal >/dev/null &&
 	grep With normal >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough error >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End normal >/dev/null
 '
=20
 test_expect_success 'with indent-non-tab only, tabwidth=3D10' '
@@ -201,8 +226,10 @@ test_expect_success 'with indent-non-tab only, tab=
width=3D10' '
 	grep HT normal >/dev/null &&
 	grep With normal >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End normal >/dev/null
 '
=20
 test_expect_success 'with indent-non-tab only, tabwidth=3D10 (attribut=
e)' '
@@ -215,8 +242,10 @@ test_expect_success 'with indent-non-tab only, tab=
width=3D10 (attribute)' '
 	grep HT normal >/dev/null &&
 	grep With normal >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End normal >/dev/null
 '
=20
 test_expect_success 'with cr-at-eol' '
@@ -229,8 +258,10 @@ test_expect_success 'with cr-at-eol' '
 	grep HT error >/dev/null &&
 	grep With error >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End error >/dev/null
 '
=20
 test_expect_success 'with cr-at-eol (attribute)' '
@@ -243,8 +274,10 @@ test_expect_success 'with cr-at-eol (attribute)' '
 	grep HT error >/dev/null &&
 	grep With error >/dev/null &&
 	grep Return normal >/dev/null &&
-	grep No normal >/dev/null
-
+	grep No normal >/dev/null &&
+	grep Enough normal >/dev/null &&
+	grep Bit normal >/dev/null &&
+	grep End error >/dev/null
 '
=20
 test_expect_success 'trailing empty lines (1)' '
diff --git a/ws.c b/ws.c
index 3058be4..68c7599 100644
--- a/ws.c
+++ b/ws.c
@@ -144,6 +144,12 @@ char *whitespace_error_string(unsigned ws)
 	return strbuf_detach(&err, NULL);
 }
=20
+static int is_nbsp(const char *at_)
+{
+	unsigned const char *at =3D (unsigned const char *)at_;
+	return at[0] =3D=3D 0xc2 && at[1] =3D=3D 0xa0;
+}
+
 /* If stream is non-NULL, emits the line after checking. */
 static unsigned ws_check_emit_1(const char *line, int len, unsigned ws=
_rule,
 				FILE *stream, const char *set,
@@ -154,7 +160,7 @@ static unsigned ws_check_emit_1(const char *line, i=
nt len, unsigned ws_rule,
 	int trailing_whitespace =3D -1;
 	int trailing_newline =3D 0;
 	int trailing_carriage_return =3D 0;
-	int i;
+	int i, col_offset;
=20
 	/* Logic is simpler if we temporarily ignore the trailing newline. */
 	if (len > 0 && line[len - 1] =3D=3D '\n') {
@@ -170,11 +176,16 @@ static unsigned ws_check_emit_1(const char *line,=
 int len, unsigned ws_rule,
 	/* Check for trailing whitespace. */
 	if (ws_rule & WS_BLANK_AT_EOL) {
 		for (i =3D len - 1; i >=3D 0; i--) {
-			if (isspace(line[i])) {
+			int is_space =3D isspace(line[i]);
+
+			if (!is_space && i && is_nbsp(&line[i-1])) {
+				is_space =3D 1;
+				i--;
+			}
+			if (is_space) {
 				trailing_whitespace =3D i;
 				result |=3D WS_BLANK_AT_EOL;
-			}
-			else
+			} else
 				break;
 		}
 	}
@@ -183,9 +194,14 @@ static unsigned ws_check_emit_1(const char *line, =
int len, unsigned ws_rule,
 		trailing_whitespace =3D len;
=20
 	/* Check indentation */
-	for (i =3D 0; i < trailing_whitespace; i++) {
+	for (i =3D col_offset =3D 0; i < trailing_whitespace; i++) {
 		if (line[i] =3D=3D ' ')
 			continue;
+		if (i + 1 < trailing_whitespace && is_nbsp(&line[i])) {
+			i++;
+			col_offset++;
+			continue;
+		}
 		if (line[i] !=3D '\t')
 			break;
 		if ((ws_rule & WS_SPACE_BEFORE_TAB) && written < i) {
@@ -208,10 +224,12 @@ static unsigned ws_check_emit_1(const char *line,=
 int len, unsigned ws_rule,
 			fwrite(line + written, i - written + 1, 1, stream);
 		}
 		written =3D i + 1;
+		col_offset =3D 0;
 	}
=20
 	/* Check for indent using non-tab. */
-	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && i - written >=3D ws_tab_wid=
th(ws_rule)) {
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
+	    i - written - col_offset >=3D ws_tab_width(ws_rule)) {
 		result |=3D WS_INDENT_WITH_NON_TAB;
 		if (stream) {
 			fputs(ws, stream);
@@ -270,7 +288,13 @@ int ws_blank_line(const char *line, int len, unsig=
ned ws_rule)
 	 * for now we just use this stupid definition.
 	 */
 	while (len-- > 0) {
-		if (!isspace(*line))
+		if (isspace(*line))
+			;
+		else if (len && is_nbsp(line)) {
+			line++;
+			len--;
+		}
+		else
 			return 0;
 		line++;
 	}
--=20
1.7.5.3.503.g893a4
