Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580137;
	b=YMAb7XhDJeRJJJ714DkzO4gCcb8u5kXrZlRzuJr8m3/ziDg+DAh61VgNQL+aV1rHHyJ4
	 yArIkJvZjgUzDCzyEnosiBHq60xt4PqiCzggM3G0WFwu5yMtgH/kfSSgJMReP14TrvqZ2
	 18TL/kcZ8vxurIZgLaESPa12T3uys07rup30HgK9p0aLkWp6FWf6JDSop0ugaAZCoB50P
	 NmwJCeyg1O7EAbdqdaifnBMChseu+2MnmnPVLZ1mYsREArEoYFztOEsH6tWqB/gTH7gS3
	 +64V1UBH0ENhDx4G8RC9JfjFSjw/Rj04x6k1saOZ8vk1dg7cowgw4w5nrtwEfXR/U3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nF4Cz6LkMZYxa1m8ZM9XEWREyq9i9s+0FgqtrzUNc3A=;
	b=rmQDu7iZTECwSD+WJdk5+cSXqczwm8gzmM7BN1cc57yXdxSSw1Z9/8RqMGPpze8/ySbH
	 8ENZDMcMGNEqOxJIdu2Ior8ZqTbomkHoDF0JamKOH7r0SwpnRA+shtO/n1Vqq4pnIm8YC
	 G3gGwBa5Lm1y9jyfN6gvNQuPqvpa10xLzXIUiyc50UuVZeOX1w8WJk+sTRNKlVH1LOVkg
	 +myhxByM0qFJJ0H2LBW3ugYW9/a2FHILLHl4zCCYjEQR7tD06BLKfG9ZrQGuvXfQKmhEC
	 cJPElFvgpS4XETmzDlJGPsfT+Uk3++KkYmPOrqGUhPG4biGTiUfELwYNPFPdxkd+I0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="B+643xl/";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E960A260B
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F5E960A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B+643xl/
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so17080785e9.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794580136; x=1795184936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nF4Cz6LkMZYxa1m8ZM9XEWREyq9i9s+0FgqtrzUNc3A=;
        b=B+643xl/vU9hn0ANRNFjIPRaj4bW6laDrksNtZBXkr/ZgbEO/WjC6UifVrI0YkptE2
         +44JFzlWULRHMvXSgZF5qsses9YMAylIiMCjarDRXVHxfe6+9ApNWpB59NBKPesFaitH
         eYrZgN4OaDMJQdLL5XKdPKhtQtftoFwf2zrxtax5nklAbUAT9TMc8l9ZAt2ZFJCoHVSF
         nh2p1tQX3vhYz+HdYv+7yUNVRh5tsVZoh2w3sg5+J3O6npzIefM5aqBTNMcVzNoUK1fy
         /ylHWEfpxXfAKir+eeAT8Z0RAC3U6BoQO2KjpPNWDY0MbNUeSfNglCtwbK3JXUm/m2in
         qguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794580136; x=1795184936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nF4Cz6LkMZYxa1m8ZM9XEWREyq9i9s+0FgqtrzUNc3A=;
        b=FueyQ/DG0eonR3qnUFvoFPbUjkaUWz5mv6Gc7rzpRZuBgL+dwl7beaaxx5U+ujP7Nl
         jN260wJPuZ4q9uHHqbG6GOvaZQ5izDZm0OzmtiEIgv/Z/jnPD+CF9IO7WtbNlc14Q7mc
         KnNQjNhj1p1CvbCFTGlDmjhzOieGeWlxTEfv0sW5oZoJCEAO+U6UHEy8hpbQVVN6URHZ
         D3i9U3llsEsVIUzoUtnO1CSN5x9IF+zzXdJPxBXL3Z6wyk3ONBLkc3G5iPZINMgFgc47
         8pufm0xfrvGIkBI19V+HV7R7rwvLbwUVS9XCIIfTH+Td3JV1yyfNh6taWDbrag+iNIC3
         kt4g==
X-Gm-Message-State: APuU4Z8PcS7r21gwK8Gw19CEJx/3VOzr588D1cPYBxDeNS7np4HQf7+w
	3xLS3dznh956QUP531Ha5VEi6XM6dYq4HXAVcMVfjcmO9WK4jOE3DCPRcQvvZ7Fe
X-Gm-Gg: AYBFou1IX2hNFmw9GWfM7cAGRlSurE2RR4lRXY0aaMY9Iwx+ptu3a/T6fqFd6Zt6VMq
	Qnucj/qK44b+3g0OTDtFZzDdDBbLDq4wSeqlzvfXiS1qn0WDmazuGCiyXTc76gfjerZFM+kkjin
	E8kbtEEAIAo5N5ZgMLHXffp4jlv6ipj/S8rFpoXHZkeMSSDTsldqzfzzTl3vvjLc2pAPhLxLFr5
	JFJn08MYMJfIL5RB6He7rAxUyY7uQmGlt8rRIwNpPfoIOXu5y4DVMRTQVDVvoa6cVCVWEw74QO+
	oNAWSNUjyMDtVqSdhtCftcuYdQJ+2qpuGyrZ5x1TOqYajKKR/S8QrtIooTJVzmS/WMklzxoOKi7
	SpCjgbnWEhTR7fTQQkvMKcWgkK1rk71uiSTbn+57eUutGYarQpSaT5ySl8AVkmCrCBCMI8fIHlE
	r0Xis4nGtbs9x8/2OucenHsv4YfAxqCVh3gRtBX96nyHZA0pjfCfV8hi8R6Tu5DYC5eYyB/K6rk
	bQcMZplzLFCWv6QiCN6T+K1YiRiSGPg4CFhK/0BcWmq64aBw9UNt1SShHAJRQE/XHzOWxdZWAz0
	sqIdDN6OO+iAbu3gTH1L+Mtata1esFhCn2pqj5slUlrTIThY6UrZ18jhGBqYXmCqaapBAKm+25I
	2q77iXPHD6OCk5RPq/wSK2tNReu/edw==
X-Received: by 2002:a05:600c:4e15:b0:4a2:1612:636e with SMTP id 5b1f17b1804b1-4bb55a4436cmr55070295e9.5.1794580135795;
        Fri, 13 Nov 2026 06:28:55 -0800 (PST)
Received: from KURSA (ipservice-092-208-105-158.092.208.pools.vodafone-ip.de. [92.208.105.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac1159sm60033285e9.4.2026.11.13.06.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:28:55 -0800 (PST)
From: Caspar Duregger <caspar.duregger@gmail.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Caspar Duregger <caspar.duregger@gmail.com>
Subject: [PATCH 3/4] refs: let read_ref_at() fail gently on an empty reflog
Date: Fri, 13 Nov 2026 15:28:03 +0100
Message-ID: <20261113142804.7465-4-caspar.duregger@gmail.com>
X-Mailer: git-send-email 2.56.1.windows.1
In-Reply-To: <20260212040708.GA1894049@coredump.intra.peff.net>
References: <20260212040708.GA1894049@coredump.intra.peff.net>
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

When a reflog exists but has no entries, read_ref_at() can answer
"ref@{0}" with the current value of the ref. For any other request it
dies with "log for <ref> is empty", or exits silently with
GET_OID_QUIETLY, even when the caller asked for GET_OID_GENTLY. Such
reflogs are left behind by "git reflog expire --expire=all".

Return -1 in this case when GET_OID_GENTLY is given, and make
get_oid_basic() treat it as a failed lookup. "git stash export" on an
emptied stash reflog now reports "unable to find stash entry" instead
of exiting without a word.

Signed-off-by: Caspar Duregger <caspar.duregger@gmail.com>
---
 object-name.c    | 13 +++++++++----
 refs.c           |  2 ++
 refs.h           |  4 ++++
 t/t3903-stash.sh |  8 ++++++++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/object-name.c b/object-name.c
index c066a7d6a2..1d7cbd8a03 100644
--- a/object-name.c
+++ b/object-name.c
@@ -761,7 +761,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
-		int nth, i;
+		int nth, i, ret;
 		timestamp_t at_time;
 		timestamp_t co_time;
 		int co_tz, co_cnt;
@@ -789,9 +789,14 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 				return -1;
 			}
 		}
-		if (read_ref_at(get_main_ref_store(r),
-				real_ref, flags, at_time, nth, oid, NULL,
-				&co_time, &co_tz, &co_cnt)) {
+		ret = read_ref_at(get_main_ref_store(r),
+				  real_ref, flags, at_time, nth, oid, NULL,
+				  &co_time, &co_tz, &co_cnt);
+		if (ret < 0) {
+			free(real_ref);
+			return -1;
+		}
+		if (ret) {
 			if (!len) {
 				if (!skip_prefix(real_ref, "refs/heads/", &str))
 					str = "HEAD";
diff --git a/refs.c b/refs.c
index 3f7458332e..b6ce62b12a 100644
--- a/refs.c
+++ b/refs.c
@@ -1227,6 +1227,8 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 			set_read_ref_cutoffs(&cb, 0, 0, "empty reflog");
 			return 1;
 		}
+		if (flags & GET_OID_GENTLY)
+			return -1;
 		if (flags & GET_OID_QUIETLY)
 			exit(128);
 		else
diff --git a/refs.h b/refs.h
index ee3b8a62ef..25b8987ca9 100644
--- a/refs.h
+++ b/refs.h
@@ -603,6 +603,10 @@ int refs_create_reflog(struct ref_store *refs, const char *refname,
  * that there is one important special case here! If the reflog was empty
  * and the caller asked for the 0-th cnt, we will return "1" but leave the
  * "oid" field untouched.
+ *
+ * If the reflog was empty and the caller asked for anything else, we die,
+ * or exit silently if "flags" contains GET_OID_QUIETLY. If "flags" contains
+ * GET_OID_GENTLY, we instead return -1.
  **/
 int read_ref_at(struct ref_store *refs,
 		const char *refname, unsigned int flags,
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74ac66f22e..2c41cc2b3f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1566,6 +1566,14 @@ test_expect_success 'stash export resolves stash reflog selectors like rev-parse
 	test_grep "unable to find stash entry stash@{2}" err
 '
 
+test_expect_success 'stash export reports entries of an empty stash reflog' '
+	git stash clear &&
+	git stash import refs/heads/bar &&
+	git reflog expire --expire=all refs/stash &&
+	test_must_fail git stash export --print stash@{1} 2>err &&
+	test_grep "unable to find stash entry stash@{1}" err
+'
+
 test_expect_success 'stash export rejects invalid arguments' '
 	test_must_fail git stash export --print --to-ref refs/heads/invalid 2>err &&
 	test_grep "exactly one of --print and --to-ref is required" err &&
-- 
2.56.1.windows.1

