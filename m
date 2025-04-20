Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC21EB19F
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745155184; cv=none; b=gPLFCdnsTqXTv3O9Rs4FGG82SrbhLRmK6LV4/Su4bNfPyTr6GQEZOcDoOhKa6li3tcII0P/wzhEvhI0dDHpbsVRMCjlx7u2xV3kABWetCrPbXB/t5fTAvikQ2MrjROxlpF7+Zi7bgKNHiyq+T7YqdY3U1wHIHNRyzFV9XGUfnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745155184; c=relaxed/simple;
	bh=7aFKqQm0qiEsRx3IGEQ/WN3Cr8QsAVkJF+2pH20ajNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TijCKbEa2WnW+OFg3/VIlDedDWR5jQp94In/E8U03BlHLfnNJ8oqPrUuVFVgtjTAlOxLyLK7rOtnYXi0c5UCKqhylUpEEuy6jHcNkwcEVvWUJPx//m91Sg36QDZIGESXe3z2XaFREonvuSANl1uR3brh8/o+c/kBHf4/AdrQGgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wfm2sQhx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfm2sQhx"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso2536358a12.3
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745155180; x=1745759980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZFl1M0OrcIPWT8HFO43EYurxkcw/E436zkZdv4GyHM=;
        b=Wfm2sQhx4mUfbAIWo88LPBbReMr1V6VGXpjP6Cq8GwtxrT47IizthwUj283yOKTKfD
         dFnuOImO2kgc81rCv4O8j0ocso0qzkafo3oXTOeBOf8LWhRniABUTcw+AX7TgWMHj6C1
         /WzUEcmQO8zk3MHSUZCwLM363YQtHTCahEs+ajoKmVv26cBWpD2idG3EO+OUuJwbToq2
         6E/d6RipfPL6QZ0sG5T/f6lOtNzowH/9ZzR1csGdCGemC0E3a3H0CyH2oQuwERE1iwJg
         c/QBm9SP++M0yG9rBC3ivCYD0YaPXi2QboUSdSIncebQEKqk5G1WIE/iAA1vYVfLivx2
         hkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745155180; x=1745759980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZFl1M0OrcIPWT8HFO43EYurxkcw/E436zkZdv4GyHM=;
        b=ckm0RlXdziNgtTyXObrmzxyL0ANp17QRMNl5NGmVnLkandcxXtsZLQ29P/nZHrbfxQ
         kYjl8SqnS8hoRACtxtUl97YmPgE+lnnZa5G2VEnbDfkcP2e73blc2oQq90ycj2IzKY+I
         oiYbGs+AaeCkd0aX9n9FSYrLUdZWhHTp+bbQDym6Y8WLfShz7LU7iazUtTIYGeBICejm
         eIGUMCLo3+HVtE4Zm7/+USOxnuPc5UCt+ZaPKmORm2ESxA57NwLo2zRhC5g04LsnhK5e
         q+93SawMRh9eldP1zo/fwtuyg0mAzb7/0GshXvZf0TIomcYZPVfER339/8UCuyei1GjU
         Eb6A==
X-Gm-Message-State: AOJu0YxuG3Mpijqq9psD8tpWUxaZ0OMQoPgUYimX0e3Su55s23P1XXAX
	GVDyEZQKfufFfag/8WR1o60wa88rNAiQeKiY5/B9KD1ttvP3nYdW
X-Gm-Gg: ASbGncvCc8hLSOUNSySHjLGrqYux3F19QCwcrmWGFv+Q8+c10gaqHakwN/3emOllYgA
	YEXBJsJIWvfQdrWXYXrNz5hLCmRnRmDN1FNbCzYq2grmN0zf5lVSlu5In1YnsR3pgaLEWzSv8ri
	eeLWN9XLRQ2uszD5RF27KGrelL2/eHxGGH7XAELKUErs8KIXnegBjnh0Yx3IL5ea/uUEjh51aWR
	LkpZdV6VKGpNWE39ALW4kGitofJ7SWxgGKQecp2SLFS8OfMY8owIkM5hGXgOubVphftAkeYELeT
	ahmqt8+sM0ykN1fi4y8HWNo/jWvcc84bVwYMPLfjqoZ2SuM=
X-Google-Smtp-Source: AGHT+IHC/gdl08BbnlGMNEpcTeiwPcuEaIhhH9D+44Xqmw83uvEl+uEyLhq4ULGGXGGDA8fvtL4SOg==
X-Received: by 2002:a17:907:1b17:b0:acb:32a3:22ff with SMTP id a640c23a62f3a-acb74b81139mr743169166b.27.1745155180378;
        Sun, 20 Apr 2025 06:19:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:7cb7:e0fd:4535:dd46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc703sm397872566b.94.2025.04.20.06.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 06:19:40 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 20 Apr 2025 14:21:37 +0200
Subject: [PATCH v4 5/5] makefile/meson: add 'check-headers' as alias for
 'hdr-check'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-505-wire-up-sparse-via-meson-v4-5-66e14134e822@gmail.com>
References: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
In-Reply-To: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=7aFKqQm0qiEsRx3IGEQ/WN3Cr8QsAVkJF+2pH20ajNc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgE9Geq0iRcN/UkBoOzkzg1kbjL8xt8nEx9D
 ohd15MYLM2jNokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoBPRnAAoJED7VnySO
 Rox/Ti4MAJ2+k0wkjnH86r5TvG9dgykeERDKtOCWl8eAHA7G4RzyUMJtdxn3A1NUZy++sZjtCHi
 BG0+jVQncqsyXJ3iKBFyINMO2DrgcEbYr+YO5CZ1QgQAa6j9EzbRAf6VpGOrp6aq79s2F760Nv5
 C7LGhj/KzHZZhs/IkY5iX8MBLMEnmQmH6qC1vazY03XOq6m+/lYiJcseyLMsEO1hTQkUbC2tUP0
 cLLhn4+t6/WgIHHsThsMhxdNJcWKWFZSw4dbvt3evRKIXmdqTJ3R9vGsxpgBG6wFjRoUYj8tLs9
 sp8LbXga3UoJlyDJjV0ruO482Orr1KQziEAi9x/jSeo2/g3wc/MoQnwL78b5/5BD4BQJkrFZOJ7
 Old79CO0um+SG+Hrt2JIyR0G9ComOo1tnnAxjGjyc0H6j5gKqpQ0agwZ0PHkquH3zp5mHe7fSs5
 Uj3EweZTm48bE3M1UV7ukG7Y831Syjqs/NpS0fbuEYD5jTMK4FFiQddTyrT0ztH4xXieO1rvXh5
 mw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'hdr-check' target in Meson and makefile is used to check if headers
can be compiled individually. The naming however isn't readable as 'hdr'
is not a common shortforme for 'header', neither is it an abbreviation.

Let's introduce 'check-headers' as an alternative target for 'hdr-check'
and add a `TODO` to deprecate the latter after 2 releases. Since this
is an internal tool, we can use a shorter deprecation cycle.

Change existing usage of 'hdr-check' in 'ci/run-static-analysis.sh' to
also use 'check-headers'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Makefile                  | 4 +++-
 ci/run-static-analysis.sh | 2 +-
 meson.build               | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ac32d2d0bd..961ee508be 100644
--- a/Makefile
+++ b/Makefile
@@ -3326,8 +3326,10 @@ HCC = $(HCO:hco=hcc)
 $(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
 	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
 
-.PHONY: hdr-check $(HCO)
+# TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
+.PHONY: hdr-check check-headers $(HCO)
 hdr-check: $(HCO)
+check-headers: hdr-check
 
 .PHONY: style
 style:
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 0d51e5ce0e..60c175a094 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -26,7 +26,7 @@ then
 	exit 1
 fi
 
-make hdr-check ||
+make check-headers ||
 exit 1
 
 make check-pot
diff --git a/meson.build b/meson.build
index afbdc97fb6..39319e2610 100644
--- a/meson.build
+++ b/meson.build
@@ -2054,7 +2054,9 @@ if git.found() and compiler.get_argument_syntax() == 'gcc'
     hco_targets += hco
   endforeach
 
-  alias_target('hdr-check', hco_targets)
+  # TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
+  hdr_check = alias_target('hdr-check', hco_targets)
+  alias_target('check-headers', hdr_check)
 endif
 
 foreach key, value : {

-- 
2.48.1

