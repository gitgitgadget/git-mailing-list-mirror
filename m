Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6517CA17
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696430; cv=none; b=CkE9o/W/SgVs/t4XoTAl/FDTnz28nsaJH2WX2NgvcVwxjJgAH1765DslGuPJsBzNnhXIlMU1KWVY0k9Xo92vhu5PyFZTXpwkuL2AX5TvDf1GHqco0Plf77sSHL5CfVLzYmzOTZNXkwID89uQoLdPznUCu5OgAEBBABbLit4UfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696430; c=relaxed/simple;
	bh=PvbzChAfKoNkViQ2Oi/UOVQzYJsVikCSGxnAwQ3QuQc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wczszi6Iez/R1FtgpHTQG5Vnq5VVDTEFfa4lPDnk9TkPmWHYAgGquE7O5lDtJDsgPV3uS3Ciu1BgOeH7bSd2yMTokJJ6tO9TtM6lgOIogI2zm5DKvEZ3VdgEHBL+AnJu8Hc0HOkpOLvJzIW5cy+e008nJN8WyqBk89I/d5Pa/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laaii9Gy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laaii9Gy"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c88b5c375fso2662030a12.3
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727696427; x=1728301227; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwkQyLqjizi1/AoAUsCTjcz5PmfwhrQ+1B0dyZMZV7Q=;
        b=laaii9GyIWXC6UTWGBN0uH1QwfqfXUUSA4plMEGszDFXPYKluBlLANAdCyTJCTbAnh
         y6VJ6RMszHCP7fy8JLe3XtbZigFw/vUfswBdpEiOEF03opmdh1PW5JUuQAZyM1dBCgOK
         /lGBE+DCI2YMzYVCirONI08Uoq6v1xsKl7IYPq9Ex3O6xB/cDw559c0s2kjEniZC7KL5
         kSVWHqnuMO9WWL2haQebsZQ+a2xyOC7nTJoox58JpgXz+p6GlDhW8s4WmfyaFB5MHG4x
         2urBRzZFBZutzqRzIAeb5mY6KJfUb6RngH0iR9pxmptrhChAfNjg6EBCmLLiI0aZoCoY
         qVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727696427; x=1728301227;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwkQyLqjizi1/AoAUsCTjcz5PmfwhrQ+1B0dyZMZV7Q=;
        b=SyXYDEzXGfjGb8WKO+qsatkwMwts11iSmDMPWI7ZMdxas9vDHrDOo13nPxHaFGGOEF
         rvZJrRnQRtya8o0Wwu1O3avN3VMK2wbXwWW/laBcWy/F5ZAav3Sfki1NsB7QIEFd8LII
         Hdgawn3BNnJgCHbw9qyPPhzB3jSM9JpAquVLM+wHcGvpEe7pqloX2Yjd2mFyzUSZ0zyI
         q05O1xJ9OEBwys8HYTgTX6Oa1hWokO7thzL6SWHh/heDe4Bqu/FPTs6yQD82uq1TGUTj
         DtxoUy8fVJwI27VKPsht0ONzn2/Ozf0WGq5Hq9CMg/Hor1V3Yr1idOEuEPZTwAZ3Ml0z
         xrlw==
X-Gm-Message-State: AOJu0YxjJrgkXiMGLGpMWealhRDeD7+OndrXnJbMzBAQmUNlPQmBORpn
	KaIVpd02Uut6YJTTpkXxSrpeScE3Kpmp31hitxUJFhQtXI7isnATWdNlew==
X-Google-Smtp-Source: AGHT+IH0rR9afm+vlRoEfgOlA9Dm58WzRHEq6b4Wd8k3XEfRmc0LS3htTqDItq1jqAPbguW1weJnQg==
X-Received: by 2002:a05:6402:42d6:b0:5c5:b84a:8156 with SMTP id 4fb4d7f45d1cf-5c8824e7174mr11516507a12.17.1727696426539;
        Mon, 30 Sep 2024 04:40:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240a4b9sm4349001a12.23.2024.09.30.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:40:26 -0700 (PDT)
Message-Id: <9a45b15ea4b9864cd3cff066ecd9281c4539d5f7.1727696424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 11:40:23 +0000
Subject: [PATCH 1/2] read-cache: free threaded memory pool
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
Cc: gitster@pobox.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In load_cache_entries_threaded(), each thread is allocated its own
memory pool. This pool needs to be cleaned up while closing the threads
down, or it will be leaked.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 read-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/read-cache.c b/read-cache.c
index 764fdfec465..3c078afadbc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2188,6 +2188,7 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 		if (err)
 			die(_("unable to join load_cache_entries thread: %s"), strerror(err));
 		mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
+		free(p->ce_mem_pool);
 		consumed += p->consumed;
 	}
 
-- 
gitgitgadget

