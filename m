Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB371FF601
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978408; cv=none; b=kItkjpvfpFk1QHrBAGQfCgExjszENL1OPZGA6ppSKjoSYxdcY7hPcejnNJ5RepCz21tkCLjWeD4cQUwTj//Ty+MlDn669LGlfIIRo/6nu5vY2z/ihdPtSOkVpLDkUgoTngDflcXLTDOP31pyYQsjmbsLC/DW0t5YANMIfSgLQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978408; c=relaxed/simple;
	bh=N2qNpCXPKdKq7h/M5HgNeRLC4W8nTNNo5eAQBxtgTEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4qhxvQppCDf+lxkVnaggfdOZfKT9Z0v35wQN+pqBPA0i2h/WceGeUprB+lQzbfvG6Pw7cKTlQg/gkQtkpfZsUe4pcXzRt/iAM9o5NJoLCHIo7JhCjFy4/AqZw4UQfuTwKTINHj1gDZgLB1eTn0PWjsOu1HPLhLk9HPYq1aUGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VB0h06Ba; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VB0h06Ba"
Received: (qmail 23455 invoked by uid 109); 14 Mar 2025 18:53:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=N2qNpCXPKdKq7h/M5HgNeRLC4W8nTNNo5eAQBxtgTEE=; b=VB0h06BaN3HKq7ezkwxFqAe9unZceuYYOBpjR4EoTvQQRDE0KwSNRH9DK1Pdf3KUlfM3ZySlvp+CpX7NvByC0lMyVFnaZHjb2csmYYsLHmfgyvo+NWmoqN8eo8/U1Cx2cosikU0DAmH2uXUjE7jYDDdxw3KvIWo1JyBVExXXvWfKMUrqel7locPEezF43OvGIl+wKSeBjhwtAMandqNBqTU48NIXqMOi2eM9tueigGvMY0rHm4jm5Sgie0iyzXQx4RNj3WnKbS3jbQtCxtxgFM0B8tjI2VW+Cp6Z6VODdyfVYmGIJpU3qs8Ng9Y0MmHUK1qFL+oSEBJ8EX2wBPTp8Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 18:53:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7917 invoked by uid 111); 14 Mar 2025 18:53:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Mar 2025 14:53:25 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Mar 2025 14:53:25 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <20250314185325.GC578421@coredump.intra.peff.net>
References: <xmqq34foefh8.fsf@gitster.g>
 <20250307225444.GA42758@coredump.intra.peff.net>
 <20250308032309.GA584028@coredump.intra.peff.net>
 <xmqqfrjkao75.fsf@gitster.g>
 <20250310160440.GA26189@coredump.intra.peff.net>
 <xmqqsenk7mab.fsf@gitster.g>
 <20250314161010.GA8522@coredump.intra.peff.net>
 <20250314161347.GA9440@coredump.intra.peff.net>
 <xmqqv7sbh698.fsf@gitster.g>
 <xmqqr02zfr3r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr02zfr3r.fsf@gitster.g>

On Fri, Mar 14, 2025 at 10:40:24AM -0700, Junio C Hamano wrote:

> >> -- >8 --
> >> Subject: [PATCH] run-command: use errno to check for sigfillset() error
> >>
> >> Since enabling -Wunreachable-code, builds with clang on macOS now fail,
> >> complaining that the die_errno() call in:
> >>
> >>   if (sigfillset(&all))
> >> 	die_errno("sigfillset");
> >>
> >> is unreachable. On that platform the manpage documents that sigfillset()
> >> always returns success, and presumably the implementation is a macro or
> >> inline function that does so in a way that is transparent to the
> >> compiler.
> >
> > Would it work to instead do this here
> > ...
> 
> I forgot to say a more important thing.  Between the "let's excempt
> developers on macOS" and the "let's see how far we can go with the
> warning turned on everywhere and wack-a-mole this particular one
> with errno check" patches, I prefer the latter at least for a short
> term.

That's my gut feeling, too. I wasn't sure how people would feel about
actually touching the code (whereas the other patches were purely
turning compiler knobs). It may turn into wack-a-mole, but finding out
is part of the experiment.

Your CAN_BE_TAKEN() approach is certainly less subtle, and can be
applied in a more general way. If this is the only spot needed it may be
overkill, but the readability improvement alone probably makes it
worthwhile.

Do you want to turn that into a patch?

-Peff
