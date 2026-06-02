Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0B2F7EE8
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422651; cv=none; b=BSqRS8RTld1M/lPeq3Pv8WRccgBqFHE2wZvnVhZkF+v4Irxr1r/Xv7pf+ljeC7etuTnMgyqrkv8dXMSe0mXcWOi0X0kI+I6SuKqE4CfUZc4+c08RM5J44gFYIvWKbEprOrGSryJ47LZ+MiKrmjEmXpHUFGfyslMlV49mW3HRaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422651; c=relaxed/simple;
	bh=bjYAeIiZSRq0fOz2wlblMmEzvXCLwn7s68ootE7YVZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruwdEisneKQHzKTyYW+KYvOMzrbit/WAa5VX58aUSHRElKKh8LWngeutJk9fss18HhToL38um6LV29s2X5Gemh0f+pjFnUbtxk83Mpu4mUeE35zHMZowS+TbOAb+6eMrltAxBFdeLuCozdipULBZKveMe2iJpteCB0fNLLbyFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=hRLc1mmI; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="hRLc1mmI"
Date: Tue, 2 Jun 2026 19:42:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1780422153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXeIlosB7PAtFkadgOe2lMGSwK1YidOX22HpWQ76LC8=;
	b=hRLc1mmIBqFbaKogh/QNE4RFnv+qqNTZR00dsobZN+4jslPCEFL/9gZOErNWIrMGHbiB2g
	P9ns0lvHehn0/Ri2qE3FfziHs0qv6w0WIXGxHIn3Ws7GZmhPM73lljtKpi5s3dHKkNILIz
	yWFuU86TVH9DWfBgh5YNokIxhD9s4azw64kT/ZmricM7bq1QolQ6Nq7fYT/K4puVvaFKx6
	SLRBOOW60soNQuStNt7M3mQDiiXtRtKgAd6LRAzEVkgz8EJmuGWT7q0pzigw/9c8oBEB4Z
	ADtlqGmJ9McpatGGaIWEgSS1vUiHgS4w1MKubE50xrrR7INHTC9xXcLyBwuHiQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Chris Torek <chris.torek@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v9] revision.c: implement --max-count-oldest
Message-ID: <ah8VHKk83Az44A-t@exploit>
References: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
 <8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>
 <xmqq7boy4o05.fsf@gitster.g>
 <ag3kJ_xKY6584De4@exploit>
 <xmqq4ijm3p2x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ijm3p2x.fsf@gitster.g>
X-Spamd-Bar: -

On Tue, Jun 02, 2026 at 06:53:10AM +0900, Junio C Hamano wrote:
> It has been a while, and we saw no further comments by other
> reviewers.
> 
> Perhaps we should declare a victory and mark the topic for 'next'.

Yes, if no one objects it might be time for 'next'.
