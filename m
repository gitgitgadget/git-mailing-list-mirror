Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9021C07C4
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732371; cv=none; b=FK49DJSzMAMI3MX6GRSYYzpjsnobJjMbg9i2U/tohslXXdfW2m/2vHz5Q9qUffnzK8YXoCCiSs6fxT8S33JaPWW1cV/xoVA1gnnYCvNXRUr+ApTgkMomeIMSQrLM1K1K4uCqMIzC9SP2LC9d7OGf3uee/uPyg2CMuHowL93bFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732371; c=relaxed/simple;
	bh=SKvYG7lj9VN6KMWRj5xmZZn9QLY7sOs5fIYNnPNfX3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/XFxzuctVU2sCInuV+nBbwokY4I4kmsn+0k2wenoTBlCJm3bIybkQdHZ4K8Bt5Lx5T5+T1vSl6p4+/7DQF3ttUkX5FdGd9kseAJOX7eSBiXJsMr5NUEqyqe+e4vCp90owOBuRjsQuPb7fM55wOXMDgTufV2p003kN8cfkGteMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgrSZjvX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgrSZjvX"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5d80f5a23eso4225184a12.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759732369; x=1760337169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxhdb8ROMgRv+mumCV+jhCN5MrumblcRLd2hzRRKtyM=;
        b=YgrSZjvXUjEWfaCpEl26AnEmn/9os0bU/LW2dLRcRGXK+KR9vgudgpHo4mUVadfzpf
         3obBQC0SJHggnCbIvCYEBJWqgNE2LeTCgiSZBNeL0UEtu+BELWrf06iEPNrS/dD5ePQ8
         DPU7HRE6IBi/xp+DdQkp4Hk/mAeUV6gqdRVk2fT9L6miBsos84yrmby9Cx5pzlOpE4sP
         wkP8sBEhoP3JJG8DxMxls0CcXcrUl4UAQOUHd28Tr1YCghTqpkHTsF4yYDa4vjB57c8N
         qUXTZDVuCXhNQ8SMryruM+FsDfBuDhLPbc7oLGLSzGqw8esVKcCEc73DDwMr0bdRz4o3
         yadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759732369; x=1760337169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxhdb8ROMgRv+mumCV+jhCN5MrumblcRLd2hzRRKtyM=;
        b=v0L1l+GUuPGQtmqtLXnMa534/lb3TUnTnZWgSvt4Y8J2Znv4fYfMXrRQamHy1LiD9l
         VOsm5QZ+nuarvvUtsnEQOXVtYlRnMVdHbc1n2VpraRjhU4CFciWKKGd7CZMBfY1H5NHG
         j46Bpi8s92ezFcEaqnM22KrS4mQescxtFQepZTZyzyQhcMbDapFO4qmLVHHKGAajgWYl
         Qb9TRwWep/1n1SJ2B3AThYQZjMAXqtCy5cOvhmrr6Q11pwx9ILyY0oQyvBxLOUnMhA9C
         CpDsvECXIWcCt77Q98icV35pnzI36unbY2gXZWAkY7Qw7HQxggV3p6PkOp7dDf6yu5UK
         jE5A==
X-Gm-Message-State: AOJu0Yyv3Xipcd2Lvp2zxgmrN5+y+or/z57Y7Pcf2oaqsP3M8o+U/V1l
	p/W4Wnfh3H0LMTgSaeBmLbWqEiRIeS6PW1gThKN6i+M4pS1rBJY2a5bjlOckcQ==
X-Gm-Gg: ASbGncteAlS9pC7MgGoBq5cQJmaHAcqDNVbY2+Wmt77hFvPQ2a9TL1qeH9xdsj1Yb4R
	B6zEDNpOckaEXGO4UqinnLBlFd5N9bAL9ou//vtuctjx3RiFq/+EaR8Vc0WGmALPVbrYH3xk4BD
	kbJLMbsjQkyEwp9ROofFHcKVDTglZcfEW3P7Yyq3+U19QlmnbiJuG9A7eBoNigJsMeM0ghOsZU+
	wQbtfg4Ml9CFu4WQnf5SRi4zWp/Vasc7QM53L1JCjTekN9WEjyYiAWZhOCC4GnJZH9u4I24F/7r
	X8pFAH+CIA2NnLpysUwQxZMk+iRBpmG2N84jYS5/7XX88fcixi0FIlmT5BGByQ/itC2daTHG3ka
	w6ERjS+nocUUPgZHiMClagstdXZebCSzmxarTtakuagUNIiwk7TJS
X-Google-Smtp-Source: AGHT+IEmyEdznQ5XyMllOlp47zpFSUxLG7sN6kxUwRLYtIuEY8CmhDmTuuAAhQqMWoRLd6s6xfzVsw==
X-Received: by 2002:a17:903:1a0d:b0:267:44e6:11d6 with SMTP id d9443c01a7336-28e99bab52emr140584605ad.6.1759732369315;
        Sun, 05 Oct 2025 23:32:49 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28ea1d99ab1sm82968185ad.9.2025.10.05.23.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 23:32:48 -0700 (PDT)
Date: Mon, 6 Oct 2025 14:32:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] refs: enable sign compare warnings check
Message-ID: <aONikOiigJ2aBtdB@ArchLinux>
References: <aONhmrE0otiyZ16f@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aONhmrE0otiyZ16f@ArchLinux>

After fixing the tricky compare warning introduced by calling
"string_list_find_insert_index", there are only two loop iterator type
mismatches. Fix them to enable compare warnings check.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index b7c0aff85e..668c8ae632 100644
--- a/refs.c
+++ b/refs.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
@@ -2408,7 +2407,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	const char *hook;
-	int ret = 0, i;
+	int ret = 0;
 
 	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
 	if (!hook)
@@ -2425,7 +2424,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		if (update->flags & REF_LOG_ONLY)
@@ -2818,9 +2817,7 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 					    ref_transaction_for_each_queued_update_fn cb,
 					    void *cb_data)
 {
-	int i;
-
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		cb(update->refname,
-- 
2.51.0

