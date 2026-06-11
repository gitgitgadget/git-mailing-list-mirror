Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041435E1D5
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159128; cv=none; b=JNT8vPPGkDIGwYhqHACaVXIO5ByJrcTq2+uCiwldV+dO/48otXjIis4vk/agnCY+hobw8tqiycihCcyxKf/B0tJaWSVoZviulEHbPVF96AqHQN6NSrV/eoRKr//yUXNGixI8TvmaU2GP5mpLKNqZocPr8BvFG7fxzwLjP3IIZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159128; c=relaxed/simple;
	bh=pYpR8rtBpFPwm0avd8cWyfVYzg0YfL0ETXiE6ulTFwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNhFe5J0NrzMYXHBsPAqw3XaSIYh+xGcqLd5B6OQr1tIcbkuEs7mwTwCGMyGKvF2340F33L0Raxxr+34Mp8L2Y8ygLk/sdrhgYt5YsG0coviMkaLAXPHPVk3ZiPKngVmGemIikrBZvWZnIbODljtpX7Ki8khYHl1SS92fzsmfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QFsGds7/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QFsGds7/"
Received: (qmail 106227 invoked by uid 106); 11 Jun 2026 06:25:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=pYpR8rtBpFPwm0avd8cWyfVYzg0YfL0ETXiE6ulTFwM=; b=QFsGds7/PV8cGSrERX1GQRO/lrmdES+YLmj1WKJX1xJeAk7/qMzuL33anS+3oTQj0qf+8bBnxpDmNa4FayWi7Na6YKmZri/HaD2nCsuljZg95q+c8ohNdAAeKAwZkzPg8QAunZHRkSceBLpn64obRi6l5sjOEdZWoGfyPqUVxqkFaYlUPXGPGAeesAGfS0INsvvwP8s46ye+ugyFciMtTtHBxpnPvpFjW/JH4tGE1z41N2Z84N40ssZce4SUqMKNRkZFsywM0GRJdzxtWYx1dheNs464et9LQlVrs9W1QfVwdvjryZKaYNANBfuzFY/+9uaq0AisOMsX2a5LPJpscw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:25:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 313745 invoked by uid 111); 11 Jun 2026 06:25:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:25:30 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:25:25 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight markup
Message-ID: <20260611062525.GB2189088@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610225513.6269-1-taahol@utu.fi>
 <20260610225513.6269-4-taahol@utu.fi>
 <20260611061156.GC2187173@coredump.intra.peff.net>
 <20260611062423.GA2189088@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611062423.GA2189088@coredump.intra.peff.net>

[and naturally I forgot to cc Jean-Noël; resending, sorry for the noise]

On Thu, Jun 11, 2026 at 02:24:23AM -0400, Jeff King wrote:

> On Thu, Jun 11, 2026 at 02:11:57AM -0400, Jeff King wrote:
> 
> > Though curiously the case of `#` in git-fast-import seems not to get
> > marked as <code> in the html output (even though the nearby `LF` does).
> > I wonder if there is some special treatment of `#` or something.
> 
> Ah, weird, it has to do with our config file.
> 
> If I do this (not in the git repository):
> 
>   echo 'This is a literal `#` symbol.' >foo.adoc
>   asciidoc foo.adoc
>   grep -i symbol foo.html
> 
> then I get <code> markers, like:
> 
>   <div class="paragraph"><p>This is a literal <code>#</code> symbol.</p></div>
> 
> But if I build with:
> 
>   asciidoc -f path/to/git/Documentation/asciidoc.conf foo.adoc
> 
> then the grep shows:
> 
>   <div class="paragraph"><p>This is a literal # symbol.</p></div>
> 
> Looks like it is due to our [literal-inlinemacro] definition, which
> comes from 974cdca345 (doc: introduce a synopsis typesetting,
> 2024-09-24). I think this might have been an unintended side effect.
> +cc the author of that commit.
> 
> For the purposes of your series, I think we can ignore any issues with
> [literal-inlinemacro] for the moment, and decide on "\" versus ``
> depending on which we prefer.
> 
> -Peff
