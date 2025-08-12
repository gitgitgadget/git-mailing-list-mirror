Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4731F9A89
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036733; cv=none; b=CCKP//lBc/KpPk8qTTjdpCBerSm/VCBwiBge9qdXQ7zi3r7BHMiuR/tG4Ndyxs5ZzlYPwzrNNShCxLkhmXLAuVkR9g7lnqiEHNnyuSh0DEhl6CBz+ZYAEix8c9UrpqHxWkdcXlZMZJycykV6MquVdSCu/xacCgL9TkOm0looVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036733; c=relaxed/simple;
	bh=E5x7ZflzDfCAibUdmuw/bGsJ6j9wNz9epVEdkg2EfQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rgZXr8x4VZ/Zx2mvJth1EvoCAOSPYjci2Rud79Z2qEdaW5qPKnBV+qJlgJF9yrl1IjkxFvBwFG6o7SPQ3mP+JH6fhu3Q6Li1B/WOsC+zEBReC1pD70t2s/NZ9e/lya/Q/AAktCljXAGK5eKvctcGPO3KXDuEDEtR4ZlDzbR514w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DnmojxG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HDCXOiBS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DnmojxG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HDCXOiBS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CCCDB7A0112;
	Tue, 12 Aug 2025 18:12:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 12 Aug 2025 18:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755036728; x=1755123128; bh=UWr42Oazqw
	Ez0OrLXerQqmAX2cnl9OjxgZppFQUC968=; b=DnmojxG7AxWvDIh0yMcdNAl3qZ
	E/G8b1jyJ8yR8dSRkZSOlQDWT/NCMDpwXHnmFk/xmnyU6xrtFhfOhb8nRn6kSneg
	bVf5jXRZYHcqTQtSOXhLsUZW1picLevJPKkoFvY1cyOT4C6tIFoqyvAVB+/TcJmB
	9O2lF/+WhPT2nc4Al9xyNVNUX+I2ylN6yWY6xMcx24pbIFL1jz1P3Z4ry5j/JFQo
	YFJP/8HbE0hIOKTwS7exr3ojrTgpThWEpIYlOQ7u78MrwGL9OQFRR9EPaubZprKO
	DqotQc3tPGwznAY+RgyqEM1fSNESOUN78UWETE57t7t5bmHcJTpEk3+JIQKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755036728; x=1755123128; bh=UWr42OazqwEz0OrLXerQqmAX2cnl9OjxgZp
	pFQUC968=; b=HDCXOiBSkZ0w4bkl/pMa/crQwDZhEAITJQcbWaEI4vAdo7ZDNb5
	7AU1wqx9w0NTq0jTpxcV8GsmuZCe9hb74YkIlLS+ZTOcvFPnLbATEnpNhhjUCGPG
	JJQsIzDb+ye/3rG9CkWjEKdux219RgrEF1BfSLOLoyDKUtiYZM7+gWcJZ6KkJQ1R
	Cwm6txnrgfqDC4ZITGB8yoHQV+XJDNCbkPnt0KneyEvbkP17Yi0D0Z6p+N2KpPxF
	l09iNUq2Qi+1WqKocc6f08HKgses7Q74eKvvMs7mMX74v5h/Fhgew42070oDCANl
	disjBFO2lX1e3U29/MT/XeUxX+dwikx4PDw==
X-ME-Sender: <xms:OLybaP9Svue2yr6nU9Piy_fVbroM1SOvXxUrfDxrV3LX9__IsF6GFQ>
    <xme:OLybaGR-mL0PefpZyslmMG97suBwn-bTIrkh4YMm83HHZ4hsHdKdq-PTRAuNCh4Ui
    l1DwNivdVyTMwxL1g>
X-ME-Received: <xmr:OLybaJm2y9BEOpAdosBF34SrZk0H50-EqnxUBusl4TlwvTK3TDfgdtulZBYVmTNLOLQ6PMEjSVhC-V04jijX8g6e_6kDwyxi9AK7CSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:OLybaORqF53mWPCbMXdpK0Bz3fo2NMUSQ_2b-TE0WSxz9ra5YcnArA>
    <xmx:OLybaPOox30yhQHDBH0I_Ymut6CP3fdDWiZfsrHDiQjHrBcna01xLQ>
    <xmx:OLybaPVUvPGISiQr70fMzpjUc_QlQ6JoVkFpZux48n2MHtiio5jmRQ>
    <xmx:OLybaOcwjQT3URDiqM5Xj3_Q0or-wqqpF7dmVJp13rXN3CHrs-hgKg>
    <xmx:OLybaKO9LmoE0Dpg-JYE3YIm_buclhC-s-F96ip7VIPjJf2vcLKqzcTI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 18:12:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] doc: git-add: start man page with an example
In-Reply-To: <152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com> (Julia
	Evans's message of "Tue, 12 Aug 2025 17:40:19 -0400")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
	<xmqqbjoks19f.fsf@gitster.g>
	<152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com>
Date: Tue, 12 Aug 2025 15:12:06 -0700
Message-ID: <xmqqwm78p4uh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> Wouldn't "add file X" confuse folks who still remember how other
>> SCMs before Git operated (i.e. "file X is now known, so if I make
>> further changes to X next 'commit' command will record it") into
>> thinking that Git would do the same?
>
> The point about Subversion is interesting: I would expect that most
> people learning about Git's data model in 2025 have never used
> Subversion.

Even though I promised that I won't comment on this thread further
for now, I'd have to respond to this one.  

Times change.  I didn't have Subversion in mind when I wrote the
above.  It was CVS ;-)

Yes, I have heard that for recent crop of developers especially
newgrads, Git is the only SCM they've ever touched.  If we can
assume that the data and mental model of Git is natural for our
intended audiences, that is great (we can also forget about the
diff/patch based world view, which comes from how CVS/RCS stored
their revision data, and assume that the snapshot based world view
is natural to our readers).
