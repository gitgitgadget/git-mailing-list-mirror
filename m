Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC222BD022
	for <git@vger.kernel.org>; Wed, 21 May 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862977; cv=none; b=dW3QzHL2xjNqm0+M9Nqryau3tosmpml9GUHre8/wX9FGHdPr67mxc4v0m+9M/jD6HVnYxUPZMypjFNA5y+qsompR9RSUt6tlaxK0XVSFb4Mqhv5p+e+mCsiaboR1nAuOLwSIVY0o6EkGLpXzzA2Rm9OozJSVL3C5tawGdkwwRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862977; c=relaxed/simple;
	bh=C4PGHmgrv99lAZLstXIhIlLMcBB4IdOcXZFsrUMLMS4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NfD837bOeK7xr21hbt+UmlNgjISoE7NPM03oloLDCdDOLUVJnFUMpFR/qxtGg8J+m4AcualyDsyjYy+BlBvHMSpaLk8HjtH9KgLtywrtXa5g1BG2THaPOF94Qy+VnDurrwxmoQXSXl6x3ssw02Pgc39EROCeHUUydqKUttjtZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfGLCqGr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfGLCqGr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso59455335e9.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747862973; x=1748467773; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t76NbYgNjtBWaAQWnzpFEN+T9Y+tK1Nb8QgtZp11o7A=;
        b=YfGLCqGrZZFOWL6+7Jqt2j7iaa14sKNpidQrhTeIwDbWhNTx0oKIVhDmtZuVHdMYCC
         xPZGTva+GZ5eWPeF+TR2JJHAqH89omffeXxdKYWpszOFko1eCvjebcO90K2hvjVQgYM9
         tVe88YL1lymBCS2VSxioP2GjQDkEGXKY0CqyxJXnrf9FEU4YEzPx3MmX4koGwrH4SAoI
         Gjz5UI62JZn07cYT/rv22WUs0R8vSnVj9wu1GYbSq6FBWSplROgfdNNEvkdwL4NIdyiA
         Cb6wRpjxrUo6N6EnZkPYWbP6ePgfDxOyCD87w99krZ6Hs/FsO8o1gl3QXZVnxcXQDy+G
         QhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747862973; x=1748467773;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t76NbYgNjtBWaAQWnzpFEN+T9Y+tK1Nb8QgtZp11o7A=;
        b=wyh5IJ/bdcxtsPl5x5B0ZmtNCvrU3x+6cRhERGcGG9y6dH/uApvZNc1e4I6kvIbZTA
         0Cs1CXhWfq7Ok8LufwIsE+bWYJoHwQKHVpVdGuZ1PqhpX+OJlToWoSpw3c6C4yD//IL1
         9C+c40MPjN2hAjbtVhWsu6OP7EeC+xaUqtXwl+FYM7USOH3If0mEDpLn4yiglvW4+2jf
         zfCAd5vIE6Pqov+ajyZkEYmajT3F/bg2cCzP0iUEtxwwWlH3oaoEzopg0tU4k357g4w+
         Jlh+TbN7JF6zdmT0WM/fQAMfZZZeZBOuCyXyDXGSm9XpD/Hjq7ena9zJeExV/KQG4Z1q
         qtxw==
X-Gm-Message-State: AOJu0Ywetnaqblp/ispxpYHT+WyqbfwB5n2CdOf6J79VDjMNOvvoiOES
	gScyeOsdnOPZDkryAGbPpoSum5Cld0saWY5TIM0X216rWVNtr1rh/4nwbjXsvQ==
X-Gm-Gg: ASbGncv7kiKP7LpDeEA56S/tqQH0e3Jz0NU0XNJljIYrcpPZODDka7zsfvFNovZYIYN
	IB8Ng5Ww9Av4KU60hgSU4zQ4N1WqgsJBAO0EsCy4LsBikzo4EcrQjcvw9l2RntPOu/2yZeT2UqI
	+8QFeoXhHzC1xlvHw4HnnbWBVtT/1pEhq9oGee/kPSjVJTajFB4Nb00jqaZXrYqMJAMLakr/Z4F
	Yx1mFeF9ILKcDC5R8Qh1E6b2MY/Zsm6k6dvIfKbZrl8vO+G5DXEZlEpgDj5pqgl59+KnqZCBqiJ
	AmDieosme+VP1zTCDJ0hmJJkC0AnMRp3WfA+mXCz16Cfl2vuAV86
X-Google-Smtp-Source: AGHT+IF2S2BonxiphfHhSfzOViw51QITXpFwmND/ih+vqqf4JLVgGRHPCJ2+X/zC3fmkimWpkbuGBw==
X-Received: by 2002:a05:600c:1992:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-442ff039684mr207372875e9.30.1747862972979;
        Wed, 21 May 2025 14:29:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f381420fsm80680035e9.32.2025.05.21.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 14:29:32 -0700 (PDT)
Message-Id: <pull.1970.v3.git.git.1747862971672.gitgitgadget@gmail.com>
In-Reply-To: <pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com>
References: <pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com>
From: "Alex Mironov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 21:29:31 +0000
Subject: [PATCH v3] name-hash: don't add sparse directories in threaded lazy
 init
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Alex Mironov <alexandrfox@gmail.com>,
    Alex Mironov <alexandrfox@gmail.com>

From: Alex Mironov <alexandrfox@gmail.com>

Ensure that logic added in 5f11669586 (name-hash: don't add directories
to name_hash, 2021-04-12) also applies in multithreaded hashtable init
path.

As per the original single-threaded change above: sparse directory entries
represent a directory that is outside the sparse-checkout definition.
These are not paths to blobs, so should not be added to the name_hash
table. Instead, they should be added to the directory hashtable when
'ignore_case' is true.

Add a condition to avoid placing sparse directories into the name_hash
hashtable. This avoids filling the table with extra entries that will
never be queried.

Signed-off-by: Alex Mironov <alexandrfox@gmail.com>
---
    name-hash: don't add sparse directories in threaded lazy init
    
    Changes since v2:
    
     * addressed commit message structure

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1970%2Falexandrfox%2Ffix-threaded-hash-name-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1970/alexandrfox/fix-threaded-hash-name-v3
Pull-Request: https://github.com/git/git/pull/1970

Range-diff vs v2:

 1:  fb378147c73 ! 1:  b91ccb640c5 name-hash: don't add sparse directories in threaded lazy init
     @@ Commit message
          to name_hash, 2021-04-12) also applies in multithreaded hashtable init
          path.
      
     -    Sparse directory entries represent a directory that is outside the
     -    sparse-checkout definition. These are not paths to blobs, so should not
     -    be added to the name_hash table as they must never be queried.
     +    As per the original single-threaded change above: sparse directory entries
     +    represent a directory that is outside the sparse-checkout definition.
     +    These are not paths to blobs, so should not be added to the name_hash
     +    table. Instead, they should be added to the directory hashtable when
     +    'ignore_case' is true.
     +
     +    Add a condition to avoid placing sparse directories into the name_hash
     +    hashtable. This avoids filling the table with extra entries that will
     +    never be queried.
      
          Signed-off-by: Alex Mironov <alexandrfox@gmail.com>
      


 name-hash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index d66de1cdfd5..b91e2762678 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -492,8 +492,10 @@ static void *lazy_name_thread_proc(void *_data)
 	for (k = 0; k < d->istate->cache_nr; k++) {
 		struct cache_entry *ce_k = d->istate->cache[k];
 		ce_k->ce_flags |= CE_HASHED;
-		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
-		hashmap_add(&d->istate->name_hash, &ce_k->ent);
+		if (!S_ISSPARSEDIR(ce_k->ce_mode)) {
+			hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
+			hashmap_add(&d->istate->name_hash, &ce_k->ent);
+		}
 	}
 
 	return NULL;

base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
-- 
gitgitgadget
