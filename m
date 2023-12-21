Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E64EB31
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22322 invoked by uid 109); 21 Dec 2023 09:56:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 09:56:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22862 invoked by uid 111); 21 Dec 2023 09:56:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 04:56:07 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 04:56:06 -0500
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	AtariDreams via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
Message-ID: <20231221095606.GB570888@coredump.intra.peff.net>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
 <20231214220503.GA3320432@coredump.intra.peff.net>
 <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>

On Fri, Dec 15, 2023 at 02:46:36PM +0000, Phillip Wood wrote:

> > Yeah. b2() is wrong for passing "2" to a bool.
> 
> I think it depends what you mean by "wrong" §6.3.1.2 of standard is quite
> clear that when any non-zero scalar value is converted to _Bool the result
> is "1"

Yeah, sorry, I was being quite sloppy with my wording. I meant "wrong"
as in "I would ideally flag this in review for being weird and
confusing".

Of course there are many reasonable cases where you might pass an
integer "foo" rather than explicitly booleanizing it with "!!foo". So I
do agree it's a real potential problem (and I'm sufficiently convinced
that we should avoid an "int" fallback if we can).

-Peff
