Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B038655E
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849797; cv=none; b=gKT76+FSX4ZxREKmfRVXrx22JFjQe0+HzXzmBm+eLMDNpU41BxIn0axLLFZuFUP9dYR87nR4K8I+/cfoHyZ0xM/CjFv3xgzRKxS8kmGPkFfbWDfFmKBBsSZokjX+kK28zJyu3lp3HOgvE8Mn7g0+10FUQQEUMGI65X1OhaokMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849797; c=relaxed/simple;
	bh=HlqizusbViqTHksfT9Feu2m/r918LEWny5s4ND8Fy28=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCTA+FbQptYDHk+MyOZccYtYkEmuwSnjdxscY1BoKKuNeCERvSOh8i8jK5r8eD4rNNpbI5kCgYr5l2/MAAvkoVz0PS+4mJ3l3GwRn1QYytdsch5kKVr4/MSc8NARzeAjEighleaKPs9wkPwSFYzFtdciYdHBpm67pFqz4CuWSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=AqAp2kWQ; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="AqAp2kWQ"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6886h6lF002639-6886h6lH002639
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 8 Sep 2026 09:43:06 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x3pXu-006lZe-BD;
	Tue, 08 Sep 2026 09:43:06 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 09:43:06 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 2370606f;
	Tue, 8 Sep 2026 06:43:05 +0000 (UTC)
Date: Tue, 8 Sep 2026 09:43:05 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
Subject: Re: [PATCH] lint-gitlink: don't use empty lower bound in .{0,8}
Message-ID: <20260908064305.PIgoB%taahol@utu.fi>
In-Reply-To: <xmqqo6e8za5e.fsf@gitster.g>
References: <20260907184858.13475-1-taahol@utu.fi>
 <xmqqo6e8za5e.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-06.utu.fi (130.232.247.46) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIWkhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=vMgjV+i5blWjSEbC40/86+edZlSmG7EMJgk4yT4tNbM=;
 b=AqAp2kWQlESGhVXiUH6B1IIXLB1Mm/rV+EyVqtlW9R1LndEGtvlagpKF0RbOAvv0G8GmxkIqOKNw
	e6dLJHOup+vZFNLH8ql0ey7m5/6S7Ab2DriLy34jwDTDuXV47nujv2wbG41cVRKoSxhbYfWJr67H
	ZJWiQbeLobgKaubL6gjhxwD8WLtldmILOh+iyOxo0s/Dm1bXq2M7X2WgeTaZUGn3xAHoWRZc8wDa
	i4SE7JJDlTHBC1FCPlJHAzt89s8u7F5um8kVSCro73wcfBOUJYjcmujXU0PfYcX1flo7y2myri/K
	xFKRT5u69wGHIizn2OuMszDj7/DsdACLD0JG/w==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > The regex quantifier {,n} was added in Perl 5.34.0 as a shorthand
> > for {0,n}.  That makes it too new an introduction for Git which
> > targets Perl 5.26.0.
> >
> > Even though Documentation/lint-gitlink.perl is a development helper
> > script, let's stick to the general Perl version requirement for
> > consistency, and use an explicit zero in .{0,8}.
> 
> I am curious how you found this.
> 
> I somehow find it unlikely that you were sticking to Perl 5.26, ran
> "make -C Documentation lint-docs" and saw your tad old Perl complain
> for syntax too new.

Well, that's what happened (although my Perl wasn't exactly 5.26).

> 
> Perl 5.26 is from May 2017 while Perl 5.34 is from May 2021 if
> https://cpan.org/src/ is to be believed.  
> 
> Will queue.  Thanks.
