Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9A27FD49
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937969; cv=none; b=qlr0hejT3ltDQpJwrhb6YLCMJ/y2Amd1liIYVGoDOgLP2WXBS/n9sEkZLeJK/AE3eqGhkSvcd4FwYv0+XE8JRn4LFlYSyEVQKFP4/blbarcjABTNsotyHq+50xyb/CPJFNyJol9gV2JDxlONtI14ElJoTBnGGTzdSAMBfUPWZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937969; c=relaxed/simple;
	bh=dgzktmB3UZefBssaL2ZSgY5M3yNRYA/erR3TfVJjNYM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EZiibVdGMtwXcPVqlAvL9G6QFsDkwnxHqopQtUstZ3gNS4UXJ53ZeGxGGU4Wh/Ae1sP7MoohtJMRp1wmu/wTH0K4Hc2qgbb7vamdkh/SuwwVMZuppty2Fj3oCQivH8DBirInt9OMKaymlIQRooQL+khXZSUS11p1H41h7J0gGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0NQKntT; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0NQKntT"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-67baf20e8c2so2257414eaf.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937967; x=1775542767; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=a0NQKntTCYNSdV9V7JHDCp+PEQWMTZ146WmjEvHJqAomC2p5znN/DdUF/wQK523Flv
         fGK48eqfDaF/NTEQahWjW9zabFRYeaDLZ3/PRHnNkpf2tpFfwsVfF9QNM3eHkr9XA5qh
         gbxLG2a/ROrpdblGHtfWHYKwqWo6BbAR4RwTnCtX82Ca1pcKGyhUl+vgBl/0xc+kXKqJ
         bID4NCBR7JFpyfmofagrk/tMtXrTqgM18CvO/hPdvbM68HL2BuRoDBUQ8IZDOH3YNlp4
         tp1vHGMHe+zej5MtCQ0x0jecITjjagQw4OHHiIawr1d1+6BPiKgTsUpB/Hrb1laFamiA
         DUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937967; x=1775542767;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=d7NeuU5IAn7TQHecMmX/MaNpJp4bmHIsLYX23cLQ+xlJH6j3QwMG95v12CfoaUu1yz
         Ejwsh2q5d8jxGGFeNGDYf7Ff0OhkUOSIzyfezZaqEISFyvMt2edA4j1CeAsb7MunCGnc
         C9dzLME76pK1R/PlMprehBmwRomJxUpfkYsXQ9NqNjVhjaScRKQ887hMEirJzh7mGNAc
         F+Ff+IXxTJXNaWItYlOB9ZYbnips9SDcNT1Kazvy4xkdeeJZrxhxZp7smCdKzXd3o4rw
         sFvm2+ZFGQ0Vy6fqTMKWTJAmvw0RVhMLMIogIkV2Bm7Hz93mNLuT5UsnDikGvcZKFUq2
         u3/w==
X-Gm-Message-State: AOJu0Yy1bDp4v/6wkbtoqioKqLtyw95WXVf9qYB7RoyqKWSPZt+aodGc
	j2hh9DAy4U8e78AENkaBPD/bttM0jYrlPsbaHrbmvCMXjg+yJIs8c80H9xVJD+xF
X-Gm-Gg: ATEYQzx9zRPWiYqgPui/z++kzLDvqMF1a0O6MzO6CfIrVURz9Itxng1qVPvEiUzLj1G
	l5gLvjDmGFTzrkHrZFoY+j6VQqQC2kzTPQCH7OJ+6jMjz8HhW8ZZut+297+M/nWhIJETQzgWaKI
	Y1cU7Le/ulMxpt+IouGeyD8mxodwNfYoZrwoQnUvcRwhhp5sXIho2R7dJpEdn4vJYaK6qq87m1h
	laVzWuLhIk2mU5h3yh40fqqXCqomJv+r98t0+GBs4lCftfCO89bbQrKHWFW8st/9TYl8WBLPOvN
	5DQRoMXgoQ68Hg4kcDbnS8YHC9B2L3fCFEq6ZI+Fpag5bFZMFqoNd0YCdhBkGlldWe/5gzLRV6W
	O5CBACslKJ5Od22V5qhbzlQvGMh5Dr2NjklRliww1NRlkZzdZvakoYezA1x4UaoM2Xr7ZiWeHrA
	C2C6zoDnymtVvfDQoTsU5dY5Cutt1o61gF7r/QIQ==
X-Received: by 2002:a05:6820:16a2:b0:67b:b847:f0fa with SMTP id 006d021491bc7-67e18639953mr8658131eaf.17.1774937966672;
        Mon, 30 Mar 2026 23:19:26 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e231ad680sm6075740eaf.10.2026.03.30.23.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:25 -0700 (PDT)
Message-Id: <cb270120f0e27a34a58c856b7c80e78e2301c989.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:07 +0000
Subject: [PATCH v12 02/13] fsmonitor: fix hashmap memory leak in
 fsmonitor_run_daemon
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `state.cookies` hashmap is initialized during daemon startup but
never freed during cleanup in the `done:` label of
fsmonitor_run_daemon().  The cookie entries also have names allocated
via strbuf_detach() that must be freed individually.

Iterate the hashmap to free each cookie name, then call
hashmap_clear_and_free() to release the entries and table.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index bc4571938c..d8d32b01ef 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1404,6 +1404,15 @@ static int fsmonitor_run_daemon(void)
 done:
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
+	{
+		struct hashmap_iter iter;
+		struct fsmonitor_cookie_item *cookie;
+
+		hashmap_for_each_entry(&state.cookies, &iter, cookie, entry)
+			free(cookie->name);
+		hashmap_clear_and_free(&state.cookies,
+				       struct fsmonitor_cookie_item, entry);
+	}
 	fsm_listen__dtor(&state);
 	fsm_health__dtor(&state);
 
-- 
gitgitgadget

