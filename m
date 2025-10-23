Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE830CDBD
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218042; cv=none; b=bQ0ecmhVtoX/xNwgofy4h26jdw9k478R26TYYBlOAor7sMAxSLoG0mPLbxxviCb9Zum25M6meMvA2My2nMtnB2g8ec8amZrfsj3Q2qtcJ64b/49gIn3f+zMpGLCdX5T8AZR3STvO2NhFp7buiPsUkEWAcTS0o3N0agi3tRZAMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218042; c=relaxed/simple;
	bh=BFzGAhre+jo8z0/+oxp8m6gOUElq17j3yLDK4srmFDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtGn1Gn5fYJQoq/R0onNhOWvWMebot6k9LK9zgn5wxwAvyi7lb2No0AsxBz7uPFkHdUggiIFthjJBgAWgw+QlkNo8LtBXyAZFArS2/kLH+Ihmh4TN2CrlcjqyeEmhEnolJX8D7RXZhWiXBfCkPI1jXWncluzfehBhr7sEVV2KyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVdUv+GO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVdUv+GO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bcb25so413277f8f.2
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218038; x=1761822838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s7M9ePekeLJypbflibFTENkE/RA3ys+hSLZa4ETri0=;
        b=FVdUv+GOIAMUk1Ts7Qi0s7gLh8voTVioFB05ZiHMK0Gx4NWL0RafnKDtt9dJ402KTJ
         Bx5hx8G3yxm/W9MivheIQj1QBfBILCZLH1M39p64vHWjOWoEt92vqT5er938myfGEY2b
         z1kY1vJh6+CRgaEajXLEFIiIXQHDw+ENtyd4ZcfF53r7lXlFxA8hoW/nW8eTrdM/U7X/
         ymTrdcwZogrYXtz9RPS3AiKtjYKU75oF1TJ3rqmA73GRYW1ymmdgTnDRfxSQ4qk/zlyq
         ANH5accGj6Xh8WSVSlt5NN0GF0XpXnILNFlBupuc97ZSpu8Ekb19dvAjOSSwqEwB8rVx
         xXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218038; x=1761822838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s7M9ePekeLJypbflibFTENkE/RA3ys+hSLZa4ETri0=;
        b=CsLa3oBVOehZOaloiX3Y//TJ6ckqXcmgGWJCMh8DhianMOmB/DATYnwxo2xUfKonFn
         D1PICTt/Dy9Nw6czFqOF+wuKOCCPWhcSDSXKuy9TndDVbXWASnir3866kObCYHe8sirm
         caD49on71zcsiqB9/uSndLSdC7URXmLbMjniXxQp1cv6kUwFlwlLWwcBnvkVN1XQlME8
         0vs74mk1GZorDubKZSAkCkpYBcVm0b/NUjeSt1FlijuDodYt+i56kaaDT3tmvifBSkx/
         VA8FHc+jgr6+CxAYY/s5ZgPNizKsZxfciZVzmoUur3ASOODrcwygKht8cDOfMzJJ/H6h
         99Ng==
X-Gm-Message-State: AOJu0YyWfEKa69bBMSyJUWHhltt3z5/8UqeGHZywInLqqXFwP0ZrjDBF
	E46ZZ2PCjsGczmYK560AKlbdSZjvNH323sHWsAe54LDtcscJfQEDpX8H
X-Gm-Gg: ASbGnct26xo7qb5aQGN9dWSB4roLSBIs8hfCfql3bNN5lrrUgNCH9dTJGWOrfexpJcf
	iZ+wdNZoR3ZzsL0dZ3pBbQYbdF9o7wTwReo7mg9AdKmw2GptfG5lWZHw6NWiFl5RyzV+Zh/VZtR
	CNzUIYdiJJq0MM0CwvOTcJ4UOdF2wk+5WAQFoDmQtr+vnzMcaMRMLX4TwbtUC+TambHSEzrYnzJ
	KLWCKMqLkmGhGCtnFlIj+hZOpZj4Pk2Jp2zB2/CY4MfhDOU2oiNH1PIFXfz1VoXFHi6X5SO2K2h
	ioNbT05bjkh30tUNBko3W/nbKr2Bjj7hoYLdVNU8ObHVHsV2hsTDUT0LWSxT7R2pRBbcoaahqgO
	zq8sbNCRVX2NmzjtcVG2/23dplibDdvsLKX51pIqLeM/Xqt4tA2W6VdWTInmLbBNYqH7W
X-Google-Smtp-Source: AGHT+IEkqpmyirC0dLMOYn57co8RfLFVunM9J/EPkx6gAildzEsydvKHBYfs90/WPJEwq4Uh/iyldg==
X-Received: by 2002:a5d:64e6:0:b0:429:8a0f:754f with SMTP id ffacd0b85a97d-4298a0f7826mr1352203f8f.55.1761218038113;
        Thu, 23 Oct 2025 04:13:58 -0700 (PDT)
Received: from ubuntu ([105.117.6.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898cc930sm4049757f8f.33.2025.10.23.04.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:13:57 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v6 1/2] gpg-interface: do not use misdesigned strbuf_split*()
Date: Thu, 23 Oct 2025 11:13:46 +0000
Message-ID: <92fc78c203646fe30155fefe2fd041f99bde1b7c.1761217100.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1761217100.git.belkid98@gmail.com>
References: <cover.1761217100.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_ssh_finger_print(), the output of the `ssh-keygen` command is
put into `fingerprint_stdout` strbuf. The string in `fingerprint_stdout`
is then split into up to 3 strbufs using strbuf_split_max(). However they
are not modified after the split thereby not making use of the strbuf API
as the fingerprint token is merely returned as a char * and not a strbuf.
Hence they do not need to be strbufs.

Simplify the process of retrieving and returning the desired token by
using strchr() to isolate the token and xmemdupz() to return a copy of the
token. This removes the roundabout way of splitting the string into
strbufs just to return the token.

Reported-by: Junio Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 gpg-interface.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2f4f0e32cb..917081abac 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -821,8 +821,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf fingerprint_stdout = STRBUF_INIT;
-	struct strbuf **fingerprint;
-	char *fingerprint_ret;
+	char *fingerprint_ret, *begin, *delim;
 	const char *literal_key = NULL;
 
 	/*
@@ -845,13 +844,17 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
 			  signing_key);
 
-	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
-	if (!fingerprint[1])
-		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
+	begin = fingerprint_stdout.buf;
+	delim = strchr(begin, ' ');
+	if (!delim)
+		die(_("failed to get the ssh fingerprint for key %s"),
 			  signing_key);
-
-	fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
-	strbuf_list_free(fingerprint);
+	begin = delim + 1;
+	delim = strchr(begin, ' ');
+	if (!delim)
+	    die(_("failed to get the ssh fingerprint for key %s"),
+			  signing_key);
+	fingerprint_ret = xmemdupz(begin, delim - begin);
 	strbuf_release(&fingerprint_stdout);
 	return fingerprint_ret;
 }
-- 
2.51.0.463.g79cf913ea9

