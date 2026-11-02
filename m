Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632525;
	b=5jAi+judp3zc7ATSvzp/bSinuDUDM5CpziwJ66/lBJV267cGGRfEPMkictycgJEYU0+r
	 0y15VHjE4yQHZyesntSWOqI4OennLcCdysxazCpSdSBygB2JBKd5zsMYzW3K2rPrToS1d
	 j+Lm4xnBL8oEWJfxoMNc/rGObyENwHmmmNTKwsySSH8L/hAv3ClY1q4Imb1zIeuOOEHBs
	 Q+p9DrcL3VmGIom2aBW75usG0ebj8A6xWkj3tiHZW1JiGTAqTIXUqBDmVJDGGbOanpXYJ
	 WmlQsiJUvB/XeHCfkVlRnKLuBBzzUFsYaCBmLmqKlE2+TDx/42D5QdcL70LRDrSZoUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u538flnabdyzsBREUCepirYGgucTRtT1XU+xtySUpHY=;
	b=V7081+dks1X+SXD9Q0z+Lta7g35vMMOtaGfqh9eRXm8efnO7QisV2CtcFGa1Jk02NAqb
	 78BA8tNduYbImbQJneMgPmj6V9WyTBlLTrkf1Jbn8wJrAiCBrVIgk0l8TlzAh8qrLm77h
	 dzHEDeE4UgCAijcX350rhTMP7KeqHUL9GrTydq3eVcHS0zGw1DfHjnugDsD/PXzjDDCkt
	 OEVeaahXAdeLQzq1b8wc7yiTqwP0XG0yhUHxFlUsKRQBzdnqZRHgrUlE3vGf32pQ2icGx
	 T+uOMt9A1DCkdkjOnV9JwBZUOJwKPtw6lwsfk4n3ruRdJwLljFY4KQOYlN2f+FjcVvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GUkYRfv4;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059A60B426F
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B059A60B426F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GUkYRfv4
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so28128505e9.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632523; x=1794237323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u538flnabdyzsBREUCepirYGgucTRtT1XU+xtySUpHY=;
        b=GUkYRfv4Qz071eQZZVrfq3FG2lTc2BBQccC3c0WwJNqvo0PmrWOkYod0ijFieM5Ce2
         WsTcpu52aSsDrLes1G5+cREt19WhE3zsh51VJ5ZY9bUVusFllLPSCpgpedmIICc7/hS8
         HkO9FN8rAawKKLcyUnjFKfeg5DmZHAnmh4qPZTG6m9bxVp2octBs41LNzYt1Tqb63NFg
         0HhLvEUIBdffbt3Kvi9QcoeakjGJAJ/emvNqRjsB55HUeVR/6sY1+KZlVGEjNWpR/0e8
         1zA53bnK1M0NgsiZwL+tUacAcOMmmnz0visC+pDDEYypVlejxRXpgNT+xCl6w6i5eTTh
         Zb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632523; x=1794237323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u538flnabdyzsBREUCepirYGgucTRtT1XU+xtySUpHY=;
        b=JlhFHHqtroqnreFN91pt+5oRawO0GFDZADHvlvme2DuBOvWoq33eDn7bY53rfRrEs+
         ZPXHylivbraiFmNWCv33k+1Zz8zB6W7Y7PtBHgqoC6wEwmk0TKyC/nnQ6sRUHNYTDdDs
         5iNIT4rzbxG6Yx59S+tfEF94LLn78Wp+KUFTpw450Aw3ZntYS7zjtJnt6e8tOc8GvtBc
         Q+GSdZmHffUfk2dd63vzv//L/60QOVF6ztwLRl87Nb9GWqMJ8JlKp4xj5iVK+RQaRoT1
         ySekTz+bFYjh7avUu534O9ugeGlYELtuX/qT0ezsuvDVSxvfl4g33QyTivHg8/x5iUc9
         TR7g==
X-Gm-Message-State: AFq9FYIQGjmJ89ippCcpObMahBYMezTV/3BzwU3EMAGU02cYn91PjIIR
	Cwix7Kq0DcekruQi8j6Jd7iCmnpeGpjSir0+gi37x4tY6eBF/wLgdhIcNjHONg==
X-Gm-Gg: AYBFou1GaZqv3s7Bhg0UM2gy8T4RumZnpCOL/FGAhwxSoIrXkkD7WaI3BXGaVuQ9KRR
	uKMppHaKAe9wEbQKgBwnx8ASr1nWtcJDRm/vv5fkw0IkhNPMdxK5dk/HbRa9BeHxlEmBwGf4Kfk
	syCFLFZpsu9b5THVTc1qP/NrO6Ioiab/1BMK3rb+zBCy0/8GdzeP9aFJONUjuxhxJLB34CBWMFm
	MJcSgWDXGUizMW0Yb5LhsTrNxbkszC1SyTaC7Lw3DhJ3OQYPXCBOydnyzKXcxcOgtz4fI8GeXBL
	eYlDEUe8utpiN/WcMb3aCXespPpis7RSCCX3NrByuSgV9naMLOx5En8/uPnWUO2Vcw1Vm4B/puU
	STLRivSEWGcvH0/ysPgVD3M3fA47pqWN9FMYX8NujMBRTpBMRpxe9JEy4rCkB5SdrHLRz9riB9v
	apAG4S5yBPUoWtm70jycbufq0YcIiRYJdDg6gDxLdOyhNllWe1yTSRcvMBRdwClYigj1LUpybSy
	vCGsq1l6kaF/e0XFGnhXaJHesIBbAPeUhnW5S0H66SWhCmTjh0KOiRhb17bUB3qTGc/PJfq/MYK
	rAukJo87xvKO39/CzDMB1P8RzEiXkpa7C2IKmuP9L5cqPXKoLjkzB+B8fmXx+bydD9P8zXC46wO
	08QPc816Qno5iTMwVejwA8IY/5t2q6uLOr2c9FYcdxHORJq/7K06nC6J/nisvUjFSe8sYTM2PDH
	k2dCQnsro3FF9MVLzsOlZ56iWI9/mbU9GNjhwM5bhcAWBkVme4wQt1lqJUYZjS2w==
X-Received: by 2002:a05:600c:4ece:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4ac169d7e39mr235212155e9.5.1793632522850;
        Mon, 02 Nov 2026 07:15:22 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80eb1sm21851553f8f.34.2026.11.02.07.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:15:22 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Cynthia Uche <herroyalpriestess@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 1/4] parse-options: add parse_options_takes_argument()
Date: Mon,  2 Nov 2026 16:14:49 +0100
Message-ID: <20261102151447.734680-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.4.gceeb21e89e
In-Reply-To: <20261102151447.734680-6-christian.couder@gmail.com>
References: <20261012074413.337183-1-christian.couder@gmail.com>
 <20261102151447.734680-6-christian.couder@gmail.com>
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

Whether an option takes a value, and therefore consumes the next
argument when that value is not stuck to it with an '=', is decided by
its type and its flags. That rule is currently open-coded in
show_gitcomp(), which needs it to decide if it should append an '=' to
the option it completes.

A following commit will need the same rule to find out which options an
early scan of the command line has to skip along with their value.

So let's factor that rule out into a new parse_options_takes_argument()
function, and let's use it in show_gitcomp().

Note that an option with PARSE_OPT_LASTARG_DEFAULT only consumes the
next argument when it isn't the last one. It is considered as taking a
value by parse_options_takes_argument(), as an early scan can easily
check whether there is a next argument, and would otherwise wrongly
take that argument for an option. show_gitcomp() keeps not appending
an '=' to such an option though, as it already did, since its value is
optional.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 parse-options.c | 35 ++++++++++++++++++++++-------------
 parse-options.h | 11 +++++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4519ead9dc..d7cbb5a343 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -841,6 +841,25 @@ static void show_negated_gitcomp(const struct option *opts, int show_all,
 	}
 }
 
+int parse_options_takes_argument(const struct option *opt)
+{
+	switch (opt->type) {
+	case OPTION_STRING:
+	case OPTION_FILENAME:
+	case OPTION_INTEGER:
+	case OPTION_UNSIGNED:
+	case OPTION_CALLBACK:
+		break;
+	default:
+		return 0;
+	}
+
+	if (opt->flags & (PARSE_OPT_NOARG | PARSE_OPT_OPTARG))
+		return 0;
+
+	return 1;
+}
+
 static int show_gitcomp(const struct option *opts, int show_all)
 {
 	const struct option *original_opts = opts;
@@ -862,20 +881,10 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			break;
 		case OPTION_GROUP:
 			continue;
-		case OPTION_STRING:
-		case OPTION_FILENAME:
-		case OPTION_INTEGER:
-		case OPTION_UNSIGNED:
-		case OPTION_CALLBACK:
-			if (opts->flags & PARSE_OPT_NOARG)
-				break;
-			if (opts->flags & PARSE_OPT_OPTARG)
-				break;
-			if (opts->flags & PARSE_OPT_LASTARG_DEFAULT)
-				break;
-			suffix = "=";
-			break;
 		default:
+			if (parse_options_takes_argument(opts) &&
+			    !(opts->flags & PARSE_OPT_LASTARG_DEFAULT))
+				suffix = "=";
 			break;
 		}
 		if (opts->flags & PARSE_OPT_COMP_ARG)
diff --git a/parse-options.h b/parse-options.h
index d7f896a933..589f8d9008 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -420,6 +420,17 @@ int parse_options(int argc, const char **argv, const char *prefix,
 		  const char * const usagestr[],
 		  enum parse_opt_flags flags);
 
+/*
+ * Return non-zero if `opt` takes a value, which means that it consumes
+ * the next argument when that value is not stuck to it with an '='.
+ *
+ * Note that an option with PARSE_OPT_LASTARG_DEFAULT is considered as
+ * taking a value here, even though it only consumes the next argument
+ * when it isn't the last one. Callers that care have to check for that
+ * flag themselves.
+ */
+int parse_options_takes_argument(const struct option *opt);
+
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
-- 
2.56.0.4.gceeb21e89e

