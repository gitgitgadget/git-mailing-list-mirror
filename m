Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D752158529
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723418633; cv=none; b=DVOpKPM8IipRFh7gV888z9Yf/eeJebxG2TWIv97kVUe5TjRQurbgfxp7Ra/7eHj15w60l+SsOCxzCWbU7h7bOAOTOH5exOgr7I5kjJ8BUyFgbMOnd7fAfsqbxRT8P/O984WNZZt6JsAr0xUTdNVH0azGyMz/xeLNspk3aqd5ZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723418633; c=relaxed/simple;
	bh=On2I4fO6fxHV8xoNa9cTCaluvOxFCdDur9a0tX+2Xik=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fJqK768T01KIwtLpolsvCSfRL0xWszvxf6Q2g7WO+bKaV6x0Vbu7mC0TWujdFSRkAGQyMSpLi4Ty9tY0SGiEPBaHyBiyQDI8KnbMfc9zrBld824bDbdL6BB7zPKqU5s61P1fcgcjbrcQguunIYrFBFaj3vIvFmjwkRsgVO5WLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=x7m/uSXZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="x7m/uSXZ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723418628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgpsCoJ1XXB/Jjdaq0wqCEokHSEZAAYqxl+lZGmhGPM=;
	b=x7m/uSXZ/UYuZEEQfPzElug4RoTrtgSFNj9gWm2CEKP9+3KCifF8bLH6eQfsmCi/f0qkh0
	iWaUyLE90mqHiTkkA0Ymqw3bMVm1MRM10i9hcknDnqSGa87WjjCxzHduTRz2Hla5l8ky7B
	kinuCjCwi4HJjnnctkHNMXGOz4VNQuQ47j072a85OhnCkHP1QBQ2hxcGxhmdgCcikOZTgt
	+B0u3JhnXkF8sYUIPPPsDUYHelVloCoz1LInRXMO07dRwu1aW+r//BCDb/752lat7HS79K
	NzayBqVsqY/K4r9FFXVvoaLGdCEygihPtqNFNT3I5Vn1Egej/ULYhiIS0qb/3Q==
Date: Mon, 12 Aug 2024 01:23:47 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Josh Steadmon
 <steadmon@google.com>, git@vger.kernel.org, calvinwan@google.com,
 spectral@google.com, emilyshaffer@google.com, emrass@google.com,
 rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org,
 sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com> <Zrdn6QcnfmZhyEqJ@zx2c4.com>
 <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
Message-ID: <ee460e193b567b73e789ee77579f41c4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-12 01:03, Eric Sunshine wrote:
> On Sun, Aug 11, 2024 at 1:27 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-08-10 15:15, Jason A. Donenfeld wrote:
>> > Still the same name for v2? Cmon.
>> 
>> Yeah, I was also surprised to see that.  This _isn't_ cgit.
> 
> Josh addressed this point in the v2 cover letter by saying:
> 
>     Known NEEDSWORK:
>     ...
>     * Bikeshed on the name

But didn't Junio already say that the v2 of this series will be merged
as-is? [1]  That's what actually made me surprised and confused.

[1] https://lore.kernel.org/git/xmqqfrrd9slb.fsf@gitster.g/
