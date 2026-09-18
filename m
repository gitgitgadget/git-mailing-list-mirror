Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F340F731
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751935; cv=none; b=loqV+LDBVRk5dy9NX29LBiDKNYRf7QghVkdiE9Bl3J1SC8NRDa3jClzzZAibsKHrIr4STvFG+6zGanNIIq1Pmk8bCk5hJqgL8/sDt+Usm4VAGFBkY54//cZaNBfN1Nw7EGQmv0lnvML1y4Og803ZeFXfZ5KRLlC3gzPIVWdghnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751935; c=relaxed/simple;
	bh=+cmLHVIDlyGui2rpMngz4xyVYMTI029KiMzmyz1kFIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rebScOvclanjMQjEFMWmFa1FBstI0w0ukMasOrA2ij7YNfOoM0Xg8G+xjSnBV4KxKe8Izg9hs8jBX3vxi42mybFg9uYRBS9nibOCECTpZBuL1eoxg1ymsveNvTaYYNory0CiHzre1T9QRmrDChRxT3upQkRX/ZboVym18lgLNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GY+bOPiU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVKWr0+E; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GY+bOPiU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVKWr0+E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id B31C71300278;
	Fri, 18 Sep 2026 13:18:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 18 Sep 2026 13:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1789751932; x=1789755532; bh=WmPY3ZA83iGpyHP1ntooP
	yVpKxJDONdDbTCmF9ZIiz0=; b=GY+bOPiU0gUBXWyybtUVzbvCgTZw56MscOuKP
	5QYDP4cWlHWUSMjjIXmELHiW2y2PdZ8GQw7sSK/3g8lcKDb4arHWtPLe9kffSD8H
	ttd6kqVYHQflVFirvFooRK7f7Ftn8w2oTGOdCFaWPEKGUhO8lHW7k7jEgxjsR1r7
	dKfnnaBS/rpyWCfqlT18zYudp+5hKxJXjZM9g0IuwBWLRvZ/7hYAwh3g+gkvLpj7
	tAxkuBq/jdbVmOiDMjaM13+gkt5N89IWjkNjFIBVNvYugQIWNxxHataQiO5qZsLj
	rrnkA5Y4VDC0/Z+BWy0gjSiKhcU30T0VfzwCHYsGwgtMn4SeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789751932; x=1789755532; bh=WmPY3ZA83iGpyHP1ntooPyVpKxJDONdDbTC
	mF9ZIiz0=; b=VVKWr0+EvW0+JUBY+R16g9U3Kh0vI5FMbrJTp9RN7HaVBieTMeu
	lQQngRquGjM930SnzV04dcxDAnzY6zDZkKSlQ2NqxrX1RTuCJa6HKsGKlP1YwT2y
	nCriwUaT80mep/7RkUepi/Lt4/KbfIg/aO59nAeMByLxfmJlay2zufKFnw2nShsi
	mx2c+nvS24tslfeCvGkyOO/HAtVx6FgnVRtD/Uj28JSblwLQ+CT7KYP76VVZuZ89
	+FjbJQF2pH/FVyzcoLZpy5Yr7oOpIJlz8uKbEmr8ToslS7LX3EpXJPoDKsbLSZWr
	vBXh0UDvjDf7UxiF5ErXKZwkh9U09gX3iTA==
X-ME-Sender: <xms:fHKtakS_o6TgKRQ79FAIlW5yLCVqPknN85vt024BXPao9pCaR-vK7Q>
    <xme:fHKtanwn01q21v1BO5T9mCnw8ypjHzmrC_oo6OaE5Mr5PgwZWfNj9PT9CSgzgmJQT
    bB-NpY6f-MRPVKgSyZxyuNDE_Vn4WO7Zf4kBuXsqAobphiEFUf83Ebv>
X-ME-Received: <xmr:fHKtavct-oM74bQ5Xci_k9c4LOw0B70wS9XKLh2gvTPvmLWuf1X5AhE9ITCRtirqDYWsfrFGU8lKBV7kL2C1_T1KXCSZWh4an2aPjD3M2-9R4g>
X-ME-Proxy-Cause: dmFkZTEXecHJPnjFu4a40XDknUzAv1akGwgHDr82DYIQxZ4y+t3vzvmf0NawMlHjeFPIt/
    8n5smIxmLKdI5RX+KQhf0unOTgI61fUVc2Dl/6cBuUyhJMWXIhh9PzJrz/Jxqp4XIROwtc
    Hy2cWztoB3dA0NLqjti+625UfBLnBxvEv73I9oI/0gQ1PYW4XxwIDWkj0ndqxMIJU2B8nW
    XiV66dvwe2ujdVV2IIozKkZkBC3h5z0oB5AJcmi+etJ6heRvIF1iNBFP2mLZY4dOHnXNlv
    TP3JVH5UKTMDB4MKvZbsi0KeX0pPAhyE7qAbOUmCL2CwymmedZojz56QwPpE/BVpDF9jf2
    yTuk+SvXXvOktM55XTMhSUMt9kqFzYXLazyINizgkg3zMdB/Z9VSZqeWhkKDiCiUtfaavr
    6DoYbWAtY8ffdjn/KrAfgVXPCeUHoFhjZZZWun31rpO5p7m86WavHDG68gPYOqYVrB1nkK
    ASJQl8DOijj7S1DaFLVpRjDOlBuI0eRJLfuEcGfh4ushCqO31qH0+yFyGg5GENgrjXdfZd
    GPYkhtArW+K85RwN9Py7dhzwcIf66XnPGpsafG4ktyu6Ku6PjGaMTzSXeGG+sUkDQOwmhU
    Y/nSEhPLgSq5linLcOWr8HR/0zmuX5Lm6jm/mb7lEpUPMr+RThUhEEDlWNoQ
X-ME-Proxy: <xmx:fHKtajLFX7Dz4-D8NtUunZHMlie4PnD1dqtMi2GV7SGsVtuio7FFpg>
    <xmx:fHKtagFg0DMKCLaC-lv8d8omEKq3d7fBR-eMIrUOPvjp8d3gkyg_PA>
    <xmx:fHKtatqxfUL3Z6WfoDGr6jc3CGzMlEf1tALKUdl57JrB6Tj7TWNAfg>
    <xmx:fHKtapRI2xnUrKy5_hk1r7iBK2tb4CNFvveKOqf3RJkjQAUGrBcz1g>
    <xmx:fHKtanObP0BacyIhzaFGkOQDA8eMsmNXBPteCntqCkg3NBk-8NA-Z6o3>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 13:18:52 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v4 0/3] t40*: modernize
Date: Fri, 18 Sep 2026 13:18:44 -0400
Message-ID: <20260918171847.2670739-1-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
- use a "test_expect_success 'setup'" instead of setup functions
- make capitalization in test assertions consistent.
- improve naming of rename tests.
- make all indentations use tabs correctly.

- Link to v3: https://lore.kernel.org/all/20260917195436.1102981-1-markchucarroll@fastmail.com/

Changes in v3:
- Correct cover letter and commit message issues.

- Link to v2: https://lore.kernel.org/all/20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com/

Changes in v2:
- Merged setups into main test bodies.
- Removed unnecessary echos.
- Cleaned up here-docs.
- Updated names to modern style.

- Link to v1: https://patch.msgid.link/20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com


Mark C. Chu-Carroll (3):
  t4001: modernize
  t4009: modernize
  t4010: modernize

 t/t4001-diff-rename.sh   |  94 ++++++++++++--------------
 t/t4009-diff-rename-4.sh | 142 +++++++++++++++++++--------------------
 t/t4010-diff-pathspec.sh | 120 ++++++++++++++++-----------------
 3 files changed, 169 insertions(+), 187 deletions(-)

-- 
2.53.0

