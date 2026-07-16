Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981503B47F3
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188383; cv=none; b=MFb6EqQ+d1H1WOKKzKxxWhUuzZSwR45/z0L/6qVNCR8fttU7+6KJ6CRjiiRY6Q1DbQD75volObromx75UA0uUslMVdDOe/WGah0e/XL9VgVtbdLpN0uBjPzj3533IYp8Y/BkQFM70GJvUD/sk4/c96qaSZU8sjJ9KCFDzB4nk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188383; c=relaxed/simple;
	bh=cGZOcKhEqweKZk5Dp3qLrYapDyOmctCEiLRxXnT45OY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mtDqwu7/kuA35ou5Q+Q22ESHgk2XztC50d3sz2Z/2p2CzUEKDJQ6/4zSJP6U3uVpVMdkKb1p3bAef4cAXepPxThkEnK7e5idlSqngM+MclcUN1qTSk9/KnBfA1rT+WPcFyMc0UsPrNzoet0wqCk3Jpi+wXxPMT+nWSmAv6De5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eqX+nWXa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rZ5JrHbo; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eqX+nWXa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZ5JrHbo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D1217A0156;
	Thu, 16 Jul 2026 03:52:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 03:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1784188358; x=1784274758; bh=BBzmuFknJ/
	w55U8iQ6vZclocQBioT/TCpBRivLjkubo=; b=eqX+nWXaCzofvaUlomq3JgWHqk
	hzbZQkXMCRUz/STKgwxoaF0TSlyjTinMDAUP9lie4QhdyyeHpX+ndyq6gPwFjx9t
	tFMVpu043MEhshmaadZOQ2Zj69SUX0NL2xok/IMCOXKLz3UORo5sUq8r7n+ClMJ7
	is+S2XJAkE9j9gYsPqMoIWflkrUPgsJqKia1GefRmvP98sWC1Va7PxjYFNiWSvAO
	A3V7IBtprQu++QLEquSTBSH9rX0Jo1EOduBtNfJ12uyPRmHaxrpb/THhNoWCUU6y
	pd4TNtykyproAP1p6x3HBvC2TdPz5aUMHjXd08FSh0ZZhpGABYBlGLMTkhYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784188358; x=1784274758; bh=BBzmuFknJ/w55U8iQ6vZclocQBio
	T/TCpBRivLjkubo=; b=rZ5JrHbomM2AGtkuaLhMePG+PpMfp6PyUFuEikhhBSJO
	UwvbmN8ezeVsIfKfEPFPdVutWkiGAKDW0lJfeYAI4VSNlG+tDuNJk59mJ5PcDo1z
	In59DRgcjH8CaNdw/TOO5pdiyGqvm39t0If07Z9r9u+V7PLCXdxOwuSxCkoQqkj0
	kujhw0FiVMfdV/+EAgUApNiWv8jFoWln3Ra+0ZudvcHJFePpJCYnZgtOf8ansAUi
	q84plkUinKFlTowOIP5bUCeHV7TceIRShoGdIFYsgye5SIJuJZeZnTYkZWEVNC1K
	a3dmtsJXxkGfdJiB8I/ItiJaRhLh8cvc6m8dcMl2VQ==
X-ME-Sender: <xms:xY1YalcloFva5tXyPpEYuC7C2Vsgt-hh_EuFc22LNTnH_t93m-C8Pg>
    <xme:xY1YatMt2Tc8CuL0dHELkKqCpXOBQnc3vUlv4wAxzaQAm2HW70DpI2Szfd7igVGLU
    IHDOmZj1OL7whawHXh8yZQnKi46G7g8zsDlDdjUB8VZ9i6inWeb>
X-ME-Received: <xmr:xY1YalKjZkdIh12CYUN09K9vqUxb8wAJ-i3iagNbJqD2xQZArLVVwxMHnC9QSmjzPWQUl9c-OQjmCiYFpZctBuqvj-i03WKwnHHP-mol>
X-ME-Proxy-Cause: dmFkZTGCexS5AaiOwERS/sOOFyW+Ud3+nyPxsrGDEDwMQxndTwnofuOYpyu3Utqu2nyP2E
    o0eSMkAn2/0vy9yHaTTGFSah/NgKCURlXkAENbjUj8W6IEwgWRSg5BoGafnqhkIZDst9Rb
    EGyd34CPKHPc6toLwadAJeK7HDJBDR7Zm2EEFuUVOJiZRK7EY6zPR8DvYQIFZI85Ee5xWN
    I4K7L5gglOk9+LvXJRFVREDo6u3sd7biUvlPfk7Ke/BrXRjSjehJfVdcCVbpnTyFb2PTcg
    XzSmarviyqMYAUjeRnSXjybgDIFJfIPqx44RX5rEXbxMvgCAK+oA0E0gL711nrxIDvPcWW
    aNck8AgB0zCGhidGe5deXEYk4pGq52UiIisI2+Z7jAXsc6aZmunBlMauExOtNBDNuyWbRm
    M0zv/4FEPqjRiIAjoBC0Hp84K9hBGuUcY66S9YX1vPpKXkSOkDk8Y2Gyc9rTbxW83YEwoM
    nW7Ld2ong1jHFhDkHI7HBb9T7QLI0cqJF5bMFdqbBGPIO+T89FKLkAe5z3dxMnjmZlicDN
    H6tlAgmTBs5eEoXBCwu9xs9wfWhMsOQQUZxD+MVnhQyN7SWa4frNF7iWvxsi2fxQYWoCHL
    w6hU2ARcA9nMx1W/0yfP7nsPMCH62gDMeGTGnqvj3YsNax2KZTqfvdBaUekQ
X-ME-Proxy: <xmx:xY1YatIzvynH_aDOH62_9AK_2psg1z7SqcB4KpbfdiklmP66jIapgw>
    <xmx:xY1Yav4MU_MaMKc3AEHu63g9i-SP8QNLC4yJDrGoINYABNF0f09d3A>
    <xmx:xY1Yanec5KgVLmV2dNgjPb1jR0K-E1lfLPyQi82gtHYshxk5jbOqhQ>
    <xmx:xY1YaqFdu0SUbi0K55z1JRmQp3ncq0qZqBxFh0PD89nFjr4a3b5y5Q>
    <xmx:xo1YaqtLVUWGMzHynjr-zG6NeBKXtoHAegiEq3fecXEz_PReS8ODdKRP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 03:52:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9ad409ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 07:52:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] Reintroduce writev(3p)
Date: Thu, 16 Jul 2026 09:52:18 +0200
Message-Id: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTsJNArqVQwLbX9gNClkpqAJ4
 e5WWX6L91YyqMDoWqykWMRkjBnVoSA/3GMPlpBNrnR12VRHnl7GColJxzB78FslYWEXzl2DkwN
 woRxPik4+//Gt3W3z4wmffjfati8r/viKegAAAA==
X-Change-ID: 20260714-pks-reintroduce-writev-2d8f7e52eee9
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Hi,

this patch series reintroduces the writev(3p) wrapper. This wrapper was
originally introduced as part of Git 2.54 [1], but was ejected due to
issues on NonStop [2].

This patch series here revives the effort with a couple of fixes on top:

  - It picks Dscho's fix for CMake [3].

  - It picks a fix for NonStop [4] and polishes it a bit.

  - It adapts one more site to demonstrate that its usefulness is not
    limited to a single callsite, only.

Furthermore, I have included benchmarks now that demonstrate the
benefits to make this series a bit more appealing. Ultimately, I'd be
fine if we say we rather don't want to go this way though. I merely
wanted to tie some loose ends that I left dangling.

That, and it's nice to not work on pluggable object databases once in a
while.

Thanks!

Patrick

[1]: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
[2]: <028901dcc859$d2419470$76c4bd50$@nexbridge.com>
[3]: <pull.2078.git.1775206502134.gitgitgadget@gmail.com>
[4]: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>

---
Patrick Steinhardt (5):
      compat/posix: introduce writev(3p) wrapper
      wrapper: introduce writev(3p) wrappers
      wrapper: properly handle MAX_IO_SIZE in writev(3p)
      sideband: use writev(3p) to send pktlines
      fast-import: use writev(3p) to send cat-blob responses

 Makefile                            |  4 ++
 builtin/fast-import.c               | 18 +++++++--
 compat/posix.h                      | 14 +++++++
 compat/writev.c                     | 44 +++++++++++++++++++++
 config.mak.uname                    |  2 +
 contrib/buildsystems/CMakeLists.txt |  6 ++-
 meson.build                         |  1 +
 sideband.c                          | 14 +++++--
 wrapper.c                           | 78 +++++++++++++++++++++++++++++++++++++
 wrapper.h                           | 10 +++++
 write-or-die.c                      |  8 ++++
 write-or-die.h                      |  1 +
 12 files changed, 193 insertions(+), 7 deletions(-)


---
base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
change-id: 20260714-pks-reintroduce-writev-2d8f7e52eee9

