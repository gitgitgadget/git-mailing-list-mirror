Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE621772A
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886262; cv=none; b=svSC94F97TtpZkkrjoGao8+8khNSGKfkemtpywJb0GqJ0eUoUknlN65WWGiNR64QcibigaA3C6PJY8tTlDtKmG/U0VQ+OJJZt6sRCJQ6bTmFegqe4QLsj+B6xalevWr7vz7WX8bcQ94Ua7b5na/IqdhAD81RhJldcBCRwiAi7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886262; c=relaxed/simple;
	bh=igIP4kOBBUyahq9/CjdXpZLbibUtnIDJSkOgTkg/PaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9YGOPoNTKkW/2KHYzr4QT0ZP04G0en7kWB8YKEzEsrq9OGbkVJyeU75WCXoEasPRMBzfUuKKXSQ4bF9p8af2Ou75jeYppgWe52xogp/WpOuxYs04xV4x1rMMyd4LNZK1pOV1uWUPGbpQisrXKNX554xb7K7m3XvnuculUJ/PZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz; spf=pass smtp.mailfrom=michael.lyo.nz; dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b=z0WBtvc8; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b="z0WBtvc8"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dn84X1b21z9skH;
	Thu,  8 Jan 2026 16:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michael.lyo.nz;
	s=MBO0001; t=1767886252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eI5Q3gpaIEy6OPlIVXu34sKEEgx6XWuMxR3b7h4BLo=;
	b=z0WBtvc8WIxhmGPyNttSeOctiJ59aJESLt2E+kqFt6NLJgjdR8+JkwXNGsP3tvjBwY7B8R
	TYmF8fFxau+edrLqWjLrJguofoTY1uxsz7Z68W8wDjf9sBBl/3mQnZ8dDvKON4HRhaviqw
	PBc0e4uovh+MtGJqfxVA1IVVyv3raFJBQJv3n0FhrMUMvj4l0M29FXc17nkDgbiHXVKQkL
	2mM5oIi/Km4rNK8sDkcLUEDpUU91kiD0Qt2itrko0GUGKBK3sdDrjXobezPSn8M+QqDUM5
	gFidRkFD6YrabFMiG85ZAs4usyIzldzAHvEJup9J+YXQ7ip3xrVuZON/OBVNCw==
From: Michael Lyons <git@michael.lyo.nz>
To: git@vger.kernel.org
Cc: Michael Lyons <git@michael.lyo.nz>
Subject: [PATCH v2 0/2] doc: git-blame: convert blame to new doc format
Date: Thu,  8 Jan 2026 10:30:19 -0500
Message-ID: <20260108153039.658217-1-git@michael.lyo.nz>
In-Reply-To: <20260105230220.519303-1-git@michael.lyo.nz>
References: <20260105230220.519303-1-git@michael.lyo.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split and updated with JN's suggestions.

I tweaked the `--progress` documentation a bit more than requested. It was
hard to write grammatical English that didn't imply something incorrect.

Michael Lyons (2):
  doc: blame-options: convert to new doc format
  doc: git-blame: convert to new doc format

 Documentation/blame-options.adoc | 120 +++++++++++++++----------------
 Documentation/git-blame.adoc     |  72 ++++++++++---------
 2 files changed, 97 insertions(+), 95 deletions(-)

-- 
2.47.3

