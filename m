From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] War on nbsp: Add "nbsp" whitespace breakage class
Date: Fri, 27 May 2011 15:51:10 -0700
Message-ID: <7vfwnzrc4h.fsf_-_@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Sat May 28 00:51:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ5sL-0005dz-4R
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 00:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab1E0WvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2011 18:51:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab1E0WvU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 18:51:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F6505B06;
	Fri, 27 May 2011 18:53:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Aq5aom81ApVt
	E9kHZlM8hW79Zsw=; b=JGIbyfbyjLJ8y3UG67JhX8P0cZscyKK/dxlhUoEW4XqT
	RJZ3owCvc7UWs6LZLcQDO1Rm2jc0HCcYMWRF5fvxYE0SmJU8H6qg/zS6YJ+ZYEee
	nSM5MHBcFT8tCUdaZTcIEVSylrY4957Cl/xLACKX64bQevQ005yMP8YWzVZIe+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=L5B4M+
	B91ewK8Gkf/KsquDKy4URQaYwc10u0mKQ2yCEuVYwhbx93l2vkQqCJ7bv+ScMfpD
	khsonFw0VCzEoH62okJPCYGVWdHBiNjO+5QUJxGqM+RMWZQ2pi0ojWTc8WacHs/a
	xWKom0JbozHS9e7uz5Xpbs8h0eUQtesH9dFSA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D2C5A5B05;
	Fri, 27 May 2011 18:53:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5542D5B01; Fri, 27 May 2011
 18:53:18 -0400 (EDT)
In-Reply-To: <7vy61rrcae.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 27 May 2011 15:47:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FA76DA2-88B4-11E0-A186-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174653>

Not even "less" shows nbsp as anything special nor unusual, so eyeballi=
ng
with "git log -p" after applying a patch that accidentally had it where=
 a
regular SP should be, breaking compilation, would not help.

This only handles "diff", not "apply" yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is the moral equivalent of the earlier patch, but based on the =
two
   clean-ups.  If we do not consider nbsp an error, at least we should
   count it just like an ordinary SP that takes one display column, and=
 if
   we do not like indenting with non-TAB or trailing whitespaces, we
   should complain loudly, which was the topic of 2/3.

 cache.h                 |   18 ++++++-----
 t/t4019-diff-wserror.sh |    8 ++--
 ws.c                    |   72 +++++++++++++++++++++++++++++++++++++++=
+++----
 3 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index dd34fed..4f58587 100644
--- a/cache.h
+++ b/cache.h
@@ -1122,17 +1122,19 @@ void shift_tree_by(const unsigned char *, const=
 unsigned char *, unsigned char *
 /*
  * whitespace rules.
  * used by both diff and apply
- * last two digits are tab width
+ * last 6-bits are tab width
  */
-#define WS_BLANK_AT_EOL         0100
-#define WS_SPACE_BEFORE_TAB     0200
-#define WS_INDENT_WITH_NON_TAB  0400
-#define WS_CR_AT_EOL           01000
-#define WS_BLANK_AT_EOF        02000
-#define WS_TAB_IN_INDENT       04000
+#define WS_TAB_WIDTH_MASK       077
+#define WS_BLANK_AT_EOL         (1<< 6)
+#define WS_SPACE_BEFORE_TAB     (1<< 7)
+#define WS_INDENT_WITH_NON_TAB  (1<< 8)
+#define WS_CR_AT_EOL            (1<< 9)
+#define WS_BLANK_AT_EOF         (1<<10)
+#define WS_TAB_IN_INDENT        (1<<11)
+#define WS_NBSP                 (1<<12)
 #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
-#define WS_TAB_WIDTH_MASK        077
+
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index 665f693..8c7fea2 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -56,7 +56,7 @@ test_expect_success default '
 	grep End error >/dev/null
 '
=20
-test_expect_success 'default (attribute)' '
+test_expect_success 'default (attribute) -- must check all available r=
ule' '
=20
 	test_might_fail git config --unset core.whitespace &&
 	echo "F whitespace" >.gitattributes &&
@@ -68,7 +68,7 @@ test_expect_success 'default (attribute)' '
 	grep Return error >/dev/null &&
 	grep No normal >/dev/null &&
 	grep Enough error >/dev/null &&
-	grep Bit normal >/dev/null &&
+	grep Bit error >/dev/null &&
 	grep End error >/dev/null
 '
=20
@@ -83,8 +83,8 @@ test_expect_success 'default, tabwidth=3D10 (attribut=
e)' '
 	grep With error >/dev/null &&
 	grep Return error >/dev/null &&
 	grep No normal >/dev/null &&
-	grep Enough normal >/dev/null &&
-	grep Bit normal >/dev/null &&
+	grep Enough error >/dev/null &&
+	grep Bit error >/dev/null &&
 	grep End error >/dev/null
 '
=20
diff --git a/ws.c b/ws.c
index 68c7599..53e263d 100644
--- a/ws.c
+++ b/ws.c
@@ -20,6 +20,7 @@ static struct whitespace_rule {
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
+	{ "nbsp", WS_NBSP, 0, 0 },
 };
=20
 unsigned parse_whitespace_rule(const char *string)
@@ -141,6 +142,8 @@ char *whitespace_error_string(unsigned ws)
 		add_err_item(&err, "indent with spaces");
 	if (ws & WS_TAB_IN_INDENT)
 		add_err_item(&err, "tab in indent");
+	if (ws & WS_NBSP)
+		add_err_item(&err, "&nbsp; in source");
 	return strbuf_detach(&err, NULL);
 }
=20
@@ -150,6 +153,45 @@ static int is_nbsp(const char *at_)
 	return at[0] =3D=3D 0xc2 && at[1] =3D=3D 0xa0;
 }
=20
+/*
+ * Show line while highlighting nbsp "=C2=A0" (c2a0) if ws is set
+ */
+static void emit_with_nbsp_hilite(FILE *stream,
+				  const char *set, const char *reset,
+				  const char *ws,
+				  const char *line, int len)
+{
+	if (!len)
+		return;
+	while (len) {
+		/* number of bytes in the leading segment w/o nbsp error */
+		int ok;
+		if (!ws) {
+			ok =3D len;
+		} else {
+			for (ok =3D 0; ok < len; ok++) {
+				if (ok < len - 1 && is_nbsp(line + ok))
+					break;
+			}
+		}
+		if (ok) {
+			fputs(set, stream);
+			fwrite(line, ok, 1, stream);
+			fputs(reset, stream);
+		}
+		line +=3D ok;
+		len -=3D ok;
+		if (len) {
+			/* do not bother bundling consecutive ones */
+			fputs(ws, stream);
+			fwrite(line, 2, 1, stream);
+			fputs(reset, stream);
+			line +=3D 2;
+			len -=3D 2;
+		}
+	}
+}
+
 /* If stream is non-NULL, emits the line after checking. */
 static unsigned ws_check_emit_1(const char *line, int len, unsigned ws=
_rule,
 				FILE *stream, const char *set,
@@ -173,6 +215,24 @@ static unsigned ws_check_emit_1(const char *line, =
int len, unsigned ws_rule,
 		len--;
 	}
=20
+	/* Check for nbsp in UTF-8 (c2a0) */
+	if (ws_rule & WS_NBSP) {
+		for (i =3D 1; i < len; i++) {
+			switch (line[i] & 0xff) {
+			case 0xc2:
+				break;
+			case 0xa0:
+				if ((line[i-1] & 0xff) =3D=3D 0xc2) {
+					result |=3D WS_NBSP;
+					continue;
+				}
+				/* fallthru */
+			default:
+				i++;
+			}
+		}
+	}
+
 	/* Check for trailing whitespace. */
 	if (ws_rule & WS_BLANK_AT_EOL) {
 		for (i =3D len - 1; i >=3D 0; i--) {
@@ -245,13 +305,11 @@ static unsigned ws_check_emit_1(const char *line,=
 int len, unsigned ws_rule,
 		 * The non-highlighted part ends at "trailing_whitespace".
 		 */
=20
-		/* Emit non-highlighted (middle) segment. */
-		if (trailing_whitespace - written > 0) {
-			fputs(set, stream);
-			fwrite(line + written,
-			    trailing_whitespace - written, 1, stream);
-			fputs(reset, stream);
-		}
+		/* Emit middle segment, highlighting nbsp as needed */
+		emit_with_nbsp_hilite(stream, set, reset,
+				      (result & WS_NBSP) ? ws : NULL,
+				      line + written,
+				      trailing_whitespace - written);
=20
 		/* Highlight errors in trailing whitespace. */
 		if (trailing_whitespace !=3D len) {
--=20
1.7.5.3.503.g893a4
