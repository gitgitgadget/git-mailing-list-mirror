Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AA1DFD1
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713723256; cv=none; b=bC7iS3kd5V59KB7goocwjJE0h5hgaln3JZBOxtVkf4jD2KQ9AYfwigz/qJCBDBaZvEOB4X1LCfhWSm9pUg2cYdlWmW7TTS9A/uWyzdi0q9zd0O2rBPbRkE3Z5C3oTANZwuGWEtRuOO2x1zXKdq3tMx5nId/fRxg0CjxzrXlI2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713723256; c=relaxed/simple;
	bh=ewvSRXH/gbKvRH81F3clIBEJNN52BuCWTrlcAE1LsTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6SA5Y8kdaxWvDa9okCmPLLf54D5OkGxns6F6WAh3CTFWnLUovOGl+KH8j984d4K+0bgkqmynLUFgz0NiRjoERRH0v3EQ5PueumPsLRRKaX4WjIjUUQ1W/VhhqL+XewkDKJS5u69zlmyR0Y9/qvfiPmnCAZVoDgBF2bE6l4zRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=ax45AOXB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="ax45AOXB"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a52223e004dso340079866b.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1713723252; x=1714328052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMRuyxJDaNk3UVAf8fF1qvASGheUlLTkpX3T9o+GlG8=;
        b=ax45AOXBq1MpYgxcs891iT7dr1q0DEdCH9LXA9q1K3O5CthmkmjlI+p2udghTyf8jZ
         9/KMGOVUGCrgGvHSySixEDCsg3nUEE9QP4OqEUtOCGnzOPt0XNCzFubs9rCU9MffTn8D
         88eCxZq0lyVTAOZR7Meo3ltiBu0o78F91BalESA+BPT/XOSWsBF8chhvvPvNCGKNx/Sc
         YvrIitbRBgRL7LzYK66giRiLxvzOCvdWUSUqnqhvYExE9Nq0SVwvPSKRInz7AmcJ5gkS
         +LaF9+hlFsxIgK+eVQv1pdQni0kqwxWHoT5JqHDkekeEtp/vnwjK4ZNcXDL3kJLw07t+
         lbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713723252; x=1714328052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMRuyxJDaNk3UVAf8fF1qvASGheUlLTkpX3T9o+GlG8=;
        b=lC+6hTdooc0gebKeffe+Svhdm6saRCgamVqrNcEq3/qQ4h+NK6pSxyKc3pHPYM46ew
         QN3qKVHhlhB+651Ip++MXKn5QTYBa2+XLtse827PQBHl6J3GattY24jy6OqslNWv5lpb
         1cKmzW3Ph+v5Be1CAhZE++KhSsqapvsWJUNsxFKDfzDQBObqglw6TzUGifDJjcNBSvVu
         wm45D5K2zIkcD7/fUoTaWbYmKgXOaAXyfS4LLzq+PY+3VwKpTaH5O3ebF6QPALEvOXOt
         yC7SZOTYZHBc5dDq/7/lj/VKnU4QDYBWHXEEqH/+NN1tPRK9G9lNFsWkfietXbXzbY5U
         W8Nw==
X-Gm-Message-State: AOJu0YyR9QPS9eDCsCnvD8xpcVgqlHH8+lTC2D4W8bdGwCykkUZn1eVB
	QpqAYR/XojmNke2DIxfaDv0+r33s+922IiS/bTPjxFvpkg3jMmcL0wzBOBsnactJT4PBuO/hTtw
	/nTE=
X-Google-Smtp-Source: AGHT+IF0mLghWE9TluKFNAI1RsvaYupXXnZcuWfnXlK3eO8EB0fpbJq/+Abmvvwe/TvRPUjJr/y9Ug==
X-Received: by 2002:a17:906:34da:b0:a52:2e08:207e with SMTP id h26-20020a17090634da00b00a522e08207emr6091217ejb.77.1713723252068;
        Sun, 21 Apr 2024 11:14:12 -0700 (PDT)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.154])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906091500b00a5216df5d25sm4772043ejd.3.2024.04.21.11.14.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Apr 2024 11:14:11 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [[PATCH] [RESUBMIT] Consistency for substitution hints (i18n) 0/1]
Date: Sun, 21 Apr 2024 20:14:04 +0200
Message-ID: <20240421181408.82736-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i18n: as translators choose substitution hints applicable
to their writing system, expose the ones in parse-options
for completeness

Alexander Shopov (1):
  parse-options: use localized substitution hints

 parse-options.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.44.0

