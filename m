Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9A13DBBC
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727220856; cv=none; b=XNDzwU3gH9cwtsN9ZSkHjZXLPd2w8SGOXTKNigIJkCuU8lhUed8WyljMpz6ihpinDkWhtO0YIcBkRJCrSkA9Q+eAbWWStEsT/Uu2SgNRyaeQJuMRpDOPmu8ugWSOIOF54dnw148d4qjkbQVjInCVi0yPeDixgh10fqVtN0wrxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727220856; c=relaxed/simple;
	bh=hQXrs3AcWbKcm30e2owLbxCoMn7hHjHyzWBM2nQRGps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bPSQr59PqDjP/qHgaN0Bu7UGtYR4x6OzMvFVswbwWJtogdsevAUwBgjug6Y7yW/iQtnWxb4Upj23wyy5Em9i7jIDFjxx4IRQ0uUGyYMkQmJYIb5IRmI35VsDCHza5+aGtO5EBmojMBuFgdVloBFo1qydIKgwBgEKCJ+EcGV1kBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jrk4nMM0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jrk4nMM0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 259581C10B;
	Tue, 24 Sep 2024 19:34:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hQXrs3AcWbKc
	m30e2owLbxCoMn7hHjHyzWBM2nQRGps=; b=jrk4nMM00KN2VWLe1u+5VL/druFV
	OlRQTth1aTZB+xl4ypLhnw9GS/v1NAzpBsSX85cI4Wzz//mfJcAajg3fTK5IH28f
	/LAdc5Hs4WDIhZRjUrAL9JKNmYOueRLwcNd421qdkNn10PbCkhMJmqjiJQDfw61B
	qpb+rab7Ukms/eY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CEEC1C10A;
	Tue, 24 Sep 2024 19:34:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 847D81C109;
	Tue, 24 Sep 2024 19:34:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Chris Torek
 <chris.torek@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/3] doc: introducing synopsis para
In-Reply-To: <gfwncnuvogwawlvp7mr64xrar3xv7fmevy3n3puro25wubi6mq@qdt6qmqi3o5n>
	(Josh Steadmon's message of "Tue, 24 Sep 2024 15:03:21 -0700")
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
	<xmqqo74rxvw0.fsf@gitster.g>
	<4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
	<xmqq34ltbkah.fsf@gitster.g> <xmqqy13la5jb.fsf@gitster.g>
	<CAPx1GvdfE+v-wV=gbTZJi6GvwGhw8NZcZHnEwj0K+YSTfMs4Kw@mail.gmail.com>
	<xmqqh6a6496d.fsf@gitster.g>
	<CAPig+cQgw8xf5bQaUEW=qvKQpnxrkiTrMsqa+VW9d_GX0au1sA@mail.gmail.com>
	<gfwncnuvogwawlvp7mr64xrar3xv7fmevy3n3puro25wubi6mq@qdt6qmqi3o5n>
Date: Tue, 24 Sep 2024 16:34:11 -0700
Message-ID: <xmqqed58r5ho.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8128C912-7ACD-11EF-B7B3-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Josh Steadmon <steadmon@google.com> writes:

>> I checked my High Sierra installation (macOS 10.13) which is even
>> older than Big Sur (macOS 11), and High Sierra's "sed" also
>> understands -E.
>
> Hi folks, sorry for the false alarm and the delayed response. For some
> reason our build environment has a >decade old version of sed. I'm stil=
l
> tracking down why that is, but please do not hold back this topic any
> longer due to our out-of-date-ness. Sorry again!

Thanks.

I think Jean-No=C3=ABl's latest rewrote ERE down to BRE but also tweaked
something else around U+2026 =E2=80=A6. Please try that version again whe=
n
you have a chance.


