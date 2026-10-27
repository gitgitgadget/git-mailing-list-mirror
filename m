Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098858;
	b=5ANaXMk4LMuYkb5iZm+kOwKOZfRaRKhcD/I957qrswA4QCN0/0bfCJYwNFRiwYQivHeh
	 M1qeZ0Ga2oh6rfM5irtEiVnVhO3DzagJ9/abTFXZduiMTU29YsJeFgCClrARPopNuO8+f
	 jfqtCAMsJAxFRMq6F39gup9j6WsQ4mii9u2i7vQEDIhsosc56jdwiP4RFeYaXDx36+Nf6
	 j44KIAGqyH3ikQNFVIyyjUaBjM7kl10M7ekj050nooQIeAxctAOkgclicWFaERjWTDYFl
	 Vh1QtepYLBsDGJ6eul2/otgZKcNOLaFzLXTeEo0zUhFTzMVmFhlMIXDUM1DbMiiPONA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=T8Tq0MqJQBdVzBggqHI2Xk2juCZlYfAyrhyxyN4xwY0=;
	b=n6vW46TjklC/kYzq1gUJup88Qm8dLIO5ZWJIWgcIdY/dKgnb+sUP/e2YYRyxBEJ+Zgrz
	 v/wX/GL96DvIWICrNXlFgMe8lfdvOJeNIw2+FWzIQmpnMj/GbOe5fToXz/m4cdPfHJ58n
	 HHkVjk4VB9lO2n6dHuYe4dW+EW6vzRK0OIe2SbkjAWTyyo19B8NMU72Bpf+wmtkbg2TKe
	 AgypfVhg5Fwk50i2TZOXAl+eKnnXLbwZ+wqbvQdeU10Sc+H8HCoD6rMu7fRH+fwV+JSnL
	 AWNsGKC0FCn9elFmWKL7/1NajE7N3JFhujNPQd41685hfSLqbmq18zmj5+Z6LtUye9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tBMo4Fd1;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07760A2602
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C07760A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tBMo4Fd1
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-846566246e8so747752a34.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098856; x=1793703656; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T8Tq0MqJQBdVzBggqHI2Xk2juCZlYfAyrhyxyN4xwY0=;
        b=tBMo4Fd1kxbofIPhY8lEcvEoPzzkRaWWOVC+b9AP0SdIHlZJfKqT0V/F6hpaaKydZS
         ytpoDKlBnzA5WE2EJ3IjNhgRZMZyZ3KxSlHZ276KXnh+THaf98KeRYrZT+rwZ7TZGLfH
         ajfYwk8dnzJZdRqpxP/xPykLu4MHNidSX8vI5IgRQM+2+aIge0to1GQrpYsrQL0hUnV2
         VekOvciViC/uLVbHbzMgobCSh5DdCVDN3TDfduW+MGyqCedfuTa1cmBf7laI9S4Ai56C
         6fzNOXiU99p37ruOwEM+CGmJ6OUNsi51cTi1wAGdWhzgSXwUllZx62zS+YWTU83P8b0l
         aUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098856; x=1793703656;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8Tq0MqJQBdVzBggqHI2Xk2juCZlYfAyrhyxyN4xwY0=;
        b=UruDpNrPRW4znXKRTSi71Mwq9XgTyqndGGxLIyTPSCRXX/yXVwisIURMOtYPrd14RP
         SnCcrecFWiYnglJ2dVykgJvZROOLaE+YFALuY/gMFLYuKmpmp41uvZf/opihsodMI74o
         zOum3HA5X3xCLJgOGGFlhxL4pMlY44/3r8oB0b2bNFrpmUuBYn/rnEkx6qiWaqTsp8RR
         EO4s6wDCwumTISP78wbqUc9M3P4yht8xHZ5N+K7C0+eIHDfsFEc1dWBwR35b70u+bdK9
         nUJV/7gFPMifkIC1ftafe3wuzQ3VRZs0WZqKWS/6gJhmu39I8CcuGnE7JFqtII6yratA
         ITjg==
X-Gm-Message-State: AFq9FYLjjePlYcge2rYyXk3VxZvpcK/Mi9kEvqKjuBlQ8OnkDUBibhBx
	opBUxdAPPsafLtfX+Aty7gBRC8OUrjDx16LFV+kj3wz2L1uGpLeFe5r5gBaw2V8cyAw=
X-Gm-Gg: AYBFou2q9EimTfI7VH6ttfEQ674qKoiVkIu6F7yqy1iNzEXPNHEyAEePpEm+8N592tt
	5Gnw3bw41WRLNDuaRiFbfAX7Ego7IrphYL+QAxluRdOox9bieMmvN5WzeNcR+X7S6cSXPTLv/gO
	5bXIZMZSSdEfsuk+C2S/5ARSetlUXD0vch4u+aqVaGlTFFoKTkQvtafLgC9uLM8ji+J0+0cFCru
	SfKrd6NZTCZxcqBnvtSh27dSBlB73sS+tWboNPxPeYkRryTSa4XPRxCkDgUrVy2Zb163XLSIN1h
	E9nXrhUxiK6IT4W1I/MuPV84wu+YrQxJ7WK0zxJSRFNk1tNxZbmcfD9l7+4d6sxLAehmtBFlVDQ
	r4CGsEHjQ+1OPGiBfywKy9si4MySSzTjulBOtqxuaxzWxU+CoVzCYJ/crPEuKPB39Ql6uhVz8RL
	DA7Ajc+U6ieda4Q5ttnQ+ItDdZFEqW7BCnpAPCTT9PWFf/x1Km4JbHWmucsKKxOtklkegOKI2RI
	wBjFDKgrPernpJTL+JLFgp8YnNzOZvRsQMdZrf4ynI5rtoj+GdezcHRwL4=
X-Received: by 2002:a05:6830:4486:b0:817:d181:50ad with SMTP id 46e09a7af769-8593fc72f8fmr1331498a34.2.1793098856309;
        Tue, 27 Oct 2026 04:00:56 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.150.193])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458d7fsm10187873a34.2.2026.10.27.04.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:00:54 -0700 (PDT)
Message-Id: <pull.2276.v7.git.1793098852493.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 11:00:52 +0000
Subject: [PATCH v7] diff-delta: use safe integer arithmetic
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Pablo Sabater <pabloosabaterr@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

In create_delta_index(), buffer sizes for allocating the delta index
are calculated using arithmetic operations on entries and hsize:

  memsize = sizeof(*hash) * hsize + sizeof(*entry) * entries

To prevent potential size_t wrap-around when computing allocation sizes
on 32-bit systems, replace manual arithmetic with overflow-checked
helpers (st_mult, st_add, st_add3).

For the unpacked index allocation:
- sizeof(struct unpacked_index_entry) is exactly 16 bytes on 32-bit systems
  (4 bytes for ptr, 4 bytes for val, 4 bytes for inner entry, and 4 bytes
  for the next pointer).
- sizeof(struct index_entry *) is 4 bytes.
- entries is capped by (0xffffffu / RABIN_WINDOW), limiting entries.
- hsize is determined as the smallest power of 2 >= (entries / 4), capped
  appropriately.

Using st_mult() and st_add() guarantees that any allocation calculations
will safely die() on size_t overflow instead of wrapping around.

For the packed index allocation:
- (hsize + 1) is passed to st_mult(), which is evaluated as an argument
  inside st_add3(), and is safe from overflow because hsize is capped early
  in the function.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] diff-delta: use safe integer arithmetic

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/2276

Range-diff vs v6:

 1:  b91a1ed54b ! 1:  8eb6d31788 diff-delta: use safe integer arithmetic
     @@ Commit message
          helpers (st_mult, st_add, st_add3).
      
          For the unpacked index allocation:
     -    - sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit systems,
     -      which may be padded to 16 bytes depending on compiler alignment rules.
     +    - sizeof(struct unpacked_index_entry) is exactly 16 bytes on 32-bit systems
     +      (4 bytes for ptr, 4 bytes for val, 4 bytes for inner entry, and 4 bytes
     +      for the next pointer).
          - sizeof(struct index_entry *) is 4 bytes.
     -    - entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN_WINDOW is 16,
     -      limiting entries to 1,048,575.
     -    - hsize is the smallest power of 2 greater than or equal to entries,
     -      capped at 1,048,576.
     +    - entries is capped by (0xffffffu / RABIN_WINDOW), limiting entries.
     +    - hsize is determined as the smallest power of 2 >= (entries / 4), capped
     +      appropriately.
      
     -    While entries is bounded in current code, using st_mult() and st_add()
     -    guarantees that any unexpected growth in struct sizes or bounds changes
     +    Using st_mult() and st_add() guarantees that any allocation calculations
          will safely die() on size_t overflow instead of wrapping around.
      
          For the packed index allocation:
          - (hsize + 1) is passed to st_mult(), which is evaluated as an argument
     -      inside st_add3(), and is safe from overflow because hsize is capped at
     -      1,048,576 early in the function.
     +      inside st_add3(), and is safe from overflow because hsize is capped early
     +      in the function.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      


 diff-delta.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 7cbedeb507..efebce3aca 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*hash) * hsize +
-		  sizeof(*entry) * entries;
+	memsize = st_add(st_mult(sizeof(*hash), hsize),
+			 st_mult(sizeof(*entry), entries));
 	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
@@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	 * Now create the packed index in array form
 	 * rather than linked lists.
 	 */
-	memsize = sizeof(*index)
-		+ sizeof(*packed_hash) * (hsize+1)
-		+ sizeof(*packed_entry) * entries;
+	memsize = st_add3(sizeof(*index),
+			  st_mult(sizeof(*packed_hash), hsize + 1),
+			  st_mult(sizeof(*packed_entry), entries));
 	mem = malloc(memsize);
 	if (!mem) {
 		free(hash);

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
