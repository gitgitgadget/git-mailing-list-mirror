Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537527;
	b=0ZB3C/Ng70sJTshYq4JJzqclL12IW9RxYNh1sF3GjmdOieqLoJVqyGqdxthpEmEURKoy
	 84LEeNd7y+e1VEryJUQlmnsOCXkhejri8tNEC9fx4fhgaBOBIFh69ohx9mNe7qfdrTrCf
	 sJfnp4LfRgrzr/mynuNJwmtRihPlBEQ97LhxRNADJDlFti6EvOB7OsGptx34kQydnqIS6
	 +gxwnlxh8raFMuB8yXDMoqeNfmNkqcb2Hb++um3wTdM6rKV+s3pOEzd0kktsrMq5wzR1C
	 owZRcPeJN7EoTpMtmuEgoEUJN2Jk2Lpxcz6PTQl4ohD4/Wrip/87S5UrPe2VWtBDi2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=4puN9WG0gm2v1KyxQf0Bajma3z9kh/P+L6l4iKwbiP0=;
	b=2Vn9KmqED5mkUcVOvPHoKcXLC+zRVN2EMQnjOix9TQPRo3ICMHgzPEFEwTBXWk36mB6l
	 DZW3P5Jn3zVYVdWkRzaN6tUczJ8saDoClFZ7UWuSmnE4OWaEzG1uuLlk6ohgA7rLFH8tl
	 oG3LqDNDhXllZhGJITxVO+cPfoJChW/qVvuuFw6EMKCw+F9RLUSZZ3qRfDz7yxYjbdIUj
	 Cg0ccT+9HDWjXy0jjXv1whpD7+2EafaoTsypa8yJzelE4355p4wJJ5ZRZzprWm65I5TLP
	 mIxXnDWe9Ph1UFFGaHh5rjq2rheuTYXKVC275Fgd3u3D6rG72NkTb4bJWbSxJ6uF8gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rhkDdbWC;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E5A606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E5A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rhkDdbWC
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-483a66818edso122753fac.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792537526; x=1793142326; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4puN9WG0gm2v1KyxQf0Bajma3z9kh/P+L6l4iKwbiP0=;
        b=rhkDdbWCUUHZhqaaOCMROddjt7QLodq/Oe1+vZT+Q4epukExV4ebmbSMD+3OoKrwdh
         3VDYA2Tfl4Y/9M2Zq/CORimSjYExokyaQWmLu8kJxoYzUdadIJuuZBlz6RkmKP2ZwSaz
         //8LrLvacvXMN3ShzejwbmqujKMZrOab13UoFocyKs0bS3pGcX3GKyrDP6RCTVWgRUc6
         +eGPZn3RUNAEqWfCywjAysHEj07MOBRFFoFIi/SlDBgeOhlYzCrwYk+oeJtwGasuU1Dn
         Nfk+6PlceHx0r64gqEw6S4eIiG3uwFF+5Qx+FcIWzCYEYK5TBOgaecYkL9OMkXL0tch5
         iStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792537526; x=1793142326;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4puN9WG0gm2v1KyxQf0Bajma3z9kh/P+L6l4iKwbiP0=;
        b=BK9RNvZiMyBbL7QIppzbOfMtljty7Xqxoqtgj6wNH0gtMIurdYUpF2Rp8qUBg3JiPw
         7zw3ZuEtwPOFoJfOcZ5Ej3k3Uf7v8uCU/bx+CQbazrOMUJidKuNEDXqR6kEDc26TMl5K
         JpGOFXFOHqmyfslqbA+3z1mEli/qgI1dN+IYgJQl7XFwWEKGApupHobpSGOx7osfqYv9
         0WtrARfmfZ2WXuC5gEdKVeUv5RJEXVNvNuZUazee593/Jw0dRPkCqC2mOCxcs9r1KI8Y
         s5psRroN6VMfGPdW7nzkMm4addhiHo6CpT7nVwhEk74eluppZY0932ssw/KwjNePynUH
         wKkQ==
X-Gm-Message-State: AFq9FYKe+mVx1WL0VuV69Tm0AEhSbEYRNgl7hEA/1sDwmlTMPYnWk2ba
	NRc4/06ppKfoKrvZUT5YoryK8wCKPoHNNOyyd5RrD7VOojW03YWlpOKM
X-Gm-Gg: AYBFou2U9IjdFqaFXADxrF3tR3fdtL6FwLe2aCCBF4PFVDVy1tacPL1KuPNRxJa81ym
	9Il5r5o6v6g/Jj+fnXE47W7JQhmOYw2kFG189cG3kJV4YZOiCV0N2OBPvCtcJ9gfMHvb2E9e00b
	alC714fnzwF2CIsb3dwLsJJV+g2k3PfnFyDlguOHqChTG2Ho/e8N9NgeJ6Q7tptC6ZrLmp4BN8p
	muA+Z//bdHyllZk9buYfF6tJ2OmZbt+TZBWVH65D4AvuV1Nl5MsvEHgfhgx+ZH9wzrGaKTO2gso
	FN3/WBkAxeBq/IsHpCwIglDO4omt8geqFRSz345kxo0V5htFchdQhe4A6bWvL5SbnloPlKtNvFU
	bqolklBtA+1lz7USF8ap/BfEy/PXVCgBIBLm95ovx4dnKqcbhwGNEL1w1g6LdP3UAEqRh7Nbkaz
	9cp9YDGJIoBVPkLxIiz2MOJCAgDxcAKZEhWgNEF0vJqPu3HmVWYjyXh36wpDGZZ0fFz0tVM5CHS
	XTgs7kQIXElILfirdw8uDQ=
X-Received: by 2002:a05:6870:912a:b0:494:8d38:437b with SMTP id 586e51a60fabf-4a7dc21e927mr116444fac.37.1792537525656;
        Tue, 20 Oct 2026 16:05:25 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d61d6645sm679055fac.12.2026.10.20.16.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:05:25 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:05:22 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	Mitja =?utf-8?B?QmV6ZW7FoWVr?= <mitja.bezensek@login5.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] fetch: commit references fetched before backfilling
 tags
Message-ID: <atftdOihoUHTdvfu@denethor>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com>

On 26/10/15 11:24PM, Karthik Nayak wrote:
> In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
> fetch code was modified to use batched updates to provide a good
> performance improvement. Batched updates are used both for the fetched
> references and to backfill tags.
> 
> When using batched updates, the references aren't yet committed to disk
> when we start backfilling tags. This means in situations such as shallow
> fetching the negotiation during backfilling tags, the newly fetched refs
> are not available for advertisement in the 'haves' section. This can
> cause the server to send all objects the client already has.

Ok, without the earlier fetched references committed, the backfill fetch
may ultimately ask for objects it already got. Make sense.

> The issue always existed when the '--atomic' flag was used, as both the
> regular ref updates and the tags need to be part of the same
> transaction.

So IIUC, you are saying that this problem already existed prior to
0e358de64a, but only for atomic fetches. Furthermore, this patch doesn't
fix anything for atomic fetches as they can only use a single
transaction.

> Fix this by committing the previous batched update and initiating a new
> one for backfilling tags. Use a separate error variable for tracking the
> reference updates: One, it ensures that errors from the regular ref
> updates don't cause a total failure. Two, if starting the transaction
> for backfilling tags fails, only those updates are not made to disk. The
> initial error is now printed straight away to clear the buffer for
> further errors.

Naively, I think it would be nice if it were possible supplement the
backfill fetch "haves" with the non-committed references in the pending
transaction directly. That would avoid having to commit the references
in the middle and probably also fix it for atomic fetches too, but I'm
uncertain if that would be a simple or reasonable thing to do.

Committing the intermediate state here does in part fix the issue, so it
may be a good first step regardless.

> Add two tests, one which validates that the 'haves' are filled when
> backfilling tags. The other, to test that upstream is still set and tags
> are backfilled even if the main ref update is rejected.
> 
> While this does make it a little slower than master, due to two
> transactions:
> 
> Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = master)
>   Time (mean ± σ):      82.1 ms ±   3.3 ms    [User: 60.2 ms, System: 24.4 ms]
>   Range (min … max):    77.4 ms …  89.4 ms    33 runs
> 
> Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
>   Time (mean ± σ):      82.6 ms ±   2.4 ms    [User: 59.3 ms, System: 25.2 ms]
>   Range (min … max):    78.1 ms …  88.7 ms    31 runs
> 
> Summary
>   fetch: many refs (refformat = reftable, refcount = 10000, revision = master) ran
>    1.01 ± 0.05 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
> 
> It is still faster than not using batched updates:
> 
> Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)
>   Time (mean ± σ):      1.468 s ±  0.041 s    [User: 0.839 s, System: 0.587 s]
>   Range (min … max):    1.427 s …  1.558 s    10 runs
> 
> Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
>   Time (mean ± σ):      84.4 ms ±   1.7 ms    [User: 60.9 ms, System: 25.8 ms]
>   Range (min … max):    81.4 ms …  88.6 ms    29 runs
> 
> Summary
>   fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD) ran
>    17.38 ± 0.61 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)
> 
> Reported-by: Mitja Bezenšek <mitja.bezensek@login5.org>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> The issue was reported by Mitja Bezenšek on GitLab's Git repo [1].
> 
> [1]: https://gitlab.com/gitlab-org/git/-/work_items/799
> ---
>  builtin/fetch.c  | 38 +++++++++++++++++++++++++++++++++++---
>  t/t5510-fetch.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2decc6cfd..34fc37b58a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1923,6 +1923,7 @@ static int do_fetch(struct transport *transport,
>  	struct strmap rejected_refs = STRMAP_INIT;
>  	int summary_width = 0;
>  	int follow_remote_head;
> +	int commit_ref_ret = 0;
>  
>  	if (tags == TAGS_DEFAULT) {
>  		if (transport->remote->fetch_tags == 2)
> @@ -2076,6 +2077,30 @@ static int do_fetch(struct transport *transport,
>  		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
>  
>  		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
> +
> +		/*
> +		 * As negotiation only reads references from disk, commit the references
> +		 * fetched so far, so that the backfill negotiation can advertise them as
> +		 * 'have's. Otherwise the server may re-send objects.
> +		 */
> +		if (tags_ref_map && !atomic_fetch) {
> +			commit_ref_ret = commit_ref_transaction(&transaction, false,
> +								transport->remote->name,
> +								&rejected_refs, &err);
> +			if (err.len) {
> +				error("%s", err.buf);
> +				strbuf_reset(&err);
> +			}

It looks like we log the error and continue even if committing the
transaction failed. Is there a reason we would want to still try to
start the next transaction?

> +
> +			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
> +								  REF_TRANSACTION_ALLOW_FAILURE, &err);
> +			if (!transaction) {
> +				free_refs(tags_ref_map);
> +				tags_ref_map = NULL;
> +				commit_ref_ret = -1;
> +			}
> +		}
> +
>  		if (tags_ref_map) {
>  			/*
>  			 * If backfilling of tags fails then we want to tell
> @@ -2099,9 +2124,16 @@ static int do_fetch(struct transport *transport,
>  	if (verbosity >= 0)
>  		summary_width = transport_summary_width(ref_map);
>  
> -	retcode = commit_ref_transaction(&transaction, atomic_fetch,
> -					 transport->remote->name,
> -					 &rejected_refs, &err);
> +	/*
> +	 * The transaction may have failed to initialize, meaning there is nothing
> +	 * to commit. Carry forward with other operations in such cases.
> +	 */
> +	if (transaction)
> +		retcode = commit_ref_transaction(&transaction, atomic_fetch,
> +						 transport->remote->name,
> +						 &rejected_refs, &err);
> +	retcode |= commit_ref_ret;

hmmm, the error paths here are confusing me a bit. If the transaction
failed to be created in the first place, wouldn't we want to stop
earlier on?

Thanks,
-Justin
