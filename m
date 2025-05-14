Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8926AC3
	for <git@vger.kernel.org>; Wed, 14 May 2025 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260969; cv=none; b=l/IXpyvC8zNJjQXdD2cCL4cyZtCOAWOcCpbHovH0jW3syZd4qNVlyRSACFIwDbvDjKdVEGUXFZDb7Q2OWiBClD+5xKIfnZevAq3MfTOvQOHxyZFUmIK7TRHLUn6avyoBZ/UiMTR67TmyjpVt1xRsGUFdN2bPiVl/ujvMi2eicQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260969; c=relaxed/simple;
	bh=j6z5OhFJPQekyLT5m+kb2TYYUznikweD3yUBuBGUDHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1ml4FICk8WwmR9wWaci124+LM1EHNZc/0MkQbrlzpYXKfxt5n4t5d2gNCChAOKPPvGWWJG4p2r9LW7D62ca4G2XQsxHjralquKXq6HHnoKbDSTummDqomBlB/tla0bSB4lO7hx6gq/QcEBRky+UDJTa/PSOv1MOXpU0FPpBGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PSFO6YtG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrPcwkb2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PSFO6YtG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrPcwkb2"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 35C261140109;
	Wed, 14 May 2025 18:16:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 14 May 2025 18:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747260966; x=1747347366; bh=CG3w1iiY4A
	Dy0S758GacBVpSBTDqzfIIONu1bSLZ/m0=; b=PSFO6YtGUgc+EADkpyKw40rcxb
	mNaZMS5qw1CI2GqDS7yEM4LPhtRwKLz/sqUl+Rgggfr0it23g5/J6GCiXiXQ6tBQ
	3AjzztaV8CO42nbJCWZzpGfOgOV/OKsmmfN6Jk9JAXgPsYcDuuU8Jh5rQ+fh5uhj
	G2cPAEKm6FX/ps7ZqRaN9/kD8wLGCeChmlis7U8KT5ZsmSrcpeqSNKWw3hXGT20U
	FhLxc/YdZFXXc0lmb2T8OlkLQ23W6uCOyypM41JjQpY86wDm+SxDVNf2Q3S3OykC
	fgOxsWVKBxAk9avkKilaI+ZV5Zyr7G4VUOilRtwa25n/9lid+AVEqZHz7swg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747260966; x=1747347366; bh=CG3w1iiY4ADy0S758GacBVpSBTDqzfIIONu
	1bSLZ/m0=; b=jrPcwkb2MMKv55vkR3uZ+S/jNtd7pb7zcExqM6reiq/mWvZlsZ7
	njlUt9nxLxutmSc6ZGZc2rj93QgDLctAXziQiwMJIR+ovJdKchdTr11vHCcO7g6H
	wPD4GRAEuSPPOjavbj9LUf963Bh8gINJNWkF9eSK5/M6nyOShs68oP5tiXkS3N4r
	okImz4p/zoJv4oBdXa3QDV4kxLNiEwtbwvEmlCBSJx/KJDSjWRIoYTb7xbSofTtV
	mCjecELcoRYYwEWXL/oW1QZI6E7wx+oXSGTcXFnQK0eIaELqDMtkP45NjNFNQEWX
	CWNtlxL24Q7W0QqGY4gDvs2z4I83y3rwFLg==
X-ME-Sender: <xms:JRYlaOLiekmxMHo5CghdddohtNGJ6j4Tmfg0S4u94G-pUToYOxn7KQ>
    <xme:JRYlaGLCdx2_JCZvJ3C3reVq6iqB3ufYW_htQrY_Fdg1tDPkPaowvE6afIAuiKBLn
    WatR9xnE81G_UGu2g>
X-ME-Received: <xmr:JRYlaOsnWkp0eBlCZ74u1gyUoNcWGVc6QkA2CguNMyNvmeX5Cdb5Cjo7h45f_UlhOPDQ6j3fNZ8LzcSSdl2URb-sRIpWNR4BjMXtG2U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:JRYlaDaNx4MJBDTbB_lgNsVen19iF3QmIIg55AfpNUZk5cJHw0lIcQ>
    <xmx:JRYlaFZo4aKs0VLgkQEB8DXvZD_oSrnBMAgutaPOj2UEktuuGYNePg>
    <xmx:JRYlaPBM5SGBYvpyRRWQ8PFCEV10RflhsLTO8YyFoVJ7LBLpEs5ocQ>
    <xmx:JRYlaLbznvHcxU1vUh3Bv-_UAd7RTjSiHl-7eY_MZjurLKavgoF52g>
    <xmx:JhYlaGR7K9fwprUsmjxey1vuhk2OnGUUlJMXlcDbYIh8i3OYQen9NP8K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 18:16:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 5/4] scalar reconfigure: improve --maintenance docs
In-Reply-To: <7534cfc7-751c-488c-9a98-6f422e5d0a81@gmail.com> (Derrick
	Stolee's message of "Wed, 14 May 2025 09:52:44 -0400")
References: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
	<pull.1913.v3.git.1746582637.gitgitgadget@gmail.com>
	<7534cfc7-751c-488c-9a98-6f422e5d0a81@gmail.com>
Date: Wed, 14 May 2025 15:16:03 -0700
Message-ID: <xmqqikm27s9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> Adding this extra patch on top to improve the docs. I could resend
> as a full v4 if needed.

Nah, the other four patches have been beaten to death, I think.
Please double check the result when I push it out later today, as
I've got the following when running "git am".

    warning: Patch sent with format=flowed; space at the end of lines might be lost.
    Applying: scalar reconfigure: improve --maintenance docs

Thanks.
