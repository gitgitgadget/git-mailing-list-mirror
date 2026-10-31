Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446785;
	b=ZcDqL5cN/3tFuLAln7RBEpPtFD32/sDmugDNCf9cnkP2pMSTAHe+H+2pJDL/M64Jt/W5
	 8jTexyzQbna8L9QNSC06SDU8nl2zKmZPXGZvnFLBE6HNpzTa/Yvo3D8IMope/M4lP9OFp
	 Mxn+3Dme9VhoXt3RskMFqriIN3vtoD92QncHtQF4hIjSSd0YVzUoJg3Djnk4lmD1vV66r
	 sXFm4Jh2FzAU1vlCDHzVEoGMdP1WFDOM4aiyhhcmtMYUfCd/Svrejj7uBlzE6QIIk2/Uk
	 eypNIbwa+s/t1CO5E+1K7NDQX3KhnE7mkMKjVbHkNck00veZqQ3wwBQ6dwUYOs6O5Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6MJQjP9oDBvvEA3BsS341GWfV+IdpaBmUA0FbQUZbp8=;
	b=2/Ql+fDQuVJ2qmM9F+AKCcbS4We9miEOMQAh5g8jyzG5duKxLNXCyqbZ0Jk3L7gLgS0A
	 CxupTEKtruNSrnAjOc0XrYW+Ads0MIWtJ2a7Am8B/HS1gF9M+MRcSS/4gLS9R8vO+uri/
	 XOH/tsM+B7UOdYGxZ868IZROpzBLxxDMmjy72JMwj2vuB2PKJbJB8hfmzGMlnNhR7owvI
	 LZIEBvcf7GLIEpTXi/4/OufHC0rf2OoLQYqjKkftx5fg9icgD2HzSoijek940hJIiCBIE
	 MZ1CTaxolI5NpPBpJzx5lCqwpxHI4v3cTnTc3WDncMf1DxLT2Wp2NwuupJHKENNtFBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1GY+OZE;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597F606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6597F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1GY+OZE
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so13529615e9.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793446784; x=1794051584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6MJQjP9oDBvvEA3BsS341GWfV+IdpaBmUA0FbQUZbp8=;
        b=S1GY+OZEHF/Z/y8/HUydj4GdFdz6+Dlkx98Pcmu1BZDLIO1IvsZA+lYRohOyGHvKMj
         uuTaSn1WQJ54BeV0GxrSJUD4F0l0esYW10AjCMfdJLy+2XnHCd9evllBiVz3Yo79IuB6
         apRlX9NfYnzn+tdS8OFWE2FN77qkXmLcifdTMpnkas/9dtyYCjAUoFflbFGUw/5DRbbb
         qcHP5pioLwcT3QhJJlWJIQiSkQcTXusBiKG9FtuqedvwWwj+xLtCngWMsYhvLbAnQHqr
         1rjSmIAqCthwpGaAbPotM69VK1OtNfK8HtN4vYaXjspYTtPfGn70KkYqfW2MqQuxQm48
         VcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793446784; x=1794051584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MJQjP9oDBvvEA3BsS341GWfV+IdpaBmUA0FbQUZbp8=;
        b=mSCITGb6aJgvuFhaohD/0ccHLOZOOS9zcuWGSanWIziWTK3oxxFBd90aLhgb1xlbZ1
         oY66TdEZrtK4t26No2PA2vZ7pEFKLWgi1V36rDCkutGJJP8JTHvG61WmnTcIbFJiLg9v
         hDEYFhi77GyiACFtGLEj9zV41wD02PKnbFALdJpxZ25/xV3K99VctwGT1VL7eN6hKWyt
         CJCaspZPgyGMWBZsRCei8t6nmNBDppq8HMrWP17ywHX6tscMmWA9ZylAKysk1ToY85ko
         o7aJufbkHh8CtY3AqiEVLtKPWYaajNV3vUzc6cJoYK0fW686OEeW/hyLEaWGLmxatN5E
         qNrw==
X-Gm-Message-State: AFq9FYLm/2Lrr8d3j3iXo03QiABN7p00l9QTYLed7eLYaVFjJVhCfUXx
	r50P2Vsngm61wKws24frukXpIUX5kl/VoIHzoSEPweqtnvl+EWn2ktAi7IlnDbRX
X-Gm-Gg: AYBFou14lQg57UtcjJ8aFYlH9ap15GIYb7O28rwe6QnxOQaaejWlJ44L8M7+d0xeIXo
	eSULDDo2T5uXNaCXD30+QscpwdNuEq70Y3Vdj+Ja+W/x8gQ0X0KSYduxLeNXFyBAuj46jWN9aPy
	J++pwVU1iajwM6/JE7+RyMUSUB9SHQUPx6nMkpcvK5dZCq+b3wNC8KQoegr4g8puVG+PXqeFUkR
	IwLLGrO/kx0konS2yuFqg3H+5dkpJfpO2sMYD3nQ/wmiZeIxqNQ0ftOhaFeS5AJ6x6UqCLc2hGb
	lhJUy0UlkSNwhO+O3CnES87VYC4hxT0FpkeVt3GfaSuhUTbVarWolAgbHxBzAF0gCHxyHzk0B8l
	k2Nbwx+yxGLEg+rZpNvmpq2zfvW6CgyqUvoz4SbZXoYoZe5pVlh/PsJDZGT6YVCw8jlCfbiRMsQ
	TJm/QAfiEppoeUCuBzwoWDXllVElb0BEUHQtfwRoPoyWJKdsq055DD1InjHnAGhWdOtvL9WYaxq
	hKp94J8LLMAYn3aLJUG9AqIDRdrwb+uVDrIciKdjMhFZlxIWHEUZqayOaYIiiqQiRDWgFSTHMRJ
	pr4fQwecLvR4c5s1BVzcqrfzpsXVSLTwSsMPBJBZUSjSIlfi8Z4d2vIGyMTYKA2a
X-Received: by 2002:a05:600c:4188:b0:4a2:d80:a044 with SMTP id 5b1f17b1804b1-4aa8a7ac714mr136908085e9.8.1793446783607;
        Sat, 31 Oct 2026 04:39:43 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm8345366f8f.23.2026.10.31.04.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:39:42 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Han Xin <hanxin.hx@alibaba-inc.com>,
	Han Xin <chiyutianyi@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>
Subject: [PATCH 0/4] use size_t when receiving and verifying packs
Date: Sat, 31 Oct 2026 12:39:34 +0100
Message-ID: <cover.1793446357.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the search for truncated sizes, this time focusing
on the side that receives and verifies packs: unpack-objects,
index-pack, and pack verification in git fsck. These components keep
object sizes as "unsigned long", while the underlying pack code already
uses size_t.

Each patch addresses a specific part of the pack pipeline:
 - 1/4 unpack-objects: on Windows, it dies when receiving an object of
   4GiB or more;
 - 2/4 index-pack write_compressed(): on all platforms ("unsigned int"),
   --fix-thin with a local base of 4GiB or more dies with "serious
   inflate inconsistency", verified by simulating at 16 bits;
 - 3/4 index-pack: on Windows, it triggers a false "SHA1 COLLISION
   FOUND" when the object already exists locally;
 - 4/4 pack-check: on Windows, "git fsck" checks a prefix of objects in
   packs.

These are all failures (die) or checks on a prefix; no corrupt data ends
up being written.

No tests are added, for the same reason as the object parsing series
(requiring 4GiB objects and 32-bit long platforms, or objects of 4GiB on
all platforms for 2/4).

This series closes the pack-verification boundary left open for
fsck_object() by the object parsing and checking series:
  https://lore.kernel.org/git/cover.1793444420.git.gitter.spiros@gmail.com/
It does not depend on other in-flight series and merges cleanly with
them. For the full effect on non-streamed objects in 1/4, the downstream
fsck_object() / parse_object_buffer() (from the series above) and
odb_write_object() (from v3 of "use size_t for a few more object and
buffer sizes") are needed as well:
  https://lore.kernel.org/git/cover.1793439137.git.gitter.spiros@gmail.com/
Pack-objects (delta search below core.bigFileThreshold) is left for a
later series.

Based on master 50fe5cc63f.

Elia Pinto (4):
  unpack-objects: use size_t for object sizes
  index-pack: use size_t in write_compressed()
  index-pack: use size_t for object sizes
  pack-check: use size_t for the size passed to verify callbacks

 builtin/fsck.c           |  2 +-
 builtin/index-pack.c     | 14 +++++++-------
 builtin/unpack-objects.c | 36 +++++++++++++++++-------------------
 odb.h                    |  2 +-
 pack.h                   |  2 +-
 5 files changed, 27 insertions(+), 29 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.53.0

