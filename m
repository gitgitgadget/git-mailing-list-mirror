Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862F344043
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136836; cv=none; b=lnkNGPXnzp/ezl8et3e0/exX8zrUltu7fR3phnpwt1CvvxftKZuQYIsNRkOo+ynzgTC1MK3yMK9jZ0gH4mXaFt9jvGztWMaqu/apzbSUvVE0mxdw9MEwjppwCZw/dS4ZAduQcXQjcmNT4opFxtvu7I0km8zgxD9QZ9i9L+o8uxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136836; c=relaxed/simple;
	bh=dnSDjPoVeYe8cXfXaap8NrRRRYN+D6aWh3uqrlj8q/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0viq7OmDFi94ovjKe/cVXzzQ81fWpdyi8TrbdHRainM8zaOf2ZEGbDRPNU+jY+EjAx3m0gVulnNUUxv0aaMuHAzgtXsqMlz2V1rvopL1vrSQe8ilGNK9p94DR6r8UsIiL1Hn9GVIiB2wawkg5XVE3sEhwK7HjlsOz0Sp/i8Qsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/tWGQ4Q; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/tWGQ4Q"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so36543505e9.0
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761136832; x=1761741632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/unL1+QAzSHCWFeUB79RUI28aeC8Avviue8ad3mmgzM=;
        b=g/tWGQ4Q9NrHcimt1M6kGON3QfibddOIFnCxMFz4SQ19xxhdpP6zpW2is4vMdj2dw/
         OGrWf9dER3JCtmOpU0uSN5W1rQ1By7f40sN7JtcEQ7Gtq7lXONUmsisuJnUbDNXs1MXi
         ZgwXrHf87vLUV5GFI+o6KniV+t/Wd9EBab6EsDz4E8TlN+WPQz4Ksd2YVQDtBFVmoE7P
         tcuzsfJHcKuoRsK5Zg8OjzfgLcWitvKWJ55rMVxggDLE2i5x5RnIWctRLxARz1x7KT01
         W7xPmBSizpjkmWlbyhzqtl2/AtnjB50fbqIZXG1TdIlguxzuXWLpLuDjscovLZsydV9/
         mi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136832; x=1761741632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/unL1+QAzSHCWFeUB79RUI28aeC8Avviue8ad3mmgzM=;
        b=G8ghLxeJWOdh0envQcRDK7iivEltNz1WDNdBd5KaPKPBwiT46ZbffgWK99w70ufgQv
         nMdubajkaJ7x8SV6Yy44CQkdgkNYu2g6F2rje5EbiWAP70yDQxELHImQ5aQQJXkYeuKa
         w+qXs2+esg65tV/706EOW5vVSl3elwjXGELulpumQJ13RWl02EWtauwWUkZuNLyZiEe4
         yw+nZkcJJ6EYBTHshR/p6nhdD2oSRF+piyNTHydpr680NENBgrbh53EIYB8eCh7jH3K4
         ez4BBpxW6EIg2dxsAL9Gt7DhDreziPMhfHuOu5uqwVOxXEraHCS1di7VyuLbsNCqk2XV
         b/Aw==
X-Gm-Message-State: AOJu0Ywyq7KyfObARwM7RNZ6SBawUj/uVM50L2VLNYNUH5W0LOGHrf+Y
	WuC/QS4h85PMb9jL5Dfl6OwVJ0HXVvkYKzETRnhYeXf6L7fkFMrraFkF
X-Gm-Gg: ASbGncuT96vkgfxRdSLIE0xZQq5JUD2gWIaLgErTmvWGcC0ProyNu8S9Yjz4FH/NqBK
	QpZthGMBjV8m6r7617OuPhoV9LzT22+jOtokIjyR5kaeVmS3YQxzm6obukYHIY5sl5sV+PBJSyw
	xK7DT0akh6eogtGzy4/T3v0xWJRb/Feh+2wTsDfMwy1OvMpqtVkzBeLQBOmwDzJAAmW5sAJw9rw
	1+kBXs+Z5qjesHX4Nu4RcOMCojRm0j+oFETVz1j7PC8Tj/WZNdvQPiNGXBoT1Y+oCy5xZK/KPwK
	Jg/CXFRHGu7aMd3BP1Fov6GNNQCVYvDs++LWdjhefWikJcBA8KLRydboK//FC/PleXUHi4VemD1
	aSsyCW1Jxgrd7+bN+ctyFeriKDs6dCfBuy2bsz+GfnZWESDEe15wTs/HnfOzFWl3xTeTe
X-Google-Smtp-Source: AGHT+IE/KBKfYn3xKRxH1bLdQMuYAgBfRH+ZGQhNAOOSYY9k9u76M1hhufx6/YropL9+snBlTExpIA==
X-Received: by 2002:a05:600c:8509:b0:471:16e5:6d7a with SMTP id 5b1f17b1804b1-4711787dca0mr112263225e9.13.1761136831582;
        Wed, 22 Oct 2025 05:40:31 -0700 (PDT)
Received: from ubuntu ([105.117.1.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a993sm25123126f8f.24.2025.10.22.05.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:40:30 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v5 1/2] gpg-interface: do not use misdesigned strbuf_split*()
Date: Wed, 22 Oct 2025 12:40:19 +0000
Message-ID: <df8fbbd3a50748fd974083b6bbb07ffca91be465.1761135129.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1761135129.git.belkid98@gmail.com>
References: <cover.1761135129.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_ssh_finger_print(), the output of the `ssh-keygen` command is
put into `fingerprint_stdout` strbuf.
The string in `fingerprint_stdout` is then split into up to 3 strbufs
using strbuf_split_max(). However they are not modified after the split
thereby not making use of the strbuf API as the fingerprint token is
merely returned as a char * and not a strbuf. Hence they do not need to be
strbufs.

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

