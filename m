Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4886E1474A1
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890622; cv=none; b=DmS2uGDWrQjo8kOXca5UiHH87SGPfxj7JM91zyr+DvICK8RECRx5szXJVMHHzeu9icVcVH1Lcc/ozBiFd4C+3LOJgKHWwZWSKK+xeR4l87mBv/hEcOV22sa8cMBu46Wuct/usUlgYWBggmjCZkXOJ1hKNfACigcKpokT4cCEPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890622; c=relaxed/simple;
	bh=pM37SOTl1nVxrcQ0hw+CLwqUvjQUA/bNQ4h55sHJzcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Msv3tA3djVpABaq0v3X4R8f5nEcyHb+Q8S7WjGerPOMTuXevwgGQnA2BPjClaD6vmVXJcF/TC+uztSLnae8RVfe+D9gawoLcxUVjwvfMVTMPAoPFM2yRfxJZZ7AHqAEnxKKgFP6B4J9CH+ndz1dpnL60KXvbd/9axcv/yh52hhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GagIwm8n; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GagIwm8n"
Received: from cwcc.thunk.org (pool-173-48-116-13.bstnma.fios.verizon.net [173.48.116.13])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 412GGiho008766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 11:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706890605; bh=xV+7BmN5N3stwtQqSS2uZs3Hub5JPPDjCy8hhsTwYJY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GagIwm8nm6yKcCU+i1TUKO6d3214oPfL4H5pKl5CT9S0HARlpy7UKffoJwb7Z2VVb
	 9+XIqN4yn5Jm0MQGVlL5y4OTSGoAtw9arnkJ0MFVU+9YOX+xAWjWRnfF6GgLMzRZx7
	 uvjxTqyxu4keCcFj/whq/goBpN2nKhn3SXpF57FHXvns4yd+Y6jTtyAC3popH8dQG9
	 aX2d/KG6bObQi6yZY9dd2hvGSBlxCfc3PIZyusDU2BJPdf8GvExAaMqfMkAMV4OXUK
	 fjS2k4TYdM6wZP91kCfYO9bwQ7EaB41Z0454P4WXlrE4gk1/NKhLtdv5QSmU5pxGTQ
	 6lgkv3FJsHOKQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EC7F915C02FC; Fri,  2 Feb 2024 11:16:43 -0500 (EST)
Date: Fri, 2 Feb 2024 11:16:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: rsbecker@nexbridge.com
Cc: "'Sergey Organov'" <sorganov@gmail.com>,
        "'Hans Meiser'" <brille1@hotmail.com>, git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <20240202161643.GD119530@mit.edu>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <877cjm53bf.fsf@osv.gnss.ru>
 <008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>

On Fri, Feb 02, 2024 at 10:22:18AM -0500, rsbecker@nexbridge.com wrote:
> >
> >Did you consider to rather read the list through
> >gmane.comp.version-control.git nntp newsgroup?
> >
> >This way you get only very specific mails in your mail-box, those
> >where you are explicitly CC'ed, and you usually get more support
> >for structuring from NNTP readers than from mail clients.
> 
> Google is dropping Usenet NNTP updates on 22 Feb 2024. I would love
> that idea, but it has a limited lifespan.

Google might be dropping Usenix NNTP updates, but news.gmaine.io and
nntp.lore.kernel.org are not not run by Google.  So whether or not
Google groups are supporting NNTP is not really supporting.

One other thing I would note that is that if someone isn't interested
in following most of the git mailing list, it's unclear how much they
can actually contribute.  Maybe they could fix spelling or grammer
issues in the git man pages, but it's unlikely they could actually
make code contributions.

So from an open source project perspective, which is primarily run by
volunteers, each open source project has to make a cost-benefit
tradeoff as far as the *project* is concerned.  Individuals do not
have a fundamental human right to contribute to a project.  Hence, the
open source project doesn't owe an obligation to spend a huge amount
of effort supporting some kind of forge web site just because some
potential contributors are clammoring for it.  Especially if they are
saying that they can't be bothered to follow the mailing list traffic
because it's somehow too much.

(Of course, I have all of the Linux kernel mailing list flowing into
my inbox, and have e-mail practices that can handle that load --- so
it's hard for me to have much sympathy about people complaining that
the e-mail load for git is too large --- compared to LKML, it's
*nothing*.  :-)

						- Ted
