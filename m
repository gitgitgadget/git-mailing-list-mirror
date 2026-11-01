Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547421;
	b=0lIq/ZpTFdcdJxXp0cwqsgAkx1aUoEJWsdmic4vvuRBOD8Gdb9YgSyLTo8w3jR9nSG1+
	 ovk8idrlUtoJG5+YbdMZbKyO5CpjRtxWjrmHk2tEVfXVyiQ07guotymdHgsHkEDxMRrXe
	 ixPSB+OnAKPO79tzSGNRyAbo+mnkhlaoeKNLXO6arfHPO0RF41xKSf3uAAkewtOvUJbf+
	 1x43V+qeUx9Nx4jbrVw/BsHbw6QLUiasrzeChA/XGI7mDxSUqPS3YCiWfaDaGRh5/HHnO
	 qTCglPDZRDXYmOVdKdx79QS3kDsm2SW+tGNujTNz2v4PfcEoDFStRG2K/B8sz1n9RAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WgBAFchSM0ukp7/Xjkswu8plhhaucOrtBSThrOjqYFY=;
	b=UdryFHxzXJIAZ+y3o0WH6LM5tsPrC6MMNpuiQB/sG1QFi57LwBPjlBhIR4/5/KJWB1R+
	 thT8v4rHNmXYa0Qo/Gi4UoAkiJiYLjMiFIn7DuVAhBaQxNE6WCL7zOYgbKUvu/NRqhm3F
	 532ZSF/NcocPAf2P6NgCGPqp+l28Y5T7OPqWYOyOj7cN76se7qqcPxdrDtMx/7pMT2b1/
	 GYHO5DnB8I+z+DDlGrnAb3sn5dqV8xaw5s7jJ157RfAvih/3fFX/FKUBg/3BLI7psAZ4S
	 8oReQUcvnSuvs+RkkKkL3XA5cB0swOOzj1w3UKqu/tVDlCyHlyIg7vHmNXplaia0Ozg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NQE9yk+5;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19001606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 15:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19001606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NQE9yk+5
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dee593f18so1973671f8f.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 07:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793547419; x=1794152219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WgBAFchSM0ukp7/Xjkswu8plhhaucOrtBSThrOjqYFY=;
        b=NQE9yk+5XaFG44G0GC0fdDL/9onxHeYmGFUFwZhs8s+3yLPU0T+D57Yme836gRz+rL
         uQMjaYz9GwooMjPFurhC19mIpBBKNQucjF/pVqGiFwGKEhnRmCRqhIN8nyQQeDdXcj3L
         +t/PF41ty5qNTHJGCIGSl2Ov4dKtB7abq2b5eJ6ITDKcDUSk98rIq5zFlQdofhMSePL2
         0hWY00lsCwKoKEGuAk6srkjnFgU8TuDA6KHp/f7JRYF6c1yNuAviTnED+DkY2kFfJKgM
         W/MrCiVcMFwvsMA80HgyRVdrkxdCbvG+hAPhElHye5YHHCtUHj/q1q9ZfuRAilvfV1cT
         LYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793547419; x=1794152219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WgBAFchSM0ukp7/Xjkswu8plhhaucOrtBSThrOjqYFY=;
        b=GZzG0QdG/Mz+Ql9+iByrTKj+WuBTi+uurrpGbVNH41+Q1Wo7+dgqMkerPcbPkGjvGS
         u1vD908q6gTnFaPLrP3UOme9yHLEZ9huFWqANIIToSF7wb7aq/CTMtXcR65ii0Tq6j/E
         Vaw03Om1h999koMEBm6r/lR/f1IfQW9UlYd0Bwim3dYYnwEr2gc576adUYA8HSG6zUxo
         eBSH4egIsch5zdIzlhkB8Wz3gP/yjblK3ryk1WeAuD+70x35QUWxmoWQNsMp0/jmu/Q2
         DBPLkHewcc/fsNU3S17aAFShxTk5FRDKkNbdVc9n+Zhq/r6+5iJJXsG0y0/ySRDsHf2R
         17Zw==
X-Gm-Message-State: APuU4Z8WKNV3w8hUJpjax8ZEjZOa+9mf7R6Vp5Oar54xzYrLe6Jk5rYW
	MWJXcHLqlZPY8L8ZLATBG/Hv9CQW8XNkN0f3W60CeZY1xr91NgSVyWw7UzARJfRg
X-Gm-Gg: AYBFou0FKwGlRoe2gptsuEI/FWCnZJ20TOIyadl71ULxt2eG+V0Fw98oPMEVm8WmtBY
	lDEqPxL21thTRgFjBTlKTA+4H+mBayiku5XsItYNG1wjwGx6h5Q0ivscs0Yo8CJ/Wnfp3BEExhC
	1qfAu5XAUYIQMUpG+xUvz43hGSIz9mANVbBdGaEVGIyB6B1BeuUr54mdb3P/x7A9cDqHUHJZvMr
	aVfeSbSGnmLMncjfZ+MaPW00U+SFABiUhBs4IxNZnBI2rZwvtXnFlDf9T9JcbUDDtWxnTRVXWYT
	hj9HS/ViL1/igrCuUCmdOJ5KkH+3vma4ixB+FqB5BCSbxyIugQl54dprC6/aFET0LEqpVb7FSUu
	rFSzK6p8k/adZJ01B6hzIYhUQ2KhD98Q8rCE5a/Wdbo+WB9O8BIa5kA5MPLLlpPDL3PujnfirDo
	mPo4ItNKuYad+osZSZCYUHmwdu69Pst9VfTobJMGwnYfDf/FKyR2Xl3DVBqwzBSLbQn9gy2I8Ag
	dNxzuKy1LjQj1U+Sz+w+kOtKFYeNlD4UKmJ5F5KeZzrlz3LhX2Q4M06NCXU9IV9ip9OZnP9IqHO
	R6I+PVhOqh5J8tN4hXRsWMCeBpHGrAVNFJsQaA7TS2PbeTfK/I0lGeR9OLNiHsiQ
X-Received: by 2002:a5d:5d82:0:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-48e6e2b9e97mr15652567f8f.4.1793547419426;
        Sun, 01 Nov 2026 07:36:59 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7246fsm14908450f8f.19.2026.11.01.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:36:59 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] diffcore-delta: use size_t for the size of the buffer to hash
Date: Sun,  1 Nov 2026 16:36:51 +0100
Message-ID: <0c5442280cc441ffa3ed61af74466e2b4d2d6794.1793546752.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793546752.git.gitter.spiros@gmail.com>
References: <cover.1793546752.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hash_chars() in diffcore-delta.c takes the buffer size as an "unsigned
int". With a file of 4GiB or more, it hashes only a prefix; because the
similarity score is calculated against the full size, similarity is
undervalued, so true renames are missed, which also affects
"git log --follow" and merges.

This was verified using a 16-bit simulation, where
"git diff --cached -M" reported a delete and add instead of a rename
(e.g., "D a" and "A b" instead of "R099 a b").

Make the size variable "size_t".

Triggering this requires processing a file of 4GiB or more, so no test
is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diffcore-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 2b7db39983..7f10f79ffe 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -127,7 +127,7 @@ static struct spanhash_top *hash_chars(struct repository *r,
 	unsigned int accum1, accum2, hashval;
 	struct spanhash_top *hash;
 	unsigned char *buf = one->data;
-	unsigned int sz = one->size;
+	size_t sz = one->size;
 	int is_text = !diff_filespec_is_binary(r, one);
 
 	i = INITIAL_HASH_SIZE;
-- 
2.53.0

