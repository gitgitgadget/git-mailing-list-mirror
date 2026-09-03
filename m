Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6822370A
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429571; cv=none; b=IHDIJ+qHh3FFtl+WcOhBd/4+ew0pXFxzvWnfihIvsLyEc/sl8XvaH0Ta3XwekYK0yW7isc/ZbtD0EDH4Jlb/N7SG0E4GWdXj3g3+1W2UDx4EXHAQarhY7mi23mm+XAgQ2IfyAuRpd9e47cdQaJRcv8ZHQSrxdmto0AdmTlmuHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429571; c=relaxed/simple;
	bh=ATpufZarSmD2pKIMjoH9M+lHOBNOS+9+XY7pRWSqG4k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y80jn4uRnaZUfMtCfZekcfIttLwt+BSdDIXFSa5bbT93pp71U85W7onL8XSXOf0SCrP98LbMaJCLZkIFGmn7bZTPjh7EEODXvKHoYXvRr89wJoCO6A2mZITovJtupMs9lW9bq8erK69oRTpyDSqlE4PJXiy85LV8vQfWKugyVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=HukgZKKi; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="HukgZKKi"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbFSD32r9zMlFw;
	Thu, 03 Sep 2026 11:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788429564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFvr35diZGaGpeG+j4WiHiOnM/kf3u0OxCAuCNn3rcE=;
	b=HukgZKKivqBThIsZsZPxoHv+147hxV3nTheFTa/CFddx2WcMC1t+llr2uMywNe3IJz7goP
	toox6MviGrZl/zF8UmZHhZmTmyXFaaTd0HtXoWomtWQEjrGlMu2tZ/aDb7VW8+QkHDehEk
	8yQllWWzaj/If5+Az+gE3zffWzsk8oOOcBAlspBxt22ppeCvAhIkBeEqyghHewEQzjVan5
	HEOZ+34G1LrLhZ9rrIqRw4KMnCmfMhnf4tjtWp41L7wYpspZ4I2OEEF7a5YXvpAhZR8PwV
	efOtpImYcBj6HFBij3JKDqR9rNpLV+T78UTUimtB7rpeRIzGA8c1hGc0L4Ay4A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=dev@ytausch.de
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] dir: find common prefix among positive pathspecs
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <xmqqecfbk2eb.fsf@gitster.g>
Date: Thu, 3 Sep 2026 11:59:12 +0200
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Rspamd-Queue-Id: 4hbFSD32r9zMlFw

Hi,

> Junio C Hamano <gitster@pobox.com> writes:

> I am not sure what you mean.  Do you mean that the other one should
> have been marked as [PATCH 1/2] and this one [PATCH 2/2]?  The way
> we use the phrase "based on" does not exactly match that situation.
> It is more like "This patch applies on top of the other one", or
> "This patch depends on the other one."

I wanted to indicate that this patch depends on the other one, but they =
can reviewed
independently. This is because the other patch eliminates a bug that =
leads to wrong=20
input data for the code segments I change in this one.

Re-reading your contribution docs, I understand that this might indeed =
be better
submitted as a patch series. I will resubmit as patch series v2.

>> -static size_t common_prefix_len(const struct pathspec *pathspec)
>> +struct pathspec_prefix {
>> + const char *match;
>> + size_t len;
>> +};
>> +
>> +/*
>> + * Find the common prefix of positive pathspec items. The returned =
match
>> + * points into the first positive item and is not NUL-terminated at =
len.
>> + */
>> +static struct pathspec_prefix find_common_prefix(const struct =
pathspec *pathspec)
>=20
> Our norm in C is not to pass structures by value either as parameter
> of as return value, unless there is a very good reason to do so.
>=20
> Since we can easily use
>=20
> const char *common_prefix(const sturct pathspec *pathspec, size_t =
*len);
>=20
> to return .match and store the length in *len when we return, we
> cannot say that this case has a very good reason to use a structure
> passed by value.

Fair if that=E2=80=99s your convention, note that in other languages I =
usually write, - I=E2=80=99m probably
telling you nothing new - we usually prefer clear separation of input =
and output values,
which is, IMO, cleaner when returning a struct and makes this version =
more readable.

> Actually, I have a feeling that we do not want find_common_prefix()
> helper.  Instead perhaps
>=20
>    static size_t common_prefix_len(const struct pathspec *pathspec,
>     const char **matched_prefix)
>=20
> may be an alternative that is easier to work with.  Because the
> existing callers assume that pathspec->items[0].match is where they
> can grab the common prefix from, they should look like
>=20
> len =3D common_prefix_len(pathspec);
> ... use the first len bytes of pathspec->items[0].match[] ...
>=20
> They want to be told to do this instead now:
>=20
> const char *common_prefix;
>=20
> len =3D common_prefix_len(pathspec, &common_prefix);
> ... use the first len bytes of common_prefix[] ...
>=20
> In "use the first len bytes" logic they already have, they know not
> to memdup when len =3D=3D 0 (and ignore pathspec->items[0].match[] in
> that case), and they know they need to memdup if they want to have
> their own copies, etc., so the changes to them can be kept to the
> minimum.
>=20
>> + prefix.match =3D first < 0 ? NULL : pathspec->items[first].match;
>> + prefix.len =3D max;
>> + return prefix;
>=20
> So instead of these three lines, your return sequence would become
>=20
> *matched_prefix =3D first < 0 ? NULL : pathspec->items[first].match;
> return max;
>=20
> If there is no positive element in the given pathspec (by the way,
> "pathspec" refers to the whole set, and each element in it may be
> either positive or negative, so "positive pathspec(s)" is a
> misnomer),  the loop never touches first or max, so when the loop
> exits, we won't have "match" and "len" is 0.  Your changes in the
> loop to avoid assuming [0] is positive element all look correct.

I addressed all your comments and will follow up with v2.

Yannik

