Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C335950
	for <git@vger.kernel.org>; Sun, 11 May 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746980171; cv=none; b=lJo4RjgFKUyepQq2y7O+cESd5NFbbCCIsC3Cz0nzAA2ZtHGB/Ob7h0oidudgJbb6s7BD7KHyTPBSdXN++JHlfdRINvFSW2fahoKOk3yzC/rLpyt2Hci9PxKGntxotT1yqu3F1GyoWhtwt4knACvUS6k9smoFeP+JHsoaaLAmxh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746980171; c=relaxed/simple;
	bh=UhzMNmnrcWK5gQQIhOrXIVT3Dk7msA4pLC6zG8XNAic=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PReLq4zYT/Ln875yb83G7Z1V2wNJ3iUrErAZbV7gp7GtqPdL3+c+Er/Vlq0+xWLxK45vkD0nZ3ya/UxR360DqnnwLLaNG6Xw3FsPs9cAeSFjEvVHa7zmsDfPvSaAf/Sd1sIbwu3OjMT2oXMMsBJOxqy+D+lSLOJqil1ot0S/CAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmPK3j++; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmPK3j++"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe574976so25432665e9.1
        for <git@vger.kernel.org>; Sun, 11 May 2025 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746980167; x=1747584967; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlzhTnkb9UoJlypaC/4I3RGsmBzXQvznwTtYdTPoZ48=;
        b=WmPK3j++maCR4eLW+jUrzgiBGhdYhbC3FW8N8m5gaeQPNy9VfZFvnQPZa8YSfbnhTQ
         WfWSXZQAXlCCDdRjLjVEuabum1Z8WswiqNoexNYOw+MbBelzrJmMuGFCd5O3w39/ejrN
         0+AQOGNvU0f8GbmqQPAyzE/UELgqVwq//lWMIcrMQ4BSE35L8wFked8oaB91Jl0PMe7g
         ljAHCmxTQx+U2qQlV9nVWgKj4KYGOgGF33OF+hGKtrCGdSfdnf52X3CqG0/6389j0Lxd
         ZxKQvj1Nn7by82gg345DhDTaUpIvFfETArj4F5oiRXGQ4210XvfEd4lvDQO9mWRl8GEH
         8FVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746980167; x=1747584967;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlzhTnkb9UoJlypaC/4I3RGsmBzXQvznwTtYdTPoZ48=;
        b=AmrTTSFq+uFkp5qvbsOzxlINUGrvjD6qLtgx87QWa+pgKPD2JuPjYRLqkabALdULHl
         bR7C1ke3/+uyB+uPFBMV6rL8RQ0gBiVyArywI7JP8XHR3etvzHQqSs4cV2IH2E7lQP8a
         mRjg37AO0PPw3aWJjaf8w9lrxnOwKRcBbXL1RtCZXdD6jUHZb7MHePc36/+x30bsNhA8
         UNPcufnzeWn0W2DHkMMbCbtYJPlXNY+UO3yru1ZSQpfIX0eE1A/nFeJFiY5lWrKCgHkP
         jq7Z2LeWfTT1fTI9o1l8YWHVruVVa1qlmJuUHHz4cHs2zaMH/8FTgjPs6GcGBsd+AGSQ
         TbOQ==
X-Gm-Message-State: AOJu0Yx104b1awvuSjAhdmXq3P3AUEbUVKR71ro42/J75cE+0oPJIOSL
	eMvk7OWvvp0Nczd5rdSzI9bdH1mQXPZWrF1hzvmf+I5iLJ2FOi/Co7xwnw==
X-Gm-Gg: ASbGncvtoDzrYgTmMkUEhQscfOIxW8X/t++IHR80e9IZg9Lw5Ip9WcgQBU74tvLilD3
	9p9eifmejPxKUVpoNvKGYPbiSxVRiAf42o/a5O3e0FUIWNkOdua54O6kzH0ulHSluuM+OTxosA9
	Ps5KKiNlxFl9H4kblvP+t4jPLKxkuTVI2cFNa9PuJT7TPgmpToHS+gsmsOI8HbH4zetNuaYc0YB
	MrpQNmdrx2bwIckTpduqj/WOMiWDBD0WiCCpytJLXZlFy7FZvhJyiLOgLQmawB5K4K9fXNQGz2E
	PeYVuHpkDS8czb8g8/mTrpD6Iziz/HtOnNKesI8UzF9h9B4O8PrP
X-Google-Smtp-Source: AGHT+IGzdI+nCwz089wEKjI7wvnN8fSDwKU/RAKcbNcZra9d4BXk4QFlAcSSdceI51rBeifQS5/xyA==
X-Received: by 2002:a05:600c:34d5:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-442d6dd21bfmr73941985e9.23.1746980166848;
        Sun, 11 May 2025 09:16:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2ab2sm9481330f8f.46.2025.05.11.09.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 09:16:06 -0700 (PDT)
Message-Id: <pull.1958.v2.git.git.1746980165245.gitgitgadget@gmail.com>
In-Reply-To: <pull.1958.git.git.1746849030749.gitgitgadget@gmail.com>
References: <pull.1958.git.git.1746849030749.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 May 2025 16:16:04 +0000
Subject: [PATCH v2] reftable/writer: fix memory leak if write fails
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In reftable/writer.c:padded_write(), if w->writer failed, zeroed
allocated in `reftable_calloc` will leak. w->writer could be
`reftable_write_data` in reftable/stack.c, and could fail due to
some write error. Simply add reftable_free(zeroed) will solve this
problem.

In reftable/writer.c:writer_index_hash(), if `reftable_buf_add` failed,
key allocated by `reftable_malloc` will not be insert into `obj_index_tree`
thus leaks. Simple add reftable_free(key) will solve this problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    reftable/writer: fix memory leak when padded_write() fails
    
    In reftable/writer.c:padded_write(), if w->writer failed, zeroed
    allocated in reftable_calloc will leak. w->writer could be
    reftable_write_data in reftable/stack.c, and could fail due to some
    write error. Simply add reftable_free(zeroed) will solve this problem.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1958%2Fbrandb97%2Ffix-reftable-padded-write-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1958/brandb97/fix-reftable-padded-write-leak-v2
Pull-Request: https://github.com/git/git/pull/1958

Range-diff vs v1:

 1:  2023d6791ef ! 1:  9329ae2d478 reftable/writer: fix memory leak when `padded_write()` fails
     @@ Metadata
      Author: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## Commit message ##
     -    reftable/writer: fix memory leak when `padded_write()` fails
     +    reftable/writer: fix memory leak if write fails
      
          In reftable/writer.c:padded_write(), if w->writer failed, zeroed
          allocated in `reftable_calloc` will leak. w->writer could be
     @@ Commit message
          some write error. Simply add reftable_free(zeroed) will solve this
          problem.
      
     +    In reftable/writer.c:writer_index_hash(), if `reftable_buf_add` failed,
     +    key allocated by `reftable_malloc` will not be insert into `obj_index_tree`
     +    thus leaks. Simple add reftable_free(key) will solve this problem.
     +
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## reftable/writer.c ##
     @@ reftable/writer.c: static int padded_write(struct reftable_writer *w, uint8_t *d
       
       		w->pending_padding = 0;
       		reftable_free(zeroed);
     +@@ reftable/writer.c: static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
     + 
     + 		reftable_buf_reset(&key->hash);
     + 		err = reftable_buf_add(&key->hash, hash->buf, hash->len);
     +-		if (err < 0)
     ++		if (err < 0) {
     ++			reftable_free(key);
     + 			return err;
     ++		}
     + 		tree_insert(&w->obj_index_tree, key,
     + 			    &obj_index_tree_node_compare);
     + 	} else {


 reftable/writer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index cb16f71be49..3b4ebdd6dce 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -57,8 +57,10 @@ static int padded_write(struct reftable_writer *w, uint8_t *data, size_t len,
 			return -1;
 
 		n = w->write(w->write_arg, zeroed, w->pending_padding);
-		if (n < 0)
+		if (n < 0) {
+			reftable_free(zeroed);
 			return n;
+		}
 
 		w->pending_padding = 0;
 		reftable_free(zeroed);
@@ -256,8 +258,10 @@ static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
 
 		reftable_buf_reset(&key->hash);
 		err = reftable_buf_add(&key->hash, hash->buf, hash->len);
-		if (err < 0)
+		if (err < 0) {
+			reftable_free(key);
 			return err;
+		}
 		tree_insert(&w->obj_index_tree, key,
 			    &obj_index_tree_node_compare);
 	} else {

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
