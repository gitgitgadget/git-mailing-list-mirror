Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFDA1E1C1A
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749506242; cv=none; b=mrCJ5XL3McDDMjr5m7IVv39oxRHKkAsyyYiAY7ZTICOHMgJys5+WI4A7O6/5VsYdAaK+hDaUrQbI25bWM0oZ+UpERJGYNp85LRacsPrjC/21DAs0JMS0EPkRbXYgJJmnz1y86/DeAG3p0GD0n7S/7/r0TrxRsFj0w1GHhWAHXWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749506242; c=relaxed/simple;
	bh=9UdpmdGoWC/9wOgascWRts2/Tso1+F5t/J/EHFwL0fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzNnqU5fn/r7zkdYOz30sOG0XuXGfGQUScDta7mDUmk5BfEOJZ8wxtWEic5DMMmjvqkfZCvQtv/lpqN5lY9KsnVvlMjZdI+tVzj/Y/A2BSFMxw9SnMcPfYpFowzdn/TynEjhsCUd5EzW8RvoDUxRwz8bVXr3NUAB619rK9s986o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=Km6Pb3VG; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=UqtBc7Sk; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="Km6Pb3VG";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="UqtBc7Sk"
Date: Mon, 9 Jun 2025 23:57:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749506238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpUATCbTLnQoYv8NvGg4hc2FScjtSHz4KrTNReeqA1A=;
	b=Km6Pb3VGfF231UOR/wg7hMye2OAOmquy54jAop6Gwz/Y3ZillfIF9WdxopyLapFV/Bz6ua
	SCPCfLx67ylzkNZZ/VLb8w6vSFm5M+JQ1oECeaolwmSexeXpXHgWTXZF8bvl6G5moOTDm9
	rkpGUdM+wg32rHfbFzTeOlFyVsVtf/clBM+s8p+DoKrcN1TJOp/iMQIXsd+4DJj4eXf/8C
	dM+Ws8csg+02UOgurp+9jhe69bBt7N2zQynril6hTaNud3dNPvOGFGx5GWiHFjDZqNKr29
	6dBmc+GSxzVPcehqicpL877/HFwnKsf7xtLSFMnwhnO1/xJ4QphbOmY0j2t/Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749506238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpUATCbTLnQoYv8NvGg4hc2FScjtSHz4KrTNReeqA1A=;
	b=UqtBc7SkPw5trYzOgZcrhCKF+h9FU6EIKPR4fY0pZN99muIWAaGTQtmfWCSflfSiG+IvXC
	X0kHHkkbVhcSa2Dg==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bswap.h: Move the overwriting of the ntohl*/ htonl*
 macros.
Message-ID: <20250609215717.gbaaVj7r@breakpoint.cc>
References: <20250606165718.HOiC2U4X@breakpoint.cc>
 <xmqqplfg1sym.fsf@gitster.g>
 <20250606220455.jhicNLuK@breakpoint.cc>
 <xmqqcybg1orc.fsf@gitster.g>
 <xmqqmsajxo2i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsajxo2i.fsf@gitster.g>

On 2025-06-07 14:02:29 [-0700], Junio C Hamano wrote:
> This seems to break Windows rather badly.
> 
> https://github.com/git/git/actions/runs/15511228119/job/43672455770#step:4:92
> 
> I'll eject it from my tree for now.

Okay. I prepared a revert the commit introducing the regression and then
tried to clean it up a bit taking this fallout into consideration.

Will post it tomorrow after some testing.

Sebastian
