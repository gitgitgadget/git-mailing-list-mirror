Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DD18EFF1
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241214; cv=none; b=TEie7y4kDxJ+JqeGkD0FAsmz85Eia59Zcoi/J9FB1C1agddBxKJUdp2JYitrfQJ3wYIdUMj8mFi0iLDnimaSSAUSUJAEWNWbdxIoizVWzSr1PUxc2HgaMGpftlfQKnvdfzKPCRgO/ZURPJ89q7R/9eobuslPmOksF71bys8NHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241214; c=relaxed/simple;
	bh=4ERN6am89GHqeH3BGLKrFT2DEc/4Rxylkn6UoUHVhq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OC3oTZy1Wg9obRMCR+JeW5U8nXBvcA7rb8r3oJnYxXZLYlk/otpNtI1YvEt98D4OLlKkeOoGKtiFIKiMHzwf8pf4u1nlPnGEVxTVJt0mWbMeBBwhbcmWiksVpP3CL2r5E51Sd0+BbW8iVUvvSqfzYlLUdS/4P8ZcewbgLHxnN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhtVox0/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhtVox0/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99eb8b607aso184373666b.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729241211; x=1729846011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05LnHSMb4yPosXhgCOaJwaQlNlEH8PQfessTE4QU/9c=;
        b=JhtVox0/tV8Ua1WGTIcJgwW1q8WdxsDtEAbyjJ04DLiMic7E/n102C30RUfcOanohw
         T8K48zRGSZUZws2+swWavpSZ88D9PrXH4l9yYymAuN1y4UwfsoIwlvXP56M906dLdz2w
         IrmtLZVvBGxvrE6BepyJed3exEkiXMXUOqUrL4xeWx2rd9pKl+N09dt2oNWollDs6mHD
         dSjkiRg3xAstTH8qxDrqBrzrgsJovoF7qKRInloJ9tPC3VtEnlUs5Q66ob4ob4WxeDZv
         LoofMntoT3IHUjguKNz1weDTtOslecoOkjgdEzirsggOyQ5jpMq++iQZbVbUu+lEuc4Z
         yX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729241211; x=1729846011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05LnHSMb4yPosXhgCOaJwaQlNlEH8PQfessTE4QU/9c=;
        b=tXsSYK4z1ScP2F09ouSqfG4fy3spD1ZdsTARu8tTHu+9zUKszaz1xF6N1PL4nmYapr
         wgS35FcdOdkv3aVeQ0DU+wLidQ4wTvKfiaRKT4T5t8p8xGUbt0dak7FhzLOiEs2ett5W
         Zh4Wo2YUgRXO29KdfXM/gEBJGtOHlOJzAB1W3PEjlqwTE3CFbrSbRubfYG2YldJRRuXq
         uRwkNW7Sk+OD3kmLnWNzvpDJklTTjvr0EUE631OApo8ZTj/uVHvfOwz4mAdReb54a4j7
         fjRY94AjPsXktqQ7Q5/keAcudcSia5ZcqpdqbHK99rcENaDgLoDo+AWaJmzkBGYrZ6q2
         t1CA==
X-Gm-Message-State: AOJu0YxQy+ZjybOalhdhN5ZOcxCyrX2mIWie+5UWbS7FDuo6wzPXrXAp
	lWJBlbpC4mlQi1bq+rLm021xWkYDdpIcz1ypo/UUYdS9tnSm4jl5
X-Google-Smtp-Source: AGHT+IGeC9KgrvUMV9VZOEOcbw1XoZK49/iVQoJCeHk+MnLLANMXDcc+qNK5wf31h1gegQq137hr4w==
X-Received: by 2002:a17:907:3f23:b0:a99:eb94:3e37 with SMTP id a640c23a62f3a-a9a69ca058bmr129158966b.58.1729241211021;
        Fri, 18 Oct 2024 01:46:51 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68a8d9d9sm65596366b.44.2024.10.18.01.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:46:50 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	toon@iotcl.com,
	spectral@google.com
Subject: [PATCH v4 2/2] clang-format: align consecutive macro definitions
Date: Fri, 18 Oct 2024 10:46:46 +0200
Message-ID: <fcf965ac7491a1c4ce980517cddec7365b641cdb.1729241030.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729241030.git.karthik.188@gmail.com>
References: <cover.1729241030.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We generally align consecutive macro definitions for better readability:

  #define OUTPUT_ANNOTATE_COMPAT      (1U<<0)
  #define OUTPUT_LONG_OBJECT_NAME     (1U<<1)
  #define OUTPUT_RAW_TIMESTAMP        (1U<<2)
  #define OUTPUT_PORCELAIN            (1U<<3)

over

  #define OUTPUT_ANNOTATE_COMPAT (1U<<0)
  #define OUTPUT_LONG_OBJECT_NAME (1U<<1)
  #define OUTPUT_RAW_TIMESTAMP (1U<<2)
  #define OUTPUT_PORCELAIN (1U<<3)

So let's add the rule in clang-format to follow this.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.clang-format b/.clang-format
index 66a2360ae5..9547fe1b77 100644
--- a/.clang-format
+++ b/.clang-format
@@ -32,6 +32,9 @@ AlignConsecutiveAssignments: false
 # double b = 3.14;
 AlignConsecutiveDeclarations: false
 
+# Align consecutive macro definitions.
+AlignConsecutiveMacros: true
+
 # Align escaped newlines as far left as possible
 # #define A   \
 #   int aaaa; \
-- 
2.47.0

