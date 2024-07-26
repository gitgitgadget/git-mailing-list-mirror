Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9F42AA4
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018294; cv=none; b=c3hm4zohD1H3CQQJM8orvC1opBpSaImsVA+uppo1tKFUMbg4RPDqRV5pSoyCJr1zJHWyi4lO20fHv47l01k5G5izPyAnb2X1BmKFF4oEramc+ojzh4IqmfbEfGms449QsuvotKskd1VqCT4Tt5eD/IYAv0n0lz0imiVHvOLw+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018294; c=relaxed/simple;
	bh=/KIcONenJhywSaEoX35vp15hX+pTNWIkVXZraMMSX7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OX2Ka6ZCoWblZupl35y43sCT9V68/O00t0z4ZE1G647tSLIq7dLLfSNmsPbIo6VCXVAHKw/nDmQR5szloC9Mn8aAP/uirUlhy3tQCPgNz2s51EYyz13yxuX2EpnyGUBSipw1XHOI33x2wQCeL4kmLr5NyimhF1gYF13qX9kz8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ANMRw13L; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ANMRw13L"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFDF422F88;
	Fri, 26 Jul 2024 14:24:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/KIcONenJhyw
	SaEoX35vp15hX+pTNWIkVXZraMMSX7Q=; b=ANMRw13L4B+UIZsyOL/ZlFfhIpfx
	zNclLwjU1E1BSkOotD9P7EVADc4bnvLuGAvvsjl7QIefUaV7y1RAaSVYKm98xFhg
	HyyKfldw4gDe3wDdL9LhgdbA8d8mlR4V5rcrFUQRBiavG+PrSINOycJQPcRWFmMO
	kKEYI45JaSuCsvs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E7A1522F87;
	Fri, 26 Jul 2024 14:24:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5ADFA22F86;
	Fri, 26 Jul 2024 14:24:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>
Subject: Re: Re* [PATCH v2 0/2] add-p P fixups
In-Reply-To: <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 25 Jul 2024 18:41:17 +0200")
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
	<62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
	<2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
	<5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
	<a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
	<97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
	<xmqqcyn1lcjo.fsf@gitster.g>
	<24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
Date: Fri, 26 Jul 2024 11:24:50 -0700
Message-ID: <xmqqsevwui31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 590DD984-4B7C-11EF-B490-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On 7/25/24 5:24 PM, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>=20
>>> ... We
>>> can add a comment about the dash problem to the commit message when
>>> this fixup is squashed. Also the problem is now documented in
>>> Documentation/CodingGuidelines which is more likely to be read by
>>> other contributors.
>>=20
>> That is a good thing to take into consideration, indeed.
>
> Rub=C3=A9n Justo (2):
>   pager: introduce wait_for_pager
>   add-patch: render hunks through the pager

Hmph, what happened to the first two out of the four patch series?
Retracted?  Or you just didn't bother sending the whole thing?


