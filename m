Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D224EF76
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560966; cv=none; b=sJEoozo5MsE5464UOhChlcBZiZCCCHNF9OVfawhA4tRkNwo6NltN+Cb03v+Y7yK5rbtv637gy+aJhHPhLLx01fFzWLVvxE9wu67cTo8AhV6mzx/rILPywhHsGVzPQrKSD6SF0TAu68lJMZTOrrQJEJT20ii/Ufb7+hOU5hcS+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560966; c=relaxed/simple;
	bh=nx0jtnDlZqWZR58LA2W1wxNVfQ64jCjmZ+O4W/vVUzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lD0Bv9DhlizmoSDeLZdJhVsMqp1lr2+gpszunVD/a8RW2m/M1qFioXGktb9mJcI0Yqka/v7u5yUMygtS9OnC+L/Vo3fqZ5AQglvhflmOlNaMjKCe7Ax8uKCTI1WsxRKLn07GYsypoNZMgn4GEw2XLGP20y2IqMuV5u2pyGXROxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=VInq2V2G; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="VInq2V2G"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id XMyBuSIT8MhRjXMyCuL685; Thu, 03 Jul 2025 17:39:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1751560774; bh=jdRus3LS7wuuYBf4qTh5N4hroWrxYhyFavOMdS9UqgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VInq2V2GF3MsYiAmXS1kvCNzE0jaKdVyd1tzaWI//yjLbN68+geq7/QoFw1nMS2e7
	 zD18i9ihWZy3jhYQQcvvoFmBZ9Zhxy1VK8BR7vvn0uIaYBGx35IOGeHOw7RMFh04iW
	 X+awl0Gaj75UlNCWhsM9TEiCaYSHeJGaIIFhegDnUy4VNA3rSurcwOQc8U2Gmbw3RZ
	 0dMgf2aODPaNPdokVr7IN/ozF9mDyFGHcMUx07yD/I9duMKMqWVlDFxvJHB0DhUFVL
	 MTKFz9uqglnUXYmo/LzI0ZchBH+IbeXM4ChzPRt4l2N3LE3U9b9nQq4Kk5TLeW1oSQ
	 dS2uEfik3KZHg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Xq9ZOkF9 c=1 sm=1 tr=0 ts=6866b246
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=_X85RQHKIpvgHndqO5EA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <ad58469d-e8a7-4a9e-9f34-2afa68458f00@ramsayjones.plus.com>
Date: Thu, 3 Jul 2025 17:39:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] meson: fix GIT_EXEC_PATH with overridden
 -Dlibexecdir=
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: irecca.kun@gmail.com, Eli Schwartz <eschwartz@gentoo.org>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
 <20250703-b4-pks-meson-cleanups-v1-6-2804c2932abe@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-6-2804c2932abe@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBcLUz48xqzzs+xnomhqqA6kLPoYsRqbvqB6sRhKhF5ulOOw7l7C1leevpnwHTyPOLXEJZ1rxWg4hJ/EVXkoQDuRWCU6KgaHJ+t6hW4kzfH3hyLGQckW
 +uNasYSNiL51E9DOHVZIaTzhBZiLzt30Ba64nBYIBgs0/rdVaRz54DxRxbxFvP3o0EPyaviJIzot+5hFx0IFsLr9vXLCZMxzQdY=



On 03/07/2025 10:28, Patrick Steinhardt wrote:
> In 837f637cf51 (meson.build: correct setting of GIT_EXEC_PATH,
> 2025-05-19) we have fixed how we configure GIT_EXEC_PATH in some cases.
> It was reported [1] though that this causes a new issue when overriding
> libexecdir with `-Dlibexecdir=`:

Yep, I noticed this report when I got back. My first thought was 'no, we
may just as well revert commit 837f637cf51', since that is in effect what
this patch does! ;)

Then I had a quick look and left a diff/commit 'note to myself' which
effectively did a global search/replace of the string:

    install_dir: get_option('libexecdir') / 'git-core'

with:

    install_dir: git_exec_path

and put it on my TODO list. (Note, that is *all* I did - I didn't even
attempt a build, let alone test!)

Of course, I need to spend some time on this (if nothing else, git-gui and
presumably gitk will need some changes as well?).

Hopefully, I can find some time soon (those round tuits are in short supply).

> 
>     $ meson setup -Dprefix=/tmp/git -Dlibexecdir=libexec-different
>     $ meson install
>     $ /tmp/git/bin/git --exec-path
>     /tmp/git/libexec-different
>     $ /tmp/git/bin/git daemon
>     git: 'daemon' is not a git command. See 'git --help'.
> 
> While we correctly propagate the libexecdir to Git's GIT_EXEC_PATH, we
> forgot to append 'git-core'. Consequently, it cannot find its binaries
> anymore.
> 
> Fix this issue by appending 'git-core' to libexecdir. With this, things
> work as expected:
> 
>     $ meson install
>     $ /tmp/git/bin/git --exec-path
>     /tmp/git/libexec-different/git-core
>     $ /tmp/git/bin/git daemon -h
>     ...

Hmm, I'm pretty certain I tested commit 837f637cf51 in a similar (but
not identical) way! ;) I will use the above test next time.

Sorry for causing a regression. :(

ATB,
Ramsay Jones


