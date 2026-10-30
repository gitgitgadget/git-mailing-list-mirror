Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390250;
	b=vu+cJam3FtDal/Cg8YE1cVU9wSuD2C0bGFtuVVI1ImQgueHjEgQytwsfxgOcTUqFkN52
	 iBPbExN8W7vQeikNC2c4diskhQbvPiUvZ5ccbIKN6RNrS7W2QgJ3MeSrJF9+O4pmLt4M7
	 zyXAQrap4HE9wOiaSHWyrfeY1fUCUHti8Sj92sSG3UOdP/S/0KjkMQ1UY2olGQP96GMiF
	 UKqHLVPPlm5byqjEM7AcFheKBTN4FHviMjLp++tiAJ12HfNLHNcqHtuLAb7iGZ0YHBipL
	 n70ittcE4+pu79/J3FBKkxcu7KvtJCxXVlEvvwK/KWCxZ9gB3+j6BN8gpphBohVCE8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390250;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=BuqwxI5pQx0x/S6kh92NmPFRULxcRaryok9ASdaLy6g=;
	b=2O7WGL7XCzimN9TFErqHhHxAmN5CiJRnNK3ZN3/1yIpaiBPGnWBKYja8XmffGM/hrodq
	 TRVADY/+SpSzMn3gs0my5lq2OlAKkrhj+XaCnL4Q4THxkiFTP/nF3f+d2Na7USa78zKMj
	 aeZ9C0cZGkOiXuu4nJHvFSCsj3ck6avGKxPI69iA5bvo9PUDNLaMpxm0psLeyESuepn2V
	 8jYwCLbQMknNpNm2ZK8TmwVDp6/9VFH0wCjeKpfpMsr8RRPWzYjTDhiO5JaX9CvqQDw5F
	 ESwhBZyrX+ZSQxTqnDKxzfj+JOmLuaxFmjmGqe09oIbiQDniv1X50Ponkxn70nrYekQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=YyMVxIXf;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949D606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 19:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5949D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=YyMVxIXf
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69UJvDGM007142-69UJvDGO007142
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 30 Oct 2026 21:57:13 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xMsiv-00E9sS-Kq;
	Fri, 30 Oct 2026 21:57:13 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 21:57:13 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id bb04dbeb;
	Fri, 30 Oct 2026 19:57:13 +0000 (UTC)
Date: Fri, 30 Oct 2026 21:57:13 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Omri Sarig <omri.sarig13@gmail.com>, <git@vger.kernel.org>,
	<julia@jvns.ca>, <me@linux.beauty>, <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5] doc: git-rebase: update incompatible options
Message-ID: <20261030195713.ajPKo%taahol@utu.fi>
In-Reply-To: <xmqqse1nugsk.fsf@gitster.g>
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
 <20261030163841.31840-1-omri.sarig13@gmail.com>
 <20261030192719.8KtoR%taahol@utu.fi> <xmqqse1nugsk.fsf@gitster.g>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZXUgFDSgEAQYdEEYKDQkdHBFI
 WEhaSFlcSFlbWEZaW1pGWlhfRlxfSFBIWEhYSF5IWEhYSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFlfSA8BHBscDRooGAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4G
 G0YLCUhYSFldSAUNKAQBBh0QRgoNCR0cEUhYSFpaSAcFGgFGGwkaAQ9ZWygPBQkBBEYLBwVIWEhaXkgYAAEEBAEYRh8HBwwoDB0GDQQFRgcaD0YdA0hY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=BuqwxI5pQx0x/S6kh92NmPFRULxcRaryok9ASdaLy6g=;
 b=YyMVxIXf4Arv/9bKQXHvsPQthzwXn2xze6NmFv/gIxjGjL99NWy6y7kmJTxXX+l3mHwIRYtNrp3z
	R/W89j20UaSsfEbIs0qhCe73++1njncqsmZVA81oDT1WSfMsUHsLe/DGldtxsCJRS+J+qjea65U4
	0lyJTqH2Ju7TQWBmdqUsK05GSgiC/cpMOg4IiNKD59lY/b5XlhTYTsfoqGxqCNw9UsSqdHsvg3cD
	KdmRSWNSp2xSvGcpSL5LHGzZeOcXWHiU4zvO9om044xPrnJyl0i5oKx8aPDUGYnKWOKzzkAlEblR
	eHrHtWu6QDjqf1DwIDFBTgAk9hDL7nBShv9UBA==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> >> Thank you for the review!
> >> 
> >
> > The range-diff against v4 makes it clear that v5 only changed the commit
> > message.  Unfortunately, the reroll introduced a new typo:
> >
> >            section from the option description.
> >          - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
> >            2021-09-07) removed the `--preserve-merges` option from rebase, which
> >     -      removes all incompatibility references to `--ignore-date,
> >     +      removes all incompatbiilty references to `--ignore-date,
> >            --reset-author-date` and `--signoff`.
> >      
> > Otherwise v5 looks good to me.  Thanks!
> 
> I do not quite get what "all incompatibility references" mean,
> though, with or without typofixes.
> 

Um, yeah.  I agree.  Perhaps something like this would scan better?

- Commit a74b35081c (rebase: drop support for `--preserve-merges`,
  2021-09-07) removed the `--preserve-merges` option which was the
  only one at odds with `--ignore-date`, `--reset-author-date` and
  `--signoff`.

> Thanks.
> 
> >
> >          Additionally, since 414d924beb (rebase: teach rebase --keep-base,
> >          2019-08-27) the `--onto` option is incompatible with `--keep-base`, but
> >     -    it is not mentioned in the INCOMPATIBLE OPTIONS section.
> >     +    doesn't link to the INCOMPATIBLE OPTIONS section.
