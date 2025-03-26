Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D29188735
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742968496; cv=none; b=hpMLV7RDSUWtLOdU3eG14n5DkW9FZR1Oa8H59FYC3P2dXxbFnA/Ur4qKuOCcG2F8P9r6Pqw1mNWd3wAetG1wzmPypMk5zDFSCIt+77pG/7cHlqJnSVC+N0c2h5pVxQ42HUStglmfcd8NpuNkG0FgvVtJdSu2UGh/X87RAqEQ8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742968496; c=relaxed/simple;
	bh=M1CXq7DYoWOVQKcApkifCns1RFwdYL2AsdxbXyy2xkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4hR+yv/5Ng219mU0j9Ma2H9N7gBW2aPT6j6tVILHiL7qypPRO42u6Wt0iL9B+Ez4x5UMixEciZfqoAWPGx17egPU1HYTli0O6I8QsG+yJgiCS3kQf9px9AnYU6rYIfwbQWA5S2ICKZA8zfqht18l8XTpg5NzYhgUexixnPml3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tq7xxT1P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vFvwm12/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tq7xxT1P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vFvwm12/"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCAD61140209;
	Wed, 26 Mar 2025 01:54:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 26 Mar 2025 01:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742968493; x=1743054893; bh=31qBR2b7zG
	kmQHL+e2jlKMHJof3Pu7VwjiyuNsHE8Jo=; b=Tq7xxT1PifgctUvFkUPMviVQgD
	DRR9Ef+iYrFeXNyOOUvcpvaeQXDHDeJMElI0JcvdfY3O39j95/BlN96YzuWPoiAE
	dm6cF42sqSOd6chqwSI+7lvp1z2vMZPjFfxmD94UWRLpBJ6/+cWaN4OpBBO8IGXX
	gOrIj+y/Ol5rzQjVLK89tMqY7X3JLKiiDrBA6MrJN6202q2lNyX9YhByUEg3FAe/
	hJqvvmWpOXSJcFEkyx3+UvIRunCOt5hdgAJBTTZXqCGlf9xjiyCupn6ym/SRJfSb
	tkddFQBH+gul+FxlJc59UCjyATpUR8rsJwbkfNfQZXYHvsCKiu2CjnoKUOTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742968493; x=1743054893; bh=31qBR2b7zGkmQHL+e2jlKMHJof3Pu7Vwjiy
	uNsHE8Jo=; b=vFvwm12/H+xsh8NOIdU9fD4wpVRk2Ll+PUORZQOQ+CukfrI+dyu
	rVB0E51Y9FOzf2WBQVlpBwSKR3HTJPtQOn3hiGPoqP4xlpKSYtEZE9TliHpe7AbM
	OZqbV6Ct5zuY+y1EvCjA3TsZvMqJ6ESPpanPC27s00FNKsxekHatgCdshA9nv3aR
	6z0uHvpI3Ud7HPHEXIXZ2S7e8ss568LgfJk0liF4TQivOg/eYHHzBn712YmofjNZ
	dYkvBAtVKvvvpUNphaNIu6tUjbXc0WJFfoT8u5HumeANwNYYQEGWbKLHuViNo8qV
	PKpM80dFjsX9xLlEw0/Vjh6pK3I7xMMuJpg==
X-ME-Sender: <xms:rZbjZ8S_hfYl9MFznULH5eHEn4c0qozvK5X8O9clUpKi38pWS18TJA>
    <xme:rZbjZ5za4ike8f4PqyYbiKsXvtWqfub5xSWhNiQ939hCSO62BuRYsBht-YW_IWX09
    _VGExcyxZGHCBsG5w>
X-ME-Received: <xmr:rZbjZ52UL21YjIm3yA6Z1D8owZJNAh1QEZr7Z_Qs1LSOWLdGRxk7LLNOf0ZWOY4-eK3bGtwf17RXXJNpmb2cQ-0N4KDnDkpSSgW5yPQJ22xFQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeftdeitdfggfffffelgfegudehvedvkeeutdel
    leegueevjefftdelgeehleejnecuffhomhgrihhnpegtphhprhgvfhgvrhgvnhgtvgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhiphhorghklhgvhiesihgvvgdrvghmrghilh
X-ME-Proxy: <xmx:rZbjZwDBZqiO3GmMLk5BX9c0cWzNB3ONzQLZXNVXUAbmTyMHKU46QA>
    <xmx:rZbjZ1jxaS1V7F-Eau-hwGPAcu2L6AQTxBOx3QQcgp1WRVteTMO5Fw>
    <xmx:rZbjZ8pu99IxLcH1z3GOm3OQBmgmsjDLuFoWiOuOhr-0apzXHtm_cg>
    <xmx:rZbjZ4g5ueGRTbPgTTCZ3pbGdh9JqWr_mVbyreNjCl3Uu_ZjfPYIaQ>
    <xmx:rZbjZ9hDaOmkD91uMqvAOPvd7Z-j0ict4KUgCy9dRZUF4cPXspuaHtja>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 01:54:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d429c8c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Mar 2025 05:54:51 +0000 (UTC)
Date: Wed, 26 Mar 2025 06:54:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] Avoid the comma operator
Message-ID: <Z-OWqs33rcgbYcR8@pks.im>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>

On Tue, Mar 25, 2025 at 11:32:04PM +0000, Johannes Schindelin via GitGitGadget wrote:
> The comma operator
> [https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
> rarely used in C anymore, and typically indicates a typo. Just like in these
> instances, where a semicolon was meant to be used, as there is no need to
> discard the first statement's result here.
> 
> Changes since v1:
> 
>  * Use -Wcomma when compiling with clang and with DEVELOPER=1.
>  * Address the remaining instances pointed out by clang (and by Phillip).

Thanks for all of these fixes!

Patrick
