Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DE3A27E
	for <git@vger.kernel.org>; Sat, 25 May 2024 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716639931; cv=none; b=eeKHyLoorcaVL2L+uOq/qK/9kSc6hVyu2MOcgsbwLzC7eyHfV0toXUkk47vDWgQPu7O/deRCl2VqSKtvimxCiDkpiWn6J80r2WrERLl8y84KvJvYHFwFn1qxsKeFWSwlJgl4mypeTNqYQVzFO+W+srbr87MKZHMQ58oc3cUREbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716639931; c=relaxed/simple;
	bh=ivK9E4pzKvVamQ/nGKe7cFw8fJLM3aMYhri62oUKIq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAUVcsecZRAq8+GHslWTNyFqMMRzzSm8yfOh5pUiIJyaKhj0iUHbZQpWuOrf7DRszzCm0fDhV3WeGRXaOzze1dRwToUvd5W9ZaO+vHblCSkkPKhpEZu1kZoZSoa4dJ2FPt+4lOjFFwtoIzR6+sgBN1cr47RXnTX/+h+63dqMPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=L1108/1l; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="L1108/1l"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57883b25b50so503318a12.2
        for <git@vger.kernel.org>; Sat, 25 May 2024 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1716639927; x=1717244727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuVEv5fGAXBSTxUr9qzlGAm+LNSlX9x1Twohwxz76K0=;
        b=L1108/1l3nNZdpaW7zP6NPybil5DOEU1Q9GWtHOBSybgxAY8TnQCX4arRoheVwSH9b
         x44OBIS8b5ewyrS5p+opVZkBPYe0aXXIVWTwy5brMaJg43T97lfjjTQh6W+bZuwCkeVH
         rMEmau32u6GVennDYcm2rW964KNRZrq1eX5BXScl5srSJKJIrrDjLlyklcip83XWt5ek
         QaKvY0I+TDK40QuTnf3FD0sSuG8ED72xSOp0ynuX5hpbrDKvrEREOCZYEBCoRJiZQbfQ
         oshzA5R+90TDKGR+Atki8giSBQOfSwZCI+xDJmRpgq2Mw+w5IeKpxobDwMXbSziUIdE2
         S+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716639927; x=1717244727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuVEv5fGAXBSTxUr9qzlGAm+LNSlX9x1Twohwxz76K0=;
        b=X8eqL+CAaShbwJAFKZjtHzs0GNoLPzmAdfE3uZeq1DWZmVDQ62dXo9/gJNDMPSKJN3
         qqLanqJI8cywcPVmArE9wKYdRaA7dAxJE11lDAV7xBpD/3z9vCdxzM48AOZ2+Z5ueeVe
         NKmsqxlzaL84kC3WedRY02USXCkzV7kPPRV0UCWcXu6wppCy9wRyY/jQmkOD/JRi6pKD
         3Ce0gD/UqOV9LIox2vZKMdsH1p1FhijEvYWBRLUVEgasuwUyDfzp/FR0AEMcnHxK/jUF
         MQ5kgCNJRPMvEaOCi93T2X8J53jBk3YvVivCJsyBJ+B2jdslEyzrjZvRCYQ39WC4w16q
         n5aw==
X-Gm-Message-State: AOJu0Ywyoo9BEU6zp0VjNP/unaiWlmhQhOs4+tMzcn+Xe3U7ydpbhkFn
	OLNSFVzI6jo0PAraiRtQbMcl6LygkNzEEEfJ6CtubKogu+RadpNN0cJiicDV+Dd41sStzYAwlnH
	/UIA=
X-Google-Smtp-Source: AGHT+IFsjhGsQHrdes2YcTlcDg1duEVevxJTrDAe5j00cw3w08If8eAC8Hfztqstz/HKDVfcNZ71/Q==
X-Received: by 2002:a50:955e:0:b0:579:bf5d:ac01 with SMTP id 4fb4d7f45d1cf-579bf5daca3mr726125a12.15.1716639927043;
        Sat, 25 May 2024 05:25:27 -0700 (PDT)
Received: from localhost.localdomain ([147.161.172.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852339fc4sm3054485a12.15.2024.05.25.05.25.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 May 2024 05:25:26 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 2 1/1] parse-options: allow localized substitution hints in macros
Date: Sat, 25 May 2024 14:24:38 +0200
Message-ID: <20240525122514.2608-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <xmqq5xwa1pfl.fsf@gitster.g>
References: <xmqq5xwa1pfl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i18n: expose substitution hint chars in functions and macros to translators

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 parse-options.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 30b9e68f8a..06d962b00e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1070,11 +1070,17 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
-			s = literal ? "[=%s]" : "[=<%s>]";
+			s = literal ? "[=%s]" :
+			  /* TRANSLATORS: change `<>' to other characters or leave as is */
+			  _("[=<%s>]");
 		else
-			s = literal ? "[%s]" : "[<%s>]";
+			s = literal ? "[%s]" :
+			  /* TRANSLATORS: change `<>' to other characters or leave as is */
+			  _("[<%s>]");
 	else
-		s = literal ? " %s" : " <%s>";
+		s = literal ? " %s" :
+		  /* TRANSLATORS: change `<>' to other characters or leave as is */
+		  _(" <%s>");
 	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
 }
 
-- 
2.45.1

