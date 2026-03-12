Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABFC3E63A7
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332425; cv=none; b=l1M1d6zn+0QtElm5sRoRaBSNrAdK7guS+AAPK94xvfOcAsbG4Sij92V1bYLVchD+ReM1Hlc0lUrmUblXhN5qLYSK5AIKf74ZkjdG9i9WYwSdiI/dAWI9DFoSkeJEW4dNWcRJLk/KrbCyVbz6pVBpHbx+nKONBFthC3Pd2O1Brpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332425; c=relaxed/simple;
	bh=OjjieivabQf4wLEFdY+m+9P8VeDQ0uVlvlsNaOFk7Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXU3g4RnBrPg39cW4BPrFslKUegYMQmTQYilHczFKO2ZPpx0yJ4faPydxW8MRfKOmAYGeaKsr8SsKN5gEjs2a9A4GG8XzcfjUvFYFLeoYtFjEaXzvuQpk+4x/RN7mYaDOexFXfhB2/2y0Qq+corDCXP8mwkxGVBUi+b1vLB6p+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=KlPkUG58; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="KlPkUG58"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773332415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9TNoeldQFEKW/tL1x+/Mdc4sqUzXgtHdrGCPypsTLw=;
	b=KlPkUG58dnpaL3sZ0UcEZ0003plAMfQ7npeEkqFBeoGbHM1e2FEIX7UOyAnceS0eWgoGSR
	yJQ82ae3EZnMSbETRV9SXgChtntTRgtYWWj6SWdHIB3umbePC7taQ1DwGjb8ghZ1VCn9eD
	hLC5OJV+MDTY/0xiXLn3qqlNrApbrFTfpqVwx8dAtaqJsniOg9j8/D62fNITAkIPDfxuA2
	PkbMLCUnEXL+QWl6sV+T4yuOkzJOdjnxljx5V+uYujQSTzFWf6dHTx+1Yv2q2Q3sEjXjVt
	w4VWctCTpvfx5mItZiXXi42fmUr/UejuJXWiq2W6SJI959WGDYj/5GL2vTTAqA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v8 0/4] format-patch: add cover-letter-format option
Date: Thu, 12 Mar 2026 17:20:07 +0100
Message-ID: <cover.1773331753.git.mroik@delayed.space>
In-Reply-To: <cover.1772839973.git.mroik@delayed.space>
References: <cover.1772839973.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

Squashed the documentation changes to their relevant patch and added a
new format preset "chronological".

Thank you for the reviews

[1/4] format-patch: move cover letter summary generation (Mirko Faina)
[2/4] format-patch: add ability to use alt cover format (Mirko Faina)
[3/4] format-patch: add "chronological" format for cover (Mirko Faina)
[4/4] format-patch: add commitListFormat config (Mirko Faina)

 Documentation/config/format.adoc    |   5 ++
 Documentation/git-format-patch.adoc |  12 +++
 builtin/log.c                       |  82 ++++++++++++++----
 pretty.c                            |  15 ++++
 t/t4014-format-patch.sh             | 126 ++++++++++++++++++++++++++++
 t/t9902-completion.sh               |   1 +
 6 files changed, 227 insertions(+), 14 deletions(-)

-- 
2.53.0.904.g2727be2e99

