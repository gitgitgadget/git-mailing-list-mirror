Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298DF28370
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735781; cv=none; b=MH26/g6zroMx8B9NM6OOLcXS1QO5nlTk/Z7cpAMitY0Y1QC6yijcG3TfMlI5JDLVUgC8veJqEJv2sAGQp47YQCt7aM2wLuTNlc3BBCm6nf2aP1j/Qr8ebkU1P2mos6BSkkY18W3QYDVq67GSd82pYFQbQ9iWj/C92rr2HCRfIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735781; c=relaxed/simple;
	bh=u/K1I8oeiwPCTqmIQr2Pz//pqz5JnTQLXVaQ9Oiknqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9cngl/RTHQddimazZXw5ENv6NDALOcbpgmWsa5w+0pXrukKiCTJad7ll/iuwWLsCZxFZg9vfQVuhElVYuVvTt9tYxyJ4HfUJ3aJVo4/Wzqfdmq+ChxmgvXwURt9FH1fYhYHRT2any3yw9y25SqOyplyRfsg5ZawEuLdwL5f1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrIeh0aa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrIeh0aa"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4114e0a2978so1406295e9.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 03:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707735778; x=1708340578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Be7NdF1DavVP67NpaUXUBE/cLhKaJUG9pdJwMYWq/w=;
        b=mrIeh0aaomPEW4gqu+Ai4kUHezAwEo86p8dRUjd6ZQSbEECcBafmq+7UpJolbGTEHr
         WUg7DRxJ93vwr5Z6pkqb2f58oJElY7CCUV3zqqc5IwpREPh9sPhWOOqM8pEbO+gM+vm9
         5SHLuH9VmiVC3e/UroGhKpFP+g37HxhM8zrECT20i2Q2WD8HHmhMM0MTuqy48y2YUire
         oWNgipxzSjJG9Zx/t5OMHiw9t8G1eHkyC1Xi0+cuZ8/iBPeDmUb/kfKEQK1FtNpzIFha
         KxDiKO0gXO73etIHBL0Ub7k8kmE1Xx4JzCUpLfzugkf8xovEKs0eNbvOx/OMhrCL64Nf
         bZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707735778; x=1708340578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Be7NdF1DavVP67NpaUXUBE/cLhKaJUG9pdJwMYWq/w=;
        b=LiSW/qCOWly7OHfNoqvUod63XhHUQesmn7earbGx4TuJS2HXCquV1cX0+hrFKWkn1D
         de/82GcjCU8psdaKXPH1u8cBA2cF5lmGPYHcYX8xYfmC39qIJBb87wzAvRQXx49pBMqn
         wI0+FnNiFn8WyYirHmXR2J/lMs/dGgvhGKv2Xsl/gZmR36I9tqUtU2W1H80Iks+Bz61f
         q9d7/RczfL6E/Y22HaQeMH4mSF1zN2FyGkWTsWwUisORb/geQn7oc7qM/dAP9YQNDGCj
         dnnluiNA3JBNmf9cP9cHiwIdSF5D7RMpe6eWBtsPrCjuCg6qwr0vgDhg2Sg1wOPbAfXW
         Xe9w==
X-Forwarded-Encrypted: i=1; AJvYcCWAQbiYX/SPK3Ri6MNsE3hIebLGRpSm/9NeqitM/h80p4ySzVmzoO2EYSV79UJooU8E9OMW8tQ31DGp+rGWdM1Y1NFs
X-Gm-Message-State: AOJu0Yyt5mdEqDATmgxYyHI9BDns845Hiqh2EnyvFcgq5zvZLDn1AfHh
	0B+Y18n4EFiU2p58PqtWKOkwNODTfw9c2jFrLQEADfUEDtj/rJVo
X-Google-Smtp-Source: AGHT+IHBe/Alyvt3E2U+FLd3xsD2GgFRuAMd3pGSYnZpTUjvvPk+mOeU8V/81rzndL6thfrWoupD1Q==
X-Received: by 2002:a05:600c:a386:b0:410:be25:12b5 with SMTP id hn6-20020a05600ca38600b00410be2512b5mr3123654wmb.9.1707735778116;
        Mon, 12 Feb 2024 03:02:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVea1DqOZGM5yYvZDY0wVwQI3dM4CyRQUtU9t56l8lCsiDyz6qH5Qh2w3KGzocF9uD8lJmSb+fx4zoTEH8v2Cw/cpxp7WehbiQ/c0nWI+8jBnRWRVBE8PyMxU1vuTU69DHOGwbd5ujSAbQX4yJJy87bskEGayEP/kR/xMqa6PCe0IuKzwpKZ0B1xB88OAV9O8D79Ym2k9lXevun+k043zzpajx3b7LaRsOzATs+DFJuskZmHCuW5PwnoZGnn6SXoEg=
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id m6-20020a7bcb86000000b00410df4bf22esm1874469wmi.38.2024.02.12.03.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:02:57 -0800 (PST)
Message-ID: <c5d60b5b-3181-4bb7-a7f8-eb97474526d7@gmail.com>
Date: Mon, 12 Feb 2024 11:02:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
Content-Language: en-US
To: Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Michael Lohmann <mi.al.lohmann@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
 <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe

On 10/02/2024 23:35, Philippe Blain wrote:
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

I tend to think that there isn't much difference between rebase and 
cherry-pick here - they are both cherry-picking commits and it is 
perfectly possible to rebase a branch onto an unrelated upstream. The 
important part for me is that we're showing these commits because even 
though they aren't part of the 3-way merge they are relevant for 
investigating where any merge conflicts come from.

For revert I'd argue that the only sane use is reverting an ancestor of 
HEAD but maybe I'm missing something. In that case REVERT_HEAD...HEAD is 
the same as REVERT_HEAD..HEAD so it shows the changes since the commit 
that is being reverted which will be the ones causing the conflict.

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

Thanks for the comprehensive commit message.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 2bf239ff03..5b4672c346 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -341,8 +341,10 @@ See also linkgit:git-reflog[1].
>   Under `--pretty=reference`, this information will not be shown at all.
>   
>   --merge::
> -	After a failed merge, show refs that touch files having a
> -	conflict and don't exist on all heads to merge.
> +	Show commits touching conflicted paths in the range `HEAD...$OTHER`,
> +	where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
> +	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
> +	when the index has unmerged entries.

Do you know what "and don't exist on all heads to merge" in the original 
is referring to? The new text doesn't mention anything that sounds like 
that but I don't understand what the original was trying to say.

It might be worth adding a sentence explaining when this option is useful.

     This option can be used to show the commits that are relevant
     when resolving conflicts from a 3-way merge

or something like that.

>   --boundary::
>   	Output excluded boundary commits. Boundary commits are
> diff --git a/revision.c b/revision.c
> index aa4c4dc778..36dc2f94f7 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1961,11 +1961,31 @@ static void add_pending_commit_list(struct rev_info *revs,
>   	}
>   }
>   
> +static const char *lookup_other_head(struct object_id *oid)
> +{
> +	int i;
> +	static const char *const other_head[] = {
> +		"MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(other_head); i++)
> +		if (!read_ref_full(other_head[i],
> +				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +				oid, NULL)) {
> +			if (is_null_oid(oid))
> +				die("%s is a symbolic ref???", other_head[i]);

This would benefit from being translated and I think one '?' would 
suffice (I'm not sure we even need that - are there other possible 
causes of a null oid here?)

> +			return other_head[i];
> +		}
> +
> +	die("--merge without MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD?");

This is not a question and would also benefit from translation. It might 
be more helpful to say that "--merge" requires one of those pseudorefs.

Thanks for pick this series up and polishing it

Phillip

