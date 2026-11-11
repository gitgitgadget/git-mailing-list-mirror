Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434418;
	b=Wl0LEX0naz06L6h/hWYKWi9LZiURxI6MUPF9KGf6uIvrlmCTGiPrPCHDua5lMpSLl3d2
	 FZ5FL++WhcmDnSFx2IAb4+TYxo8L41RoNbI8nHl0hgiKZsBdWOpkfoavDr5ya0fMY9Ieu
	 M+UViNoC7j2X3kmGZbCZDQVaA9Jzw8ERGm6TI8fDoFU9TDqvxYk631vBKFFUQQhZcEobO
	 LAGlJcwoUjM/ESGcr+hXdbcwDAS3kKIUX1bnmH5M5CE1vr9NtaEAG1wW+wjLTomPrMjOl
	 XuMdYHrLOS0KYqpft6giDE+hz+A4cTJg2chVyQ2EA/1K4bu/5iWgyrkq0lbhlBR6iMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434418;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=wf9nFLYqEflN651UFGPZn4/edKetVQlTHcnSIa4zlr4=;
	b=3429gGhfdRPiCwU1Rt3mMck/NztECFL6wnWON6+WjtoVV8PBboBDEGOW42pipm8aFhFT
	 f+mD3lV0jpiD0q7I4A8zFZprM2+4ui6bD5le+26k/tNs2HMWQtgJkxMUjpD98FdiIrrsE
	 hk+pHdVAYRHY1B8wCE0cXrbV/0sENjUUfD7ez/t1GOh5E1aW+JPyLUdHmkK6GTaXZBq+a
	 Aj8lxQI/oxLRUIPeG/l9Ii/o7/oMbevGfDmE/vm3uWBd4xb43PEgfTDfjcQFgX3kEI8Ic
	 Up38h5SftvERYwQ7Cc0N5cr6QHqFkRutZPq3PWX4wzSfwqjnb6oGy8AP0SiS+zgzdTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=nXLbjylL;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E960A5BC3
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 268E960A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=nXLbjylL
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6ABM034l013147-6ABM034n013147
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 12 Nov 2026 00:00:03 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xRGMM-00CYDc-Ti;
	Thu, 12 Nov 2026 00:00:02 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 00:00:02 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 78f1773d;
	Wed, 11 Nov 2026 22:00:01 +0000 (UTC)
Date: Thu, 12 Nov 2026 00:00:01 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Julia Evans <julia@jvns.ca>, Patrick Steinhardt
	<ps@pks.im>, Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King
	<peff@peff.net>
Subject: Re: [PATCH v3 2/2] lint-docs: check the guide list in
 command-list.txt
Message-ID: <20261111220001.VKwmr%taahol@utu.fi>
In-Reply-To: <xmqqcxsjt6b3.fsf@gitster.g>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261029184834.2273-1-taahol@utu.fi> <20261029184834.2273-3-taahol@utu.fi>
 <xmqqcxsjt6b3.fsf@gitster.g>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEheSFhIWEhYSFpYSAsHDA0oAwAJHQ8bCgkDA0YGCQUNSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFlfSA8B
 HBscDRooGAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhYSFlbSBgNDg4oGA0ODkYGDRxIWEhRSBgbKBgDG0YBBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=wf9nFLYqEflN651UFGPZn4/edKetVQlTHcnSIa4zlr4=;
 b=nXLbjylL7dDeb4zVsS2fyzfsM0SgM/mm3+NeSU4s7//Oc1FffIIBnKuO6PHIVfU1GQW3blgaZmvp
	faURmmXZbqMn7ZzVLWVlugVaZ1KiYoGFIiScW+xUwEMDibTFc2qJDHmP19zsSWulQ7MtDbavKduC
	y7CFBdEm1z8aq0Um8OC718/K3XSyOM/8hF6bi7OAQ6g21kBExUe/8EWZkIL4DjhEa1GZsUpfj1BD
	KEAkZv+RGMuV/udnZJgbn5P4hzi5hZ/OoidPzkjyWKvMDtSdNOLBvlRiE5RxDij0XPEOr2acwZvt
	GLoxiU53JJW53gh5hrklumCDKjeZJSh7IBrqRQ==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> >  extract_variable () {
> > +	file="${2:-../Makefile}"
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
> 
> I like this sayIt pattern to prepend a snippet in front of the
> Makefile.  As we allow extracting from different Makefile with this
> change, it would make more sense to (1) make the path to the Makefile
> mandatory, (2) move the path to the Makefile first, and (3) use not
> just the $1 but all the remainder of the command line as listing the
> symbols we are inquiring.
> 

Hmm, sounds sensible.

> which would mean ...
> 
> > @@ -87,6 +91,7 @@ check_extraneous_docs () {
> >  BUILT_INS="$(extract_variable BUILT_INS)"
> >  ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
> >  EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
> > +MAN_GUIDES="$(extract_variable MAN_GUIDES ./Makefile)"
> 
> These would become
> 
>     BUILT_INS="$(extract_variable ../Makefile BUILT_INS)"
>     ALL_COMMANDS="$(extract_variable ../Makefile ALL_COMMANDS)"
>     EXCLUDED_PROGRAMS="$(extract_variable ../Makefile EXCLUDED_PROGRAMS)"
>     MAN_GUIDES="$(extract_variable Makefile MAN_GUIDES)"
> 

Okay, I'll do that.

> Other than that, looking good.
> 
> Thanks.
> 
> 
