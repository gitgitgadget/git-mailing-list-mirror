Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861859;
	b=PbyraBv+jPqCVpDNLUGnp2W+fgS6p8iDAnn44n8Rx3TQJUBE2b0Lj8iyuUGpjM72mGSS
	 Ed33MpAC9Rhxe+Qac99s+17H9yViI+ZfwQy3+N/49q8SNLRyqVZNNeAiCizTecqy7btLU
	 c69bTozYMifc4NcYWKqgFp1SZ/zHHT3J2H7vl1JFeDzCKzgrDGZRbwRHvLzMcTsOJAdG6
	 vbz2FNZYWdHgC9pa9EO72iPWUy3FeV3FGLTtLjDjZGVcB+fJx9XZcLO2NJPovgvjmdKnl
	 IpAhP0VfokBNyjJUPoi2KNOiLRGxYl01XSLxhoTrUqAJltl1u2CQKSXGPu48GhPa1zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861859;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=mo+jWWIUp511QzGNbrjy1+yLYPUYE3Alch1Rapl4Pw4=;
	b=X7dQIVlvA4FGQ1r0A79NchypjF5kIVbS6tjfVag47VCUPR0oC94ZaZng00ldmrz3Gajn
	 o8BTyNF9WTfl399teQei/pvLGhGX7xZWVy1Sr/GVzvEw0FD019bHnGtmk1o1OygeUFS5G
	 ODHA3evxGLdO4mipLKAex1Ot+ohC3sEikGiIMb/wDoHLVorsVjhRiPT5rwc20e+zBqtCO
	 16+misv3WQgLaY9QFqE/eJequS15IMg28XCxIpEg9DtE3REPZVOfYh5RLDGhy0Fb7d/Qs
	 E+O7EEUBb68xNzj40RnYogjpdKvJKadxD6aBXionU6pQ744jMwJRMndfNFn3ya/c76g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=aeEgWxv5;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C7606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 06:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D78C7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=aeEgWxv5
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A56vONZ028732-6A56vONb028732
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 5 Nov 2026 08:57:24 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xOrPY-004ATf-Ak;
	Thu, 05 Nov 2026 08:57:24 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 08:57:24 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 0a04fd18;
	Thu, 5 Nov 2026 06:57:23 +0000 (UTC)
Date: Thu, 5 Nov 2026 08:57:23 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
Message-ID: <20261105065723.Q3ED0%taahol@utu.fi>
In-Reply-To: <xmqqfqyieokd.fsf@gitster.g>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
 <20261006055002.M9X9O%taahol@utu.fi> <xmqqfqyieokd.fsf@gitster.g>
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
X-ClientProxiedBy: ex19-08.utu.fi (130.232.247.48) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIXUhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWlpIDwEcDwEcDwkMDw0cKA8FCQEERgsHBUhYSFlfSA8B
 HBscDRooGAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhYSFtaSAMaARscBw4ODRoACR0PGwoJAwMoDgkbHAUJAQRGCwcFSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=mo+jWWIUp511QzGNbrjy1+yLYPUYE3Alch1Rapl4Pw4=;
 b=aeEgWxv5rnDBxI5jbLNpaIUTVsBJ5+6rlsKnp8zIQVb2aJ9UCZgNr4/jtjONK8ljpr3hxvZB3JpC
	rRaf2+oCQffzaFK/Ffa2FgSixVR0xkzbtZtXye+/F4poWpG03RdDNkiw8wFUrBPilNxNviqlBZh3
	NcD4G29C3F5yW2xqJEY+4tPa0po/cADSq8rh9Eb1fEgbUlfT7nxTUXQh8H7P9qyrksllpu4I/uQm
	LQ37MN4gI4pjblfa6m11BCENUOn57un4sqvolkzJltJfBLp2STw69Ti/HPx+EnyMVAZ1FqOIRFCc
	GKEZUfjsZiiFpUlsh3K64P94npUKoJ+1w7h41w==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> >         gittutorial(7)
> >             A tutorial introduction to Git.
> >  
> > +       gittutorial-2(7)
> > +           Obsolete tutorial.
> > +
> >         gitworkflows(7)
> >             An overview of recommended workflows with Git.
> >  
> >
> > And let's not worry about that exception you mentioned.  After this topic hits
> > 'next', I can rebase mine on top on of this, and deal with all necessary
> > integration work.
> 
> OK.  So ...
> 
>  - I'll tentatively eject both topics out of my tree,
> 
>  - Julia will send in a replacement that does not add gittutorial-2
>    to the command-list, which will be merged to 'next',
> 
>  - and then your topic will be queued again with an evil merge (by
>    me) to add gittutorial-2 back to the command-list file.
> 
> ... and both topics will be happy?
> 

This topic has graduated to 'master', so we should be more than ready for the
last bullet point.  Please pick up the rerolled ta/command-list-guides-sync-lint
at <20261029184834.2273-1-taahol@utu.fi>.

$ git cherry -v origin/seen ta/command-list-guides-sync-lint
+ 9a1ba61ac0e4491a4f028250be478cfcf05c9ef4 command-list.txt: add gitformat-loose(5) and gitpacking(7)
+ 5d36d7585956d17172012c8e42d77597524708e8 lint-docs: check the guide list in command-list.txt

--Tuomas
