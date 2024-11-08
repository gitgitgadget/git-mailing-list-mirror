Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820B1BD9D8
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731048836; cv=none; b=Oi013+oncApQHSxsfDnrwJtZfYlnE90TldTuwBA8p4O2atyU3TTbgy6GUNIkOAFmkyeWieS4CdoGqOGYkUDfaBedj8OtJonftE6Gdut07hRbFpucDc3YZ1clFIyaU+AdJepBq5HkhtDtNDdQGF8NAjcNdSzlA5bSSaVOBGQuLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731048836; c=relaxed/simple;
	bh=gEJ5DFG781dCGeG59BRLzCdH0O51qlo4i8vylCueHp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1FCZUcKBSJIJ+ElR7NvfGF7La/GL9bGEsSMyWhj3d/P/MVLhztsFoz3HguLgeZ6WlWYyXlTPRs0PGJT0xA6b9RYX/0SCZABzhLdcdj0qn30Rf5nyiblM0vLZ6Y/k3PchaA+a3BpuZN9VuP/HwXSCEJFs0BOAN23pAyS8/H4sEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Xl8mX2YgFzRnmS;
	Fri,  8 Nov 2024 07:53:47 +0100 (CET)
Message-ID: <abc2453b-f7df-4601-8834-595881f9ceca@kdbg.org>
Date: Fri, 8 Nov 2024 07:53:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] range-diff: optionally include merge commits' diffs in
 the analysis
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>,
 Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.11.24 um 18:20 schrieb Johannes Schindelin via GitGitGadget:
> +--diff-merges=<format>::
> +	Instead of ignoring merge commits, generate diffs for them using the
> +	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
> +	and include them in the comparison.
> ++
> +Note: Some of the formats supported by linkgit:git-log[1] make less sense in
> +the context of the `range-diff` command than other formats, so choose wisely!

Can we please be a bit more specific which options are usable or which
are not usable? Perhaps you even mean to say that 'first-parent' is the
only one that makes sense? At a minimum, we should mention that it is
the one that makes most sense (if that is the case).

-- Hannes

