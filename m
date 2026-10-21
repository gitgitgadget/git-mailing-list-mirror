Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580783;
	b=AgqLvkT8pbBROY03cWszeq2aKGICb00HGl1WVBeR0sKC9Zr7knaHYRhetxiZkbYk5RNk
	 /LEsaX9bXOVpNGZQk9kjSPxAldEulaoiCNpeRNT0CiJef5YZWIy6BYU7ncEbxSwo5sw2A
	 HJZs5FfnIRGYrpB1MlWlBwb6D0onZzowfcwvzrk3/tp23kW1fYEehpFapyjDTx+bSkDsk
	 x/F5MARuFMuaVlbFVUsOtGlA9wVkHUljS4pDrJlYd0DjgmoRWGRC4ZUc62vz45eMcLn86
	 BAtjuSdxwUat7azf90sD05IseXpM12NGbK0nbIEKm1UnubLQAhGOToBwNsnphkf5Vfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580783;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=5eu5BLfZYkWeRNeQ7hnZMkVv5gVQvh+B+6rCg38DW9I=;
	b=RJ1fMn90/lGHunEvrh2CQKNB8y0UVQHW9FcRF+Dhl7HqeT9iOdYebIU02pibvG7biBzu
	 4CPNMUNQyVc4i+FiIKwsbkSWwgkSqGZQHa6rVzXkOs7wl3nh6ThPx99rejGAKvjEM3KkI
	 l19HUkvBQILeByWZXxcRZ0dxdBfE6Ypeg6g7Wphb+Sk+YQhDYAD6xXnzg++UXLwrqy0dz
	 fz83xOehW65oQv8SKMnZSaKWqy5SffwckOqBXGO83hnIw5kGZnIFQJysARqwiTJDvRZ4u
	 hBlAq4pbQI97vQBxa4gCTlaAhIC/w3gR5c8rwdOz+GDm82twDgHcVnYDrqSspxADYhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="UIm/nTVH";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2F606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE2F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=UIm/nTVH
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69LB6GRi000773-69LB6GRk000773
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 21 Oct 2026 14:06:16 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xJU9A-001EBm-RC;
	Wed, 21 Oct 2026 14:06:16 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 14:06:16 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 6433bb99;
	Wed, 21 Oct 2026 11:06:16 +0000 (UTC)
Date: Wed, 21 Oct 2026 14:06:16 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Muritala Mudi <ibnmuhyideen95@gmail.com>
CC: <git@vger.kernel.org>, <christian.couder@gmail.com>, Siddharth Asthana
	<siddharthasthana31@gmail.com>, <usmanakinyemi202@gmail.com>
Subject: Re: [Outreachy] Microproject: use Q_() in builtin/checkout.c
Message-ID: <20261021110616.Wxkhc%taahol@utu.fi>
In-Reply-To: <CAO=0-S64w=n47n6yfYoKJie2aFi+T88Sp_qPmFe2RW0xWEwcdQ@mail.gmail.com>
References: <CAO=0-S64w=n47n6yfYoKJie2aFi+T88Sp_qPmFe2RW0xWEwcdQ@mail.gmail.com>
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
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaXkgLABoBGxwBCQZGCwcdDA0a
 KA8FCQEERgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIWkhYSFhIWEhaXkgLABoBGxwBCQZGCwcdDA0aKA8FCQEERgsHBUhYSFlRSA8BHCgeDw0aRgMNGgYN
 BEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=5eu5BLfZYkWeRNeQ7hnZMkVv5gVQvh+B+6rCg38DW9I=;
 b=UIm/nTVHerT9zeOVDWO8mUjwCs1dDKmIltYQ+HjtTH/WN1FKl7mviYK7Li48kwwkOaRd0v9KpXM1
	epdMfGj4KwoF6Ej+Iwac7o7N72FRdF2JYcI9t3+zXKcdR5Skk3qHnfBi8tPZT+fu42S2vbExBOkg
	Cpurei31Rr9s86aPYx3qtRtWxrhwA9UUT5vqApgilxNbSmkBZ5/NYlAqX1ksd7Mt6Lf+pfbTWQ25
	Ozx2yM1VyjKR9gih39u9CIJsIKsUcQUGbKkrcGxgVgsNWbFqEEkwxJNxv/RGjHOMuw9gDQnkKGlP
	PXC+R3/KBo/w2fzjtpJBbzFZ7M23vKtj617Osw==

Muritala Mudi <ibnmuhyideen95@gmail.com> wrote:

> Hi Usman, Christian and Siddharth,
> 
> Thank you Usman for the welcome. I took some time to look into the
> microproject I want to work
> on and one that got my interest is the Q_() pluralization
> microproject. I will like to work on builtin/checkout.c.
> I searched the list archive and I didn't see anyone working on this file yet.
> 
> I noticed two places that can get improved with Q_():
> 
> Line 1088, " ... and %d more.\n": this is at the end of the warning
> Git shows when someone leaves
> a detached HEAD and so commits might be left behind.
> Git lists up to four commits and then shows this line for the rest.
> 
> Line 1492, "only one reference expected, %d given.": this appears when
> more than one
> reference is given before --, e.g. git checkout a b --.
> In both cases the number is always 2 or more, so in English the plural
> is always shown.
> But for languages like Polish, which have different plural forms for
> 2-4 and for 5 and above,
> it will be inconsistent to use the same form for all cases.
> 
> In po/pl.po, the first message currently has only one translation slot.
> So using Q_() can let have proper translation.
> 
> I noticed that line 1405 in builtin/checkout.c has the same issue.
> The same message also appears in builtin/worktree.c at lines 812 and 951.
> 
> So I have two questions:
> 
> 1. Is it OK to convert these messages to Q_(), even though English
> will always show the plural?

Yes, that would be very helpful.

> 2. Should I also include line 1405 in the patch, which will mean
> changing the same message in builtin/worktree.c
> as well, or should I keep the patch just limited to the first two
> messages for now

You can reply to [1], giving a review on the patch.  Perhaps you could even
nudge the author to take care of line 1492, too, whilst you can write and
submit patches for the other cases you had found.

That would be a nice exercise about how to coordinate contributions, wouldn't
it?

Thanks and welcome to Git!

Links:
  1. https://lore.kernel.org/git/20261021022156.119947-1-tangajoris@gmail.com/
