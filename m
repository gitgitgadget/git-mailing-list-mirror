Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9118DB07
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742108348; cv=none; b=EIg5/7rQZmkENTXz8j4TU+ZWdDQSH3oN/blrPuY1wSbgKTYX6akb2/Wvfzs+Ca4jSdeD9UIyqjFBdph67ZXnUjZ9VdCYQSFfpYAojfoX5jBx5IDWcVzfzrdxK4ilB1CKkvLKQMwc7de82CJsMpJqZo7gHF6eKGRonJab+AaW1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742108348; c=relaxed/simple;
	bh=Qe6J1M+VTSx+DBvWYuiJMmLY9MSxlvidroncW2A9/N0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G00JGl3yWnT/9nDP40jckbkBpNDb7Y+wZSHocX/9v8hV1l4NWHYAIYUXGAu81C2GvPEPzu/zCYmj+FaC7YBWdBWSwWCQNRr7Plc6tp5D4U6Wof4tHqbfcrR32sJTWBhMbjxL+CoyRdpwQeKGMefmWsOwYkw1ScpvicVo49HC4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBIZJBbp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBIZJBbp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so1162515e9.1
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742108344; x=1742713144; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av5G7+2sI8ZZYyMpK6C4iIUMbJ4BzFe17X7p0gq9SSU=;
        b=mBIZJBbpVnCfYmpbtzTimwqXyfZO85NBgk4oa659tmIR9iZChOQdF3LFpgF6WCQAfU
         98a8Oi5oJFeD4TW/nal7jVX1nbyO3U8HYwaP6kJITytq7xE00l9hg+v8HD/2Gv12UVeS
         3YHCxsDEEOmcxDgUTrSvXd1uW3dCsjuCm5K6XULG8tzNjwOFwoi6J/O44+8W1WYGLdOI
         XcEcXG/u5hXKeF96wpC3hFBM+yJ2id5vgkm6kICXK2J4X7xETEbFpO1+oFKLPlYxjnDm
         MvImPMLYsWnWWwlMiG7gIBLJHjzJ+yl4kUvfXq2eKWJGfK0wO6mwuPMkJJJYC09PsfKl
         ToMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742108344; x=1742713144;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Av5G7+2sI8ZZYyMpK6C4iIUMbJ4BzFe17X7p0gq9SSU=;
        b=HxrxnuTbWKdJWfh4A8hGaQdVwVhPqHdSaefiPQ4XiPgv4RTMUJonTyFIh8F6faE6+B
         SuIrxNDXs0N1994qESm4DxdQeC5wXP6/cuxUTzTbY7hGfRZfR3liYBWa/fe+FeC3JQBH
         Qd0OkMU8rqes0bzHRLCzpz/PgGRFoSndhcYNZKO+39O3VP3db273KeyfHlKW41bLpdB7
         WTWXBbyGwjhuocM9rr7NuTRYBSgsUljUa+rfYmV51qtNtOgCbeY5URWichTWO1IHZouD
         eCktr8CEia56td2VtMQnGJKxJS7ZIbpvbHorgf1EJDiDrXbuBYr35x7htFz6BlUPTa50
         ubMg==
X-Gm-Message-State: AOJu0YxXN4XJjZsKmFJ7bDLMkSLNr7ky8VGyuKKQ8T8GcaSjBy6bgFxR
	uCq/RQmQb7qEqNyI7Cgl6IRoi6O90sUZcurh/oI7R5er4vVbeMiQw+OAiQ==
X-Gm-Gg: ASbGncuZD6RRi2Cx+/FDxGHS3lZn8rtNnlMTuy299t9p+MLfXOuZeX3wIiGgef1d3+7
	lluHZ8+tw83IRy9v8kxpPFNYJ0Q4gZKvUoH9lR0Y6gOTqw+upzHbev7lz+1d9tlu1ItwLbPd+Lr
	skjjNeuXaNedjzIMNYXoI5KNp3ueqxEh8KyxiS9Npg6yRKgOcCaDJqjDjQ7bqawYFBYomvFeLAZ
	gwR6STHkuaY+jDnrGYQ2fhJfcjc7tLyYRQlPLQHzmZIv61Wcsz5iLkrgVm8ieVcSieZB5WJXiDj
	YgP0FazGMEeGa0EP+a9/smip0wNJLbxvxDlru3nXbWGlFw==
X-Google-Smtp-Source: AGHT+IHP772vivxIYnT6vamWYIAoWV5EE+zjv/yhJsv5ofivfuHJyP6f+L9QgA/zD6JRYKekVIUreA==
X-Received: by 2002:a05:600c:511c:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-43d1ec729a9mr107440935e9.11.1742108344154;
        Sat, 15 Mar 2025 23:59:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe2927fsm69809145e9.18.2025.03.15.23.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:59:03 -0700 (PDT)
Message-Id: <97fa3d73e88edb5d07ae073c4bf9afa521982600.1742108339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
References: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:58:58 +0000
Subject: [PATCH 4/5] merge-ort: fix accidental strset<->strintmap
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Both strset_for_each_entry and strintmap_for_each_entry are macros that
evaluate to the same thing, so they are technically interchangeable.
However, the intent is that we use the one matching the variable type we
are passing.  Unfortunately, I somehow mistakenly got one of these wrong
in 7bee6c100431 (merge-ort: avoid recursing into directories when we
don't need to, 2021-07-16) -- possibly related to the fact that
relevant_sources was initially a strset and later refactored into a
strintmap.  Correct which macro we use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 46e78c3ffa6..a12aa213b06 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1517,8 +1517,8 @@ static int handle_deferred_entries(struct merge_options *opt,
 		struct strintmap copy;
 
 		/* Loop over the set of paths we need to know rename info for */
-		strset_for_each_entry(&renames->relevant_sources[side],
-				      &iter, entry) {
+		strintmap_for_each_entry(&renames->relevant_sources[side],
+					 &iter, entry) {
 			char *rename_target, *dir, *dir_marker;
 			struct strmap_entry *e;
 
-- 
gitgitgadget

