Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17438239E
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433029; cv=none; b=XnO5LVvmgFnQ5+5jT185BKPXtYSfA7VzBu0KwagiLLKZ37TflbMSRhR3NavHfUVyipV0Sb/fmJtXK0uPz9ke0WtrU1QJsdcLpbL62sXsS30o5nAtZI4gqPe5txvu+eGxdJZBiGB76EtWEO/qZfwOgmfsqi8picOGVjNodlSHY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433029; c=relaxed/simple;
	bh=KrMPjcVlcvJ5aO0RhEuzQzYY0aHXZ6dy7xvt+L30D8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbHCUM8K9u1MqYw0jqZnTkQcIDyM4CeQIiyTVJU3rF9LhDVcoXx6F6SqltnX5h1KyMSuS1SMG4/uWu7kvSNdJXSLZx61hprbK1r7wopPeEdZYECa2NHNPj8wZ5jTNxQRlLSN5jffRhPpMdHvAbih9WzOHPeTMbAq2pmO/XM+f4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4fgjD03RRRzRpLK;
	Wed, 25 Mar 2026 11:03:44 +0100 (CET)
Message-ID: <6b299cf5-acfd-4a56-87e7-db26743a3271@kdbg.org>
Date: Wed, 25 Mar 2026 11:03:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v4 1/3] graph: add --graph-lane-limit option
Content-Language: en-US
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com,
 ayu.chandekar@gmail.com, siddharthasthana31@gmail.com,
 chandrapratap3519@gmail.com, gitster@pobox.com, git@vger.kernel.org
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-2-pabloosabaterr@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260323215935.74486-2-pabloosabaterr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.03.26 um 22:59 schrieb Pablo Sabater:
> @@ -3172,6 +3174,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  
>  	if (revs->no_walk && revs->graph)
>  		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
> +
> +	if (revs->graph_max_lanes > 0 && !revs->graph)
> +		die(_("option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
> +
>  	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
>  		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");

You help translators if you make the new error message format string
exactly identical to the one that we see in the post-context.

-- Hannes

