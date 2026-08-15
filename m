Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8832D7C7
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786803035; cv=none; b=DQc82n4txkTxQ6xALTJXliQMEM9uuIDmLyZ8rlGu5e4tb94Rnl86qdAwEYxjh2a3Huzjfn+b5Quq30BhcgmDdh3OZ+B2ayRfdxM83G8e9AuO5QGtr2ThzRNGstzzam5k87vj8/HWU4DxoTCwINiqvvy7fJmlG6WeM6sSrTX+v3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786803035; c=relaxed/simple;
	bh=sYijSGQyR9uKM/soY6uSW1oLGEaK53OA/L4yR1uHawA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bCSfcsX6fxSWWVrUWw2dL33GxqDtU/cFqe8Dv/OkBEQQi/Rxz3vaRuhF58CLnguCuv7ZuBQOQpvEfrfxyy4cQPo85y3UP1XZo1tOO1eZRHo5pUFhXf8LYEwSEZZGa/odfGuPLH/TJI308BaMvQ1Asn8xmW6e53k2r18iBPqtJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.103] (unknown [89.144.223.124])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4hMgwc2z8YzRnlc;
	Sat, 15 Aug 2026 16:10:24 +0200 (CEST)
Message-ID: <246b5e7f-ee43-4f3b-9760-2373a1b5b97c@kdbg.org>
Date: Sat, 15 Aug 2026 16:10:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 00/12] Upstream some more Git for Windows' patches
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
 <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.08.26 um 09:52 schrieb Johannes Schindelin via GitGitGadget:
> Johannes Schindelin (12):
>   mingw: include the Python parts in the build
>   mingw: stop hard-coding `CC = gcc`
>   mingw: drop the -D_USE_32BIT_TIME_T option
>   mingw: only use -Wl,--large-address-aware for 32-bit builds
>   mingw: avoid over-specifying `--pic-executable`
>   mingw: set the prefix and HOST_CPU as per MSYS2's settings
>   mingw: only enable the MSYS2-specific stuff when compiling in MSYS2
>   mingw: rely on MSYS2's metadata instead of hard-coding it
>   windows: skip linking `git-<command>` for built-ins
>   mingw: always define `ETC_*` for MSYS2 environments
>   mingw: ensure valid CTYPE
>   mingw: allow `git.exe` to be used instead of the "Git wrapper"

I have been building my own Windows version with a subset of these
patches since November 25 already, specifically with 02-06, 08, and 09/12.

After building with all of these patches instead of just the subset, I
don't observe any negative effects after a quick check. CI is happy as
well (https://github.com/j6t/git/actions/runs/31831084178).

-- Hannes
