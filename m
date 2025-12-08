Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188931D723
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186965; cv=pass; b=E64Kcnu7mypnpG1JmQmrN2S2UhVbYQPOdTER9uOKShVk616zsufOEf/nJ9qtFquTKPxppmerVTOPlMC0zkeQk2N+WongPSLSkCSo+QFsjayCvscxMGFP1KVE70yJ9/FA++k1FqQDzW4PGHdeVc8Tj0MqIxZFGSJauQztrSpWVTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186965; c=relaxed/simple;
	bh=iIkIXHTRvFFhvzSnC7Zp93BC8KRDihlZuypiIRqL95Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDSO/r0kaxgw5QhuXTu5hzTVrgZicgJW4nhOay+YuBL5WccbHKLvUXKJwCE5T6DLPy6Thx8jTqp9F+b+bXU9MJNFYK9zWrwK9yetibTnGuzq3AoFQMRgx4p1wptN0VtCFcDZX4WYr/B1hXyFY3edmTctDBcq+oLVo0Nr6WKHF+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=SPCwYVSD; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="SPCwYVSD"
ARC-Seal: i=1; a=rsa-sha256; t=1765186948; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FY2/tlpzPJxtBHlPyum/sW/CXySv6SMNMprovDl+DdKo2AZkygzaN922XXDo+BLAsJVxg+Qitp9FxC9HG7kFL7YcnliG4cEnCUA0nZRZXGNT8DVvzkVSsEYFrU3s0Zv81VKacjso4qtmWOS22DWXEH1afqJ41209joVlC8pWVhc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765186948; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iIkIXHTRvFFhvzSnC7Zp93BC8KRDihlZuypiIRqL95Q=; 
	b=RAim5/feictYkx7XqqBVwI9ouSbhu2s0+Zr7eEFahkWfnJ+9VHoNbcb1ElDclJ059OWpUDuF5t+dSjMUfe3MOs/mWfrYckqygj7ktMubY79lzx1RMqgMNn2VW6MnuiYV5a8j/UaWAU4YjgbPm3hHXxB1GQpdLSQ+XSYriqTL8nk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765186948;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=iIkIXHTRvFFhvzSnC7Zp93BC8KRDihlZuypiIRqL95Q=;
	b=SPCwYVSDZy4ZsgYJOGQgOmGQT+9pisT3QzeC7jNB+GndFIW2+CxFviSyzlSkeHRa
	MGejTpZrBsZ+qayzZOAZAWHgQ05txgE9gfM8hekt0eCWAe0+yXwhGmxcfxSHPv1IJyO
	PJRfmrkhzuhSKCbub/L1sK6n0jHsHSqlRxpp/oIA=
Received: by mx.zohomail.com with SMTPS id 1765186946443648.37390456868;
	Mon, 8 Dec 2025 01:42:26 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 7/7] meson/Makefile: allow setting submodule encoding
 at build time
In-Reply-To: <xmqqms3w7d9e.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-8-adrian.ratiu@collabora.com>
 <aTLNxlKh02T_1PYB@pks.im> <87sedoemvr.fsf@collabora.com>
 <xmqqms3w7d9e.fsf@gitster.g>
Date: Mon, 08 Dec 2025 11:42:22 +0200
Message-ID: <87ldjdux6p.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sat, 06 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> On Fri, 05 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
>>> On Wed, Nov 19, 2025 at 11:10:30PM +0200, Adrian Ratiu wrote:
>>>> Some users find it difficult to distribute repo config changes for
>>>> enabling extensions.submoduleEncoding, or to enable it by passing
>>>> the config via cmdline, so we add a build-time option which can
>>>> enable the extension for convenience.
>>>
>>> Wouldn't it be more sensible to make this a runtime configuration key
>>> that users can configure in their gitconfig?
>>
>> The request I got from a combination of feedback from Junio, Aaron and
>> Josh is to avoid any kind of required user intervention or manual
>> migration, to find ways to automate the transition as much as possible.
>
> How would that lead to build-time behaviour change, though?
>
> Users in managed environments like $CORP can rely on /etc/gitconfig
> or equivalents managed by their corp-eng, so I am having a hard time
> imagining why we need anything more than an configuration variable
> looked at runtime.

Please see Josh's message:

https://public-inbox.org/git/20250816213642.3517822-1-adrian.ratiu@collabora.com/T/#m7d0d75126c81bef7d3619e53da6fa0cd69426570

A config variable looked up at runtime would solve most cases
highlighted there, except for the force-enable
`extensions.submoduleEncoding` regardless of the local config.

That is why I added this option :) though we do not have a local config
in v5 because I saw no reason for it at the time.

For v6 I will likely implement Patrick's suggestion to introduce a
config variable and just set its default at build-time which seems like
the cleanest way to do it (and automatically run the v6 migration
command instead of the current automatic fallback).

That would allow a smooth automatic transition which will address Josh's
requirements.
