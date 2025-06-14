Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1534545
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749884791; cv=none; b=GeJc7DtLZf26JMSwmfePFOVMTzU4jzxR45cv1cemG5G8aGJfFrOAjhE9zKRdnW2tSfSCFmgOKZjGIL6SSaXe2BnZkbS4gwGo5CYEfacLg2gpkcbWBFs+HU2QWEyrLGEbfvAPNXCErsMmEaWMmEFIE933vkkzLSyLsxNYS3exZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749884791; c=relaxed/simple;
	bh=3rZxGbY+4SPV7iXvTXNvx6HMqHP7PLWNMiuo5buv9gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJm4CtkNjR2xBrIgkGiZkNbUVNtPYhV2xhuxovE29cWF/W1aAUWxgsKyHpJGFfgmzqZF6CgkW4o3DS+Q1UxtjkLPu7V4IzRSguaWmna11NZjl1MGs9fYkpAqcaxjme7634mWVHC2IsFXjqkj8EYw3X4tnpELNpHT+tsyZ4nrLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k556G358; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k556G358"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742caef5896so2540661b3a.3
        for <git@vger.kernel.org>; Sat, 14 Jun 2025 00:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749884789; x=1750489589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOfPvBkhywlSjg+n2s7BNsXaOMwCpa/umMH6MORNMKI=;
        b=k556G358dRGTfjNT0CqHHFZmESfJimLRNf81N/TJjs3WAE8ltkl3MRyCtzqbSI17xk
         Vz0I2uYzAYJVio1gk4WkbAjSTKlKlOU1hK6NLt96QgUg/H20o/TzCPXyldJqmsQ3GVAE
         5VzKUq8SWbEc4ir8U3+J48hY3RIvOCNpiE6IQwU4zgLNBhuFju9/XxThs7jVzpNat2yM
         1zJpKNGvlLsHFIA4XNsrr0ayar8Im5x8WdAqspYw6zOqiRwjYn/Q/xyFQyZmy4j0Uv6M
         LghZFRsPzUkL+ZAMJSeFGoC8qIGtRtlgtzEFT2pQfAKnxEjeryEkyOUdpzYElQzgG+wI
         uDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749884789; x=1750489589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOfPvBkhywlSjg+n2s7BNsXaOMwCpa/umMH6MORNMKI=;
        b=M7xi86AJtomCp51P8APD1zLLOjlvKm44RkSzjcI0tRpRc09HENlQlf1bQPYYpwYfS7
         MQf4Y/rV+d/VOZ3435HqCBr5saUvgPhU7rDzFhP/vZq7Z9w8T9ytSPh0Ss4TrN+ttEzV
         /o3r10c3XZoIIMi9Att7JQIplutkExM7LoqmLsZnXrDyY1EbEiLqReEX2lvzaLZW7ESv
         SPIAGhieLDarjL03wmqGYIYcHB+rtTMx3vlTPSw0UMbF0EW+OVNQ1ucjFJxa6AOBdF+g
         /DN/uy8vAWqrWUVTgAaGpaeO0MGiQAVrx6j2bMsW2ZZZWfiMpD6mL47FEadnnpeoSLqe
         rABw==
X-Gm-Message-State: AOJu0YyqV5cGR39Nu4kgU6wtti4Ga7+Fgt45qSg0Cfybw9Fes+9HZmQ5
	y6gYAO/zpTjCRfrZd1xIOGoc5pyb1aUI32noJVV4qzKFJIBw2I8v0Ol8vqBc0xuw
X-Gm-Gg: ASbGncucjnXfx1beQWXgvCmSDAqhz5/gniHvo3khkC65kVJZTCWkFdHi5CeYYal3lrW
	D9erMhIQAn0lJv0APo7hxispQqGmPUWYDWur9myIBniYfeB6D//tLLEya5wVwkSodFVy2A5DpWW
	MYXAD2r9KbjidaM7mcf4C+Qz8eDNYZik91yHfjJMMInReZTVGViaPYDk+BbJWULr21oc6JOdCmv
	NDl3OXbzWK6zuQvEkxbY/pfjBtsFGgR0+nOcBB6jdEQ7xht7/LN3/zgxZLFj4VtUm5B5vP6gev5
	AVSSKX9F4rxRSjwocqHsIGLFVk5Y1QwYW0suJON8e4Lz7qw7kVNrH54nFWk=
X-Google-Smtp-Source: AGHT+IGzKTw8DIyBre000Woj0A4BeBti2MpR/thO+qVKyCOscsQeZdWvgYxOWeQOfU82nPMRUtx9PA==
X-Received: by 2002:a05:6a21:3388:b0:215:df3d:d56 with SMTP id adf61e73a8af0-21fbd63176emr2875707637.21.1749884788921;
        Sat, 14 Jun 2025 00:06:28 -0700 (PDT)
Received: from meet.. ([43.250.165.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168999asm2380814a12.54.2025.06.14.00.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 00:06:28 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][RFC PATCH 0/2] Add refs list subcommand
Date: Sat, 14 Jun 2025 12:35:34 +0530
Message-Id: <20250614070536.17320-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces the git refs list subcommand, as part of a
longer-term goal to consolidate and modernize ref listing functionality
currently split between git-show-ref(1) and git-for-each-ref(1).

The initial implementation focuses on mirroring the behavior of
git-show-ref, providing support for filtering by --branches, --tags, and
--head, and implementing pattern matching similar to the legacy command.
This ensures backward compatibility.

That said, git-for-each-ref(1) offers more flexible pattern matching and
we acknowledge that its style may be a better fit in the long run. As
such, this RFC deliberately starts with the show-ref matching semantics
to solicit feedback on whether to switch to for-each-ref style matching
as the default, with a compatibility flag to preserve legacy behavior.

It's also worth highlighting that several options from git-show-ref are
intended to be supported in the git refs list subcommand. These include
flags such as '--abbrev', '--quiet', '--dereference', '--hash', and
'--exclude-existing'. While this series focuses on core functionality
and pattern matching, these additional options are within scope for
future patches.

Additionally, the git-for-each-ref(1) command offers a rich set of
features that would be valuable to incorporate into git refs list. At
this point, all of its existing options appear to provide meaningful
functionality, and my current thinking is to support them incrementally
as part of expanding this subcommand. I'd appreciate feedback on whether
there are any options that should be reconsidered or excluded in this
consolidation effort.

This RFC is meant to start a broader discussion on:

  - The desired default behavior of pattern matching in git refs list

  - Which features from both git-show-ref and git-for-each-ref should be
    preserved, rethought, or dropped

  - How much backward compatibility we want to offer, and through what
    interface (e.g., compatibility flags)

Feedback and thoughts on these topics would be very welcome.

Meet Soni (2):
  builtin/refs: add list subcommand
  t: add tests for refs list subcommand

 Documentation/git-refs.adoc |  25 ++++++++
 builtin/refs.c              | 110 ++++++++++++++++++++++++++++++++++++
 t/meson.build               |   1 +
 t/t1461-refs-list.sh        |  95 +++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+)
 create mode 100755 t/t1461-refs-list.sh

-- 
2.34.1

