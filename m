Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9D2144DE
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079437; cv=none; b=GmxUYtHUieKMG5XNv48zHwDIsHXwYqBnp9bgA5+p1n28wnfWgFsJ8GKl9CF7PwkZcXHXIeFCLZ2VM23Y/gzx+aZ2+2uidP7TVLbmSFRRLoIZrVqH76ZGkGoS+xUjBfvGAPRH0iDyzCULLSyUIEPeDqkD0DCZ1E3rqh03lZjBCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079437; c=relaxed/simple;
	bh=hauJ6W7qEpaVFng0/pgb6pHCx/uM6kpimBuA9/uC4V4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dH5BosUFloBfon94OJgg1ODvbR2ucurVeRzmUJrg3aOFp5ydhrCEegWsvNEKzJ/0WMjhL7+LP68zrELbWWdZAHhey4Jg6jduznJmdQVwUhgO5oYGfmR7vDGo4ZXlYndYBbRC5DzpWJME7kO9U8PXGExxdEnW89sA7+x1ooiB1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFiU+T/n; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFiU+T/n"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso4746085e9.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743079433; x=1743684233; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiUC+gghsUFEtxRBEcC5sOngFvCXvYNoP00xTn9baz0=;
        b=fFiU+T/n81aOrFO1EygR+KR52v9hqe1OSwmFf2z9vtgQ1S5SQWEIJlk4Weom7PhZlN
         vgfPiL0Uj3x6n7z95cdhMzbqgr4lTS8r5WAloj9QlSlAgZfaSjGGC7i+Dgq3PeVYmVUY
         asY/RqjE+UP4zDY7m27rLy7aXtlJQPR4O9yAl25CixgRJi81obh08XifbQzTR0v+G0Nh
         l+IjIOiMLTkoVC4woa/CW5r/DYMnmp1EB8Z+G0X3p1B9LkKq7+xZI05bsdVRaonaZCKi
         NwjhByxrZ2/ektnnmozZwvQ02M6qMdfYjI6As8Y1EG5kaqyt+ArAyDbF/HbQI2v2vend
         lZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743079433; x=1743684233;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiUC+gghsUFEtxRBEcC5sOngFvCXvYNoP00xTn9baz0=;
        b=HxrQ8YGdp34nWz6kcOTj7PEv5dUx+dwoNCVv1xAQc0JyWZAXHR62XY6cx4wLMWUkLj
         YyHaKMUk/tgDKFwMRt4mx0abapCQFmRCoxSAD4SsQo0G8Rcb9LB9Z6Kx4yWdTOvVnqjC
         SGkWqO+qmNe56RFt446kZHFa4fJI7EFmLG0e0oPlD/FjmD6OCW4nd5KWoPVBgbFyt5XT
         wbdnjZeINkNfKo26COHvMCamxyzs4NLSZZ104wjNF3MOFMEgcaQ68BMnFZ3NFAhM4wA+
         K+jb6By4O9jbg+VAE6QIHVoMsVlJ5JSnzYX8p1fK+Jaxg+yrixiAc9vctvbzV/1D0FRf
         pDog==
X-Gm-Message-State: AOJu0Yz08c2FdR0wKvNnCHBu8gynVCH1t1vF3rFIsvGzvTjZCPVgFpUd
	0HVgKt2vHgQb3puAa7f1/SUr4jb7gf0TilOS/mID+hRDfdYzTUfNIMTF2w==
X-Gm-Gg: ASbGncu7/H9AzwvWB2lFtYJvholo8kyfIcHwF7X1yPbTmi4IY49+XO5QuuswqpHveyu
	E1PzgGBkYerqT2hF40wtL1NIQ65eKf1HePmwVtitowvafXxoO2XpQB5NXnzQf6jJfI7v8GWDZ85
	HsbZcJiNQyAQ1ghZls5AJphFMQna2roM9jT4fxZM22+fbOrp//2bsFnT2YSiuEhWvNEZK5oCMMF
	Cy1R7rqn0CehpdItp3ApHP5qH9mPK0XHQ2t0XnEnt7WaxxbjxSesCBEDi8qpO3h8dKuM57oqZG2
	7E3ZQaRWvnxSx90HcGN5nGxrjvXAyGDV1pydH1k/fh5CZQ==
X-Google-Smtp-Source: AGHT+IG9NeHsEv9j6DETQ1r9RV7JE5kGWeYW/ML5jgXF0rZB7hxlpgn8YgJTiwhjwjd71c+y0MeTag==
X-Received: by 2002:a05:600c:1c28:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-43d85098776mr26493155e9.25.1743079433388;
        Thu, 27 Mar 2025 05:43:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d7ae6a206sm35549585e9.0.2025.03.27.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:43:52 -0700 (PDT)
Message-Id: <b9901920de20ae29bd55bd68dab37a737867593b.1743079429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
References: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 12:43:48 +0000
Subject: [PATCH 3/4] load_revindex_from_disk(): avoid accessing uninitialized
 data
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `revindex_size` value is uninitialized in case the function is
erroring out, but we want to assign its value. Let's just initialize it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pack-revindex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index d3832478d99..3b007d771b3 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -208,7 +208,7 @@ static int load_revindex_from_disk(char *revindex_name,
 	int fd, ret = 0;
 	struct stat st;
 	void *data = NULL;
-	size_t revindex_size;
+	size_t revindex_size = 0;
 	struct revindex_header *hdr;
 
 	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_ON_DISK, 0))
-- 
gitgitgadget

