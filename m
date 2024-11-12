Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD72178EE
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437522; cv=none; b=jF7AAF+Nyj9J0x07YjWBJsLO9lj/TvloR3vxJLQIC9w3h3Xe1hcPTVxpquVjybz7C+umJyXlglrTozYwdcKfl5Y2AkSZCQn3nwY2o01T3P2Z/i3VTsB1qmz/JoRN+JfoL0YxuE/fuSzgXRJHOLriMr2BWWJH6VEOVnxlYNMgD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437522; c=relaxed/simple;
	bh=S0D5pICP0BrmVrTFJR9pOB1+MCGPuAbYEc4rfKh9ukg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lN9XKz66E3hH0rWdlU/ACSNyV+z0AIkSESNoEgpGMGBPorL3lS+KVk4cSLQmMpJP6arDbG7XZJ7LzblDbV1nMQOZFC/NR3g+QyJE3wie6h/fqoeH4iJksnwTDToitbwUqLrLNeyWTALG1wlNdcmJid212P6brV6Vgp9yf1+K2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4XnwWH6DPZzRnlK;
	Tue, 12 Nov 2024 19:51:54 +0100 (CET)
Message-ID: <baeb6c64-eb6f-45ab-ac11-0896dd0adcae@kdbg.org>
Date: Tue, 12 Nov 2024 19:51:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] doc: git-diff: apply format changes to config part
Content-Language: en-US
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
 <17a2f028d59a0097e92229c2b934a69974691e79.1731343985.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <17a2f028d59a0097e92229c2b934a69974691e79.1731343985.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 11.11.24 um 17:53 schrieb Jean-Noël Avila via GitGitGadget:
> @@ -1,18 +1,18 @@
> -diff.autoRefreshIndex::
> -	When using 'git diff' to compare with work tree
> +`diff.autoRefreshIndex`::
> +	When using `git diff` to compare with work tree
>  	files, do not consider stat-only changes as changed.
>  	Instead, silently run `git update-index --refresh` to
>  	update the cached stat information for paths whose
>  	contents in the work tree match the contents in the
>  	index.  This option defaults to true.  Note that this
> -	affects only 'git diff' Porcelain, and not lower level
> -	'diff' commands such as 'git diff-files'.
> +	affects only `git diff` Porcelain, and not lower level
> +	`diff` commands such as '`git diff-files`.

A stray ' remained on this line.

> -diff.srcPrefix::
> -	If set, 'git diff' uses this source prefix. Defaults to "a/".
> +`diff.srcPrefix`::
> +	If set, `git diff` uses this source prefix. Defaults to "a/".
>  
> -diff.dstPrefix::
> -	If set, 'git diff' uses this destination prefix. Defaults to "b/".
> +`diff.dstPrefix`::
> +	If set, `git diff` uses this destination prefix. Defaults to "b/".

You are applying `backticks` to possible values such as `true` and
`false` later. Then these `a/` and `b/` should also be set in this way.

-- Hannes

