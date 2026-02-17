Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFF330324
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326529; cv=none; b=T0eR5lvsw+jHp/AgkbPYvfs4KCTsXkavgtqBwsJyVUR+EK3KK7+oseme43ERomomR4mdNFKw5amq/+n2IKWK53r8wRbu8nYIzQypDo8W0B7QCbQ2bBFN0U5inVx2DS/MKjUtJlNkBdNA+07Q35pWihRRzMa8yuVvjPaVV3M0YAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326529; c=relaxed/simple;
	bh=A3nJ2ocdJ/y9nzrqzCuC82mSvVN4GagRTDiOH09QSko=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LWYgaI3uc4Bd1DjCA/WUeg6PG/zINNNdstbPXHW0dk7n3xumKRgjpAh/WA/kW+iBaUoDg097jvROggvVneVR2+xyKoj9ny3S/jWa4j3kvEuWuVYz7J4+THMo4VoSWw27qpYTFnzUR4xj85FYwB/lz8KCwJS0P7wOTJeHe70O6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnfgjqmC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnfgjqmC"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ca01dc7d40so421828685a.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 03:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771326526; x=1771931326; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DSJ0O9xN6/l4I5wxamK9qz5cRzaOCcno/GPB7FbK14=;
        b=MnfgjqmCSPYy2INJuW2o8ZZj4hGFdPZl2c2Pz+Zf+Y8GTageSlh1y9qbFlrFt8bu48
         6lYA8Jg7+R4Lw4WZy2JkgYudF9wP4gvrRIQVaru1t1mRG+8HaTzBrA4N8ba3M/R9Irjq
         bARZ4HxvrlzfAEKt+l/to9KgSea7h0mvNKhvxnqb8nmF+aqmLi/VnAOWaV8bHl7uCt9a
         sEpig1UCHOoBOK7pV6WsM0Msbhh5oRVTsSTgtT/LGdhrk9/kqlR2HZmySwS8Y/ja3kO4
         mL+DpnATuPlnqSErdvy09qFvZfl3pfLtwhJptD5r3H04Gine7NK/7zP6X8opyoOCPTPh
         kdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771326526; x=1771931326;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4DSJ0O9xN6/l4I5wxamK9qz5cRzaOCcno/GPB7FbK14=;
        b=URlTz6h2U6raDJGx6RER8MKVmFGi1+/CkuWufhfYRD2KpJZ1VuvNZGOZmM/SKIOEbh
         rY0qS8QIfxQhP+7Vv4Rs60u9V/uzQFlNwssCekP9PtOhauAi8NUHncQLIiLHvf55t+7u
         5D9rp8XLPNwC8K6nYopouBzrFvFl+VWzmQmeUXJ+2dSlNYFQxJzFxOCIuJgezqbOl8Xo
         0vjffKkATdGIO42BvDHiE9utsB8LRToD2w0FFFgs1yiKS9QEAoRjRrW0SYe9aKYvvDim
         KYDsCkMmQUHhDUAH/i5eZ3Uw9QdLGeE60yEphaIaZP0h2NBwzaW336GjiyXsQjeu9NHK
         E7Gg==
X-Gm-Message-State: AOJu0YyFJq64yNYxOyfjt5hQafu+o43R+RiN7n/pbWT0udaZ8kh2WPSC
	RZxsUELUHQr0QiuCfeZfptsrf2X5IunigL6JcHAoiJA0OoZCC4dER3qOXQCh2XDM
X-Gm-Gg: AZuq6aLcSNmH2zshFrf4OxJwLSXlLMPk7ACowMITn67iQ1ZZk6XEgoIT1wfOdSyj1WC
	3jqblgzoe27KNqLSVPYFU+mifkR8zizWR/4rOVuXnqet+zD+TMHsP/vkTlUcCxnEpsL6VK3AvzF
	PXZWb3xCpH1E7TlHJlBsZMxSb2XILXLsVyDz3b/JDU75Gj06bUpQnm8e3xXhjcBLPsckU9lMmte
	uuLdjaJSM7mtJJlvt/Zdw5pkiR9tngqzfg5PoS+1YIfFIgckbbteeffKa3BH/xZWqEALI3LMNVm
	tPx1qQXKuwoSxZZVqE9j4dDbkG4zwl/evRmREzUh4X+/UORfFsVO/yIv0r0E3XpB4Jt2WxaAyKr
	Nl7VQV+Vu31Qle7VXqWnF+EedJwy9WRUipEE131XjBJmJeMbfnGFfOA+n3sDkEI8OAhuId1eCUi
	vMjbYyxmxlimJHWCpNdBbP0fl3tA==
X-Received: by 2002:a05:620a:2588:b0:8c7:1050:46f with SMTP id af79cd13be357-8cb4248104bmr1657596385a.66.1771326526120;
        Tue, 17 Feb 2026 03:08:46 -0800 (PST)
Received: from [127.0.0.1] ([64.236.160.198])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c7ea8sm1528568885a.31.2026.02.17.03.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:08:45 -0800 (PST)
Message-Id: <3653067f0e84c22a432c7ee85caca129f5970f41.1771326521.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
References: <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
	<pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Feb 2026 11:08:39 +0000
Subject: [PATCH v3 2/3] remote-curl: introduce show_http_message_fatal()
 helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Several code paths in remote-curl.c follow the same pattern of calling
show_http_message() to display server error messages followed by die()
to terminate with an error. This duplication makes the code more verbose
and harder to maintain.

Introduce a new show_http_message_fatal() helper function that combines
these two operations. This function:

1. Displays any HTTP error message from the server via show_http_message()
2. Calls die() with the provided error message
3. Returns NORETURN to help the compiler with control flow analysis

Refactor existing call sites in remote-curl.c to use this new helper,
reducing code duplication and improving readability. This pattern will
also be used by upcoming HTTP 429 rate limiting support.

Suggested-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 remote-curl.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..21c96f2ca9 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -367,23 +367,25 @@ static void free_discovery(struct discovery *d)
 	}
 }
 
-static int show_http_message(struct strbuf *type, struct strbuf *charset,
-			     struct strbuf *msg)
+static NORETURN void show_http_message_fatal(struct strbuf *type, struct strbuf *charset,
+				    struct strbuf *msg, const char *fmt, ...)
 {
 	const char *p, *eol;
+	va_list ap;
+	report_fn die_message_routine = get_die_message_routine();
 
 	/*
 	 * We only show text/plain parts, as other types are likely
 	 * to be ugly to look at on the user's terminal.
 	 */
 	if (strcmp(type->buf, "text/plain"))
-		return -1;
+		goto out;
 	if (charset->len)
 		strbuf_reencode(msg, charset->buf, get_log_output_encoding());
 
 	strbuf_trim(msg);
 	if (!msg->len)
-		return -1;
+		goto out;
 
 	p = msg->buf;
 	do {
@@ -391,7 +393,16 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 		fprintf(stderr, "remote: %.*s\n", (int)(eol - p), p);
 		p = eol + 1;
 	} while(*eol);
-	return 0;
+
+out:
+	strbuf_release(type);
+	strbuf_release(charset);
+	strbuf_release(msg);
+
+	va_start(ap, fmt);
+	die_message_routine(fmt, ap);
+	va_end(ap);
+	exit(128);
 }
 
 static int get_protocol_http_header(enum protocol_version version,
@@ -518,21 +529,21 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	case HTTP_OK:
 		break;
 	case HTTP_MISSING_TARGET:
-		show_http_message(&type, &charset, &buffer);
-		die(_("repository '%s' not found"),
-		    transport_anonymize_url(url.buf));
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("repository '%s' not found"),
+					transport_anonymize_url(url.buf));
 	case HTTP_NOAUTH:
-		show_http_message(&type, &charset, &buffer);
-		die(_("Authentication failed for '%s'"),
-		    transport_anonymize_url(url.buf));
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("Authentication failed for '%s'"),
+					transport_anonymize_url(url.buf));
 	case HTTP_NOMATCHPUBLICKEY:
-		show_http_message(&type, &charset, &buffer);
-		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
-		    transport_anonymize_url(url.buf), curl_errorstr);
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
+					transport_anonymize_url(url.buf), curl_errorstr);
 	default:
-		show_http_message(&type, &charset, &buffer);
-		die(_("unable to access '%s': %s"),
-		    transport_anonymize_url(url.buf), curl_errorstr);
+		show_http_message_fatal(&type, &charset, &buffer,
+					_("unable to access '%s': %s"),
+					transport_anonymize_url(url.buf), curl_errorstr);
 	}
 
 	if (options.verbosity && !starts_with(refs_url.buf, url.buf)) {
-- 
gitgitgadget

