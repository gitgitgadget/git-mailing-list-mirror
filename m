Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574E4AE8B1
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197154; cv=none; b=Rfpg/hMqzYv6bxkMpRm7Jib0wU0uwcgPyiLG+YQZa5EpNeHIkl+k1VhQP9HLRDr15ouVLpT8KUEorj9deubuYhxSnarUIKi2ShQzMHFOGSryfZTZFixhqAOiAkl7ZyACO1h+391mIb8/kcAp1PaaRVBwzektnkOGaa1sX+rCx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197154; c=relaxed/simple;
	bh=b9dvCr+PiCyZylU6gBIjcbu2QRku7DQa6hUE0fgGobU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oMhYuSGLG2Fgn123SM5JKYTWKi3/EpRafj3DF3OZFFA1/RUaZpARXZTg8Vb2tGE5MhsC9JGteeaBeKFB07TN+psLqgOPpQm+NEqdGlwV4l8EWkA1xx+AhZuDmTFoR0TLAFlsnjwHllKdK15vJlSClhf26Nm7akc54HkEsOyOqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKvfFG1d; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKvfFG1d"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52f9fc510e1so1242941cf.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197151; x=1788801951; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=toQmBdd+jxqMuT/b0eUHtWgIOQ9Gq0hxiSHcBS/Dg+U=;
        b=mKvfFG1dfd5PZ4PAN7nApyaNWkqFnoGIdixRTJvHzVqNXxJGWY8QUcyN1d5GWUn/OO
         t8RmKC0dZBUhFOZyceySN1lSq/lPVnh50coz3cMBZdqYjKFiXGm6Z5b3u6AIlLpOLvsa
         O+tx5Z7OWaVrYOOnoSKTkCDLob4+39GgF04ahv3BvA3BZIB9/RzcMZ3azXtIp40t8209
         HMKlHkUZU4zNF8jMxNt/Kom9rULWhVKEFkTDjfFkIfHnqXhdmAVuNPu9emqFN4DQhsat
         JF3zJznjJSNGDIjVDwPQQxPxlXXf7Gp2rGLLuclacI8NGabrmqvrH3Y639kUiwhQxpwj
         uDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197151; x=1788801951;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=toQmBdd+jxqMuT/b0eUHtWgIOQ9Gq0hxiSHcBS/Dg+U=;
        b=PDtN4VyFwcVeS0BIbXY6oy/N1Dz/1DevN/vMwDhj5FF6Z3ea5RcSMKcZ3hvzcvjpVE
         4Oz/kY72bw1zq7Bqe0CEKB/5vyUuCA5ON/1k7WlGQlfutv7PvMnyseOlShS8dupfXTMD
         1ve+VcupTK+rvCMIv/cjUaoNU1h2vSRNNlkHhdfH61YkwUqHVRRVn1Qy9tc3qQ5Ywgr1
         3Ga7no/MBvfsd/Ph8IVdqoxWSzOfAtELfSfmUyy5opSZCM8hlfL+Xf60XmMbUhQckc5O
         l5JObrpp6CLjA4Z0dKhfGEc1YStmJXH1kySG9nDKbY2adQ+xPF6QNoTgRvrJwJu3+5Ey
         75fA==
X-Gm-Message-State: AFuF++m1+XfzGh7myW1H+Z9g1dLkfgFAA74vkr0HOf78+mJXC9YZDC+/
	8Nfj2R0g6hiW8V0hXzPSkFOkInGfP/Rrlo3u0d8+20axcAgtnMNi88UCDt2GExi9
X-Gm-Gg: AR+sD13lLsul4lsl3uBgXgsess+QfwasxCfWgwiQMJtFgWY9vV1SeISuPGyXmI5owh+
	TGQbvtuLLhgQJkTNLafpV9Z33k2zywz/l6ENAX6pO9q2N3A9b1U/Mc3OHNK1cdp+o3dm/YLSKMF
	3H2x4jWfiLMzGkIlDFdrNIs+HIfSFuJXto3WmpHKE4n+D+btSeIMCtzee5WfFzYbo9nj9y1W5KM
	PM3FKQnEvZakpMTAnyfFuP25OScH4MLHCXF1phwwGnXQqjR6MZCjX51IyHLKyYHuh1ItpH6YZ3p
	HS8LOWTfvwtVbdw9ivA88S/82vlhW5Tg3tueO7Z22/51XM+oYuTcqa0+WLKrt9KPxvH0nGdBLib
	oprbmCptsuGz61VufMa/3KSu7hDCtw/EfdCeySGzQfJ2cc+x+9cwlGXBIwR+HkeedJUrjvZbMMu
	CtkmpnxX39y216FebNaebORVHR0GjEmmMMZDGf6QjECScp/WTZV1z7iQLQKtIq2WqT
X-Received: by 2002:a05:622a:1b91:b0:52e:f047:5208 with SMTP id d75a77b69052e-5300b72dde5mr105763381cf.1.1788197151446;
        Mon, 31 Aug 2026 10:25:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe5495easm76908611cf.2.2026.08.31.10.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:25:50 -0700 (PDT)
Message-Id: <3e419c55225f452f9472eac2cfb82aadb680a41e.1788197143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 17:25:41 +0000
Subject: [PATCH v3 5/7] trace2: remove use of xstrfmt()
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
Cc: gitster@pobox.com,
    Taylor Blau <ttaylorr@openai.com>,
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

We continue removing the possibility of a die() in the trace2 API by
banning xstrfmt(), which calls die() during a failure to format. Instead
of allowing a die(), perform a soft failure by failing to output the
trace2 data when such a failure occurs.

This requires carefully concatenating strings using memcpy() to
construct redacted data to avoid copying password information in traced
URLs.

Update t0212 to more carefully test this behavior to explicitly include
the ":<REDACTED>" string in the appropriate context.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h            |  3 +++
 t/t0212-trace2-event.sh | 12 ++++++++----
 trace2.c                | 34 ++++++++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/banned-die.h b/banned-die.h
index 0ad9a6c492..4d1800353d 100644
--- a/banned-die.h
+++ b/banned-die.h
@@ -17,6 +17,9 @@
 #undef xstrdup
 #define xstrdup(str) BANNED(xstrdup)
 
+#undef xstrfmt
+#define xstrfmt(...) BANNED(xstrfmt)
+
 #undef ALLOC_ARRAY
 #define ALLOC_ARRAY(x, alloc) BANNED(ALLOC_ARRAY)
 
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index f5358a1dd4..23df800395 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -332,7 +332,8 @@ test_expect_success 'unsafe URLs are redacted by default in cmd_start events' '
 
 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
 		test-tool trace2 300redact_start git clone https://user:pwd@example.com/ clone2 &&
-	test_grep ! user:pwd trace.event
+	test_grep ! user:pwd trace.event &&
+	test_grep "user:<REDACTED>@example.com/" trace.event
 '
 
 test_expect_success 'unsafe URLs are redacted by default in child_start events' '
@@ -341,7 +342,8 @@ test_expect_success 'unsafe URLs are redacted by default in child_start events'
 
 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
 		test-tool trace2 301redact_child_start git clone https://user:pwd@example.com/ clone2 &&
-	test_grep ! user:pwd trace.event
+	test_grep ! user:pwd trace.event &&
+	test_grep "user:<REDACTED>@example.com/" trace.event
 '
 
 test_expect_success 'unsafe URLs are redacted by default in exec events' '
@@ -350,7 +352,8 @@ test_expect_success 'unsafe URLs are redacted by default in exec events' '
 
 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
 		test-tool trace2 302redact_exec git clone https://user:pwd@example.com/ clone2 &&
-	test_grep ! user:pwd trace.event
+	test_grep ! user:pwd trace.event &&
+	test_grep "user:<REDACTED>@example.com/" trace.event
 '
 
 test_expect_success 'unsafe URLs are redacted by default in def_param events' '
@@ -359,7 +362,8 @@ test_expect_success 'unsafe URLs are redacted by default in def_param events' '
 
 	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
 		test-tool trace2 303redact_def_param url https://user:pwd@example.com/ &&
-	test_grep ! user:pwd trace.event
+	test_grep ! user:pwd trace.event &&
+	test_grep "user:<REDACTED>@example.com/" trace.event
 '
 
 test_done
diff --git a/trace2.c b/trace2.c
index ea021c602e..4a597d8213 100644
--- a/trace2.c
+++ b/trace2.c
@@ -261,7 +261,10 @@ int trace2_is_enabled(void)
 static const char *redact_arg(const char *arg)
 {
 	const char *p, *colon;
+	const char *redact = ":<REDACTED>";
+	char *redacted;
 	size_t at;
+	size_t prefix_len, suffix_len, redacted_len, redact_len;
 
 	if (!trace2_redact ||
 	    (!skip_prefix(arg, "https://", &p) &&
@@ -276,7 +279,25 @@ static const char *redact_arg(const char *arg)
 	if (!colon)
 		return arg;
 
-	return xstrfmt("%.*s:<REDACTED>%s", (int)(colon - arg), arg, p + at);
+	redact_len = strlen(redact);
+	prefix_len = colon - arg;
+	suffix_len = strlen(p + at);
+
+	if (unsigned_add_overflows(prefix_len, suffix_len) ||
+	    unsigned_add_overflows(prefix_len + suffix_len, redact_len) ||
+	    unsigned_add_overflows(prefix_len + suffix_len + redact_len, 1))
+		return NULL;
+
+	redacted_len = prefix_len + suffix_len + redact_len + 1;
+
+	redacted = malloc(redacted_len);
+	if (!redacted)
+		return NULL;
+
+	memcpy(redacted, arg, prefix_len);
+	memcpy(redacted + prefix_len, redact, redact_len);
+	memcpy(redacted + prefix_len + redact_len, p + at, suffix_len + 1);
+	return redacted;
 }
 
 /*
@@ -301,6 +322,8 @@ static const char **redact_argv(const char **argv)
 
 	if (!argv[i])
 		return argv;
+	if (!redacted)
+		return NULL;
 
 	for (j = 0; argv[j]; j++)
 		; /* keep counting */
@@ -317,7 +340,14 @@ static const char **redact_argv(const char **argv)
 	ret[i] = redacted;
 	for (++i; argv[i]; i++) {
 		redacted = redact_arg(argv[i]);
-		ret[i] = redacted ? redacted : argv[i];
+		if (!redacted) {
+			for (j = 0; j < i; j++)
+				if (ret[j] != argv[j])
+					free((void *)ret[j]);
+			free(ret);
+			return NULL;
+		}
+		ret[i] = redacted;
 	}
 
 	return ret;
-- 
gitgitgadget

