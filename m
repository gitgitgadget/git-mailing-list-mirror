Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434292;
	b=IFf73Z/4H2XZgrq2fSExFNam01pjqvEs1jHBOUqF8auX+x2kVYXtU4Nq38FoQnfDELvu
	 LmnJGV+us1M2QGphpDKrmkymRAQkR92bSidDYsO5WjR3jK+J6WCw4FuNSvWpJ8b4AXgDO
	 /W9ztv6htJU0Belc5q87/ztEZssFB3/+masQK9Y9xhKJfcfmJ+u48bk8G8HDp7ZoNrJpY
	 IVjjTTY0r22oM1/B7MLdfmAfmrGdGm32Kg4l9e7yGK/5lF3Cy4HVIKbbnf6IScitkJG20
	 Zo6AV6nNWj+1WT1KwiogAs0QZ5dUd5v1dEyIO7dKyNayiTN6Akcs9Ag5NxCiwAbRX1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434292;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=oLGgYJU4oBKq6HCJZHpyjZLUo7fwtniEqEmmlJQspxQ=;
	b=Cbo4h5KRNYWng17KnH/6iITo9pKnoClsJckWsjhGJGwZgpm1uuiTVu+KWP7UCa4E50Xr
	 mjbVpCGbFoYOS5naEWMtMVzSjD7ABLJa0wrAl36F/BIkHbuD6OyOgi/kYnO+KZUk1k9x6
	 PX+28Jl164bxjxKNJRRicAEoEPgCzQDr/i6LRqgQ3eB4kr3WAo5eX6qlg/ZMbBcor134t
	 0b1Sj/JzlFiwAumgQGNlzqAZeM9xemKkOvc9l4BJNvjD7fS5ZSii1Dt0ldxvATMgGCl0V
	 VOmwzBqA/lXq6DE9ie4alyDtzz/6HELpB3KQOQYoEBORNDLgwCUHudxPEQypX1z/SnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=m9l6dxs2;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5298606A327
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 21:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5298606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=m9l6dxs2
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6ABLvkZd012620-6ABLvkZf012620
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 11 Nov 2026 23:57:46 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xRGKA-00CY87-LE;
	Wed, 11 Nov 2026 23:57:46 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 23:57:46 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 7c98261c;
	Wed, 11 Nov 2026 21:57:45 +0000 (UTC)
Date: Wed, 11 Nov 2026 23:57:45 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Julia Evans <julia@jvns.ca>, Patrick Steinhardt
	<ps@pks.im>, Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King
	<peff@peff.net>
Subject: Re: [PATCH v3 1/2] command-list.txt: add gitformat-loose(5) and
 gitpacking(7)
Message-ID: <20261111215745.5LxQ4%taahol@utu.fi>
In-Reply-To: <xmqqh5hvt6ot.fsf@gitster.g>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261029184834.2273-1-taahol@utu.fi> <20261029184834.2273-2-taahol@utu.fi>
 <xmqqh5hvt6ot.fsf@gitster.g>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-04.utu.fi (130.232.247.44) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaWEgLBwwNKAMACR0PGwoJAwNG
 BgkFDUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXkhYSFhIWEhaWEgLBwwNKAMACR0PGwoJAwNGBgkFDUhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gP
 ARwbHA0aKBgHCgcQRgsHBUhYSFlbSAIdBAEJKAIeBhtGCwlIWEhZW0gYDQ4OKBgNDg5GBg0cSFhIUUgYGygYAxtGAQVIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=oLGgYJU4oBKq6HCJZHpyjZLUo7fwtniEqEmmlJQspxQ=;
 b=m9l6dxs2iRbDC14HAKKfujWGy+o4P5qnevKKc5zO/kykQVmUPYC9FxoCdpVbvPQRP3xIMVdDFX1/
	PlsDWy3I0JiHuLx3uCQYjg9lgltWfNX+iDN282qhIafEPq7obIcmFmKKgTSq0V0zzLZgcU+sk1Gs
	O/LkX2GERhXCz25ljzKbjPEZ9u+kqeu58U7E9WbVLZF2vgdu7C5Wirc/MN/ElUdF8W4qxdZQvZ6I
	mR8phY7o5SQx1DvdZTSlBsPNYcUYbk64yS2XCoNaIbM0qR/Mnn0CIE6MpOz8o3R5fgNcG5p5c0Wx
	MQA8zFN9/1u4HTxIcMSUd18aDsHGjguPdFL+eQ==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > Three manpages from sections 5 and 7 are not featured in
> > command-list.txt as concept guides or interface manuals.
> >
> > As easy fixes, add gitformat-loose(5) to 'developerinterfaces'
> > and make gitpacking(7) a 'guide'.
> >
> > That leaves only gitweb.conf(5) which could be added to
> > 'userinterfaces'.  However, the manual would then appear
> > as "web.conf" in `git help -a` which is just confusing.
> > So, perhaps we are better off by leaving it out.
> >
> > Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> > ---
> >  command-list.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> I agree we can decide what to do about gitweb.  Is the list
> otherwise complete to cover the available documents in .adoc format?
> 

AFAIK, yes.
