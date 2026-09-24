Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86338E8CB
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252949; cv=none; b=KzrvpcD9z6O3uMxlmUs5P69iQA37kloK+PuwSWxlMcDPcPPhUZkv4o0aoGsvcPI/oiQ1R6cqVNiSY622eYgDtuYJOtW7yfVxn85CQP2np9ezNtn5CIO2EKlIMgJlR/t1VldKPexS/7ZvRiZ0NJG0W3vzkYntNWGZ8VEBcS3Gzq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252949; c=relaxed/simple;
	bh=n8hA503vUd+tFO72D5byyR/JO1Q+P5sW4nV1Tb44StI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UhnC29c0b6C46rkOsOSEywlFe6kC3nywW8Dz0xv8fHwNDSP8egnbDjac5nvaUqU9ahb5AoRiWzSIaaDCweWCgY72K8hd9o45VlAyldD2g+HQLl5QHqYymS2hABAM8i/2W8T9dvyVwEMsxRYDjq76BK9doixD/qdItsoFNI0sqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=GLcT7uvl; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="GLcT7uvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790252942; x=1790857742;
	i=johannes.schindelin@gmx.de;
	bh=gjjM19rNVgqB9l9Wv8c5xUffkULsb52zoLh7AbMinn4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GLcT7uvluIOKp4hSIJm1E2VpZ3brY7/GT8lFlDzRs3NzwdzWLpyjSOj/Fqz2Szof
	 VhfoCjhmFlqHJ2lmmOpFz/VFczFCWBaMRRXs8L0SUHiH0GNE7NYpBl80ky8sIe5wy
	 krTif5b9ZkHTqCeglmRg/oiwK+LTx21R5S2R4rd0SEOUXnpo9TmxY1BPJ61tbZE9S
	 T+olzpb+5ejx1IWD0yrktpm+CP5sZyO9TjLHUKHxdgh/ov2oJayJXTzstU3u4dwlA
	 x28kZ2wI32xaGdDZdgRSZYDzWJm06SM3b6MmH1R5aMZf3KsFO+c8bsO3TViUbyhd9
	 OxMhVJQKnPt3zSPw+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1wMduz1UcJ-00qlSb; Thu, 24
 Sep 2026 14:29:02 +0200
Date: Thu, 24 Sep 2026 14:29:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: Git v3.0 timeline, was Re: What's cooking in git.git (Sep 2026,
 #08)
In-Reply-To: <xmqqpky346fr.fsf@gitster.g>
Message-ID: <306e7563-c356-dc59-c14a-ff8e99a948ae@gmx.de>
References: <xmqqwlsei1pv.fsf@gitster.g> <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g> <5f34a5a9-9f72-b725-666a-94798895d122@gmx.de> <xmqq4iff5ml0.fsf@gitster.g> <xmqqpky346fr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:k14hmscCxbBvVCubHu1svY64T/6l7UZkFlgioifVuePFSM91UVs
 FXgFBw3DmKzrbQlKOO7hel/umWehG4YWj1q64lqmcLOhTgFgAYpMF8MaYvAeaAeT7vxoMfl
 9WJtgTkxouVKM0A66rNyrIeIhN3thPpKcGXdOdNg7XJvqfO0rySgw/SwLnnvTSimBjHK9p8
 KEdMoXZxO0dhtgJZwwKaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TlpW/COQ3hI=;BrwYR8BEeFHHbcaSXPTnrJHxjnc
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 23 Sep 2026, Junio C Hamano wrote:

> As I wrote, after the current cycle ends at the end of this month, a
> 10-to-12-week cycle including the end-of-year slowness would mean the
> next cycle, 2.98, will end at the end of this year.  Extrapolating
> from there, 2.99 will be March 2027.
>=20
> The consensus in the room was that we want to use 2.99 as a signal
> that something big is coming, so there needs to be some lead time
> between 2.99 and 3.0 for "advertisement".  This lead time between
> 2.99 and 3.0 does not have to be the usual 8-to-12-week full release
> cycle.
>=20
> I do not think there was a firm agreement on the date for 2.99.1 and
> 3.0.  Potential factors mentioned in the room included that we may
> want to match the LTS release schedule of major distributions.  My
> preference would be to give a month after 2.99 to apply only
> accumulated bugfixes and nothing else, and tag it as 2.99.1, which
> means 2.99.1 would be April 2027.
>=20
> The contents of 3.0 should be identical to 2.99.1 except that
> breaking changes are enabled in 3.0 while they are disabled in
> 2.99.1.  Volunteers can run the 2.99.x series indefinitely to help
> LTS distributions.
>=20
> At the release engineering level, I am very tempted to keep the
> WITH_BREAKING_CHANGES Makefile knob in the 3.0 release in order to
> keep the differences between 2.99.1 and 3.0 to an absolute minimum,
> and then remove the "dead code" that is used when
> WITH_BREAKING_CHANGES is not enabled from the 3.x series at our
> leisure.
>=20
> So the above is what I have in mind, shaped mostly around the
> consensus at the Contributors' Summit (or at least how I understand
> what the consensus was), with my preference filling in what was not
> firmly decided in the room.

Thank you so much! This will make it much easier for me to plan out the
Git for Windows roadmap, such as switching to Rust-based builds and
integrating Git Credential Manager v3.0.

Ciao,
Johannes
