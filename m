Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573523A58B
	for <git@vger.kernel.org>; Fri,  9 May 2025 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746777246; cv=none; b=hHMME45ESByNp1D/3ATPUAPIXWSjlS2kBeEd2OpQu7eygvsQ+LVaN4qfHOA6nNjVeJhXa8Xx0GUHbsB+R/ZSN42bqRe+jnXBNMBhkjN+w2k8on0YtsvyzT2bfywRDTptIpFjeTQBIDZU63zMi7S5MkYn+Br/U+sQuIVPWMVfafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746777246; c=relaxed/simple;
	bh=QXAnuNiMjqeRCnfORMPsW+B4/tbLGLAWaxMpkk1hRqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E35mMeAOMJuNqveOd+6QcNb84Sr+1dtjJDTWcBxIQ868DCSYzFG/5swx5VUfkVqc0ZuPWFNy6x9oGvIy3GHIt+M0nn//Q6/77kNYgFijiRc3kHhWynmbX9B+taqUpjqwoBeD8b42E1qCyfKF/470KoOAX6zI5eEVgSMPcE0CnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PlJKqq4G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TN41wvyw; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PlJKqq4G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TN41wvyw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 77373114018B;
	Fri,  9 May 2025 03:54:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 09 May 2025 03:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746777242; x=1746863642; bh=xudF8cbAyS
	Q5stq6GkGvimn8M2hLacArgt8hsabNq9I=; b=PlJKqq4GKg2U1kzsDeSrotB0nj
	t6LVenX8IPRYmR3dXm/3Vh4JqcrrZwzOL6pLLJnDPkiBIHWjX1NBYBDV5sgXnJ0g
	mUIgM0vb1HfpgexnjPiTGBwlqFjvSI95sgfHt45mtl7ce9vxUOMatCW8+HLCMH7T
	0s/0DZimXi8VeHKWTADdBf/yKxh8PvGrxnjmptqqwkH+WPDWw70olLljT8kyFKFg
	A2dkLerDSWEbQJUEu68HbSUBtV6szLNbDKtAcqvGRpC0g3fpygy+f3qMHP7tgjz6
	bqvIe0mCx2CJHY4ZQD+8HKpk8Jrk1OCuRsJbPR4ElDYjKx0dtNbzZvdqGA/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746777242; x=1746863642; bh=xudF8cbAySQ5stq6GkGvimn8M2hLacArgt8
	hsabNq9I=; b=TN41wvywYVFqW20o0X0G2uUriLsw99BBsKJPdKETPEwPkWNXW5o
	XGmsK6oAItVOLNcKXc2Aczezp40Hy6BuirnAdAEEk8cnKvvYbx3lsWMXHV6atbFP
	6NwmUQ6wjLnq3eTFKt32N7/qW0gyGd2cgYf93tnxPCLIEN5T5NvzVWHRelKzZvTC
	EwE8B+KVek6gBMtLdsIeQyx+on/19uqg3QeIzlH0HRaxJHaxICumCn0MO5jEc/Zx
	6ZPTSLK0pks6OQvYiqQVl/BAlcFHrQ0/eiXYfw8orxf3nzlh5qhEsyjgdHt+y9yP
	kOP9IK3nrHbKIcl4Inr5H05P8byyanguQ0w==
X-ME-Sender: <xms:mrQdaJBgWi-Z02EdC4Ngtatj8fqwq2E_mz78Z316vR2U2uCvOvGGsA>
    <xme:mrQdaHiZ8ojMR2LPkFkgb-qqjdt6tY7QgRctACuXi4cONnm6k3OZ5cGtzqCjT7A17
    SeXyqhuEf1rOntlYg>
X-ME-Received: <xmr:mrQdaEmALccFSOg3QLK4sRPPk2gNH8CoLyynVRyOXAvaMpnrY0OBI93DGsljzAVnC_-Si29kuHRFAvKRDxVkMFVmnAGl7dFsv31U5BRADA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:mrQdaDyh0IWeE7xoDFUSq2VBAiNFisE3atE9I_BM5IIsersbx5yvVA>
    <xmx:mrQdaORSRFJyWW5IE7ijTLdt_SiSR735xsLJmaCLoSTfERUs3FTYPw>
    <xmx:mrQdaGa_pgyJFTk_I4yFWiHSrtb7D_-zwom4KjqXN3KRTIvxFWPaNw>
    <xmx:mrQdaPSzmosQP_dpUMz2iIapElaQIvqfUdXnhZYrWn3CuXt_aZ_Gag>
    <xmx:mrQdaNACW30tKJI0djoZXx7WWf32smtHoYAaSAPgn4qU73ArzDTU-ciB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 03:54:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9eef004c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 07:53:59 +0000 (UTC)
Date: Fri, 9 May 2025 09:53:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] contrib: remove "git-new-workdir"
Message-ID: <aB20kvkNy48JnJc0@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <20250506-pks-contrib-spring-cleanup-v1-10-e6d5ddd79a72@pks.im>
 <xmqqjz6tikak.fsf@gitster.g>
 <aBr9ZhSmbYtRp6o0@pks.im>
 <xmqqwmascoyj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmascoyj.fsf@gitster.g>

On Wed, May 07, 2025 at 10:25:56AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > If this is something that the project can agree on I'm happy to rewrite
> > "contrib/README" accordingly. Maybe I should even do it without having
> > any consent yet so that it can serve as a starting point for discussion.
> 
> Yeah, the latter is a good attitude to see.  It is way easier for
> everybody involved what the issues are if we have something to base
> our discussion on.

Okay, I'll do that in a follow-up patch series.

Patrick
