Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598712;
	b=X82UFv/l0yRRg4yGCxtvqTM32eheK91bYCmRNU9K4GNWuGYZtwiRRMw+3Oxe6PSZc6s4
	 e25dcExJB5bOWpxSAtUdSbdAkoGOKYm/qbICdO9MCNn5SKqrYBLCf2dZ/lr64xefzmHVG
	 iSCMGSk8wJorgUHhlfFaBJLneiHxCpys6GkDwLI3L3x63nz60iIBBX7ACusIhmJIR/9WY
	 BYzt23K1DPGOZHCD5n5j+oxLC6uEoaJF7n+SCdylsfnJhCGiUx9AQPWmlvaItgmymSUU8
	 VL66Z02m9Ysc4F8xzzz3bVqUefGwMMd8k7ZtoskGeEFPHjbimsAn6YHgi+3HEMTiCqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598712;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=5p3ZMuxopt3pO6jQWJRsDkjb/c84t9LCJ3ojof5+oW0=;
	b=PqVuDOlTTW+642zb/4eUoqniliQAvyx79rGxETAHi93GrfXdA0TZDhM5T4siJ8j2R1yQ
	 A0fgGRwJsVsiwjpYID9xeE9qIVm0yrpzZzoQqpTPeBS9M2oHuiA2ZceKT4V6pweVUCo1h
	 RcCeaTUvnyXFMdbTrO0RgeA4FOQKG1OearTtd45+B2CDZvOhC8502BagrB+03C4pwPtD4
	 JJDQw8Oys4or5wpMF6rO1/0jh3w/XIGzJ/7+zkPSqvl9lBTpdK2BV4lgguvO6FBn5mofw
	 WgWKeGERhYEC6Db+oF5zYAPGF4IemFn2FDkKMWKMVfagOO06QtJE0A1JE+M4Qf1xLow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=m6zJhZbo;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE4606A32E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 19:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EFE4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=m6zJhZbo
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6ADJcCHf028824-6ADJcCHh028824
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 13 Nov 2026 21:38:12 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xRx6C-00FMnW-9g;
	Fri, 13 Nov 2026 21:38:12 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 21:38:12 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id fe3b0a1e;
	Fri, 13 Nov 2026 19:38:11 +0000 (UTC)
Date: Fri, 13 Nov 2026 21:38:11 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	<git@vger.kernel.org>, "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
Message-ID: <20261113193811.cjM3D%taahol@utu.fi>
In-Reply-To: <xmqq33t4eh84.fsf@gitster.g>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
 <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
 <CAOLa=ZTAYtq0K4YfcSBocf-fxadTiaJp+AV5-_6_pbNMBwYQXA@mail.gmail.com>
 <ava6Q1u65ASVeth5@pks.im> <xmqq33t4eh84.fsf@gitster.g>
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
X-ClientProxiedBy: ex19-13.utu.fi (130.232.247.53) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXUhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhaWUgDCRocAAED
 RllQUCgPBQkBBEYLBwVIWEhaX0gFCRoDCwAdCwkaGgcEBCgOCRscBQkBBEYLBwVIWEhRSBgbKBgDG0YBBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=5p3ZMuxopt3pO6jQWJRsDkjb/c84t9LCJ3ojof5+oW0=;
 b=m6zJhZbo0XXMFEkuKRKhjHs91OQ+Xn/TRgjvCNGZY6VJMx3BagibIFcxYFhIYbNUajZ0+xUWg9Pb
	siT/b4OB7GR1LCPnAZh5YhZDdcFWSotqh5azhz2eRYWKL0LQ2E1V/TnfJvi3T8eLWRuJ3zdBIQZY
	kmTbJS04LaDieEPl33PYIruLi0RhFgDHQKZ0GyJxPo0LrZW0m6Vj9nzvarucmoRAbmb9j1fBRnqL
	BGteOvPrQD/kYnlONH6GW4u1ylK1M9KPn4FZl3d6FIegOUWyvy0jObVmd1z3RWWxkL+Ux2RRJjPy
	/JhC4sso8egAquW9fYT5SOVygrgQX0NglEfD1Q==

Junio C Hamano <gitster@pobox.com> wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> >     @@ rerere.h: struct rerere_id {
> >> >      +	RERERE_AUTOUPDATE = (1 << 0),
> >> >      +
> >> >      +	/*
> >> >     -+	 * Reverse of RERERE_AUTOUPDATE. That is, update the file in the
> >> >     -+	 * working tree but don't touch the index.
> >> >     ++	 * update the file in the working tree but don't touch the index. This
> >> 
> >> Nit: s/update/Update
> >
> > Oops, good catch. I'll refrain from sending out another version just to
> > fix this one fix though. Junio, I'd appreciate it if you could fix this
> > up in your tree. Thanks!
> 
>     $ git checkout ps/rerere-subcommands
>     $ edit rerere.h
>     $ git log --oneline --first-parent master..
>     $ git commit -a --fixup HEAD~10
>     $ git rebase --autosquash HEAD~11
> 
> By the way, I wonder if we can simplify the last three steps in any
> way?
> 
>  * We can use 'HEAD^{/^rerere: convert flags}' instead of counting.
> 
>  * The last "rebase" does not have to be on HEAD~11; as long as it
>    covers HEAD~10 it is OK, but we cannot use 'master' as I am *not*
>    interested in taking any new development from there, and I do not
>    want to worry about what the command would do on the merges the
>    topic has as synthetic base.
> 

Just for hack's sake :-)

	$ git rebase --autosquash $(git rev-list --min-parents=2 --max-count=1 HEAD)

> Perhaps with newer experimental commands it becomes easier to
> manage?
> 
