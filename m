Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA63CC7C5
	for <git@vger.kernel.org>; Thu, 14 May 2026 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792876; cv=none; b=W4U9aYSIkojnK+GXXc2rptLHEopHAH5p2pZYpgQHXEXJxUk3SJ8LIAB2XHAMnlagPrwv/ezfSNJ+giuAGM4OLgu6y8zDl1zieFWDIKVdW3JxUuPhoVPATvHWUZFGeFq0uATZC1oSlndmfgrcDrtBbR0IA56glmo32ilC3t1bE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792876; c=relaxed/simple;
	bh=MeB1qnH3fWkTvHtsXQUAj5NCVeq9UEmCrtjFYr81I5s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBEVaqrcC6XWXS1AdSrX7vs0VolnjUw34NCf10vKk1S+YtmzD1wxN5uGmwF8plgI8LSmNFJQqnSgctg7u05M12gNgki8+zBnr+ij7hWlkff0UOw4kM+y4KJ938S9hOcuqC042NsWv3GkVlJ8JsVq/yta+7bXsI1T4a64Kw6UAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=FatDmXbi; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="FatDmXbi"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 64EL7gLb006964-64EL7gLd006964
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 15 May 2026 00:07:43 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wNdHS-007yVR-T0;
	Fri, 15 May 2026 00:07:42 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 00:07:42 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id ec5a8b85;
	Thu, 14 May 2026 21:07:42 +0000 (UTC)
Date: Fri, 15 May 2026 00:07:42 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] approxidate: alias "today" to "now"
Message-ID: <20260514210742.Yc6NZ%taahol@utu.fi>
In-Reply-To: <xmqqwlx6f1fo.fsf@gitster.g>
References: <20260512145430.13212-1-taahol@utu.fi>
 <20260514115520.6660-1-taahol@utu.fi> <20260514115520.6660-3-taahol@utu.fi>
 <xmqqwlx6f1fo.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-08.utu.fi (130.232.247.48) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=9PVzMLHVaFyk6tfopoSz1Kc0YDGvdSYXlJ+E+K5rFDs=;
 b=FatDmXbi15oM4ii6iiaQ/euGqTDi7D+Drl4jFKF/lOGCnIhmnGHUYFEH5KWmdb/6fWv1FcuoJXhO
	NYcFSUD+shyUztDrNBgdeBwY7k+qf4FJFyAvdK/kkEMhwVjtuUBlBRqItpAcCm3QcPUW9W46hvul
	I8V9M200R/JkLHqp4ktENANfN7jEyhWVXz3GzOcUPoUUZ24FhnKrCW4n62z3p22krPw45Zefsbk7
	LZxe0Q3DYko/zuAlyFRHkz834J1Y7RJQuPP9cF2wH4iOnGz2Uiq578ALWhpx/lxyTUXG0l6HKXr1
	g3vxomtdka3z42kb3BY218Acc7z23dsmMc7Qug==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> >     Sorry, I don't know if I understood.  Does the patch change the behavior of
> >     that command somehow?  Is there some kind of edge case I missed?
> 
> No, I did not think it was a good idea to carve the behaviour in
> stone that "git log --since=today" behaves as if it were given "git
> log --since=now".  My reaction would have been very different if we
> were deliberatly and explicitly saying "today is synonym for now",
> but the thing is, it is not a designed behaviour but what
> approxidate does for anything it does not understand, e.g.
> 
>     git log --since=decay
>     git log --since=bogus
> 
> all behave as if it were given --since=now.

Thanks for spelling that out.  So, as there is no deliberative
decision behind the current behaviour of "today", the code has
to remain non-committed on that; we are not at liberty to codify
the status quo.  Right?  But perhaps we can find a least common
denominator.  "Today" means the current day (well, obviously),
and this seems to be enough to get "today at noon" and such to work:

```
static void date_today(struct tm *tm, struct tm *now, int *num)
{
	*num = 0;
	tm->tm_mday = now->tm_mday;
}
```

It gets the job done whitout setting in stone too much anything
that is up for debate.  Do you see that could work?

--Tuomas
