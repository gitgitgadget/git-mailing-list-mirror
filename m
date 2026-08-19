Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4403932D5
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145608; cv=none; b=SaNripyWWeJCzbdOK36Hm4VKxjBeoJlNCY9520jw7HptzY5M47Tz1npmnGIn1xEziD0EoGmF5hMzgmgDUHttPv+f+pYEHNDEXcLncyN677ZPhQr0QvMiaJORMx8PA85e6v3RqVVobIrlCisTaZjESrON4UCUD+csBBBnXHU66tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145608; c=relaxed/simple;
	bh=g48qNFzXKAjUoPXUG/7RmHIP2neHN4nWPNVmz1DC96Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0H7fZm4bGldjhFHZOAemSzblTdx1ZkoSaKsrIelUzkEYD4bDhMmGVLp7tk8svTNSID+gDbjWUFfGytsE7odee48U7qbxKuCLQ37XcpQO9isrx5sFHoNfxFG8jNtnOOcL6WlcHv481Tl+rlwCdTaeSHpRQUJilTIKJ4vehScGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seX1ykjr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seX1ykjr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so9768335e9.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787145605; x=1787750405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AntWTakjVx3sXLfb5OuPJTHPPBaAFeVs7BNllVt04aY=;
        b=seX1ykjrHIedauQXE2S3dmXM9h++BEKZeLC0OFZG/sDFcbxzYbuBdz8mo4XLEAAriL
         85RQswmanlj/vEZ3NaXc526WqH+TQZu3amkgeFLl6eRvF5c0R8Ib3eUQevHvCTWeXLjk
         hvuBFd4dG4bs0e2/j84iSkrPeNCR2mfLGaGS75xqu278oUu/jL1Z1xbZTxW6v3YsUA2i
         U/lpfa4LjlaPQLXJt7OHoDvwdKcISpYK9RDRVpx4/qHT6hSnQJZwUPXf2BdZhXWemBC/
         NmfTvaHChytfQ3xxoFjoGCITN8dEP9VLfqC4nTy9G4MbOOBQKD4dDmCNVvXGNN4wNKxB
         tEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145605; x=1787750405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AntWTakjVx3sXLfb5OuPJTHPPBaAFeVs7BNllVt04aY=;
        b=eGOvpMUFR8EvtCcrNuI1XQHk+TTPTZIhP/mna9+p709JXM7vvG2jr7s7bowFzbQ+zk
         ZaQ8fXBq4dpMZc779gZBlsct5N/BjUlh1ozQbSvJS5SsWm4zCQNUmbbOmXeLjE7wvFjE
         ks9zrtXq+7kFmYggKaMyO8QXqjbbJ5lSpNTk6GEdfWFHND24b+BkgexD4ECqGa7ETblA
         /EhKqL6H8PBhM/8FY9EBEwW4TY3T5obpjMxZMF8qugcoL5mEEJNldNvs/ZWn5lmdmT1o
         pFuNjPAMnrIGiFYKqCLZdU6iSWzJzmLTwugd9xP6Cl4OkZ++4CK0HhcBKQDQDk10SR7V
         bI2A==
X-Gm-Message-State: AOJu0YyCVjklysgjjcsoetlGGp6Bmh0n0B4UlF1TVlO9OTCbnunJ1qPK
	O+mk7GB5NCeKiEtFxb1PPt1wT12Zz9pDKh9AwWcthNXjVY9EIDcKnjNxpm8FQghM
X-Gm-Gg: AR+sD12Zeac+Bl6MD7YmJjieSc5LgUL99Q7jzTXqV6LVxWyYitPIm03Y7DQ9pk18d/E
	bJs5JlvNL6YQ/fj6dhsBMGlXqI4qua2rwB4AulUFeDJDuRPEOJv7DAFN0/RfP1MK7ebTO/z8JD7
	tRJndIrz+QNz6x1kRhEhaFuBU+b4sQsifl8scaR1RZsFyEeRU3aEBw9KkmzBl2CQHRxGan6PM9Z
	2xjIoXppJ3NcjyCoFjAAAZDN3gcTGNpUFKRXICF9BIiB5QGQ/WDyrNXByeILrn9JV+zysCzO7Jx
	zXUE5SAkWLcgIHKsaVvlshuYwErtmWpQi55IBk3Ep5reqt1ChE09IGV97CEKIMzL4r2RRE6F7Ys
	L9/1vbDdcNnkoz5XmUS5jzxKe6NgMykTSj/nThaJV1wgYMUZGE/onqvjQRZtjw+yOxOXMaylRT0
	KHw1MCLs0NdK2MFrHJg2mdqpX9uUoDFheY1jKG4UBgve1GNPxuAzI3vCs22HVMnYXgWnawlu4Pv
	K9iDQ5IkuLAl2yrljHrhDMsbaI=
X-Received: by 2002:a05:600c:c174:b0:499:84ff:b16 with SMTP id 5b1f17b1804b1-499aa1e3c97mr92864925e9.14.1787145605053;
        Wed, 19 Aug 2026 06:20:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:15a6:881d:7fd4:eabb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9ddee1esm37578955e9.2.2026.08.19.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:20:04 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 19 Aug 2026 15:19:38 +0200
Subject: [PATCH 2/3] reftable/stack: move list lock to `struct
 reftable_stack`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-740-optimize-reloading-the-reftable-stack-v1-2-6bf5305d4e43@gmail.com>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=g48qNFzXKAjUoPXUG/7RmHIP2neHN4nWPNVmz1DC96Q=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqFrYCpSHg88T34Q+4Yc4u6to0r2VE+36zt2
 dI+jSG2aPCKPYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqha2AAAoJED7VnySO
 Rox/F3ML/RwKf9bM6RpRRWxO8hiIMhhNAfrSJ833lMCm8R5Kzm/gka+7TjAYoqm+CMjsA8LBoCL
 9mWoG4F0WeoeokcIiYlb2NHmXeJ4Hs+1mKsaqrQE3RVfHHy6BHwYDb+iYWTaKUSHPn2w67amfs+
 iBx8FN/G31KtFnBVpoyNUryI6Q7/lmzk3wcmLNRu0tEC/iYVZUUnCl/nDLre5ZGnsci+MC9M3x5
 ZLb7NFTuq5vpl48T0kP3XjFjjXOxOMq5dMeUdgHxusbKKuTwfWwIen2TWiWl2Z4eLmvcBWvG5dJ
 mB+24IjeHb81Wcd+fBfP2M3C83eSzZQxxjpEpLYhYWr77jjwXO19kTjn7jkDfH5xJiYrNkF1J3X
 f0ymV+PX2pakM9asVNcXIEcHsShMxYT7Bu29nKxDlpQ72p9qwx9ttj9WXkCYFBjj5K99GludK+p
 171bnOCoIUzyZp5dro8g63IZODTtcrz3nR6+LX1pK3gyi7QgTL4GY8Cljs/iBOhoeh2Fv4VMKr9
 SY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The struct `reftable_addition` is used to modify a given stack, as such,
it also includes a `struct reftable_flock` used to obtain the lock to
the list file. While the scope of the field lies within this struct, it
doesn't allow for optimizations to be made on `struct reftable_stack`
itself.

Move the field to `struct reftable_stack`, allowing us to make a simple
optimization around avoiding a stack reload when we have already
obtained a lock. While this is currently possible in the write path, the
write path also contains multiple branches to reads which only work
on top of `struct reftable_stack`, and we would miss the optimization in
such paths.

While here, remove an unused header file from 'reftable/stack.h'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/stack.c | 15 ++++++++-------
 reftable/stack.h |  7 ++++++-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 540f5e77ac..e449af9c03 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -536,6 +536,8 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 		goto out;
 	}
 
+	p->list_lock = REFTABLE_FLOCK_INIT;
+
 	err = reftable_stack_reload_maybe_reuse(p, 1);
 	if (err < 0)
 		goto out;
@@ -628,7 +630,6 @@ int reftable_stack_reload(struct reftable_stack *st)
 }
 
 struct reftable_addition {
-	struct reftable_flock tables_list_lock;
 	struct reftable_stack *stack;
 	struct reftable_write_options opts;
 
@@ -653,7 +654,7 @@ static void reftable_addition_close(struct reftable_addition *add)
 	add->new_tables_len = 0;
 	add->new_tables_cap = 0;
 
-	flock_release(&add->tables_list_lock);
+	flock_release(&add->stack->list_lock);
 	reftable_buf_release(&nm);
 }
 
@@ -669,13 +670,13 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 	if (opts)
 		add->opts = *opts;
 
-	err = flock_acquire(&add->tables_list_lock, st->list_file,
+	err = flock_acquire(&add->stack->list_lock, st->list_file,
 			    add->opts.lock_timeout_ms);
 	if (err < 0)
 		goto done;
 
 	if (add->opts.default_permissions) {
-		if (chmod(add->tables_list_lock.path,
+		if (chmod(add->stack->list_lock.path,
 			  add->opts.default_permissions) < 0) {
 			err = REFTABLE_IO_ERROR;
 			goto done;
@@ -774,7 +775,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 			goto done;
 	}
 
-	err = reftable_write_data(add->tables_list_lock.fd,
+	err = reftable_write_data(add->stack->list_lock.fd,
 				  table_list.buf, table_list.len);
 	reftable_buf_release(&table_list);
 	if (err < 0) {
@@ -782,13 +783,13 @@ int reftable_addition_commit(struct reftable_addition *add)
 		goto done;
 	}
 
-	err = fsync(add->tables_list_lock.fd);
+	err = fsync(add->stack->list_lock.fd);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
 
-	err = flock_commit(&add->tables_list_lock);
+	err = flock_commit(&add->stack->list_lock);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
diff --git a/reftable/stack.h b/reftable/stack.h
index f7901e6c6f..52e07ad551 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -10,7 +10,6 @@
 #define STACK_H
 
 #include "system.h"
-#include "reftable-writer.h"
 #include "reftable-stack.h"
 
 struct reftable_stack {
@@ -18,6 +17,12 @@ struct reftable_stack {
 	char *list_file;
 	int list_fd;
 
+	/*
+	 * Set while an addition holds the stack locked. Used by
+	 * stack_uptodate() to skip reload checks while locked.
+	 */
+	struct reftable_flock list_lock;
+
 	char *reftable_dir;
 
 	struct reftable_stack_options opts;

-- 
2.55.GIT

