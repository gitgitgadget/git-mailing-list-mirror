Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312F0524B4
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399277; cv=none; b=WWjm1/IPLYEIXLxuHPAfbvO15kqstWmITxAXnhlCmXsbi9YUeOqoV0qUO/B9tPs+Ukof7ECWNBkZdAxes1EWVT+8SN2ZOhJJ2U6QUOG0AwToRZOjVI7fFTWOewdnoCfAt6YKplcVIVrSHf5SrMZxQ9REuud1VfqFA19LvHHw+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399277; c=relaxed/simple;
	bh=lir3M7OE/Y76KYmrdSv7HQTsgms6mRQ+cfkHT8UpGpg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qPr3PwP+87pJvrUP9l3arfUrhbuCsMu/rWQQ7luLR9VD/f5xLzhoNJOiYSPEwLuqdvJI520fAOvO1fvCvBLctgu+m+thQdioaW4rVh4FJcEg2Aa8a8ogZIMrVOz5p/YQTbFnDWldO5bAn3zuzrIsJyRuI4H5/YHltf/40r+3S7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UTRJ4CL3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UTRJ4CL3"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711399274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4vRbSKUbgUBsOostTMIOS0u6lmhmXGILihMtB6br5U=;
	b=UTRJ4CL32KpZkjPWbtRmA6Ols337cdf7Lp84F09CAOvkgw2TeEKKtoVIu2W3vBZTxOUmiD
	eeA/tRKVbSCucroECG9R7JLVOO7w6pmz7winrF0CWOJGV6ovrgQYnMaAli7CGD78oUBkEn
	2nlIZG5mqoYoe5sqVve0CLfeUHp+qPQsrHvgGFOr7kcuwMF0BxmpKtF0u6RyRc9mgj8aZc
	TnOKNLMyc1XL7B3FJwOQvcpSHqmTtuTR8juMRolM2n+IbQ2QpcyyM+nl0C26EnYGvGtony
	Ci36iCY5pDMHmcJFkde1q/PDiZCEae9p7R6zGf9v8wvqhonaiPUc0ahY4Av+Og==
Date: Mon, 25 Mar 2024 21:41:14 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jn.avila@free.fr
Subject: Re: [PATCH v3 0/3] Assorted improvements salvaged from an earlier
 series
In-Reply-To: <CAPig+cTia_gXkpNw6jo8VHg=ODqX71Nvff4Qfq0oMWqShv5TWg@mail.gmail.com>
References: <cover.1711398665.git.dsimic@manjaro.org>
 <CAPig+cTia_gXkpNw6jo8VHg=ODqX71Nvff4Qfq0oMWqShv5TWg@mail.gmail.com>
Message-ID: <92cb6c057591c7192fd7eb7097336f66@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-25 21:39, Eric Sunshine wrote:
> On Mon, Mar 25, 2024 at 4:34 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> This series contains patches salvaged from my earlier series, [1] for
>> which it has been concluded to be not acceptable for merging, because 
>> of
>> possible issues with various git scripts. [2]
>> 
>> Changes introduced to the patches are described separately in each 
>> patch.
> 
> Prose description of the changes between versions is very much welcome
> by reviewers, but please also include a range-diff[1] or interdiff[2]
> when preparing a reroll.
> 
> [1]: git format-patch --range-diff=<prev> ...
> [2]: git format-patch --interdiff=<prev> ...

Ah, sorry, I didn't forget about that, but I just intended to start
providing range-diffs for future patches.  These were more like new
versions of old patches.
