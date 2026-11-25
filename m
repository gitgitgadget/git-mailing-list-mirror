Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640170;
	b=2G77cRk7+tcWJtHrBRJztA6Di/0Ob9adXjvj37KGwqQ4TfAr6EYR/2k+fHvDkVci3jvk
	 dt9JWnkgWVebbsu4I28y95H82ZIYSerRK8MVtTe6vQ9sd2yj9hKc+Ai6gwjA8270p55td
	 978hg0I/kvXX9w99vzPMuVaxCjSuv/6bMKrN36JW62K7wHWozyDPq4QKMpeQjj9/WxaUm
	 G1n7pfu+pdZByfFdWRktbg+TIvXrdGY6JMPL+PUyhNXK73n1Ut9hRM65rTnxlara08v99
	 hrAg3kBU9+dq0FICjy2TMD5lkNijO7o4R7r+Jv9eF13PaGBFZuNwfVlvUJErJX/BVQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=B8DbwjNIDLo+0V767Fhs/eI1Dl0eyFKETFj8kFY7yrs=;
	b=QMM5GNKgomMpo21Ds4wnTxWmCUln57ol98ck/C0uHCuOONqdU+h7PmdGNNH/slQWDWdF
	 K19nC3h4ZklIAnqILMareQGILdVt0QoiCiq5PhIFoREpXvpOG0rgm6y7Iwh0H68D4VdiN
	 da8oNH835l/p5kKq3N+ubN2R3VhTpBcaNg9eNraNgYouItdVgKqfwpkaQ5wVK+djJ2X47
	 C71tIzWtal5kyi79sUUPTXT2wPECrrMdoU3XK85iPI4QCmsE2foCYLnHfeYKZkLFQv73a
	 SMSOqxFW5JLqHf4Jy2Jta665vwyN0A5KUiSyInanXsv1zFTCGK/cVOIHtC/30oVomKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z97N65r9;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A634606A326
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A634606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z97N65r9
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-71b30ed75a1so3626318eaf.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795640164; x=1796244964; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B8DbwjNIDLo+0V767Fhs/eI1Dl0eyFKETFj8kFY7yrs=;
        b=Z97N65r9p/mafyr/Y9AsvGZHac6Y3WMc2jXp8NDBb116REAx4HwJGZ1jEWqErZ4W5S
         OZhA47ri65UU9T76g2xC2So5JMLNjZtcUFEmmR+c2K/Bo+0/yyr4IF69maHnWPwpWTok
         q3ZAWh0yJh0EB0vV8U2sa7RVdYLbRb80iMhJMimvhTPRR0qvJZltgW1/5A7w8AtIGFtM
         1NcBuqtc4y37g4r3sIsTaOz18pJumdAXbQV5ZK8YCuMBnvnlVL3NXY2B//RJtejPkQVl
         dsflwkSpTBQbcNipRz4v4wLvqG1BM5qyd+pfZ0flJ7wOq+dF9IZ+eqSJrv3WrcSdhH7D
         vojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640164; x=1796244964;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B8DbwjNIDLo+0V767Fhs/eI1Dl0eyFKETFj8kFY7yrs=;
        b=hW6e0tkK2YtR3N5a6qzE/IAOJmE9OiQ5ClGDLJqQVQWWLHIQ8alu2bZ+xwSOqOzP7Q
         SXsXjeibhUO+TDwog+f45F+81iXjzTYOKYlJRxG9hMlUKbdH2mGg87cyuNER1v3wtpho
         0sOfkwZGhNTgveuWzpSBUBNGXoeucrEwRG5zw9yRFhhSi4FpqGIhNK5uBAZ2iGeNQ1Tm
         nGyZck0PfysUxnRYGO0DsK49Mu3aUKeXqvvXFlWwZYvaHPttS1gI0CkVBU5h4XfTfino
         +Yf0AjV9bR70Lq5M00/FzcW12DlXHgwLxVWSNvxov/E28zZEzZM2J6wwgTHizxRcmozW
         A8TA==
X-Gm-Message-State: APuU4Z/IYfQZ6fZp0bnWWRhRt15es4x/bV1OGTpjWC6PnD8VtoD1XVF0
	3BMQDbUr8H3vBUSjt0pJWDZWpOuRMFEdwuWpxHWdrloWbjP7hNcmjePTpIXHX5vP
X-Gm-Gg: AZFdTZd0xoy3DoJ3C0GmmgRWTiWw9drD9l6FSLfeVuWC2DxUqpJZwT4lztmRJBBpIld
	lmvr8dkb9qBfgHAvrCqxFHbP95mZOtlLCwTkKwIsKmchZ3DmeuoNapDXbM09aNF6Qt2CtCxozOS
	jUzLAWodHdOvB41yWPRWXbxo3ht2DfF7Q8r0BbTrI9jNi+pPmXFus10dHlAbvr1Cj5NyukqvflK
	taBPdYq5U4ngWbUUgRPBZcnDrTdCw4Hv4MbNzFnKg/cnRe7tToBh8yv9gqbZgiXtOpaXjQE41VF
	otlhJTrzVbbJRTX0cQqzln0b5wOfAfWF2xGoY9sdNKbWZLEINv3xtocK8l4EVr5yBuZhpkJsg0p
	L6z0hWqtmDVOgct2HicNcbg6cmlpkdsk93LAekszotvf0c0i0bHm+FNfZZslKROVSYmHXj+0S4i
	OTQtIedgV0JtWk2AVXUGg+u3G20ttjE61mB+Ok25u8kG/oLTu7K3/eFiR1JZ0JR1mWJVyxVHa8I
	NVI0c6L+DmSdLL35kmvcVbG6v5OsSM5Y9AWLEo4Nra0Lz7xEJCiCdueTuZAWIAvQdnRlwLssZU2
	+XlnvMEYzuedQ0Tp3pxqGVyhLk3fp/rT
X-Received: by 2002:a05:6820:4082:b0:703:38e7:c3e7 with SMTP id 006d021491bc7-71b39486441mr14627392eaf.44.1795640164492;
        Wed, 25 Nov 2026 12:56:04 -0800 (PST)
Received: from [127.0.0.1] ([132.196.38.97])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b3806ef20sm12477108eaf.7.2026.11.25.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:56:03 -0800 (PST)
Message-Id: <23ec6cf8f08ec63efe7b868d78745940e8475ed6.1795640149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 20:55:49 +0000
Subject: [PATCH v3 5/5] date: avoid overflow in approxidate relative-time
 multiplication
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Simon Richter <Simon.Richter@hogyros.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Parsing relative dates can overflow `int` when multiplying a value by a
unit length, before converting the result to `time_t`. Signed overflow
is undefined behavior, therefore checking the converted value is too
late.

Reject quantities above `INT_MAX` before narrowing to `int` on all
platforms. The inputs are non-negative, meaning that checking unsigned
arithmetic is sufficient. The product must also fit the native `time_t`
range. Report arithmetic or conversion failures as parse errors rather
than saturating the offset.

Pointed out by Coverity.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: Claude Opus 4.6 and GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 date.c          | 26 ++++++++++++++++++++------
 t/t0006-date.sh | 13 +++++++++++++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/date.c b/date.c
index c50f45d310..3cbfe20b37 100644
--- a/date.c
+++ b/date.c
@@ -1307,7 +1307,14 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	while (tl->type) {
 		size_t len = strlen(tl->type);
 		if (match_string(date, tl->type) >= len-1) {
-			update_tm(tm, now, tl->length * *num);
+			uintmax_t length = tl->length, num_t = *num, seconds;
+
+			if (unsigned_mult_overflows(length, num_t))
+				return NULL;
+			seconds = length * num_t;
+			if (date_overflows(seconds))
+				return NULL;
+			update_tm(tm, now, (time_t)seconds);
 			*num = 0;
 			*touched = 1;
 			return end;
@@ -1377,8 +1384,11 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
 	}
 
 	/* Accept zero-padding only for small numbers ("Dec 02", never "Dec 0002") */
-	if (date[0] != '0' || end - date <= 2)
+	if (date[0] != '0' || end - date <= 2) {
+		if (number > INT_MAX)
+			return NULL;
 		*num = number;
+	}
 	return end;
 }
 
@@ -1404,14 +1414,18 @@ static timestamp_t approxidate_str(const char *date,
 		if (!c)
 			break;
 		date++;
-		if (isdigit(c)) {
+		if (isalpha(c))
+			date = approxidate_alpha(date-1, &tm, &now,
+						 &number, &touched);
+		else if (isdigit(c)) {
 			pending_number(&tm, &number);
 			date = approxidate_digit(date-1, &tm, &number, time_sec);
 			touched = 1;
-			continue;
 		}
-		if (isalpha(c))
-			date = approxidate_alpha(date-1, &tm, &now, &number, &touched);
+		if (!date) {
+			*error_ret = 1;
+			return 0;
+		}
 	}
 	pending_number(&tm, &number);
 	if (!touched)
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 6e63130ea2..2a33aaa327 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -211,6 +211,19 @@ check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
 check_approxidate 3.months.ago '2009-05-30 19:20:00'
 check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
 
+test_expect_success HAVE_64BIT_TIME 'parse a large number of weeks' '
+	echo "Jan 1 2099 4000 weeks ago -> 1651778400" >expect &&
+	test-tool date timestamp "Jan 1 2099 4000 weeks ago" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success TIME_IS_64BIT 'reject a quantity that does not fit in int' '
+	git reflog expire --dry-run --all --expire="1 day 1 second ago" &&
+	test_must_fail git reflog expire --dry-run --all \
+		--expire="1 day 18446744073709551615 seconds ago" 2>err &&
+	test_grep "invalid timestamp" err
+'
+
 check_approxidate '6am yesterday' '2009-08-29 06:00:00'
 check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
 check_approxidate '3:00' '2009-08-30 03:00:00'
-- 
gitgitgadget
