Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CDDDAB
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748889730; cv=none; b=JCsevDRLAO/L9/ptgaFQr+h6muvqqjsqLpDibukOEwgtRjLjkdWulXMXPWsJmDkYcQujU/pzdMci1bSt+15b1K+wCSNcfWohB36XWBgVmMcpvHJEEkfos7NbM48nQebc9JqXhGwES6UXUMjEmwc9VdwHIy8BasWKCH16GQn6TPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748889730; c=relaxed/simple;
	bh=CtF/170vBJOL20xCMxDPNgVC3TvF95GbISRDY6zCXSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuvPEXrUTy43LBBEDZZGhsQ9VJ9lfcv99jvp6vK6cJ5JXwfJ3zXzXd6AL89V2eQdSXAOSRmmOH6bmX40eqIUJaXQ0FJwrIj6HtT+5cQ+HDra4uQIxGt3DyTom/kiKfpBvT0VDWarpwod0WisH3W9yqseaNXXeo9qNI2M7xayf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7t9DYbn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7t9DYbn"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2349f096605so59006045ad.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748889728; x=1749494528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4QdNLti6YxqjR9js5yp6Llnrw9y84hNFxlQavjCC8ds=;
        b=c7t9DYbnvi9w+N7xrq5qqeLXJHuP1gYduxqoFV2FMy9tto5eweJD6LxT5uW+Szsbmo
         fxdq9/0OUyUuNI74Bam+yRNjae0cp9qpnA5WoH/8YH2zUX4Id9Aetp4CclqnEwRGJtJQ
         TuzwbiS5UFUATeeCOvpn80dh7o56ML2etJVjSCBnkOV3vXtTPY1TYsxneaxOJ4PUI0+a
         naKdm1vbhnJrM1DYz2/mhgnrxJ4/NtQRHuJG6PXtR7f92cDc89Sa0igGUz/nQ/smY0oq
         zOOJPhF9hhUtpmLURKP+NEKWXaBbic/FlrRtACEyO1nc+llKIQLyjGGaoBzLVCdOi6xA
         EP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748889728; x=1749494528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QdNLti6YxqjR9js5yp6Llnrw9y84hNFxlQavjCC8ds=;
        b=Ifwalvl9t5wYyd1BVTyGNPyKudDJOB5WicVFSbqoov4+9OpiPsQBrX/gwSJ1El6Phs
         CAabG7+sCm/GZ603PIY/9m86mCpL8G8g2A36aF8me7Me2rUTNkAI0VlQddklebNeCQ9k
         C6DQFbdahjmzR9fneGojL3yGyQ6LHr3n8uRVjB67w3Jp5YOed1SiDATlFmkAPyBJvvLZ
         +aUqMtEjgumqj25MxUFoHrT8CH221EJtOnjNiIZXT+kq61yNrC5hn4GqBQQYWXiOOicY
         Zb1/MASCuWZLTC3mZjoXOH2n7TsntK1fTbnLCvTpL86bbYMHieTAV6woQk21/KV9f9J5
         DTBA==
X-Gm-Message-State: AOJu0YzGPS6fs4sZnZATAQKTTUJryyHk7KiOMmIVNJmoVXjcs6qQ53WA
	XXU9KW9dDur9vseEPxhyVTADIk4CPJCyH4LF9zIokl1xmxfLlPrfrfG+edxE6g==
X-Gm-Gg: ASbGncu2uD9MKD3Fk57Ru/In3+A4zpYtdSyF7KCEruY6FpOIOALLGeFqRbP5vw7wsb0
	L1pFralN9xVu12FY58S663gEsJNInbbLYcVdE9w0AIEMx0SV5OyInLe4d6dfjoanbzJiHTRL7hU
	iiJdgxRMW0iBUFMjoQKnaCoyTqhpvK73EoPJ3NJu4cMPlpSVlSchV5efkOdL7ATaADIzvqHAX4b
	mIcICkJBOGCB2vBXWgMqip9hDyLiMNNHPi7LeExsSvjSbnonSPHrJUTIw6dC8z/hFw/cW9qYpUJ
	FKjtx+Y7z04cqKje7jFSoqlfLyrPHe2ZBzjQHkbDTiIK
X-Google-Smtp-Source: AGHT+IEaFO1pNyq2ojfCHq5hZ2w6NfJVQOmTcV6yQt32z2PGLIfrVlBHChCYS4Qzv317MVQsVJYY9w==
X-Received: by 2002:a17:903:22c4:b0:234:f580:a15 with SMTP id d9443c01a7336-2355f782eb5mr160202365ad.14.1748889727959;
        Mon, 02 Jun 2025 11:42:07 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8483sm73850505ad.1.2025.06.02.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 11:42:07 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: jn.avila@free.fr,
	Collin Funk <collin.funk1@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] completion: Make sed command that generates config-list.h portable.
Date: Mon,  2 Jun 2025 11:41:48 -0700
Message-ID: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OpenBSD 'sed' command does not support '\n' to represent newlines in
sed expressions. This leads to the follow compiler error:

    In file included from builtin/help.c:15:
    ./config-list.h:282:18: error: use of undeclared identifier 'n'
            "gitcvs.dbUser",n       "gitcvs.dbPass",
                            ^
    1 error generated.
    gmake: *** [Makefile:2821: builtin/help.o] Error 1

We can use a variable that expands to a newline to do this portably.

This portably issue was introduced in e1b81f54da (completion: take into
account the formatting backticks for options, 2025-03-19)

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 generate-configlist.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/generate-configlist.sh b/generate-configlist.sh
index b06da53c89..48ec8d9812 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -1,5 +1,8 @@
 #!/bin/sh
 
+nl='
+'
+
 SOURCE_DIR="$1"
 OUTPUT="$2"
 
@@ -19,7 +22,7 @@ EOF
 	s/::$//;
 	s/`//g;
 	s/^.*$/	"&",/;
-	s/,  */",\n	"/g;
+	s/,  */",''"$nl"''	"/g;
 	p;};
 d' \
 	    "$SOURCE_DIR"/Documentation/*config.adoc \
-- 
2.49.0

