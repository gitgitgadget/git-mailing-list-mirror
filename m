Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257A32E12E
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505727; cv=none; b=nYF262eMivhyjFUaYyIe2iZdnrm6i4GO5Leie4CElXty7dQOK0HjWDvA8RTUGW7vU3fzPYiP8RB7D+ss+9hSXlDRheB1BGfW+HaTuTf9C4WYApaxHCuLkPVQFiPA8Eldg2hqDksPYnHz0yrsYt3c/PPE/v9EENUvAZVfPx29dnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505727; c=relaxed/simple;
	bh=Emzozsj3+IU4Y/1G49/GpSVVk7nF4krQfN67U/iE9lE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLdP0b+KwjKOS6LaH3OUkhPqRAHQNDcHnWDWJVyupewl4MgCREXlF668adXGykc+nIH8U0UHtvdIdZBL3xYljPtsWycTtxH7Py9MhF4HevdDhWm1pt8zQpbud5OmTD0VaGsRiOaQc1LtqOJ5CluqdWS4sTXJUUfctLh5uYHxPvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=CNf2B848; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="CNf2B848"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 67NH6jJI011494-67NH6jJK011494
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 20:06:46 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wyBef-009a4f-RG;
	Sun, 23 Aug 2026 20:06:45 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 23 Aug
 2026 20:06:45 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 088a0d1c;
	Sun, 23 Aug 2026 17:06:45 +0000 (UTC)
Date: Sun, 23 Aug 2026 20:06:45 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Justin Tobler
	<jltobler@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, K
 Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: Re: [GSoC Patch 0/2] add unicode support to git repo structure
Message-ID: <20260823170645.rBeci%taahol@utu.fi>
In-Reply-To: <aorzcZVdCK27pdjG@ugly.lan>
References: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqse47pfyy.fsf@gitster.g> <aorzcZVdCK27pdjG@ugly.lan>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhcSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFtbSAIJEQkc
 AA0NGhwAAx0EAwkaBgFaWFhdKA8FCQEERgsHBUhYSFpdSAcbHwkEDEYKHQwMDQYACQ8NBigPBRBGDA1IWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=r8LcuUjTOpOczbzSFwj7TCKFbsFEW4RU7Q6VK1r8F+E=;
 b=CNf2B848CeR/389bM0LNVgftJLrjRBYL/ciRXapkktWteqvXpXmRTXzKKuPW0syP67Z7aLOxcE3/
	nbpW1EE050JdykgxSp/o7oTjdw8pTp0LE6mdLOzI3Be1AWesFQjK6EUfEQ5D4TL6dCMn2wZUZuPl
	4IGjg+QnN/gYXJ+aUP92KLhqowGhahstxHSMOqpM6gtZ2/tG5u/vUWgSUAUz9v+5z2iYetSwG7kn
	NIeOnQxuiE0Oaj/RWO6h41R5HkY9bElvTNeYFR7DBOjrqqEN731tHVAXOPb61TCwx3yqnxz/Pkji
	a4nICZKAKPAqdMP09+MApFcKbcwFlR1JIOlc4A==

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> wrote:

> i can instantly think of two popular applications i'm using every day 
> which use box drawing chars: mutt (thread and attachment tree displays) 
> and midnight commander (panel/dialog frames). if "often" above were 
> accurate, these projects would be getting a lot of complaints about 
> that, which they don't.
> 

Hmm, mutt seems to use ACS (alternative character set) as a fallback option:

```
            else if (Charset_is_utf8)
              addstr("\342\224\224"); /* WACS_LLCORNER */
            else
              addch(ACS_LLCORNER);
```

How relevant that is to us, I don't know, but perhaps something to think about.

-- 
Tuomas
