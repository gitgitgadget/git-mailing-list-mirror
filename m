Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DED383A5
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713723256; cv=none; b=j0AMNmWhn/6JeVi4Z4woeq3rdBhm4mLaVtTvSvjXlxfutd8YYBuEllQDZh86Hfzl90ctO6M2Phtf8U59Me8PQH2YdgfbU1lhZjJ/ubRLdsdMtrXo8+e80iWl8VjopTWk2ND+HGRegatm9bHxLqQZj7KnwOe437WgU+7fi//8E5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713723256; c=relaxed/simple;
	bh=cchItB5b0OHQUhMAWVdBxLeDnZgqoRVrA0kdXs3c5Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nwh0Lx635RsybwKzfA0WM4e9RFvH1080lwzkbkigEfu2rBFpnH8WRNkZ0dPs8Kwtztvc7gn/eTPjO4Rv0uSd/PSECqYOtQrkoGzxUM2TeRjN7U2yEXrEwGvhmQw1CW/XncnF+bjlakzhTSLxf1p1OAtMH6Bs09qPxflmbvezSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=CCzmoPwl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="CCzmoPwl"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a52223e004dso340080466b.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1713723252; x=1714328052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRbInsuykI7oAoDvU7h/X745xXzVT5Q+o1+om/Nkr38=;
        b=CCzmoPwl/13A7wjQUjNwCpVadvE852LMjTLtfqajGVZNEEJVf1Pe2okvoj6u7gCrFg
         DfjDzHxKCSlKKmRm3netT/7QTm6Lf0PXKLVqchAgBw/Tg/YNkRwXfFb8Ty5IjYQBF7b5
         m1gdb50PrukYb9hX+cMvZbIt18lYfVxIhNYBJGXEGUsPDj4ZglRoOun3XbP9VvRAK6io
         LwJP6ELBTRyG3uRmAtomuX0+y0SREI45Y9WO/dieIw4h4zchFnAH5pq4bo511rsCkWva
         aCnEKqOwpyfUE0NKA/SCSFDZUpcmD984kh3f5J5XeOvY9f0WSRs79TwHcs1q04L3FRN0
         W0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713723252; x=1714328052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRbInsuykI7oAoDvU7h/X745xXzVT5Q+o1+om/Nkr38=;
        b=TcIMZV/+Pz/YH5Szq3xDoZYZeH5BAp5AhMn+N+8NGs5BSdLUVOGBk621ZowsyQdCIY
         FyMPBYOF2weZv+UaRKhJTAncld9FM6jZ8aBril6xaofb6ZgGNrzJvBTCbFIUD3USyUnw
         n5p4AT9+kN5+mjmvO0Nh3WiXu1Urcs1fx/uJRfgUtZikiBCODldaCmwKu8Odocwq5UfU
         bNZ4Y7hOjlHpZW0b9zJ8UU5f2yYnKx/CSRjDx3RaacSw9Hq1UnWNv+MQLfiqIHqsss2V
         RD26Dm2ODZNiiX+Wc0DDnat2nnzR/OPT02dgTRe7iGlrjmjpojQI0DcsUaX+F2LG2sb+
         1jJw==
X-Gm-Message-State: AOJu0YwGfKdHKaA+PpOtGu8DNZpqhs+aW95E1aU8dledy4P1lAczo0Nv
	SjIUiZAfbZ/tPkIGsvw1T/5A9s+7BOtVemOnH8ypjVNnzkeYuS0S40Hg6j/59wUd3aWDDWsgbfA
	EgFE=
X-Google-Smtp-Source: AGHT+IGKzm4OI2q6xvkOJKtfqjJAggSTvV1EKJgeDvI1TTFgzEglysYW/SfMoiyFzSTzJjXqjwb4TQ==
X-Received: by 2002:a17:906:3645:b0:a55:75f7:435c with SMTP id r5-20020a170906364500b00a5575f7435cmr7949141ejb.16.1713723252611;
        Sun, 21 Apr 2024 11:14:12 -0700 (PDT)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.154])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906091500b00a5216df5d25sm4772043ejd.3.2024.04.21.11.14.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Apr 2024 11:14:12 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [[PATCH] [RESUBMIT] Consistency for substitution hints (i18n) 1/1]  parse-options: use localized substitution hints
Date: Sun, 21 Apr 2024 20:14:05 +0200
Message-ID: <20240421181408.82736-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421181408.82736-1-ash@kambanaria.org>
References: <20240421181408.82736-1-ash@kambanaria.org>
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

