Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A91F5834
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776302787; cv=none; b=TyCPnMpTyV0UtSYfsxSh4et/fSP35HkOyewT+gNBzWhmJdECYbU8/lHN5Zf2JiUEF49lpxAwJw0rmKOoB+s4kqVV1ksh38X4X41dzzyEvTCrGWBOwE1hSie7IBaMKSJJXYtEQfNhQYKyqDKslcRt6oha6dn9kbUolbjw2Rfve0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776302787; c=relaxed/simple;
	bh=Q9fBS90h2RGl0OtnhuY5tacNTDmrRZUgG/eEDHwR0ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Hvit7lYx4tQEdADzkk8PvkGOQLI5R7tM+CABVMggH1VAirSlAlrFL5ItE4cuFok2WN+ZH+zgSHTUwsldTChF1vZ7gdnmimZeesKkC5jbef3pLF9e7ufI4v2PI4iQxeU1Phye8IDUCnUJ0Kl3UXq3vFeUXO+gePI9wc0yUG41VBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=kSt115Gs; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="kSt115Gs"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1wDBUq-002XfZ-IM; Thu, 16 Apr 2026 03:26:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
	References:To:Subject:MIME-Version:Date:Message-ID;
	bh=R94f+zXq8hqEHyxdOJyWQPcWgT92223caHX1ZNAbuYU=; b=kSt115Gs8f8vdnKaF5xCXrOSZD
	z1MrFVCAK9DS40tt4JvL8FVDq1vQItcFAcL4mpTZTcp+wf8V6I0AjD0c8stb33HNC/ezaqELORnVe
	dRN/NwaY6FmheZXFKoERnyUmSnJvoVf/1Ycbq3GAnidUjwXivYf5BlUrLMg5MSaiCuIO7KiB+YvCE
	YQVlYx4e4IZ//tq+mxB3XLj7okmZUc7gsT+6Nc5FTSysX8OUzVGjMo23kYBz4/viqam7GJFDJb43R
	/pf413oiywX0/hHm2Q/1QIXo41anrzar1x2sjqfjT/xwcbrACsLuU39zyXHWrXirGKXreZN3HkXi4
	GEijlK/g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1wDBUq-000684-8w; Thu, 16 Apr 2026 03:26:20 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wDBUb-00063a-Gv; Thu, 16 Apr 2026 03:26:05 +0200
Message-ID: <e9611b58-3886-4f04-8f49-16d140ebfc15@howdoi.land>
Date: Wed, 15 Apr 2026 20:26:02 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git subtree bugs (mishandled merges, recursion depth)
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
References: <26263.63341.878041.155047@chiark.greenend.org.uk>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <26263.63341.878041.155047@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Ian, does this git-subtree issue still affect you?

On 7/17/24 11:55, Ian Jackson wrote:
> Steps to reproduce:
> 
>   git clone https://gitlab.torproject.org/tpo/core/arti.git
>   cd arti
>   git checkout 01d02118cdda30636e606fc1a89b3e04f28b8ad1
>   git subtree split -P maint/rust-maint-common
>
> Actual behaviour (git 2.45.2, Debian amd64 1:2.45.2-1 .deb):
> 
>   $ git subtree split -P maint/rust-maint-common
>   /usr/lib/git-core/git-subtree: 318: Maximum function recursion depth (1000) reached
>   $
On Debian's POSIX sh, shell recursion is artificially limited to 1000 
calls. This is not typical behavior; most distros I've tested do not cap 
it. bash has a configurable recursion depth limit, but sh ignores it.

I've proposed a fix for the recursion depth issue in:

<https://lore.kernel.org/git/20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>

If you have the time, I'd appreciate some testing and/or a code review.

> Expected behaviour:
>
>   The resulting history ought to have a few dozen commits,
>   most of which are the upstream history of the subtree.


> Actual behaviour (git 2.20.1, Debian ancient 1:2.20.1-2+deb10u9):
> 
>  Takes a very long time.  Everntually produces an output commit
>  which has most of arti.git#main in its history.

Even with my patch series applied, there are many more than a "few dozen 
commits" in the history. For me this splits as

     9a2422685e6cc05625f47a1fe709f1908f31fc87

with 12307 commits in the history graph.

The reason for this is likely e7b07376e5 (Merge branch 
'rs/subtree-fixes', 2018-10-26), which was merged around that time. 
Previous versions discarded too much history, and that patch series 
added more merge-base ancestry checks.

When merges come into play, the task of choosing which history is 
"important" and which history is "not important" is not always clear-cut.

Colin

