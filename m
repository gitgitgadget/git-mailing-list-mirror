Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788B184521
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935361; cv=none; b=Za70ysSUfYMhCdHSyXA5sysEpSIZIHpbpvXQ5UGM3K/wVyA6sBl62eBdq5mR1Zggt4IXbDCIRMWiTaIU2hdFRRsmDAycJm7TrArMZ0KrWKvp87/ml6ZJmJF/TQunwddiasppBAI9/4zSiIvLMJwbSdYwEXqhKMPEbDCdOt1Nfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935361; c=relaxed/simple;
	bh=+25DMw5JT39mPlKaeecjlM5vJOsWhF/gOktQ7wz7nRY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hvN3RVJe8wsgr2FOILRL/KjTdEfqUlwNMISXq3LVBpv/3l9tNGv1zfV0udYWHqxqatOlLn+o+JJMCo+yCjnruvEWoCqAR4sEcurDDAUEspbaNkl69knHgKkCgkzMdAun8AJPcgAHXIivYh3+LoWuS1vmK52vXzvrhC5KdSjwmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNXw2nR7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNXw2nR7"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d43657255so276571166b.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935358; x=1726540158; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tbkxkoReMZi9SHv05I5ka/s+XtDoF2jN9IpBDQDIZA=;
        b=aNXw2nR756/FHJDY7ZIQTzUq+4HIB7oTX0qWersE80iuU6gbE7lSJgXywyOoNUskUC
         yjT3uVVatFixmGRapIBxkCUEc1t1+3oYuBQfgpNRPvhTsOX1EJL6jGVQydFRjpS8SrbL
         ++tR+Nf/Kbxty+2ZTlX6SGlOG/nr4DmpmsZ+VKbAHeEw6VH4dAJH5zIJmFFjceVqB9N8
         R9rVIFdFwSMqpdWprEgUNCFIOypYPz7Zq2VqeWESiL/3yUfwMqJBiNor4h2MTIqJ+KOM
         62VqrI9KsVmaDYBZltgMVmUQOpqJ6TYHePLTaIuieDF1Eez2Fkug9YvNwQ4N5kJsw5M0
         /keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935358; x=1726540158;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tbkxkoReMZi9SHv05I5ka/s+XtDoF2jN9IpBDQDIZA=;
        b=WAIVrXbgFdMny6daoOAOGzPIQV7tgUN9v0YKuACBgpm+CJvbDJ6MDP60Mk9OspDGvS
         mlP1Y8HsBkiEbrYNSGLC6qQsd2DjhchpPLbgSC9GfMGGSfACnCzuvkojx0VY5zo2xrKk
         vC+5RoZagmN7cjtf+GYPeWUGk1KdqADat8xKe+DqpSinX4UvdgqmvNLTpeZZe7qpWnYH
         inrdyKarwf9E0O1wDzLlDUfb6MBmpp2pVf9JVKF3mlEzybpUNl9z+SCiF8j6OdOfD/ei
         oYFx3DmFigB7Hom4utAt7LyeMK9YkJEoxwBoWgqGCFK35Nq2NX4o89ePxgRw5rROFuKk
         BUKw==
X-Gm-Message-State: AOJu0YxqnAO+uR4LBsu5siyLQ+a0/Eu4W6ZitrKsyGlMKiGNTHClH5yX
	ASN9nhOnNGd/hiaO7lYwkmY7N4b9xEpyHTMtyu3Vn+9NSnxhdqIA+IQljQ==
X-Google-Smtp-Source: AGHT+IGl236GQxyeTpKQZRCxmjjlw4F5VsW2Y0N/JtFcCfpm+gHi5ZC3YlNa/Fgl+cIQGIWp7s8BQA==
X-Received: by 2002:a17:907:1c08:b0:a8d:2671:4999 with SMTP id a640c23a62f3a-a8d26714e3amr635411866b.39.1725935358172;
        Mon, 09 Sep 2024 19:29:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835abbsm415288766b.9.2024.09.09.19.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:17 -0700 (PDT)
Message-Id: <502008bb7c57327bad65867a70871ef0cf8898b5.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:46 +0000
Subject: [PATCH 21/30] pack-objects: extract should_attempt_deltas()
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3d0bb33427d..b1d684c3417 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3151,8 +3151,7 @@ static int should_attempt_deltas(struct object_entry *entry)
 		 */
 		return 0;
 
-	if (!entry->type_valid ||
-		oe_size_less_than(&to_pack, entry, 50))
+	if (!entry->type_valid || oe_size_less_than(&to_pack, entry, 50))
 		return 0;
 
 	if (entry->no_try_delta)
@@ -3162,14 +3161,12 @@ static int should_attempt_deltas(struct object_entry *entry)
 		if (oe_type(entry) < 0)
 			die(_("unable to get type of object %s"),
 				oid_to_hex(&entry->idx.oid));
-	} else {
-		if (oe_type(entry) < 0) {
-			/*
-			 * This object is not found, but we
-			 * don't have to include it anyway.
-			 */
-			return 0;
-		}
+	} else if (oe_type(entry) < 0) {
+		/*
+		 * This object is not found, but we
+		 * don't have to include it anyway.
+		 */
+		return 0;
 	}
 
 	return 1;
-- 
gitgitgadget

