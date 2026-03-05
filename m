Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0471E531
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671928; cv=none; b=KbC/+EIYUKXj+QV2jjP42MMZKkpMm1Sy2AHfR5xLYO4CslIvfZK6MptskbNkEG5gx1zAJNHZ3ghis4s+r5WiKxkQxVU8Lemsx1ALBa68b1TGtX5YNtJHuafsxbTE8/fpCwAPCTx8r3QrgFGcgc3rq/Ql9WiSPoctJOddb/WFupc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671928; c=relaxed/simple;
	bh=dgzktmB3UZefBssaL2ZSgY5M3yNRYA/erR3TfVJjNYM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B20Y87FKKKydAXi6LU8xfHFpxcgAz9071MU6nbIoM58z9fyE7ihYggavnfPFi/53UOSqZw/5bkD4zd0rjAwCqgZi4sblkwi/QvEk0XxUUOkoEHoJbKLapI+30a6mBcpC2VHPE8m1qZOWIUsofuC3Z0wmD/lDqaT0TvT65fnlpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcdL/UiW; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcdL/UiW"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124a635476fso8808818c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671926; x=1773276726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=OcdL/UiWRWyZUpmKmjPtkYz8uqdRLWPgxWVDIbZ3r7cqmLee0hQIziT/Ewai/3WWqk
         KhHqrEhR0v+pVJv863HX+bX7LcnveSHcrjuYWQhzz7uGsKEjpd8ADKI815ay2hfDls8o
         ApAF2VNo0Jb1YEODa6U/2GR+bdo6rHhB46vQ93Y2WiQVoeUOqCSQNihHOjb7WC4/KcZL
         gq0Kf+P4jkMqyobHx1ZtmH/UJYMsf8MNQt+modRVhQhcHJop5cVkYARVZQvg/1WwSHrK
         urlHoDG0eVApYMVfIv1j2s6T1GMHIrn/f1ENnufKCFUJmRrF5w8C1alxT/nmrmPrTDxp
         JWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671926; x=1773276726;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=ZN+0Rq4wpD0AYGGDnh9Jd2v/Sgv+Pvv+l7BfD5odHW7rbnsmSYawR+N5S3hp08/dJX
         oIdLynHeOvTakerGviD9HPeKh6uaeB4HPON7tDsdrulkJ+AijRHIswNN3PUEWPL68o0H
         bgonHASTUTILtZ/EL1OHNWbbqVHe82EOJKYCV5ZjcbuOwCmnMYFg3EN38X7WyqxnUdJt
         eJ09JLmvImuAaczPntZI4XS30+Zp6f/7E4JeIiNHYnjBkQd6gOghj4DeYgQiOz8+URoq
         3NXfyVOvGTyn+lIkoH8ebewPKj1LTLNCueAK/bybw4oqWk3IS8h+JmvOcEiS37yKyyqa
         GbRg==
X-Gm-Message-State: AOJu0YwRRYyQO37NQ7VuIEbNrGooaSsmCbcjUp+OtNGgPrhjg+x/FSew
	Ozajo/IErAr1GNSHSwulcCWvrb24fT+3XJ6eCNR0Mg0L29fzM7PyzvR2Jl/HBQ==
X-Gm-Gg: ATEYQzx8z0kNQUezBHr7ccKPO2eAbqzd+HVtDfqxKZRseAvlCaGkrsp6zB6+Thge3P9
	BmJMXWnrexeQIIxWjKYBguisyXCUqk7mx87I90T1lJrTk0yg5+KU6zcm57cM8cDB8m/BFz7/k4h
	YjWiVR7gMowKI9tY2fz+jbsbqZywW4hIUqGTdZ3HBkKGBPASzKmtWBfJLkyI4Wty0iGzM2Rv4kg
	1BxHH/RqCYLVkuZoXqDoAxlj4QiCpf65SttAz8wXACVQjCD7bEHwRv1fDHaL8vNDIbiXurYNV+Z
	hfrzah0m/d2kN7VgluyxalVlJAQ7rhL6l+wuUAwFQHAFFiK5Q6TtK/4AYfl9FBwnDo9JX5qT0lU
	2vFfLgzAzYvfO8rtfK/aZsHwoKOoUyzawFPUt7RVQNfJJFySJXeJUz7OppWiUPQpVMUIYR/O6OC
	XzLUlq0+xLTAlgN9Oqu4Fg+mzh
X-Received: by 2002:a05:7022:6609:b0:119:e55a:9be7 with SMTP id a92af1059eb24-128b7075a70mr1485199c88.3.1772671925600;
        Wed, 04 Mar 2026 16:52:05 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49ccsm23565764c88.3.2026.03.04.16.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:05 -0800 (PST)
Message-Id: <cb270120f0e27a34a58c856b7c80e78e2301c989.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:50 +0000
Subject: [PATCH v9 02/12] fsmonitor: fix hashmap memory leak in
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

