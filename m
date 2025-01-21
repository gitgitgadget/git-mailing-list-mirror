Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CB26281
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737430473; cv=none; b=FrX/qJwukaNb5MNki3a/lwI3gWlHDGcFuNr2zOE7ieKf287z9gQtSpSG9iymOUAxsb1QbOiMwhhzLSJ+nd7cYXqL/9YlYT8EJl/zNp9cVT2BejKqYVt6nddmcJnGD5RfaEt5JUyEY0VudIs1AME9vB5DMEL9W1lICXrqiKAR36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737430473; c=relaxed/simple;
	bh=9ATi7VxH+WjvNv4ajjh+9QLGUtMviBKvsp4lO7MEtuw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=j/6jBw0+EDZGJT6QrAsHVXZepdraQ8oVjYId/YSBttTNusaCIaM6FLarWHua2jkJfgbnrSeuJ4hJtSCyuIk5sn1h9PDOKchkZjYuYAiPGsnVqb3siYDrRtv0YJfOESEad0wzMyhfLXXgXLPG0RHEIdDYkDKxnXF4EHnG5+/e1lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GecNHydY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GecNHydY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso7753682a91.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 19:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737430471; x=1738035271; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkbuaKA9UTIl1Nnu5RdY58388aGHdz1U8KYjLzOvMF4=;
        b=GecNHydYul0OXr1ufAGOJc5oi/aH3gfIUBfKoOYD9VfJgQHtAB96btEW3o0wYnuBPJ
         QbH5xsiQg8RNnh/f7Z8uE1IZ+DFp63xnRE+Z8j/1wWQaQC6zQyiE2X1zKvP1yH2ZfL76
         Yo1JpiJXRC8eu4KihBRipsSJmKajLBiRbN493YLdzd8DddIuMOMDVOl7mTAu+rMUDM3z
         mgMRqozHxv7rWmmh/cmeq4ZStRTqw9UZE0y+b3/NHoCqcz4aMiSo8uTLZ0t+2kWo+o16
         eyESFBMlhK9SfJYp1/p17cm2J8R/XeY9FdYAzYIbbEtp81rMNbjyagu1wVqlfC7v2FcU
         DJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737430471; x=1738035271;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gkbuaKA9UTIl1Nnu5RdY58388aGHdz1U8KYjLzOvMF4=;
        b=TAyU4r+kogU3+/MDjAqZdxJrR9I96/Hz7cYaiiu7rpJNF4AUFzMyDt+6cIKKLbtCva
         QkazKKNN/VkS4R5rZm+w8Tkbbz1UPCnseKKa1TsTHRgwm1cvgwgqoQV1IJb8vK1waih3
         MO4nYbrNjKSr2g1AL2yIFrka9/2Qf3Ly/tRbZ71qZcDmgTY7PDQozQs44k7We9J+7ZfZ
         Cxy0SN26yUoltLlFvtWwXwaQ/tqzGWHwdZd/1kxnRpzYaumx/ZKHZmS0A2wEiY7JDk4u
         NdTuW1KgpbmduUx9Efxa2AY0BHbhgmog/6OhnDMbLi4lWlmBvm7gWbIWk/8YbLppLUU9
         +xiQ==
X-Gm-Message-State: AOJu0YykqyJRCClcH2bCqKQncjU5WSSYP3x3IIsmil7eZFV/z2k2bek2
	fLKiyxQbaLrHB08OAc+wrlD0+O1ZFH8UWGPBkVw6bsHCSyMmurCREvt6xnoO
X-Gm-Gg: ASbGncsfVJNYmv+1KntKO4i/9nlEo4BOtQwtrmFqRYx4az2OTMmhrToZl5fFtfAwHRK
	ZaRXx0J1eZ9iL577lZPfg8FQnl6MkSchUa8sTyelkc9gUxwv/fhNIXc82jw/9NgYTTMVOV2uVjM
	X34syGuItNIX9DOJdTXcr9w1aES0VgEAI8LdIhv3dqxFoufUUfbKZBpYTr/8DolPhKLcjmtzOe5
	7yRtNt2omV2BZhDfvcK89hoFff/vVGglb47SsxXmCIZavSc8b1Vfiy1m/T53rP78K+V05fO
X-Google-Smtp-Source: AGHT+IHRlxB8LnN/c8hWkJdscAmq3A+zCohj6ZcREa/g7j3QadcWHMcbgkN1RNs8cHeaIrc4LDInIA==
X-Received: by 2002:a17:90b:2741:b0:2e2:c2b0:d03e with SMTP id 98e67ed59e1d1-2f782c1ad3dmr21797882a91.5.1737430471447;
        Mon, 20 Jan 2025 19:34:31 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm126291a91.26.2025.01.20.19.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:34:31 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/3] refs: small followups to the migration corruption
 fix
Date: Tue, 21 Jan 2025 04:34:09 +0100
Message-Id: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALEVj2cC/42NTQqDMBBGryKz7pQk/kFXvYe4iDrRgWgkibZFv
 HtTT9Dl+/h474BAninAIzvA086B3ZJA3TLoJ72MhDwkBiVUKaSssagk9s77bY00oCcTdWcJjbP
 WvbYVqRNUmEHqWuWQLGu68PsqNG3iiUN0/nMFd/lb/3fvEgXWgqgSpabc0HOcNdt772Zoz/P8A
 o+YMOzOAAAA
X-Change-ID: 20250117-461-corrupted-reftable-followup-eb0e4fd1a723
In-Reply-To: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
References: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Junio C Hamano <gitster@pobox.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3534; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=9ATi7VxH+WjvNv4ajjh+9QLGUtMviBKvsp4lO7MEtuw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGePFcSmYL4d05E4M3PqFCsrPKo6VwNrhWLGl
 d15SGONVrNUQIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjxXEAAoJED7VnySO
 Rox/jgwL/2MynDL4T59kbWIOTI9jkNfSfiSm15Zr2Gq9BaQGiepdHjd03qWEX1PKsnkQHl/wXN3
 6S+wBFy8SfMc8aHlglSUTqrdF4EeNXwfeP6shYmweAaa9DdKbOcnK9hM/JFFXVc05tqF1jy+snY
 iPN5BKdBQkfRk4CBiYQjBfWsRtwTQBYO2IuUltLS+puNfjvqOOziWVyeUyK02/GLenaamKUnVSm
 v1Ktpi913fyXnBm49zyB75bhVxO8H3qEJBeLeTLJutv9czD4ux3vZl3Vr73sZ/xLIaQrrsx+fLj
 Q8v1Z37DjEhHC9+dCzMjh1mkTNR0hJZB/+08v5znyF0Np03weloDmNleZc2iLbfSQBDoPPC0QV3
 aYeOxvMH1UDbHxS1ohS1whOPrNSideIwyHdZCkLzm+OljBFdfee0zJ97vo+g/m2kVH2qn5xlnKj
 vMQu+R1Od4HNLyjf5m01k2w82Hm7mRvlzp+jtTKPN5h0XOwqQ5no6dIpu/WUxcbjzFsPJFdAg+7
 Jk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This is a follow up to the bug that was reported [1] around `git refs
migrate --ref-format=reftable` where the migration would fail for
repositories with reflogs with lots of entries. This was caused due to a
mismatch in the reftable's header and footer, specifically WRT the
'max_update_index'.

While there was a fix posted. This series is a small followup to fix
some of the topics discussed there:
1. To mark `ref_transaction_update_reflog()` as static since it is only
used internally within 'refs.c'.
2. To change the type of 'max_index' from 'unsigned int' to 'uint64_t'.
This would be much safer for large repositories with millions of files
and on 32bit systems.
3. To add a safeguard to prevent 'update_index' changes post any record
addition. This is a preventive measure to ensure such bugs don't arise
in the future.

This is based on top of master 757161efcc (Sync with Git 2.48.1,
2025-01-13) with 'kn/reflog-migration-fix' merged in.

[1]: https://lore.kernel.org/r/Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Commit 1: Keep the function comments.
- Commit 3: Modify the requirement to be for any record writes instead
of the first block write. This ensures that the limits need to be set 
before any records being added. Instead of using `BUG()`, return 
`REFTABLE_API_ERROR`. Handle all callers as needed.
- Link to v1: https://lore.kernel.org/r/20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com

---
Karthik Nayak (3):
      refs: mark `ref_transaction_update_reflog()` as static
      refs: use 'uint64_t' for 'ref_update.index'
      reftable: prevent 'update_index' changes after adding records

 refs.c                          | 24 ++++++++++++++++--------
 refs.h                          | 14 --------------
 refs/refs-internal.h            |  4 ++--
 refs/reftable-backend.c         | 22 ++++++++++++++++------
 reftable/reftable-error.h       |  1 +
 reftable/reftable-writer.h      | 24 ++++++++++++++----------
 reftable/stack.c                |  6 ++++--
 reftable/writer.c               | 13 +++++++++++--
 t/unit-tests/t-reftable-stack.c |  8 +++++---
 9 files changed, 69 insertions(+), 47 deletions(-)
---

Range-diff versus v1:

1:  82a4f950dd ! 1:  5821ddfbe2 refs: mark `ref_transaction_update_reflog()` as static
    @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
     -				  const char *committer_info, unsigned int flags,
     -				  const char *msg, unsigned int index,
     -				  struct strbuf *err)
    ++/*
    ++ * Similar to`ref_transaction_update`, but this function is only for adding
    ++ * a reflog update. Supports providing custom committer information. The index
    ++ * field can be utiltized to order updates as desired. When not used, the
    ++ * updates default to being ordered by refname.
    ++ */
     +static int ref_transaction_update_reflog(struct ref_transaction *transaction,
     +					 const char *refname,
     +					 const struct object_id *new_oid,
2:  51ed04e95d = 2:  8025cfadf2 refs: use 'uint64_t' for 'ref_update.index'
3:  34e3001e29 < -:  ---------- reftable: prevent 'update_index' changes after header write
-:  ---------- > 3:  4b0416ce20 reftable: prevent 'update_index' changes after adding records


---

base-commit: a5aa44e7930761cb900813d971b4105f901818fb
change-id: 20250117-461-corrupted-reftable-followup-eb0e4fd1a723

Thanks
- Karthik

