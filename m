Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F01DA4E
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437109; cv=none; b=AZRCUkDNKDnb8G4XHubgr/X9EXiCsn5Wg+ArrJA4SVoi1ITlGOuryHZUDEytkPlndJuMD/Kp0mK9n3B1ORbecD1fMPY9yhi6WMosIljwHwSrmIe7X87sEwwdY5I95hB3dHWWMSUeham31HxyiBR5CpWjXNAP8ShHxrIrJ2zCTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437109; c=relaxed/simple;
	bh=kjVo12xOQmWe2VivdA92h2N9++UKJ3eD9kw4ETCUaSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DCivd9DNPGCO/onTFs8zVDWvxmPoMNJ4KbFFbe/zdAxufCwv/8bhkHIfeLKtM7HjkDQ0HcIOKiq1ibzAuq4NF8JiraZZ8kIIUgs7EByYxhHLJxyfiOYOgU4bDoOYQ8vHHOsB7IkUuMs24hj85xwffQezgOKGG1clykCC7Oy3hAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k3KZHsUf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k3KZHsUf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 97EF3335BB;
	Mon,  8 Jul 2024 07:11:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kjVo12xOQmWe
	2VivdA92h2N9++UKJ3eD9kw4ETCUaSQ=; b=k3KZHsUfFMHqOI8XwQz+hPTecoRu
	IhzybV2nZMLjJTrcoQLoD8rs0jIKg+dviKB55AYywv+/leJ5yy9ZnGIB62WW31vy
	Mx5hgLZtQuZbpSDpcWJlv3Rn40vQQtt3LabJE+YixlX+BAtas9ciGkMeKtcCM2em
	YY6RxL8UYXFvdps=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FB6A335BA;
	Mon,  8 Jul 2024 07:11:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 221B3335B9;
	Mon,  8 Jul 2024 07:11:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jes=C3=BAs?= Ariel Cabello Mateos <080ariel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] gitweb: rss/atom change published/updated date to
 committer date
In-Reply-To: <20240707184813.33166-1-080ariel@gmail.com> (=?utf-8?Q?=22Jes?=
 =?utf-8?Q?=C3=BAs?= Ariel Cabello
	Mateos"'s message of "Sun, 7 Jul 2024 18:48:13 +0000")
References: <20240704164547.94341-1-080ariel@gmail.com>
	<20240707184813.33166-1-080ariel@gmail.com>
Date: Mon, 08 Jul 2024 04:11:42 -0700
Message-ID: <xmqqr0c4kuj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 DC053C9E-3D1A-11EF-8272-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Jes=C3=BAs Ariel Cabello Mateos <080ariel@gmail.com> writes:

> ...
> Additionally, to be consistent, also use the committer date to=20
> determine the date of the last commit to send in the feed=20
> instead of the author date.
>
> Signed-off-by: Jes=C3=BAs Ariel Cabello Mateos <080ariel@gmail.com>
> ---

Nicely done.  Will queue.  Let me mark the topic for 'next'.

Thanks.
