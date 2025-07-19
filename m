Received: from cloudsdale.the-delta.net.eu.org (cloudsdale.the-delta.net.eu.org [138.201.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84D7082F
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.117.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886528; cv=none; b=Hfj6oTxbWkKHI14tyG4kiWuIJBZ+W7e25HsesWVU3NnbpAqv0UFxL/+UyVd0gyJyGY49IVF31MHrwKSOgAs6lIsXaCa9BeHMXLIco160vdY0B2a0McvnXt1rFDwO21f2F9NeiDnAcN8L0cdLj3j9p4kCVGDZFc3KcOgmP+naHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886528; c=relaxed/simple;
	bh=OH9O/eyS+aF0OoktfScakf3xOMYuDF9wu92HyUuk7cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NthMfRlsVaPWn4hAhVO9z3TyezGipiQnSaTzPsSvWJNOwONpqDyAruX99hCUZ+YMyhqJXzpI9DjwkYPx+UV/UtuPDVu1gFeEnX+o+7D0tYkV3NwtDxeI81cTVhQuO/M7NnlPUB3Cmm3mJDsUwWx50f/UjLk4QiQ+VGuF1ptF1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me; spf=pass smtp.mailfrom=hacktivis.me; arc=none smtp.client-ip=138.201.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktivis.me
Received: 
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTP id 9796f7f6;
	Sat, 19 Jul 2025 00:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=date
	:from:to:cc:message-id:references:mime-version:content-type
	:in-reply-to; s=20241213_132553; bh=OH9O/eyS+aF0OoktfScakf3xOMYu
	DF9wu92HyUuk7cg=; b=nqiLOwcmcGnnAMpaMLKPnTKleHV7CFIp1rcLnXbNqMYs
	4uDuPZjgE8LyXxXwC7v/g7ukxfA2dnucd+O/O5Y5725GOmfgq2eXp9UVPdtE16s4
	HCVyuOvTSPBnlEj3hbLp6qeJrQtNeykqr63vAKnFyaJyyVR7FpzfB9fO+cpoKyX7
	u5BSUu6Wf3y9Hxrc5R8MKF5FfpB4JltkHe+Hj+sZJ89RJYkMsxXCZhOWOhkdfCn4
	/5SZ1/LnXFotAizkb7cm+3sjtnZOrGCqzCRVL4mM8fKdmXECdEk0q3JVUucFBf9E
	tsN6BwGZr+2pFMuBsx8osi3nj7uTkx+sxRZN8Ijen7t+xqEOkY7ZBPAyVVyHW4oO
	15iqMPuTczoIicPcT5VmPCWfA+hSMMIJ7a0IWwfOc85T62qQIFXhH9OU4lW9darL
	JfjxCcjh0UktiMYABii69VGV7uNZDV9N9BJ7sXUaAXndK34zvbj4slbpRq9jwB5c
	JxJYUiJBPgQ9S9FFVzrNuq6NzJfUfoRFFzans+qfV48Kh/JWBqMonQ6aYxPA7lpm
	zA8KkVkvJTaMUuy6O/p3Vps4uP3tobNvejGRh3FUF27RTcZ7uLfYEqD/0V7LsmyL
	myqtWlP8IZHfgxknxqmxw6HrsH3Z/h9saJtTXepXugDe1dr7tPNhMpQzSyfOW7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=hacktivis.me; h=date:from:to
	:cc:message-id:references:mime-version:content-type:in-reply-to;
	 q=dns; s=20241213_132553; b=dbTJ4/BuyQbBNP66xOsZSs5136mlFabudNC
	9PNQ0pCTdal8PlNYz4eV8b29aw7whVUSTdG73oePhtLHjZKkM/aImv6t4dw00yAf
	bQgAwywkU12uAnMuuGOYugpfkv22QZ5QSW3t1zS1Mk4xApUe/E1zx5bm8KTlxZ+X
	pg9HyqexlINSsDaluXa68nCeA7jglKyB8JYPp2ZSxzMmAIi0oe+Z4/lKXqoRsbMv
	qDz82OguV6wchVHcH5EA5eyV8sFTjt3lsrH4AucNb0mekWgJ/aybgBaeksWrzWAq
	5/QfOUU/eVXxzJXfZ8ZAEPL2NgIspCxJXtdAZanOFkZQiITHdbUGl4xPI8jA9eDf
	10x3iLq0fZnsfsgQ45OvItEAg78ojHF6nxluBSrouv1Hqttm1TzixaV4hENvzQ47
	vWd3ZkUDbUP5CEgCNO1xSXeplxgWVinxs7X0KKmj5ySLbCXSsh8nXvLUlO3QSpVp
	OVXg9ay3YlcUKTWtvyC5SOgXgjvUcIfft6aKNNX8bzKuge3kgfYBOnyumJQoxMMR
	djKFcxkYfgrNSVtNlDhc89cKfSg26odhtmVZ2PFzawuWCldCl+A3fltpxI6o1cpo
	4X1S5UcZ6Rn4giPgdDgAF29k8safEBedEfBJAVATWbu1Fo16TwRlsW51xLtMZMG0
	FrGCgYTU=
Received: from localhost (cloudsdale.the-delta.net.eu.org [local])
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTPA id b491dd39;
	Sat, 19 Jul 2025 00:48:39 +0000 (UTC)
Date: Sat, 19 Jul 2025 02:48:39 +0200
From: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Edward Thomson <ethomson@edwardthomson.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aHrrZyrDw_CYmFQF@cloudsdale.the-delta.net.eu.org>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <f439958d-64ce-417f-8175-720f69387d48@gmail.com>
 <79c1b3ab-af2e-4c93-b033-349221d82ad9@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <79c1b3ab-af2e-4c93-b033-349221d82ad9@gentoo.org>

[2025-07-18 17:25:01-0400] Eli Schwartz:
>On 7/18/25 9:34 AM, Phillip Wood wrote:
>> Hi Ezekiel
>>
>> Thanks for working on this
>>
>> On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
>>
>>> So...
>>>
>>> This obviously raises the question of whether we are ready to accept a
>>> hard
>>> dependency on Rust. Previous discussions on the mailing list and at Git
>>> Merge 2024 have not answered that question. If not now, will we be
>>> willing
>>> to accept such a hard dependency later? And what route do we want to
>>> take to
>>> get there?
>>
>> As far as git goes I think introducing a hard dependency on rust is
>> fine. It is widely supported, the only issue I'm aware of is the lack of
>> support on NonStop and I don't think it is reasonable for such a
>> minority platform to hold the rest of the project to ransom. There is a
>> question about the other users of the xdiff code though. libgit2 carries
>> a copy as do other projects like neovim. I've cc'd the libgit2
>> maintainer and posted a link to this thread in neovim github [1]
>
>
>A hard dependency on rust for Gentoo amd64 would potentially require
>building https://github.com/thepowersgang/mrustc followed by building 13
>and counting versions of rustc in order to get to the latest version.
>What is the minimum supported version in this series, by the way?
>
>bin packages for rust do exist but not everyone wants to use non-distro
>provided binaries, sometimes for auditability reasons.
>
>
>For Gentoo HPPA, Alpha, m68k it will simply mean the removal (or end of
>life and staying forever on 2.50, perhaps) of Git. There is no rust
>compiler there.
>
>Even s390 support for rust is limited to a precompiled version not
>everyone is willing to use.

Also in other distro concerns, if it trickles down to libgit2,
extra care should be taken to avoid creating circular dependencies
due to cargo depending on libgit2 (via git2 crate).

For example with making sure it can reasonably be built via meson's
Rust support rather than through cargo.

>
>GCC-rs will probably fix this general issue.
>
>-- 
>Eli Schwartz
