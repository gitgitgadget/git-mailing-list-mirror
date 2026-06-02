Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325CE38CFEF
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420217; cv=none; b=YxMrfGT4uj7nnmLx17H809bCKuqnh3gGPvvdgneiV+895hLNWDKscxNbz5BqOyutaCIBwUcZWESeCZB6MIkZUJAemLwD12BS3iJgjx18pnIlxBOfvM9IoL68jKhQjW6PXVSysWoBqFyIskRmWUWE4RwgyhNIDr0lGAEIB2CjYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420217; c=relaxed/simple;
	bh=AMKwBrMdZcroKrtIVdXETtZuQfiM6PxNu8xICZ7ph80=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eH0wozwC4gjc4LLYezt0008xecfn9a47+YDvncHWrYB5WE4UyIY7lv7ALSRQu1O0e4mIaI2xY+cc+ZDMb5TLvGt03gKjHeRZ5fPuxeveosN48RCg+dEWVhz2Urt/xju1N8QP1zreU1B5aSkC6N2ddOYpkdAI79Lu2T+Yah4AHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=GUMgoz2R; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="GUMgoz2R"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 652H9uFN020214-652H9uFP020214
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 20:09:56 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wUScm-00GYve-8t;
	Tue, 02 Jun 2026 20:09:56 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 20:09:56 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 7809e711;
	Tue, 2 Jun 2026 17:09:55 +0000 (UTC)
Date: Tue, 2 Jun 2026 20:09:55 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Patrick Steinhardt <ps@pks.im>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <20260602170955.Z4b7y%taahol@utu.fi>
In-Reply-To: <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhRSBgbKBgDG0YBBUhYSFpIWVxI
 WVtYRlpbWkZaWF9GW1hIUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhRSBgbKBgDG0YBBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=u2gfsRlWTJmPfJMWQua4/Rludg2gSJwUBOtMiNayJ1A=;
 b=GUMgoz2RC//gEWV4Yijsgn/3XcE3fQijHZhOSFdK+Wkt4t10Z9oBlWMh+SXTvssMAe9a+aLw/CO8
	2jzkHyuPDdS+huExnUBy7ssjwnyM4YLprZlwF4mPOyTSJCvls1S7ocsdGmZKHv2qXd8fRoYC1t+0
	jrwrJYHNYkVf/lufjwXtRWgqlRrdn1mH6Z5IeEQ0Fn/oXbCYh5nwyGBsQFna2puxJquffuB8+9Yg
	/hkzqooyC+gBSitsEG/O86GEzGKR1PCHb6l91YC98Aexj3asdjkAYqf7i+EQSTpx2Sc7QbqaoxI0
	N8ih1SRjSMamOLkjYVAL9m8fbuboNytB90o+dw==

Patrick Steinhardt <ps@pks.im> wrote:

> We're about to extend our documentation to recommend b4 for sending
> patch series ot the mailing list. Prepare for this by introducing a b4

s/ot/to/

> configuration so that the tool knows to honor our preferences. For now,
> this configuration does two things:
> 
>   - It configures "send-same-thread = shallow", which tells b4 to always
>     send subsequent versions of the same patch series as a reply to the
>     cover letter of the first version.
> 

Huh?  Doesn't MyFirstContribution speak *against* shallow threading?

	        [...]  make sure to replace it with the correct Message-ID for your
	**previous cover letter** - that is, if you're sending v2, use the Message-ID
	from v1; if you're sending v3, use the Message-ID from v2.

Besides, GitGitGadget also employs that kind of nested threading, if I'm
not mistaken.

Thanks.
