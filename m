Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0447375F69
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090268; cv=none; b=eA1GvEqGJffKDINgywqGmcZGhKX/Mfeh3ypY9RiLthySAFQOTai57W9yOquktqypZZyAXZLWqr1Udvf7L+kkFf94IAVotj8mGJMwqr8hKsW/YcJ5QPVqIsDBqvF1RbXjVqwRfx/mvOoLYZzgu5pKfapJ/ozXYp0+bDYKu1ttYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090268; c=relaxed/simple;
	bh=bNFfhnMIzypqNZARbZDjlgkkaw4R3QVNdFeTZ2xx+P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OplTZNIAgVKl07OrmFzDY/PMJj5wvTyqxBXSFjkrrlyjQIo8jbZscGIqqp945yPXb8FmC/+/fXimuaRD6JpjjOuKlVhMovx+MgOfIzHEOu10pYQAyWQQsR1Z5/PM3BiIDDRGiRtpxHUrydLuPBi23REZkivQfFNOR+N3id2H5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=Y2V0u+Xm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQOR9u8l; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="Y2V0u+Xm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQOR9u8l"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF9A014000E4;
	Fri,  3 Jul 2026 10:51:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 10:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1783090265; x=1783176665; bh=lBgzmmVQ7neLLJuuDEefA
	BnJwIHu/PEwKUVHjnW8gLs=; b=Y2V0u+XmYMLE3bkXQ6mhNZBLtua/lDur6Ptem
	b+uoLeiME6j1TJZ7nQPigjAEt2uxq5Cm2Pjk0weUUVoEpJWZnSRJO6afvH4lSnvU
	x5AOR9E39lfdjbJQMhB6qfWAcduUAbz91CyVYcYCyjKvlQUn8KqW6EPR+10TZW3F
	B1Ku57WJVIRSHvFR4lVxfC3+V5cqh31+qkRPuGjn7GJgZwT9hzZVhwMctShDWfL5
	o7RDLIqrc35M5cEsS7UmqYy9MVS3BHTKlxPabPRLQv5hFEFYLqHHHI8WVCsSeEPf
	YGAiLYUxrZBgseA8hfEgFrHm+5MGF9aDYb9wBvDkPGrGagcdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783090265; x=1783176665; bh=lBgzmmVQ7neLLJuuDEefABnJwIHu/PEwKUV
	HjnW8gLs=; b=TQOR9u8lH3WJ99uJZB3iN5QdCisDYNFRW6LCn84zc6fbA/byuXB
	blHKg654xXfpBQNNJx7EQO/ikzhNsy0EdgB3ss9eTE4AdCwDru4oSdnd6dWqFB+5
	GMNjQML8Wq+f2wrQCVEsdjuCrDZk9pRvLOvOk3aBskSc5s1uh5ekq/X+N+7nCNSy
	JmGZ3qBjMLLKGFxucLcIUDIP5qL+cp/TOQGLVDLAPXjG1p+qBhdPxFOUHk4e3Fr0
	jYGcpYlYEJQX2xXBxqdums4wzRGIYSan3QBODmUgMRfHNvbtw+zk06PMeROHwQ+O
	gNybMaewGfv8SXO/E2cHFg7yxaKnNA1c/8Q==
X-ME-Sender: <xms:WcxHakRnc6JxDWia_e_qER0n9F7nS89CzPS2_9_PVP9nHNvTSkZ8ag>
    <xme:WcxHaozQyGctvqBLjVGt2aAUjR1u6na559bKsnrYu6GtMq9hx0vAdNxw30RCjqXSQ
    -e_zmYq94EsZlBxRHDECeWwQKS5kyEytvoB-3lq5yX5001tbznFVw>
X-ME-Received: <xmr:WcxHam2h2LLHMN5KtJiPYRvdEIKBV4zI2_ALgy2h565lH0LLwHPFRGk90sTkZ_LzyOC8xXKzFbpXd5xspIWFjQS_B7CF0_vX8GytwOrM7wi0cw>
X-ME-Proxy-Cause: dmFkZTEc7hleSoWAUcQw2u9OvwH62GVmf41wVWFp/2UMvEr9QKtYuS5H1/lU2JI2Bk+GCH
    ohDvwV8FQ5JAj1nQrSSvfYqwNdId3CIbE23dshft1mktu7QyXENTwdsXUDmHC3w49LMdoc
    94KixlKU5T8h7xFwDvsMO495gr/ej2WklGQN4XR1bUkJYkF9pi7clpv5TqeQfG5CIVxYmU
    TmuWvms9iS8V9K/jOFBA0M2/beFAo45sUQwEfJO1PtKel4tJXyVQ0VpMgZXVfi5E6FJdTI
    y6nSQ8zelw/W+710mJ4r+hK5kjNTq8EDRUVOBqEj2QLa+QQWHudUtG8BGD7D9qWACq0Wsd
    ZpE29CZXvFRP7xA/mykusS0lEt8Jqu53MqqCcbtEIf/279rmzS8Ni5Urxf27i0W3U6Bn/3
    CokQJaCHfKPD/ectr2JMqYeFrnfa5kF1HFVCZX83no6mKYBGHwvJg5fEmHuiMPuAceHFS4
    3l4QOJJC+2POXEIH1Gf1ulG/0quSIAH2sCXylOmKh49LZM7AfXWECEhYjh+CZ4/zWcmsQU
    rro7TXnIjYGZKxZ/4PL/5uOb70CjFcF6TztBgbWyNLjoUDsC+FqYWQfX4oawD34WZYzllV
    X4gWji223PBTn2bYnx8Ry5EAEIrQGbhtNCuGDD2z68X25rXDW1+o1F9CXAJw
X-ME-Proxy: <xmx:WcxHam634PYsXzA9N_JzmnI5t5_JiTIVpvpEzrMeDBNdB37xf58qpg>
    <xmx:WcxHapUjJC2b3B4giKDJcnZDhWSoq2kSa5_w3GzNtxVta815FRBK_w>
    <xmx:WcxHalBSTQKvvXcKRO05nUZFQpO68WdnhuJ3pmi5MuABij5OhSltbw>
    <xmx:WcxHao7_ijz5Fnha0xRrtvsWHi7I10GlNWh9Fwfeo71PR43tc3PFxw>
    <xmx:WcxHaldQjB0OR90_KtG5cgnC_gQKO9kCKzPQ0oHL3fGXSaUXX8J2mGFi>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 10:51:04 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH 0/3] history: sign rewritten commits
Date: Fri,  3 Jul 2026 23:50:34 +0900
Message-ID: <20260703145037.69832-1-git@5ouma.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates `git history fixup`, `reword`, and `split` to honor `commit.gpgsign` as well as the `-S/--gpg-sign` and `--no-gpg-sign` options.
It adds regression tests that cover configuration-driven signing, command-line overrides, and the handling of replayed descendant commits.
Finally, it updates the history documentation to describe the new signing behavior and available options.

Souma (3):
  builtin/history: sign rewritten commits
  doc: document history signing options
  t345x: cover signed history rewrites

 Documentation/git-history.adoc | 14 ++++--
 builtin/history.c              | 80 ++++++++++++++++++++++++++--------
 replay.c                       | 13 +++---
 replay.h                       |  6 +++
 t/t3451-history-reword.sh      | 39 +++++++++++++++++
 t/t3452-history-split.sh       | 44 +++++++++++++++++++
 t/t3453-history-fixup.sh       | 39 +++++++++++++++++
 7 files changed, 209 insertions(+), 26 deletions(-)

-- 
2.55.0

