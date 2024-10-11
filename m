Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901A18027
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664449; cv=none; b=snBIQogfcNJnkD1+DJlY/ipqKolAaEL4+sfxlxVbJo5u/bZxGYuyba5v5DPtkHcVqxogGe2GB14hf0Qytc0IAnrYBo2AWeWRs3UNx9/pAfikl/RM9qpwRg85URsoMntwwGaPx4ZDiUzlXpa8PbpbiXcpRDs7MA62Rqn7TY5Et/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664449; c=relaxed/simple;
	bh=wpy3WD4cuxtlFzliug4wG+7BnWgvmKFxkv1Rfidtj8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RUZKDA1UE4+ivkZn/TtoFJpfY8u0gCYGy9Ovamj1if+x1YFt2ZkZOOQB99mIFoGKqH4w3YsEL+bt6VROj+PXfOilynjP3RfvFGD6KnodjRn8hj4Q7ImfwzX0f+m3OlDR5voiWmotll/uJbkaL31D69+VYZEy7i+XawGfm9jcA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WrSe3mFp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJc3Fyl9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WrSe3mFp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJc3Fyl9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C79BB11402E1;
	Fri, 11 Oct 2024 12:34:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 11 Oct 2024 12:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728664446; x=1728750846; bh=UkDNSZgC5E
	empPJ7o6hjkkSHFNN7GcJez9oTcS2VZF4=; b=WrSe3mFph+xIZBJrOdNJUmgLwN
	UpFiYFkHcQYpEu7w5iYXHbRQUM5jBJqLVL2LoSVdb0hpyeF2CpCEJTTrKouCNHcr
	qHR18pvekYue2Hz8FljOXkqFUi5KdeLwMZ4FfYbx44A/vw35vKKxAVN3mwEKqbpT
	j+1GjMLpam0VIOfbH8qcEk0ZEwkynrlTxvU8xvOISumAoA4//Akg4EZkWXUDbZ7A
	NuohRfeR5sfMmZhyjt6zZT3AbdPV9on9tVK7J9jJY7OkBgYN9lGTm+m/TWYbJPBA
	MyEe0V0fAG4xqWJVQVG/Vvd425cO/iye53lTTUZRIVYxMa04Gcupg3dQoMRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728664446; x=1728750846; bh=UkDNSZgC5EempPJ7o6hjkkSHFNN7
	GcJez9oTcS2VZF4=; b=HJc3Fyl9sXlnHQQDQSb9CQNRSEuENj5WAQBkIyvkN2t5
	R2jR3DghmZjQM4/STMCvGyfkT18nYf7T1KBPPft4glP1J7rt52bDGBEfwURbMYp7
	l+nQRe7pRnuRN3XqlqAVPncXWP994ppYaeZ6YO6gpTJFODmcIcyu4XOoSpdHzv2N
	ASawc0fgOQVFze5DIPpujbNJdqorEgC/ujM3BaDyVH3cUu/PKajL1MobYav43ny0
	KIBJ8vSBQv/t9TqbkdnfVXrsrkulphAbK9sVK+Wtgg/eKw0gI/Z7LEZfqpyES6xe
	7Y2SZ3cDVFL6sCDlveeVXPnnlAunvt8yOQ81Fc6v4g==
X-ME-Sender: <xms:flMJZ5OP2njwl4Wqi6pAtHVOpVmcRHIr9Jfh0rPDXILN0iowKuKDNg>
    <xme:flMJZ79Ph-84JRRh5xG626JyZakQkLAsKUj6XsBEYp9gapg_iLby8FVcId71sMh4U
    0eTvl1lPOUVr4yu4Q>
X-ME-Received: <xmr:flMJZ4TmtquSxzMkEF0V01y0kbkB2GMGT7IdRqaF3v0bDOGvT1eUJRLRXVy67UvOemI8_I7e9Ka0YirvrPU-vZQiY2IHqOjLJNQURlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfi
    gvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:flMJZ1sqjq5CvzhsVCD_d9GY_-0La8zwsSDb6CMSpVqfmPIA49qHdw>
    <xmx:flMJZxePvT5m0J4CdG1S7jQubDiendGZ9PlZrI_9NMTxmpFJTe9xUQ>
    <xmx:flMJZx0zX2GXXLuSY3DnZ9hnkuBaGKpp1DUFl-vhgi7XXaDFf5T8WQ>
    <xmx:flMJZ99izrQ51jwLVn92y4YjnADQ07w512tkR7hzKo-MENdmmzxD8w>
    <xmx:flMJZwx4vDIhGQt3V0GfHh9l-C5n6wgTek6hmRd4doWWED439HuaSI4d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 12:34:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk,  Taylor Blau <me@ttaylorr.com>,  =?utf-8?Q?R?=
 =?utf-8?Q?en=C3=A9?= Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 4/6] transaction: add TRANSACTION_CREATE_EXISTS error
In-Reply-To: <CAOLa=ZQA6vc246LRxW8n+a5qNDGxsSLUAhT-x-9tdAKDb2LBCQ@mail.gmail.com>
	(karthik nayak's message of "Thu, 10 Oct 2024 16:12:38 -0500")
References: <xmqqzfndndfm.fsf@gitster.g>
	<20241010133022.1733542-1-bence@ferdinandy.com>
	<20241010133022.1733542-4-bence@ferdinandy.com>
	<CAOLa=ZQA6vc246LRxW8n+a5qNDGxsSLUAhT-x-9tdAKDb2LBCQ@mail.gmail.com>
Date: Fri, 11 Oct 2024 09:34:04 -0700
Message-ID: <xmqqplo6ha4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

>> +			} else {
>> +				int checkret;
>> +				checkret = check_old_oid(update, &lock->old_oid, err);
>> +				if  (checkret) {
>> +					ret = checkret;
>> +					goto out;
>> +				}
>
> Can't we simply do:
>
>   ret = check_old_oid(update, &lock->old_oid, err);
>   if (ret) {
>      goto out
>   }
>
> if ret is '0', it shouldn't matter no?

That's nice.  Yes, as long as "ret" has no useful information when
we enter this "else" block, reusing it like you did is just fine.

This is one of these moments I tell myself "oh, why didn't *I* think
of that" ;-).

Thanks.
