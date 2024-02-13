Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C3134CB
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813236; cv=none; b=ZW0WwfIDEw9HZkyW4VW+vpaeyScxzT6ebCCRE2DYHxlD77u6B6+OyzYYUAZ1+r9swj6+LLaF82Mi/WjA98foe7VI+2TO9kMI8hIaTc5DodHe9FRCyKr73gC4AVKGJ/1QIurS3GlpSZ/+uInZaWm28Mg0ui21nzpcC+2GAqLjH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813236; c=relaxed/simple;
	bh=wS1pJqInDW/otLyUi+jXu61aA0yPWTLGC2Z9OiO8VrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGtS115Gv75FLA4O2CJ4WS0IQkHNm9+0RHZTruBGioyYYQbDPs7dS13mGf14IchVZ2t3vhaDYbf5Q3Jn/+UttSuy9x1AN2rkrjZRUsJ+G1IWCTsBXNZC1v7TRYi1Y7840YUXhFjThFGSaywRLokwDZoiqJNIer+p+2xHg/jVYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr6KhrJg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr6KhrJg"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a38271c0bd5so504626166b.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813233; x=1708418033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uh9e+6ra8WAKFK/V+xqQjQSi9KpGp5w0xX3D3NaG8k4=;
        b=Dr6KhrJg1gz8FIsEf6QKQYZ+nuM/bDEkIsbkWi6+8rPOrrCSPXPtq47K1IN6sc6sMf
         x+W92pahxc4pBLAWK6BSUDEU/GuGb2nlRM2fx3zTp/LfuRZgW3e8n7Aydch2bYF2vS1I
         uKFgaEk2ZB2F4ZO7WzZWgbgDwsU6ndIPP28bq2SuRhT/InN1yhXuMYM3S25LJLbDuZRu
         GPkyNo3H3s669RloBDoTUTGywr9M8y70BbUtAbAMoWvf1ASaf5nlS4blyxIX1FbTeBMW
         OKQRP/XaDXR+nKhzNrI6rqGB0HLmuV5/kbitX3jgGZkgIg6UWyeUxVNMvUakVCPUfH8z
         BuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813233; x=1708418033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh9e+6ra8WAKFK/V+xqQjQSi9KpGp5w0xX3D3NaG8k4=;
        b=OKBp20r12CrYUT2oyeH6upDLDTpkMQvK677ct89GlXJV62Q3/2ZnxI9a7cTVB0R7C6
         3/31unp4B06EB+HU8tgZwEzb+P8yaa7g8CfapLp6ZB8lLQFzpSWwnsuyT7ekmCqolpts
         2hYfwo7vzCo3SRhsB6RJu5SsOWmOa5PA1Lqx2U9keCiv2uJv7NOeqGXUUzyafQuZpkuv
         RqVMU+2G3x5iwx4tK27x/T0oV+9QgvBdWK+JUiJfB+CPq7AXyCXUwQDvonBwCBE4ozod
         F8dtfq2Js/lo73oYEJCEmksdtr7/XCBd6GQ86QhmBw9gHEsDFRGpIY5/iPQG/dE8Dnmv
         sobw==
X-Forwarded-Encrypted: i=1; AJvYcCWRBMfk4gBNdvxY2ejkzlNK3N8s1Yar2Njd/TBtms31vivLWbKnKA0/2+4UX76/A1hTNuplj2EGv5CjpDgsFXKkpPtR
X-Gm-Message-State: AOJu0YwU2qFWcBp66E5PXBsdaqB7xipYfrAhWrVckEusgYy55H6riQY8
	Yqx3WqGQ1mUNFTZYCAkuF+l7eGRuDnSDFCj2/6ykBG2Wtmnb51ff
X-Google-Smtp-Source: AGHT+IF5ZjB/KAHeulE9oBGD4a5kgQVwWxe6d9nIoqfb3GMVdqzxkifX67lJm1XgFX4mCu8+UsU6dg==
X-Received: by 2002:a17:906:5ad9:b0:a38:9eff:b4c7 with SMTP id x25-20020a1709065ad900b00a389effb4c7mr7305443ejs.26.1707813233120;
        Tue, 13 Feb 2024 00:33:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSi0BQxVxNfvSxq8RgJ6DJW5GtZ35mA8Dg2qZXPjSfH4O1qVLCHdGlOG+P22kH9f0L7MKVP7usnHw3k5+AGrZ2KArLLeQcpkdDqNy5OBqhALcUwvV1gnxZBtd9KyDRkaQ6rb5H/IV/vQwkCp+tOVuuh4E0Ue64DApJ8kHDLaeqPtx0rBoKmqad4/CsenIYO8wWhS/RLxtNlFhrsFNLt3Ors9NEPa5LqwrBnW8dQ3Omp/cOxKYzFKztz/oLHmRr87k=
Received: from [192.168.3.191] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id ti13-20020a170907c20d00b00a3ce3c5b2a4sm870058ejc.195.2024.02.13.00.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 00:33:52 -0800 (PST)
Message-ID: <7a2a0ed5-f9dc-42dd-886b-457641b9bc79@gmail.com>
Date: Tue, 13 Feb 2024 09:33:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
Content-Language: fr
To: Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Michael Lohmann <mi.al.lohmann@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
 <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/02/2024 à 00:35, Philippe Blain a écrit :
> From: Michael Lohmann <mi.al.lohmann@gmail.com>
> 
> 'git log' learned in ae3e5e1ef2 (git log -p --merge [[--] paths...],
> 2006-07-03) to show commits touching conflicted files in the range
> HEAD...MERGE_HEAD, an addition documented in d249b45547 (Document
> rev-list's option --merge, 2006-08-04).
> 
> It can be useful to look at the commit history to understand what lead
> to merge conflicts also for other mergy operations besides merges, like
> cherry-pick, revert and rebase.
> 
> For rebases, an interesting range to look at is HEAD...REBASE_HEAD,
> since the conflicts are usually caused by how the code changed
> differently on HEAD since REBASE_HEAD forked from it.
> 
> For cherry-picks and revert, it is less clear that
> HEAD...CHERRY_PICK_HEAD and HEAD...REVERT_HEAD are indeed interesting
> ranges, since these commands are about applying or unapplying a single
> (or a few, for cherry-pick) commit(s) on top of HEAD. However, conflicts
> encountered during these operations can indeed be caused by changes
> introduced in preceding commits on both sides of the history.
> 
> Adjust the code in prepare_show_merge so it constructs the range
> HEAD...$OTHER for each of OTHER={MERGE_HEAD, CHERRY_PICK_HEAD,
> REVERT_HEAD or REBASE_HEAD}. Note that we try these pseudorefs in order,
> so keep REBASE_HEAD last since the three other operations can be
> performed during a rebase. Note also that in the uncommon case where
> $OTHER and HEAD do not share a common ancestor, this will show the
> complete histories of both sides since their root commits, which is the
> same behaviour as currently happens in that case for HEAD and
> MERGE_HEAD.
> 
> Adjust the documentation of this option accordingly.
> 
> Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Co-authored-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> [jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/gitk.txt             |  8 ++++----
>   Documentation/rev-list-options.txt |  6 ++++--
>   revision.c                         | 31 +++++++++++++++++++++++--------
>   3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index c2213bb77b..80ff4e149a 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -63,10 +63,10 @@ linkgit:git-rev-list[1] for a complete list.
>   
>   --merge::
>   
> -	After an attempt to merge stops with conflicts, show the commits on
> -	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
> -	that modify the conflicted files and do not exist on all the heads
> -	being merged.
> +	Show commits touching conflicted paths in the range `HEAD...$OTHER`,

if $OTHER is a placeholder, why not use the placeholder notation <other> 
instead of a notation that could deceive the reader into thinking that 
this is an actual environment variable?

> +	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
> +	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
> +	when the index has unmerged entries.
>   

Thanks

