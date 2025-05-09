Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A726B2DF
	for <git@vger.kernel.org>; Fri,  9 May 2025 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774874; cv=none; b=HQfTuTuMWaTXuX0w8s9HJekcVejUtzedkDHv87XNcaCgcO8g+wNi04/FHTCdJQqbqYp8BE0tLlbgywHC6eW9hoR1X9M5dXqk4gASW23Pr9Wo7In64v//4C7qpSeOcuoafwZVM4s0xI7MfgeSF2ddNXXkTi3c+UqHlm2VenfO1MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774874; c=relaxed/simple;
	bh=t0uVXm0jBpj0T7i7iXBgX7dSsWxOOaz8mYn8gUZZWH0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uWesR44EfPJ0ozg6kNVltJb7I/Ru6Fxip6lG5xLrVXIsDgPIj5XY+7DI5ScvdgQ3dNk5TGQ8R+Z+wGTky6UU8bQUCs6x5oSZy8hjg8kmCJUj58S3QD5mgldweEpNxQxdoI+Efhp6nTr0drddk/58D3Ednush5JtOG/ezJEzmXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntmiYUSy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntmiYUSy"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso689330f8f.1
        for <git@vger.kernel.org>; Fri, 09 May 2025 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774870; x=1747379670; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11Umvpu64gP6CH2sco0ZQzrc7iz31s/R9UWCOXEausY=;
        b=ntmiYUSy+xZLN1xcI+3KrYAFoMsGkaHkIdBweu4ozFRww3APxVxz24zglH7zxWD0Y8
         G0pAn6j+dYpyi4m/4+59uFdPH0cte6LRRX105+amcNlc8CqpADmfxqAIbUuZtikMbOOP
         IIrDSuYtBOwaE1hP/CFZ86WzLjI50NUFGZKhkguMeYiJZQfN20xHFGymIg7ptjkWg7B7
         H5SUQBFb6INEA8dBtFfK+nt323Crag6xo+BTq5gQ1s3yHYELhxoGZnEsc9HOnjabrjuB
         qeIygHxJQbThtkbEgBCJjnfTzZNS3y1hHMZPjT6v7Qah734E4WSKn6Jsj5USAsKaDIbB
         QUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774870; x=1747379670;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11Umvpu64gP6CH2sco0ZQzrc7iz31s/R9UWCOXEausY=;
        b=rRdlwT5zv1qeI+A7NZp6lW/jlKq7Qo/WmCCWWhDdaLPW6pBGvZty8B9+mj25rRM5WL
         gECES9dfSEIlxSuw0nG+0C28h1GAq2tt2Fz2+ecuWnT6+MoDEC2ZwxOrOEB/CaQgoij8
         KD1EMVzxNxLj4I88xp7wM+LPHwYUEFAg2su+22iTMuT/okoj4qWJvi8Ts3M7GUD+FS2I
         vHv7NTABTW1sLs9GFvX5A+o5sIyRK5q8oKfPvB/OE3xHFasMsot1dGbAooMT4kMJR6yy
         wCw+8WbyAEwEG9qaxdk1C8PXhKB0H61Lbu4z+3WLvuAY1NZpuiLllCwhuhEdRRY/Zl/I
         fJhQ==
X-Gm-Message-State: AOJu0YziNIabCrR7lRMtmgGImZVdgm/XppCxJ64Ay1oW2pPwjticq0OU
	qZKkxcliVEvBY9zp9UNEozwtQsl4QC9W6eSB+3pT3fQS4rdonLUzxky59Q==
X-Gm-Gg: ASbGncui69KL7Df3ZD8fsvcQF6FzZF1FS4EpiZlLB/IoNnivjrY9I3P+10c5Kb69X83
	SfLSw1FqlszYClGefLibi9zMjGByfi0lJUp9VnhfaXzEHuSKMzlQLZXR3DqPI1LUUHMdkP+gU6V
	6AICcL2Whf27DARkHNOr7bZYU31tfeNKH66tSOj2vcxQqUlxlo6uhXlKl1gYoVBCq+uATqwFX6b
	XNsYSlghbDvKzT9b55E+psqMLtoMs2Qc3a13NiWf08t1GXrTq98Gahiw7bcTekE0x+dO+P0C92z
	/fSFWKJuKIes971+uq1lkSjztHuUZNxslUCQ9DKgRA==
X-Google-Smtp-Source: AGHT+IGPXTSO39+OS8IPDitRjrE3QoTBe2sVQjCvW3dF/LA5W/xlYyzxX7VaF8N1I8omxIUrExBefA==
X-Received: by 2002:a05:6000:1882:b0:3a0:bd7a:7ba8 with SMTP id ffacd0b85a97d-3a1f6c98e05mr1614311f8f.19.1746774870040;
        Fri, 09 May 2025 00:14:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57de001sm2309201f8f.20.2025.05.09.00.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:14:29 -0700 (PDT)
Message-Id: <pull.1957.v2.git.git.1746774869081.gitgitgadget@gmail.com>
In-Reply-To: <pull.1957.git.git.1746712275566.gitgitgadget@gmail.com>
References: <pull.1957.git.git.1746712275566.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 May 2025 07:14:28 +0000
Subject: [PATCH v2] fill_oids_from_packs: fix memory leak when
 fill_oids_from_packs failed
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In commit-graph.c:fill_oids_from_packs, if open_pack_index failed,
memory allocated and returned by add_packed_git will leak. Simply
add close_pack and free(p) will solve this problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    fill_oids_from_packs: fix memory leak when fill_oids_from_packs failed
    
    In commit-graph.c line 1930, if open_pack_index failed, memory allocated
    in line 1925 by add_packed_git will leak. Simply add close_pack and
    free(p) will solve this problem.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1957%2Fbrandb97%2Ffix-commit-graph-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1957/brandb97/fix-commit-graph-leak-v2
Pull-Request: https://github.com/git/git/pull/1957

Range-diff vs v1:

 1:  72402abe900 ! 1:  190961fe942 fill_oids_from_packs: fix memory leak when fill_oids_from_packs failed
     @@ Metadata
       ## Commit message ##
          fill_oids_from_packs: fix memory leak when fill_oids_from_packs failed
      
     -    In commit-graph.c line 1930, if open_pack_index failed, memory allocated
     -    in line 1925 by add_packed_git will leak. Simply add close_pack and
     -    free(p) will solve this problem.
     +    In commit-graph.c:fill_oids_from_packs, if open_pack_index failed,
     +    memory allocated and returned by add_packed_git will leak. Simply
     +    add close_pack and free(p) will solve this problem.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      


 commit-graph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 6394752b0b0..93d867770b0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1929,6 +1929,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		}
 		if (open_pack_index(p)) {
 			ret = error(_("error opening index for %s"), packname.buf);
+			close_pack(p);
+			free(p);
 			goto cleanup;
 		}
 		for_each_object_in_pack(p, add_packed_commits, ctx,

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
