Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B6D40E8C7
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672379; cv=none; b=dim8KTu5s5BI0RVClIUU/lZka1zEtlts1tTMYLpo10UA5nVXZi2J67Tq+dEOypMqbOI7mKR8jMFkB9g69Imq89TbGbigq5J4+TP0hxO52Ba/yhhFWsdpIa3BbTxaPhCpBuiyP8wdE4MFjGQco2T0lqFJbrg+RAsouo2Lcqmfg4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672379; c=relaxed/simple;
	bh=kHJZdTdfMrtzSZl3CFB4ZM0ddwAtlO++CrUsoQu1QpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIh9xblct6hb7MZ1jk4VmpdVz7pr1jSAFLKzSoMj5x3c99srte1/0xHZSMwQ/HQSFX3SoXdApjx+Jon8JWjspqKUQ+g51gpt7wrBZNQKOspa9WyhxFpLZBJ8alf5vVAzCEfVbSUCCajYh5V+Ap3XM615TD63j+AzLOTGmrBMdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ3Ra5bc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ3Ra5bc"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso360980466b.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672376; x=1781277176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dULl0arOOCpMbauzScp+9sXEMWvAB22CBr27Si50iwc=;
        b=LQ3Ra5bcSNR4Xxo/BDyUWH2uATmobb1BBfahOuw6zBCtCHbfLWL7LWEuojo+PS+scg
         lnDMph64lUgX6/sGRfgsr47GNIkvpv/OKZz8WMN7xJfhbwEEzmsjXEHGa9Wew7kmOKh+
         C6EJ7mFyKZU+u3XV/NGXij7O7zhxZM6traOdqXzcVIRyZzx7Q1AokCQdvUVlLZNYMElS
         Xbe9avi85yCFFHBB5xfA4B6I85CsA4EBCmeAeLkJs1HH5viBulCPu4Dh1ToIiZt2ye4K
         QCvd2lN8JZgOGxTfMRonUl1SPqHawPAwpuT1xiDBZOLlbJgtZVEUw2hRU+gDQwQ0q/QW
         97Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672376; x=1781277176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dULl0arOOCpMbauzScp+9sXEMWvAB22CBr27Si50iwc=;
        b=ZJgUnII807No+e3v7ARcL4U+K58ujpcyc25fJeI/MmUeRdANMa3nn1lMq5v0fLkPd6
         G0ddxIHOGXXZ3H51p8tf8ml4dMMpWQhe8TRzbXVu0eFlrH4FGmD6mVQcdqRaKB3Sitab
         c9+a7x+jbkaVPYeX8Ad2mHjjSlNPS3NdFoHoiTUM8MDIfmScwAoRr8tBPThA9hfXJHgw
         r52F4Z2QEDHp3HZF5Zj4Kx5D7jjWOiP8eWxO1uL3lzLYctptYz2uMJDVqnVD1A3nVanL
         4Fjr5bvsRBgJGgUCvX0N9VzUyjVetC+8agrVYszEdtdwkFTlaR+MSO02mgvudYLia5kL
         /H9g==
X-Forwarded-Encrypted: i=1; AFNElJ//w8kL/NFyH50eDuP03QBOa5mKV0t5pQqdaMW0p8nmcDDXX96JHD22WU+diQYu2H8Dn1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YweiAJZSmVSma9U/g3ZxBKWTwX+wslxfOnSAeqLFmxvaneMF/t/
	c84r03Pa1MY0ebaTNU94ftGxRgBJgoqrqqVUo3xtNZkAeiperrKuPKEP
X-Gm-Gg: Acq92OHCA2fVtb2N92sNcYCnUQx1L0uWb7fZH3ZEilwybRCK6HI0gpDa80CotXVpqvt
	mGmQIW9B+gGKzVVLdmwca9VobumaGShbMu7XaIJJJ/HytlXENvlIn4ArE10ahJPYsv8clDO8cAe
	y5TficCukiRhXiXJIHOCCOVmqcjpCKIAD/Hf5fdgCCLlZh1BNDjuA3u9i+YrYnU0ci/rasN9mX6
	uHl+lWnGqqrX3TMbbktynp0Ls92hPvsapvFG8xpZze1Z8EOUJNzQ7GcK7X6sYGv1LjRXnBH9Pa4
	gxm+GIk2xadDScO6FW2UyAAvGYZjqZPK4956yVYAJzLRYwSnwN1CrVvS7oNydsHmZ0iyeihhlpq
	5qmo3jU6Abtv+nEvls9RPSuOS5jiCHjsB3K9zwKusiS0ZgTE4+NdYqVXso8WH69WMDf102K+/DX
	2c5q77Lsz0Gt8Db0sU8pQZdyXH+U5WP87wGXV0TA5zqvruQ7hGxXuEH8D0cFwPy5M+/7MtLeGkU
	6y35bHgN3yhuA==
X-Received: by 2002:a17:907:7b8b:b0:bed:83ee:9223 with SMTP id a640c23a62f3a-bf372f1ee4fmr218979366b.45.1780672376294;
        Fri, 05 Jun 2026 08:12:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054dfe3aesm471262866b.37.2026.06.05.08.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:12:55 -0700 (PDT)
Message-ID: <0fdaeec8-99cd-4dc9-9549-8a08133deebf@gmail.com>
Date: Fri, 5 Jun 2026 16:12:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/9] reset: introduce ability to skip reference updates
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 03/06/2026 17:14, Patrick Steinhardt wrote:
> In a subsequent commit we'll introduce a new caller to `reset_head()`
> that really only wants to update the index and working tree, without
> updating any references. Introduce a new flag that lets the caller
> perform this operation.

We already have a flag to update ORIG_HEAD so would it make more sense 
to have a flag to update HEAD, rather than adding a flag to disable the 
updates? It would mean updating the existing callers but I think it is a 
clearer api and it avoids the pitfall of

	RESET_HEAD_ORIG_HEAD | RESET_HEAD_SKIP_REF_UPDATES

I wonder about the function name as well if we make updating HEAD 
optional then what does reset_head() mean? Maybe we should rename it 
something along the lines of reset_worktree() or update_working_copy()? 
I'm not really sure what a good name would be.

Thanks

Phillip

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   reset.c | 7 ++++++-
>   reset.h | 3 +++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/reset.c b/reset.c
> index a8d7eea4d6..ed9df6ca5c 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -93,6 +93,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>   	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
>   	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
>   	unsigned dry_run = opts->flags & RESET_HEAD_DRY_RUN;
> +	unsigned skip_ref_updates = opts->flags & RESET_HEAD_SKIP_REF_UPDATES;
>   	struct object_id *head = NULL, head_oid;
>   	struct tree_desc desc[2] = { { NULL }, { NULL } };
>   	struct lock_file lock = LOCK_INIT;
> @@ -112,6 +113,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>   	if (opts->branch_msg && !opts->branch)
>   		BUG("branch reflog message given without a branch");
>   
> +	if (skip_ref_updates && (opts->branch || refs_only))
> +		BUG("asked to perform ref updates and skip them at the same time");
> +
>   	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
>   		ret = -1;
>   		goto leave_reset_head;
> @@ -196,7 +200,8 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>   		goto leave_reset_head;
>   	}
>   
> -	if (oid != &head_oid || update_orig_head || switch_to_branch)
> +	if (!skip_ref_updates &&
> +	    (oid != &head_oid || update_orig_head || switch_to_branch))
>   		ret = update_refs(r, opts, oid, head);
>   
>   leave_reset_head:
> diff --git a/reset.h b/reset.h
> index 9f696382c1..cb0700ffa7 100644
> --- a/reset.h
> +++ b/reset.h
> @@ -27,6 +27,9 @@ enum reset_head_flags {
>   	 * any user-visible state.
>   	 */
>   	RESET_HEAD_DRY_RUN = (1 << 5),
> +
> +	/* Skip updating any references, only update the worktree and index. */
> +	RESET_HEAD_SKIP_REF_UPDATES = (1 << 6),
>   };
>   
>   struct reset_head_opts {
> 

