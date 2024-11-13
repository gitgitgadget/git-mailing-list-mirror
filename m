Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E32161326
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 03:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731467613; cv=none; b=Xgj8Hd0HsiNnN+D7K7gRItSGoNTMZkDSmx0QeNfJ/6HIBTf31g4lquhxLKmQ+RpqmB1v1w+syyKo9KA6zbKiYCW8uo+1vP2f9Yt4yvejJsYzHF4RwfAHThwmLzE2PK9hUUX4anLoNVVFO14pqq1JK4dcPsuBS2EXY6cU6osdlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731467613; c=relaxed/simple;
	bh=tTE2I2Y5Qv+7hA6R2APSPBcmKUK4wDuv4sHCn/g+4NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lf26VLy5ZiA8jHQRVLRtPsJtAJhlrVmPXDmKWHTcw/p5L+8MXFUo8tzKyKoBgzEX6CxOZk112ljtJknKBJlHTymNZbP1YYK+BhH3cN7aRYXBEdhGsspTFyztfJVFb9wm6lZReJeIydkL5whGgKB6Qr4XjY6v1e3pXWqp4ItiG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=oSipe31N; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="oSipe31N"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id B3lotlX16xileB3lqtIyLF; Wed, 13 Nov 2024 03:10:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1731467421; bh=vCNCLSqJ5zhPqR9l7qaX7vW4RX+Jd+tzXa50Og2eCUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oSipe31Nk51/Cgo7fsv7Tkj6CmgHbblz6Q2AFcFXkUMl24WIQ/CciCDIXvggEejGU
	 KMzSRqqJXrUX0vIt+iTHGGAVTlKPHv/wzEcB70iS3KSAXr3LOSx7yEIUZDUO5AUa7t
	 +2DkyrBBTJ+VA/mapzpTG6xdynqEOlpvNFzdRP9qhBrqWRgHrOekJcpNcZ0mFin9iY
	 AH029WV5/oNX2Ty0/w5NxBdSPiJ9WXCl38oSXUTK2roz3oUGia+1IwHC7317cTH/Wn
	 ScmZcVl0Izt4lbWoOyrLZfts1/PgUzscxdgQbhKM2Zjwgfov0gtrm6icUf/thLKRc5
	 HiR2yXLbJAZvA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VaJUP0p9 c=1 sm=1 tr=0 ts=6734189d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=zL5cuzKR9Q0_LTtTa-4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <291117c7-6b79-42cd-80c9-ee04824fc573@ramsayjones.plus.com>
Date: Wed, 13 Nov 2024 03:10:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 00/19] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 David Aguilar <davvid@gmail.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1731335938.git.ps@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <cover.1731335938.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPZqgzbMi/XocfehE94quM20oN2MdhvzpC5yF4wYgeojBOOA9sMR0EsjSlHbKNEwx6W1wUhN6llSrM0rhHw4i0nT++ZtuH8WM4/ZPSYpPhGUZtnD187R
 zq+3bZrWp0IkT+ttiFiLqMRfU/j6qm2w6VUfrT7q0TN+xcqJN7VPPX4D1YYv4hWZMMMuG7Ek2gSanepEKT+eLT+xaxmf9S0NPSw=



On 11/11/2024 15:30, Patrick Steinhardt wrote:
> Hi,
> 
> this is the fourth version of my patch series that modernizes our build
> system. It refactors various parts of it to make it possible to perform
> out-of-tree builds in theory and then wires up Meson.
> 
> Changes compared to v4:
> 
>   - Improve our CMake build instructions tot use `SH_EXE` to execute
>     scripts.
> 
>   - Create Perl build directories in our CMake build instructions.
> 
>   - Remove superfluous use of basename(1).
> 
>   - Remove timeout for unit tests in Meson.

I tested this version, without issue, on Linux and cygwin (build not test)

ATB,
Ramsay Jones


