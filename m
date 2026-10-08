Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E0471255
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452668; cv=none; b=FHgxlD/md8IjtR+OI96HQzK8s2Wd4Xvv1DtZKq9WQd5XDPpsOreJN4TzNJKjC2ismnXJfyRVBpUJRdPAByUFrjURGVSC0TEzU8LAIIgmpk3muYf5dFkE9BO6FUHh6qhwVhvM6AzyzcqYbzCFs08nxXmWBWIR7wXauSqCe4IGf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452668; c=relaxed/simple;
	bh=CQ9tc0S4DF6GUVCfEqc/dvakJ8PZZwTyyU8CF6Ka+tw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc:
	 MIME-Version:Content-Type; b=YmMo/r4ztLKH+vdH3pPGWSQU5MvKi1OC9u6Jib0YWiPkCW9vKQalztzHuKXIze1hb3V3wSi7zKccyg535kyaFpBVDAisuiaFO3I0BQaAd5izHB5rkFhi+HImvyjHWQZ+TBxzswUekhO4wh58oOhBSlu0McFJfPqkIkvT5mY7CJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jab0Njo0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jab0Njo0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso394071866b.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452665; x=1792057465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LJ2yz8p+QEInIrNniat0kFdGA/TjgDaQCju0t049nQ=;
        b=jab0Njo0g2qR1nwhamFvyY/fuWvMveCZBT1BMBI8YB7sw5XavmQAXKllwfYYi9FOns
         CVb1EmH22JOrJLUeJBSQ/6wnbnzOLsnYG7SFAFcYSZdMyWsJlrQ1nlpxQi5gW6Z0yMw0
         sj0AmK7DvHg3cRHy3IIATok/8LzMbDPE8j7C6TO/AnLWeucyrnKgSBbhXSB8210ExaW7
         wP1rvZg4p8ZVcRQlOKivB9Lcg5ZwB7qx5kH8n5dDAhtc7QN9krZcXM8WOuKUU60xzwdB
         R5lMHdVq94FBcRZeYP9TGblLRZyf3JngteFOrEkaxyKbGq2+WbyyhwOOM6pZB1lbB9B9
         q3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452665; x=1792057465;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9LJ2yz8p+QEInIrNniat0kFdGA/TjgDaQCju0t049nQ=;
        b=JkzsVbZl7sIT2ZfPnxJelTIWrCHeaFPPUgsBbpRv19Eyk/jNfKvJfT+FMiVRL4t6+b
         6lbNTk3bTiSkx7x7QN2wZPUQ/d683Snsgf3OqZuDJuYhqbtbR80X07RIGaDvIps16Hac
         hUveeWlz+JQtt64UMJU3y7snmH0ptaIz6tt6NF1erDcZvEOdkMOzgWU6DAt7t8KuoH65
         5KzxzbQtrfeaUbrmRsruixbdFuyFXvO5nI6PQVdu/mvqW4GbacDikX89jNx3kiMA02Vy
         LKGGIapEAndLMY4leRvsTK/IW8iTGtjnLrAFCx8JXSV3Oi9crHYeYNMv8J+Md6ZCP+ib
         +tog==
X-Gm-Message-State: AFuF++kqfskM4rOBVin1AynIzqw/KW4PMx+8GX2ZiVI3iu9lnW428Zpb
	WoZ13pvK3dQOTH0nu4qyOp+bx4OlxUjJrOgtkN0HUYX2OneU44M5hSlxiW0grg==
X-Gm-Gg: AYBFou1DIU5DkLJEl2P61juY2HT36Qbnt5mCiguvzvQWQAixphuLLluBKRIOqhvjLe6
	lQZe/lSQfV08VhFbx8KPVqutfbF/mjCcWTo97yjGX5ZbT269Ete82O68aJcbu+Rn9sg/H1i6lzi
	b2xF8UNPiGlz1WRRlxw9D6m1L1a0gSGCjrfvDN1OGone40VJE8z0pBLBgjrCMz/KbuT5PBajpBs
	kydsbfaOhSRjhYLvdGaBWXkQzWuYeX8dpLZ2J6chNQFSE7p9Iy3+JAfafwksWcazGakjiSD634s
	WowUDpyx0kJ/fpZrts502yi3vBElaRxSzTQcHWirHZ4rU7afseDuRzjqN4BV6aKo6s5wUsI3aF/
	qhCuBapDfJz5omObEZI8f3gRYOQFAN2RZfoAfcHvxMhTlID5jeAPr2vmaXF7Crg6IExni2YY7WM
	EY85yTek+0awZrSc1owqLpMDQS6OXaJMKmkeoYbGmt8OWdipEqK7syryoOh0lg6hTv9C84YKXZL
	BL4mz5kytbMnlXHi4k5yPv2VuCZi5QQoQMfwhJd74DW8TRTwxHs7RQNkVQ1d5FKX1SkeWtsQyFw
	e85DXmebf+mdPYC362lTZHZYYmuuAZZDHqVFr4OAAtMhm7Ft/E9G5qt9eJoW4v/juKPXMeullTT
	iEVRqimGJte0JnikXNPNVfHok8NwVDhJnnKOvhz2SR7k=
X-Received: by 2002:a17:907:3ccb:b0:c2a:6bee:77c9 with SMTP id a640c23a62f3a-c317bbda556mr464983466b.4.1791452664835;
        Thu, 08 Oct 2026 02:44:24 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([192.166.203.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c318ae45e19sm114188366b.61.2026.10.08.02.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:44:23 -0700 (PDT)
Message-Id: <948927d8fb4ca94742294d4f423ee1cb9819a7ae.1791452597.git.maciej.ciemborowicz@gmail.com>
In-Reply-To: <cover.1791452597.git.maciej.ciemborowicz@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<cover.1791452597.git.maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 08 Oct 2026 11:44:16 +0200
Subject: [PATCH v4 1/4] refs: distinguish internal transactions from logical
 updates
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Karthik Nayak <karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

A ref backend may use a nested transaction to persist part of a logical
update. Provide an internal-only transaction flag so that these physical
updates can avoid reporting the same operation to reference-transaction
hooks again.

Keep the check in run_transaction_hook(), covering every hook state in
one place. The flag is deliberately not part of the public refs API.
Subsequent changes use it for packed-refs updates belonging to a copy or
rename.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 refs.c               | 3 +++
 refs/refs-internal.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/refs.c b/refs.c
index 951db56113..642f895b71 100644
--- a/refs.c
+++ b/refs.c
@@ -2689,6 +2689,9 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int ret = 0;
 
+	if (transaction->flags & REF_TRANSACTION_FLAG_INTERNAL)
+		return 0;
+
 	strvec_push(&opt.args, state);
 
 	opt.feed_pipe = transaction_hook_feed_stdin;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c3ac7b556f..0b41f5fa4b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -8,6 +8,9 @@
 struct fsck_options;
 struct ref_transaction;
 
+/* Physical updates nested in a transaction already reported to hooks. */
+#define REF_TRANSACTION_FLAG_INTERNAL (1 << 2)
+
 /*
  * Data structures and functions for the internal use of the refs
  * module. Code outside of the refs module should use only the public
-- 
2.39.3 (Apple Git-146)

