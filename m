Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7225037BE85
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705159; cv=none; b=EwMs5iZyPwRhXns41M9lRts5l/dznNmg9qcmzN958eVh4PJvz8AH6znvs8j3AxLP/OWdCuZdcBtgs/0sIss+OWgEzDKNB1qH3BhslSEiva6DggrtWdZrNQyS2ch6zRm88kAmaNbGhPx3k3IpckN1CHuKJmLI0yFaKLH2qxK5/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705159; c=relaxed/simple;
	bh=4G8woI5jPslbiZdMD9jb6VJkXVhyogTOGLRyZCEmyGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpy6wONDqb13c8SxnCzT2ppM1oEpkxbrjcHfe9ERsz4hlyJqH4ll86Oz39ito2KuWMkvgKaoKk3Yxp8Lh4Lr2215sCegP/995zLm1Q8QmqiDa0TqNocU9J20VchRgGPgu1fnigQDOP+XeOln8gkKDV0NVQCwtxN+xfMsWFveHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiklPjWE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiklPjWE"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b940f962a82so66445666b.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 02:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772705156; x=1773309956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=027dPFV8Tc8GDTJ3SSFR7JTe8u6/ev1qukXmoBe9FMw=;
        b=CiklPjWEIhQ586UpEZWBl01Oz/SsKAffITJqL3tAFeNm645vK4J6QRVOsy2Xax1RcG
         KLapfiKLHg6S3C1Bp5dSGXJDNvwPfi5xDAjHa+BfR9iJo9E1ZKqDa83gv+TSWankJBXg
         QO6f4joQfjUJa+NaNIWdqRV56j4eswE+ZPf7xV1ysNvzRmrieBH/S8wHM5a67xXdxzz4
         5ZKEbFS/H+O1jWOAnGtcBAFJLQ4eUyMVQVz79lth43uUKzlNb10jDJZ/wWY2bRdyA0QA
         VBwO4nCDQbjaBdy9ObYsaUITuAoaQw7gTiBOkfQx7GvHSyZlsHs3vpS/wXhNRENuzve0
         hOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705156; x=1773309956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=027dPFV8Tc8GDTJ3SSFR7JTe8u6/ev1qukXmoBe9FMw=;
        b=aZtt4rUoVbj8ZYBVpfLGFzihLr23SLEegNEsZmfQuKbAbWDALtfgsh90WUPjEjyX/E
         YYO8G6jznRT6SybGHBehJvRh0z7MgKiSXi7F368NLFHXpsQDz0v0VydMxYZv1etAraV8
         r4ZbO0jgdtlRwg87FJQ2eTuRqbezWpbj1ii52oJFRbfdkis5EVXtuApe2G/sepNNfDbt
         8zlvrS2b0Ht42brINdCHjWOl4y0u9jVX4klWtBM23ViYY2ajP4+RX3nMH96C25UXE91O
         uBWXGQOaUg0oyJ2K8E7BUqilhHmL8xExsQCgwOqngQUvWI0WYAkDe9gcjTwUmbY0clwu
         otQA==
X-Gm-Message-State: AOJu0Ywauxo6KgAFoBHb5qNz0RnFLLXKX4jgvRIkRqkZimBeGYlXYc4k
	zuQ/DrdYKiaaF/p6ZzGPhsnClqcZawNCXu8eLvNg0q8eA3/S7qcSIJS4sgoAJ8Xl
X-Gm-Gg: ATEYQzySLeBYK0p6WYkRybCakWVG1jrdc+k0vBmLV9V8GU04+VEqjewM9xe9N4ALwCz
	wlW3hJhYDvNhGlRtlM+zJWSi04tukO/TwyTAIS/6K5FKIjSqN3dH3oFkFzLRmsBUCVEwuunOhly
	J0iPQexx0pEYA+T6OB2x7LTyzMcJPQ7DE1E6A9IB6SUI17C1lVdTcsUkRjpYU6TxIYhuSwGjX0I
	/sQExW02VJlgbSWA9S3RwP0xtu1XuhSphn9YQ+U1yFCzyQ60D3VkQ3D0Zr/tUFpkbhYu9mAIVBD
	AQsmL+zcLIi3E3wH+sh0pUxVEYrKnoKqxeKatA0Dir1ELpI5UYMEiWd4it3Nssq7cYpihvRPLSm
	L+ZTWp4+pNfiXjX7moaGlC0rwHvj2XRoFvR9facRBaoWSCRJluTcQ4RtLDoFaVhSPa7pULvTcEe
	qUKlktfMU8J2r6mi2QhDE0urwpoVhUlJREWmveefwoEBfJW5H7EBaxvlWYJGM/eoJg
X-Received: by 2002:a17:907:d93:b0:b88:713e:78a5 with SMTP id a640c23a62f3a-b93f13f873amr309013566b.28.1772705156365;
        Thu, 05 Mar 2026 02:05:56 -0800 (PST)
Received: from localhost.localdomain ([105.113.103.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac513bcsm879815266b.19.2026.03.05.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:05:56 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 0/2] oidmap: migrate cleanup to oidmap_clear_with_free()
Date: Thu,  5 Mar 2026 11:05:24 +0100
Message-ID: <20260305100526.102130-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302200018.75731-1-kuforiji98@gmail.com>
References: <20260302200018.75731-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series replaces oidmap_clear(map, 1) with
oidmap_clear_with_free() and introduces explicit free callbacks
at the remaining call sites.

The old boolean-based API implicitly assumed plain free(),
which obscures ownership semantics and does not work well
when oidmap_entry is embedded inside larger structures.
The callback-based API makes cleanup explicit and type-safe,
and avoids relying on hidden assumptions about allocation.

This is used in subsequent commits to adequately cleanup all
usage site.

Changes in v3:
 - rename funtion to meet guidlines
 - drop [PATCH 3/5]

Thanks
Seyi

Seyi Kufoiji (2):
  oidmap: make entry cleanup explicit in oidmap_clear
  builtin/rev-list: migrate missing_objects cleanup to
    oidmap_clear_with_free()

 builtin/rev-list.c      | 15 ++++++++++++---
 oidmap.c                | 23 ++++++++++++++++++++---
 oidmap.h                | 15 +++++++++++++++
 t/unit-tests/u-oidmap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 6 deletions(-)

Range-diff against v2:
1:  1d544ef7d2 = 1:  a050491441 oidmap: make entry cleanup explicit in oidmap_clear
2:  f2c3a699bd ! 2:  b592d765e3 builtin/rev-list: migrate missing_objects cleanup to oidmap_clear_with_free()
    @@ builtin/rev-list.c: static int arg_print_omitted; /* print objects omitted by fi
      	unsigned type;
      };
     +
    -+static void free_missing_objects_entry(void *e)
    ++static void missing_objects_map_entry_free(void *e)
     +{
     +	struct missing_objects_map_entry *entry =
     +		container_of(e, struct missing_objects_map_entry, entry);
    @@ builtin/rev-list.c: int cmd_rev_list(int argc,
      		}
      
     -		oidmap_clear(&missing_objects, true);
    -+		oidmap_clear_with_free(&missing_objects, free_missing_objects_entry);
    ++		oidmap_clear_with_free(&missing_objects, missing_objects_map_entry_free);
      	}
      
      	stop_progress(&progress);
3:  a4e426bcca < -:  ---------- list-objects-filter: use oidmap_clear_with_free() for cleanup
4:  4116e5491d < -:  ---------- odb: use oidmap_clear_with_free() to release replace_map entries
5:  ad1f776a19 < -:  ---------- sequencer: use oidmap_clear_with_free() for string_entry cleanup
-- 
2.43.0

