Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762271362
	for <git@vger.kernel.org>; Thu, 29 May 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748546457; cv=none; b=Pr6/Z3aWLjxncK/Q8U1EHYxtq77w4Hw8LAhWozEw2vzjPnQHbFtJu8AAD8roTOyex3xaPuZQqr2geCByDI0/vsh3nMZr+4B5TrKOJ+3XwMPNY5ZmwBW+8uMAqVTa8jjTomaZCZGShcmt90JDxpAYTSgN1nOVplOHcUM6uC8Ong8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748546457; c=relaxed/simple;
	bh=Piso9PA4s6h3wAmFRnnpPTI5fmFIONwkIRraoYOaL2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WS6pVKeic/i55KWlOVXsgZSU+C3P43FXCfa0R/zjwWuXwKuK9NOwLAXuiV/7/aEjTcvH6j5i5dVWnkRc2McdCjdDkgqSKSkiXYA5K9mwvrNEJI5f/6zLjzB+2OQiGbWiL0fE4Suvt1/0HVN50sIkxQcPxQrtCO96Mic9XxuSwl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjqkMCz6; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjqkMCz6"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52f404ddf3eso748641e0c.2
        for <git@vger.kernel.org>; Thu, 29 May 2025 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748546455; x=1749151255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ssolFhivXN+n/ru4ETxJEXEL28oMcn8yW27phXlpIE=;
        b=jjqkMCz6lp8vyxtPMROKsmblOoS3av8Wx8DtCa4an+fNT5x4QnLK8iZhNna5K0iDyx
         laD0RV+R9egJnE51W3ho6FdUMoK2jC/UXmklLfXyUL19N6x4K2v8/Xj55F5q7DYf4pX0
         J4Pg52k085zBGsxgLRw/su6c5/nBoeu8V1V/7UhmDEoy47x9l6X/EciOns/pD/Lbk/4+
         pvkXZHtWpnhm3fumBuea/MhrHb8QPYypr7FjsiB7t4jHe+bDdx3AtHGp8147XPgZ9br8
         nLZLKdp0Dhuvhx/PAA960Papu+vbw6Z2wXjmK3LoA2KEn73O0ITE1LgvZ451VWcAN0nF
         vYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748546455; x=1749151255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ssolFhivXN+n/ru4ETxJEXEL28oMcn8yW27phXlpIE=;
        b=TNS1j7wKzioYNN5G7kFN+zcl1UtYRMfHu4vdNiJGHUAnH8/mTrPrEYkbHM9Qtcgks/
         AhWi4rRmkstsMZOrU+uD9HSlVyjZrWV8LOTIyMYPnEzQUlxsj2bvI8nrostcR/9zqAC/
         3PfNzWcV/yRxYaXJtz78s45TmjmMblEd6s/pJvN7FLBuRdnlRLfT+EoSfFaHFeYM4HuO
         enhs+WBGwIAvutTWvxID3sQ8e70SLYnpErGltm21W4ovLBg9lUTK4y5PSlIz4URtoNdi
         zfJb70ngiuirBFSZPuLAA++RX/rYUYCz0CvgRjWFaflJinsF+LZ6PzsF4U/vm0x3AE1M
         kzOQ==
X-Gm-Message-State: AOJu0YwdTxP1dJRhvh5M7oEiqI1/qRYr00tHkspuoWow0NYwPwo5UnzV
	EOjYuTP+IRgwz9ivZ9Bpgjtm4gbRBtoZB9dr0VQpravNeLRLVsDJbzHKb350Ng8m
X-Gm-Gg: ASbGncsPGkCLIH6criIbRmWs/YpMgitKWm7G42rW6jth38IWHL7YwZZvbLHMJmoUp+Z
	6MfGlHx0bXTw3olHKvf6RH97426cGXwdAngQ/GaGMycwfqoPUF1XYMNixhaW/0TwxPIsQMeU9Cz
	PRm/cXC57YrSeJlMsMGsHHTx8MgFDQgHV+hok3ejOCBcuPlEan57liqiMwBcC9IH/ARKJNZ5+v4
	WRjzSvbyHEs4F3tOZhdtf3V+42XWHOvzlEfMZgLsWZEhhL+I8iOjBcGu9N0WCSL/sVckJSezwDA
	53bDpF7eKKGRYeWPk0/x7/AqRiDe3rkXj+iFO9PhrSYRsJbzUFSMQQICrR2mWRMS16591jrRVzw
	tPRUzlg==
X-Google-Smtp-Source: AGHT+IHXB2U4ni6uKZFpMZh/omFhF0vdb9Gv32Ppgfoy3FUKp6ek+l29AvqCTICFzOCWEDapQwkD3g==
X-Received: by 2002:a05:6122:3c4a:b0:520:5185:1c71 with SMTP id 71dfb90a1353d-530810adccemr771620e0c.7.1748546454778;
        Thu, 29 May 2025 12:20:54 -0700 (PDT)
Received: from localhost.localdomain ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074ad9dc8sm1754464e0c.20.2025.05.29.12.20.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 May 2025 12:20:54 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH 0/2] Update MyFirstObjectWalk with struct repository and meson
Date: Thu, 29 May 2025 16:20:34 -0300
Message-Id: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I was studying for GSoC using this documentation, but I found out that two
things were outdated:

1. The lack of using the `struct repository *repo*` parameter in some functions;
2. There were a instruction for adding the new command to the Makefile, but
there are no mentions to Meson.

This patchset updates this documentation file, and hopefully will help future
new contributors.

Lucas Seiki Oshiro (2):
  MyFirstContribution: use struct repository in examples
  MyFirstContribution: add walken.c to meson.build

 Documentation/MyFirstObjectWalk.adoc | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

-- 
2.39.5 (Apple Git-154)

