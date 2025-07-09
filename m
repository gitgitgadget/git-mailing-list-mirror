Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3A176ADB
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041058; cv=none; b=p3PTXfwEZcsByw7V0vZ9GoDJOTPzAB+Be5ogiTO6YclAWsrx+HnuLcfxSZtvGghm7nMakzDeZiADWienquTmEHBgMXVf95R6aETAQkQeYwai/J8NoLuQtLtd3w2ff8KLgKEwbx3b7FglaZ0QNIDcUVhJwqpIkxKwTImJXjngChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041058; c=relaxed/simple;
	bh=fTBuSSHw7zrmmFKmFNmU+HgIXEvGRUeX9CBWrvjy5aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4Mg7wJbNtGuppMdmNXOwXBw9Qngz+gYyv+7MsPJ0fh/1uyOs3Vi3TjugQPDoP1LQiI1wYz91knwhzmta/rBlfFMon0N4QvWWkr5rZ3i1vcsjLNM14XqY1PvVQhw1JqP2oc7ScMKp0cosjuuCmVm5Y1LKrjouF69UyYSmpBeVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=L6T2S/Ow; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=fRIjHLjy; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="L6T2S/Ow";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="fRIjHLjy"
Date: Wed, 9 Jul 2025 08:04:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1752041053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxScxTUQB7FmgJsZCd9N/t7SleNRhXVMJ30AwGO0rnk=;
	b=L6T2S/Ow3epoKkmrB+rNlgikamv3kcyKCM/54ouQJIQ8KxitAhPlAtgGf28Sv7mixEcVx6
	FqRjil72CYLlU9eJqAUb5B1MPpCQxcDVTP2vinyCNnDjMffOT3/HHNZ56QWTuhtNrIqR+u
	Es8FOxk+Z3AzcRY2dCwV0AZmBL7Y9RtmKlBqj+IbQe8GC5I6QomrLnydcnIYzFmES/Q6Vr
	qAhblc2FhdU98tp6hex74S5TURI2qOpi5oqoVsVnDiaY11z/KmElaKzQ+b3KuHknNZSdlX
	00lhqk+rF91neKleNZa6svsLXWzLBheE8f68VGT0HcS7ZZWe1dSwmKFWMgN4YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1752041053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxScxTUQB7FmgJsZCd9N/t7SleNRhXVMJ30AwGO0rnk=;
	b=fRIjHLjyZ5EuyEttEJh16vkiSVN5YsQkkn8qBTZBGdmBB/AYdyumcFJ8xZinqBqRoMR6JZ
	p/UKsxlQJk6fkLDA==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] bswap.h: Rework ntohl handling
Message-ID: <20250709060412.BnVWKovB@breakpoint.cc>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
 <xmqqo6tv1v1z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6tv1v1z.fsf@gitster.g>

On 2025-07-07 15:43:20 [-0700], Junio C Hamano wrote:
> 
> Now, I see many comments and suggestions on the thread since this v2
> iteration was posted:
> 
> https://lore.kernel.org/git/20250611221444.1567638-1-sebastian@breakpoint.cc/
> 
> and I think the ball is in the author's court to respond.
> 
> I'll mark the topic as Stalled in the draft of the next issue of
> "What's cooking" report.

Sorry for the delay, thank you for the reminder.

> Thanks.

Sebastian
