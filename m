Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251103;
	b=jsNlCaa3rce8Cnz7yQ81/YfZ/oHGG/cTXt9O0+IsolwDgRJ5Wsyqc0+d3tNyb86ESWwf
	 Gqds3NlnhOajhXtytEZo8hcPgrk/v9wCK9qbOAnvgu4OKh4GZugY0yMu7kmezAz7h5aAP
	 xgRQP279aX1xZxLRIaXfX6hR2UQxuivpU8lkiOr4rXSyxm0Bfb84ZH5UV1h9Tu/8iNPgG
	 9XCR620BkcevJg5ofKvjjzYTtgq0uQDIHMxs4nBjBb5m8c15QADQ95iEgcioueUqqRqVW
	 z4cVpoCmfLqzGBELjexWQ8ePlpi9+556HlUHMyIfarXK1FPwEDHHRJ/yvBvOcQJWspg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=KXLQo8l9I4Wyg6V2Gcox9sPFsHxNxnshAyffnEi8pPM=;
	b=wHbNcQ4bBr1gPsPNmugfhcDElu3W5ATOMt4FpvFyeqCDZKOSBC43t3nQzWhqmd/liakq
	 7gUeORr3bhH28+KXCIGlgcwip9KD82aBVgd92V7ev6B+814HzyomiddhpY1Z187R5+qlI
	 Go2ZQiUiCBvQcyTTs/Nnon+jsXXOlS/qWFRT7jhjmo14KPZSLfpbu2et8A9h3dx2OJjK8
	 pQigmfqo8TMet1kEdp1IYgmKroIP4NV7tm/9SrjwHWyi92U+6JP8lfO3AnYn88GA18XhV
	 hmyQZHJ3VZMaUs+toSCFhpKmDwicq0RxWTUylqGL15dwA2730/1z/ZbUBm0cUr7/6BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URe++l9o;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0744560A2619
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0744560A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URe++l9o
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3712b6d9843so931081eec.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 11:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794251102; x=1794855902; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KXLQo8l9I4Wyg6V2Gcox9sPFsHxNxnshAyffnEi8pPM=;
        b=URe++l9oJUquZMzuDE0RsrdzWqQMt7T2TI2DyYtreIhDGvbi5izcgKyCfrNf7Yux5s
         pT5MGuwkPtpytqAhtz3AhTRCJomI30nMzH48rjJjnHTU6GSDXatdiomAI6zslHpp3kl6
         MZI9oZ8oWD/GBpmS092+kBjBdAtpHmmnkvAjbgxTpvJ/PpjVQ5XTYu18jt7iGBL0l0Y4
         1RhbkOEzdwVD/TPSweZM+ANhgtiYHDgiDVU5jqLRd0PY71xQFuMLjhAmZbgO/utZ2Fax
         0D95lITbpp5HGrAdbIZcVvhv6iNG3PsTZxS3ZV3awNOsJkVEByMttgs3Leqj4VufMN/K
         ueLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794251102; x=1794855902;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KXLQo8l9I4Wyg6V2Gcox9sPFsHxNxnshAyffnEi8pPM=;
        b=X97N9wmF0b548MEzVyju4e0li/BKrHzzYmL3n9WzFDBjpf5SNVkmFlyUsxYgwIf6Z+
         Iq7/HxxnduCFDCzlCQILdgByM3nja3tyUR/FaW9ypafFDtc4nalc62lV4SsOB2KMKNaZ
         glJVAgGuOWI2INGDUazkaoss1xY2oceTImEohSNBiej/+bKbXStenrjM8NQFHAaANtEZ
         8PL+kPDsAdWvYgWAfkkY3E/QN5lw80KzFxI3LcXb3zLvJBk0cQhsalvu9KDUgFmWJB+H
         akTgJgHijTVxArG6NtQlG2Ug3o5HFp5+S3bMKQFyq+m7BZM/UwgFdc+vLbkZkBb/5E2s
         3kqA==
X-Gm-Message-State: APuU4Z8Yy5yh/zyUFQfSoj8MYvO/UJxpVV+mSSPOOE+++pgrH8hry4Yn
	tvMV8SnreqdggnbU3o6RuqoUDDOU/r04KjlqGM/HrrA4KMuaZtXHQS8qTAPcuQ==
X-Gm-Gg: AYBFou1DpHdFryTKL4CrrgnJhnak956Rjmvy1IOKCrLmnTi9QRuusjBa/sZluIxHF0J
	/mc0aICAxGx3zm4CIerWeIjB2igN/lW4k3HCUcpuzaBZF8JTOVlC9/TysDXTVg5Odh2WbFHjbKJ
	1n79DjIcZpdbgYZujxtQ7+EbnaOzpdhsNoVpe7HmkAVCyQV0hVNf3I6Y0ITwbTwzlHu5U9rOXuH
	c6+KFihGxeeXp5oVj+zhCt1qenRO9mcCbx9g+lDOtlYkzxVBN+YWxlFVwDZfCEi8oTqrZAe7lPA
	SHAWd6jZ48WRRfMXH2Z18M9FbvoQQQNbIkV03hyDZy7XDEb5wCaxo9g5AABxlO3taNI79/n1Rnt
	bxaL5Ih8OVRmvPXoaNVV0eFuQD3JIZ+UxfCdwlOyHqKPOeRL9feLfjUOMMaewVkXcMhDnV3F7CX
	OXnNKG3PnjHdWypU7b40xiHGgdc11MpCFRwXuL+5z/CSCGsSteuJIoLXSAhpdc/vB12nllHCcFd
	crJQbsb/p66qHLjobdCMw7HKQTGjpFEpRIn7SoJGP/+OsX9PZrj9pah799o7idEbApKAOwNqxyj
	elBfeIQd5k/GywqGhtyeQaltwse4Sw==
X-Received: by 2002:a05:693c:87cc:10b0:36e:dd5:fb08 with SMTP id 5a478bee46e88-375214da6d1mr194036eec.40.1794251101837;
        Mon, 09 Nov 2026 11:05:01 -0800 (PST)
Received: from [127.0.0.1] ([40.65.61.38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm258840eec.12.2026.11.09.11.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:05:01 -0800 (PST)
Message-Id: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Nov 2026 19:04:58 +0000
Subject: [PATCH 0/2] [Outreachy PATCH] archive: remove USE_THE_REPOSITORY_VARIABLE from archival
 modules
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>

Refactored archive-tar.c, archive-zip.c, archive.c, and supporting files to
use explicit struct repository *repo pointers instead of global repository
variables.

Srujith A Poojary (2):
  submodule: use the submodule repository to abbreviate commits
  archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules

 archive-tar.c                    |  8 +++-----
 archive-zip.c                    |  3 ++-
 archive.c                        |  6 +++---
 archive.h                        |  6 +++---
 builtin/archive.c                |  3 ++-
 builtin/upload-archive.c         |  2 +-
 diagnose.c                       |  2 +-
 submodule.c                      |  5 +++--
 t/t4041-diff-submodule-option.sh | 23 +++++++++++++++++++++++
 9 files changed, 41 insertions(+), 17 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2305%2Fpoojarysrujith%2Farchive-libification-refactor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2305/poojarysrujith/archive-libification-refactor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2305
-- 
gitgitgadget
