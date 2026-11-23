Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472035;
	b=U8kA0N/21ezFC0VWnAIKb7+YBH/XcxWRftbeuHDXWQUpfnaL4gesvmL40mimalA3SuVT
	 2UqIlwlXI4/ju/datKfEYNBWpsAS2nkzrXHQPZ/JcJxt4xdqktnCV0o+rOW7m/jxH0PhZ
	 s4yFljcp8mApApLj9EGU38sedHL38DVNTTGc6q8LzzOZmg/Ym4NVWIaGdp3h0u9O+5GaU
	 A7zZqfA9WyQor6RcHHhsOthMuCUi3ehn8EyyjuOGcyDs0APx8AYzDgDBO5/sfbRtK2byQ
	 Uz8QGdFSOuPHnSUiAOxBvMkQ9O7rXhCm8aemnM92Xj2MI4P1vf0oFSOuHISebWqVxIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=B8DbwjNIDLo+0V767Fhs/eI1Dl0eyFKETFj8kFY7yrs=;
	b=SNEUq2SBlH2kHXP+3T4SQWce+25O40lDlM57UTgwUsRx1ais7+kk7uKh2BmUaLUtb3Mk
	 Q6LlBP78l1Ozf07KhIVEyqTSQwxTbMmUIvjJKGCzFU3r3G6fUNQyR9iGcsF0r6t0WI6KC
	 wO/QrHJFhtRI7XVycRH6pxL4pU6X+Oc9ggHCkCjn8ekTDa64be7215V6wm0AtZNDnzLOT
	 oaLR0Pd0IaRhgqSTDZdmQh29vMPQGSjR/zSchBonEp0Nw7nH3GCTgjjGiIGXQdIHOV0dE
	 aAjg3+BzOFjkA6D9BFIppm9Bx4wVfu13sxT0AZpogRF+ggBsLmzTZxOO8XHMIdQxFBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXk7kRyN;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B08606A692
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34B08606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXk7kRyN
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so723447eec.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472034; x=1796076834; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B8DbwjNIDLo+0V767Fhs/eI1Dl0eyFKETFj8kFY7yrs=;
        b=NXk7kRyNOuOOhaHCOgv1SBr3i+glImYFs/JYKXAOykKee0CDYdYuAGJm4qZpyARKBV
         TkZZFP6kNqkddcXKzGEYODVvdXbUzsdDz1YdWU9GJQb+UbW2uiSrfy1eeJWv2NY5hDVh
         Mrk+Q2wBC6RaKw+rVtBJToVQHiSRNvVI7U/aRl4LrV2d4wsnYZNY9TLhHsSfdCgBVZMy
         SSOLYdGTf/Dvul1raC5D24bbzCsUdWtUAwND7L7ATlyfUrJKlXxy1gM4ob8sMm20/VPk
         ibCMzCln4WkfET2OS/rcqmfLrJkWkKBSPpvDwDJu5XBwsU77iAcPb+qiHI1Sv3YUa3lg
         O5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472034; x=1796076834;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B8DbwjNIDLo+0V767Fhs/eI1Dl0eyFKETFj8kFY7yrs=;
        b=jLJ9UMTBQAwIl7yF5S1eMocji0i3YkIDbjZTdmgbLuKM+V0BMS1NL7qIC9DaSm6TP3
         7io2YCf8Y73omdafRZBgc11cM3e1AIoxGTXEV8mr9xVofH134FS0Yvu2nUS8UItruPY9
         YodssjHSvSRoS+rV2k3IKg1OPaK6Q4PdkOLgIf01yvtlRAuAD7L62mXbSxL9ML+oPZNf
         309H3wEAU3lSxX+4qFC99aNei18ErIFLnkUNNdmbzHBzNgFMW69ikg4OLfguUoSt+6I1
         XY5keRgxNiblduWjABta8NvkKqfefpS3FK4B08Qtc6VCXWXwDS19yZ5L5DUdxmvf/bVx
         m5uA==
X-Gm-Message-State: APuU4Z/wfWFZ1Gy9vsgeMqzCjYpIcu/bNM7niTGnkPoHKBJ4flWF/EvQ
	wXOsZ9HqimnHtGqK5mbBloxhh0h6LbuiDX8W1BIOHNdpF8g8NLMXftgZOZJj7jFT
X-Gm-Gg: AZFdTZf5bBmOBXICKnJA/SsOArXF+d0DDsRdY3wIZOSVrgWz1CA0Ta9Eh5u6EINR263
	4V61I2z+ioCUnT60KPhvwu0sK2wFfj8dZ/oAwNINat0v6mAhi8dhXkAGw1h2RgyUzZzJK3YX9gB
	uu+hsxzfp2VYz4s3TIsDEkct5WrOQyPhTokbGV0sV3tadUpZLSO0wQraZVGZCjmOIZJhDszQsvh
	q+orxa4IZEirdC0eX7S7uO4Mi0IGc+tU38/1yZyGKC8gA90wCKaoiXblSO48c/KXmVU/RE3+Bwl
	WF9YCerkGFbP4ato3sBLlHKXBE2nwABDpGSlL9HuvIKSetEAjcVtYSV52Y+RvsvEeE0eA2sXobW
	TruaqRT0KzChgXCih7ihUd2PaI9MUqwGu1W08TN81eRFqL6AdbQfOtQWuK0KMStkARzLXQOlrk5
	dOnq2KiNJdxCulbonr0CAmG27zGffdtDmjfcStLjwPbOLdeEfUJtNHE9NIrRyGjkP6zDWgKZC0f
	W8M8BNCBNMKPv++l4w0pg5PYdDizuZYulpZMO470P9GuYXe76Yz1y8N3tidSAUpNXXnzTA0x36E
	yD/rrX/n8EPpO6uIQtbThE79kKJMqQ==
X-Received: by 2002:a05:7300:d090:b0:386:8bd2:da2c with SMTP id 5a478bee46e88-3868bd2db9amr11019588eec.2.1795472034039;
        Mon, 23 Nov 2026 14:13:54 -0800 (PST)
Received: from [127.0.0.1] ([51.57.82.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm46948858eec.11.2026.11.23.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:13:53 -0800 (PST)
Message-Id: <6057734709542cfe83a0ae885cb588e01806f247.1795472027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 22:13:46 +0000
Subject: [PATCH v2 5/5] date: avoid overflow in approxidate relative-time
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
