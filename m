Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE9317160
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214893; cv=none; b=mHR2Iu1DuugaWGyxvvMcprx5+8PT7ic7mYpREwsbz7mFzFUMN6rA+x+pZQYYnTiazXIw1eS1YMuo8I6kvx216rSOGgB+B0Aaq6hif12ECPeyBzkobsJd39MBv06HwA/aVYNITy7X00LHmNiBHwV1ybsxaI1KtT2gL/iD8gpoWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214893; c=relaxed/simple;
	bh=xbUUfrYZ3ia2gwXycu5H8TiQGu9kQ6PdxDhTOdwCHUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/wrAN3fNYobdjyFTEjnDHFmKsMI+z0FwlLc1riQ1rgzangFBu3bJmwrPZDrlWBN4nKR3Xi1HEE1MHdTbYf3152fVeP2r2VdFQyFwpOQ7XQC0bYZfJjT0sG3ft0vAkx6EFKF8f5RdtxyZRm/VG+3kGbmlDhRsQCjFu/NE21/7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=M7Vdpjiz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="M7Vdpjiz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1775214889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulZYmGmwlm3Tk9w49D+WR73w/NZ/XdTZYCYcalPGAco=;
	b=M7VdpjizFSl7ZXB8aB4iDTnxS3BZsvu2ewPxvTxhJ1UA5joa1PZ9msBusJxgGaG2+5LP61
	8CMaP4O5IBabWCzIuGifGDuWQKXJPMvEAU8+RtU04JlY9j4OcTn4dBTXdzGOr3BN5xlC7J
	1RMGwW9loSEoi8jJ+y/dwz+4MfZf0TE=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v2 0/12] fixing the remainder of the C23 strchr warnings
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260402041433.GA3501120@coredump.intra.peff.net>
Date: Fri, 03 Apr 2026 13:14:43 +0200
Message-ID: <87cy0g5m8s.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> And here's a v2 with some minor changes based on review of round 1:

Thanks for all these fixes. On top of the fixes you've made that are
already in `next`, this makes my compiler and me happy.

I've posted one nit about indenting, but other than that, all looks good
to me.

-- 
Cheers,
Toon
