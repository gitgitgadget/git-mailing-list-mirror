Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AE2ED845
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766375; cv=none; b=lalmaLuYvQ+rWw+bYHIQF7s2xStx2ylGUuZAVqIoU3rr4Jt7nY0cXAVx/vs8AYuaMLyNsO+hwdmFUQwWrL61m1aIIMRrIHyAZjmgvSMmYuLdrTPlh9o7XfOIdm+YP7ggUnts8W0OUXT+pO0c+O9ZR1nWFKa0zuvgUDmTUKrgc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766375; c=relaxed/simple;
	bh=loVjaaM8alEj7d6WkiC81O6xKZjhuetx0q3wAcMaOv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TFOrJZpqISwU8eOz+C7ZwRa2pkRIoq9bB7qR68LY3lcEIx4Mo6eAxKD08srq6u8PMK4gtaiw8kUv+wxbieOrYOXnsT6JHmFfI41SvBkVXq9ZLrQYzOnBrB0XmI2LyHhiLXKGjf9KcwYKCwZWa725Vnn0+DQYD6iIRgBVEPrwri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU0mReXr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU0mReXr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24458242b33so8036685ad.3
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755766373; x=1756371173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjr5YEH41eQxlr88R3KU725jXsc7D+0/918K5Ox1c0A=;
        b=XU0mReXreK4TcaKuiPXaPJ6JWmrfy+V4rBvyaUKw2A1OpCohG8r9cyuDzx0P/uCiJD
         d3PfUYwkF/j28MZMlyn/pn2pILzhwWrBIHcLBrnD6Uofb3GHW7I5otL5T46p3xDDQXrp
         O1Mq6uSZwlwUUIubDMqlL7zgMv8vcWwKLxV2Q28/JinRCGkFHFAjqHj288ewtTS7iqTw
         K+OsDWoeMBb/4dQu9p0jHTqOQBUWqSy/op10fM64LohQO91L0R56jxB09twxHBHry9ix
         +8mICVgG/ljAs6A1/6KmBR4/3zXc3XWlaudWT8843n9CuzUR5AHyc9fladpFzRkKMebY
         9UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766373; x=1756371173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gjr5YEH41eQxlr88R3KU725jXsc7D+0/918K5Ox1c0A=;
        b=h+cy43OTCxeRkajwbkD3duLYNyxz5gbVMhDfbNzM15aBIRfie7+WUvPafEiZQ7Pjgb
         8xHrn2B4WATHXsqeLirv14SAPdMFhbelYio7tU93ZNGtB5NgNoi9TIoSHj1v7q+3hxDz
         UfvZY5CErNFWoCgfu6HNMKzT82fSx/XS/7nRzfI5aUUQ4P4DLIzm8T5Y8B+KgOTQwbN+
         mAfgrHCOro5hEGBR2LCsYGr14IE45Dzdp+A1DM6CmIJxyyn6IQDv5iZTvQR69AGcAaXS
         CUpBr8M5KaDtPM7d3MWsZddm5TSPzdu7D0uF+sNaReL0j5VfQygeDYKLSH+eLZ+JE+qn
         0+qQ==
X-Gm-Message-State: AOJu0Yze9BHZ7rZJ9Rjm9//e164w1TLYLWWTfMMi2dO6lb0Eun//L69T
	0L/mCKjMeSJjHqFKYa8ijbkoNXIsFkTu+YsAWH16j4ovv9opsscAA6OTNwJecg==
X-Gm-Gg: ASbGncu0BcJoX1HiB8fAV8Edu1SFILyDRA+IpqFyFSVaDLXvec9DLNPsrd4olLyahDs
	9SK4QPLyU6k6epAKjSR3wCGmyQciau0pvje6YyoNg0nzFOuE1BuNiQKCAWjKDmEJDmsgukFRfZy
	PvNh+WzbSrTF+dWbOga7ZRDh+YMK6Z3QRVbbv8/G6fREmbqGapLcUfluq/62H0wC1WwSBiMEssQ
	2m8TFykGQND+iXlWjySyW852kX9TgcPA/WOcqaP8z9ctsNxDzlW/+xx5NjCcmV0Sv44nlRl/bRA
	iMkka/1V7GQLpvmilokkWxv3Gys6nLRMedYv2DKNri9MMRVaDB8e6tcrjC20yW7UhkN0HVSOQf5
	jE7p1fNzUaXhl7ci6vss=
X-Google-Smtp-Source: AGHT+IFxF9xYg+VTIDGu5Rm+/wyvt4XmdcBgH9OYq0MtEyszndbRihEmzTRKmMMeYLd4gl7KyA8RHA==
X-Received: by 2002:a17:902:ceca:b0:240:3c51:1063 with SMTP id d9443c01a7336-245fec19ec7mr27926465ad.23.1755766372575;
        Thu, 21 Aug 2025 01:52:52 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7d7fsm48949525ad.80.2025.08.21.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:52:52 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH 0/2] Add refs exists subcommand
Date: Thu, 21 Aug 2025 14:22:44 +0530
Message-Id: <20250821085246.929307-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces `git refs exists` as a modern replacement for
`git show-ref --exists`, continuing the effort to consolidate commands
under the `git refs` namespace.

The two patches are as follows:

1. The first implements the `exists` subcommand. The small amount of
   logic is duplicated from `show-ref` to avoid unnecessary abstraction.

2. The second adds tests by refactoring the `show-ref --exists` tests
   into a shareable helper, ensuring both commands are tested for
   identical behavior.

Meet Soni (2):
  builtin/refs: add 'exists' subcommand
  t: add test for git refs exists subcommand

 Documentation/git-refs.adoc |  7 ++++
 builtin/refs.c              | 48 +++++++++++++++++++++++++++
 t/meson.build               |  3 +-
 t/show-ref-exists-tests.sh  | 66 +++++++++++++++++++++++++++++++++++++
 t/t1403-show-ref.sh         | 66 +------------------------------------
 t/t1462-refs-exists.sh      | 22 +++++++++++++
 6 files changed, 146 insertions(+), 66 deletions(-)
 create mode 100644 t/show-ref-exists-tests.sh
 create mode 100755 t/t1462-refs-exists.sh


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
prerequisite-patch-id: 235cc677f372e9571dade4313f8cfed4eab65f7f
prerequisite-patch-id: d0cb9932dcf233b3a26e413514375191ede93c73
prerequisite-patch-id: 9cb324ad34a786af110e9d3d47e4ca8aec240971
prerequisite-patch-id: 0d74ac673c285c334adcc19b9ca2d4919563e804
prerequisite-patch-id: 04c6d989f4130a063bc80f7dc9ce9a16d3459665
prerequisite-patch-id: 95dafb2692da02d79c59cc2742258a915da25e88
prerequisite-patch-id: f14c9a47038305eb3cfe8e9b649fa64065ada9cd
prerequisite-patch-id: 6923112c5bbec8f7f89d4a978cd2dd8e3eb55630
prerequisite-patch-id: 68baea3d311384cf9b8685ad874bb1b103a81f7d
prerequisite-patch-id: 2378c874394d7805730a46879d03da0bef244adb
prerequisite-patch-id: d329083ff7ea2fb57c984c4c4718bbb793fea13d
prerequisite-patch-id: 9b34591269ae3de243da1ae750878b7f6b29da07
prerequisite-patch-id: e3fa9191e8bc9e281adaf7c056644073e0b99dc9
prerequisite-patch-id: d3ecaf8354dc1d58dc70a9d9ea51508ceff2b2e1
prerequisite-patch-id: 90cd997029c15397eceb219d0d22989d9e874a92
prerequisite-patch-id: 37e3430d0a76fcdd8f6853c311f76aa18ba4f430
prerequisite-patch-id: 358ee0b96796c09458b03c35739268866a2c36df
prerequisite-patch-id: 50119e8583f0bcf8c275758d1955682643974687
prerequisite-patch-id: d85f18fb917f1affeefd4f807c7a8114fa6adb16
prerequisite-patch-id: 84e6b5171ddd6f5736196cbe79549f4186b85981
prerequisite-patch-id: d4b4473d029ea8df05668f9bfd767a9272255e3f
prerequisite-patch-id: 8cb9a456888b52813ef095b7f997dab5f390df0a
prerequisite-patch-id: 4e16bf58775a0dbbf58302f21d11864b96f321eb
prerequisite-patch-id: eabfc6cb85b47f04d78c2634dbaa6fddf87a60f9
prerequisite-patch-id: 15aad03c722b62d6fa22bdc3a44f862ebc2b1c88
prerequisite-patch-id: 9361523cda8f829d5fb7cef7d234f3fda99ebb9b
prerequisite-patch-id: 66abfbef34f4f7bc408324c5f327b767ef36a679
prerequisite-patch-id: 449ca227be630deeced22f191344becc63cdf9d1
prerequisite-patch-id: 5226b03a040940b4fe1bf0af254a77d67f5a177e
prerequisite-patch-id: e7c24bcc4a5ed5367e90bb23db0e28d0ccbdad2a
prerequisite-patch-id: abfc3c9c3ea59b7495e229e9ad433f60dc0ff8f7
prerequisite-patch-id: 7fe80bfc019f63df308391e1127a25e59103abc2
prerequisite-patch-id: a84ad0fb4b321a8d6c58d942a716b8e3748156ba
prerequisite-patch-id: 900b6cbe5278bc6beeadc102509f1385ce7d637e
prerequisite-patch-id: c7ad0ca2ff0e22d174da1047c6eb30b1dcd8da84
prerequisite-patch-id: 118017529d699ca93d9ee86196eac8557f5c36a1
prerequisite-patch-id: 49b0a7b7e607adb614e7b46d2778ac46d3b3c7ce
prerequisite-patch-id: 823f58165b365d7368faa82d905fe0d0c2136357
prerequisite-patch-id: 665b97ae5be824000628b34bdbb2b73b68b5c292
prerequisite-patch-id: e3c140859b3637d5a13c020ef041ad25a4a6bc42
prerequisite-patch-id: 41cb62f978e5dbf3a658ffffe99b8c1b479938a1
prerequisite-patch-id: 1929619486cdee7517c3f2b0af67e96c69c89764
prerequisite-patch-id: 5035d6f130dfc22b4fe9ea79b7a436fd54070a81
prerequisite-patch-id: 53dd4f1d4455d8cdf2e2a2fcb082be00ad8c0914
prerequisite-patch-id: 2efcbefc0f0395e8178e656c3c79cea2acf54377
prerequisite-patch-id: 447c1cb43a64eb6c95d98e115fcbf424492a3ab5
prerequisite-patch-id: f929f5f303123f8b937cb94c200ba93b139b9dfb
prerequisite-patch-id: 373824b744f085cd7bfd97f1568c6f2d56ea8ca2
prerequisite-patch-id: e4dfe5bca99ff093f0c8aff1a085010c0f0d3c6f
prerequisite-patch-id: ca8fe616ea1ac4d575747f9224222bd65f514705
prerequisite-patch-id: d34e569010a2beb0d5ddfe7e3dedf3abb77c5604
prerequisite-patch-id: 250bae2541030fcdfc5b35ede44c23e1138c7a3c
prerequisite-patch-id: 476284f1a96b09b8853052c9ba8f32acb2834c17
prerequisite-patch-id: 9cd780236535e9e84eae38f2a19c5e010f6c1288
prerequisite-patch-id: 7e3ba2fb3d0dd0760a3e3a5b336927b04999b28a
prerequisite-patch-id: 0a500a41e9feeca41e81bb0e1bfcf3ddfbe4cb82
prerequisite-patch-id: a11fa19efa109c1394e0c6ab781720c61ce13c41
prerequisite-patch-id: b365ab543df9d138b41c1a8d40a754b84b965e99
prerequisite-patch-id: 6f248fa00c78e2171a52f4c038d4bd7f339840b2
prerequisite-patch-id: fb1e7d4305f77c598936f4b638fa7803965c9e78
prerequisite-patch-id: 5b1b57b2c3fb387b3fbd7a9c6f0b57c80199a94d
prerequisite-patch-id: 9d70dcb2e265c49f9b84afafa56c857567943a04
prerequisite-patch-id: cf13b44e4629fbf488603defcbc8acdc0217b4be
prerequisite-patch-id: c90829faf86b799652917ef99206e7b1cead2c54
prerequisite-patch-id: b076beae979d5ac7fedcc13b5d26e77d5cbe6663
prerequisite-patch-id: 5f39ac2a8c07870f69770baa0109793ff7022076
prerequisite-patch-id: cafedb553cd007249c5bfcac36242438656ca170
prerequisite-patch-id: 197d745dfcefbd8751e0c90aac632331826752a1
prerequisite-patch-id: 0d1d1a35ed44cf830442f3e74c65cdcdf9b91566
prerequisite-patch-id: 4cc86520dd4d680ee3ca856d176f324e683eca41
prerequisite-patch-id: 95a6721029877cf75106b96a6bcc707aa17e1b9c
prerequisite-patch-id: 5b7734071f21d853533a6ee09383690fafb5fead
prerequisite-patch-id: 7e1d3e7927abac3b453fd0e79b634c7365ed955a
prerequisite-patch-id: 7daea73cac876045f587001cf94b7f83ee9e12c4
prerequisite-patch-id: a765074cb9084aa5da8e72b2690c323c3ec83231
prerequisite-patch-id: 4e277720b943d0a26cc85adda11eb568e442f77b
prerequisite-patch-id: 28f977860324220a487487be0704519f90a02306
prerequisite-patch-id: 08e65a7035bac5c4232ea4e39c54eecc49408f19
prerequisite-patch-id: 63c3e610f0e56eabc039483636e292d05bbc63b9
prerequisite-patch-id: bedd7161331cb4fbf30debff40d33a8a0c14023f
prerequisite-patch-id: bf6dd38daaf71b4599833e4c8cbf64698e9c1a36
prerequisite-patch-id: c611631180a541b1787c12bcbe64bb9ae3454244
prerequisite-patch-id: f3368c4816df6c93c1ec1b35c1c405657f1a7387
prerequisite-patch-id: 29c35a90c70a4f37baf96b4f592e197c5621666a
prerequisite-patch-id: 6a612f309924935068f6a57f8d181d842a274ea5
prerequisite-patch-id: 76634063b4f24689276d6099bade4330c3fa8bde
prerequisite-patch-id: e217cab3cdd411bad09c252de5fb4206be77d637
prerequisite-patch-id: bb3fbaa2b7bd78e3e60f7a434146005c04161509
prerequisite-patch-id: 24edfd0bf766d61c182de3aa86377ae90db4f7ef
prerequisite-patch-id: bcc3a15b67760ab9433363223c506cd09f03747e
prerequisite-patch-id: e7bd2d09677a0bb1019e3c3790417498ba2dc7f2
prerequisite-patch-id: c79540346ad559338d46454486dcc1be25e9c5a1
prerequisite-patch-id: 8803357fd1432a264d60c9e1a688dc85d7935b3e
prerequisite-patch-id: c099a26d62f63b535199c6f52271bb63e88df69c
prerequisite-patch-id: d1825e57939cbd15928498352e1a7f00c673c12d
prerequisite-patch-id: 3ebef3d7a7a7b224eb0a68ec8edfa0358a2c5a7b
prerequisite-patch-id: 69f3f6729c7c473374a9f21ec2875b8e42ea5cd9
prerequisite-patch-id: 2c5dc68c7b4811b6710cf1516cbd3608cc761bbc
prerequisite-patch-id: 0803b4f82635672ea9b6b9a546d9a9577884c5ad
prerequisite-patch-id: 553adfe23223a427db3f93e23dfb603c55cc5aae
-- 
2.34.1

