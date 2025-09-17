Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F992BEC5A
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100806; cv=none; b=UuMZUDXK4LunUw24DPZd+MRxV0s8CiS3JMorRZFQQ7vhH7jIBzCl1Spcnk2DZeBPTplJAxfXQDEtzka90WrHds4DURGLf4LzIqLvy6xilUXOkYPSqnr9dzj5skW/GJ0lgiDLAYje6XkuTfIFmvN8V2irNo3gSV37WVJLt4D3RY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100806; c=relaxed/simple;
	bh=YxflvnelRWTDGnYw8qT748OsDUSlpuNkuHr9XAQizAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1tysWwYVi8PbR1SAHh0QzcOAxEMde6x0rj+EIXVkjPs4XDZgxrcT68k3Nwe25Z9NgGReaPj+ELqedoSYkVPoYO14MDasehf3BJZyolfL8wZsBcF1s4Yjsgbg0SPhL+o6C5H9iMgWPfXYJHdH1V/mG8Nr9/uaM4VyQ40PgFAGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/QjZSkh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/QjZSkh"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b54fa17a9c0so42461a12.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758100803; x=1758705603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUo+y6+wp6hMvfjarzReyWoDDTFmxvuNTxR8NdSRxQM=;
        b=M/QjZSkhugJnMk387Yoqsy3bUyeaSY24KW+rlizS2M3QVGB8TDvJQ4LtWVzqXahwP2
         VO8R5FxcjahRLTE70vKO83kCSOiiGXXEpYbxBliyk61zw0duMdmzrwBhIAQbE/in4UrK
         ojpA7nfAdXhOYlswXZDyaCJAjJE+HyHXcbcNacm82SD5DdD64d72V7i4XYdMtRAmTZXb
         +CN7+yMjoBnv4BtxozMOHgbDulWnFdoW2ElwU3j1br74kTDQf1dI4bO2UZX+4QTxnE03
         pbs6rTDicjh6okT3d1XTs39TboTRSMzn/bvVmPtH3cG3LOHPB4jkLY+sz79BpsWzvXEp
         z6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100803; x=1758705603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUo+y6+wp6hMvfjarzReyWoDDTFmxvuNTxR8NdSRxQM=;
        b=vWwnmwOoGu7xP5K39LkiuXkffsk7dWFnxMQ8eQKeBhxP/9jqcm8zTPqjKfx5qsdaZc
         DiEKA26M1D/ms9Sg+0BfiVccKZRdmKTcrcG62Qt3eM1ZjFbnqPpkhqki2FkHRBzqSbof
         TG9Cwe5uIstSc0v9JvYAhPUaC7KnxXXJk98l4CQOQkHunoBGeKkc3oti4QiO2xbK11HV
         qxypOMsk/8Eo/KRDShe5X9MJmBCo9dUXEsFvT/0ByNIjL9bdeibGRJxdgZnhKcSPNcva
         TH2k3B6WsSHgjvTnCrxgysY8eKNk6BpJqVYf35YyjugA6zfQDmkbAZyHuzs+Zpd64SO/
         ytnA==
X-Gm-Message-State: AOJu0YykmUSJSK+ncDUrC6kXARtVdy99uv/lexedneHr8fU/vZoeV+qa
	kbr6/nWi43XvwfMht6GBr5lspymDDe8Kj+Bb/qNN6i+5y89pXfWHvQubDK7BWw==
X-Gm-Gg: ASbGnctlBGyrAIx8NezTxgdiB6gPStUXvyi0rCaJuaINadnPZhFkklOUy1FHdSuDHB4
	jO2d8mq8rmla9RrkBXgtNgrqvoM7ivCga2cIXlX9EFq6r3MizMq41P1cGV9Pv4XEqMMvn2bkKxc
	moYYPD34YeEN9DRn6Wc5Z9Pq6tsAUr5LcJwIFtMxChET6OLXD+fRxpOGjCy0thndJzmzUqUfcd7
	iebGXttsMe1uJ9Np4ct0BbxRygI1lRtlNEbnmsTvQho8URH9/GCKY7jHCcqAmYWe41Wcz6mK/og
	3P0e7ba4YYpU60eHmuJyNj1FyS7nPxsSI8X9CYpbHOfRAlapwkeEw6wtCOFb0RRVopitciJlsyB
	Zo4zVZcHAPCAhwLSA2g==
X-Google-Smtp-Source: AGHT+IH3pTMxdFLR5PFsggymRcNoPJJITZKGxd+r8qyosFktU3opHYOGXeRhckEtvF+QwCHz71w2+g==
X-Received: by 2002:a17:90b:4fcf:b0:329:f630:6c3 with SMTP id 98e67ed59e1d1-32ee3f61eecmr1849339a91.20.1758100803097;
        Wed, 17 Sep 2025 02:20:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32ed273ec20sm1852113a91.16.2025.09.17.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:20:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:20:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/4] refs: enable sign compare warnings check
Message-ID: <aMp9SretmFxYrHsy@ArchLinux>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMp8yNFiXDyk2hP4@ArchLinux>

After fixing the tricky compare warning introduced by calling
"string_list_find_insert_index", there are only two loop iterator type
mismatches. Fix them to enable compare warnings check.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index a8f06b9a0a..79069c37b8 100644
--- a/refs.c
+++ b/refs.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
@@ -2381,7 +2380,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	const char *hook;
-	int ret = 0, i;
+	int ret = 0;
 
 	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
 	if (!hook)
@@ -2398,7 +2397,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
 		if (update->flags & REF_LOG_ONLY)
@@ -2791,9 +2790,7 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
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

