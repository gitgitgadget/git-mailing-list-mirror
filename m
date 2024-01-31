Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7503FE46
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732707; cv=none; b=bSxOcOEJvfoIohkIgzOBMUkxbGjOUBXnOwWCue4kvoH/Di9x0zd1xyOEeikad/M69g6RcJNiWUS+YCo0JlCMY7DaaXvNIUx4qYfXjbzR9qFeyth0+r6ll5fmrLE46r8CdaloAriafaYzB8Rt+nHbpt9zanlEPJARYLeiSoVuPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732707; c=relaxed/simple;
	bh=sjp4SJ3RGaEGpW5hsnJgAC3CvaKcZdA+YoMjkiMckwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QMYeoqMPEkV5YaFeSypPHOXoAD1lLkKSEucYwm9apUqj0n+CytN0kWqCGSUUMxHgIjO6gjMrdxZH00ZhfKroD6O1uli5BoKOYzNSrlMFC8cElTJ8eQvDUVHPEOlrsTIl2VDD0O27o6uB4IdRLTkeD+4l4dh9Fuq1buEPI5RP+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A1vqABKY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A1vqABKY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 573FE33874;
	Wed, 31 Jan 2024 15:25:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sjp4SJ3RGaEG
	pW5hsnJgAC3CvaKcZdA+YoMjkiMckwk=; b=A1vqABKY3wbADjH5ajaEaLTbweGI
	mRNr6/7nzM4EsKn8D1e8HAjLllhkTX8Usv/OlirsV+7+A+7ezr4LNFAABrhxguAb
	HRSAKyFFDuqyw0T1pwxGgm4LCqC7j8oJE+N+thmVEYMvPwbZqocP8309N8/za6os
	f0hYbDgsktHtSdk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3954D33873;
	Wed, 31 Jan 2024 15:25:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 544AC33869;
	Wed, 31 Jan 2024 15:25:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: FreeBSD CI suspended on git/git and gitgitgadget/git
In-Reply-To: <22cfob7wthmveupp5w7dbdtbparybcsdagoitwneqw6f2cmhs5@x3tnbbftvtyw>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 31 Jan
 2024 11:23:20
	-0800")
References: <d2d7da84-e2a3-a7b2-3f95-c8d53ad4dd5f@gmx.de>
	<22cfob7wthmveupp5w7dbdtbparybcsdagoitwneqw6f2cmhs5@x3tnbbftvtyw>
Date: Wed, 31 Jan 2024 12:24:58 -0800
Message-ID: <xmqqttmt45et.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CED1E606-C076-11EE-AD54-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Wed, Jan 31, 2024 at 08:11:46AM +0100, Johannes Schindelin wrote:
>> Team,
>>=20
>> I noticed that there is a problem with the FreeBSD runs on Cirrus CI (=
see
>> e.g. https://cirrus-ci.com/task/6611218006278144):
>
> Thanks and sorry for not catching this earlier.
>
> The proposed[1] "fix" runs successful and might allow (albeit with the
> warning about prioritization) for this job to be restarted:
>
>   https://cirrus-ci.com/task/6173598017126400
>
> As explained there, FreeBSD 12 has been EOL for a while and therefore t=
his
> update was long overdue and will need further tweaks.
>
> Carlo
>
> [1] https://lore.kernel.org/git/20240131191325.33228-1-carenas@gmail.co=
m/

Thanks for reporting and a quick fix.  Kudos to both of you.
