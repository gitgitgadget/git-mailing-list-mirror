Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F5233957
	for <git@vger.kernel.org>; Tue, 19 May 2026 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188275; cv=none; b=r6E5T+oK7RLrqBI6rjETPTmiFEgX+Q4igReoDUMB8K/DwAskUqk8abdlpE5n3HTGHWalv2PRIWLZzbW75aaNrDbo1SAmDie90EbnleRaTZHy9+iYg0E4vhJuYRer84I3yeNMpKsOsOmiRYNiRV4koKjg6zwhhvHfbXX/NptVGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188275; c=relaxed/simple;
	bh=X0xsVfECpnHYcyLFASqDAGzazWzqOyMusBaDKnnkCDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0PhGgQ93HzHn2xN7n535ZpOdSIFrqCVhUMTdIuAz+JwVW0yjlgDiHFcGLaLoUh//Xq4EJOZU3qOg3CgX27lBehBF6Lq29zhksgRVfQ2ITR83/z0EvbHLaLaSM44KHonvy6unBEbonavo9FIDgeuCF0132Mqw6IeL1CjnO7hRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Bcoq9mxy; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Bcoq9mxy"
Date: Tue, 19 May 2026 12:57:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1779188269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DRt1LeV96G1LkoLqKojd+81yaiyN23rrlobSbTYg/G0=;
	b=Bcoq9mxyLP1dkKAbOSpcvSGJZDwkkr7znYt38FJvw/LAfwn/0Nq65N4tNDI7fqMBYcdXE2
	CD4ByUiMbN1jSWjuNPQSQCH0HOGaF2nxgL8nNFyCoID5JoG/D+dZ1EDp/FMalh4JHDiSrG
	+O4yPmh9ZXuiJUEa+8qwpZlrllmgzAZpklhVhE38uKdbVe6C9hKj/DWjuvBefH8rvigxDL
	eMacmD/lcwoNy1qJ60jVm3/QLZiCp1+FstV4KPSbX5M6iG6RvqdR0WqSFcffF2/n6mKebt
	8MERw4VJivTYUczGUnmPIA82fbncIZo88JiOByzS8vr/tJdvQpyqTPMVASq9WA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Chris Torek <chris.torek@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v7] revision.c: implement --max-count-oldest
Message-ID: <agxBvWQnZiRJZwNC@exploit>
References: <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
 <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
 <xmqqse7n7w2i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse7n7w2i.fsf@gitster.g>
X-Spamd-Bar: -

On Tue, May 19, 2026 at 03:27:49PM +0900, Junio C Hamano wrote:
> Mirko Faina <mroik@delayed.space> writes:
> 
> > +		 * graph_update() as it doesn't do the actualy printing, we'd
> 
> "actually"?

Whoops, it should be "actual".

Thank you
