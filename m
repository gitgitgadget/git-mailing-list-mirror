Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6861EA7D6
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214540; cv=none; b=TjQ3bpHtfYGWyNylcHG2b90n/qi6QLIb0/tzythfx1Zstq4yOOmRa4+Oq+fx8ZkY0asM4NBD9r1ZfOiTN+72DSF312h7TP7mr/mmwWPwnY7zAfJP1yceyy9rucfS0kVOaskGIJ5U/dWpcrrHSsdtRSXJ6aQA9vw2mmSUUJzSIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214540; c=relaxed/simple;
	bh=vjlgkoUVayj3ZD8VeorzV5jxOCFYbRTntfbTjPu3YPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPUpncCihLLy55okg2s3ZyPjIM8VzwK2uC9dYV7iNADi3zuCAIvVU8X8IXnQrg2xNW7UVd8bzJdrJYjJv/fPwUDh9MwOWi209g+J4yKOlu9VNe6gMeRNiduTLeBJmOlKnLvbzoy+oRvDmEUZQCvuKmYcwnlkCO8JDmsYv7gTvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY++46bA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY++46bA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so426383a91.3
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 22:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745214538; x=1745819338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q5OQO60JMGT2niHTvIkWusngsNEUhEAS2IxecOiucNo=;
        b=gY++46bAAXl6ITEXIPKwKtPsG25i5MpAiIIN3JOhWi3ivCgUFHqIRqqFUCrK3Wj/pl
         pdbpJ32WAsYkvxM4HP9TbmcG88wBEkcws/dKjU0A+Y4mB6nszLGlp9kFnUdGfjpbWomp
         9g2lFupv2GZWk8o70HCPKn/UBmnsFGXkENaNSAq1wnxMEq5o4H35xPzq9/9DZz7g3p6i
         1NRQjILPA9UH49b27ekkrgmC/pFZrDVZ6cqIeOxbJHgCfBpcDzsNrF4YTHO7QjeK43SF
         AcYtMmeL0lBmzVjvaXnJUkx2CNMiRUltJ2r2Spu5BHRmSo5q8AxyNSAoZBcRkF2AU/gz
         4Iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745214538; x=1745819338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5OQO60JMGT2niHTvIkWusngsNEUhEAS2IxecOiucNo=;
        b=azRZOZg+nOF/rQ2CIVYIuwOaBEgegsCn9mabcWkxwduapMrwtF7J1Falunh51o6EUY
         f8gyH7k0uNsolQehSfKJeHMqaK+48ObLDM8o4CV7xajQ4zl2I4NQArihL16bTA6wpGdL
         JCDBfpNh7uWzI87sj3FMfnw0+avY6sZVdWsBReVADLbmpXLJ31b4Z5UKQFdie4XKWeKc
         0e+MA6uxU8LLwYeFduzSzbMPeumFkw/ShPWVtQR24OwZi8wKNEhMTf+00h55lF0WpAiY
         9b+CWOSvSQN3YmoAwMM64q3zjA5d2DcgECqoWOZpJlaacmC65XjXFQN9cNOE5xp/leOu
         +MdQ==
X-Gm-Message-State: AOJu0YwMqGCWy2OwruPyA7r9O+E52gaCVvTz8sXhbbixTTldUpqeLXT4
	6lhoI3jsH08Gth8U7g0E1/DAyeE42epzMXIR7YHjKga2jqH9VawPvCF2HmGg
X-Gm-Gg: ASbGnctBvYeYq4SKEnVz86e4Cmkpp4Oakz4heOL9FNW8xOL4ZYcQHlwaIe7H2lXQbF5
	qWHYmlLIO5zAgtM0JNXytu7DNLMETK/pjdnBx2Ic45akfpFZnPS56xnhAv80gE3SB6+927lSkcv
	dqTvZh1Kv/VrampXs4tgpGeM0RAzCFcVywreco26kQgS6mlg4c1UdzZa1W0eWGzkmGaaQyXC2sJ
	7+BN91EQad68hOaBtejp7Qr7dIkXcFJzgYrnhrVcA33ZeIBJKIowt3wS8k61Q209jBpLycgBcqV
	9TwIKmn39kBr6LBKJ8xafCB27ZaH3qgq4qdw+edPRc2HC+tgHQb2lBGFcetFZ/hSjBqFhwU=
X-Google-Smtp-Source: AGHT+IE2DNhVceFwV5fWbTm1uIpwk785zTaIZqrETccAB4yYXhh5L80Hjvu7YJxwPLaX7Oweay62rQ==
X-Received: by 2002:a17:90b:3e85:b0:306:b6ae:4d7a with SMTP id 98e67ed59e1d1-3087bccb2c1mr5618898a91.3.1745214537805;
        Sun, 20 Apr 2025 22:48:57 -0700 (PDT)
Received: from localhost.localdomain ([185.153.179.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087dee8811sm5682010a91.5.2025.04.20.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 22:48:57 -0700 (PDT)
From: Josh Heinrichs <joshiheinrichs@gmail.com>
To: git@vger.kernel.org
Cc: Josh Heinrichs <joshiheinrichs@gmail.com>
Subject: [PATCH 0/1] maintenance: fix launchctl calendar intervals
Date: Sun, 20 Apr 2025 23:46:32 -0600
Message-ID: <20250421054633.231069-1-joshiheinrichs@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

While working to add git maintenance support to home-manager[1] on
macOS, I noticed that the calendar intervals are set up incorrectly for
the launchctl scheduler. With the current settings daily jobs run on the
first six days of the month, and weekly jobs run daily. I've confirmed
this behaviour by manually shifting my system time around and checking
the system logs. This seems mostly harmless, and I think git maintenance
is somewhat niche, so I don't think we need to worry about proactively
correcting existing launchd configurations somehow.

[1] https://github.com/nix-community/home-manager 

Josh Heinrichs (1):
  maintenance: fix launchctl calendar intervals

 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.47.2

