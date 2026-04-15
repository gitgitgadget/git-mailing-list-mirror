Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0372627
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278851; cv=none; b=cwsUJDylS1cSX1LUeI1J4/w2oXbldGc2gPOtkSCWdbSCIw+4bhTvacNPNcrPFwkMk0KV/nVXUqk8DsRtnwVrnTZH1RVW7icBUutdFyxYnHlp/57qYZGMP7Hgs3dSvZOdRz1/PffFnCYanlYOSoeIsAkhQArcEudhnTa2A8YBQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278851; c=relaxed/simple;
	bh=3dZY5gicmhId2pPnZ1kU7bNGz/thL9YOwoF8wyY8vRM=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=lFEXJsw3KysoIa4fOmBoZc/eaIbzPCAXtase3KavmwCqw1d1S+2XquMjjhh8yHT6q3yrmXBk/81qrpFy8czDLmWfQ0xyyf/D89nrYYADZNa4jtFpzuW2ya4NNA1/PuQdWqq0IyOxsZ2shbVmSbeNc3eD8oX3EyXMHh6gYAx/Bmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=Y1ISuo2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u8zo8gl8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="Y1ISuo2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u8zo8gl8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DDF38EC0287
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 14:47:28 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Wed, 15 Apr 2026 14:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1776278848; x=1776365248; bh=dLFzPCBFAj
	pr4xgBx/sXQ/KQ2t4TQcqdIhHlkR77y8o=; b=Y1ISuo2X0gT8PWchNHMxDqBwqN
	3bGLUYS65zZ3NDeUpOsa7igG6HTrKI3wElmJG2+69kcFEWk0wPr6hMnwAXxnsrr4
	E2r9R0kjvQLdMLYRM4P+0y8sv5tSMs5rjghexyTx1SM0rTZfVZxtf4hsxbsMkwtu
	Hmy5glNB+qRMIAIcfR5vOjK0AXADSWWOwQjdHQwPea0RcOwxT0WEIgqpkNn3CXDY
	dZv1hIySLf3jgRUcrduFpMc8n/u58vFo/70L/mCkcWD5KROhrNuUCh6EOpPHgmH+
	ZLx7rXNpkYgepTqj5tmfqUOLcQz90ho4WBUOL/nHhaXCPbTrnyv0Bkx8Vhug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776278848; x=1776365248; bh=dLFzPCBFAjpr4xgBx/sXQ/KQ2t4TQcqdIhH
	lkR77y8o=; b=u8zo8gl8M6UqwUATEK1B5FqAJeaPc2BqtYBTCePcQwqBjXMqzh1
	tp7Y4CJ9NcMzB+BGzLHj0ja8/5H+n6wqMlv7gSaFRxMVLWANAkEM805/LUpV1dKK
	dDFfDi5xKi0chmorcbEPQYY06ZKwu8ovC6KOTbDP+5oKdYrQY4nzBVEDvptWIDXC
	k9HlAqHZsElAMEy+vmgYXopqMfykvC8z4fBTiOoVZ1BVHFa4bxkthgVQDyVqEx+4
	QrEgOsv6OlXNaOz5ZZd6b6bwSWg706QmiTLVWXlNOrpM4C2/jpaaEF+2bOlhY6YN
	tk/+KitbJWA2JSK4TbS5MEd0Mv4Wh3a6t1g==
X-ME-Sender: <xms:QN3fafDLLef8E6LKaGV4F_HXEI1XDpArOUhURBMEmAAwSOIEziq2uQ>
    <xme:QN3faQVJiJBqSNwtoinRBkTdLyPMs0YtxOqYRbkJInL4zMmXAyJvJotUvfuJV55Gl
    YDx7kacbo8BkhPSWe6KdPGkF7I3qNAm1X2k_nxr7UE3Lb2cdcgTGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvf
    fkufgtgfesthejredtredttdenucfhrhhomhepfdfuihifvghiucgkhhgrnhhgfdcuoeho
    shhssehfohhurhguihhmrdighiiiqeenucggtffrrghtthgvrhhnpeduudehkeejteehgf
    ekgeekvdevteeiffevgffhueejgefhieegkeffjeeiudehueenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoshhssehfohhurhguihhmrdighi
    iipdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QN3faURkF7ILmIjry6aml-VZRnUIXIg-DHIFlYfhyH6HnqUTzhCmjg>
    <xmx:QN3faRtKMKeVyqIxbdGE3rmy6OBxQyi642TnyRmOnqrNTMk-v6ZTVg>
    <xmx:QN3faevELO6Q5Fdw6_1ptqzSDcTFes6Y2RpBGY_UPJIX5NIsojfwVw>
    <xmx:QN3fafzmSbYScZm8WWIncNAYS44SrzTEtL3XTOp2GNeKXJnWkKiU_Q>
    <xmx:QN3faWl_FlTLe8UjdrugXDha8aLmZvqe5fIY_86-R5ly4-KLIcg1Hp1L>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B937D1060065; Wed, 15 Apr 2026 14:47:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Apr 2026 14:46:39 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: git@vger.kernel.org
Message-Id: <818da18e-f928-4473-8a37-28a737dbb261@app.fastmail.com>
Subject: [BUG] git-send-email hangs when sendemail.suppresscc is set without
 sendemail.confirm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

When sendemail.suppresscc is configured (e.g., suppresscc=bodycc) but
sendemail.confirm is not explicitly set, git-send-email hangs
indefinitely after processing the patch headers.

Steps to reproduce:
 
    git config sendemail.suppresscc bodycc
    # Ensure sendemail.confirm is NOT set
    git config --unset sendemail.confirm
    git send-email --to="someone@example.com" HEAD^
 
Expected: email is sent (or a confirmation prompt appears)
Actual: process hangs indefinitely after printing "Adding cc:" lines
 
Workaround: explicitly set sendemail.confirm:
 
    git config sendemail.confirm always
 
Tested with git 2.53.0

Best,
Siwei
