Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A437822D780
	for <git@vger.kernel.org>; Wed, 31 Dec 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191949; cv=none; b=NEAkX1ws+KLDmVtYOTEdtyi9u+q9Fw8176k34oiezVu5F+kVwfToRZUszWU7Mo3WWshnJWWuE+DsYaQs3zt8xfmPh1T/AprA+G15fZyBMcvMN3j5QMN9diYJOoTtDN84AzV5Ot6K6mAUGzIUgO1kVL68ZxY1oOQGEkW2tN1O6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191949; c=relaxed/simple;
	bh=tQZmXB26k7l1DNqA7asp8HJxigt5SGdAtFVb0vSWyec=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=neGrt7GRAsHO6YpEAvi2sxXjxcztNaOFqa/+Ok0GswNeog+Sg1s9+8X9bdm2EpBU9ddfpM5ldXa6kzHew3tO+/2UbrM//VlmwPCqJBWsZkCUO+W7tEp7QeS3u8+KKjO5STySC8t9hwJ5+GU+2Qs/WtsFGz05sz9nBcPo6eKbL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksm+R1kC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksm+R1kC"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8bc53dae8c2so1656940285a.2
        for <git@vger.kernel.org>; Wed, 31 Dec 2025 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767191946; x=1767796746; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDCXIYoRV03HKmuzL+PtiAGKR1ztjnYmzXFOkLhlDRA=;
        b=ksm+R1kCh/Brt0Qaro+KnrYoSx5Bidi+esVOh94+3XC27HY7hmGeWFAKAWOviQCizj
         PTEen5XFHGqnSZhT/LTkmPyMehnstczPC8sEqZvlu4hklim70JQXuw497YEzqrFRlSYo
         8Q+IBZq6R6cifOg3VyKoQFvV5HjpHww65hYLlLDxx3j+HUj6MwTVBkBfWpoB/0gjHGUP
         aRPm9CDWOAn3W09vkoTb5taL/DMCUur3F7d+fD+UUPgLs5oQRMmqNS/JvoLH6Dknd2lu
         8/ika4yKFUQhU31CBuYCdBR/b/Oao7YPWrDVAaJ3+nsjxUES19G+sLcHVnPgoUN91zHq
         I8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767191946; x=1767796746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDCXIYoRV03HKmuzL+PtiAGKR1ztjnYmzXFOkLhlDRA=;
        b=pPcF2pgjR4eeD52cXTc9COYaZODhEcAwdHLAOTkdpripw845qOE9fQ7Puru3Y7xlFm
         2ZERea61jDNKW3Y3id7z+dHjP8Y062B91c+rZWJ7y4K1ScLD1rMUv68GlvlnXDkV1GBP
         L+b1cHgq4smZXYOFBxo0Vwfj1uatDo0yTpdUZ01K86Sjhbc3mBrA2PzJH8Qov38rdG4J
         viv3qLXNh/9TzLJMmpK85PzIIFt6ImZzPCki/4ho/Yj0OWa8DXNKy9I03pitijr6OmUd
         1i4fI/uZutUopMoGP1wiIek9qYD9Q3mj5OiQbbWo0+4zoGTmKkk8m9197Iobv/pU74AT
         ckgg==
X-Gm-Message-State: AOJu0YycBIKPsJLVxrpXg0AKjtpRTf1tTHpeG/YksFHEpItuV8zzU9qc
	w7T+ApUssxSe96AJdF3m1LdhtsDAMOUWmgqDTOtR3Z7/vp1ByYa4HpjTaAvwaA==
X-Gm-Gg: AY/fxX7E55/avjFEyI5wu5PCC6sQavqQawWunIWFkNBSsoMRZ2ntwMkBQhTwhy9Pa3S
	5x1OnpeGxVynIjVC+onp2mFyo/fBlomiIblfH+As0zMksir31kDLZJs107jOl7N/aTtig8vbXgK
	b8uPFWxg+KyX46VkRMnmuPQe/pEbYdi+6u6GwwXkHW3CS2SVvbhQB3suBHGbxgz6ytypP4RdXut
	At6+Zr7mevvBEI9JA1hi7trzfNjZ1htkBlc/ZRlUhUBYfW5G4m6m/48bULs0t6N54J4elZwrEXP
	onFrtnvBjxy4G1PhzjNZimwBMWBw+kEPKoSMDUB0KKotoW2OuQcBLv6QjlVdx5hNUiWn3m8iI+z
	Ar6AM0+e3GQgtpu56SawVyHs/g83uVmiigfm0RibWx8U3oN7POBDbR4U+d4CiE3r+i9NEYD4lnJ
	M+f/+ZY0E81Xe3Sw==
X-Google-Smtp-Source: AGHT+IHvMQgElfKnyaUAtAQyZ9oQvw+g6QpJTHDDRqTYzISsOA72yrRJQ2HEswOF/NFidoFlyqFWmA==
X-Received: by 2002:a05:620a:2945:b0:8b2:e70c:427a with SMTP id af79cd13be357-8c08fc014ddmr5121073385a.44.1767191945964;
        Wed, 31 Dec 2025 06:39:05 -0800 (PST)
Received: from [127.0.0.1] ([64.236.133.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fe5sm2842199885a.26.2025.12.31.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 06:39:05 -0800 (PST)
Message-Id: <pull.2148.v2.git.git.1767191943962.gitgitgadget@gmail.com>
In-Reply-To: <pull.2148.git.git.1767098576384.gitgitgadget@gmail.com>
References: <pull.2148.git.git.1767098576384.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Dec 2025 14:39:03 +0000
Subject: [PATCH v2] fsmonitor: fix khash memory leak in do_handle_client
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The do_handle_client() function allocates a khash table to de-duplicate
pathnames when responding to client requests. However, kh_release_str()
was used instead of kh_destroy_str(). The release function only frees
internal arrays (flags, keys, vals) but not the struct itself, which is
allocated by kh_init_str() via xcalloc. This caused a 40-byte leak per
client request.

Fix by using kh_destroy_str() which properly frees both internal arrays
and the struct itself. Also move the cleanup to the cleanup section and
initialize shown to NULL so that kh_destroy_str() is safe to call on all
exit paths.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    fsmonitor: fix khash memory leak in do_handle_client
    
    The do_handle_client() function allocates a khash table to de-duplicate
    pathnames when responding to client requests. However, kh_release_str()
    was used instead of kh_destroy_str(). The release function only frees
    internal arrays (flags, keys, vals) but not the struct itself, which is
    allocated by kh_init_str() via xcalloc. This caused a 40-byte leak per
    client request.
    
    Fix by using kh_destroy_str() which properly frees both internal arrays
    and the struct itself. Also move the cleanup to the cleanup section and
    initialize shown to NULL so that kh_destroy_str() is safe to call on all
    exit paths.
    
    Changes since v1:
    
     * Removed incorrect claim about interrupted threads reaching cleanup
     * Simplified commit message to focus on the real bug (kh_release vs
       kh_destroy)
    
    Signed-off-by: Paul Tarjan github@paulisageek.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2148%2Fptarjan%2Fclaude%2Ffix-fsmonitor-hashmap-leak-gfDCU-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2148/ptarjan/claude/fix-fsmonitor-hashmap-leak-gfDCU-v2
Pull-Request: https://github.com/git/git/pull/2148

Range-diff vs v1:

 1:  18670d3230 ! 1:  0a754c7f09 fsmonitor: fix khash memory leak in do_handle_client
     @@ Commit message
          fsmonitor: fix khash memory leak in do_handle_client
      
          The do_handle_client() function allocates a khash table to de-duplicate
     -    pathnames when responding to client requests. Two issues existed:
     +    pathnames when responding to client requests. However, kh_release_str()
     +    was used instead of kh_destroy_str(). The release function only frees
     +    internal arrays (flags, keys, vals) but not the struct itself, which is
     +    allocated by kh_init_str() via xcalloc. This caused a 40-byte leak per
     +    client request.
      
     -    1. kh_release_str() was used instead of kh_destroy_str(). The release
     -       function only frees internal arrays (flags, keys, vals) but not the
     -       struct itself (allocated by kh_init_str via xcalloc). This caused a
     -       40-byte leak per request.
     +    Fix by using kh_destroy_str() which properly frees both internal arrays
     +    and the struct itself. Also move the cleanup to the cleanup section and
     +    initialize shown to NULL so that kh_destroy_str() is safe to call on all
     +    exit paths.
      
     -    2. The khash was freed mid-function rather than in the cleanup section,
     -       so if the worker thread was interrupted before reaching that point
     -       during daemon shutdown, the memory would leak.
     -
     -    Fix both issues by:
     -    - Initializing shown = NULL at declaration
     -    - Using kh_destroy_str() which handles NULL and frees both internal
     -      arrays and the struct itself
     -    - Moving the cleanup to the cleanup section so it runs on all exit paths
     -
     -    Signed-off-by: Claude <claude@anthropic.com>
     +    Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## builtin/fsmonitor--daemon.c ##
      @@ builtin/fsmonitor--daemon.c: static int do_handle_client(struct fsmonitor_daemon_state *state,


 builtin/fsmonitor--daemon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 242c594646..bc4571938c 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const struct fsmonitor_batch *batch;
 	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
-	kh_str_t *shown;
+	kh_str_t *shown = NULL;
 	int hash_ret;
 	int do_trivial = 0;
 	int do_flush = 0;
@@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 		total_response_len += payload.len;
 	}
 
-	kh_release_str(shown);
-
 	pthread_mutex_lock(&state->main_lock);
 
 	if (token_data->client_ref_count > 0)
@@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
 
 cleanup:
+	kh_destroy_str(shown);
 	strbuf_release(&response_token);
 	strbuf_release(&requested_token_id);
 	strbuf_release(&payload);

base-commit: 7c7698a654a7a0031f65b0ab0c1c4e438e95df60
-- 
gitgitgadget
