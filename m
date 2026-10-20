Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522248;
	b=S9yiJZTq777rwHpoGhzBt9H/jcd9spVpk3OWnRB8IotUFyhtd0Yd8CwDMbow0u5XP6jd
	 rJW+Iyl4FXF6BxV/u49rtUMZ9e3/WBW2Q0RtzyZFHmICNs8k6glO2M3YocgxoJ+PUrpvx
	 lPdFTfl83MMt9iipeoF3jO0WpBzOCLjn0BMOiDJWvwF4v8QK+VKpfmyRskoS4PskFwxO8
	 wuW+zHCTKCN441MrZWs7XRJ5fgG71AtAwuzQ1+Zd/7aDAc2mO8RNnOCo+pexN67rt43NG
	 13razWDy3uorAmXs96OVRD3u/c1JA5Du+ez3gP3ik6mWP1LYSKOT3q3BtH3eBOTb1zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522248;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=5A/ITERHlzSZkRnNSG7q8Oaot3P7/5GlWxgdoCJLt3g=;
	b=jDuAJApiyYlw6RBDaGLMtCmT5iousqfwqEFOH4mgDM7ycLh6MgB0YjwBd2siqbbdymwF
	 PB1eiP1eWCavtfJGpDDyyUwGSGQpmob7KrXGEnaUWi4K7wYSqq38raNCbVM8lZrWOzw1/
	 PWAnLsaO7xLOJ8zA5ca/W4qdTJlUw4p7bOndRP/YvBa0imJWZdcoUclnZZEXsmxSfFgTI
	 F2ubFLHIFkrqX3/JJB01rq/UFVJBk78GhmaghUzrvbtfkxVbrQCEvgUgfYKi0lDDYRK0y
	 EDjO0VHGu0M2PODPzZEr6XPs4qv8fY4xJX9uWR/eZEYBkXy3xAZ99HqqPluU/XIiXyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=BvGhXISN;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53C606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD53C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=BvGhXISN
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 69KIoWc9031041-69KIoWcB031041
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 20 Oct 2026 21:50:32 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xJEuu-000FDm-2U;
	Tue, 20 Oct 2026 21:50:32 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 21:50:31 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 41ded07e;
	Tue, 20 Oct 2026 18:50:31 +0000 (UTC)
Date: Tue, 20 Oct 2026 21:50:31 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Julia Evans <julia@jvns.ca>
CC: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] doc: add new git tutorial
Message-ID: <20261020185031.Atmmv%taahol@utu.fi>
In-Reply-To: <FAD8AD8D-1F2D-47DB-ACFA-C523865E2221@jvns.ca>
References: <xmqqld7tyxi0.fsf@gitster.g>
 <DB04A709-0EDB-4402-99F1-94D8FFD23F13@gmail.com>
 <FAD8AD8D-1F2D-47DB-ACFA-C523865E2221@jvns.ca>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ex19-15.utu.fi (130.232.247.55) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaWkgPARwPARwPCQwPDRwoDwUJ
 AQRGCwcFSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhcSFhIWEhYSFpYSAoNBkYDBgcKBA0oDwUJAQRGCwcFSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFlf
 SA8BHBscDRooGAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=5A/ITERHlzSZkRnNSG7q8Oaot3P7/5GlWxgdoCJLt3g=;
 b=BvGhXISNT8jlTO5Yic7Hn3+c28/HxwSdwfdBGPtIvUJLCWviU8AMzDeYmKbzF5ph+rgKvPWx8vpw
	RUr5KHcVqoeSxmD+b560LVABXeA4wt5XpwrmZIIqkvpGKl4nMNi9dGZJAr+DU/ahzy0zMIQtOWAH
	K1ZyanNYqfH8dNdE1BqyE1s9Zz9OP653Qgl17tXhhuHk99N454kkTVqWKwPD4p/RbQHf8yCTmsHN
	RqW9hvKP+vVIWvXCESO+b+4k8a7Ixo2dvLrv2W4mR5sfvf8eR/8FohhqyJo4Hw/i4XvcGRN5Kaog
	pic5ib8gLV6HAKwr3pdWo2JjcGKhE4LC0ye8Yg==

Julia Evans <julia@jvns.ca> wrote:

> 
> 
> > On Oct 19, 2026, at 10:24 PM, Ben Knoble <ben.knoble@gmail.com> wrote:
> > 
> > 
> >> Le 19 oct. 2026 à 21:24, Junio C Hamano <gitster@pobox.com> a écrit :
> >> 
> >> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >> 
> >>> So far we've gotten 112 comments from 30ish beta testers who have tried to
> >>> learn Git for the first using this tutorial....
> >> 
> >> And we waited for 10 hours after seeing this cover letter in
> >> anticipation, but the patches haven't appeared on the list archive.
> >> Does GGG need to be given a gentle nudge somehow?
> > 
> > I received the v2 patches. I rather suspect the list did something interesting (or the archive), or that the messages were too big.
> 
> 
> I see the patches here in the list archive
> https://lore.kernel.org/git/6532e60e30864c9bccfe5be0731c6913aa44d188.1792421748.git.gitgitgadget@gmail.com/ 

Thanks.  That works, and so does

  nntp://nntp.lore.kernel.org/6532e60e30864c9bccfe5be0731c6913aa44d188.1792421748.git.gitgitgadget@gmail.com .

However, all these fail:

 - nntp://public-inbox.org/6532e60e30864c9bccfe5be0731c6913aa44d188.1792421748.git.gitgitgadget@gmail.com
 - nntp://gmane.io/6532e60e30864c9bccfe5be0731c6913aa44d188.1792421748.git.gitgitgadget@gmail.com
 - https://marc.info/?i=6532e60e30864c9bccfe5be0731c6913aa44d188.1792421748.git.gitgitgadget@gmail.com
 - https://lwn.net/ml/git/6532e60e30864c9bccfe5be0731c6913aa44d188.1792421748.git.gitgitgadget@gmail.com

Quite puzzling.
