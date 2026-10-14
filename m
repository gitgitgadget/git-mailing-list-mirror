Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232383F8ECA
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997387; cv=none; b=eO4VkJrlH+mf3Xire6FZHm8Oe/qDnVFewkHDjBTshw4VzggKUXmzASY0ulmTQAFlT+7yGHJ/hjrK2iSrAbE9vU26BQuBqfrv5QIt4Y5+cueFtf85CqnmxA45GJpm6+/6/MQHpgoc6mntfdTXXyZCJoZ1FVYs78Po+06xLS4L5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997387; c=relaxed/simple;
	bh=higeM6wdcn494A4Bl3uelvKV/sR6agv7BXfr/6kb6H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDJa13V0tSi0DCEXXHnbS8XfIlxCfzTPBv5FVlboR2XzpKcIgKJYRUz3C4sZl0fuFbUtwHMyRjLq18VzLYcqTnAjKTTilM1FDwsh99ak03nESSwdspSY1P7W1hXoxQz2m36aKoOrcEyOGle5pPXB+8VE2rwPFI9sOxYUJ4+lMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5oYqf1R; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5oYqf1R"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6dd059478dcso2942824eaf.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997385; x=1792602185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ue84xUnNW1hLOd65fczukC98Y/uZDBWKB53sgYZWo8M=;
        b=V5oYqf1R5KahSRRxSZcPCK/+ADBHPVu6ifD+EXOL2YQtgU66AQuoZVpBq+lU5FQdJU
         w9D3G/cHrUmtk2LyvzSdKhIPLp5QvIKM6uAXCSSGQhma7SIQ8VDgtsG2xpYnWT+fZU2H
         Bhx9mofyiTmpVGaKsg+oDk1jgtXLZJeBGVvzmXnPsdeXtyNuU11VVvANpG/awXADpQcL
         GUUFhG8qA6p5dFAH6BDX/aL4lnrAAjKaVV/XA0EVH2hb+tZaDK44MvhHouM00ugBBjCz
         B5kOnqvmDhKuYXUZCW/CMYhGfDGNAvDHn84NZtWE+Hn2tf5owaNfKbjFBvsgt8FTbokn
         a7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997385; x=1792602185;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ue84xUnNW1hLOd65fczukC98Y/uZDBWKB53sgYZWo8M=;
        b=zTtYo56foVfq1c+SJv10Ndho2Y6MAkdYeaWEE3KTD6p+fBYzd/vyepF3sVMmHy7GJe
         6nEKZpQc7zXzgm1l495MiUveuj4jqoP2/S3w6ztHNRmMLkECXeamYIeMGvWhZLy1Q/4f
         eWYj7evGny1jB5/noKQaqzTCQu1g6YWfw1Hid4aqt2zLbBUuSCmKu09pE+Mi7A0BFUHW
         8QvZBsDPKYmd1G1MVknX7vRqHvvSC5uqaMtrwnVCoK0x8/PK4pbk9OhlCk/OIRcy2jjI
         4LZvATkrD0LuVo89iQNcnnCM5l/tr5v7Y6rP249L6zd9VGkPZXCoeBBhFbIGHo9TMh0n
         9ElA==
X-Gm-Message-State: AFq9FYKxTGns13NRPz7MP9agHdagfTgIMkd8KezLLSUHEicpUYAwFjGW
	ygjQtDLxZ/xKMfgiIrBGJvuzgsMGRO+0+CgaIrZ75B8EzEWO9VSatXs0pMX1SA==
X-Gm-Gg: AYBFou27/pAy8whHB24iGGKwCbbH2uOP+x7qSrF1X+Yit7ZxIZTfDbBszDYP2ATmDSE
	HQXmaF2keCRUil28bFYrU7Cs6oLOaR73O2JGspHIsjMfaZs5aChlOaiC0lliV/4qmw6+f0QuY3f
	P788DgqeKWVPS7V+AdAz6L7EUzkgos3HQfkHHRRkPAbLNd4R2WSAPIJ/VfUZNp34RX/bCeNe2tT
	+2FmIYB+revI6j3rffcsR3hkHHD82apxadOLhmyHwYhPJq3yEgkfp+BCJlB5YsKN9sTUdkgu9Lj
	lZ587khJBCGYbVx1VRwROqAWL96S5ad9ocQiLz7vSXQODZH6lEIIAyD7cT2x+hNbMtn7waQKwsC
	1Zmv6cKolwBOJLgCZXmtY1fuf9TPIpTr0KfnA0xu/waVMnsZSB34DPkVNhYtYeEQJV2FXYMMUoY
	83nt1aFCjDopg+Edi6GvEXzU6GMWVZYHk8cvZYTt1tSy7R81uyIN3NsMbOIdIHgU+hJAEiZSjpb
	6PaFvtGPNvr5TpRQ9+PLDw=
X-Received: by 2002:a05:6820:2215:b0:6f8:5abd:b5fa with SMTP id 006d021491bc7-6f85accf929mr6411200eaf.28.1791997382978;
        Wed, 14 Oct 2026 10:03:02 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6f634860481sm7822378eaf.13.2026.10.14.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:03:01 -0700 (PDT)
Date: Wed, 14 Oct 2026 12:02:54 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] connected: do not walk alternate refs in deepening
 fetches
Message-ID: <as-wOIAxpdnVVc8h@denethor>
References: <20261014103507.35317-1-iwiedler@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014103507.35317-1-iwiedler@gitlab.com>

On 26/10/14 12:35PM, Igor Wiedler wrote:
> The connectivity check spawned by check_connected() uses
> 
>   git rev-list --objects --stdin --not --all --quiet --alternate-refs
> 
> where 39b44ba771 (check_everything_connected: assume alternate ref
> tips are valid, 2019-07-01) added "--alternate-refs" so that the walk
> from the fetched tips stops at the refs of any alternate object store,
> on the assumption that the alternate is already fully connected.

Ok, when performing a connectivity check, we assume that an alternate
repository is already in a valid state. By excluding alternate refs from
the git-rev-list(1), some time can potentially be saved.

> That only works because "--alternate-refs" comes after "--not".
> cf1e7c0770 (fetch-pack: write shallow, then check connectivity,
> 2018-07-02) drops "--not --all" for deepening fetches, since those
> need to verify the whole chain up to the new shallow boundary rather
> than stopping at refs we already had. For such fetches we therefore
> run
> 
>   git --shallow-file ... rev-list --objects --stdin --quiet --alternate-refs
> 
> with the alternate's refs as positive revisions, and rev-list
> enumerates every object reachable from them. Unless one of those refs
> happens to lie inside the newly fetched shallow range, where the
> grafts cut the walk short, that is the alternate's entire history.

Ok, so for deepening fetches, the `--not --all` is intentially removed
to allow the newly deepened commits to be verified. A consequence of
this though was that the `--alternate-refs` changed from being excluded
to included unintentially. Makes sense.

> This is slow for setups that attach a large alternate to a fresh
> repository and then do a shallow fetch of a ref that is a few commits
> ahead of the alternate, which is how CI runners share a clone of a
> big repository between jobs. With a 7M-object alternate (a bare clone
> of gitlab-org/gitlab), "git fetch --depth 1" transfers an empty pack
> in under a second and the connectivity check then takes 227s. Without
> the walk over the alternate's history the same rev-list finishes in
> 0.0s.

For large alternate repositories that contain lots of additional
history, this certainly could result in a significant slow down.

> Move "--alternate-refs" into the non-deepening branch next to "--not
> --all", so that a deepening fetch walks the fetched tips down to the
> new shallow boundary without looking at the alternate's refs at all.
> Negating them instead would stop the walk at the alternate's tips,
> but the reasoning of cf1e7c0770 applies to them as well: an alternate
> that is itself shallow, or a partial clone, has refs without the
> history behind them. fetch-pack sends the alternate's refs as "have"s
> in that case too, so the server omits everything behind them, and a
> check that stops at those refs does not notice that the objects
> between the alternate's boundary and the new one are missing. The walk
> down to the boundary is bounded by the depth, so this does not bring
> back the full history walk, and objects that exist only in the
> alternate are still found through the object store.

Naively I assumed we would still want to negate the alternate refs, but
IIUC for deepening fetches we may fetch objects that a shallow/partial
alternate repo _could_ have, but doesn't. Thus we need to perform the
object walk up to the new boundary. That makes sense to me.

> Add tests to t5618 that check the arguments of the rev-list child via
> GIT_TRACE2_EVENT for a regular and for a deepening fetch. The result
> of the check is the same either way for a complete alternate, so
> there is no behavioural difference to assert on. The difference is
> only in which objects are walked.
> 
> Signed-off-by: Igor Wiedler <iwiedler@gitlab.com>
> ---
>  connected.c               |  2 +-
>  t/t5618-alternate-refs.sh | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/connected.c b/connected.c
> index 929b9bd28d..d8bfb3dbf2 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -127,9 +127,9 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  			strvec_pushf(&rev_list.args, "--exclude-hidden=%s",
>  				     opt->exclude_hidden_refs_section);
>  		strvec_push(&rev_list.args, "--all");
> +		strvec_push(&rev_list.args, "--alternate-refs");
>  	}
>  	strvec_push(&rev_list.args, "--quiet");
> -	strvec_push(&rev_list.args, "--alternate-refs");

Ok, now the --alternate-refs option is only used in non-deepening
fetches. Looks good.

>  	if (opt->progress)
>  		strvec_pushf(&rev_list.args, "--progress=%s",
>  			     _("Checking connectivity"));
> diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
> index 2fb6d549d3..237eaba85c 100755
> --- a/t/t5618-alternate-refs.sh
> +++ b/t/t5618-alternate-refs.sh
> @@ -58,4 +58,17 @@ test_expect_success 'log --source shows .alternate marker' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'connectivity check of a fetch excludes alternate refs' '
> +	GIT_TRACE2_EVENT="$PWD/fetch.trace" git fetch origin &&
> +	test_subcommand_flex git rev-list --objects --stdin --not --all \
> +		--alternate-refs --quiet <fetch.trace
> +'
> +
> +test_expect_success 'connectivity check of a deepening fetch ignores alternate refs' '
> +	GIT_TRACE2_EVENT="$PWD/deepen.trace" git fetch --depth=1 origin one &&
> +	test_subcommand_flex git rev-list --objects --stdin --quiet <deepen.trace &&
> +	test_subcommand_flex ! git rev-list --objects --stdin --alternate-refs \
> +		<deepen.trace
> +'
> +
>  test_done

Ok, the added tests here are simply validing that the spawned
git-rev-list(1) command is using the options we now expect.

Overall, this patch looks good to me.

-Justin
