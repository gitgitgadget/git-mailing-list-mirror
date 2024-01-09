Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9E39FDC
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrXFmt9p"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e52ebd640so3683885e9.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 07:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704814176; x=1705418976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bikIPW2eO+xFrllwHwwMWp1LGn+Cp38w2f7xVcpjesg=;
        b=TrXFmt9pfMOIbFFh//Gdf5sHKz2li9ntEjFzsCyp/PJXWkML7QNV7kNmjrqPL8e83F
         yHn4eieNlwHgjA4sK0ryDOdDUzEzqL0f4DKOLPj3GnoRl3NbTW1TIDqXH55Cgdna8VZY
         /vYXj4G+j7XOOb0ZnhqqDSk3k5u5mcQ5CfolxLGVUuGtVr9GCctxckK+xbyuPVt4UqVB
         3/yCM8myR5w5cVGQ9gQ2UqR2umINyg3iDn2FQq+1iLeDImuRsgRMoW/ARPKUrSXXJahN
         72EhW7uJdwUoNLjGtR05DOFDi579pNKX9jRdFpZksQsPj1QBnUc7MA/+40Y2CKZjheww
         OutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704814176; x=1705418976;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bikIPW2eO+xFrllwHwwMWp1LGn+Cp38w2f7xVcpjesg=;
        b=qBu+ktZ+0c+KW5oZZqT09KFY89icismEp2WzGJzB6GI7oD3vGbs8TGsZCImzSx7IR3
         PMdg7AbDffyrhBVu2Q8WVIRM0BDjctdpwyuSIlGXeHox/k/VVOMM0dP9eWdE8Uj/1w2M
         q2TvM64UiploYslo71rZZIGI0yShkqEOWY2UlOdjsidxQdAaurUioWyQV2mGKx3lEPLW
         V8vSGPz/1am6T6hQjiblLxfZTVQAxT3Dfvru4l+AtUCsQ2oP4VS7tGB3p4zF3k4Suj4q
         vy71UUcjiLkaZZnoaEX+Uq6j+JI6nsgiuHEfkOWbCEo4Ta8v8eWIG61llu9OFg+QPGdL
         Zrew==
X-Gm-Message-State: AOJu0Yx1jFG40/pLlTObRIAS/ezzraDw8ojg1cObJwHgWo5pNeEGQO2p
	FdHliS4rLAunJJpZCMhZVsHwsr/MZt4=
X-Google-Smtp-Source: AGHT+IHgBfO3Eer/wgjcw3Hm94tKShUe+ULe5yz0WBarbOhd3S0N7Gue+mpmd2i7aK3r+CcWymOHSg==
X-Received: by 2002:a05:600c:1d24:b0:40d:5c0d:1e3f with SMTP id l36-20020a05600c1d2400b0040d5c0d1e3fmr2999885wms.84.1704814176571;
        Tue, 09 Jan 2024 07:29:36 -0800 (PST)
Received: from gmail.com (228.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.228])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b0040e47dc2e8fsm4025906wmq.6.2024.01.09.07.29.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 07:29:36 -0800 (PST)
Message-ID: <ec57072d-0069-4d07-a695-b89436350568@gmail.com>
Date: Tue, 9 Jan 2024 16:29:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] t/test-tool: usage description
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
In-Reply-To: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Even though this is an internal tool, let's keep the usage description
correct and well organized.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/helper/test-tool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 37ba996539..d9f57c20db 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -5,7 +5,7 @@
 #include "parse-options.h"
 
 static const char * const test_tool_usage[] = {
-	"test-tool [-C <directory>] <command [<arguments>...]]",
+	"test-tool [-C <directory>] <command> [<arguments>...]]",
 	NULL
 };
 
@@ -100,7 +100,7 @@ static NORETURN void die_usage(void)
 {
 	size_t i;
 
-	fprintf(stderr, "usage: test-tool <toolname> [args]\n");
+	fprintf(stderr, "usage: %s\n", test_tool_usage[0]);
 	for (i = 0; i < ARRAY_SIZE(cmds); i++)
 		fprintf(stderr, "  %s\n", cmds[i].name);
 	exit(128);
-- 
2.42.0

