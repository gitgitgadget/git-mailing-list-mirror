Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3C179B8
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21966 invoked by uid 109); 21 Dec 2023 08:40:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 08:40:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22313 invoked by uid 111); 21 Dec 2023 08:40:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 03:40:12 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 03:40:11 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
Message-ID: <20231221084011.GB545870@coredump.intra.peff.net>
References: <xmqqbkakqx6s.fsf@gitster.g>
 <ZYN-5H-2NNoRRpf-@google.com>
 <xmqqplz0p90k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplz0p90k.fsf@gitster.g>

On Wed, Dec 20, 2023 at 06:46:51PM -0800, Junio C Hamano wrote:

> Josh Steadmon <steadmon@google.com> writes:
> 
> > I can confirm that this fixes an issue noticed by sparse-checkout users
> > at $DAYJOB. Looks good to me. Thanks!
> 
> Heh, there is another one that is not converted in the same file for
> "check-rules" subcommand, so the posted patch is way incomplete, I
> think.

Yeah. I think it is in the same boat as the other two, in that I believe
that the KEEP_UNKNOWN_OPT flag is counter-productive and should just be
dropped.

-Peff
