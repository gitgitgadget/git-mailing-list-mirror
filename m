Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2D72612
	for <git@vger.kernel.org>; Thu,  8 May 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746746204; cv=none; b=EmViopsPZTnpGwoQp1Vpi+A2zqtEOTFx3lSjurIn2oARBUxD+BNFE28aCAium0wCEKmhASY2yYpExj5rZn/9+TzQ8wKZkhhP8dmd7cb/5qcif22ikq2Ui0pQVu0k+1NLg/2jbzcGbUNbDrXxiihKe7tWJVJHqhs4fLSIehUmvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746746204; c=relaxed/simple;
	bh=Za6ZEbBga7OLhuDmoqcOTAHaADl9+PSd/FsbdQsCWfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSTG39M4uTE2GHn5kEC3KUop7cYTeXBvtqtcy013QIj7syrGy1HGO/mScFCbKMm2y7uU1jZ7YmD8GpQ2K4R5+awqS+8y+zi1JvSoUv2i/WtfG9hQyLJXt5do0ZRwjtfCpiybCitm6w5n3DI8oGIFXoT7qk3JnTZL2v6b8hR61G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=XzYZEHT0; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="XzYZEHT0"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id DATmu0hzNCrh0DATnuzuG8; Fri, 09 May 2025 00:16:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1746746199; bh=CGRXbEIkhGLaL8+Lx9LQhdWBNuFtFTQzh2Je9RaEW9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XzYZEHT0cN98GThwfFE8oP/3JQCE8hTVERIJyfVr6wQBuDbEoFFvxToON8hytCd4W
	 5YqWhQHDrN2Tu6BnmsbXSVrcexYQXSDi1paleoqISs4I0r7+2s/zE2sxkFB/dKidE8
	 wLmpaJBbKvl90diGMMCpmZ1yZiQDBW66iCsuBzOv18EwXANo/W/9aA0t90cdgZWpez
	 nlyorG156Am3y7SKraXycDS8fyDfCCQKJkiaB3Kay8w9n7WpYd63TpbdFn9nWswfrU
	 eLuo0V2QEcGrigOwPn8rAkGCmNFZD80AzmYCz6mCf1ZQFRqtXdxhxzC4VNeqtHe+M5
	 AaVpH+ewUpAGg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frB/Z04f c=1 sm=1 tr=0 ts=681d3b57
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=nfUDaa4QlWx3y9Zs12YA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <90deee16-18a0-47e6-9111-a0c467404386@ramsayjones.plus.com>
Date: Fri, 9 May 2025 00:16:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] meson: correct path to system config/attribute files
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Eli Schwartz <eschwartz@gentoo.org>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
 <xmqqr00y4vvd.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqr00y4vvd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPjXbP79yg5Phg5VI19rR2vnhFtBvzzMJ/Htx0RPUQ+Cn52JpYfpO8qgJ1ZjzTMkOyk9zna3+Rj5Mt6P9P41M7oLsQkJlBmDo0PkCg7oKEix/57OZ0bu
 NxxMbXQJrzCRs/5fXOxPd7GuKh/O/uVnsEsTZ/OCO7YhdYqA5Ob62ZMjBV9szhLQJiCfhSdkXrn7cKlUJX4vMhUz0iEcsC22Wig=



On 08/05/2025 22:48, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> -  '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
>> -  '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
>> ...
>> +system_attributes = get_option('gitattributes')
>> +if system_attributes != ''
>> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
>> +else
>> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
>> +endif
> 
> Just out of curiosity (because this cannot be a regression, since
> the original removed one used the same constructs).
> 
> I am guessing from the presence of double quote around the value
> that these strings are not directly used to invoke the compiler
> without involving any shell (in other words, you wouldn't want these
> quotes if you are shoving these strings in argv[] yourself to feed
> execv()).
> 
> How does the above, and get_option() in particular, cope with a
> pathname that has letters with special meanings to the shell when
> they appear inside double-quote pair (like backquote or backslash or
> even a dollar sign)?  On the Makefile side we give VAR_SQ for a raw
> variable VAR and use the latter to write something like
> 
>         -DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
> 
> to make sure we won't be broken by them.  Is Meson giving us an
> equivalent to us for free by simply using get_option() here?

Err ... no, meson is somewhat broken here, for example see [0].
To be fair, it could simply be that I am too dumb to understand
what meson is doing (and I haven't really studied the documentation
or the code).

Hopefully, someone who knows meson will be able to answer your question.

[0] https://lore.kernel.org/git/a5795bfa-cc02-4c9a-b7d2-4924a94cd0db@ramsayjones.plus.com/

Thanks.

ATB,
Ramsay Jones


