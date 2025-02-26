Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E422A4DA
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592399; cv=none; b=hbWOMNSwZTxc4gWwFuFx6soD1DxIcCr3XzH7Gpl0LBO8xoJV8sjeIyMlE+2cdBXUEqMg3lvM77+wz6RdtRiw513Mo94KS2+ZfTffpi8n1tK9AEXbgx/X49sztvdtUdkn+BQtNM4DB54l9VeAvHoa9l8K1XWQBOnHj4yOiBch70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592399; c=relaxed/simple;
	bh=k2mrrX+qkZfV3gPExVRlfYOtCCF024o+yFX3j+ZDO7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQlg9z9VnTdegsX6xbwb/BMiXTWVGiaoXV9yaSTmf/ETfelo7aJBXFVcVzXudH7hTIVHvDHD4XOPUqbQl0EzMQcwXfZQar75n8+fltSJa4B+rxRH8u0ERDwH1TBUwdGwr+d6wsw23QtpQEegfFCw0PLJfMZbSPHq5NdcAinwnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=GjxVe3Wx; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="GjxVe3Wx"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id nLXotXd4dSSpfnLXptpWMI; Wed, 26 Feb 2025 17:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1740592206; bh=BslwToHmgSLquoWY13Z41M/motjB4DTmA9mGuZ1bMlc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GjxVe3WxpN0gb3ma1POPP6vmfj48CDci/IY8Sp89I4BCvcHqnN+K1R8I0bbKc8nyx
	 lxBdA7H7zcykEnVR/Z3wnmtDbrx1j+HysfFk04hxp7U5jjXUvBRBdWvLtre4wwrQye
	 hDIPcPcTR62zcw1fyQ1AgiFkhpnr6AweBvmlEZB5dCZEI7s0FMXVS/WlZx8mDTLn6J
	 UWm1mqRusgCOUdCNz739RMhk8ncRsCq0GcYWe23fiQqWkWpu3Yk/MXQqbS4b/hB8/z
	 PWO+uWBV14+87xgFNXdmGJr317bCRavObe9qaW5TDpRIniF5+v1Gcybr5WLazxRNxq
	 ICMwOqcQFBWzg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9re0vni c=1 sm=1 tr=0 ts=67bf544e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=3FqUGxySjS5IqXxmh6MA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <543e1914-d05c-4053-916d-e8286edecf50@ramsayjones.plus.com>
Date: Wed, 26 Feb 2025 17:50:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] builtin/maintenance: introduce "reflog-expire" task
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee <stolee@gmail.com>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMm9ynZ0dmVHobhtx5EEMo4oSy8mocL95Fas7J59/dk4WNtzQ68ZvVEb2j2edN5sNl8/+wdAm4BaIiG9DQaUG5cstC1Lz0RwgZQUOixAfTkpc+X8GWjq
 bxwD3ZDVObhUOD8LAw+e0sBwTCrEZRmW94k7DdWPCmV/V+Uqw/FSNmWwm5KXJqfy+Z/tfnMxud579FKRlZkwmcG/fuh4PS8MJHI=



On 26/02/2025 15:24, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series introduces a new "reflog-expire" task to
> git-maintenance(1). This task is designed to plug a gap when the "gc"
> task is disabled, as there is no way to expire reflog entries in that
> case.
> 
> This patch series has been inspired by the discussion at [1]. I consider
> it to be another step into the direction of replacing git-gc(1) and
> allowing for more flexible maintenance strategies overall. Next steps

Hmm, I don't know what you have in mind, but just as a data-point, I have
never used, and have no inclination to use, git-maintenance. However, I do
use git-gc extensively: at least once (times the number of repos fetched
which have changes) per day, pretty much every day! :)

ATB,
Ramsay Jones


