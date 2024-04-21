Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE73E478
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726904; cv=none; b=hsJraesYw3Pwc49754RkQRNxISxEm7lo4imfenS2q3wOe9235tovfGya2sdd29RIn9xbg9T9pJh0A/a0lBcyyCHHvNpIdYrK3qiGKiEuN4Xmp3QclRUKuq2IoSkicgSJuUSZHpTwlWp6klsWHb653Ui6qHhlOGS9bEuFDN+PtbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726904; c=relaxed/simple;
	bh=VOQl6qibkteRQCV3t677Butr7hNlEMqsSASfwL6E9SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6SW5xYPWHd9dNQM7W+9Z6GOpQbqyy4OxewZBhkk6zAflvI7nefsAe2p1LXqfOxfAqjhg36xOT/XPQPIOW4bQkhqF/z48iLBniTeMw7G7DXeIMd0m5rXHJ9Zj5AvIDj66ZMHcCx5PnE7ecrJ+cN+abmjNZCYG6qPNNtObPNDjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=BPIF9/cs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="BPIF9/cs"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a53f131d9deso448786666b.3
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 12:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1713726901; x=1714331701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54vnLQuRFzcgOC8tQmmyPbeOHbEPAZTL+grJjWZubd4=;
        b=BPIF9/csFDIBu/kt1OxILKLvOhbRnHX4dE6UdpPqnKAlznOrPmwvSfyr/M24l46TVi
         DHwx3/eP5MJeDcSVg0glN+Q4IPNk7BnoGdHuYsEDHPnkekwI+7WM0dhKLT+ZipC7WqQW
         JLMOAz8M4B5nH3dmgE+V1pcNULkTmQPRKMkSrvc1n9cdl+wY09vy7tvkxJihZQe4i4uR
         njKTPJLRfo3H9NNEM6EZ9wHzSK5ZqBG7WLGVlC1EkNTJJPKi+u+5rbrSzzssH7sR7wZu
         FI16CbwYp9YoifLngwmsxdzbDkWyFpYiPIu6p5WoOqW3ctSBNOw4N1SHR3UPmVBi+k9C
         5pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713726901; x=1714331701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54vnLQuRFzcgOC8tQmmyPbeOHbEPAZTL+grJjWZubd4=;
        b=i3Vqx65SE1UqB2Ejcl9LdiBFiPHM/fwhCTLXk8UgPBxXmMiiOOdQrsPLgHeBmrwq13
         0ieYGoErCySMrcUzGFjbjJ0vCONuqw+i2Rz8Uotg6Zinl+y+tJrZwvmomZl16foSwizs
         GmIcWNv1S3lOjWM0Dn5QKoIYjd0ILIzSbZgeEhihkP4UuHcDwsLU/Br18H/6HiCBRkOL
         qI5Z8IxSTSjKHaMPuFQx6OLBsjgr9o/2e8qpeDHmy6TaU7vf+Eghp7ZHst4Wb8sS7HrW
         UcUP7qymKSE6+HUV4cZM2vJWWiLo8pO0M8VSQXmse4bhOHXgp7l9qT7JUsTpebayGr8w
         kcnA==
X-Gm-Message-State: AOJu0YxdVfHA/l7QTK8uJWO1BOTw8x1pVSOdTNEjG1Gmj2US34WfFlZ7
	FpXlZ8wSKPB+sDGFkiqOb4zONyqNeakIAF8SiPUQ7YcYvhFAeGC/yE1PgNJSm07fSVbQCAbRkoq
	rl5U=
X-Google-Smtp-Source: AGHT+IG7/OnOP2OZBLH6f4qBBmnfuO3+t1Vsplq+vLGmAw1Xgu5SE+a8MEw6rTsCgGZvq+y9AyFRnA==
X-Received: by 2002:a17:906:eb44:b0:a51:a288:5af9 with SMTP id mc4-20020a170906eb4400b00a51a2885af9mr4687876ejb.51.1713726900803;
        Sun, 21 Apr 2024 12:15:00 -0700 (PDT)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.154])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906091500b00a5216df5d25sm4826659ejd.3.2024.04.21.12.15.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Apr 2024 12:15:00 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [[PATCH] [RESUBMIT 2nd] Consistency for substitution hints (i18n) 1/1]  parse-options: use localized substitution hints
Date: Sun, 21 Apr 2024 21:14:57 +0200
Message-ID: <20240421191458.5411-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421191458.5411-1-ash@kambanaria.org>
References: <20240421191458.5411-1-ash@kambanaria.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i18n: as translators choose substitution hints applicable
to their writing system, expose the ones in parse-options
for completeness

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 parse-options.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 63a99dea6e..2362ca83f3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1061,11 +1061,20 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
-			s = literal ? "[=%s]" : "[=<%s>]";
+			s = literal ? "[=%s]" :
+			  /* TRANSLATORS: keep as is unless you use hints for substitution other than `<>'
+			     in which case use those */
+			  _("[=<%s>]");
 		else
-			s = literal ? "[%s]" : "[<%s>]";
+			s = literal ? "[%s]" :
+			  /* TRANSLATORS: keep as is unless you use hints for substitution other than `<>'
+			     in which case use those */
+			  _("[<%s>]");
 	else
-		s = literal ? " %s" : " <%s>";
+		s = literal ? " %s" :
+		  /* TRANSLATORS: keep as is unless you use hints for substitution other than `<>'
+		     in which case use those */
+		  _(" <%s>");
 	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
 }
 
-- 
2.44.0

