Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578732ED29
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728197; cv=none; b=puHGER172JPd/gWtjEcT6Di9myhnJUoWLLOpfivm260AjE9d/2mBU4Wq3UeIgvIiI6eF1LNKKIaBVJP7Ns6iJGq/Tcp2pBy0oFaAbf9rLHuVE02Bira8fIBYqkzBNBDzLxxKmz4Iw98yBEZF80UjnWjmvgcaP4wj+Tyka7cInF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728197; c=relaxed/simple;
	bh=c8M0Eqt7+Mu/XmzAxhCT2KvSEZtcGEhcU3avEsPyOJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdH3NT9iiM9eitjNbGUCT0hyPOIPuuiK1ob5jPrjZ9nre/TYwaLN0xciFewdN5oVQrZdJZNNHqr8/4gbvInFszqHj+E0rrZPObKYiRH6I+bkgjUUkCcn0PUxuZQ6aQnA0W2bDLBIjWUf3OckRgHKq6/3OFsvieFG2o3SJqD7l4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk/aWmUh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk/aWmUh"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1255255a12.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728196; x=1775332996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZXvSydOmdHuc3zDw44zV2zPXNOsky9d7Cndf0fdZEA=;
        b=kk/aWmUhRr1bvF+cC+SODZRWkSF+8v1g5/utxifv3uxg9B1VM9w0ieE0DUu4yhrI33
         ykmnpP1HCn5hE5g6YRIvNniLe+dYvS2tzp8KLHcG+fXEBzv0Kpu8jjhQh+1K0oMVWi7D
         LMbNmXobkahZM2MV0SLcnMGXFwud8nbQ4ZVsxTJy6QbvaXBMek50NX8K3LuoUcZS09Wh
         CM5L8SqUaQIQhTkiM/EH9kHmJGgr5ouuCJWXA0iCr5655h+VBp/iMr+YWokl0vm+3wtj
         xFawVyqADYL+zLIjSDUw+ceud6CSN6m9ybWTjLESPaTXSO4seNB3vwMawb1bskqykpPm
         89Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728196; x=1775332996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VZXvSydOmdHuc3zDw44zV2zPXNOsky9d7Cndf0fdZEA=;
        b=WXG05/yKzlkYBKvY2KYuURfu1g6zy9y9mxIGF3Ucs0vSHpIgMq2GJNym4UFuQpBMCt
         d6L4EWtuDHfdxNb8HRVjhZl3pNQ7jzpqMPFsip2Hqs+rI5hdgA/xYnUd4O0u+BvJxLGU
         EgqVSe/PAcFLNhwDwVi6YGSObJCrXAx0RKB89Ukv1R8T41AMRVlsUD8XhA5dPNqQVtc3
         856/+QK1NTpfvxRBihFYQz6G5pvNyLYHJ9qruZ3J5ZGIoQitl7goIysmb8qAP7AojMV0
         t2ERfeYtXYgr0Amg0pG0Gyz/fHy4652niJTbQiGpbV794ciTgQ4RQQf+tbhhEifXyXZ3
         wHrQ==
X-Gm-Message-State: AOJu0YzX7LZGQBmunP+2BnJXUQBToS2yxBmnAhc/Hk9SB6q/8igo+A19
	96HpDbx9aIWRQzpMrzLZjy2FCnonnRojW89AN9rDB1GluKneu9rnsS4ZVTeGx6vT
X-Gm-Gg: ATEYQzyyc/OkTNggSV07TSj7SYtyH2npFFhDuPZHebHETBVu3+0rlL8DZshEQkzrP1A
	1h7OUZn1AtrUfza8wcqVkjdIQl4hzOL32y5sDZa5HhR6BMoS0EIlaNVsCMBfGnpPMLvTmIhd/Kj
	vga/xVxki1OCznGk62K5KobhwjIKFZu5UkilsXQz2BaTdz3Zx3qMC7ezWVAbfR4d2rfO3lU6jSe
	qAhDTMvtQAPsFGJI6SiWL+KV7rBaGXlJ7BUfn861WYgCQ45GozTute+IF8cbKAlamGmW53MdU+2
	zDFx4+/TYkCD3yGDxjtDKLB8ebFsmatoQ0yrxMv1Jyz0Llk2EXatfDuE03Yt4vutKOMmpcJrGfZ
	W1Z7W+iu71tpuXik0I4AkMU530FXa1cW0ZujrUzwued2NyMop+CmEVqaBJzUw7VqhQx4C9YGgHC
	mJ0hjMo/T2HF80K7Jky5CLTqxIIHq6QLYKaj6v+Q/ltGL5FvLxl75hBdANO3E+9sGppbQbMJFBr
	co7czmY6w==
X-Received: by 2002:a05:6a20:938c:b0:399:12d:41f with SMTP id adf61e73a8af0-39c87775d24mr7618623637.7.1774728195844;
        Sat, 28 Mar 2026 13:03:15 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:15 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 06/16] t5304: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:45 +0900
Message-ID: <20260328200255.247759-7-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t5304-prune.sh to redirect git-cmds output to a
temporary file instead of piping it directly to not hide the
exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t5304-prune.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 2be7cd30de..a6d235a8a5 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -264,7 +264,8 @@ test_expect_success 'prune .git/shallow when there are no loose objects' '
 	git update-ref refs/heads/shallow-tip $oid &&
 	git repack -ad &&
 	# verify assumption that all loose objects are gone
-	git count-objects | grep ^0 &&
+	git count-objects >actual &&
+	test_grep "^0" actual &&
 	git prune &&
 	echo $oid >expect &&
 	test_cmp expect .git/shallow
-- 
2.43.0

