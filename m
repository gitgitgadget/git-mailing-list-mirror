Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085591;
	b=iFP26u2oLQIRd1JLJPEUD71TcTaqrKRR5kb1v9o72ikXqVNkWhXgXnDUEqjdfBPkeLJn
	 Jp6OuxjvXtEkh6zT6kBiBNKoIbdN8zmCOfKZNHdoeToY5ZJimfioFEZWZtvypPpMixS4q
	 y5QWBF+5CcftDSH3nttD9jYjuMp1mnvQVaaMoCh81astwcU2Qji47LoeQ+l/PO/Qg6wrA
	 ulVEtlIr6rmso0jsxwIa1o5CiPiyyGU9sHha7dmW2QSbI/r5zGk3J+RDdlsXeaZSUY2Mu
	 f2TBVQR4bU2jc7/z9+d+xGF9dA+ucNla+SGFE/IC3eIWuIlkTDq7uKcjXYgKyi37ZWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sFJ/dViH53yIX/WrfL8rUUP6LC3t5/NEti5QqKUf7yc=;
	b=1WvyCik8k02w9vSqBt8k3O00Qh2kHDroIImFh6geB0oA6g50MAmHGB14SUtPqOH99itz
	 irkAADrTeiw2speovs78yMeTNDdqR3bmRbsl2FRaEM+lUNV62ugrsE0T2Y0olUi7udOye
	 g2lOG7pDEXBdfO2t3bWzswtc4+xOTRTpiY7ZzoAcAsJqpIxR/EceDocjNl78j+HIGAHus
	 VuVwAORN6/ft26dV+nEeqWxm7xFpZWlRBkDhgWfA4HE1lQs66t50Pxul5aZdWhc8Pk8qE
	 oTm6vywVkLO49M58HlqKN9nwvudk4vI3fgoBLiHaC5iAeQbTvVkXTHMKpqi0TaTQ1wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4CaV+Hd;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E334606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 10:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E334606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4CaV+Hd
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so294455166b.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 02:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795085589; x=1795690389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFJ/dViH53yIX/WrfL8rUUP6LC3t5/NEti5QqKUf7yc=;
        b=P4CaV+Hdm9BgGixMfm5x/BdNr5si14KPH8gWFYRDTS62l+vNDwiyOLpziTRoqaoVLL
         4B6Li7fc/3Jfit3kzntxZyY/Ha9IcjcBqIUueKQf01UwSy+npRBICt/kDKB6rzNoyOa3
         msK+zWr/gD3lQeESCX7Qjk7MLtIt//BtShmqu5XyUNfLULOSj8kDw+qx/Crz2eWTRAwu
         hWBDBDeNBkxf8NHAVVoaEDWqDIFNBeV9UPiPHsIHfyE2UJx9uPicxJxpx0TK/8OKfoBA
         Yb7zOzskNybi3KeM8TIY4bgWwiD2wJy+z0v0RPVFYlHgfIkdHO8JKQukCh6Ecmd/evxb
         FlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795085589; x=1795690389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sFJ/dViH53yIX/WrfL8rUUP6LC3t5/NEti5QqKUf7yc=;
        b=dzBOQvqBzwp7PUf9h2M8yfv0JMRVa967TXTiwg7mbLJCIuj4Kw1y4IACOhScZFprYW
         H+WDFpC97h39DjiY71yfXmp64ckhddlS0MJwMq/I8iO0Xdo4+ooA76wsXJtyKiml7yXE
         Y1+h5eBaJ/bKEQR03HjNDvYzWSH5O8kuN/X/XnJ7S39eFoUVOz9bxC9foQh+n6IpoP4t
         mPRjuSlh/jhne48VhMXEsBppO8YMjC3SoMMyAI4cvzHFsKTLZB3aLtclisDc5p3uaarb
         ewmG2LXuIMwrMYWofwb1cq4h6j/lUOG/IuXhMHbu4kRzQ6kon14dP+t9ldr3jf8/DYml
         v3TA==
X-Gm-Message-State: APuU4Z9cH671pRpsDSerzAU5OTQ26b9VSC9LjMunLcIvw2+AkJHGFqtW
	nxsnH5hVYPThqYFF6ohV+gWtwJWSDWW+DMFrJ22W0IBHJb0gsEKerceUGgfGSyWEDuY=
X-Gm-Gg: AYBFou2v2s7p2Eobb4p5e2ZxWWlQM03WQ010m4ghYgn3I8+inmzNEkzamFADYB98nqf
	xTMkv51M6iC8UObKB3qlIdyP/3tYrzl34/9jfcPGI8/aNklufFEm+Ipvucu6C6Fq04badv9WOuH
	7lku1MOvhW2am1zFJ4Dq+Dr7uN3qaa8Whq7kCpwEbNR3lWGMs20toqH7Sb9KdgMgPym4zw3tGyz
	Rj0LETcBK59cfDkCDrdX2LFs6aS/XqC8Cn7z1+Drio9T6v1/mpildRh63p9gmnANwiwIdmNsstE
	WbzAXaK9Xwk9lvPju2DcDyGkyWChs/ITxJwqywTwtyZsmKemAx/ForpDGRUjn8aLnwBjIfNhhP6
	93GWI4u8WnE113FbPmoGuvEWSDOjWErtVivafrrq7hserd/9WC1H4CGBxM1diePrD6LupfeCDX8
	bPSo3MAYpsjMZTyy4fnFFYhZIrIJmrI0IhIR+0HQzEWfJkjeTIGGLuYuvnAIwTPOWubAUFZALy9
	/TzJa7LNLga4sH0NvNi671t2pcGitPdGUgJf44Cy4KG4V+As/Jxp58YUbTat8IsBduH5/PxVgeJ
	d4ngrzVWmVbfksZm5qLiFprstxNIkkv+2luxVsaV/09gBOsaiwigcbr70Ha9n9XufMbaSDATXTv
	GTOiYYs9+FJUmpPTGV3mUWAaYlrwCnoaOKgvNvtyf+wgFZzcINkwzZVUwd65k4b750v/o4HLK6Q
	JD2VF1kHPtkDYwT54pzVCPdLDU4Eyd
X-Received: by 2002:a17:906:fa89:b0:c51:2064:1958 with SMTP id a640c23a62f3a-c5120641bacmr255267166b.2.1795085589220;
        Thu, 19 Nov 2026 02:53:09 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4c62sm99288866b.18.2026.11.19.02.53.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 02:53:08 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] doc: wrap emailed text near 70 columns
Date: Thu, 19 Nov 2026 11:53:00 +0100
Message-ID: <20261119105300.95746-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CodingGuidelines, SubmittingPatches, and ReviewingGuidelines do
not say how long an emailed line should be. State the limit in
each: keep the text near 70 columns so it still fits on an
80-column terminal after a few levels of quoting.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 Documentation/CodingGuidelines         | 4 ++++
 Documentation/ReviewingGuidelines.adoc | 3 +++
 Documentation/SubmittingPatches        | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 23a4d2186a..a0cc5a050d 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -33,6 +33,10 @@ Git in general, a few rough rules are:
    achieve and why the changes were necessary (more on this in the
    accompanying SubmittingPatches document).
 
+ - E-mailed text, including a patch message and a review reply, is
+   kept near 70 columns, so it still fits on an 80-column terminal
+   after being quoted a few times.
+
  - A label "NEEDSWORK:" followed by a description of the things to
    be done is a way to leave in-code comments to document design
    decisions yet to be made. 80% of the work to resolve a NEEDSWORK
diff --git a/Documentation/ReviewingGuidelines.adoc b/Documentation/ReviewingGuidelines.adoc
index 6534643cff..8770f0597c 100644
--- a/Documentation/ReviewingGuidelines.adoc
+++ b/Documentation/ReviewingGuidelines.adoc
@@ -116,6 +116,9 @@ guidance, and concrete tips for interacting with patches on the mailing list.
   unrelated to your review from the email reply. Make sure to leave enough
   context for readers to understand your comments!
 
+- Wrap a review reply so it still fits on an 80-column terminal after
+  being quoted a few times. Around 70 columns is a comfortable limit.
+
 - If you cannot complete a full review of a series all at once, consider letting
   the author know (on- or off-list) if/when you plan to review the rest of the
   series.
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c60855f706..2525cc7e20 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -700,6 +700,10 @@ WARNING: Be wary of your MUAs word-wrap
 corrupting your patch.  Do not cut-n-paste your patch; you can
 lose tabs that way if you are not careful.
 
+Wrap the prose you send so it still fits on an 80-column terminal
+after being quoted a few times.  Around 70 columns is a comfortable
+limit.
+
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
 e-mail discussions.  Use of markers in addition to PATCH within

base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
-- 
2.56.0

