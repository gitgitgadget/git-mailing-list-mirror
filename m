Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027985D74A
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707676774; cv=none; b=qF+WFtwDs7T/KQr5IE/okWIzJcebVK4LCqxBN3Mo0fGpid5EN5gNK6pwvHyTzxgI5nnhJ1lm3Zj9gZ/0zT4+1JwtGHpcsoBRniqMiLcI0LqFDecFsNvxttMZyJQ3gKXSOLoyyuJGBg1NR6qII52YePK2kgOog+UiIFww9uH0nBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707676774; c=relaxed/simple;
	bh=fdMvcQ3ggkXZxLDXfELYFogbCnL4yMRk39ONX3bUV5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv/DczQGKl7idDV9kRYcaeS2waDx1VY9Ov+d+/rmZF6XzzAhOR9EYEGIBwxBC/ZsubHDmGrB+LxvLNC5QlK2i1YOG95HJpY0RXH4IvUlfmFhg4OX/vgaMvi+0dEL6o+F/T4Y9rKaIsN51VIctIrdPyJQMFmHEVbWHR5fd2sopm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx9J15SJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx9J15SJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3c0efb9223so266476466b.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707676771; x=1708281571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONUj48aF3C7y99NgU69gpZnZKZCfgGEoHsbwW5vy4ww=;
        b=cx9J15SJzdNDBOdCQeTFPsum7kId89CAvoB+4TgfKoVzOS7YfnpWznUl8snT1flf2x
         ANga1fSmxga2YwR8mBoGz66w8zSqLUBOyfRV79BpCrR/jSyXL2cEMkkZ1aNN+icI94jS
         etGfbPlZWObKskNDOEWQGoVYAvPkS+cnIDFr+U1VBAsXMJXRwa+8YKSOBbYmlM+zB0L5
         9eLklQ7bkYNHkQdAkUVofiDR1xJRxlYo/JRxp0f7+0ebowarYLYiHY1AcZT8RSlcUTch
         nSrFLT9l6gia0JQIJQIUySsnygo7+b+q9yNo/Yh1H85xDVeFez75GbHr9GPo4HpuxbyZ
         q+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707676771; x=1708281571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONUj48aF3C7y99NgU69gpZnZKZCfgGEoHsbwW5vy4ww=;
        b=nvBSvoATZZDZm0Nwkh06trWVDI+UyvKkV5+uv9dppBn+LfbxVPCaOPKl3WxQ5RKoRh
         ubhcxxERq/+ZYkjd7H9IkBBnUEokY1bXIGTso6ltZ1exoQcymdfj1wyofUdVVOy3Ayuh
         MGKDSg1WKknxtnuhOfHLOiEzPJ8uSlJj4ybAauTNmT5AQohvuS9SVnL7tTDx9SiuQWDg
         SKBTfDczBD9TYci/N0WUtqwOaBn/I8c/Q4nkDh5SNz4YYXdlizMPY2Q3TQZ4cKy+2/sU
         YUDJ5X1NJSBDj3+XboLPEZmfk294rrHreGDZZop4VKqMrSKVFzLYvUMvV4ijET3xEzHf
         M8+g==
X-Gm-Message-State: AOJu0YxJq2Ks/4bovi84SXxvMIyjwzaXQ3vvDGjSwiW0dC8Te8QEf+FW
	MGTwbZ1thTRffS9ugcJyLn1y/bdCF20wlQ61nhCdOrCR/hzR3uStTYrLgSOJ
X-Google-Smtp-Source: AGHT+IEbbTT/Tt5Ibi9yU1ntYIToFIU8+883pZcMsAnYdiIYj6ZWPzOBqhqX0mq5vX7sD5qP0NTN5A==
X-Received: by 2002:a17:907:7295:b0:a3b:fe38:343f with SMTP id dt21-20020a170907729500b00a3bfe38343fmr6937230ejc.29.1707676770958;
        Sun, 11 Feb 2024 10:39:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXa3869o9kGB9G/fnsWOp6TBSnZsRu9bknc8YpZzdq3UAcCAhcN1u/dPe5+Z6HO2P899J7iqbpVAh+SOqScKS+XwWthRoci92BTtaGkya9p4/mkLpPRaXhA6BgxGhIX0HLqZ9Z/sZ3OlkHqsA==
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id w12-20020a170906130c00b00a3716299b40sm3069808ejb.155.2024.02.11.10.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:39:30 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 4/5] ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
Date: Sun, 11 Feb 2024 19:39:22 +0100
Message-ID: <20240211183923.131278-5-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211183923.131278-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag 'FILTER_REFS_ALL' is a bit ambiguous, where ALL doesn't specify
if it means to contain refs from all worktrees or whether all types of
refs (regular, HEAD & pseudorefs) or all of the above.

Since here it is actually referring to all refs with the "refs/" prefix,
let's rename it to 'FILTER_REFS_REGULAR' to indicate that this is
specifically for regular refs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 2 +-
 ref-filter.c           | 2 +-
 ref-filter.h           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3885a9c28e..23d352e371 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -97,7 +97,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	filter.match_as_path = 1;
-	filter_and_format_refs(&filter, FILTER_REFS_ALL, sorting, &format);
+	filter_and_format_refs(&filter, FILTER_REFS_REGULAR, sorting, &format);
 
 	ref_filter_clear(&filter);
 	ref_sorting_release(sorting);
diff --git a/ref-filter.c b/ref-filter.c
index be14b56e32..acb960e35c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3047,7 +3047,7 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 			ret = for_each_fullref_in("refs/remotes/", fn, cb_data);
 		else if (filter->kind == FILTER_REFS_TAGS)
 			ret = for_each_fullref_in("refs/tags/", fn, cb_data);
-		else if (filter->kind & FILTER_REFS_ALL)
+		else if (filter->kind & FILTER_REFS_REGULAR)
 			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
 			head_ref(fn, cb_data);
diff --git a/ref-filter.h b/ref-filter.h
index 07cd6f6da3..5416936800 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -19,10 +19,10 @@
 #define FILTER_REFS_BRANCHES       0x0004
 #define FILTER_REFS_REMOTES        0x0008
 #define FILTER_REFS_OTHERS         0x0010
-#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
+#define FILTER_REFS_REGULAR        (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
 				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
-#define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
+#define FILTER_REFS_KIND_MASK      (FILTER_REFS_REGULAR | FILTER_REFS_DETACHED_HEAD)
 
 struct atom_value;
 struct ref_sorting;
-- 
2.43.GIT

