Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA120ED
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773469269; cv=pass; b=TDvOD5WLSziFNtnOl5sm51CUsIuhhWTn2E/2HPAKrnhfg0V/c3XwZjgYDa/X9kWFLvdAZQYtRiaAWKGlvq3GAhPNyILzRS3VzradQpUroEKMgOjUeRFBplF5e8VeyfnMX9Eccn+FMwClNuVNcUGIMn2Yyp8aIeKwZyFlcuFCbLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773469269; c=relaxed/simple;
	bh=3a9Zo40GazBs6yAU46grQrrnYiJirX/AidhLZKdgDf0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=OTDLh0Jzqu4LXqeI1dXet4c1SM5yePF7idEe2MszaS0lREJ67sFIdioaPh+rpUVfCLZCDRfIiUy6eA9KjphBUF7CsDAAqnNIIIE1pP9CcGBYBppUP7Ifm4xwL3nwiyN8SG7tWov7GJgEKHcK8xBir36MSvvCWaVqEt8M8jMfmo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com; spf=pass smtp.mailfrom=ritovision.com; dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b=UoFeoPZh; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ritovision.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ritovision.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ritovision.com header.i=rito@ritovision.com header.b="UoFeoPZh"
ARC-Seal: i=1; a=rsa-sha256; t=1773469262; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LyN4P906iSheqSbP5XVqBwUBVxu3wwTlGyqZOIeJwUiRwaaaMj2nhT8u9NWWLGqGiFIP0F3AXVNjjqQ00wFBjDT6V4N+a3JJKkc9oM1Jy+4sZPIu8+dMfyd1jee2LQZWRqbR7mWSJerNaGLjISh4belWchiZwhaxBr5O7/u4RnM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773469262; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3a9Zo40GazBs6yAU46grQrrnYiJirX/AidhLZKdgDf0=; 
	b=cMO9inK0ELOHuktFmF7dAb5mK26DysGWe5s8ElmoLdhh11UdmFj9DFK1fDnM5bstcqE4ABGgK/ttrGVLn1f6RqnTmHN9jHcmPn02R5ozh8w+ZvCpYtIwxp/a5Uj+psj8DEkn0HiPqp1E4tbl8wGJoyek8nmVhj4Dnc7CO0g9eG8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ritovision.com;
	spf=pass  smtp.mailfrom=rito@ritovision.com;
	dmarc=pass header.from=<rito@ritovision.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773469262;
	s=zmail; d=ritovision.com; i=rito@ritovision.com;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Subject:Subject:Cc:Cc:From:From:To:To:References:In-Reply-To:Reply-To;
	bh=3a9Zo40GazBs6yAU46grQrrnYiJirX/AidhLZKdgDf0=;
	b=UoFeoPZh2Zzn5Wm+U8ah8g7XKH97XXRtN2lZaCi41GbS9lNp78n/jAQFEFBLLA19
	Z2kUyRuyldd960Tn7ygY/HzC7el6pxJwuq0BmbCn88ckzCZG15z2XZch+jifS3muenY
	LIOx6DWQTWol97EZE5t1lpum5ceDMgSUnh3ZsjoU=
Received: by mx.zohomail.com with SMTPS id 1773469259520666.822142828539;
	Fri, 13 Mar 2026 23:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 02:20:55 -0400
Message-Id: <DH2ADSKXNCXG.2DM7T0NF5NH59@ritovision.com>
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
Cc: "Rito Rhymes" <rito@ritovision.com>, "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>, <git@vger.kernel.org>
From: "Rito Rhymes" <rito@ritovision.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Konstantin Ryabitsev"
 <konstantin@linuxfoundation.org>
X-Mailer: aerc 0.21.0
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
 <20260313-loose-whale-of-speed-ccdbe2@lemur>
 <DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>
 <20260313-adventurous-lemon-unicorn-278ccc@lemur>
 <xmqqtsuj7mcf.fsf@gitster.g>
In-Reply-To: <xmqqtsuj7mcf.fsf@gitster.g>
X-ZohoMailClient: External

Actually...

now that I've had time to think about it (and get some
rest), I think it's best to keep the patch series review and
discussion all in this thread, publicly and transparently.

I initially defaulted to sending it separately to Konstantin directly
because this is Git's archive, and I wanted to respect convention by
keeping the thread appropriately scoped. At first, this seemed more like
just a routing touchpoint.

But seeing as there is no public mailing list for kernel.org's repo
specifically, and this is basically already a sidecar thread about the
site theme patch, we might as well consolidate the process here for
simplicity and transparency. Plus, I imagine the site matters to most
people in Git, and the mailing list is archived on lore.kernel.org
anyway...

This will allow anyone to review the code and comment on it.

I'm sending the patch series again directly in this thread, and I
think we should keep communication contained here (unless someone has
a better idea).
