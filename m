Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAD55D88A
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928109; cv=none; b=CnCjz9PotzXgcSxIrCxEtu8aMIJtxOl8VtrZdwappsw/j3PmktJU1kAYElBUZ5EBOgE8pMAMCuxfZcTVMRRWiAaDBgD/Wswk5ADreVgj3ff8SXt0cVy24bPgWTTg9R+cyFTJ9PsF2Mwif8f3Q7ytMs7TbwcAd8al9N+NHh9yMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928109; c=relaxed/simple;
	bh=9guKryHv9lH8/76knaMrBc8J6tmX+KBDXjaOicp6N2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cp6BeGrILv78xkUg5Ft00DiBi5gkAGL9ajveixupvV5SKka/F0DakffFgIyXN/220f3WdBqIhoALvKHUSDY6br8pCBF/Id9SDiTqbZQlMpnXtp5z1KKupD1Ui+pYmGgjDl+PLgxHoV1uMySC/k24IFbJ8Sh5PBdB/JA4C65KgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXV2ED3m; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXV2ED3m"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aa9606ddadso286879eaf.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791928107; x=1792532907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XvUVULnVsnCCDDgn+SMnph/KnbAVty1hbv7nZ9NG/g0=;
        b=fXV2ED3mia0Yc/EVDeeYV1xDb81Gh5/BzC8ZSBcDyPDTNxQmrNO5TfhPvlaiktbsbD
         I+QSja+5rPk4pLz+BHud8xdEZoHLTX14SBU5+quhK1ihQAWpR50zueR95Mh7LJaiylje
         98dtqp5p1YOQw9ycR1B+L1R+ity7ZHLmxlLYyj9rchwZLVyrgqxglo9efdnzfdWKZ6NP
         rJxUZLqOA2W0H8xxmzfD9/XplJenjm2VC+3k6+WbovAB9/y00d4atfAeC9JX1G7XG1xF
         EhoYtfWobodh1Cx5SKh79eYp8oGi/dj6hL4ts2jvC0TqTiyVPHdiSCkFFai76P3sdvr6
         94tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791928107; x=1792532907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvUVULnVsnCCDDgn+SMnph/KnbAVty1hbv7nZ9NG/g0=;
        b=P76w9NfP1dcVuhlt2AfBRy7HffljaXHk313k9LbdgEofa4Jf8Wq7yp/2HaChu5QQFl
         0QN9DRw070L6tY7AJocozaCo4vMLL3Qukp8FzfeszJJae7zb6xGVJXkbHAOWzok6Bgac
         JwL9u42Ikh5NSb22kAijh5sjF9eQdLzHmR9rChkhuGfrA7B41cm+n7gRIwgO0TsD8t88
         H0JZsp3l9AtGVEWZgRUupXphhcUiqrG0Z0h1cQ2IbZr0UxKiG2D0tERjzI8AHfESz6xh
         xaP/S2g875pp9RKhmsQAF3N9f0wYE75G8PnK5lA9g8YSmVP+iAqs6o4V/Z/UlRnjuP92
         sE+g==
X-Gm-Message-State: AFq9FYLSBlr+rHgQxJUylMWq7qmBqWFwInGh+4sKy6/CAB5pExskDstM
	6nkNgR768ebbQ5eLb1XNJUdJgAgsvVZ3mmhRBSmuQ9UIZ/PU2xVmB5tKQHl0xw==
X-Gm-Gg: AYBFou2UpGEJGW2VKFla2HcMJN1SpWEavgMyzQEZIiEiIReAO893aybeQoTnF/2ExXn
	xfTgU9H5qb+6b7V/0kw4wi5YwuTvLRMp5asD7LszuiJzpWrj8epQAp7azTpDouD7L9BnmAu9inb
	fC+rfSxboUlsEkPJsd81JJTxwZF8cnMIwanH+Gx2MW1h1Jds5c/UW5jFEW+WfB2weC9nVV2PnJn
	fPD9oPKhUj3neK86PVCs5swrG/vlHfKacQDUZir8aMBqw3sNeEMt2FQjXXiJs5hFcLNYElQA+eN
	TBJ0pEiVjaxfCERmffOaDBeg/d+R5qkvzuPJ7c45AlxFgOAZDdEcfSzAHgY/GNt5Z3/spteNvci
	wo9AP9Ajh1xyApaSJfDdEUFqSfix0qcMOFJ0Y2pQ7a/xgW5vv3EnnJoYdGEpdiYiM+ZlvUTk5Jf
	MLyELNXpnP1ZvBpiyldwrOg2dgf5+mFGdHFytVJF8YH8pyZZ5KBekm0WmDnjxo6KUE/4pxxHx6V
	v4IRoqS7lFDktmlg3ySNi/NxAIFNvIyWw==
X-Received: by 2002:a05:6820:2088:b0:6cd:3fec:de83 with SMTP id 006d021491bc7-6ef1115c9camr9792054eaf.89.1791928106809;
        Tue, 13 Oct 2026 14:48:26 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830384c4985sm12722593a34.8.2026.10.13.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 14:48:26 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:48:23 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 4/5] odb: remove read loop for found objects
Message-ID: <as6kNufOqLFeBoNh@denethor>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-4-b7030ff2b26f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-4-b7030ff2b26f@pks.im>

On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> Before moving alternates into the "files" backend we had to handle
> alternates in `do_oid_object_info_extended()`. This made the retry logic
> somewhat complex, as we had to juggle reloading of the sources, the
> second read and fetching missing objects. And to handle the potential
> retries we loop around that logic multiple times.
> 
> Nowadays though, the reload and retry logic are located in the "files"
> backend itself. Consequently, using a loop is a bit on the heavy side
> and makes the code harder to reason about.

The "files" backend is now responsible for retrying a read if it need to
reload its packfiles. IIUC, this means that we should only expect
missing objects from partial clones. Only if we want to fetch these
missing objects from the promisor remote do we need to retry.

> Simplify the logic by removing the loop. Instead, we explicitly re-read
> exactly once after having fetched objects from a promisor remote.

Make sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index 69a4c203bc..095183aec0 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -265,7 +265,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
>  	struct strbuf corrupt_err = STRBUF_INIT;
>  	const struct object_id *real = oid;
>  	enum odb_read_status ret;
> -	int already_retried = 0;
>  	bool corrupt = false;
>  
>  	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
> @@ -277,38 +276,39 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
>  	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags, NULL))
>  		return 0;
>  
> -	while (1) {
> +	ret = odb_source_read_object_info(odb->source, real, oi, flags,
> +					  &corrupt_err);

Here is try to read the object, the backend is responsible for handling
any retries internally that it cares about.

> +	if (!ret)
> +		goto out;
> +	if (ret != ODB_READ_NOT_FOUND)
> +		corrupt = true;

If the repsitory is correct, does it even make sense to continue to try
and fetch the missing object? I wonder if we should set `ret =
ODB_READ_ERROR` and `goto out`?

> +
> +	/* Try to fetch the missing object from a promisor remote. */
> +	if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
> +	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
> +		promisor_remote_get_direct(odb->repo, real, 1);
> +
>  		ret = odb_source_read_object_info(odb->source, real, oi, flags,
>  						  corrupt_err.len ? NULL : &corrupt_err);

Here we read the missing object after it has been fetched. This is only
case the ODB layer needs to care about retrying itself. Makes sense.

The rest of this patch is functionally the same just without the loop.
Looks good.

-Justin
