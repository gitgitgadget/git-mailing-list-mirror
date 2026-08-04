Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5663E51C8
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878036; cv=none; b=dby6Pvz5R3RiZCcq4I/7bJxhYcD7twfK9lji14pi6+Mh/sQEpsiXaZ2UhncVWkt/aFkJwb7q+0O2Dq0NnVbhnuXd8yJ1MEAEgUouPV0kZeFwDqplRJS6Ab2ritmHuYDqfqYPcbbmv9vBMcAf0UGOAXwRc/DjCFcGdqiI1pfWx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878036; c=relaxed/simple;
	bh=VrCGVT6fVfC913CaRbRhWnH8AX64KGYac5IAzFzOGLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fO4OS13hhgLeyhsGiJLrbs9eWZimax7Sv5IBfjJ2/KujMqHjPCGKXpAz5lW65oPdWFbokL9smvbcajTQwlMJR8E+m1pVLtJshVWY7Pjlg7KXM8sVMa87JSsqy0AKr1nrpnh01564np06e8xPFlCwhgDd+dGAt9GtvRKyYPpSDZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRXkdZSS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRXkdZSS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so300009a91.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785878034; x=1786482834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ulf61+neiO7dz8t+4Kc8NzvNrnrYIu1e+t3oGT1dFWE=;
        b=sRXkdZSSuRp8Mhv42KtZo7wzU67SpYDoEL8qTPD/WA+oCXrWzcRqfrHqBvX4RUW64S
         BhOPeS/VENtLBMZCwtNDM0hA7KmEaO22zgY6FuJL2HnE55exUCoVK9co4sCFEFyz7qq8
         vTa9Du99UATKVoF8+57Jala+vRYPOL2REtCHlzBuNaJTmj4S+mFcBGA9jby6+eWozliC
         7FZws0QY3gAhnI5tdbVs2p1iwmTr55Wte6IG3H+DjHxcjsuCUe7X+xk0PW4Jyyk225DC
         6b9RzrPBHnYJ3X3DTY86SKPBrw5VLHMd+NCwzBfS6oftOXhmQZQ7ZFV1mIf3uwulq2L3
         K4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878034; x=1786482834;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ulf61+neiO7dz8t+4Kc8NzvNrnrYIu1e+t3oGT1dFWE=;
        b=gyhVwIcqn1Lvvop15VL0ttXBTFOH3GDKha8i9OXh6tQatE7ibF5zyl9LSf3a1NmnUB
         ifDA2RyIT7/H0IYplURAHany8Lw5ZRELj6ed8MAVgmG678fsrB1uh+m3C02F8Na6t4zq
         Y3HI4NIZXt/DFN/6/J6+cPJ3SIBUelgQtjQRD9gcNIWwcKJzJQCH+usV5u5tsz34BLNX
         aw9YYZlyCYmX6/Ho8siyrlVe1g6XCCqeGnQYfrMqeSTUH53MFrO/19iWjQHkXR/BhRwn
         aVlxmlOnRNWqLi0oC/aamFWB+poTcz6yQ5JdYbf7Yy2yCxMipMYvaL4A7Ttbn++h8v2R
         zOFg==
X-Forwarded-Encrypted: i=1; AHgh+Rrigfbw2tF1kIGGSfVvKWdllxNujoQuaGEpl6LNVX8RkqYjAWDj+fLXPaEh3oBXQXOgJlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXQ8ULiGDpdqXTVV1GswVfFTK4g8BJKY+KrbcEE/neeTj+EXl
	4cqJDcCYG65QHOiQO/gG+fF4WV5Tp0jRcqH440h19CKH77k6AExth3lY
X-Gm-Gg: AR+sD12TkYTaUsrgpb2FHVI0XJDMNHw2hCZM5T8tdRsHb7SapV/h7wDm7pRqvT/Oa5o
	2nlEF717ROfCgdOFZU0l/jLM6qau7l4xaywHWMmpwKx6oZ6Aw2yLNsIFEihIJjxyNxR7G01AfuM
	fdhM96qUTekWfbxlaDekjdirHSO/wsDGDpvkzYn9Ail4ZGBnCUY8D0OM705CQF5aaPcv9ZoagI4
	XHkSjw2hyIDOQCV4mEKgvfyuJ4y0+MxeYughyqvXrcJR3syCZ14iUJtCjKIuYEp2jwsMjaDci07
	FjeOhkIbuvOAWFIXfd6w/ZON0X+tRqUt+TF8EpRJH50WOwVXj5l/0PRLpKquPrNWYU+JIEAgT4N
	Z0hCf7KWldWoPasvYqwZ59bmpNRFepoYVI0RHJR35BZiYWKKkSrI2zNqk/mySnZSrHCkxs9EqOS
	9VzlXk37ttcWs80O5bD5J4tyEHCunWeqaPj6N8bzHmMuKkdRrrguKB/rYswce2S0O1/VCk8AFo4
	5QnupOcmcMzd1eCqyRsz8mXAIlR8u9bU6ADhG8FKrJvgIaWxW3Pa8p3N3LujM3btM54iOJrVtD9
	2P63JtkSTBQCnUMYw/NL70JPMtPM8+LQ7qAwGwG+q+x4o6qzQUPSHktMIb5PLctJxFJtb2t5DaV
	9uAi+8YsH
X-Received: by 2002:a17:90b:49:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-3903c550de1mr698053a91.1.1785878033770;
        Tue, 04 Aug 2026 14:13:53 -0700 (PDT)
Received: from ?IPV6:2409:40e3:40f2:e504:7c90:c2e4:caf2:ba21? ([2409:40e3:40f2:e504:7c90:c2e4:caf2:ba21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fede7ad70sm1977647a91.15.2026.08.04.14.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 14:13:52 -0700 (PDT)
Message-ID: <a81fc1be-914e-4045-87a0-cee88257fad5@gmail.com>
Date: Wed, 5 Aug 2026 02:43:47 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2 6/7] builtin/repack: add safety guards for
 --drop-filtered
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
 ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-7-r.siddharth.shrimali@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <20260730174153.9949-7-r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/07/26 23:11, Siddharth Shrimali wrote:
> --drop-filtered removes local promisor blobs. That is only safe when the
> repository is not mid-operation and when the blobs are not actively in
> use, so add two guards, both skipped for bare repositories which have
> neither a worktree nor an index.
> 
> First, refuse to run while a merge, rebase, am, cherry-pick, revert, or
> bisect is in progress. During these operations the working tree and
> index are in an intermediate state, and rewriting packs and deleting
> objects underneath a half-finished operation is unsafe.
> 
> Second, refuse to drop a blob that the current index references. Such a



Index guard looks good to me. Same idea as on the RFC.

Thanks.
Siddharth


> blob is needed by the working tree, so dropping it would only cause the
> next command that touches the worktree to lazy-fetch it straight back,
> reclaiming nothing. The offending path is reported so the user can see
> why the drop was refused.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>   builtin/repack.c                | 47 +++++++++++++++++++++++++++++++++
>   t/t7706-repack-drop-filtered.sh | 36 +++++++++++++++++++++++++
>   2 files changed, 83 insertions(+)
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 9a15ab1f2a..2339bcaac4 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -17,6 +17,8 @@
>   #include "list-objects-filter-options.h"
>   #include "oidset.h"
>   #include "hex.h"
> +#include "wt-status.h"
> +#include "read-cache-ll.h"
>   
>   #define ALL_INTO_ONE 1
>   #define LOOSEN_UNREACHABLE 2
> @@ -309,6 +311,28 @@ int cmd_repack(int argc,
>   		if (!repo_has_promisor_remote(repo))
>   			die(_("--drop-filtered requires a promisor remote"));
>   
> +		/*
> +		 * refuse to drop objects while another operation is in
> +		 * progress. the working tree and index are in an
> +		 * intermediate state, and rewriting packs in a half-finished
> +		 * merge/rebase/cherry-pick/revert/bisect is unsafe
> +		 * bare repositories have no such state, so the check
> +		 * is skipped there
> +		 */
> +		if (!is_bare_repository(repo)) {
> +			struct wt_status_state state = { 0 };
> +
> +			wt_status_get_state(repo, &state, 0);
> +			if (state.merge_in_progress || state.revert_in_progress ||
> +			    state.rebase_in_progress ||state.bisect_in_progress ||
> +			    state.cherry_pick_in_progress ||state.am_in_progress||
> +			    state.rebase_interactive_in_progress) {
> +				wt_status_state_free_buffers(&state);
> +				die(_("--drop-filtered cannot be used while another operation is in progress"));
> +			}
> +			wt_status_state_free_buffers(&state);
> +		}
> +
>   		write_bitmaps = 0;
>   
>   		/*
> @@ -324,6 +348,29 @@ int cmd_repack(int argc,
>   		if (ret)
>   			goto cleanup;
>   
> +		/*
> +		 * refuse to drop blobs that the current index references.
> +		 * dropping such a blob would cause the very next command
> +		 * that touches the worktree to lazy-fetch it straight back, so
> +		 * the drop would reclaim nothing. bare repositories have no
> +		 * index, so the check is skipped there.
> +		 */
> +		if (!is_bare_repository(repo) && oidset_size(&drop_oids)) {
> +			struct index_state *istate = repo->index;
> +			unsigned int i;
> +
> +			if (repo_read_index(repo) < 0)
> +				die(_("could not read the index"));
> +
> +			for (i = 0; i < istate->cache_nr; i++) {
> +				const struct cache_entry *ce = istate->cache[i];
> +
> +				if (oidset_contains(&drop_oids, &ce->oid))
> +					die(_("cannot drop '%s' (%s): it is referenced by the current index"),
> +						ce->name, oid_to_hex(&ce->oid));
> +			}
> +		}
> +
>   		if (dry_run) {
>   			struct oidset_iter iter;
>   			const struct object_id *oid;
> diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
> index b3e493e851..dabed97541 100755
> --- a/t/t7706-repack-drop-filtered.sh
> +++ b/t/t7706-repack-drop-filtered.sh
> @@ -140,4 +140,40 @@ test_expect_success '--drop-filtered removes the promisor blob locally' '
>   	grep -q "$SMALL" present
>   '
>   
> +test_expect_success '--drop-filtered refuses when a merge is in progress' '
> +	test_when_finished "git -C repo merge --abort || :" &&
> +
> +	# creat a conflicting merge so wt_status reports it
> +	git -C repo checkout -B mergebase base &&
> +	echo one >repo/conflict.txt &&
> +	git -C repo add conflict.txt &&
> +	git -C repo commit -m one &&
> +
> +	git -C repo checkout -B mergeother base &&
> +	echo two >repo/conflict.txt &&
> +	git -C repo add conflict.txt &&
> +	git -C repo commit -m two &&
> +
> +	test_must_fail git -C repo merge mergebase &&
> +
> +	test_must_fail git -C repo -c repack.writeBitmaps=false \
> +		repack --drop-filtered --filter=blob:limit=1k --dry-run -a 2>err &&
> +	test_grep "in progress" err
> +'
> +
> +
> +test_expect_success '--drop-filtered refuses to drop an index-referenced blob' '
> +	# create a large blob, add it to the index and make it a promisor object
> +	# so the index references it and enumeration picks it up
> +	test-tool genrandom idx 4096 >repo/tracked-big.bin &&
> +	git -C repo add tracked-big.bin &&
> +	OID=$(git -C repo rev-parse :tracked-big.bin) &&
> +	printf "%s\n" "$OID" | pack_as_from_promisor >/dev/null &&
> +	delete_object repo "$OID" &&
> +
> +	test_must_fail git -C repo -c repack.writeBitmaps=false \
> +		repack --drop-filtered --filter=blob:limit=1k --dry-run -a 2>err &&
> +	test_grep "referenced by the current index" err
> +'
> +
>   test_done

