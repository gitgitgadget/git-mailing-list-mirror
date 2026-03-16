Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4826560B
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648556; cv=none; b=SEbEaexHQ7qCKA6YnIm2DtMeNy2wBTouSPZEcwst6tLKmwStDgBK89p2jrjd6qcMbENVWa9qrhT+Luk3Y6rxt8giswiqGqIX+juJ2zfAU53dkqCPRwCZo73mc6KMX24r533GvW3tecphaO8kjDh2QXbZTt5LKnzZ4JMH30K7TnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648556; c=relaxed/simple;
	bh=QweeQ3vgN2ipcAMVZdfDl9ScTJf/KQcopXVRxeUkLRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYVyJV1PCzEdhIxM14yHAMCTaQfoPZFyG/OxFjHoN1esfNCE2kff8+C2LkYcxu58pf6GAIuuKboajEAcVQN84w6Ti9iTRdkxJMBUroGIgE1CYu8PDwxdzz+bPblL9296v4XsOOItpXD60mSZwdqr1tsI6Vkbvxhbj4LZgozsNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NWDQQzrd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fm9AXjbB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NWDQQzrd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fm9AXjbB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 36B91EC05E0;
	Mon, 16 Mar 2026 04:09:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 04:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773648554; x=1773734954; bh=7M8QgtNbGe
	3jyZsBZ+kFAVljUMbur1OpdHMSavwwi8Q=; b=NWDQQzrd5aN1V3c5EwaGOEcg6l
	SxXbinA41DXnvR+rHkUsG/q+lEiYxSTrqNMhKUH/nrHdaUHIB1hHnSRGbmP6JBcp
	g6xyLOCFP0G1P7JRUgDqlAXDE0tCNmsg0bcHo6dYLkv0qC1t8k3kCt4cAQ0ndo5t
	cuUNR7mMeAsZo4b8FSuZYxXlcWRo6Asee+bDtxVfuMzw5Ul19OXv3Bs6gQ+sifHW
	iabRC+GhKQRKxBBWBLXtSEhXgPtbe6UwVBm9p30jsuYtVmoUq7/GSDAicATOhXJU
	uywjuuQhC5nw3iuCJ2Je5ncVmGODBZanJwzzPjEzPi0wObVMvzzS0VDk4m1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773648554; x=1773734954; bh=7M8QgtNbGe3jyZsBZ+kFAVljUMbur1OpdHM
	Savwwi8Q=; b=fm9AXjbBrQJVYr5lwMNitLtFHB3uhN5NbBfBEgn0s2RJw3IlhXg
	4ZpyeicnfOtaKi9rs9dacdi2JAmvBnEkyQZz+wU3rF9pfcdMFjTpqPgbHoqHWBmW
	y9/SHKKHbG5qMwUvV1j8XW0RwSt5sb+Fhzv5YIM4ag04ZLPtmcglxEMGjZ7jFo21
	xwqQ4FdtGME8PTl1YhgNpVVIzbyzHDycmRgkTsu03ZJ4oouLrnZm3UxfRqk+LLem
	4iPHer6xUve6oyUy2mUIh55hoH/7pfvAeT2q6VG5Mn47CO8g9i0FqAKJ5iNFrOkR
	Mv9darBs+vwEvtkU1tqVM7yz+f1n1sEndvA==
X-ME-Sender: <xms:qbq3aQJfecSPscAc5h-mRzzIFH-Ct3ECyBbGjVggb6etR-oUm_8a0Q>
    <xme:qbq3aeGIuyzo9938jjRiFJ1u7DP2fA3yDqZLYNdWLmRnYCwp4WqrlZNIbYprZTvJQ
    KoqHmDSzcuX9MjGqSE0ZzQynKUY4-ZgT2evj7X05rParbkmjp3J>
X-ME-Received: <xmr:qbq3aYTrBcDuPqwFlEIfw4DRE5Rh_np3mobO_W9xKE8GdnK2sbrlcHJDNnR5uxc4ltIvOkrB1njd1oJF6ug_eA87jhkG_ajT_oemuQmgwSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:qbq3aaHKZUd1QPNUPfQLNmkDtzlgAmhc7vbDqnDMeGklp5SDu7cQtQ>
    <xmx:qbq3aU-fZCAYEg153zu6fufW3Pxx2XJwH8b_XmrxSeIA5I9TZQGftA>
    <xmx:qbq3aULGnkL-Mm7sXmKx8fhDA1VgGSOovTJz6CBJPd8IUs7Z-S1Y0w>
    <xmx:qbq3aXa-DzlmIDZHUN51CVYiRTfSOm_GnjDY8Yv0hUZ3VbVeOp9Xyw>
    <xmx:qrq3afjRe24emxp0agS13GmEPqdEBv2rA2Dss7sgcfM7CwKJyxAkXzXG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 04:09:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6933955 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 08:09:11 +0000 (UTC)
Date: Mon, 16 Mar 2026 09:09:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
Message-ID: <abe6pVAzMEY60rJ8@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
 <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>
 <abJbir7NocxmBuAo@pks.im>
 <2fe87868-dff5-4b3a-95e3-d4b6376b59ed@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe87868-dff5-4b3a-95e3-d4b6376b59ed@gmail.com>

On Fri, Mar 13, 2026 at 10:33:20AM +0000, Phillip Wood wrote:
> On 12/03/2026 06:22, Patrick Steinhardt wrote:
> > On Wed, Mar 11, 2026 at 02:56:24PM +0000, Phillip Wood wrote:
> > > 
> > > I notice the reftable sources don't seem to include "git-compat-util.h", do
> > > they need special handling here as well?
> > 
> > I don't see a strong reason to do so. The reason why we need to be
> > careful with "compat/" is that we redefine a bunch of standard symbols
> > there, and that requires us to play a couple of tricks with preprocessor
> > macros (see e.g. "compat/fopen.c").
> > 
> > We don't do anything like that in the reftable library, and we already
> > include "compat/posix.h". So in practice, it shouldn't have much of a
> > consueqence if we start to include "git-compat-util.h" implicitly over
> > there.
> 
> It does mean we're using different includes when compiling with pre-compiled
> headers compared to compiling without them though which means contributors
> using per-compiled headers could accidentally depend on functions that are
> not included when compiling without them. Wasn't the idea behind
> "compat/posix.h" to avoid including "git-compat-util.h" in the reftable
> code? The commit message for 75a044f748f (git-compat-util.h: split out
> POSIX-emulating bits, 2025-02-18) says
> 
>     This intermixing is a bit of a problem for the reftable library as
>     we don't want to recreate the POSIX-like interface there. But
>     neither do we want to pull in the Git-specific functionality, as it
>     is otherwise quite easy to start depending on the Git codebase
>     again.
> 
> We could precompile "compat/posix.h" for the code that does not want
> "git-compat-util.h"

In theory, yes. But in practice we'd notice this quite fast via other CI
jobs, and it feels a bit ugly to split out so many different libraries.
So I'd propose to keep this as-is for now, but iterate in case we notice
that it _does_ become a problem.

Does that work for you?

Thanks!

Patrick
