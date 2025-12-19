Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE2284B25
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.253.31.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134063; cv=none; b=hRnpwdyjX/yPUjJdQ57L76lk+KIEaJZPqrWwcTPRsBt9N4nG+rfTqIxuzVPj4Gu1GVEh90v5GJZrT4lji8OqG4kLdVezHIDtUWbcIAg+zdKmKXQbxy/wjmKhcD8k5pKryUPR2L7qgruevIz47boY41CG/FGvKDwfYinwzXM3+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134063; c=relaxed/simple;
	bh=wnoUb6kl7VfgGdkHGg6FGPyMRdl6/FEMtO6E3+hvdrY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p8JxIQMWY7eV203FBmlYdqZaTFnFGIJ6MrR02Jt9JhuqtsiWDkkp4TABiOldb4jLdEPOrPL9lWsYXbf/x5a6VIWpUPqJXSR7TIXAYssC+4rZrxUwGNWbNT9QOJoxEzircJ97cuslniV+ZOww2T2tRueRTmm55AdmFd34MOEedzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se; spf=pass smtp.mailfrom=haxx.se; dkim=pass (2048-bit key) header.d=haxx.se header.i=@haxx.se header.b=I+fd3ZDn; arc=none smtp.client-ip=159.253.31.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haxx.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haxx.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haxx.se header.i=@haxx.se header.b="I+fd3ZDn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=haxx.se; s=silly;
	t=1766134057; bh=wnoUb6kl7VfgGdkHGg6FGPyMRdl6/FEMtO6E3+hvdrY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=I+fd3ZDnRk93+AHaOwgvkyhZYMu4XZK9gQpS4x5t7SKzbt/lRgAS+O4Bbgu70SQ/D
	 EQbnMg+wGdGKhAR/k7Wuq1P8chGw+uhWpewi7IMCSdcxNfyQkOMYk2L6Q/0E9tGVm5
	 XWyRYT2KcZABkRt5y9wqDoA7fLSJCL4R9WgJ2Ot8wRHT/8JeSMf2ZTCb9YwmF60d3b
	 9veU2+2GokCeT1qNjZFE6D8urnI7unde5hMlxQZaR25yCfE4AoX7IBA0p/7OBASqFD
	 ORIIQiCxKTVDlVSSR6tv9AuyJF0dyJSzU2yPKsYH/O9RTKgOgM2XfGqPb9p1RAgl1W
	 /w28erZ/OkO6A==
Received: by silly.haxx.se (Postfix, from userid 1001)
	id 168C762B11; Fri, 19 Dec 2025 09:47:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by silly.haxx.se (Postfix) with ESMTP id 158A783ADE;
	Fri, 19 Dec 2025 09:47:37 +0100 (CET)
Date: Fri, 19 Dec 2025 09:47:37 +0100 (CET)
From: Daniel Stenberg <daniel@haxx.se>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 0/3] test-suite fixes for upcoming curl 8.18.0
In-Reply-To: <20251219080409.GC3784564@coredump.intra.peff.net>
Message-ID: <0s72r344-865q-2n3q-o9q9-p701087s0n04@unkk.fr>
References: <20251218121120.GA3252258@coredump.intra.peff.net> <613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr> <sn7p46s1-4o20-q05n-173r-s6716s8145q6@unkk.fr> <20251219080409.GC3784564@coredump.intra.peff.net>
X-fromdanielhimself: yes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 19 Dec 2025, Jeff King wrote:

>> [1] = https://github.com/curl/curl/commit/9941e7c95bf26f00fd87888a
>
> and it fixes the first of Git's failing tests. But if we swap out the space 
> for a tab like this:

Sorry, that was just sloppy of me to not add a test and proper handling for 
that condition. Allow me to fix that in my end. A leading tab in the folding 
part should be replaced by a space.

-- 

  / daniel.haxx.se
