Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136273;
	b=e/Ao0Siq6OF+/xMe/FJZGxVDS10s/iBdhSO2yhlHQ4RiK5NiAbcIYRRjrh8JXT+TrXyC
	 Z3htwuyn+SF/RI+f66/E6EejKD5RJAOOYuD/6UY/wBjPof6k4mdWrxXoruN70UmemmidM
	 4Hd0mTgFUidazNO5j5uf4oi7LRj7fLxAbc9ewlTOdD++oiryuDGEhSMU0oIZzzWa5n6Pj
	 M9X+FoftJ3UJhbOsq70/LNfH1Pxw5Lv7mTLQ3exCIxVT02FfUalw0OplGJKx9Ssu101Zl
	 ROYnlWul5Pa/fDKvoRsVDZ3Lo6x2Wifzc6OtoVpBzEOFk0kwoDBybPbwDYgCfMT9D8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136273;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zlUul/NBj8Enjg6EXOXivOuydImxYKf1iBMiavvls8U=;
	b=kCY09wR8SBDxeRquJM66D7zsL16x8k2SGjJcM5ZcrFBEpXvkNiZPWuPGexsDkvbOLkNw
	 3ZOJ+4gHMr9HV2tP52D+2N4KLo0Vcsvw/h2OTa0ck4Xi/54isB68ALfwfwDFMpSOi4afZ
	 R3bOCUhaoGbSHwM4FGdsEh7q1OARIeY8HyXhu1xzlemTLzl7DmNI7m5oSt8wgGwsvp+UL
	 32yYuuzQcRmuhTeJcOCKOMnBMlCwqI2RRm6JSMkNFU60y0EfCLlArzqxdlEBuy6C2Duzq
	 EeW4Zd2RIR8+XNcXjriucouqcQU+9JHp5aiNsEGdEcq6i0/SB92g075zn5+bed1P7Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Oobmz5v6;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA51606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 21:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCA51606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Oobmz5v6
Received: (qmail 39205 invoked by uid 106); 27 Oct 2026 21:24:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zlUul/NBj8Enjg6EXOXivOuydImxYKf1iBMiavvls8U=; b=Oobmz5v6/bu9XCTMtbGy7Xog+qxHGPhCeU2nscrJxJ5yi/qNz+z5neDPC2997UcmorQLezURi2ice/aIQA9JTkL/5oSlybqsXp01tYpf8G7vRk6xUFDdoDuR5nvEOswuQr1Z3ocmllDj3z0iNyMh+LP/Jfvux73/zk4elGTK1TvR6wmpFwdb3JtOMeue3L7qTaeLmCGMnwOViAqFc/DWea8pXtUGtk9wvvrr3xJC0xTXFIlOikAI1QBVaEMos0w1H6iV6awesy1cl60Chx3OiWLjMnWEOdOCv1U+DFbSNgl9eYcGi6Byt6APQ/GzLnf69admYWdZyq5HPvlqIPSq3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 21:24:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 278694 invoked by uid 111); 27 Oct 2026 21:24:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 17:24:31 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 17:24:31 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 0/8] ci: consolidate test variables
Message-ID: <20261027212431.GB774120@coredump.intra.peff.net>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
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
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>

On Tue, Oct 27, 2026 at 09:18:20AM +0100, Patrick Steinhardt wrote:

> this patch series consolidates our test variables as a follow up on the
> discussions in [1].

Thanks for following up. 1-7 seem obviously good to me. I'm lukewarm on
the final patch (and left a comment there), but if you really love it, I
can live with it. :)

-Peff
