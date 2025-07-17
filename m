Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E721A436
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739430; cv=none; b=qZ6fp4XR+GnW01XRM6gchfPwcFbKKM4QOdHQ9qU0GR5+hne0g2OC2AjL97nMCV3rMUQzIK9ny5hQOnLPxjcEs2V5Bnk6vEyT4yono2E4eS32pJ+HO6vGx+0soVSEqBmIQPvH4Le4BknBEs67XWVjiX9HCf/679ZYH0LOFDbIi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739430; c=relaxed/simple;
	bh=Qp7pzpMt0+PW0L8SSMaR+4qo0J43XV/ZH8Jm7M3gdXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYm808ttJkP03QT5GWCwN/vrKEkONmQ4R9q+nmSyHxEZ61P63vQZ87ZNZWX9dnUd57oLUNmWoI8stgzHPu3MU7vPq9j7fPK3OLR98muPmwdkhjF89whew18y76/0nkLJc+zc69XydMhU28qh4RJmfY963oDTmeKTpIyJHKZb0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ROquuJoy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzU0oKVd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ROquuJoy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzU0oKVd"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B2B841D001A3;
	Thu, 17 Jul 2025 04:03:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 04:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752739427; x=1752825827; bh=cy8oRvBY5I
	v1a03KkA47lciW+5vnLFDWuMzCJq55cJk=; b=ROquuJoyDN2MhoMhkRiT3ApD5X
	+YH/XTvy89UhhjJuJ8Zuc+/0AgLFVpwLvoN/1vYpLBhTqWrs6Fa9Eh/oVt2LG2E1
	ePI4AR35CeZsr9amRu8lwjG9j905B4O8V9pkuBaxCiCxZ/E9ecVv1SeKXOInrcC3
	9dLNKgPsAvEJQlf2mQG/TkbU+d+3fTb6WdC2/uF3YwSz7CEpfdHEpNw64orsADNI
	jNLCDeQ2oT2w6YInUZF2yCDqFe7TDhbEt6g8yWWAKyYdb/ESnhqyRoCKaHnQuCTp
	CL08VV8Tjbpvl0iVcC3VTIIVb27BvHG6WNiFteYhL5oYE6kSylqsfXxloc8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752739427; x=1752825827; bh=cy8oRvBY5Iv1a03KkA47lciW+5vnLFDWuMz
	CJq55cJk=; b=dzU0oKVdrLpi2SdCX+bF2IZ6JCquGGDt10jTYrWfgrZNoH8KWpW
	OQVn3/OUt7eWF0qMGyFYNb430oKcgVkaZc749FMoZ/IKmFPAHweB3YDR8wl/re8e
	V1sFxg3GQ9gRuEbSXJc7FWGyQtXF3Y4z+InViePcQwXl6ZSF/VBqOLhWThR6eb0k
	DYTK/1D6bwT2VU4I5NlM3m6vzzgYOuxypLeii+8plt6yDwlTwEd8GLdQPdXAG12Y
	jIEr1NbZwInCtMy1JKewOxStB+62BpkpRXbVVN759ziClDUCIOVNmL5tVQhvHEwI
	T5Tj8ROpIEqEtCdcREJSynzjeRBSTZkgLLw==
X-ME-Sender: <xms:Y654aItfc3Js10RqKPsFVjMgbi-G1TEYqfcGnFi6HxgBV3rPq15zug>
    <xme:Y654aFqGYzUqaLRf74Yml9jasBWC-8ut6mkRH5xFWYpVuzD-lxAp9WtFVvuhBcrtf
    mRnpYW3i8SkeP5h5w>
X-ME-Received: <xmr:Y654aFlZ5zRqwKKEfUHz_QvLGVxXRVY7APYDdWqh2X3CkYCnzybIqQjy6Ihj6N9W8EqzI8n7EK4_pQKRuZVmHF-S77hrCMacFXnk9pBaqRnW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhufhhorhhijh
    hileeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Y654aJx-mdbiE-y0XGAwYT5elUYJkVrkDbbktS3uqhKxc-EA9l4Y9Q>
    <xmx:Y654aNn7guTB-ssB4DfqyGDuThEx4-x1PY00s4xVojhG-DDYISOrTg>
    <xmx:Y654aCfkqi8oNkJcwOnx0c6UC3X8Gtt9Ws-vRrYgxoEV9fJjcOh80Q>
    <xmx:Y654aDomhKxFibSRyoalozz2wzHca5Zcf779db7JKS4oIYN-rY7tAA>
    <xmx:Y654aCw0CA3owzdNs7IFu3P9EMhJRaXwOHNdKOWWLcYK6QYrPWrwKfN8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 04:03:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eeb4e8c9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 08:03:45 +0000 (UTC)
Date: Thu, 17 Jul 2025 10:03:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git Mini Summit at Open Source Summit Europe,
 Amsterdam, August 28th
Message-ID: <aHiuXh-y6ah74HcI@pks.im>
References: <aGwHt9HCd86hVuKh@pks.im>
 <CAGedMtdRenBejPanZ4JJem_35EUX6v9v3=p4v4obKQC=DDMw9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtdRenBejPanZ4JJem_35EUX6v9v3=p4v4obKQC=DDMw9Q@mail.gmail.com>

Hi Seyi,

On Wed, Jul 16, 2025 at 10:06:46AM +0100, Seyi Kuforiji wrote:
> On Mon, 7 Jul 2025 at 18:45, Patrick Steinhardt <ps@pks.im> wrote:
> > If you want to submit a talk, please send a short proposal to me. I will
> > vet these proposals together with other involved parties. Deadline is
> > July 28th. Furthermore, if you got any other input, please feel free to
> > send me an email, too.
> 
> I would like to confirm whether only those attending the event in
> person are allowed to submit a talk proposal.

Definitely feel free to submit such a proposal. Meanwhile I'll connect
with the Linux Foundation next week to figure out whether we can provide
the infra to allow for remote talks.

Thanks for your interest!

Patrick
