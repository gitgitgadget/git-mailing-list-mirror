Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0653FC5DF
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534995; cv=none; b=TSYpVofEkmCX3eg08X0gHk8tDq3mNDu2k47RJFve3029z1/FII35CFPscQWBhPH4qUzfHK9UQ/tZFv2ymuBZLj7vfQBcNGXmbl8I+SkbVErdTgBMPquyJ/wJm6pJGTJN/IZI2OcH39ox2cLPdfFkXeTgYZEdhhiU9RwyOXtelMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534995; c=relaxed/simple;
	bh=BofYE5IGw//CtJTvfYBsk16bzkO1o3g6Z4gqXTJnnL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQtz4vTunhOWdCZN8VIp6IIdJEsseIdhexcJV4Db8BeU3I7tgy4O8bu0HI0WN0Cvyii7cEvEbkoo1om3PIfhy4yYPqTghescLYo+QR3ieFne+GouE8w5iLpFeKQmG2lgJhejBBDLNemLXjaRzkWX7UuBUT4lIWhEczPYw10NmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=htEXM/9t; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="htEXM/9t"
Date: Mon, 15 Jun 2026 22:49:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781534991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXWrYwzjUbqR7GmVsdWRESUTxwALHBvk4spSAvyyhME=;
	b=htEXM/9tusBmGaCcdupU+GrQJt8liaKw0DffFnz+3QgLtHckTTNFV5UmBTJDW7cjJ4jUW0
	0Hp1GAIkHdOWeMVquoK336mrAWv91pEl0b504NRYrdS6ZBVALpPUbf+Bm4+cSAiNVF7hyZ
	x4fIJ0J6u1OAiQBSLjm5EbMy9BwCDLi7oRucfO3Wi23nHVrlMrE6V58kQgKfAA3b/DnuDO
	nSjjgAbuG8kX5yUXi0aX5llVkSelQuTRZK+eN681Ze6pxXEkmwsTWGcJYGsqfT41oCJWLY
	iWwopqHdHbjjeLMSPY4RC8t8nUnc3EabV5z0+tW9Dus9bMj3GcRRGjlbYXQ8RA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] doc: advise batching patch rerolls
Message-ID: <ajAQ9BhPsFXjC13D@wyuan.org>
References: <cover.1781358364.git.wy@wyuan.org>
 <8166623d1599fca2cd4614889e4a69b2006c12c1.1781358364.git.wy@wyuan.org>
 <xmqqwlw2e8dc.fsf@gitster.g>
 <ai2NwMS-i_UTWR5T@wyuan.org>
 <ai_7X_QY0u1CWJ7s@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ai_7X_QY0u1CWJ7s@pks.im>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 15, 2026 at 03:17:19PM +0200, Patrick Steinhardt wrote:
> By the way, talking about mailing list etiquette: in scenarios like this
> it makes sense to add a Helped-by trailer. That would've serviced as
> hint to Junio that I was already involved, and it gives credit to that
> other contributor. I myself don't care much about the latter part
> anymore, but newer contributors might.

Got it. I'll add that trailer. My original intention was to directly
write a "Originally-from" instead of "Helped-by", because I didn't add
anything new at all ;-)

> And no, I don't mind at all that you "stole" my wording. Quite on the
> contrary, I'm happy you picked up my thoughts and cared enough to put
> them into a nice patch series :)
> 
> Thanks!
> 
> Patrick

I should be thanking you :-) I´d like to start by contributing through
these more basic tasks and gradually become involved in the community,
since my code patches would probably only create noise and meaningless
trouble on the mailing list at this point ;-)

Thanks!
