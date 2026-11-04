Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820899;
	b=YFvDwMGRPdvxXZP4tc05O/rNML4d5WbqYW8uZ/xfXDNMgQmSkJGxf74DCAYBW9TYCREM
	 xlwQ4Q3IneL+/gHk9YLZ/IUC8uwH2TISueTz7IXm070Z85/2oZ4usbCmvXYDQTJgherU+
	 LelNxJEtmjA3hJzSejInle6/DvB5cm99kauhpX2zfr3BG8M31yYQEyV+xCS0UTNCN9Rgr
	 nHwkmDU9NSVTiLcphprjAEI3mC9TmyewYyCowcxxNSd2cb8Vc8YR/3KfFWdcDvCwWREeC
	 qe5yJ12uNBNESHqdoSjjo1TlUi5jprErJvpRrGtoNt7pHldehHH9bw2wvTTQwFGudbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820899;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=ILbhOYGm5klvPLWc+WVJ8aYiznjqYDoB/MOlSoE5d1E=;
	b=H1OkjqEWbsm2AwUy6nvJwMWpovgmExxx9MeczKImQ4zuBrdlGiC4jHXNM9WaCpPHW881
	 /ZzyZfZ/8peuNcnDMp1lkLrKmZiH0h9C7Fk12hc3thrf8dtd5boRz7Z5ZBBVAZMws6F3c
	 S/gQucGmelepB6+YUoFXf0trd+yVCRLlaLuhyDcByO8AUWiJ73/bGG4mn2IuUaxwW30sh
	 jHM57WLRkyqh2Z3B1uo2RvyAi4+Bi72yB+qsSUA5KuH3fsE/W7m1eVq48rLE3Ko6xJuNa
	 QZoznZ5dGhxSD/mgRgSL2Kvx+QgdKA2vwin4Aj/ynIUmv/LRPO9n64yhSa6FBY9sZmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="hA//CW5Q";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B5606E835
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 342B5606E835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=hA//CW5Q
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A4JYpJd029420-6A4JYpJf029420
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 4 Nov 2026 21:34:51 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xOgl1-003l47-13;
	Wed, 04 Nov 2026 21:34:51 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 21:34:50 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id e69605da;
	Wed, 4 Nov 2026 19:34:50 +0000 (UTC)
Date: Wed, 4 Nov 2026 21:34:50 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: update the required Perl version
Message-ID: <20261104193450.XvTBf%taahol@utu.fi>
In-Reply-To: <xmqqjymvooyn.fsf@gitster.g>
References: <20261101185846.24208-1-taahol@utu.fi>
 <xmqqjymvooyn.fsf@gitster.g>
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
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=ILbhOYGm5klvPLWc+WVJ8aYiznjqYDoB/MOlSoE5d1E=;
 b=hA//CW5QaNoH2uk3lM0QljAe53VVcl5MUh3nvHx7O78YJIBE8Z+cAz6GN8bdniq5dDa+gqxr4c61
	9fFvf18IfCOJsbSXkUY/AnS9xuDnpP8QFi8DwsEuXH0vlQLjpHzYXoFosjCx4BlJNgMOelZANSgO
	QbnZXQcC1UN3QTZAGglo8wB9bYZ/LAKfG5m+kp5MQRRVdzyHKo+cuCVwKdw7BtU58+OwZaKy2oEs
	52T4ilp9Tf9nROU0gZEti3Pl5LVYQiFQ8bgwcZ0GUQYYGxnFPMfp9SJjMIUM7Wz/igZyo7oCLXFX
	2+k/iIrPRGuJpf7O1O+Nk29kt0apEMw8GvRLfA==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > 702d8c1f3b (Require Perl 5.26.0, 2024-10-23) bumped Git's Perl version
> > requirement.  Update CodingGuidelines accordingly.
> >
> > Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> > ---
> >  Documentation/CodingGuidelines | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> > index c06f5d3071..9b17ab34db 100644
> > --- a/Documentation/CodingGuidelines
> > +++ b/Documentation/CodingGuidelines
> > @@ -703,7 +703,7 @@ For Perl programs:
> >  
> >   - Most of the C guidelines above apply.
> >  
> > - - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
> > + - We try to support Perl 5.26.0 and later ("use Perl 5.026000").
> 
> Is this in line with what 702d8c1f3b did?  Shouldn't we say
> 
> > + - We try to support Perl 5.26.0 and later ("require v5.26").
> 
> "require v5.26" instead?
> 

Frankly, I don't make head nor tail of such Perl minutiae.  I would find that
parenthetical much more useful if it told exactly when we are supposed to use
such incantations.

For example:

 - All new code should carry the line "require v5.26".

or

 - Please consider adding "require v5.26" whenever appropriate.

I'm not really sure how to proceed with this.  One option is of course to adopt
your suggestion and call it a day.
