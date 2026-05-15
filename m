Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C72315D33
	for <git@vger.kernel.org>; Fri, 15 May 2026 05:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821376; cv=none; b=TVf6efNatkVoL6ePQrZ2X3IBY5zsCFoWBqekYAZ/KHowir89alpYw01L1Tz2pV+LpVlsIFmmYZwSRvBtXBu8ZwvlMB0PEqj2+9qhDU+5Hp/QPWM9qpjy/lie8dCOdlDZLoa/HlR9ppr1ML1tE3RV/Y713Iywc2BN1+nBE1AtAEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821376; c=relaxed/simple;
	bh=yQGEy5/QAxbF16OsX7CH7cFNdUQxRuIpR6iQ72EB4HQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKZevetKMY76as4UeRWdAlGypYW/+F4OtkYHIWkqflj/FXfQMM/jUBk7cHNAhYFw5Ep9M9P/YfLjLcDtbax+kM4vbE5kB1CsQN4guMcAEbwcqBdCOL0GVubd0aUON9e074A4vXrFscS1zLl5YEpn7EuQS+NSpVAjZkDWEvqCKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=McBRovL1; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="McBRovL1"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64F52iJY014607-64F52iJa014607
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 15 May 2026 08:02:44 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wNkhA-008frP-BB;
	Fri, 15 May 2026 08:02:44 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 08:02:44 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 5eb92a32;
	Fri, 15 May 2026 05:02:43 +0000 (UTC)
Date: Fri, 15 May 2026 08:02:43 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] approxidate: alias "today" to "now"
Message-ID: <20260515050243.daahz%taahol@utu.fi>
In-Reply-To: <xmqqa4u1e9k9.fsf@gitster.g>
References: <20260512145430.13212-1-taahol@utu.fi>
 <20260514115520.6660-1-taahol@utu.fi> <20260514115520.6660-3-taahol@utu.fi>
 <xmqqwlx6f1fo.fsf@gitster.g> <20260514210742.Yc6NZ%taahol@utu.fi>
 <xmqqik8pea39.fsf@gitster.g> <xmqqa4u1e9k9.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gYDQ4OKBgNDg5GBg0cSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=VMZ1bnp5R1ScxNI9TE15mY0Trkmo7dTN30SoxvHn0+c=;
 b=McBRovL1naxTUfuJIKeE67YVxuCnSDVwNfwyeUctGSQvvAz07MLKmidRNHOAGwfv7tMM2gYN4G8Y
	MwNOOZIt6iSfwaErK0CaffrEcoZHPUgDZ1jX6c0oc04LH6zbX9/xKGtyPlnF8SxG5zU7yLJxOSwx
	HAk9R2Fok08XdeDxVvdNcyHWvE8JMbjJ4bViU2edobKdN3CY7rG2zUHLnNLt5ulPh3inqhgzLnu9
	wWFux+yEM66kIwpvEzUK/tn8cKAV6ncpPLLGnz2j54jd1wc0adkw9yZuYW1j9PTehMzmJ0DGkVqE
	HaiOxbQpvCkEN1gNtn/49edU+tiVg8vCNdfL3w==

Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Tuomas Ahola <taahol@utu.fi> writes:
> >
> >> Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >>> Tuomas Ahola <taahol@utu.fi> writes:
> >>> 
> >>> >     Sorry, I don't know if I understood.  Does the patch change the behavior of
> >>> >     that command somehow?  Is there some kind of edge case I missed?
> >>> 
> >>> No, I did not think it was a good idea to carve the behaviour in
> >>> stone that "git log --since=today" behaves as if it were given "git
> >>> log --since=now".  My reaction would have been very different if we
> >>> were deliberatly and explicitly saying "today is synonym for now",
> >>> but the thing is, it is not a designed behaviour but what
> >>> approxidate does for anything it does not understand, e.g.
> >>> 
> >>>     git log --since=decay
> >>>     git log --since=bogus
> >>> 
> >>> all behave as if it were given --since=now.
> >>
> >> Thanks for spelling that out.  So, as there is no deliberative
> >> decision behind the current behaviour of "today", the code has
> >> to remain non-committed on that; we are not at liberty to codify
> >> the status quo.  Right?
> >
> > Not right.  It is more like "Even though we try not to change
> > existing behavoiur left and right without a good reason to avoid
> > breaking existing users' expectations, we should be able to "fix"
> > what is not intended behaviour but is something the code happened to
> > be doing, especially if the current behaviour does not make sense.

Well, that's not far off from what I wrote.  I just meant we cannot
make the current (somewhat accidental) behaviour official *just because*
it happens to be the status quo.

> 
> And the other half of the discussion is that once we explicitly say "today
> means right now" and make it official, it makes it much harder to fix it
> later.  So we need to be very careful in our first attempt.

Roger that.
