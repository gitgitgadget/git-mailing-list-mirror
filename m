Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1DF23D7E3
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673386; cv=none; b=Zasouv8ZSpCPZa3GPsiPsKOauf6X0Ig+5DwtBoDwSWHh4/Hu0HpK97BnkYqTPa7tZHCdxS49eRPRSWsJ3XkXULSlUzGREZ7juhfM91IfUSddbJz/xnD2Pt8gbFspZtN8EsrnbQi0HDqC2oJXMEFc6Xdqhez0MgJQKOq47HO9Ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673386; c=relaxed/simple;
	bh=dgzktmB3UZefBssaL2ZSgY5M3yNRYA/erR3TfVJjNYM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TWZ4zpJZg8VzKz8Gp3XJVv3Ut3G8uo/OeUkBjELVXtJMcNelvPfAlUQYa6IPInJqnJ/hBGiSbEJNutnM+hH68YwKTPCDimEKO/iYcjQHe4ETKyM+1AymyqKBx6cpKO3z/g4bzSxl17h0dLMCUc+Yl3x1ObDIPTN8EM/rZOuQM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgLD5YP2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgLD5YP2"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3b3e643dso451374085a.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673384; x=1773278184; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=RgLD5YP2eKl0JW6C3fi88lK1NqRglRZ0lpRi+tbZlQvMNb/5h7RvluNLcpjO13BdaU
         kNx2nuFpixHPb1OEgS9S/xvS4U1SLzCxVuZoTeoQhXUrn+ikn5Fmt6XweeqjhtlbXOnM
         khz7acWM0HDTYjx0rEtbHJUBfIHQB2o19H2Yz2lR68tGCxhA0a8BXRovSPV3V/KIl04R
         uxw2GBpuJbzYNN4N73nJ1z3IQnehkC6oEFhbhcaM3123zq7wNKwodfHBEJvqhfLIpK99
         i3/1yiiDVqbpH11BefXiv5GrIGqPoRHkWVme9lXe7oN8+/j2nT6dV6OJMVhk0YOLsnfJ
         ivWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673384; x=1773278184;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=sAHhN5OTEOo2kP83vr4Js7bHN2Usxiii5WT543ex6onskS4n1wjOKKtIGptOLLJWCq
         y0obQdg6sbASkMQYTU07pxj6hUn+vUQ4YMnHv5JAQIcAMyYUtLLQ38+5CcFFwfrald7R
         ZXNBL2hOmtrXKp42Nuby4hQlOH6EZuBjkv96AymlEJqMsEX2P+mHL+xB1TpZpOBi+qGe
         ldZwDPBI84FM5nFHSmMAH8ZnmRtnjKhdlgAkm0h7l6eQlsMOethpKjFFHdmK9FD5kNmu
         Ma+2Bmy73gZghJVQU0qxgSVO3OQKhM8G7MZQoAS62nYRe50nRNEZQwxI9IrnMWLPJU2E
         FA6w==
X-Gm-Message-State: AOJu0Yzudb8ZFy66YxRLuMGRKOY1i4toyiC1at74ORDhuzQb8sDYU193
	/z86XrNFH1lteF64YFGSHb8BicJKkbh5m1HFLCBlZd6dduM97VkSnvZLYAbkYuKf
X-Gm-Gg: ATEYQzyLJfW6CIJmJ55AWxPykxqEjZGfGP3zZ24uMIx7sN88hwlUY4kiZfKspGFQb5Q
	19YJPnqEmy9gzqmGXNnDB6vY2fQ8o7xE0Dqkt9Yuab4Ex3lM1qpTfHGBMerMAyanBohGerSHkd4
	ebBR37qaktBATbFbS6lNyGUfjluHRW0vn2yQsHY6s0Trl0wLTG/Ii80qf7ZrzjrSXeeJ4VyiQxt
	sq1YkYF2sO3Ffq/Ij2JSiseVc4pAlcFHo3iwgnQ7N4+27zCx9WMJIjoJS4FKYmwsvOk2H83jftG
	NgoUTbtI5H1os6P7xvbKstphwARfbJXgMPiMJpJGxLjDXU1DsUwGLXIJw2m6TdmV0UwPL23ZaoU
	oISdJb8ZYQ/7a19eQYC3kJENWAedlJXsPWB1q887/nDuB10iE4Njzw/WXg37+uAmVyohelQOAt7
	Ye0WqK0DcZZGzMBxUO1wQzgLo=
X-Received: by 2002:a05:620a:290d:b0:8c5:38c3:7cca with SMTP id af79cd13be357-8cd5af0dd89mr514490485a.31.1772673384234;
        Wed, 04 Mar 2026 17:16:24 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf68a0fbsm1718215785a.22.2026.03.04.17.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:23 -0800 (PST)
Message-Id: <cb270120f0e27a34a58c856b7c80e78e2301c989.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:08 +0000
Subject: [PATCH v10 02/12] fsmonitor: fix hashmap memory leak in
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

