Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762E4C81
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765185837; cv=pass; b=dYi9pDeWh/tHD7wptw9FudOfminl+s36v6cRGK/hbQ++3bPTTw//lni/UF0QrKFayY30xaR7hDb39WYwRjZSUORhLH60MsDiSSLZnq6xAwd4solHNyTFY3Iz4nIJVl+8sRLDfD4c2DP2KZkHox5mIy9V27RzsWpxvMRC8hUzF5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765185837; c=relaxed/simple;
	bh=hnmocQUBIrcIRm/D+K7EJVl7xtKFkRJmudcY3VKrATE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=St9na93Qh2/jKBHh1GgzlW+SHrSYLM1P7pBk5nioCFabb5FeKKkzULU1tm2RwN66/g5+n3rG9gNzfy4Z68FxAZ6wyUcmJwlPQDdl/zYpxNfNItOMJkfFVoZf7tnkJ4I3bqHD0PWChygnCoSRtwr4LEyNjHyqeFtMl0h9P3ose+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=VRXE9nO6; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="VRXE9nO6"
ARC-Seal: i=1; a=rsa-sha256; t=1765185818; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Plk48KPOvBAHpxyyKYjMpICf7RNEXnb8mYMIWPQxuay+xTfWEzHdewg4JH9rVo3jJY42jStH2iL6ml1d5ZqNbG7a36FiubZRZw8MoI9k+0lNN6tapGGm1ewguNbUNSYaON/t0aFtCAFWMMxemFMYM+yngfaHQgVsumysRTX9nc8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765185818; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/Mt4VADosE0Ztt0jKdnyWzAD19Cm1m/v7rrtq4IKElY=; 
	b=YQvOQRdGmmELDiCp+xNwEcVHvhDW5Ce0fvAknYdNkpWuxvTIJXD5cVasAiYcubZuvW6Ucv11dnP7l1/9dz7KsxYys+moHE5Q2fj+Cltj6+jKNEvFMzoyOHXvBT2TK19UF76v3QXR1JIKmuepfdQvxRzWoaIDS28HNKfpFklJ8hc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765185818;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=/Mt4VADosE0Ztt0jKdnyWzAD19Cm1m/v7rrtq4IKElY=;
	b=VRXE9nO6PGaZzAq5Dr6GK/8WTzWB66NJG/XM3BJgsql/Q9MePKJ31Pcr/FM9IDDO
	dVDnsRqegNmkfA2Rva1q6SzSRAvLrsKnoSLKzI9EzqV7Q1ZJP+kJyxBJuLtZePVR011
	CgKl+Od2v7SDq+u5xq3oFmPUtzhWdzU0ppb7NCqc=
Received: by mx.zohomail.com with SMTPS id 1765185816182635.5925446762669;
	Mon, 8 Dec 2025 01:23:36 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v5 7/7] meson/Makefile: allow setting submodule encoding
 at build time
In-Reply-To: <aTQbbFisaCG8N_Z_@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-8-adrian.ratiu@collabora.com>
 <aTLNxlKh02T_1PYB@pks.im> <87sedoemvr.fsf@collabora.com>
 <xmqqms3w7d9e.fsf@gitster.g> <aTQbbFisaCG8N_Z_@pks.im>
Date: Mon, 08 Dec 2025 11:23:31 +0200
Message-ID: <87o6o9uy24.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sat, 06 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Sat, Dec 06, 2025 at 07:52:13AM +0900, Junio C Hamano wrote:
>> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>> 
>> > On Fri, 05 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
>> >> On Wed, Nov 19, 2025 at 11:10:30PM +0200, Adrian Ratiu wrote:
>> >>> Some users find it difficult to distribute repo config changes for
>> >>> enabling extensions.submoduleEncoding, or to enable it by passing
>> >>> the config via cmdline, so we add a build-time option which can
>> >>> enable the extension for convenience.
>> >>
>> >> Wouldn't it be more sensible to make this a runtime configuration key
>> >> that users can configure in their gitconfig?
>> >
>> > The request I got from a combination of feedback from Junio, Aaron and
>> > Josh is to avoid any kind of required user intervention or manual
>> > migration, to find ways to automate the transition as much as possible.
>> 
>> How would that lead to build-time behaviour change, though?
>> 
>> Users in managed environments like $CORP can rely on /etc/gitconfig
>> or equivalents managed by their corp-eng, so I am having a hard time
>> imagining why we need anything more than an configuration variable
>> looked at runtime.
>
> I guess you could kind of have both: make it a runtime configuration
> key, but have its default depend on a build configuration. You could for
> example auto-enable it in case `WITH_BREAKING_CHANGES` is enabled. But I
> myself am not sure whether the latter would really be all that important
> in the first place.

I'll have to revisit this after I implement the migration command design
you suggested for v6, to figure out exactly how to best implement this.

Thank you for this suggestion as well, likely I'll do something very
similar if it ends up being necessary.
