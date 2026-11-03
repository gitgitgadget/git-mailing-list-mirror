Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725812;
	b=YEcyW9M4no/3GOIhe2irpVAEVixsIO/I3SXk1Yn53uICjPqmvmPLOdzdKrB2wkwLGefx
	 Ux/M+UcPuaanBriHM2gaega1DTW511c6ESzbH2m5pGZMDh0ef7IIOmruUwrOr0GcDJ2mn
	 2OWgkLEEa4Vl2d60jkXcqHbtnKq+Q4DcK185U6WEFWlsCO2JdP1HnQRaaYQbOvbrMGih6
	 yeir/9RE9v+fX1/l7BJa55Twx9rJN3RvFpOW0VWQbFpjq/JULFqxh3stsI3hS9QMMw3ac
	 jerFSQ16ziuDxrweHiaBunc6qsiQEXU2K5uB6cLWB7aPLOUvcIwV6FsruMOz6/8HtHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725812;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=FT7UjN3V7E8amGBrkiBHNu6+HHVXS6szCC8NW8cQjE0=;
	b=Sj1xOevW3NxbLcIwGbxERzv1LwWkq2rsmskRBOP0jgYOKk4+bdJucSH4/jJuB18zZAcj
	 AF7OYMz6DIX6EymnxhG1pHKUakqDkUbE/FS193tVEQZhmVr+JF1piTPehufbnyz9xKh36
	 DGZhY6Uj6ohNLWSPDnI2juCKIf4ZSsvbEKEsLWenUFeDk3gQZcIryTdHXYssswDWm0SBP
	 m+p2GSDWY+q68ciOU4eb1XWmomf3GX/HIfEreydr/nQXQ4d/fBDgqOMDsxXIn0VgzJmMe
	 LimI/br9sKwUuwQ/4QtQ9fDDzAngCGhpF/vQXJHabU/q80DHhqD6a5cDxmAcEiOJQ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=KbHhGsLX;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF8606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8DF8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=KbHhGsLX
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A3H9inv022289-6A3H9inx022289
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 3 Nov 2026 19:09:45 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xOI12-002556-LT;
	Tue, 03 Nov 2026 19:09:44 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 19:09:44 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 04e48d1a;
	Tue, 3 Nov 2026 17:09:44 +0000 (UTC)
Date: Tue, 3 Nov 2026 19:09:44 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Julia Evans <julia@jvns.ca>
CC: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] lint-docs: check the guide list in
 command-list.txt
Message-ID: <20261103170944.kmZMv%taahol@utu.fi>
In-Reply-To: <48aa1e9a-3049-4316-9054-644a8754b0dd@app.fastmail.com>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261029184834.2273-1-taahol@utu.fi> <20261029184834.2273-3-taahol@utu.fi>
 <48aa1e9a-3049-4316-9054-644a8754b0dd@app.fastmail.com>
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
X-ClientProxiedBy: ex19-10.utu.fi (130.232.247.50) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gYDQ4OKBgNDg5GBg0cSFhI
 WkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEheSFhIWEhYSFpYSAsHDA0oAwAJHQ8bCgkDA0YGCQUNSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFlfSA8BHBscDRoo
 GAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhYSFlbSBgNDg4oGA0ODkYGDRxIWEhRSBgbKBgDG0YBBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=FT7UjN3V7E8amGBrkiBHNu6+HHVXS6szCC8NW8cQjE0=;
 b=KbHhGsLXnb0Te/isZShZ81Z0fYVFsyHxOdj0MsnkVdkbUBViL6I/mQDQeqLpFmAfO5eDJzLpTs3D
	/yvOKgu+nlwSTmGCVsMHCk9uO2EmByPwhfmXL46TyC9IJStc3KPg9mjdJ/4AOWYk65Y/5ov8RO9k
	Yd19Az4QWj23MKpdkg4ECx+eXZ82WM945+aa+m4+GcUdVI0pIcvZBGONoQWouWjfWWy7UQva0CqN
	RpM+w1ubrMURmQmS1/QxAnCe5u09S3kA9hLINasgv6lOJwzMIEdFAf/s/vbiE9u/nqpxktDQMjP6
	uCMf0AhlC7+bNdvN7/DSjtlBLK59fFqPZ3O3+w==

"Julia Evans" <julia@jvns.ca> wrote:

> On Thu, Oct 29, 2026, at 2:48 PM, Tuomas Ahola wrote:
> > diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
> > index a0ea572382..31ee3cbe72 100755
> > --- a/Documentation/lint-manpages.sh
> > +++ b/Documentation/lint-manpages.sh
> > @@ -1,21 +1,23 @@
> >  #!/bin/sh
> > 
> >  extract_variable () {
> > +	file="${2:-../Makefile}"
> 
> I think what's happening here is that previously we were
> getting the variables from ./Makefile (in the basedir), but now we need
> some variables from ./Makefile and some from Documentation/Makefile.
> 
> Would it make sense to get all the variables from Documentation/Makefile?
> 

If that's possible, then sure, why not.  But I think we are mostly extracting
from the top-level Makefile such information that simply isn't available in the
docs Makefile (and vice versa)?

> > +	directory="$(dirname "$file")"
> >  	(
> > -		cat ../Makefile
> > +		cat "$file"
> >  		cat <<EOF
> >  print_variable:
> >  	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
> >  EOF
> >  	) |
> > -	make -C .. -f - print_variable 2>/dev/null |
> > +	make -C "$directory" -f - print_variable 2>/dev/null |
> >  	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
> >  }
> > 
> >  check_missing_docs () (
> >  	ret=0
> > 
> > -	for v in $ALL_COMMANDS
> > +	for v in $ALL_COMMANDS $MAN_GUIDES
> >  	do
> >  		case "$v" in
> >  		git-merge-octopus) continue;;
> > @@ -29,6 +31,8 @@ check_missing_docs () (
> >  		git-stage) continue;;
> >  		git-legacy-*) continue;;
> >  		git-?*--?* ) continue ;;
> > +		gittutorial-2) continue ;;
> > +		gitweb.conf) continue ;;
> >  		esac
> > 
> >  		if ! test -f "$v.adoc"
> > @@ -87,6 +91,7 @@ check_extraneous_docs () {
> >  BUILT_INS="$(extract_variable BUILT_INS)"
> >  ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
> >  EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
> > +MAN_GUIDES="$(extract_variable MAN_GUIDES ./Makefile)"
> > 
> >  findings=$(
> >  	if ! check_missing_docs
> > -- 
> > ta/command-list-guides-sync-lint
