Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE2341069
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074302; cv=none; b=m0H+ujTdSiveTaoUkQg72Al3isOHScKVPpQWUZhTzjL0H9Bewx7dMy65OfX8eoRaK0oZlet5PXkcw2fG+ZlrO0CuasnfWcX+ntndUP+NRFDU+mV/EoOv/mawCF2gZzzPYf1kB79RUzPdsmRLdihuBPvP2jjoIUt51BOqAZgEhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074302; c=relaxed/simple;
	bh=8ZD/MvZTIe/+HxY0sMqiJ4HdvZV57lWWbKE9VAIjS1E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LgEZLRUhxScUIP3o41MX3tPDhaL/FMjIhz2dS+ZQR22lj6o3NsVmQc45TJxZIAuAOfa+kuih5Ss4iCDSyiL7/zM/AYegz4rMylgUNWyyD1FrEBWHFzv1RUX6UHkBsWgBt6jS3THLMsLZ1lLcwIPIeqOatEFChDYZS+fbPfYODGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Btd7zKGg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Btd7zKGg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0bae9aca3so11223765ad.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766074300; x=1766679100; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opMqWUzCzcmY0JAjvQN7XbZP23skMXeEh5kW2kMET7E=;
        b=Btd7zKGgiOc4+k3HFwYms8z1rulC8J0c1WttkXCnP/tuCy+zyTB6I/L/6fSCs2zprA
         Kx5ob3VND2CQrSjl1mItk3HD2eb5cYN2wYFZScoazWIT7Iv34mpNzH/3EKYmRaqxnChF
         3FQd+kOmTYveuh2DRwUFaSVHX/51wHr6mD3JGMFv8eJnstNsBS9KRCeOIklGUHs2OHz+
         705i/pGKD3haCoODX7MHv7goKk003/1wqndog5LZyyiA2t/XruX5a1a51JUWMn5DvRhJ
         K0woJTQyTG/3m/4BkWDsEZoMrbo1pDR8/epFH/3bM85MsAX+MeQqv/XvB/8Aphg7Fw4a
         MY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766074300; x=1766679100;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opMqWUzCzcmY0JAjvQN7XbZP23skMXeEh5kW2kMET7E=;
        b=g6b7m0J2E6Cle9HIwXeaLsenYsQmXQ9V73q1OVOoXWVWnF1cbf+YjuX/2w+Ct334zE
         Lkf8RPj1sqBFnT3mW4s3KrysI1PX/YO5PHVppGVP7Syqg23j89ccDmBuQmoBd9pz2cRr
         AiqSelGY+NIbsTS8r75rHS/oYw1Z2el1SLNbpC1M3KLyjI1oJivaCFkFMiRVupGC+mJQ
         wh+L96oqnXun6QbKz0VEUIvWtHdF3dYg0UVzTvhPZJyDGCSsa6wIqaWBUFSCJlR10BRh
         hrgEPoFgDwZRGt6CGjEMT7WHTWAHLP/nbttmUm3pwxV6Y8I48+EePRNu5TvP6GGB7/c4
         tENQ==
X-Gm-Message-State: AOJu0Yw034isqlHbW+hHcywEQy3NrsOAuyysKbNv4ZqkHjgdj9ORm1nQ
	hk3bw91VF86uVl3GZn647H8Wkpogs3ysYuZvhJYDGHozVkSlAmHrovrPritzCA==
X-Gm-Gg: AY/fxX6vM8HdKGgyBqzHjn4EB/QUlyYirQPx3JbILYyMNaonYNWx493fEQxNjo+pn0S
	QJ1sVAPHgD/hTu566dasSVCD3r2tt1SaspbJ2j/0GeEiUu57TjlFvCGgg76wQBC122oud5B08/r
	aYK+5yRGfX1sNqyvR9eK5VribfVMcNRf8rrFAenWgaoD7W6R2vT/C8EWI5tfFBkMMZzzC18F0kS
	6L13EE8lOP9EA5M+PxV9Uqn7Q8o8SFmIO/Q6iN8y//aBDs+/+tNBl3j6y8ysrKm3a9oRtWJlBJ1
	ixqS59CkMWpotqHj8zPiMfe/9qt5J/iFgR/6ZLyVw0XjUo0Fz4FaJVcSFPplOEcBn3EoaNaEAQS
	SfFY00zuc1c+Noasia+BcPDQtcX5b1cLOi1DTlpnn0E2T+83b3pdaxCW65yiPevHS+SeaMBIRkQ
	QVwF8jLzjmEm48x3xcFdKVzt6S
X-Google-Smtp-Source: AGHT+IEkF18oX4mFnNpTQRPhzdldozSsa5TJYwBnjH2qvBnALITiqbSkHUvg2fQ6nzvhqDVembU2Cw==
X-Received: by 2002:a05:7022:1715:b0:11b:4351:2687 with SMTP id a92af1059eb24-11f354867f4mr12410759c88.17.1766074299390;
        Thu, 18 Dec 2025 08:11:39 -0800 (PST)
Received: from [127.0.0.1] ([172.182.226.67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061fc5534sm9430796c88.9.2025.12.18.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:11:38 -0800 (PST)
Message-Id: <pull.2129.v2.git.git.1766074298164.gitgitgadget@gmail.com>
In-Reply-To: <pull.2129.git.git.1766025658413.gitgitgadget@gmail.com>
References: <pull.2129.git.git.1766025658413.gitgitgadget@gmail.com>
From: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 16:11:38 +0000
Subject: [PATCH v2] fsm-listen-darwin: free corefoundation paths
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
Cc: AZero13 <gfunni234@gmail.com>,
    Greg Funni <gfunni234@gmail.com>

From: Greg Funni <gfunni234@gmail.com>

They are not freed even though they should be.

Signed-off-by: Greg Funni <gfunni234@gmail.com>
---
    fsm-listen-darwin: free corefoundation paths
    
    They are not freed even though they should be.
    
    Signed-off-by: Greg Funni gfunni234@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2129%2FAZero13%2Ffixs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2129/AZero13/fixs-v2
Pull-Request: https://github.com/git/git/pull/2129

Range-diff vs v1:

 1:  164c091f1c ! 1:  90d8f11554 fsm-listen-darwin: free corefoundation paths
     @@
       ## Metadata ##
     -Author: AZero13 <gfunni234@gmail.com>
     +Author: Greg Funni <gfunni234@gmail.com>
      
       ## Commit message ##
          fsm-listen-darwin: free corefoundation paths


 compat/fsmonitor/fsm-darwin-gcc.h    |  2 ++
 compat/fsmonitor/fsm-listen-darwin.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/compat/fsmonitor/fsm-darwin-gcc.h
index 3496e29b3a..8b4bc3a5bc 100644
--- a/compat/fsmonitor/fsm-darwin-gcc.h
+++ b/compat/fsmonitor/fsm-darwin-gcc.h
@@ -40,6 +40,7 @@ typedef const FSEventStreamRef ConstFSEventStreamRef;
 typedef unsigned int CFStringEncoding;
 #define kCFStringEncodingUTF8 0x08000100
 
+typedef const void *CFTypeRef;
 typedef const struct __CFString *CFStringRef;
 typedef const struct __CFArray *CFArrayRef;
 typedef const struct __CFRunLoop *CFRunLoopRef;
@@ -76,6 +77,7 @@ CFStringRef CFStringCreateWithCString(void *allocator, const char *string,
 				      CFStringEncoding encoding);
 CFArrayRef CFArrayCreate(void *allocator, const void **items, long long count,
 			 void *callbacks);
+void CFRelease(CFTypeRef cf);
 void CFRunLoopRun(void);
 void CFRunLoopStop(CFRunLoopRef run_loop);
 CFRunLoopRef CFRunLoopGetCurrent(void);
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 43c3a915a0..149c310433 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -455,6 +455,13 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 failed:
 	error(_("Unable to create FSEventStream."));
 
+	if (data->cfar_paths_to_watch)
+		CFRelease(data->cfar_paths_to_watch);
+	if (data->cfsr_gitdir_path)
+		CFRelease(data->cfsr_gitdir_path);
+	if (data->cfsr_worktree_path)
+		CFRelease(data->cfsr_worktree_path);
+
 	FREE_AND_NULL(state->listen_data);
 	return -1;
 }
@@ -476,6 +483,13 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 		FSEventStreamRelease(data->stream);
 	}
 
+	if (data->cfar_paths_to_watch)
+		CFRelease(data->cfar_paths_to_watch);
+	if (data->cfsr_gitdir_path)
+		CFRelease(data->cfsr_gitdir_path);
+	if (data->cfsr_worktree_path)
+		CFRelease(data->cfsr_worktree_path);
+
 	if (data->dq)
 		dispatch_release(data->dq);
 	pthread_cond_destroy(&data->dq_finished);

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
