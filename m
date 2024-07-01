Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD28120F
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871822; cv=none; b=m14bVJ24mLZEJqBjeD1a/yfxqHjTQJisOg3CnOfVW3VpUHGi73BcHp4F2Gvngetfms/0a5NcqYwKaWKHhSXDrSXlgqgwsOWO2+D+Z3WX7NNQZ7pzSDddk2rBq0bZoWz1Mnor/NSP+VhO53MZwY5tB3aA3bzhReyft7E5kWTemaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871822; c=relaxed/simple;
	bh=Ap/3+aL6flE4rFWJUAgfQ3LKXXoS9ZtAqIkGG9ZOQtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1aVVRw6bOM0KPTucx4iqofql5v1//2Nc4aK9FIZYORgP8+hZ2MK6dCJio1nFzBvTsxNEeoTp/n0gbSlnEg+RcPQB0ROfA1orNIN++XdnC9pctTkiDQCCD2yJNMN8QfgNJlaTXPJODG5iLruXy++kmXYQycCXdKfEQdvgsC615Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29223 invoked by uid 109); 1 Jul 2024 22:10:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 22:10:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18101 invoked by uid 111); 1 Jul 2024 22:10:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 18:10:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 18:10:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 1/6] t0080: move expected output to a file
Message-ID: <20240701221019.GA20683@coredump.intra.peff.net>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <c60c78c7-a029-48e8-840a-45dcc785a6e5@web.de>
 <20240701032047.GA610406@coredump.intra.peff.net>
 <xmqqed8cx6q0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqed8cx6q0.fsf@gitster.g>

On Mon, Jul 01, 2024 at 12:17:11PM -0700, Junio C Hamano wrote:

> > But I do have such an "EOT" patch which I've been meaning to send out,
> > since it makes many of these quoting annoyances go away (though of
> > course it leaves the indentation).
> 
> I am not sure about your "test body comes from the standard input"
> (not saying "I am not convinced it is a good idea" or even "I am
> convinced it is a bad idea"---I do not know what to think about it,
> not just yet).  THe above illustration does make it easier to grok
> by keeping everything in one place.

I just (re-)posted it in:

  https://lore.kernel.org/git/20240701220815.GA20293@coredump.intra.peff.net/

so you can see the improvement in some other real cases.

-Peff
