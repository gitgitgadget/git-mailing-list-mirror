Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416272;
	b=m/P9TdwxaKp22KWzD7ZgBpRFU83ow/+czKoj+Z3oGHCKv6Of5q+/3dnIlZHRJH3drgjk
	 uPTp2nma5EWxA5vcAslJEXpk0cfWVp/IpzrGAR2/fzaAlVU8iiH3jjfkkd7FUKRQaQhZo
	 AU0lmzZBiqaALW36UzOVReWb0iasIkPkj1h3lTgATLLx2jjvvuzAZFJHoRmOgT2hnFg3y
	 h/YQ9Ty1kr+o8THgfbBcjmz4h2/Ngg2uPpSygYELP/A3C+RV5qGCyyca26zBWwmExA4a0
	 EaCCs3+GlinXdBlhRrgP2ex0xp3BQNHlW8fSAlk7y9mWnSh7EKzeexjnBVHKdrWbtEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f56sKJerVTR6XdJwAIWQNmvH+I8eyozJClSiLPsycXE=;
	b=cby8XokZJyfkXeFXfqRe5OhfDcPKXI69BFa+lEXE9kSgqr+u0p3pbX2SbCT6TPzAjSQ9
	 YAiAJmEn46zlqsaIrdHvG71z/RCFgOLzdfzqr9Lv63Nmpbum80RXUPGUs98Qf/H6YjJ/Z
	 LBzPNF0X6PQTjpyrzcbTBPVttJrI09yAfX40MzP5PVq3WdoYAs7M2xUNUujUnsRLCnaqF
	 Ug6y7qq7y6UzUCoZ/V7NeYUnePony1WIBd3qpV8aFSQe5acNHiNO/0rC9Ayjmh4rqrpkp
	 udlDrhZbuh63kfhvKRZSeA+qLOD6GOIWRTCzbfFUO12qiDPQG0asRUq083AoUFkhG/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PdMoDFWf;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50A606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 06:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F50A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PdMoDFWf
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so912458b3a.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 22:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416272; x=1796021072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f56sKJerVTR6XdJwAIWQNmvH+I8eyozJClSiLPsycXE=;
        b=PdMoDFWfYKnwEasooEXcyqI2oZ/dsTmo7Ill/a7gNZxKhW59taVwIu2OCP2yu7Zx+X
         Sduo/O1SqN4I3Ay/ynmC7OCsPdK5+BstDrqp0p1mZIet8Z5qNb4pgPvJZGOLkU2giN6C
         Ivc98GQa01ZseIK2dQEjakek+uzIjHyIkJUXUBY3ThwSlzw9TYJTwbe519OQ5/ulm0Fv
         uJbU7bDZZbvQ0nx01kNTzYSC+dwNPCbKb0RkCe4h/nl6uZLFdWTGviAukC7ig9LVKY/t
         PfHa+03AJmXiPtLv4Fbg2ddW+os3pcons3UTE9Ee6OW48fDr05pBLuhct3jHTwSPNC/v
         /+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416272; x=1796021072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f56sKJerVTR6XdJwAIWQNmvH+I8eyozJClSiLPsycXE=;
        b=Iq08bmocu6OPYm7S/sJ963OEi3EQTwYp1FZNBA4wp/xUG3gS4qCW3HWtMSscTW9PUC
         rdyVzl7UMPJpXzX0vWiRkJi53hbTcDwNI7TOFcUZ1ZEZ0C/j9sNtMJ4JQA0DwbUuqRFV
         O0MiL7gmT7CVnYGIJ3xJbEmefij7H9uJoIajMwYP0ydev++Jrbexl7b/ziJ7nZPnHZKe
         Hs/YxWdqZJss+tqJaq/y/cMM5SyeiHY7toWXQOmbsoQyepMkwRZX6ogxnOEwBYJP8gjT
         ryMqaLi0nZWF9yKbTaUEvrWGNrCXfErr8go+HuQrJPs0P2zrXRrJpYNZynko9gzpFKHC
         QQag==
X-Gm-Message-State: APuU4Z+dbdJCuC0z6sQSX87OSPpydR152hcNuyTaPpqwwYnQOOrBGJxG
	RoktFAZNZXej2G4LBJ3d1+59lXHGtCr/YVTAQQAGfnLYCwuZkCjPQAS1bpZ66Lze
X-Gm-Gg: AZFdTZcMSVi0gkF+eN/C5+Q2iR5aHXRP9qCOSbm5LsB0fEUM29wNcib25UEt4mZoYE4
	To1n7+Ts4ZklI1Pi8MUhkG41m3FnW12hypwP0fOToMx4g3vPbihoq6/H8jH2SqpELR8AlB3njVC
	r7yXUU/ZitkVkWJYei2QkyppQiWYb6nkj2Xy3GVZYMUthRDZmSdNn+y+oP8ShnZRsdW0+rUkPmA
	zc1L/R6r6wUwVfy3ULMK6PB4VpP61KjvcV2qoVkABAr72nTgoR9asX/nlSXc5GakEGyBnDoPFSX
	iwhN7rUXJz0AmL+d2Znu3ps22BzN2IYWaYsjxeZpQ9PPlgan3IwWdcSTGJQV+CwMT1IyG3p304x
	y6OyDXJ3iNwkuGfK2zyMlbuSMlHPODLCILH4uQs6YYD/5ZOTa93aOxcepi+I88+cinSVhpNhG+h
	9414RBcVw4GRxtbVrUfvb6Gf3CheIVxESRsmdgjYqHWpx9BOvrBBLF8EDvPU9+q6htVeWeDldbJ
	6pdLn8zjlv9XIyPeFQiu//q6sBSI054SWpeldvFwq3hvCOFOJhIowfyLWJDmC0+XYrZykTd/vsF
	ObDgq0yBvTIYvrgLPbl0AzlNxci0wh64OZ1fLyuYCtdo5SimVMCHM5la/Knktbowf6jw/4193Ao
	MbzUPXHdfKrIGqKSew9Ga
X-Received: by 2002:a05:6a00:a118:b0:8c4:b4ff:45b9 with SMTP id d2e1a72fcca58-8c8793b91bbmr8639079b3a.7.1795416271574;
        Sun, 22 Nov 2026 22:44:31 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1e2f3sm4798671b3a.54.2026.11.22.22.44.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 22:44:31 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 1/3] remote: add relative_url_gently()
Date: Mon, 23 Nov 2026 12:14:20 +0530
Message-ID: <c9afd483dda0d52411a1e0c762414db2f4e2fed8.1795415793.git.aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1795415793.git.aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com> <cover.1795415793.git.aniketgupta3001@gmail.com>
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
index df069e802f..be561d633e 100644
--- a/remote.c
+++ b/remote.c
@@ -3101,7 +3101,8 @@ void remote_state_clear(struct remote_state *remote_state)
 }
 
 /*
- * Returns 1 if it was the last chop before ':'.
+ * Returns 1 if it was the last chop before ':', or -1 if there is
+ * nothing left to chop.
  */
 static int chop_last_dir(char **remoteurl, int is_relative)
 {
@@ -3118,16 +3119,15 @@ static int chop_last_dir(char **remoteurl, int is_relative)
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
@@ -3169,8 +3169,19 @@ char *relative_url(const char *remote_url, const char *url,
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
@@ -3198,6 +3209,17 @@ char *relative_url(const char *remote_url, const char *url,
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

