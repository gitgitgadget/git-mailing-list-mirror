Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEFE330330
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026937; cv=none; b=n+RWYHSSk8PTD911SkUZJYOSV+mathHTQMV7drH6ZeFPfDKdk/P8X4oW/cKyTTzNQ6dR8BgeVrytnp6OZjZowk0w5FEECrI5PzuDtj9HCwOsR20SK0U5a/O44LB4xOC5WKTJpBn3WnuRlhJ+CI/7cJcnXxlM4GW1+rYlVJsDHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026937; c=relaxed/simple;
	bh=huTNhMYL9zmfhTir7P4A16k9VB3OBuliYyxVhOxbQ5k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m9CGm9w3mPr/IxiKrtsyEMdQZidv7GYlBnXqEYCsb2AXs0R0Wf6pHf93JfVUiVII9SbJUW9BZlV8Xhg5/bFDA0BQ5uHYRSYLYOhRCLHCMyPo4O1dfwwd14K88+CDub7vfhaTgyMok3I0vfCmp8OtVFOlQcB+jb7CIzPOQeULV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDpkjHBQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDpkjHBQ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c7199e7f79so194668585a.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026935; x=1771631735; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao+nheOyDdI51UJpwkpo58cE+2/UdPr9zDVKsEq1TBw=;
        b=YDpkjHBQq94ublWBDVJwcxtbbRfy0iyR4rYHN78pvrjg1r0tc10prwhdRBaSTgrRyR
         JyqbEyFHCWZpISNvanPn8e2vttblNylK5AlnfiZ7Fp+kjvSikYLkpcLc2PSUTfFqBKuO
         HX94jeAiWyyBx+CsIBEjXNzxTyOv61G8iumjCBn0n5MacGvxnw0/j6ou1AIv3IPh/B1h
         JDp+I8gU5dFGKu1uFPYzp9vLbfSFsK7sghMfPLPuUSgg3BohkOeyCAkbRUi8BIRBDrAo
         YNauDxEO0hC+2XkVWV5aBc+6Mfhht0qdU1zjz+D8shEz9SU58pCldTWf7J7jQcFPKEqh
         8EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026935; x=1771631735;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ao+nheOyDdI51UJpwkpo58cE+2/UdPr9zDVKsEq1TBw=;
        b=n9Ar+safUVaoX/BZyZl+u+jpJwBDFigaZcA23wXMczw4JTNHIKfEZ5ZjeR7VZMAtCZ
         3BS2s0eibltdgTqkJ21ecvmQuDfl2PmAhyy39kzQPYhp4Oi5YDOVE3i0w369u//gER0U
         ls/bIzaWNkyI37H5mS3SX8uj8Pf2IxHolRXomXSp8748k5d/4L58fmKz2RsPvhqbzY11
         rAoLRdHoIK6Qk6KAInhWEJStzuFy/W6cDr3vV37fUMcNcD808wgZ9J9B4iyLGVXnNOhk
         7WFYmq9anQxt+8COOWY5Tdjg57N0LFc07iLA1K09wGCNL+TOpCWLLnsVs2F8031slhwB
         bKGw==
X-Gm-Message-State: AOJu0YyUpk398Lymulvb4BRUjOZXafLNJDnC1dc0v19Gd71AEei1b9vu
	IIcm74BzAo5ZLTKRDYUxsp2Lpc8RvKYws1bsWgvgDdvRy+qUVqyz1h7igOXXNhvr
X-Gm-Gg: AZuq6aLwIzu2OqVM+p1d7f/TgCpjrEmbqQ8K7ZpRHLKGcnW7/VqPiKHHAELZGJi/doH
	2/QakmfhjAaQW8nI5/0VYKjYMmst5pYZwDeHuTVx3IaulF9sVz5LOF+Wv9/ZtcZkQ0KK19QOK6O
	niKOag+iVI7iEil7QqCldbHI2kEl79+yKCw5S0qT04WUJD8FOtq9yXpz2kkxNGXif6jp3fKym9q
	e0n5EuceZqWle9xuP1QIa/FHKgyJZ7HNwmHrs3iDWiJR/0IAdASc9BZnUJ826P8dh1CuPJTxQJy
	YBtNTzI+99JZrVQQAjdcflnsHKnJxd6C+Wk8AKkJDyzUR5EWws8pyKRJfcPkaGciqJ7N1sLModM
	6ASea8SdNThfu/S7zHZ0YQqyc8AFOOzsdEHuCIpMTgUEZ32x/c+Mg8ejsXoyGSdL6FSOlVzEb36
	TVwtRjDqKjuiMk0xU6ETe1FJ4T
X-Received: by 2002:a05:620a:2585:b0:8c6:afa6:2700 with SMTP id af79cd13be357-8cb4bff24cfmr172979085a.47.1771026934757;
        Fri, 13 Feb 2026 15:55:34 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0e1bdbsm705464585a.17.2026.02.13.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:34 -0800 (PST)
Message-Id: <3fec3abbd62307bec885cab0198007c13f0f1d8e.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:12 +0000
Subject: [PATCH v2 07/13] config: format bools or strings in helper
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
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Move the logic for formatting bool-or-string config values into a
helper. This parsing has always been gentle, so this is not unlocking
new behavior. This extraction is only to match the formatting of the
other cases that do need a behavior change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2c93e1725b..0c539ff98e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -302,6 +302,18 @@ static int format_config_bool_or_int(struct strbuf *buf,
 	return 0;
 }
 
+/* This mode is always gentle. */
+static int format_config_bool_or_str(struct strbuf *buf,
+				     const char *value_)
+{
+	int v = git_parse_maybe_bool(value_);
+	if (v < 0)
+		strbuf_addstr(buf, value_);
+	else
+		strbuf_addstr(buf, v ? "true" : "false");
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -333,13 +345,9 @@ static int format_config(const struct config_display_options *opts,
 			res = format_config_bool(buf, key_, value_, gently);
 		else if (opts->type == TYPE_BOOL_OR_INT)
 			res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
-		else if (opts->type == TYPE_BOOL_OR_STR) {
-			int v = git_parse_maybe_bool(value_);
-			if (v < 0)
-				strbuf_addstr(buf, value_);
-			else
-				strbuf_addstr(buf, v ? "true" : "false");
-		} else if (opts->type == TYPE_PATH) {
+		else if (opts->type == TYPE_BOOL_OR_STR)
+			res = format_config_bool_or_str(buf, value_);
+		else if (opts->type == TYPE_PATH) {
 			char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
 				return -1;
-- 
gitgitgadget

