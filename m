From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/13] wildmatch: follow Git's coding convention
Date: Mon, 15 Oct 2012 13:25:54 +0700
Message-ID: <1350282362-4505-5-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:27:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe8h-0007ar-1X
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab2JOG0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:26:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46603 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2JOG0r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:26:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4624959pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lrLyOnrAeKPS1agLq/zUrxvqxJB8KchNgQNQAL99BUE=;
        b=UJPV8DYlHmhizGKpJA5aCq/O2MSZAqnS0l9KKcT4gD0KiWq5LIo/wRMuslZ3QdIior
         q2sZ2ILt6CoEpFfQGCU6klVR3hhaADRAbGhRH819QlCWVoWJWcqkXYi65KDZWbttHGK3
         IStw8r+PvLIiuANRunnNgwwQ/7wZAgvNd+lcnFLEEZadcVsjaJk0uFr/kn2UgoHTNoXH
         1HGkOaoX+bejTZmkj1ITCiDPMf6xvzsnWFFNQFofeRFMo8N/BIrk7kWPDsp7T14mIyV9
         NyGnJE8ck06ugRq6+auXJTPotbMClVRTe3NmSFllSIw5dGRCZmOZLeSHNte4fUml1f/U
         3ohA==
Received: by 10.66.78.136 with SMTP id b8mr30416079pax.26.1350282407223;
        Sun, 14 Oct 2012 23:26:47 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id nx5sm8573802pbb.49.2012.10.14.23.26.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:26:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:26:37 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207703>

wildmatch's coding style is pretty close to Git's except the use of 4
space indentation instead of 8. This patch should produce empty diff
with "git diff -b"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 292 ++++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 146 insertions(+), 146 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index fae7397..4653dd6 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -58,167 +58,167 @@ static int force_lower_case =3D 0;
 /* Match pattern "p" against "text" */
 static int dowild(const uchar *p, const uchar *text)
 {
-    uchar p_ch;
+	uchar p_ch;
=20
-    for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
-	int matched, special;
-	uchar t_ch, prev_ch;
-	if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
-		return ABORT_ALL;
-	if (force_lower_case && ISUPPER(t_ch))
-	    t_ch =3D tolower(t_ch);
-	switch (p_ch) {
-	  case '\\':
-	    /* Literal match with following character.  Note that the test
-	     * in "default" handles the p[1] =3D=3D '\0' failure case. */
-	    p_ch =3D *++p;
-	    /* FALLTHROUGH */
-	  default:
-	    if (t_ch !=3D p_ch)
-		return FALSE;
-	    continue;
-	  case '?':
-	    /* Match anything but '/'. */
-	    if (t_ch =3D=3D '/')
-		return FALSE;
-	    continue;
-	  case '*':
-	    if (*++p =3D=3D '*') {
-		while (*++p =3D=3D '*') {}
-		special =3D TRUE;
-	    } else
-		special =3D FALSE;
-	    if (*p =3D=3D '\0') {
-		/* Trailing "**" matches everything.  Trailing "*" matches
-		 * only if there are no more slash characters. */
-		if (!special) {
-			if (strchr((char*)text, '/') !=3D NULL)
-			    return FALSE;
-		}
-		return TRUE;
-	    }
-	    while (1) {
-		if (t_ch =3D=3D '\0')
-		    break;
-		if ((matched =3D dowild(p, text)) !=3D FALSE) {
-		    if (!special || matched !=3D ABORT_TO_STARSTAR)
-			return matched;
-		} else if (!special && t_ch =3D=3D '/')
-		    return ABORT_TO_STARSTAR;
-		t_ch =3D *++text;
-	    }
-	    return ABORT_ALL;
-	  case '[':
-	    p_ch =3D *++p;
-#ifdef NEGATE_CLASS2
-	    if (p_ch =3D=3D NEGATE_CLASS2)
-		p_ch =3D NEGATE_CLASS;
-#endif
-	    /* Assign literal TRUE/FALSE because of "matched" comparison. */
-	    special =3D p_ch =3D=3D NEGATE_CLASS? TRUE : FALSE;
-	    if (special) {
-		/* Inverted character class. */
-		p_ch =3D *++p;
-	    }
-	    prev_ch =3D 0;
-	    matched =3D FALSE;
-	    do {
-		if (!p_ch)
-		    return ABORT_ALL;
-		if (p_ch =3D=3D '\\') {
-		    p_ch =3D *++p;
-		    if (!p_ch)
+	for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
+		int matched, special;
+		uchar t_ch, prev_ch;
+		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
 			return ABORT_ALL;
-		    if (t_ch =3D=3D p_ch)
-			matched =3D TRUE;
-		} else if (p_ch =3D=3D '-' && prev_ch && p[1] && p[1] !=3D ']') {
-		    p_ch =3D *++p;
-		    if (p_ch =3D=3D '\\') {
+		if (force_lower_case && ISUPPER(t_ch))
+			t_ch =3D tolower(t_ch);
+		switch (p_ch) {
+		case '\\':
+			/* Literal match with following character.  Note that the test
+			 * in "default" handles the p[1] =3D=3D '\0' failure case. */
 			p_ch =3D *++p;
-			if (!p_ch)
-			    return ABORT_ALL;
-		    }
-		    if (t_ch <=3D p_ch && t_ch >=3D prev_ch)
-			matched =3D TRUE;
-		    p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
-		} else if (p_ch =3D=3D '[' && p[1] =3D=3D ':') {
-		    const uchar *s;
-		    int i;
-		    for (s =3D p +=3D 2; (p_ch =3D *p) && p_ch !=3D ']'; p++) {} /*S=
HARED ITERATOR*/
-		    if (!p_ch)
-			return ABORT_ALL;
-		    i =3D p - s - 1;
-		    if (i < 0 || p[-1] !=3D ':') {
-			/* Didn't find ":]", so treat like a normal set. */
-			p =3D s - 2;
-			p_ch =3D '[';
-			if (t_ch =3D=3D p_ch)
-			    matched =3D TRUE;
+			/* FALLTHROUGH */
+		default:
+			if (t_ch !=3D p_ch)
+				return FALSE;
+			continue;
+		case '?':
+			/* Match anything but '/'. */
+			if (t_ch =3D=3D '/')
+				return FALSE;
 			continue;
-		    }
-		    if (CC_EQ(s,i, "alnum")) {
-			if (ISALNUM(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "alpha")) {
-			if (ISALPHA(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "blank")) {
-			if (ISBLANK(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "cntrl")) {
-			if (ISCNTRL(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "digit")) {
-			if (ISDIGIT(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "graph")) {
-			if (ISGRAPH(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "lower")) {
-			if (ISLOWER(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "print")) {
-			if (ISPRINT(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "punct")) {
-			if (ISPUNCT(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "space")) {
-			if (ISSPACE(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "upper")) {
-			if (ISUPPER(t_ch))
-			    matched =3D TRUE;
-		    } else if (CC_EQ(s,i, "xdigit")) {
-			if (ISXDIGIT(t_ch))
-			    matched =3D TRUE;
-		    } else /* malformed [:class:] string */
+		case '*':
+			if (*++p =3D=3D '*') {
+				while (*++p =3D=3D '*') {}
+				special =3D TRUE;
+			} else
+				special =3D FALSE;
+			if (*p =3D=3D '\0') {
+				/* Trailing "**" matches everything.  Trailing "*" matches
+				 * only if there are no more slash characters. */
+				if (!special) {
+					if (strchr((char*)text, '/') !=3D NULL)
+						return FALSE;
+				}
+				return TRUE;
+			}
+			while (1) {
+				if (t_ch =3D=3D '\0')
+					break;
+				if ((matched =3D dowild(p, text)) !=3D FALSE) {
+					if (!special || matched !=3D ABORT_TO_STARSTAR)
+						return matched;
+				} else if (!special && t_ch =3D=3D '/')
+					return ABORT_TO_STARSTAR;
+				t_ch =3D *++text;
+			}
 			return ABORT_ALL;
-		    p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
-		} else if (t_ch =3D=3D p_ch)
-		    matched =3D TRUE;
-	    } while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
-	    if (matched =3D=3D special || t_ch =3D=3D '/')
-		return FALSE;
-	    continue;
+		case '[':
+			p_ch =3D *++p;
+#ifdef NEGATE_CLASS2
+			if (p_ch =3D=3D NEGATE_CLASS2)
+				p_ch =3D NEGATE_CLASS;
+#endif
+			/* Assign literal TRUE/FALSE because of "matched" comparison. */
+			special =3D p_ch =3D=3D NEGATE_CLASS? TRUE : FALSE;
+			if (special) {
+				/* Inverted character class. */
+				p_ch =3D *++p;
+			}
+			prev_ch =3D 0;
+			matched =3D FALSE;
+			do {
+				if (!p_ch)
+					return ABORT_ALL;
+				if (p_ch =3D=3D '\\') {
+					p_ch =3D *++p;
+					if (!p_ch)
+						return ABORT_ALL;
+					if (t_ch =3D=3D p_ch)
+						matched =3D TRUE;
+				} else if (p_ch =3D=3D '-' && prev_ch && p[1] && p[1] !=3D ']') {
+					p_ch =3D *++p;
+					if (p_ch =3D=3D '\\') {
+						p_ch =3D *++p;
+						if (!p_ch)
+							return ABORT_ALL;
+					}
+					if (t_ch <=3D p_ch && t_ch >=3D prev_ch)
+						matched =3D TRUE;
+					p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
+				} else if (p_ch =3D=3D '[' && p[1] =3D=3D ':') {
+					const uchar *s;
+					int i;
+					for (s =3D p +=3D 2; (p_ch =3D *p) && p_ch !=3D ']'; p++) {} /*SH=
ARED ITERATOR*/
+					if (!p_ch)
+						return ABORT_ALL;
+					i =3D p - s - 1;
+					if (i < 0 || p[-1] !=3D ':') {
+						/* Didn't find ":]", so treat like a normal set. */
+						p =3D s - 2;
+						p_ch =3D '[';
+						if (t_ch =3D=3D p_ch)
+							matched =3D TRUE;
+						continue;
+					}
+					if (CC_EQ(s,i, "alnum")) {
+						if (ISALNUM(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "alpha")) {
+						if (ISALPHA(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "blank")) {
+						if (ISBLANK(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "cntrl")) {
+						if (ISCNTRL(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "digit")) {
+						if (ISDIGIT(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "graph")) {
+						if (ISGRAPH(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "lower")) {
+						if (ISLOWER(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "print")) {
+						if (ISPRINT(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "punct")) {
+						if (ISPUNCT(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "space")) {
+						if (ISSPACE(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "upper")) {
+						if (ISUPPER(t_ch))
+							matched =3D TRUE;
+					} else if (CC_EQ(s,i, "xdigit")) {
+						if (ISXDIGIT(t_ch))
+							matched =3D TRUE;
+					} else /* malformed [:class:] string */
+						return ABORT_ALL;
+					p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
+				} else if (t_ch =3D=3D p_ch)
+					matched =3D TRUE;
+			} while (prev_ch =3D p_ch, (p_ch =3D *++p) !=3D ']');
+			if (matched =3D=3D special || t_ch =3D=3D '/')
+				return FALSE;
+			continue;
+		}
 	}
-    }
=20
-    return *text ? FALSE : TRUE;
+	return *text ? FALSE : TRUE;
 }
=20
 /* Match the "pattern" against the "text" string. */
 int wildmatch(const char *pattern, const char *text)
 {
-    return dowild((const uchar*)pattern, (const uchar*)text) =3D=3D TR=
UE;
+	return dowild((const uchar*)pattern, (const uchar*)text) =3D=3D TRUE;
 }
=20
 /* Match the "pattern" against the forced-to-lower-case "text" string.=
 */
 int iwildmatch(const char *pattern, const char *text)
 {
-    int ret;
-    force_lower_case =3D 1;
-    ret =3D dowild((const uchar*)pattern, (const uchar*)text) =3D=3D T=
RUE;
-    force_lower_case =3D 0;
-    return ret;
+	int ret;
+	force_lower_case =3D 1;
+	ret =3D dowild((const uchar*)pattern, (const uchar*)text) =3D=3D TRUE=
;
+	force_lower_case =3D 0;
+	return ret;
 }
--=20
1.8.0.rc0.29.g1fdd78f
