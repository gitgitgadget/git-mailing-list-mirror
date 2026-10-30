Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384722;
	b=pRmBdN1SVEK7Z+23qa4zXW6gOiLDkKI36c5w+HbXggovseaqasZ+GQCuDbB3UBCdTUSV
	 Cv3+/0xBw9TclCEP8LBpEyLDrU7a2wUd+umYltp3vEETroxmsqqQfOXZHHR1NhHCaRARy
	 RmcM1heZXKHADQvff425kjONMUvfpjOUZ63MXwMT7T0h+K0ywFnz+sPuIVkVpmpBI/2Af
	 KpjaN8/B+soi3sbaoz7gfguASNjNt13QRk3FdLU5M/oImDVZbANaP2PlR6L7Q5vENt8va
	 PaW6nloEMkdszWyzQLKLLbP1vxqPV2kM7bxiQBdNwd6XSk/XAEN/OIO+6d9ndlAk6kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384722;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=0ajyydwI0JxIJI4yoPaXOVmb2GKjAGyECOtsyHJbH2E=;
	b=YMWrX6kJ3iFGhHyE/9lQ1RFWd9uhrz3KYl3/+OhvnMkNffo/LzsIKMFCGc2RmW366zcA
	 ii4etV0NrFGTOyAIvtmhv2phWEGFiaQH7ZArlKSyX5MNNa5+vlpZplPknipfS9GN4HayP
	 xoZRkeVztL1/oJvG7PcOeoylkNR4DXit6Zz7YuAbKKZoD0VvLpYrOuIiXYkLM5Q118uyo
	 RDi+L7Bkigl2MyP+2re5UYiPqee68SpOzyWY4IYdsB1b5ew/7gZ2okWTBah3XmIlmFspZ
	 C416QqkXFHR/NJPftrojO+CvDsoR2VQ97Evrdh2HsedTzRR5qJYx+6l7ttj9gX8Aq3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=DPn19con;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743BC606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 18:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 743BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=DPn19con
Received: (qmail 49297 invoked by uid 106); 30 Oct 2026 18:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=xJRySd2VCI5tQDhFAI/xPy7RpvSBdm64QzqYxWUxMZE=; b=DPn19conEt+w6MFXoRUvtHk6WDzug+TfrvpHEaMusDeWI6BuWgBS7n8NxUu3omK0YHwlvFG3WhEZleYZ2mAssG+8q3E1rprhOjXAVt3Lds7y7IcwPlSLTMRoCGt3nHqxHD35HcTTl7RivSN+ForoB9l2cHY9Fn3gWgyp9aQ94gAihkPX5vHDUzCJd/OwN5WQhznLNW1oWsJKZg2pdcW48pNjlVF9xyW1CG5LGeOuBaFSOLlBIqPvW8R4/BInVmqPlF7GQOycNuisIb1rO8HqxkRZEVqm2WmhMk5jTY4TOQLKki/4awVLfYpibRABcp2eBeb0ApP/kYSMYW1ainKRrg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2026 18:25:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 323533 invoked by uid 111); 30 Oct 2026 18:25:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2026 14:25:19 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 Oct 2026 14:25:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] read-cache: hide refresh_cache_entry()
Message-ID: <20261030182519.GD7582@coredump.intra.peff.net>
References: <20261030173956.585250-1-gitster@pobox.com>
 <20261030173956.585250-4-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261030173956.585250-4-gitster@pobox.com>

On Fri, Oct 30, 2026 at 10:39:55AM -0700, Junio C Hamano wrote:

> Once upon a time, there was a merge strategy called "recursive",
> which was added in 6d297f8137 (Status update on merge-recursive in
> C, 2006-07-08).

  $ git log --grep='Once upon' --format=%an  | sort | uniq -c | sort -rn
       22 Jeff King
        4 SZEDER Gábor
        2 Johannes Schindelin
        1 Jonas Fonseca
        1 Elijah Newren

Welcome to the club. :)

The patch itself seems obviously correct, and the commit message is a
nice overview of how we got here.

-Peff
