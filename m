Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2C28FD
	for <git@vger.kernel.org>; Fri, 23 May 2025 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975650; cv=pass; b=TBbITQSZDETmIEZJszyDyLvTkw7NhaUdKSKR0Ui29NTqPn5J2e7KFolNjJ7RZiH4iWuoAvieJpGYKBTEH99O0G5M4nizQ2BCCmF60QxIXEpgcWhlwa3fZULzFNfS7qxicOAaygx4whnsxjvZRL+GxbPzR9JvhMoIwPXJM4K9SNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975650; c=relaxed/simple;
	bh=Lu0x23Ho+QXhsDTLvgxCIwmo2kzig+TMg5YhU2yOn3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf1ZYbAxjl5FQPZsMVerKWSlrlWNTEgVWpfnoAzifhdJNoXPCyZDGGB/mz2idQrpk/w5RDmVuWwsbNZ6T0sQsygdjiQPVjuVN4pbI3cU/i5yx7uiO/5Tx40ofsEv3PCxjQK9JjKpMKjZx8I0J47zNdlV5R719A/Erty953Rw0vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoho.com; spf=pass smtp.mailfrom=zoho.com; dkim=pass (1024-bit key) header.d=zoho.com header.i=mmogilvi+git@zoho.com header.b=ENwomRZi; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zoho.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=mmogilvi+git@zoho.com header.b="ENwomRZi"
ARC-Seal: i=1; a=rsa-sha256; t=1747975635; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dW5q4X8DO0Rz5aid21PWiwRz8bGXlRHODMXG1P3lUInan9t8n4I2P9V4qhP3g7heqObFDHCFQlCURuslaygLVSIAoFL3+DYzTlIoDYtjX35VmIy9JojFB/kGQ0sfCZOD2OgAG80yB16BFjfV8m80ZjlDBCNIqPHceCyg7mD+eEs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747975635; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+v5fPt0W8zAWe/3AzcteT2rS3lK95WZUNyNUtpUoR4I=; 
	b=QnMpRfZjBAPraq2w6d/bhSPUf52Qz2RxyVatxQyFvqQctDqzaKZUKL3Nc3Op9w453JmW78r/NaW+m03R6947S4g74RI8q1eKJyKdxClHZN+OGixi+NulrzNTvABUW8IXfciVLab2EBS96dcUGjnKp2ywVreryRHDR0urzJAHf5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zoho.com;
	spf=pass  smtp.mailfrom=mmogilvi+git@zoho.com;
	dmarc=pass header.from=<mmogilvi+git@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747975635;
	s=zm2022; d=zoho.com; i=mmogilvi+git@zoho.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+v5fPt0W8zAWe/3AzcteT2rS3lK95WZUNyNUtpUoR4I=;
	b=ENwomRZiDZS3ljHfMilVEKHvSKUXa5ZKA8y2uutNriTMsx/UVUdeLJl7ZFXwFuxr
	URL+3UUr6kWfxPC3PSD/K2pcdvwMWiIyya9IgqbzlNC4hhaaHjeFX4F4XOX7eS9kYXC
	1l8ABADzpR2EhOlIQtz0WzKicRPHMSgtJIDZmSQI=
Received: by mx.zohomail.com with SMTPS id 1747975634554914.7492976425184;
	Thu, 22 May 2025 21:47:14 -0700 (PDT)
Received: by mmogilvi.dynu.net (Postfix, from userid 501)
	id 2DB7947C4319; Thu, 22 May 2025 22:47:13 -0600 (MDT)
Date: Thu, 22 May 2025 22:47:13 -0600
From: Matthew Ogilvie <mmogilvi+git@zoho.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	=?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
Message-ID: <aC_90R3ohRRBVIV7@comcast.net>
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
 <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
 <xmqqh61ear4s.fsf@gitster.g>
 <xmqq1pshc2vs.fsf@gitster.g>
 <CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
 <xmqq7c287i7n.fsf@gitster.g>
 <20250522170536.GB1613@coredump.intra.peff.net>
 <aC9lM12GyntAp2tR@teonanacatl.net>
 <xmqqtt5c5viq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt5c5viq.fsf@gitster.g>
X-ZohoMailClient: External

On Thu, May 22, 2025 at 11:51:25AM -0700, Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
> > Just for curiosity, the only commit found with escapeRefName
> > is when it was added:
> >
> >     $ git log -G '\bescapeRefName\b' -- git-cvsserver.perl
> >     commit 51a7e6dbc9
> >     Author: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> >     Date:   Sat Oct 13 23:42:26 2012 -0600
> >
> > 	cvsserver: define a tag name character escape mechanism
> > 	
> > 	CVS tags are officially only allowed to use [-_0-9A-Za-f].  Git
> > 	refs commonly uses other characters, especially [./].  Such characters
> > 	need to be escaped from CVS in order to be referenced.
> > 	
> > 	This just defines functions to escape/unescape names.  The functions
> > 	are not used yet.
> > 	
> > 	Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> > 	Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >
> > A subsequent commit, 658b57ad52 (cvsserver: add misc commit
> > lookup, file meta data, and file listing functions,
> > 2012-10-13), made use of unescapeRefName; escapeRefName
> > seems to have _never_ been used.
> 
> OK, so we can safely remove it, it seems ;-)  I wonder what, if any,
> the unescaping side is unescaping, if we are not doing the escaping.
> 
> Thanks for digging.

FYI:

One intent is that the user might do the escaping manually, if
they need to refer to a git refspec that is not legal in CVS.
For example, "cvs update -r pu_-s-mo_-s-experiment1" instead of
"cvs update -r pu/mo/experiment1".  To some extent the function
could be considered a form of documentation of how you would do
this manually.

Also, the fact escapeRefName() isn't called suggests that there
might be other bugs.  There is a test case in t9402 that
tests arguments "-r heads/b1" with a comment that "This is not
really legal CVS, but it seems to work anyway".  I haven't fully
tracked it down, but I suspect that might end up putting a
literal "heads/b1" in the CVS sandbox's "CVS/Entries" file.  If so,
that is invalid, because Entries uses slash for its own field
separator.  If we added more tests immediately after it
*without* a different "-r" (which is very high priority
when resolving which version to update to), they would likely fail.
It might make sense to put an escapeRefName(unescapeRefName()) nested
call somewhere to protect against things like this test case...

However, despite writing and (incompletely) testing this code, I
have never *really* used it, and probably never will.  So I'm not
in a hurry to try to test or fix it further...

(For that matter, has anyone ever heard of anyone actually using
git-cvsserver at all?  I think I would be surprised if there was anyone
using it, especially so many years after CVS stopped being maintained
at all.)

        - Matthew Ogilvie
