Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815334;
	b=qHYIO/gONgynLfd7vytqArbXV9RZXyuizbYN/00uViMSW5Q5unI0vaqo85yB9heM+P9U
	 vgVKqHx2FThPIPgYXr2E+d/XnctnEww0xL3eU7HP4I9X29OhP0zK77c9zjBULI2lw6Qsw
	 hDB1a/hdOjpDVLkLyWpIAzWvCZD5KA1prOPwh6L9gQdDAyy8HqIM8zypJmTb+IL04FyJV
	 JObhYFafPIKx9qWyyhUrSUWfwhI6G21pO8d3Vk8XrWi74uX3LX9S7zHkJMnnVTimu3Prs
	 4DBHzY+JiMiKIeqc1hPutLcgHitlLKbznFYT6LIwICQYJw3mUC42NsuGQ6jDjSR2cvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815334;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=0DtrZwcGww5zqPLIkAyjw9aAiCGV+3VpMEbU476+hmU=;
	b=jsO2UFDJScX8ZB2SDA8MyzmSWI+4dDnBOx6dqF+80/qaVNm2GrHxQ071roVpM+W/lSA2
	 U8gf9YYW34zh1+lRjdGrWnD09wupsJH3eT9TOfF2f/Ajfuv3xwUCZHo/egN6nTqnJlpha
	 hXlu2H/DEBQc8+5htvp6XBzi5m6Vj/mPsKuC916c6Ie/bffZmTIaldVtVh/C2cHVT3FRn
	 0iJc4lS7lqg0xNMb8oVJxen+6212MrLi6nY7/4IO9SPDVcUIlJXvUunlmxG/pZtEjeZwY
	 nD21Oa8I8k82IlIR6ug0E3stRKq6GaCEmSvZYWEISWhGGmrCZ1LDXCNpqntaA+JQrCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=YZilQ13e;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A0606B206
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 186A0606B206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=YZilQ13e
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A4I1rUo019948-6A4I1rUq019948
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 4 Nov 2026 20:01:53 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xOfJ3-003gTB-B6;
	Wed, 04 Nov 2026 20:01:53 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 20:01:53 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 75c50f7d;
	Wed, 4 Nov 2026 18:01:52 +0000 (UTC)
Date: Wed, 4 Nov 2026 20:01:52 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Patrick Steinhardt <ps@pks.im>
CC: Carlo Arenas <carenas@gmail.com>, <git@vger.kernel.org>, Ed Maste
	<emaste@freebsd.org>
Subject: Re: Is anybody using .cirrus.yml?
Message-ID: <20261104180152.BksDw%taahol@utu.fi>
In-Reply-To: <auskIPBRorDxDj6N@pks.im>
References: <20261102204151.MA00I%taahol@utu.fi> <aumQMJLMeI4sfeNI@pks.im>
 <CAPUEspg_9CGMtakHO3Stj--exd5nRNv7i3vW5tmMF0Arzmo=zQ@mail.gmail.com>
 <20261104095752.2rs5_%taahol@utu.fi> <auskIPBRorDxDj6N@pks.im>
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
X-ClientProxiedBy: ex19-16.utu.fi (130.232.247.56) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhRSBgbKBgDG0YBBUhYSFpIWVxI
 WVtYRlpbWkZaWF9GW1hIUEhYSFhIXEhYSFhIWEhZX0gLCRoNBgkbKA8FCQEERgsHBUhYSFlQSA0FCRscDSgOGg0NChsMRgcaD0hYSFlRSA8BHCgeDw0aRgMNGgYNBEYH
 Gg9IWEhRSBgbKBgDG0YBBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=0DtrZwcGww5zqPLIkAyjw9aAiCGV+3VpMEbU476+hmU=;
 b=YZilQ13eyL8NnzpHFCAVMEGUeamgMAsgoMIXkN5UtaS+1CA9MzSQrkcnoWaAZodkm2htmAv62cHa
	PeWk2d41KlMFqn1UJh3eeQMnbVjetF6etz7G3e8uLiz9Q03H6tVPaXpmcqHWKZdZkRPnGbqNk7kd
	nvAJ+PitpzkT16KokbN9OaXDBa+2s1oacrZeQwnr7Dq62j6YjpK0jecXnP53fAvBaH4ToMXKklFv
	UPHWIItMIRorkMAP93e3DB1N6o+Zl2MUlY4typZjAjOOWrRTntNzcR7ryj3AX1JEScZ00mWozKU3
	FnOsAxUPi6Uev+JKJh8+QuEqDjxJCQm+WceUOA==

Patrick Steinhardt <ps@pks.im> wrote:

> On Wed, Nov 04, 2026 at 11:57:52AM +0200, Tuomas Ahola wrote:
> > -----8<-----
> > Subject: [PATCH] CI: delete defunct Cirrus CI configuration
> 
> s/CI:/ci:/
> 

Sure.

> > Since b5a9d7afcd (CI: add FreeBSD CI support via Cirrus-CI,
> > 2019-12-20), .cirrus.yml has powered Git's VM-based FreeBSD CI.
> > 
> > However, with the shutdown of Cirrus CI on 2026-06-01, there
> > don't seem to be any drop-in solutions available to support our
> > usecase---while there exist tools in general to run Cirrus pipelines
> 
> The three dashes are a bit funny, but okay.
> 

An ersatz em dash.  Might be a subtle Junioism I've picked up.

> > locally, managing FreeBSD VMs doesn't appear to be covered.
> > 
> > That renders .cirrus.yml completely nonfunctional.  Delete it.
> > 
> > Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> 
> Other than that this looks good to me. As said though, might make sense
> to send this via a separate thread so that it becomes disocverable.
> 

Thanks, I'll resend.

> Patrick
