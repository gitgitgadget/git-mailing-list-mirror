Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3B4779A4
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276149; cv=none; b=DpOLUO/lEkXTvyAK1Z+Y4vwtyGqhLqY+n9+yIKevBowldFz+mbuYdA93IzKz0uOeIf4b2GJfCwreXu8t3OAklbADRsLmajLE8GCZSL7BLUC8B2RBjS4EMoTLBDli3LHao9NsI5xss088wpeZupxCbCMn9aSRPg0Wt69mGb0PhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276149; c=relaxed/simple;
	bh=Ujz6y0ze57vLRsvZzbTB3+oYjgGxckBNnNZfWZaHIz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2lZgzTQR7ohSchNSDAW7qRjgMVZU52zHFLNoKG9KtU41Ff7k8fWAaeh5EjxZXgd7mna27eeHQSu7yii08n5DksiVqrauvDjf1t6Ok7QUnhJrZJ6EegeFwtEnyUGjG0SF8IkxqcaR8Ja6uzLz8B4AdGkC3MC4QlZRMD0BBWuzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUvqx3is; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUvqx3is"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a198cdc4e4so196308eaf.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785276137; x=1785880937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K6ZqsQgZnahm/h0q4epqUojWD0L5H/nU6D9aVt4V86Y=;
        b=nUvqx3is93LNqvtVXEv6rwbw3T2PsoKJBUD6OEYHgiKlMe50khUmVuLWNT1fIWRYg4
         GFu4diK5QQq1yX1itTjCY+StFLFR+8VcOiFOxv2IM8/PkV5ptBKnxVDBUERjd7cs7Z8k
         42vxRvu95abwuobUU3DDF1yqtLC26TAbvN9XuAqlkRwmibRJFlv0IR8tCIeCiMBIF8xj
         kHIJ9ATbWwQH/5kZtmWUW5nJU9vmK+L8N0aqvRd53KXAmRXvTeJ5nhC0rEWRqjxsEH4g
         uaXQ5UtpLfwCCwkmZWueQEMKrkrrEaheOpngHloAvhbgg4W0ES5JBgYUuLsUMaW9WgtT
         XT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276137; x=1785880937;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6ZqsQgZnahm/h0q4epqUojWD0L5H/nU6D9aVt4V86Y=;
        b=Z6gI8eW+UlN4AbUs/e+O7napUj+e0Ms+qVJhYPpqPg4vCSk/MSbIRXNb12Wl+Tj+xI
         2pFyOlhCMJUEr7a/nVI9jRj3mqQYxfVf6zfTLE4r4TcU/OHTmSpeR+O0gOIjNo7I6WV2
         eoWXZhSbvnDTPv4J40Qan6NF6pOGAk/uLqxMCnJ3VwEytUNZLhcy8TWrn7P2W88orzr1
         SNudtfmg0+aTGfYI83SpUDZBHRLFdvMRJS+xHJ62nAe9/69CWIGqma8UBcSTSD/M5z69
         d72cit8bVCk6vEpoXJht5Jw6uSmEhrrwk4hWS/Bi7Btef92b7ERyBiqel+qlXAr8ieqO
         6/GA==
X-Gm-Message-State: AOJu0Yz/ShZY2Xml+dW6NTtfsdZKWHV5cMGV1jHqY2mwhQI9RFY9Fi3l
	f3MkDu7za4AP9fWIPtGgaWto0uSsGP6m16Ya2FgNrYtz5quA2FcG+sRDH5MA/g==
X-Gm-Gg: AR+sD10CrLMA+n7xAkQ7ikHCfSDLJKk5H3z3wiR3JOFyHZIXYfBI/xAH4Xyelvp/KeX
	B4zZ+YnDPf9LWqHrQfl4UjdUIJ1OUs+sNPzyYse2J5zp8Bu9dFrfwsjm/gxtzaooKF8s2gHFHY2
	YvA9Ar2kwc5F2IIiGiGAoya7ezMUFPShFMqvTN/UbZhMUCCQGWdW7V4fLCmZsbk605xXzeZwFbr
	agZ56tucz7gh/5BeCrpM0ubpTKb9xN+4+HvJmrVXl9OZ0tZlyXKA4VcuRQLnFkeJUTRJXYuSzZw
	yduJsXhbFvoxV/RKTnFXKKTF4l3aD3jObOQWnc5ORa/wGbDsj8aInNQVrdHcXwXAiar1TZu5mRn
	dgyzNqtMOJXt6DNnDjP4wrPW/vuWSn6zHAo5w0ZqcKX++SfuMkVqP0qewW2ZmvCtdHI6SR7Q=
X-Received: by 2002:a05:6820:2d49:b0:6a1:84ea:1e39 with SMTP id 006d021491bc7-6ac96bdfd8bmr2223232eaf.38.1785276137510;
        Tue, 28 Jul 2026 15:02:17 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aca54d5cf9sm461919eaf.10.2026.07.28.15.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:02:17 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:02:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] odb: compute compat object ID in
 `odb_write_object_ext()`
Message-ID: <amkk_0C8joQKH43M@denethor>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
 <20260717-pks-odb-move-loose-object-writing-v1-1-46446a3cb5b7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-1-46446a3cb5b7@pks.im>

On 26/07/17 11:32AM, Patrick Steinhardt wrote:
> Repositories can have a compatibility hash configured, which means that
> such a repository is expected to maintain a mapping between canonical
> and compatibility object hashes. Maintaining this mapping is the
> responsibility of the object database sources, where we either store
> them as part of the loose objects map or in packfile indices v3 (once we
> gain support for this feature).

Makes sense. Each ODB source should be responsible to tracking how an
objects maps from one hash to another for compatibility.

> But besides storing these compatibility hashes, the sources are also
> responsible for generating the compatibility hash in the first place.
> This is somewhat unnecessary though, as the compatibility hash should be
> computed the same no matter which source is being used. The consequence
> is that we need to duplicate this functionality across the different
> backends, which does not make a lot of sense.

Agreed, there is no need to duplicate logic as the hashes that get
generated should be the same regardless of the backend.

> Refactor the code so that we instead compute the compatibility hash in
> `odb_write_object_ext()` and then pass the computed value to the
> sources. No callers need adjustment as there are none that write objects
> via the source interfaces directly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c                 | 26 ++++++++++++++++++++++++--
>  odb.h                 | 10 ++++++----
>  odb/source-files.c    |  2 +-
>  odb/source-inmemory.c |  2 +-
>  odb/source-loose.c    | 24 +++---------------------
>  odb/source-packed.c   |  2 +-
>  odb/source.h          |  4 ++--
>  7 files changed, 38 insertions(+), 32 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index cf6e7938c0..1d6538163b 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -989,11 +989,33 @@ int odb_write_object_ext(struct object_database *odb,
>  			 const void *buf, unsigned long len,
>  			 enum object_type type,
>  			 struct object_id *oid,
> -			 struct object_id *compat_oid,
> +			 const struct object_id *compat_oid_in,
>  			 enum odb_write_object_flags flags)
>  {
> +	const struct git_hash_algo *compat = odb->repo->compat_hash_algo;
> +	struct object_id compat_oid, *compat_oid_p = NULL;
> +
> +	if (compat) {
> +		const struct git_hash_algo *algo = odb->repo->hash_algo;
> +
> +		if (compat_oid_in) {
> +			oidcpy(&compat_oid, compat_oid_in);
> +		} else if (type == OBJ_BLOB) {
> +			hash_object_file(compat, buf, len, type, &compat_oid);
> +		} else {
> +			struct strbuf converted = STRBUF_INIT;
> +			convert_object_file(odb->repo, &converted, algo, compat,
> +					    buf, len, type, 0);
> +			hash_object_file(compat, converted.buf, converted.len,
> +					 type, &compat_oid);
> +			strbuf_release(&converted);
> +		}
> +
> +		compat_oid_p = &compat_oid;
> +	}

Here we lift up the logic to gnerate the compat hash out of the backend
and into `odb_write_object_ext()` so the resulting hash can be wired to
the ODB source callback to write the object. The logic itself is the
same and looks good.

The rest of this patch is mainly just updating the callsites accordingly
and also looks good.

-Justin
