Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79459248871
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754394474; cv=none; b=kPT65zfjn+yEla0nXV1BgFnOFR6OKR09Bd0fY3ydfs4V6YAXrxiGla7qahpPqSEh44oyPHLvCAxPbUeqqeLnAjlO3xn5xvpbX3s1GaT8Or92Q+v24aIpPKLKEO+n9to0OKnxcCsrA0aBY03E2oeO9oymJxUgnFFPOwxf6mrADo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754394474; c=relaxed/simple;
	bh=8yCv5oUny16XtMuh5lxle5ZqvvVls23usqklEpYDZJU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRLngFpFtv2C24dItetq477C9JJjQUnArmJOC6tUbcC2Y+WWHzo9dp8aikaEMtWafK3KBOJAvY7XWtREBKDzQWL9gOWjSGmLpq2R1ykbM8qQ2dodbjXG5BUoGmNEdy9G7Prz6OejWazVm7P6C87MsvvdfOJpv8Lsh750P0rDX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fmorschel.dev; spf=pass smtp.mailfrom=fmorschel.dev; dkim=pass (2048-bit key) header.d=fmorschel.dev header.i=@fmorschel.dev header.b=pgbm17wi; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fmorschel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmorschel.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fmorschel.dev header.i=@fmorschel.dev header.b="pgbm17wi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmorschel.dev;
	s=protonmail2; t=1754394456; x=1754653656;
	bh=0RY7rV4AGxj7p9gts3qzv24JLisHQmb4N7Nrzi6Z6iY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pgbm17wi1KRnfZvhMI3H7LG/YzFUNfOwmGpFcS+Ean/RASaw6rnJ8dpUKkLVmJ553
	 u/+jH6v4S7Zr6+clbm8BLbSV9jmIoMJAtS3nczzis9VLSA6C++8TaZFi1p3SCbwzAl
	 XYKlDeJ099pe/tTFT+G0WZrnMGiStYeW52Cu4Heu1PSxLv/uSnof+SVj8At85s6z12
	 JjqYlCsfMTkvmO9RXfC8opTgLLu8ej5vR+azEhlVHLpOkpCLsjX/WBN40vXxPILWIg
	 HCrgQcXu7psq5c8vATLVIQ21OGAG30SBTFboaVk+XOI/CXz5dM+7cc92oqX7Un2nAt
	 LoCXb8ScxOLcw==
Date: Tue, 05 Aug 2025 11:47:31 +0000
To: git@vger.kernel.org
From: FMorschel <git@fmorschel.dev>
Cc: j6t@kdbg.org, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, kostix@bswap.ru
Subject: Re: Feature Request: git mv --after (new flag)
Message-ID: <09e2fb55-2f04-44db-a062-fa6c2c01c8eb@fmorschel.dev>
In-Reply-To: <d7ey5l2bcy4xzidqyq5by4mrwgziahypvnco5ilbik4y3feqhj@vspbafxowl5l>
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev> <0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev> <2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev> <hi7t3qk7difgzip7syscarnf5ui5avnhmjxil4vzurwcfo7a6x@drccf7gibn72> <917aa62f-5f2a-40d7-8fa5-f19a14926241@fmorschel.dev> <ddc841ec-bc4b-4c01-a99e-9a65af3963bc@app.fastmail.com> <d7ey5l2bcy4xzidqyq5by4mrwgziahypvnco5ilbik4y3feqhj@vspbafxowl5l>
Feedback-ID: 127627349:user:proton
X-Pm-Message-ID: 44343f1e818b6ef3a465c546776841f32b11ed3c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On 05/08/2025 06:36, Konstantin Khomoutov wrote:
>> FMorschel, when reading, consider paying close attention to the two thin=
gs:
>>
>>   - What Linus says about much of the code coming in in the form of the
>>     textual patches mailed to the various mailing lists.
>
>
> I see that now, thanks for the link and for pointing it out.
>
>>   - An example describing a commit which has unified 5 different code sn=
ippets
>>     into one.
>>
>> Basically, these bits highlight the fact that files, albeit useful and
>> ubiquitous on today's commodity operating systems, frame our way of thin=
king
>> of how information is tracked a bit too much ;-)
>
> I never had thought of that.
>
> My only push-back against this decision would be to allow the=20
> developer (that actually _understands_ the changes) the ability to=20
> make the decision of tracking that.
>
> But since the decision (of what is related to what) is that this=20
> should mainly be handled by the threshold (so git can figure it out=20
> for you) it's fine then.
>
> Thank you all for taking the time to answer me!
>

