Received: from relay1-d.mailbaby.net (relay1-d.mailbaby.net [64.20.36.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5534BA2D
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=64.20.36.197
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103870; cv=pass; b=Upsn1kkwARHGavKEdD6ojBThcu6hBHsZee/xc9/ZIy2hyaRwjtDRKSJNFjvMSb0rOzdHFV+kKFp9zbsCFCcuuQugR+YlsEYPkvM9ChS9Rfg9HqL/gFw2v9tvfS90BXQ21zB946KmkuduV5IERrpDPtP0i4rOiC497xje7GAp4Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103870; c=relaxed/simple;
	bh=WI7X8EmK173ma6n858QR+nIrgMly4kpTTbz8cUYuGT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfiC7t8OIrWKZd/xZZVKac4Wcm2UNc1JS+LLDmwkhuBQYwwY6OBV6P8m2oHdVRdoiaOvTaAXG8c/bbN9IZXGnuN75GfPxw6XJ9YqFVpHPcavC+wG+T1Magtbvfunt5xThxOq0lA3/ywRI9ojl/JXi88eH8LE3tDQLASR3RlVn34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev; spf=fail smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=E7UQImxo; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=F3rAcoaJ; arc=pass smtp.client-ip=64.20.36.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=agatha.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agatha.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b="E7UQImxo";
	dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b="F3rAcoaJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=RduqojhMZGInvuDEdnXst412pDgc6CKmPS0Q+sQQ9OY=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references:feedback-id;
 b=E7UQImxo77lzyV8GPjcAAbZu3m8DlhI5UwfXPPryeaGdqsUlPP/inPWoPlXV7Fok9wzbXn4DA
 4KvMkzZGmOqU9bDieTRrzVMadmjAgUTxUE4EO3sZkrjY7PKEDNTttfwn6N60guMGgevi6M60qVn
 Ix73nb+cxeb5eFJTZZ7huHA=
Received: from mb-nj-kvm1.internal (mb-nj-kvm1.internal [10.10.2.10])
 (Authenticated sender: mb6724)
 by relay1-d.mailbaby.net (MailBabyMTA) with ESMTPSA id 199ce58a5f20005a84.001
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 10 Oct 2025 13:39:00 +0000
X-Zone-Loop: 820a07a198379e3e867cd349aba14aed10c499ca077e
ARC-Authentication-Results: i=1;	rspamd.mailbaby.net;	auth=pass
 smtp.auth=mb6724 smtp.mailfrom=code@agatha.dev
ARC-Seal: i=1; s=detka; d=mailbaby.net; t=1760103540; a=rsa-sha256;
	cv=none;
	b=Hu8FcxgkmlxU8SSaGyiijxNEk1B1+A86EF1ZFHIGQCeCSOLjgCDt6p5bMsN+zKFUKl9MdP
	8kki7JNYZK7Ics+pb6YPSxT9Uqcg7RHaTea9pQBzdGNkmrTOqBPwk1SqIy0nNzkcqV5Auk
	5HB9sfrQJFNSc5+182lXfqZmBM6XLGW4fesZWHdIWhfYTi6uOG2pf99/nPvMdi6cROP35U
	6krueOBVD50tDhwmfUOhJSsRqh7j3jVyectbKU97xpokTKZguHuWi99v+zBd6TSjA3PCSX
	8/iIAlEbfknvw6Ze8c39ZEoZPIcb1TqqLA9NP0gIe3fXtZnQkod3qj+6lkZFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;	s=detka; t=1760103540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RduqojhMZGInvuDEdnXst412pDgc6CKmPS0Q+sQQ9OY=;
	b=G3vSFe6P0LXXD3HXsd8knPtR0ekQwgHFW1xbapUvDMJ/dQyt+4ZBN//g92Dyw+kdzlXw7a
	tvmhTB/F7cThUNoKMKVLWPAKaKy4sOSwfUy4hEYwJ3escJjT2Mzl8T9GhcazvI3b4IcSdp
	HB/0mlKEfjwzSpdkqNEGPLxuUeJgWPdkECCJU9cvhcnY1KZkSa6iIKrIpxmg6BtUu24rZQ
	7b7DELTt4dCIFZnmOCTOm5dsqdekhnO232hAlKpZdtmB8+pwODf+fSjmgULorgh3/I3qTG
	yVDFD7uLneUpLRdyttf9gqXtMZ14Jps/BtKtJAolKGfx6NrV8susNzw1mRfkOw==
X-MB-ID: mb6724|me@agatha.dev
X-SPFOrigin: SoftFail
Feedback-ID: mb6724:199ce58a5f20005a84:96.47.167.18:mbaby
X-NS-SCAN: PASS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RduqojhMZGInvuDEdnXst412pDgc6CKmPS0Q+sQQ9OY=; b=F3rAcoaJVFFCNZ2sb57NP0JHph
	7WaPHQSafp0VG2IDlpre62dZdWz484ivdXa+t0dJhKZJbPoCw4LuC7EHHAuRR81TcAeE4Q2OR0GlW
	JtDQ7AWVjHk7wjbiT6uAkBIKGS8ZkR2n4Pqx7zTd7Za1G6rVNl2oRE96pgdWe4tFTvfxNkW/a7dSs
	5+OsipKpBRxHnzmZf91nPirapcXN2beSelLqNpp1RXyGwtIDO116jIzgpqxSaWp10qi4qLTgQNMAb
	sWpQwArjaOurmj42NQAaamMUZQ4Ad5wNiF4mVGRwmtUtZXIh9OCus4Dc/iuh+pkrGUGBmI8dG5XcE
	yJKAad9g==;
Received: from [23.94.14.143] (port=36196 helo=lavender.agatha.dev)
	by nyc3000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <code@agatha.dev>)
	id 1v7DKp-0000000DZuN-283o;
	Fri, 10 Oct 2025 09:38:59 -0400
Date: Fri, 10 Oct 2025 08:38:58 -0500
From: Agatha Isabelle Chris Moreira Guedes <code@agatha.dev>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy] Introduction =?utf-8?B?KMOBZ2F0aGEp?=
Message-ID: <lmg2pwd6yf5ukrjl3mtwdwih7lcywpapmey3gp6m544hx4ctab@6xw2nsncyjcw>
References: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
 <CAPSxiM9yejQNQtw22Q=s1PrG-vUGBX5DiNQZMvyHACcXVfOtfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM9yejQNQtw22Q=s1PrG-vUGBX5DiNQZMvyHACcXVfOtfw@mail.gmail.com>
X-AuthUser: me@agatha.dev

On Fri, Oct 10, 2025 at 11:56:14AM +0530, Usman Akinyemi wrote:
> On Fri, Oct 10, 2025 at 3:39 AM Agatha <code@agatha.dev> wrote:
> >
> > Hello!
> Hello Agatha,

Thanks for replying, Usman!

> >
> > I'm looking forward to interacting with the git community once again
> > within the next few weeks during the application period.
> >
> > Currently I'm looking through the documentation to get a better grasp of
> > what is expected of us during this period. The doc says I'm supposed to
> > send an introduction e-mail, so here I am. But I don't want to just do
> > that, I would like to let you know I'm also working on choosing a
> > microproject -- right now I am exploring some intersections between
> > git's object model where objects are immutable and tightly linked to
> > author metadata, and possible privacy concerns. Especially for people
> > who would like to exercise their right to be forgotten and transgender
> > individuals who might fear former name exposure in places where this
> > information is protected by laws, tackling cases where a simple mailmap
> > entry won't be enough and rewriting history would be way too disruptive.
> >
> > I want to see if I can work on a microproject that helps to tackle those
> > privacy concerns while keeping objects immutable and preserving git's
> > design principles. As it's supposed to be a "micro" project, I plan to
> > explore a small, concrete first step rather than attempting a full
> > solution. Yet I would appreciate any input on that. I have a couple of
> > ideas in mind to check if they are applicable too.
> >
> At Git, you are free to work on anything that interests you. Meanwhile,
> the Outreachy contribution phase is not that long enough to work on
> some issues/tasks/projects so, you might want to take that into consideration
> while picking a microproject to work on.
> 

Alright then, while I would like a lot to work on that I'll hold on for
now.

> To iterate, the main purpose of Microproject is to get new
> contributors acquainted
> with the Git project workflow. [1] gives a good description of our
> expectation for microproject. [2] Gives the examples of Microproject
> done by previous contributors.
> Other important information can be found in [3] and [4].
> 
> Just to iterate, you can always work on anything that interests you as
> a microproject or
> after the microproject. Most of the selected past interns whether
> Outreachy and GSoC
> finds Git interesting and they do send more patches after their microproject.
> 

I will. First will do a microproject from the list, then, and later will
try to work on that.

I thought the list from GSoC was possibly outdated so didn't give a
look, but I see now that the suggestions are generic enough and likely
apply to several cases.

Best,
Ágatha Isabelle
