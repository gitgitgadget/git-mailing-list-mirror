Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BF32692C
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836881; cv=none; b=lw7DGFylg4PxY3ppZ3pa3fS3huSxAZuFLSrwxfkLG+XP8mzptvU5ENILxZyuzS4CMnGJ1M0NnWQBkAGoS5faeHZvo/VCB6tzyd6BEj5Cf7T8mrTmNUz7y6pRK91rKIN4j71DCaglTZtf9Ybg8BOJA3LAEyEaEb0aZRzBy7PO6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836881; c=relaxed/simple;
	bh=5aDpbhe8ZZ7p8KLzOS1gke6BnIMh0BdvdDZNAm8ByTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bTspZ+AF/DPjNTVSyDdcKb96ePZBhTHzpb0UGr0Ur/FZ/mPjGfCQY8/htllHD4HbtOX08nSbI7SstV6hxuzivRdfYmTRizTjtVrc2+dTgg9u9sirRitQFDUp2sdfyDCQJ57cEd/06j3Qt1eh8hJkxrove/srThNxst+Zd0/Khqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zDOMmK2E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hl24LKkz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zDOMmK2E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hl24LKkz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CE92FEC00B6;
	Fri, 10 Apr 2026 12:01:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 12:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775836878; x=1775923278; bh=jUVRhICY27
	RhTp+byLUT1rIOBmZA+VEXJPNKwK8MQDs=; b=zDOMmK2EG7hFMmV7AWsxcEc0ub
	3kcBNR6GHquuzK5OMb00lonwjN9sJuNyKRmHDALrd+Vhw10w0bDFhwmdVQ0S49cN
	qikjxRmyT8Ly4j+eTcteB24LJJZ+t7Cn4+MNr3QsqFOz4gTbDjhc1qEY4T4+Z18/
	gD/MncfW6zYgb4kz9840oUOn2/Dtut3M6KtwdO0PJe0Je1VJyNaKJAYiPxFFkOCp
	EKMr5XvcZl4V4kZdRW9fmsj49k3rb/l4REhXHARcGmNfjcFbsdPQdcMcUXAl1baW
	JqCS1UeWmFpKjaeoTpzNlEuyYJtrpqBSYJqKcL9G2RLXme35lBcrjDjQ19jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775836878; x=1775923278; bh=jUVRhICY27RhTp+byLUT1rIOBmZA+VEXJPN
	KwK8MQDs=; b=Hl24LKkzILUt7QYD7yELjb83/eCcNz4oh4FIaQRdOIVYn9CvCei
	JmdQRRZS+ZpSWy9PFWRTehL1zkGjA3Mm7z7IIrw0qk1kGKCmcvFnTT5HKwXC31CQ
	xvj0UWZE8LbmGUJi0xvhfeZPWn1Z8ljK/mUM7pxY+h6ascIxtXupdPfzUpU7ZlOO
	+YCB1A+J0zm8W6DO/GdoUk/wR0T3LubCf6oDAHufxMp8bVttC6UqhSFH7jD1RmfE
	kZUpUjqD60skykS1I2m76j+FGS352aTDoIAZYIUTIznhTpMQptfjTVUJyZum7Qhr
	IANCbyUidwC9TGaW7BgpCNkjuVlfrlWkEaQ==
X-ME-Sender: <xms:zh7ZadnpXHcgxeQqcE2ALuuekPcyorHoFTDaPxuMxHr1d2wTy9bSOA>
    <xme:zh7ZabZnaEHHD02BXiwfgxgwZctXYeGLTLowC_npLju9wxxYIck4WcF00iWG7Tya1
    0pLRG2RWLw_uN8JMtLCQbgLjdyo8QMuR4kvtQe2_lhirEAxunDDig>
X-ME-Received: <xmr:zh7ZaXSBh53VRMVu3OX3X9GXUBSeKWMJiUE8zqEEDTw8Ss3a8TEs7FmZVouFVTWUs5anGF9vC9WFflzKN2BxwGRat_RV3xIFxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegjeffkeeihedujeeijeeuteeggfelledvvddvgeelfeduveelkeejjeffffev
    keenucffohhmrghinhepshhtpghmthhimhdrthhvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhorh
    gvnhiiohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zh7ZadsLfc0gpqJpKlCdf9iyLqeuMrWMpJbScFb1l4o3Vxu5Me3GpQ>
    <xmx:zh7ZaRH-SDC-4_judaZULD0d888z81XYPgvpEcIa7ibSLUGGg1nYEg>
    <xmx:zh7ZaWwppSrQPyIsP01IE1rI0JzV77IXtwKHkiSHuyH86LHfPahSgw>
    <xmx:zh7ZaT2nICwmWDecBojMrayx91TQh5buTE_SJuDXHDnNdMJX1Z4DFQ>
    <xmx:zh7ZadoxXD023sn6vDOS6OM_nR0IpR3srz7ThkkqewiuWHpOEAugTCtQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 12:01:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Tian Yuchen
 <cat@malon.dev>
Subject: Re: [GSoC PATCH v4 2/5] pack-write: add helper to fill promisor
 file after repack
In-Reply-To: <34c4e793113f22c393a6196d6e99a96d78cc3ab9.1775832056.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Fri, 10 Apr 2026 17:02:51 +0200")
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
	<34c4e793113f22c393a6196d6e99a96d78cc3ab9.1775832056.git.lorenzo.pegorari2002@gmail.com>
Date: Fri, 10 Apr 2026 09:01:16 -0700
Message-ID: <xmqqo6jqpzxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> +			/* If <time> doesn't exist, retrieve it and add it to line */
> +			if (line_sections.nr < 3)
> +				strbuf_addf(&line, " %lld", (long long int)source_stat.st_mtim.tv_sec);

It should be easy to see in the output of

	$ git grep -e '%lld' -e 'st_mtim\.tv_sec'

that we do not use these constructs.

Write it like this instead

				strbuf_addf(&line, " %" PRItime,
					    (timestamp_t)source_stat.st_mtime);

examples to mimick the uses of timestamp_t and PRItime are found in
many places; worktree.c, date.c, builtin/blame.c would give plenty.

