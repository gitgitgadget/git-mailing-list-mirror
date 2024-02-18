Received: from smtp.roethke.info (smtp.roethke.info [46.232.251.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68905383A3
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285096; cv=none; b=rFc50VeDOR23A1TkatLeEefiTrwGXw6+f1Auz9rvDHbn50CBNYW7Y08gJMpsVvY+TaNRTH6gmPARaYCPLVjtp0Y93hLfnPHzSSrk9T4iDNiH5rS6LPNRGRSgELz6Rt/dB9w4thLoBApI8vliNF55ES2rRX9SA+POG90i+mzJGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285096; c=relaxed/simple;
	bh=mLONKdQCQVAi96Dkfjhfx19Q0fk5OBONuoRCgSLlv2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVK5b0U/8CLcyTG3L/ISmDg5AWtrrY6VQIeJu9OnUBMyn35ASeNk7BcLjyXFRiFp/MSf+SxDX1LXnfVBb/01vB684y2rv9lP9/hIK4k4AWSOkKNygtUiUFREf80s/Qis4sFv9ljO8wzPJ1gpZ85+E45WEM1XASo1BTS9brRVWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info; spf=pass smtp.mailfrom=roethke.info; dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b=UL0K3Lsn; arc=none smtp.client-ip=46.232.251.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=roethke.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roethke.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=roethke.info header.i=@roethke.info header.b="UL0K3Lsn"
Received: from localhost (unknown [IPv6:2a01:41e1:283b:1000:bb91:34f7:c1e1:8a6d])
	by smtp.roethke.info (Postfix) with ESMTPA id BA70C1E0004A;
	Sun, 18 Feb 2024 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roethke.info;
	s=20200807; t=1708285090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V36U4jCNC2zcvBP/fXaN5DfEcEk2SwDmwm1r2NgZp/w=;
	b=UL0K3LsnUrz8Oo9m2PZQUf84xASZrWnprCDA4Z+u44bPzspmEn2Rje7uRodbRw7XqHifzj
	cqoYylb5qzoZJ2oS3gmlzpe5lAhw/a4PQMAgicSD2VLKVfno+bXkknVSJLRVdePlLVN3kX
	5LHj/N6goA8BISEREfO7aFJvt6xCI1Ej1dxc5JZrr2WfI9PRsk3ZJMClzyw9NO/SNr7GaZ
	r27NQRDMAlSw24lUoj5rA1+0D7plZi1Qxwyp9CAK5OCXrwbhlyN00K6o1HdWwI9pNlARZY
	YBERfozVGV4cXb51PwRmEB0QH2pnKWlR8yLNWbtRZAlW9TREamM26O/Gp3PEYjwVkGhmRt
	rKOmmTSFn3w4Cn7P2V8xhs5Z628kxhF2ycjJqVxFzqv3wSTY1R1zuPW2p8gOquhv/U+a3E
	i8SfAzBgQTk8P3YHgi5OjND0orY0VShdLsKAQqYXTbC8QeFBuk0NxaJrFGKH4PqL3+NTPd
	qvy9DE12/Z0mBQ1slrV/ghqCSyYAHQqhChW8rMHLlEWtd/sVngv/hIY8A+GDnQ2Rb4nu5I
	HJWiUomY7sadVrpjMKDs1oeGtffgu5PGHwuM6wL0qSZDMVJ9NZ9VJfHXSjjVksG5RXbUYe
	F3VQ3Vm6GFgRDjZ7im2ciG3hqpGqW7uJcovyryX2z3lL7RxzyEC/Q=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=marcel@roethke.info smtp.mailfrom=marcel@roethke.info
Date: Sun, 18 Feb 2024 20:38:09 +0100
From: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rerere: fix crash in during clear
Message-ID: <ZdJcoYaZEnUNoQSQ@roethke.info>
References: <20240218114936.1121077-1-marcel@roethke.info>
 <2359c888-a061-44ed-9d69-2aea9e1d3d80@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2359c888-a061-44ed-9d69-2aea9e1d3d80@app.fastmail.com>

On 2024-02-18 14:02:42, Kristoffer Haugsbakk wrote:
> > rerere: fix crash in during clear
>
> “in during clear”? Did you mean “during clear”?

Yes, thanks.

> On Sun, Feb 18, 2024, at 12:49, Marcel Röthke wrote:
> > When rerere_clear is called, for instance when aborting a rebase, and
> > the current conflict does not have a pre or postimage recorded git
> > crashes with a SEGFAULT in has_rerere_resolution when accessing the
> > status member of struct rerere_dir. This happens because scan_rerere_dir
> > only allocates the status field in struct rerere_dir when a post or
> > preimage was found. In some cases a segfault may happen even if a post
> > or preimage was recorded if it was not for the variant of interest and
> > the number of the variant that is present is lower than the variant of
> > interest.
> >
> > This patch solves this by making sure the status field is large enough
>
> You can simplify “This patch solves this” to “Solve this”; see
> `SubmittingPatches` under “imperative-mood”.

done

>
> > to accommodate for the variant of interest so it can be accesses without
> > checking if it is large enough.
>
> “accessed”
>

done

> >
> > An alternative solution would be to always check before accessing the
> > status field, but I think the chosen solution aligns better with the
> > assumptions made elsewhere in the code.
> >
> > Signed-off-by: Marcel Röthke <marcel@roethke.info>
> > ---
> >  rerere.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/rerere.c b/rerere.c
> > index ca7e77ba68..3973ccce37 100644
> > --- a/rerere.c
> > +++ b/rerere.c
> > @@ -219,6 +219,9 @@ static void read_rr(struct repository *r, struct
> > string_list *rr)
> >  		buf.buf[hexsz] = '\0';
> >  		id = new_rerere_id_hex(buf.buf);
> >  		id->variant = variant;
> > +		/* make sure id->collection->status has enough space
> > +		 * for the variant we are interested in */
>
> Multi-line comments should have the delimiters on separate lines from
> the text. See `CodingGuidelines` under “Multi-line comments”.

done


Thank you for your feedback!
