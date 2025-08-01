Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B031D7E37
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061520; cv=none; b=ahZXtADShhdIkN0Xs6C7Hymhpo7SuUs/bEI6+pel18fIlTevNBrsCiuMncK5mG2BBXMZhR/T7itUSa5TxDT313EoAJ9rTTjTHzXO3PmqJWKdWx9mxgLV8zEUnZlf9QRBsi+y6XOHjs85n3HFIpHwAzjNnScJRwVlib4BXBYRq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061520; c=relaxed/simple;
	bh=N3hGWlZwOCnzNm9PqIg3yv31UYFLo105BI2GUInLf/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpW1zZByCvmWB6gDSDoNnmnsGS9eop+lbPjuP/EjXR0LDBcvfQ2a8KY/+DcndztSf3wPmVszu6My4eMPYFQzFm3ai+RrpvLxETCPuPRJhJFSTn4Q3agewPqNnZaOfM4JLgQ7zwWJPFYTH0qZRk33jwbBEU+qa/fBUfZS7DFoUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=XpwzhycH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="XpwzhycH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754061514; x=1754666314;
	i=oswald.buddenhagen@gmx.de;
	bh=junSMpAoiXk7smdGhFofETeuWU1HQDYHzwpLEd5yfxM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XpwzhycHN3tvHm9mUVnP6LJ9EqLuUBfeJ830j/XLNa7wFV3tvSBipLjl/WwMBGYc
	 T53YsFpPkyUvxYiY1yWSQLACWv92+TBckUO6gUf9Oae4LCeHrWZEU2FqZeITLMGWw
	 J5aT99D8BTq3iVFwasVH1GfX3U+8Ac+9jycvgDas4pngDlgFavXmrp079whfaYqWH
	 pk9gOMFc0IYNofPW5+WxAEtUclzygrAhaNWaen0UrKTUEI0uCFzjJs76P689NPqlE
	 B/E3zfo+f6Tvx6hx8ypz0x7Wg0FaRO9LnNJkbXo95UH7hyesUhFeJ/LNgxe1hkIjv
	 s/XU8HdI6No93xI/Tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.115]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzT4-1v0TFF3SfM-00RdT7; Fri, 01
 Aug 2025 17:18:33 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1uhrWj-iLn-00; Fri, 01 Aug 2025 17:18:33 +0200
Date: Fri, 1 Aug 2025 17:18:33 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/3] commit: print advice when core.commentString=auto
Message-ID: <aIzayan9nFZo4XYv@ugly>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <cover.1753975294.git.phillip.wood@dunelm.org.uk>
 <0e7c08b15e5923ae03f5630a8286c7dcebdbcfb9.1753975294.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0e7c08b15e5923ae03f5630a8286c7dcebdbcfb9.1753975294.git.phillip.wood@dunelm.org.uk>
X-Provags-ID: V03:K1:3kgAmPF6+O+1C5I3sGX0F2JTK6BXPKsSfrwsgQzc0wr9Z3AebQK
 fZEgtbz8o9cYHqO/0NbSkUBCfo3QlUnF62YtTq9Moz3SVTQiKmJWJShALlK9a4BfE0b76OJ
 GczYVvdg4YTO2Xe6cMfBtLTO2ty840towg3XaqDLPC6WvXk2HAEta5WqEQZCIPrf9XxaIAu
 3P4FH6WwM8wZMUOj5NymQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VPQP+rbCDc8=;uZlzL/RBsH0hlrX5kwqRCXBwUwP
 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
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 04:21:55PM +0100, Phillip Wood wrote:
>An alternative
>approach would be to advise the user to run "git config --show-origin"
>and leave them to figure out how to fix it themselves but that seems
>rather unfriendly. As we're forcing them to update their config we
>should try and make that as easy as possible.
>
your approach certainly helps the user to fix their acute problem=20
quickly, but
- why should it? it's not like leaving it to the user would cause them a=
=20
   huge burden, or that a noteworthy number of users are even going to be=
=20
   affected. i don't think the fact that the update is forced justifies=20
   making it a lot more user friendly than git configuration usually is,=
=20
   esp. at this cost in complexity.
- i don't think i'd appreciate the tool lecturing me about trivial usage=
=20
   patterns, when the real question in that situation is why the option=20
   was set like that in the first place and whether/how the replacement=20
   is actually equivalent or even superior.
- given that it doesn't print the entire decision tree (when=20
   encountering read-only files), it doesn't necessarily guide the user=20
   towards the best overall solution. that makes it _less_ user-friendly,=
=20
   in a way.
