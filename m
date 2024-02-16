Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337C20B20
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078624; cv=none; b=HAT6WE4JXmUGzW9cvAywWwRb7QsZI5tqh16/HrX1bG0JbMj31yiGJYq928kfsE/BdB6dZqczk3HIOxEvfV6XlX7dZYtqBxB36tuEarihmY1ZGATmLk4uy4ewK+IYEwZgb1VstvneWW1kIbRAY1nD9nV6WLv79pf3gmpDC3ES8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078624; c=relaxed/simple;
	bh=Gi1FosAsJEcxF1pmHHk2YZe+k8ETwZNzE1aAjuh2lt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF6+89DSpR7lG0hjg9Aab5A/v9+9gIKfjTMktZBFvgo7LsAeTtxKWPsO65Y/IyDi3CN5tj53Y3X1VpgTwnxplueegfhuISArTkOQEtFaag/zaxqbyhfWiVNIMsDqAWPByw2nGkmbDQPI9Wvy4TcOHVVClTvF//WMBnR71dTinoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=TTDoM+na; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="TTDoM+na"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563ed3d221aso649272a12.0
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 02:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1708078620; x=1708683420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anQRNBqXCFoNsc62tBAQLgEqT1nO19xa5zgt7RB7ReQ=;
        b=TTDoM+na0RbSU4FfqekiIOEdH+UYSB7JOuBeglKYQW/5TAJLQGL1UNhM0Z5nhYHhFi
         LoLUCfxAf+6MhIv9oZ/pB0nK4cbrQy7ZLXxu8ea1Sfd+h3osohFZeJUAE6hv/S3O+SYW
         MJL2V+uKkjZ7pICEJMPwYKAK/NpDq3w6s4pmgbkglH/FhDHMAFp6Y1pcOTh1U30d7eP8
         1d0BqY3twaYMSIZVhYeKqIbP+EXLKMvRgKw4piM3ZNMrdJ7OAGHU+oyxlpNE6fs/UzsP
         RSp+skOS8p4HrianftAIM8AaXbM4QPrUByWQbJiUPC3R0vwIRorCZ0PN2xytlPI8hpnX
         D2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078620; x=1708683420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anQRNBqXCFoNsc62tBAQLgEqT1nO19xa5zgt7RB7ReQ=;
        b=mc/H3eaBE9z3ac3VgYISsjYHhPbozf2ufQMbwoIcmB6mgdwMopkZOJzjtWfOWDCVEQ
         SKIgIiqH9wiI32IsfQUMnCW8A62D84ht6FtPxxRvbf0ArnWhyGG9o/F8LqM39Atetn2o
         cqx9gF3KH4N4d2a7F4Rt0N04z5MwWATVNuMCyEmXTopv5emPu0QnLvrJlJNQgX4Se2Jz
         Fow/DL5T006PDaXuWTCxCivxnlTrgGFovZJzWxJ662eGuJUJhFWjGobvT0zA0jFc0pVi
         0aMyqGyyutfzJK6Mk+7y2yAEogsKbGxPKU8B681eD1Ono6xFE10tJmduf77O7rgRvuvl
         V/kw==
X-Gm-Message-State: AOJu0YxUklY8gIG8pgf8YB12Ajx7SJ0hzRx36PtvZ3SVGSbcUM0aLy0q
	MZWw2R/LWoTeXRn2KaBQvMVozvT5vY9GQukbITX/jNipfx+MJ6+C4kLUzimajBakfoz+WeBptgY
	hNrh6Lw==
X-Google-Smtp-Source: AGHT+IGIeqUR12uFM6UXZ+XnYSjIBnQyXh9AlKJyCKqQ2d8Q01uHuy+QVcRg7uQNGGT0PejGdISNyw==
X-Received: by 2002:a05:6402:4010:b0:55f:d7f8:1072 with SMTP id d16-20020a056402401000b0055fd7f81072mr7028104eda.3.1708078620000;
        Fri, 16 Feb 2024 02:17:00 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.192])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7d9d4000000b00561fbfebdb5sm1337682eds.96.2024.02.16.02.16.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Feb 2024 02:16:58 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	peff@peff.net
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [Improvements on messages 3/5] builtin/remote.c: trivial fix of error message
Date: Fri, 16 Feb 2024 11:15:35 +0100
Message-ID: <20240216101647.28837-4-ash@kambanaria.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216101647.28837-1-ash@kambanaria.org>
References: <20240216101647.28837-1-ash@kambanaria.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark --mirror as option rather than command

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 builtin/remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d91bbe728d..8412d12fa5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -150,7 +150,7 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 	else if (!strcmp(arg, "push"))
 		*mirror = MIRROR_PUSH;
 	else
-		return error(_("unknown mirror argument: %s"), arg);
+		return error(_("unknown --mirror argument: %s"), arg);
 	return 0;
 }

--
2.43.2
