Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77691FDA9C
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974213; cv=none; b=uqgG/PB4RbKlrh9GwBcuxBX/oTVc/nXWrz+RO2VnQoHWUb6EUyFEwK1I1P6GUUX8hK5baVfV0tgoLsvc9pcMayiWV2F9hvE+/FocTMp1FdD35+dsNeMR4B1UeqMTma0f1wVvpEDkdx9AsA2j8iCvZiglyXaZAztS0NwtUuiBtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974213; c=relaxed/simple;
	bh=z4d+v4AcUMSqd/db8+Kv6kTYQSuHzViqKcWP/aTetOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UTHsjNezm7OHMe2Niq8+a8AtHtRivhwVNRmAaP5hFHVGrBrs1dUrhzW0FAAuZ/UgI1wfU6GSbk6D+e2jzapFC+Wxeo8UgYF/kup3/WcNnVPQ2lRCnEG8DTdTjrF1mkTRDfHEruD0y4Y22ad5/X4HDgsGC0iCkeqK8rBZwo4u5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApPNOoa5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApPNOoa5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso5572561a91.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 02:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737974211; x=1738579011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h+v2lKgPEICxXwD2QXPKRf852nQzS4llcgIebWSTkz4=;
        b=ApPNOoa59D9IWcG0IPBl6y8JQTqnXIK64tHeq2KZFRQz7ZwP8+jvKsjACJD0G3Je+S
         gNzTbJyLZw+a8xFS9dfosl/Yx0pq2o6cP7pCWaQGtCt/C1lb2kLCOstllegKUMvNiejW
         gUJkjZ3Jz21NXJu8l6/B5JeUKLv0S+Y4Z8FqqiswvrvX8wCo9tncy1wzPLd0snKWROR2
         7P81fTrhDU8ME70ZkUaNDwHc+m2W2KJq6pzw2xiw6QKdin1EjztJI6kWgUiaAL3CZ9B2
         FCVOOF3wR8OLlcGBb0s7RHAlR3IWSvDFDGdFc8JN09j5rFHfaUImC2pjl0bQhulobc7j
         +tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737974211; x=1738579011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+v2lKgPEICxXwD2QXPKRf852nQzS4llcgIebWSTkz4=;
        b=q3BxHBgeR4/Xs8Y9LyWfljVI/zm1QfxfJtfi7SRK8zak/drcnMK7uJQ1ieXmSixfp8
         acmKyJRp9FsaAcf9u7oSk9x//7m+bC2COTBXOA9J6qTDz0MMCFS4TCHcPPXXwbtqQfJF
         E9oyvaUG3F8im2vvUYJ+/qwPIGetDNZVrKmzPpGOu2mLT+st66qxb3gW8kCxYqCFQYUj
         7OkhIFyKJahcrRn2LqpkCkwhCvvTN1cbXMfqDa2b8gmO+6gJN9rFHovt5Q0zQ1NmlMn4
         VIxSp5OScGJasBmlT/XYe/HHgn3K1fMLoqpP2QzqQ1ic63sr3BCw8/6hNM9SqWX1v6Vg
         zf3w==
X-Gm-Message-State: AOJu0YyYS1sxYeS6Ce3g6cISk4rCVDRUSbbjsvWa6cPVjAqeoucAfrUu
	DS57kMa7ASAY4P9gWwHfAgyMv0M3hWm9nPPxkX2W81K87OWZT9sGZ2g8P4Yi
X-Gm-Gg: ASbGncsTOqtA1i/2KIWbKM7MQhnfZGR6Ord6onzg3cOGKQQL5XdBBzcdS9dzHfwlGNV
	4yoQPB/8B9wXdrqUYL+IEclFK2/LkLTezqaQEUDtUJnrzpI8uRX8HDkG+65SUl3C+MNLjgbaG+T
	YjcWBl5ocOUZEXmDWDnEaj2PTVVr/GI90pLn476EEsXjB3NWVgp63KqGugdT93xEbU0WqB/e7BJ
	F9WDw/cgQSVmmAk719UfrBW1kwGzFbuAMA7rHcSFOCY8dFKy49broXQKibCKcaot5tPyp5N8hqh
	ZI4=
X-Google-Smtp-Source: AGHT+IEMJ05AzYyjVW4pG1WTGRoho0e/Iz9IEAK8xVGpcEadwJs4w5bPWQ4zAfUJFEwfn05H9IhC2g==
X-Received: by 2002:a17:90b:4ece:b0:2ee:c04a:4276 with SMTP id 98e67ed59e1d1-2f782c50befmr51522320a91.5.1737974210568;
        Mon, 27 Jan 2025 02:36:50 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa454f5sm6879439a91.1.2025.01.27.02.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:36:50 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v2 0/3] refspec: centralize refspec-related logic 
Date: Mon, 27 Jan 2025 16:06:41 +0530
Message-Id: <20250127103644.36627-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for reviewing :)

I've added documentation comments for various function signatures to
better understand what they do.

Meet Soni (3):
  refspec: relocate omit_name_by_refspec and related functions
  refspec: relocate query related functions
  refspec: relocate apply_refspecs and related funtions

 refspec.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h |  41 +++++++++++
 remote.c  | 201 -----------------------------------------------------
 remote.h  |  15 ----
 4 files changed, 244 insertions(+), 216 deletions(-)

Range-diff against v1:
1:  97c98f5a38 ! 1:  8e393ea1c2 refspec: relocate omit_name_by_refspec and related functions
    @@ refspec.h: struct strvec;
     + * name matches at least one negative refspec, and 0 otherwise.
     + */
     +int omit_name_by_refspec(const char *name, struct refspec *rs);
    ++
    ++/*
    ++ * Checks whether a name matches a pattern and optionally generates a result.
    ++ * Returns 1 if the name matches the pattern, 0 otherwise.
    ++ */
     +int match_name_with_pattern(const char *key, const char *name,
     +				   const char *value, char **result);
     +
2:  4f0080aad6 ! 2:  ef6edbc15b refspec: relocate query related functions
    @@ refspec.c: int omit_name_by_refspec(const char *name, struct refspec *rs)
     +}
     
      ## refspec.h ##
    -@@
    - #ifndef REFSPEC_H
    - #define REFSPEC_H
    +@@ refspec.h: struct refspec_item {
    + 	char *raw;
    + };
      
    -+#include "string-list.h"
    ++struct string_list;
     +
    - #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
    + #define REFSPEC_FETCH 1
    + #define REFSPEC_PUSH 0
      
    - /**
     @@ refspec.h: int omit_name_by_refspec(const char *name, struct refspec *rs);
      int match_name_with_pattern(const char *key, const char *name,
      				   const char *value, char **result);
      
    ++/*
    ++ * Queries a refspec for a match and updates the query item.
    ++ * Returns 0 on success, -1 if no match is found or negative refspec matches.
    ++ */
     +int query_refspecs(struct refspec *rs, struct refspec_item *query);
    ++
    ++/*
    ++ * Queries a refspec for all matches and appends results to the provided string
    ++ * list.
    ++ */
     +void query_refspecs_multiple(struct refspec *rs,
     +				    struct refspec_item *query,
     +				    struct string_list *results);
3:  f89328fa66 ! 3:  ea72647439 refspec: relocate apply_refspecs and related funtions
    @@ refspec.h: void query_refspecs_multiple(struct refspec *rs,
     + */
     +struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
     +
    ++/*
    ++ * Applies refspecs to a name and returns the corresponding destination.
    ++ * Returns the destination string if a match is found, NULL otherwise.
    ++ */
     +char *apply_refspecs(struct refspec *rs, const char *name);
     +
      #endif /* REFSPEC_H */
-- 
2.34.1

