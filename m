Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892532;
	b=lUHYPwaeTH7uthDAirq7VjvRCnFgCgzon+gduWQgd4+6Ad9qxeiwLPxMac7Rnd/z4csz
	 qdhice4JCd3XIap1ZhCmRFfvcT3lhFWkL3HLV8uvmhGkMtXpaY5Dmcl21MclOpLrX2bAr
	 jI92nbwuOkp9IwoScFbz0Qwv4C73iHGtFp22RpIGInwvGXSwxJT/Bv+iAKb+svAZa+mMH
	 kwMjoad4daBxBXrD/T1TbJdYZXeFSu9Z5biGbpK06s5FyUS8NJTnPzveRCOFeeHEzLD95
	 J0894ImKLarHRGWBjC3rtHTkLfuzdZuSdUkUZpT9ATnrYnT4exD4WLjvjrHYYEj3O3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3zwR15QVCMtswa2++rR4uaj6tvgEZn8NBxysBouUWxc=;
	b=jmHBacqg+eSsY05exhfzgZKcbw5SpDC3Pzfd30oDcZueIvLc6sRj1D3IhPYr3YOC5peG
	 lR9kvnwmdIVRydSDD0PEzYIS1tVdrgBkbv3KXUpO+M/+VTYNw6HcH/5tlAl5dVXAfgmlN
	 SkVac6COAr4w2hSt7FsawGH9pVerA10UwaQJm+0jmqTOSt0BpqVyad7LjdEetsQRQXt2y
	 tzb8Oh7FgeADkiLs9uw1bD+EbQtKSEKddSCrrm1kssSSP8dlTKGXpVX9qhq08lHDOHLxX
	 l/Hz8gTBVWQcjHZLIqn22se2m99IOf8kGXa3iCRxh7ItZxFpUBUcr4vCXc6fsqOQltg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r5abQGen;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3C606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EB3C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r5abQGen
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36cad25b8b0so2954653eec.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793892532; x=1794497332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3zwR15QVCMtswa2++rR4uaj6tvgEZn8NBxysBouUWxc=;
        b=r5abQGenfxyr8YpAM/eKmYTHGsF5CxO9c8ibCdytHaN2jdvOCSyTW7G2EG9SkIh+2R
         hK4ztlh9sce5bjPKxXfvSwNqdyWtuSeRd7DbVJbNbv7cbmHPaUdA9fxikLa+5SlKjB7R
         uUCqtSbCuXYpCVSDhL5tbigQq67qIApOY9lkRUhQaSKv36vyCdEc00rQZ1IDTdcRod3c
         /di+nowV35+8Ii0Rjyu1yUtHRh1l1HRDFlByYTCWeL9PCh9bj6JBkmnwB00uFgF7hAC3
         6rnJMATtUvSi4QjShwPQx7dWvV8ulL0LtjLULGd7HNEEVQt4uri/QPQh9rbNAFtYaibU
         mQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892532; x=1794497332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3zwR15QVCMtswa2++rR4uaj6tvgEZn8NBxysBouUWxc=;
        b=219odFPyntPcfNC8an1l+M33ZcMPxUsJNsx497kT0TsF0nz4hOe/HKxapck/ryMIVx
         QiEAeEk0RfuXxTCLTCcO98kTNrzM9oW2/0fri3SSavM78njqd3imobnwU3Oy0c7R7Yt9
         wLkakVCw8Yfi8zrcNClMZjcibl1HQc/b3qxkhdZEttsuPR2kRKA5GNg6fViMUAst7SXS
         M6KYcq37XbDUKRk4RmgiWhVbUFTeFVeBHNDdTR4Yh40FvdA57YQovfNniija32iZtQO/
         1euhOT3HKHKLe1n+Tvd2Bos1UOOjrqtokOErOZKG9tHwsPrG5kpf9fPNMhLOthUC4Tr0
         tT9w==
X-Gm-Message-State: APuU4Z9bCx/wJmXUicwsfC4D8zjWlD9hvEmSl1ZHPrXFzFohE8/aA7Ho
	iPuukOYCN+N67AJMmMp1CG/5tOkp2YvVWCazXAvKE1fWB29lO4s8KWJL3ml9gHplzks=
X-Gm-Gg: AYBFou1U0UxXkWBlZ7GqFqNyRf9owKmwuNIiT5s9ar96uEkedR52IjkQQqqo3/EdmhN
	qk7qD+qwbbykq/elh3E1wCw5k5dM/YKj/uWU6Sf4aREMCCwMdsJ5KLUr/dEJsZve3tz/2fvT0to
	DcNoynbNZ9LbVhoZ7Jcnc5TO3hr0vsXB8LAvqsFFWdURZAmK4LgHPviyO1ygEBpReCNGQm0qFin
	Nadrw8ARiaCR5qZTy7b5HhxKETeRouINR2cbGkAwWbSQvp2ko+XZa8i6WfMZ+pVYH3w+u1Gp493
	b1mMAJCmjz4lhaXK19p1CFP1yBMSM+JvqQm5zpc7a6jbvIqEA6OwMaBWJiU847r4jWPu0m7EXMx
	/lPZJoqlXhVcoqvw70aH4Ag+bqXp5+z7/YiYooGp8KKCSf4WeAF5V5R1sNNGnlg9HzqrAJP7gwx
	OubU5sXUiJez7Xz94R/O4OzPVib0DxbnXdLriDDB2SCaIkKgYJWm+jCZyTxMtjVdhtd0H3LtY6N
	tEUxJUGUAN9tJKaJBkEIDg85B/VacQCCNrSi0GF72gCXW27SIBFVnqx7ADh6PViP3N386QQVO8o
	v0k08ATvS2xNSD8GNi8cakitff8YpUr63nZ90w4j4Ge13W9KV1GLyfD3nYmEktacvQ7uIELFGrA
	=
X-Received: by 2002:a05:693c:65d2:b0:36a:18d2:8c79 with SMTP id 5a478bee46e88-36a423c0bbbmr26473835eec.19.1793892531470;
        Thu, 05 Nov 2026 07:28:51 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39972d4sm32391113eec.26.2026.11.05.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:28:51 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/3] remote: add relative_url_gently()
Date: Thu,  5 Nov 2026 15:28:40 +0000
Message-ID: <20261105152842.566318-2-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <20261105152842.566318-1-aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
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

relative_url() calls die() when there are more "../" components in the
URL than the base URL can absorb. A caller that would rather carry on
has no way to do so.

Add relative_url_gently(), which returns NULL and adds the reason to a
strbuf instead of dying. relative_url() is now a thin wrapper around
it that continues to die, so existing callers behave the same.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 remote.c | 34 ++++++++++++++++++++++++++++------
 remote.h |  8 ++++++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 49ee2ea318..899d805b76 100644
--- a/remote.c
+++ b/remote.c
@@ -3005,7 +3005,8 @@ void remote_state_clear(struct remote_state *remote_state)
 }
 
 /*
- * Returns 1 if it was the last chop before ':'.
+ * Returns 1 if it was the last chop before ':', or -1 if there is
+ * nothing left to chop.
  */
 static int chop_last_dir(char **remoteurl, int is_relative)
 {
@@ -3022,16 +3023,15 @@ static int chop_last_dir(char **remoteurl, int is_relative)
 	}
 
 	if (is_relative || !strcmp(".", *remoteurl))
-		die(_("cannot strip one component off url '%s'"),
-			*remoteurl);
+		return -1;
 
 	free(*remoteurl);
 	*remoteurl = xstrdup(".");
 	return 0;
 }
 
-char *relative_url(const char *remote_url, const char *url,
-		   const char *up_path)
+char *relative_url_gently(const char *remote_url, const char *url,
+			  const char *up_path, struct strbuf *err)
 {
 	int is_relative = 0;
 	int colonsep = 0;
@@ -3073,8 +3073,19 @@ char *relative_url(const char *remote_url, const char *url,
 	 */
 	while (*url) {
 		if (starts_with_dot_dot_slash_native(url)) {
+			int chopped;
+
 			url += 3;
-			colonsep |= chop_last_dir(&remoteurl, is_relative);
+			chopped = chop_last_dir(&remoteurl, is_relative);
+			if (chopped < 0) {
+				strbuf_addf(err,
+					    _("cannot strip one component off url '%s'"),
+					    remoteurl);
+				free(remoteurl);
+				strbuf_release(&sb);
+				return NULL;
+			}
+			colonsep |= chopped;
 		} else if (starts_with_dot_slash_native(url))
 			url += 2;
 		else
@@ -3102,6 +3113,17 @@ char *relative_url(const char *remote_url, const char *url,
 	return strbuf_detach(&sb, NULL);
 }
 
+char *relative_url(const char *remote_url, const char *url,
+		   const char *up_path)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *out = relative_url_gently(remote_url, url, up_path, &err);
+
+	if (!out)
+		die("%s", err.buf);
+	return out;
+}
+
 int valid_remote_name(const char *name)
 {
 	int result;
diff --git a/remote.h b/remote.h
index cca02033b9..940474fa71 100644
--- a/remote.h
+++ b/remote.h
@@ -478,6 +478,14 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 char *relative_url(const char *remote_url, const char *url,
 		   const char *up_path);
 
+/*
+ * Like relative_url(), but if `url` cannot be resolved against
+ * `remote_url`, return NULL and add the reason to `err` instead of
+ * dying. `err` must not be NULL.
+ */
+char *relative_url_gently(const char *remote_url, const char *url,
+			  const char *up_path, struct strbuf *err);
+
 int valid_remote_name(const char *name);
 
 #endif
-- 
2.43.0

