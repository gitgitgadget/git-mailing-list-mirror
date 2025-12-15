Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E2313273
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831535; cv=none; b=NL5t1qA+DHx66Izfe9/sgLefU5RGecR/oRI6BH8EZL8Y49/VolKszK7kkADK1xCv6pnAcJSSxD/jyjAjQ+f6wMnZWaSztTOFLrIuchXEs6f7l2BZml3YSoLTEa5vssX1ov1+VIPHP1zHzqDJeMku+Wsz/V0HEz1e9EawEZrVq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831535; c=relaxed/simple;
	bh=sFpkTPF+NMUYKHYp8JOb9G6pDaYcCmVLsufEU0PMv2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JTNjTdvWX+F7kqLXdVQGDdIssGF66AjerfIFohsqd80VKk1tsafajNosStZPSSOtjVnT3uKACbOSVYN1Tuj3n7Kg/GIa8vQNcAG4i8aNy2olIhAviw5CURDOqZz4K1COR5SPI6pmxUDFDtgD0IzOtMyaCJleijy19t9je2pOWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=DuJJXODC; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="DuJJXODC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765831525; x=1766436325; i=tboegi@web.de;
	bh=LEGtvqrbxzzOdvO2dZlf04IbxeaS9NUHQILENNpt8J0=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DuJJXODC4xhQvM6BMlq5ALmJVIRLln9FBFXtPSwSnPgCyo2mBwa5lP5IdlF5NwVa
	 Mx5Fl+QUZEQf/K6w4vNcptm4FINM7BqO3z277KqcMwy1GxsnDlPgbp1uQZysEasuI
	 ODtgHw7sQkgjWtjvPDNYyneJqSgyG4C6T++3edYTO3zTaF7DvZFdiB9WLPKzZcmuJ
	 PfayIe+1QaJNQASLX0ZUeXN5N+4twx85Ldr+yl3MDFxU1Ogz0QSxjbIi8e4j8710N
	 wNIjwoEOqYxv2lk/W2njoZnF2/nKERpnDviJDo0UK1aIsrSfy3PJXPaQidxQmkaEH
	 qtyEd9jNbS4g8HfV/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5Ug4-1w2otL2ncI-013NGa; Mon, 15
 Dec 2025 21:45:25 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v0 3/3] config.mak.uname: Activate ICONV_RESTART_RESET if needed
Date: Mon, 15 Dec 2025 21:45:24 +0100
Message-ID: <20251215204524.1946518-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LezjmzFGtlHpSQ8QSgBn1eTts+yLK89eZn7Q/UXmv9xuekk+EEz
 nDRdvtHerSjN7ObDJCagEOt3IK4Rs7V91mHn4m/w27foAiZZc9h2RtJmsHmcyU+U2vxg5u4
 yUIOzGqAQ8oJLRecYsnE7ARZip6xKZPWqeBm1Z4xpKnhUxs4Fst+8RImStoDSZlExrg9LDo
 8CX+1ghIVLRtD/VaRxk1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g4HtDikwcRM=;7u7RdcLFMP5f7FVeIuC+f+oRKjy
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

utf8.c needs a tweak when calling the iconv library shipped with later
macOS versions (14,15):
'#define ICONV_RESTART_RESET' is needed, or
'BASIC_CFLAGS +=3D -DICONV_RESTART_RESET' in Makefile language.

The tweak is not needed when Git is linked against iconv from
Fink or MacPorts or homebrew.
Neither when Git is compiled under older macOS versions.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 config.mak.uname | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 44252dabcc..b76a51e22b 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -174,9 +174,11 @@ ifeq ($(uname_S),Darwin)
=20
         ifeq ($(shell test -d /usr/local/opt/libiconv/ && echo y),y)
 		HOMEBREW_ICONVDIR =3D /usr/local/opt/libiconv
+		HAS_GOOD_ICONV =3D Yes
         endif
         ifeq ($(shell test -d /opt/homebrew/opt/libiconv/ && echo y),y)
 		HOMEBREW_ICONVDIR =3D /opt/homebrew/opt/libiconv
+		HAS_GOOD_ICONV =3D Yes
         endif
=20
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
@@ -193,12 +195,14 @@ ifeq ($(uname_S),Darwin)
 		ifeq ($(shell test -d /sw/lib && echo y),y)
 			BASIC_CFLAGS +=3D -I/sw/include
 			BASIC_LDFLAGS +=3D -L/sw/lib
+			HAS_GOOD_ICONV =3D Yes
 		endif
 	endif
 	ifndef NO_DARWIN_PORTS
 		ifeq ($(shell test -d /opt/local/lib && echo y),y)
 			BASIC_CFLAGS +=3D -I/opt/local/include
 			BASIC_LDFLAGS +=3D -L/opt/local/lib
+			HAS_GOOD_ICONV =3D Yes
 		endif
 	endif
 	ifndef NO_APPLE_COMMON_CRYPTO
@@ -206,6 +210,12 @@ ifeq ($(uname_S),Darwin)
 		APPLE_COMMON_CRYPTO =3D YesPlease
 		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
 	endif
+	ifndef HAS_GOOD_ICONV
+		ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 20 &=
& echo 1),1)
+		# utf8.c needs a tweak when using iconv from os
+			BASIC_CFLAGS +=3D -DICONV_RESTART_RESET
+		endif
+	endif
 	PTHREAD_LIBS =3D
 endif
 ifeq ($(uname_S),SunOS)
=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

