Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E03793DF
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705171; cv=none; b=Sjr6dWpkzaQlDh77CJ/JqrDPvxXx3UHJhuqzvp85q1ZvOrfjrxPb6iCA0N+VYfDjNjeXUWFwRClW6mpEFFNnyly2GZaQueCblwkR05DKZXY9/Vn3zqrqjMXugZ5yo7ZB0Mnee8F4m/JAvw3K2Pb+IsZmJZJfDW4pEBf/cSZwccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705171; c=relaxed/simple;
	bh=qqUCZvyYc9eCeLsqXdLMQJpmH5Ankem1O9m7dQcXuTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3uqxRhpslD3cODtXIRAaUq5q0UvaKOO4RubSZ7yASzDggJZcdHNkrLnGcFrxm85swg8yc1vYiJRvPD+XXDrm9DH+ZprPG3Wo94i+A+38Kyax2mfG4CBgux7cHkoQe2VeL9otVe+iir5IZVDDUj+JfVYI8HonjpwlRwtOjygp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9A+BL/b; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9A+BL/b"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b941762394aso17322066b.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 02:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772705169; x=1773309969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL4LRv6ofYskFntRWaDKtXeppTkvdDT9SynfgyqPfT0=;
        b=K9A+BL/bkJfM2xnoy/o8uHdREOQdC3ZeRqmt8VZx1nNbHq7S7igX16BRr+Cey/X85F
         A6zenQ9hJ9SCmttCCL+wKguS906Ng+EX+IshPsvcHet0e6VO5FImvCIClO/5uOFM6fLY
         9PQdwoZD/fIfcuFXb+/ah1TXvaRUnMNERSFinspF3UQE+UKV863Ptu6p62Uz0HLQgy+B
         OZyGE+/n4zzQUaW5ZKQnwbuUKvbm+l8n2RZlzzLYre1y2gIk51i6dNoksnkOCo19x5DS
         nlzD0sSs7IqNXriaNHL4dp6Smdak/R69eBTBT2xvsKv5iJfXXIshmIGYOJS23TjUSeAv
         gY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705169; x=1773309969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sL4LRv6ofYskFntRWaDKtXeppTkvdDT9SynfgyqPfT0=;
        b=qCCDmtX8FeLr+3IPrHIYIvuw+GjCzn4eicOMOV+Gd5n4ZQKasce1fFPTTpfpBFs14u
         Pyfk5LovGZV/tcADkFE3BlqcilcSnee/+r2kaN83eZ5c5ZM9B54wGzNrcCVb57n5HkjU
         J3nnnihGxNNqxBAc9fsd2V5ynZgl0x+kAGU7GzG9KGiMLQyBEuQ1tsasVN0/vUJgX9Di
         up8BXyox29F1da/rthBGvIPYw5dkmcRyR7/r+o/Z6PSx8UOl7CQYvggIbtFh6Jw6ts7v
         irHm77zYwOr20naSmb0HQ3BI85p7SxPwUcxHCgeQp6F4WxfWruHD7z7e38hF8GSJ68fO
         djgA==
X-Gm-Message-State: AOJu0YxkPIr/rVVTxU6tY9ZLZ5VxnZSIqbnozP4sIDwP4S8H/+o6keR5
	rQ0u2kEv7DOTzwD9RkecJPGmjguxV8VUeQ7MjWJ1NSGq6jqiejwjE1z96S4GaS13
X-Gm-Gg: ATEYQzzt83cqDRtE5zlmKwnrDJYp8iPRAyy/JLOfM4DCLhcUZq5z48yqOfookcJMZRC
	pVrwPmrEoFytwHt1v07BuNp7IVITla5L6INHfnccNOylKhMnpz2pBewrPSVaoEzWsTbWWRupogt
	+D3fbdu8KvCFnmSWPIMY95ozz6NXxetzjp6ZoSMoO2SiszsQN3UlXf/lH5m2MIHjxTvqxqdaqD6
	KDSPgT8bUv/y55X12LGUCue0hRN7eoM+M8WJDbdONRx94Q/EXFGjq8udoICij+2DFb53tuOSw7W
	mEARk/xuG6EKdHf3IE0nn+/3LKMqUP50CtoT6fJn6RERGbPRuTwCp+URY2xlN3rlc7MiNcv2Flu
	fO1vesleNTuh2dF61J6OZJo8K0eNyhWjegqA/kjCLgCwhrMQfd57iVnS+VP9ldvpMkqXN8YogyD
	fJulTgEEtMw1GLi7jwaT3Q5mY5jHRzbSfeivp7V7NiwJJfSfRdcHKT0w==
X-Received: by 2002:a17:907:72d1:b0:b8e:9d66:f5fb with SMTP id a640c23a62f3a-b93f0e9d81bmr315757566b.0.1772705168291;
        Thu, 05 Mar 2026 02:06:08 -0800 (PST)
Received: from localhost.localdomain ([105.113.103.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac513bcsm879815266b.19.2026.03.05.02.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:06:08 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH v3 2/2] builtin/rev-list: migrate missing_objects cleanup to oidmap_clear_with_free()
Date: Thu,  5 Mar 2026 11:05:26 +0100
Message-ID: <20260305100526.102130-3-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305100526.102130-1-kuforiji98@gmail.com>
References: <20260302200018.75731-1-kuforiji98@gmail.com>
 <20260305100526.102130-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

As part of the conversion away from oidmap_clear(), switch the
missing_objects map to use oidmap_clear_with_free().

missing_objects stores struct missing_objects_map_entry instances,
which own an xstrdup()'d path string in addition to the container
struct itself. Previously, rev-list manually freed entry->path
before calling oidmap_clear(&missing_objects, true).

Introduce a dedicated free callback and pass it to
oidmap_clear_with_free(), consolidating entry teardown into a
single place and making cleanup semantics explicit.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 builtin/rev-list.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ddea8aa251..854d82ece3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -88,9 +88,19 @@ static int arg_print_omitted; /* print objects omitted by filter */
 
 struct missing_objects_map_entry {
 	struct oidmap_entry entry;
-	const char *path;
+	char *path;
 	unsigned type;
 };
+
+static void missing_objects_map_entry_free(void *e)
+{
+	struct missing_objects_map_entry *entry =
+		container_of(e, struct missing_objects_map_entry, entry);
+
+	free(entry->path);
+	free(entry);
+}
+
 static struct oidmap missing_objects;
 enum missing_action {
 	MA_ERROR = 0,    /* fail if any missing objects are encountered */
@@ -935,10 +945,9 @@ int cmd_rev_list(int argc,
 		while ((entry = oidmap_iter_next(&iter))) {
 			print_missing_object(entry, arg_missing_action ==
 							    MA_PRINT_INFO);
-			free((void *)entry->path);
 		}
 
-		oidmap_clear(&missing_objects, true);
+		oidmap_clear_with_free(&missing_objects, missing_objects_map_entry_free);
 	}
 
 	stop_progress(&progress);
-- 
2.43.0

