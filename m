Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7AD1D7E4E
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159842; cv=none; b=mZndipeRvgCqpWhPgdtlCaEZsW/5L2M3FBc0plFBwmr//m1DaB+rIBdeN/6IIz8PhYe5/12i9QTByLHYII5bNXo7YFyesXsRG+hO5EpMQyUjQnX6uuPO5nbU9KD3SkjOJn+mUHQ5wINI7xA8vqbPmfEJjm+7GUs23ev3/7iP5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159842; c=relaxed/simple;
	bh=ADQkEbt3IexvcxUoJzIysT6Te7T2IKkh/IHH64vU3tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNFGQXm9KuDCr90rvSY9MJync7UOfgrIunCOnux4Fj6WiPRItPLJ+s/MXvUhqS8ttHI+9b1PVHbl4n94H18GitepaSW88IDcYQOeDfHGaQSmjEUdqCEVxIPFd1wVIpy9bCQa2SXTyClL6gSTACUHAwN1zNyJQb+IWOMWCruskSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/CABpSp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/CABpSp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso198849215ad.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 02:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736159840; x=1736764640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lM33Dncrfq9HXuu3cQn4eKnoLmh0+A5MlcXVQ7yzIMU=;
        b=i/CABpSpW7gmhjgtQ87jmkopHxkYBt7LlxfUTy3BF5X5xH1QagdZTxYM7/De2RebDj
         EArVbt5TTDkiLmu086FYtPUQRX8dj04pY73rk0ptbg7RNJ8wYezOuaaalYnuSm/6PG7g
         MZUZ08Tf1FypjIbBZiDNUEdHeMu7dDRrLxZCLr1AKh9tg/ZNBRK16X2YT/A7dJJFMPwv
         8GVaQtHG0mK0zH4wBBRn07cys7eIPMOweYRfOQHOutsV5zbG2REfxOe6Av68zHPbgLEn
         6XcWl5O+HviI2b6GBKX4xfJw4FL6Zkkc0tudyqz8wBBeUC7Ua69YlK0zFbcdJJP38OLB
         Mehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736159840; x=1736764640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lM33Dncrfq9HXuu3cQn4eKnoLmh0+A5MlcXVQ7yzIMU=;
        b=RdFcpAjeuymdH9bBLFe4FzxnKgC9KG4dsdok/6uqPQ2mpI70I/tG+RoaKVGdgVqJOM
         G8Pq8l9ICvs4wEoGyx+MgWzot7Z5g9Jve9v1pw7S75vwAG+6uo23Q9sr+XdnI2Et9ZWT
         9qJE4MdCi9uHdiTGGup0lCqBeSCj4yVM8QbKWW+uU9o1GYFyExIi08b3BnC64DsWIKau
         OvTlrvbP/TSBelyhpQeTrucTfhrwAPvwtg7Hn1yh2lpRMNz0I93QUOwcqHblilIny/w2
         dYwDU3RGnuBOullth33bVfLBCawpBy0Qfo5MN8wQmnTZp0eBvPVK++ELnNTjgCWL4RI8
         RAsw==
X-Gm-Message-State: AOJu0YzxPNt/z8+hqmvOqMAgwmM6yJfKJEkzan3frdflTya56bNV7sNF
	X1ad/AiTvmlRAew1AvM2fBc2dBcqIDjbsXID6MDALeYh3dTvAoK8S+ysGh13OIc=
X-Gm-Gg: ASbGncuDSovUDZYzwan1KRMoH2tjXzkmBqTfKHBRlUIaX3jb0/vVpziVBOF+K16OLSk
	OHPd/KBptHxt9orYpm/yGD5rDEgyDzdad2MZfG30+wvjHaOG46ebUNX93cmVYwv+3WS4ct7/Hxq
	KdMSFp7ioAhbiwdq25q5h/MtzcwXv4FoKo/MO1u3zlhvnFxG5wG03MpOet22MYfI1SxP1dfUiZ1
	IhhgIoo62Or9ikega5OolUnDDMP+vEuZyho9oeIG15bo+qm2R6Nrq5kOCkz57apakB4c7K1XCCm
	+KI9PQ==
X-Google-Smtp-Source: AGHT+IE1yA6JPRhcres8yC/Raldtj6ahY6KH4K07TPrV0GLDa+XIxRiI03gIA9fvf3+CC5HEIpTSRA==
X-Received: by 2002:a05:6a00:a88:b0:72a:ae66:3040 with SMTP id d2e1a72fcca58-72abdd5ef82mr86469706b3a.4.1736159840010;
        Mon, 06 Jan 2025 02:37:20 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b85f00f9sm28774281a12.43.2025.01.06.02.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:37:19 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk
Subject: [PATCH 0/4][Outreachy] Introduce os-version Capability with Configurable Options
Date: Mon,  6 Jan 2025 16:00:48 +0530
Message-ID: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging, statistical analysis, and security purposes, it can
be valuable for Git servers to know the operating system the clients
are using.

For example:
- A server noticing that a client is using an old Git version with
security issues on one platform, like macOS, could verify if the
user is indeed running macOS before sending a message to upgrade."
- Similarly, a server identifying a client that could benefit from
an upgrade (e.g., for performance reasons) could better customize the
message it sends to nudge the client to upgrade.

So let's add a new 'os-version' capability to the v2 protocol, in the
same way as the existing 'agent' capability that lets clients and servers
exchange the Git version they are running.

By default this sends similar info as `git bugreport` is already sending,
which uses uname(2). The difference is that it is sanitized in the same
way as the Git version sent by the 'agent' capability is sanitized
(by replacing characters having an ascii code less than 32 or more
than 127 with '.'). Also, it only sends the result of `uname -s` i.e
just only the operating system name (e.g "Linux").

Due to privacy issues and concerns, let's add the `transfer.advertiseOSVersion`
config option. This boolean option is enabled by default, but allows users to
disable this feature completely by setting it to "false".

To provide flexibility and customization, let also add the `osversion.command`
config option. This allows users to specify a custom command whose output will
be used as the string exchanged via the "os-version" capability. If this option
is not set, the default behavior exchanges only the operating system name,
such as "Linux" or "Windows".

Planned Feature: osversion.format
While the above configurations are already implemented, we will be introducing
an additional config option, `osversion.format`. This option would allow users
to fully customize the string sent to the other side using placeholders,
similar to how git for-each-ref uses %() syntax.

For example:
Format: "OS: %(os_name), Distro: %(distro), Arch: %(arch)"
Result: "OS: Linux, Distro: Fedora, Arch: x86_64"

We are wondering if it's worth it for placeholders to use the %()
syntax or if they could use another simpler syntax like $OS_NAME or
just OS_NAME instead of %(os_name).

Note that, due to differences between `uname(1)` (command-line
utility) and `uname(2)` (system call) outputs on Windows,
`transfer.advertiseOSVersion` is set to false on Windows during
testing. See the message part of patch 3/4 for more details.

My mentor, Christian Couder, sent a previous patch series about this
before. You can find it here 
https://lore.kernel.org/git/20240619125708.3719150-1-christian.couder@gmail.com/

Usman Akinyemi (4):
  version: refactor redact_non_printables()
  version: refactor get_uname_info()
  connect: advertise OS version
  version: introduce osversion.command config for os-version output

 Documentation/config/transfer.txt |  16 ++++
 Documentation/gitprotocol-v2.txt  |  21 +++++
 builtin/bugreport.c               |  13 +--
 connect.c                         |   3 +
 serve.c                           |  14 +++
 t/t5555-http-smart-common.sh      |  41 ++++++++-
 t/t5701-git-serve.sh              |  45 +++++++++-
 t/test-lib-functions.sh           |   8 ++
 version.c                         | 136 ++++++++++++++++++++++++++++--
 version.h                         |  13 +++
 10 files changed, 291 insertions(+), 19 deletions(-)

-- 
2.47.1

