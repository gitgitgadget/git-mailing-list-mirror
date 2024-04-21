Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB13B1A2
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713722675; cv=none; b=T51v4I9CYHPFcpNjr1xHIOj7zpWsOlFb3kCwiWoFJTsUIClsNYwDUcrv0RpuP17NXaoIqosI+l6FUe47OX9btekbuZzxwrlljX/SFcjKg/md7eqStOQHHCXgt3wvxagWGUU+zHzfD2qGzXdA3CYG8zZCXWpt67Y3j85y5V8KEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713722675; c=relaxed/simple;
	bh=cchItB5b0OHQUhMAWVdBxLeDnZgqoRVrA0kdXs3c5Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcn4qlGhN9Yk8MtV6uWofp/Mr7yxejxkNYYzCm2yL/apMbIJadKy/bMN4t8buQlRyq7jqZKGPYebdyP4DJ+PnmVUAg1XTfIogVhDw4uEuV2EjU1a45oxQlSqUIDL3buKGJxjiT1J5vmQ7mQOP5h3/C620CFAAMMsPPP7Cq3jftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=mT2KSptb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="mT2KSptb"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51ddc783e3so440281966b.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1713722671; x=1714327471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRbInsuykI7oAoDvU7h/X745xXzVT5Q+o1+om/Nkr38=;
        b=mT2KSptbjbOyjjEJ2oI/YPvpS/UTd/kg/lqCvAnkjBqipdb4p2HK0VzKYzCEbfzHf0
         07nYamS+9ni++pNyEV61R9RWXTKjzYiSKcU32Q1rI3eiNa32/L6vmbSSZkdFDwLQPswD
         5ypIMt8ZbQnbqzfNluANiwr1xXJT9cFXkucSTYD9hHWaFCAtdwFC7snlDoQTit5VomTm
         yV02EZ8Ih/BDK8pmntdVDbKmhK9pn9hjhidD6sz2zLgYQdzFz9yOi2Q89+ZALOn5i9Ch
         iL+GtHDpebCRj+6B6ExBxqoHFm5OK1E0fOdXoE3DVKZxTYtL0xt5aABQDB/CrYs+35Wh
         pV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713722671; x=1714327471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRbInsuykI7oAoDvU7h/X745xXzVT5Q+o1+om/Nkr38=;
        b=KX0J1wsajtgA+diGVWVsQlzuwws3PjBXG0GiV1qmH7njtp3xx5j9sYLfnI4mASqeKw
         KG62fCmelCUMnM5XilGCO9xIxYvdozmy7myshM4i7U1hyhkULbFBumuIj6lpo82FRjvh
         TeMdjIMYclNEWz5gyDCAlqGSLhcrkERm/pLqpl6lZBmwA+W69xSNLRpmPfW2LBqKmgWl
         UqwvOvGnI/GrXjur0OfPIMXBb1D/aU7xMVyFKynw2cpcn5zL1IUeczFch1fV8YegSW1Y
         l6Nji8gQ98lPoeB3tjFyig1kT5+q2fPtVrgYkQtyrLvQZyT4iOKq9zX40hLeLV0s1WRd
         lUNg==
X-Gm-Message-State: AOJu0YyQHSWDhAbfDwASUqDAvbxYT4D/OVp6ZhRAfC2lyiMieehDneuk
	gT2fC7oRMvZx4uosxP7+p+2d9V5EBxevww9tXU2KMU1Xu9te/Af3VwzE9QujymuHI8zCCrv4o7G
	EjPs=
X-Google-Smtp-Source: AGHT+IErcZ0wj28bEtwXIuevzAkxvn+RQMwTo8pWo4BK/wm77YKnlKhaGOBD/2IX2LeBZzdEpEj3ZA==
X-Received: by 2002:a17:907:9405:b0:a55:b93d:e284 with SMTP id dk5-20020a170907940500b00a55b93de284mr45786ejc.16.1713722671261;
        Sun, 21 Apr 2024 11:04:31 -0700 (PDT)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.154])
        by smtp.gmail.com with ESMTPSA id j18-20020a1709062a1200b00a557616395csm4420974eje.85.2024.04.21.11.04.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Apr 2024 11:04:31 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [[PATCH] Consistency for substitution hints (i18n) 1/1]  parse-options: use localized substitution hints
Date: Sun, 21 Apr 2024 20:04:22 +0200
Message-ID: <20240421180425.78940-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421180425.78940-1-ash@kambanaria.org>
References: <20240421180425.78940-1-ash@kambanaria.org>
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
 parse-options.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 63a99dea6e..93712c6904 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -27,6 +27,7 @@ static void optbug(const struct option *opt, const char *reason)
 }
 
 static const char *optname(const struct option *opt, enum opt_parsed flags)
+// FIXME
 {
 	static struct strbuf sb = STRBUF_INIT;
 
@@ -1055,17 +1056,27 @@ int parse_options(int argc, const char **argv,
 }
 
 static int usage_argh(const struct option *opts, FILE *outfile)
+/// Fixme
 {
 	const char *s;
 	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
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

