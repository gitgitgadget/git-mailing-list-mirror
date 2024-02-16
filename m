Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAA208D1
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078621; cv=none; b=gjc7BOaib56cpmxySNCsGliVbxQwiRuwPZHlXQdS5SWdyrHr+8m505P4pty3oL85ld01kFI3ENymjAYoKKUa20hJP302bbGYVhsO0Q3UL99PDMZy/DeWdaOv7U91/1JooFJv8hXDy2KRJv/5lDeRWHCj0dGc4zedmex0+QdmVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078621; c=relaxed/simple;
	bh=49NErM7FM2No/QXlAzbVpP/n2EYeE+xwb4B60gmPXFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOjYIWuX2Je+fqwax01kfbr1LIjFBdC/cpXe+X7xvzIBiKHfOWqBu/aalceVTbn3/gAxdk1CzlHqTeRsAJa+TnzM0A4GuNFCyJZivnD2YWZTm0oQjXzj1AXbJqQuIsAG2Oolg9AuHbNydODfHWs3iSR53RaIRE/hWrQGGLxoYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=ZvNMbcKD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="ZvNMbcKD"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56399fb02b3so2356771a12.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 02:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1708078617; x=1708683417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFHsl2QkFi9b9DL99IHG6fDSMBCGbP9OeHJTYCMMjeA=;
        b=ZvNMbcKDYCrFaEIb/LWG9Y02spvtDM6uKKqyf0c/X98mKA86s7ET5s5aI4TGtA99Cc
         IRZPw/M+Z5VzDbFY+QFmQd83GgBJdxEPQ1ZccTMDS65SUIpgPfVFMKHbGB++Vc3Qxn2B
         cWQw423Cbmt3POgbNL8X5O1yAs5uk8b8B0scqzNHmLRu0IT0SmB66QFOK32lQY9jFSR0
         MszzPZJrdsWFefA1p6e/i/A6SNHYbgTQ5iYUhF4guJXVNWvi+I5b8OcILWbkPgJnSoR3
         tFPt+1rVKW7R0Ei793Xm98sRkOAPJK7HnTdYFvHB4GyBuQigWWbhFx4aLv9wEvASqnGq
         1LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078617; x=1708683417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFHsl2QkFi9b9DL99IHG6fDSMBCGbP9OeHJTYCMMjeA=;
        b=olNMKOsItqxqd7rTCYpxWrtKpw8KAILE5bajUsCT+z6sd69TOahJyBS5hrvoF6U5k1
         BNPgE9IxqYxIZjpo1yS1r1qpAWMSoGm9jbWe7p/iIsO3as1JME8melwph+kTMaojjLi7
         GYo/GZZVOzXKpw5/qO1KZjvCaDtxt9vyYj/o+ilZ2SiUYuo9wL8EWmP0xkE53pjVrEiP
         oFaOAKgT2QUDx6HHm5xMOs75Xq4WchzkpEHbSa3eOo+VcVVBzMTHLliiw56u7/GlryXk
         zZO90doeMAYZc4j10knwUCr53Ld/IC3FwQ728Q6S1z33DFpKphr5lxNwwQV/IltSpAZV
         1vzg==
X-Gm-Message-State: AOJu0Yx8oU+qigMeMiDnrtfSmaXN2LsvnKzoXHGFBV5/zktSLOe+gHoL
	w1fqcIvPt+7y8Ys9fReHWq1zUb6SM0eNs2eRtx/AdxG+/wD99/nGJcJmGwhx/YtyNG9zdd3oOSp
	z1GPoDQ==
X-Google-Smtp-Source: AGHT+IG5gkpEcdQUUsGLJ4rB4Sq28QVPTLJmnyFIh9AtRFQeasvVC4fZHGL+g4wgqeSB4nTAgDynpw==
X-Received: by 2002:aa7:c90b:0:b0:561:d6b1:e25 with SMTP id b11-20020aa7c90b000000b00561d6b10e25mr3287540edt.14.1708078616787;
        Fri, 16 Feb 2024 02:16:56 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.192])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7d9d4000000b00561fbfebdb5sm1337682eds.96.2024.02.16.02.16.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Feb 2024 02:16:56 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	alexhenrie24@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [Improvements on messages 1/5] rebase: trivial fix of error message
Date: Fri, 16 Feb 2024 11:15:33 +0100
Message-ID: <20240216101647.28837-2-ash@kambanaria.org>
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

Mark --rebase-merges as option rather than variable name

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4084a6abb8..9c6d971515 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -746,7 +746,7 @@ static void parse_rebase_merges_value(struct rebase_options *options, const char
 	else if (!strcmp("rebase-cousins", value))
 		options->rebase_cousins = 1;
 	else
-		die(_("Unknown rebase-merges mode: %s"), value);
+		die(_("Unknown --rebase-merges mode: %s"), value);
 }

 static int rebase_config(const char *var, const char *value,
--
2.43.2
