Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A930E856
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831533; cv=none; b=mdneMtbC0MR9+C4Upbd4hjjvUJ1XXW//LAZKdiy2fZaa3T9ViXrr/e54FHSQc9DTIQmfQTlow25Dr4Z/IUjoXhVd4DaeuItkaNUjJbJori0BRvNaTn045YyuzCNeoasYvsPLl96d6JqN9z8GcAtXu/A50oLS2/pGA58IgHRydGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831533; c=relaxed/simple;
	bh=+Er3bGfVVwBwzqTpkEWcKplabR0hbgf3zUo1pXPYAMk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kpKkoAAHmuYlv7L+dNyHZdiEOreu/+JCaDNJej9j2BmyuBv3KwUYZ3lbVo1xLpuwHYG529v+IiCP2uv6hY7AROVUVfQsFYBkgrRvZ8lDonOp70v62XngU5r8T6gbNdIANNF72lox/Hd2Mu4i+Hb5Cs0/UNGrCnPy6cNQWt9O7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=exLV0+cJ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="exLV0+cJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765831524; x=1766436324; i=tboegi@web.de;
	bh=DQwAvvpiz2w9CLTNsA3sUkvbhgxMw/lkjwEHa3fprvI=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=exLV0+cJpH7rHZf08rZQlDxQ8q9MTqSTHN5qaFII8DgAkMkN4PoQn9xy+5ZdjeZ/
	 0YchmSq9cwy/MeJ18103l6U7w8jBn4kQ4sMjQmtjrhFoyfxDr6gVd2dnnx3kgvdVl
	 Z01fY8NCDTj8RsexMTGh8FOQl9rnOvviMymHpuOqB/KP92w5o7VNeCtCJRI/tsRvQ
	 iCTRJuvFmImk1/Si/kMhVptokQIUBO+a8NroAE88Qk0n6nrYNNnp37x1LAmFEfo42
	 mhHra6ydV4MKB764kdaOX/2J390z9DH7tVmlZNY3OG9Fmr1liPHsce4gf6qWAjwsR
	 4wLfX6JSUR+RiJEj1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1vzXdC0b9i-00yOGz; Mon, 15
 Dec 2025 21:45:24 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v0 2/3] Makefile: Make all darwin into config.mak.uname
Date: Mon, 15 Dec 2025 21:45:22 +0100
Message-ID: <20251215204522.1946504-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gqx8zAJmwL2kCDuB/XHe7O+GWoHb36MkVzAV+QMeeti1gXOplch
 wXL0eiBFh3yQ2y0OKAz+PsWPMqBR/o6+J4wrH9MnwOsK9FsKKHO/Sucau4QueHbxljAfbnT
 No1viMSHBOxnltahvITny/vR3k0SLSumzCNauNiMPT49iViH2dUXDnZcj/x4ECstq5Jrmao
 ty6t8Rcrsqcbg3Yhcfe9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UlfyYDYLl/s=;PQ3GMrLOCteqoSlGvcmdP7HophS
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Move all the Darwin stuff from Makefile into config.mak.uname,
we need it there in the next commit.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 Makefile         | 21 ---------------------
 config.mak.uname | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 6de036e4e2..2d666c26e4 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -1672,27 +1672,6 @@ ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS +=3D -Dsocklen_t=3D$(SOCKLEN_T)
 endif
=20
-ifeq ($(uname_S),Darwin)
-        ifndef NO_FINK
-                ifeq ($(shell test -d /sw/lib && echo y),y)
-			BASIC_CFLAGS +=3D -I/sw/include
-			BASIC_LDFLAGS +=3D -L/sw/lib
-                endif
-        endif
-        ifndef NO_DARWIN_PORTS
-                ifeq ($(shell test -d /opt/local/lib && echo y),y)
-			BASIC_CFLAGS +=3D -I/opt/local/include
-			BASIC_LDFLAGS +=3D -L/opt/local/lib
-                endif
-        endif
-        ifndef NO_APPLE_COMMON_CRYPTO
-		NO_OPENSSL =3D YesPlease
-		APPLE_COMMON_CRYPTO =3D YesPlease
-		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
-        endif
-	PTHREAD_LIBS =3D
-endif
-
 ifndef NO_HOMEBREW
 	ifdef HOMEBREW_PREFIX
 		BASIC_CFLAGS +=3D -I$(HOMEBREW_PREFIX)/include
diff --git a/config.mak.uname b/config.mak.uname
index a926943141..44252dabcc 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -189,6 +189,24 @@ ifeq ($(uname_S),Darwin)
         endif
=20
 	BASIC_LDFLAGS +=3D -framework CoreServices
+	ifndef NO_FINK
+		ifeq ($(shell test -d /sw/lib && echo y),y)
+			BASIC_CFLAGS +=3D -I/sw/include
+			BASIC_LDFLAGS +=3D -L/sw/lib
+		endif
+	endif
+	ifndef NO_DARWIN_PORTS
+		ifeq ($(shell test -d /opt/local/lib && echo y),y)
+			BASIC_CFLAGS +=3D -I/opt/local/include
+			BASIC_LDFLAGS +=3D -L/opt/local/lib
+		endif
+	endif
+	ifndef NO_APPLE_COMMON_CRYPTO
+		NO_OPENSSL =3D YesPlease
+		APPLE_COMMON_CRYPTO =3D YesPlease
+		COMPAT_CFLAGS +=3D -DAPPLE_COMMON_CRYPTO
+	endif
+	PTHREAD_LIBS =3D
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET =3D YesPlease
=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

