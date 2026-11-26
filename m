Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694293;
	b=CHbIGfQjbWzDmPC6lsBosXwx7tqHklQTsnASHqJTF5G9nhaft8gg6z8YRNN0ZURVvAGE
	 XLJrDhUUHwBLGYj3epaeWruzAwU5nK/b5pg0jWnAaYMBOOSPBa7hqTqE/KrxJ/JEDtAlS
	 2xJ/lv1SUdbHRW5m44Dc4WrrbtEpQjB5tVdeukoVx9/KOjfFE4scrzE8kgts6bao63A1u
	 xDj9JRZfXJKfejfqfbtHa/E/ZFMNUMVcQdBPlapBezcXHNCbSxuoPjW+Bj2frxqLAtgxi
	 lIuddul2tS4pEg1p7D3jk8szxVuY05Fp0IqkDDGTxt2fVbzmoPd7kO+sf9qB03hpHkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5DgKhwBPDWROhzraz3bQdmuHOxm4smHapXu9daHc+lQ=;
	b=QawdXHaNCqX9rJo5MskFQr4vH5Y0fBz22vG04HW0NzJI8jRrlJpUD/iDuX2LKflZHrda
	 2YEeIVeAIiC/CPRRRiuFxqXmea2o8CQr3fr/qpd+GSKTOBgeIsSl9egHjbKweSCzagzQI
	 1BfuziUpr8TDfH1ibJdOiE7KQyuTfiC6E1DUGBrmptC02BhTdjygZTRGNPqVoPqwUCN/P
	 5giTELt7Uq8ldG0EwnmeFi9+i7uE0MoW5My6+L4bUPDoeCFgDpJE8sj1cOfsov7UDPkHE
	 pogNrwAsBqFZMaZvzwqT1yN+sBD8m4TRIubBWHyl4f9EbLcj5vm0XfdXSRdue2jt9ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dITh5V46;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5CD606A33C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 11:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF5CD606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dITh5V46
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38699cf08dfso8461388eec.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795694292; x=1796299092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5DgKhwBPDWROhzraz3bQdmuHOxm4smHapXu9daHc+lQ=;
        b=dITh5V46P/Gj5lCB4ManHC1LjDQXwWYeIP7l6jXjSZ23yPln5xZBkLZsaykawrlRcW
         cKqu3ZluIRl1+rRYSxicE9EvNzgSME/Ur91UwvXq9TvTgLoKeMiHCms4HcjxrUKuQt33
         bxY0uxbbx8hZtn/QdGnhWPNcEF/Z5oQ1xZnRZD4b7GeeBEyNyiCyH0OE7+SKvIWYRGvB
         SztbqiiXkddLTNpx+uh9NB+4deTBJzQKXtAlr9WSgwO4UncExbS+hgIsosM5zBhdYmoF
         B7asWPH2LGY9/sKoIA6aNAjWX4dsr1V/rlwsgdRxgvqCR0c8iYmSZPc0CSxrBQS8vA0U
         SzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795694292; x=1796299092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5DgKhwBPDWROhzraz3bQdmuHOxm4smHapXu9daHc+lQ=;
        b=2y2N+XervoKF/CY+gG1Qyk+7+AXK0YBVyu8Pr6hg3K/AS91PY2a6R0eQL6Rr5OXqRd
         3/j9D7y134NuLQXVv3Ut02zwwNtZQ1wIq7Id8oaR0pYo9pj7cnjUABYHoriyqrJltvOD
         cg2MpUtYEUanMVvKJ+F5Btu3FVTNCWbaJY21xHKLLZFSPd01NcwE4IuoesyJgx9pX2Tp
         XqVIaJ320KO3xMI224lVO4uGo59AGn1qp8yMnOSIHplJC13r5TEaB8UR0gDR0jRmcWYg
         7zeQMPbKKQIFsE36f7iH/VCMqjZgbGb5ZsAVWaBc50VtY5/GeIGEYiIfuqQeTgruyZF9
         e7cQ==
X-Gm-Message-State: APuU4Z/lYwf+mtzsiXGiFWG2vO5KJ1b5wBmpb/eyluiUkDLAkPGdkl13
	aK/6C5jfPkrgR0KarCqscqhEqezpiPCsfLAHvpWiHIhfCafR+Gisjmyds0PxthqL
X-Gm-Gg: AZFdTZe5vIWQCG39WowOYMVGeEd9TjH5u2Rf320ntOtgHWt6uUI5q4+BGOolijHEGBL
	qkJ52uytHUHSnHVZ5so8m1OW71cLEilBJPBuTw9tL0U5td7WDvd63+YltZ4DaLKGBzV1eH2VfgP
	ibVvkMwHQGgEc0yLnAvTSp56ZwvTdgQDwJ0wgDAwd466vKHtoAKY9V7scVSM420oOHp6mVAi4Jq
	qV1FneKvbI0N9JGM0fY0e6WCj6ZaWE1BAHH5bWvRlqED506fXylcBUEkPvR4XBLZ/0FqaCDRuxW
	tpQm2XrqW6qP9ttbmPjO4wzYCC8lBNpmPp6QMOB5T54b4yF4Alm/p5yfnr9vHQrkbYMqW8Yl3rL
	4ZYUdw6DWIqqsUKeHzUWFPDg9XypJZukSQmZ0iY+wq5BcJfuV2mqEBTZKBZ/5IUWh//9v8Bh3u4
	SnfrBByqYXBF6R7YQNuTxTW1RRfb+j1b1R8+zI1j+mRbPGNTRZGOoXO3kCuZD73TDhZMbFdu5Iq
	kU1fz04i6bFDsp84KI+LTHHW9t9LR7T/10cVVtNHGFMwsgX3nFxzBrjP69cUAs2eFmCkabML+9Q
	hVAvjprjUakPoYNkov8LmlUXFhFw67+GBFL2LLMZKS92AIxyUgOZZ1LO+pQqY8JN4yF4cTc1cCa
	SQo6oSFr2vecLF6/AXsnpPg==
X-Received: by 2002:a05:693c:37c8:b0:386:a0d1:1b41 with SMTP id 5a478bee46e88-386a0d136aemr22740072eec.34.1795694291782;
        Thu, 26 Nov 2026 03:58:11 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm33614470eec.0.2026.11.26.03.58.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 03:58:11 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 1/3] remote: add relative_url_gently()
Date: Thu, 26 Nov 2026 17:28:01 +0530
Message-ID: <20261126115803.30015-2-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126115803.30015-1-aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
 <20261126115803.30015-1-aniketgupta3001@gmail.com>
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
index 2b7d26b844..3bca10364e 100644
--- a/remote.c
+++ b/remote.c
@@ -3108,7 +3108,8 @@ void remote_state_clear(struct remote_state *remote_state)
 }
 
 /*
- * Returns 1 if it was the last chop before ':'.
+ * Returns 1 if it was the last chop before ':', or -1 if there is
+ * nothing left to chop.
  */
 static int chop_last_dir(char **remoteurl, int is_relative)
 {
@@ -3125,16 +3126,15 @@ static int chop_last_dir(char **remoteurl, int is_relative)
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
@@ -3176,8 +3176,19 @@ char *relative_url(const char *remote_url, const char *url,
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
@@ -3205,6 +3216,17 @@ char *relative_url(const char *remote_url, const char *url,
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
2.54.0 (Apple Git-157)

