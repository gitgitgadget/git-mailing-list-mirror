Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515196;
	b=g0go2d/7/9BpWM+7XnFxJW/tWaqLn2VyCU7ZgMltp+u8BcztzWvbBfIR3ydd5mFjXPxk
	 ZeyTr2MOJti63H6Lys7SqsnJgz2Q4uJCX1yrwBG6IgSlYFTWsHynecdoDAcx3gbQD1HC9
	 fPCAQ2xu0DVD/53Yzzk/U9hIwxE1n57o0nB4HEEAAMUHP3YJzJK5NTeV13oegZKNCrX8i
	 vu1xbxaBUvidgzby+W5mDwDpO5kI8L3TFr4u/jxsm1GSh020JRb9EfUiNEK9ThnUgzySG
	 9b/ZoijZKmdHq8SjgbsKFbxss+70e5NFamFAc6sD2SV5dz7eoqQGq6pwNmkOlmGGWRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+HEcCQFgGasrcxfC/oEPCuLP4iEYm11XOBAN+cduWys=;
	b=IHkF7nCPMil7FF/M/Eus/DcIohMpeh2KMKXjMg1mKTKvcM9KRmpchZ89bzKiubIrkNCQ
	 RV/HgOzOOdnCQIF/Xn8GLFTVYd2vPpvLBmNsqhJWjSDviqMNaj1TfuPgjF6cASD95wFnt
	 X7tpJHZ+95tHXpHV10pwZlGBskavgsmrgCe8O6fZwQ2KKeZfe1qEabmX+TQgmxzl7OaWb
	 UhjYD+++bXyIlroD7Jo+Uc95oTLxnOZ7xiYZFXogEpKUOXa/whjBqW309HAU8JV2LA+RQ
	 Pzf7kVUEtB7vTAYvPI25eFxGBdb2y7LOpAj3Fe96OLuyCtyLSE2ApzqLWQl7GBObuoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fF4alFl2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1160A2637
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40F1160A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fF4alFl2
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4326803b54so119908866b.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515194; cv=none;
        d=google.com; s=arc-20260327;
        b=Uc0THs+f88V4wmb6UJcdvDUmQku8Z+puO9WYOdGallPUSZfRheyf5M8zXW0HowSU+V
         LnFs7ZTw/LyGXdk1pX/WBWrTLJbMs7Pfu6XGZ2jrTuZxehybFp9tMF8QdYQVzJHI/iyt
         gq9NWDm0AJ3Wh8kTH4bdHKbYV+58Wd+CGEpRDhei7sLqReQ2EVakIJGW3E+z40yzJk7v
         oE2LNV90TOvXkGDgNl2myQVScMiSJN0CzGwwnRCK+7iNivs1DIUR1BY3cRUr4Xs0GoTF
         8Ugv2HyuUH4GuB71qMIbI7yu4/T8Qpwn0QfsqS2gauZbee7NzhMijJwVUU0yfSNQWcWk
         5++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+HEcCQFgGasrcxfC/oEPCuLP4iEYm11XOBAN+cduWys=;
        fh=xEwNemFXS4bNjoQJ/u99Eqj9SfdLR39dP7gdi9L7gCU=;
        b=T+nHTzdAeoIu4cPfbbRCK7oxfA4DiMxXeQbgxlxs3F5NUOLUpzV3HziP904xttIEd6
         XbjfEf9nYi1D6v6EPm5GAwn1+JLZAcmw+efZE4hK+R9QvYudrWKikusUU11W48qbEZdp
         YBjR7PoPaqHj3ZJlOsEKHlnJ8sVAEsneK9VupDfAMIkCJsMDPfj5N/LCpuBmwtnBJZ2a
         mattCM6/2JS0Ws29opoQ2DaQ/cgQU8+PEjBDm6Qj2ufBK699ypPomWvdurqQzPrvTb0N
         lAlmSIUJK/7J7WruBR1Kx3yGmbPFfsD++VZKogEu/FRgxnalbUxfxTU8zoy5jA9j6BXn
         xZNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515194; x=1793119994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+HEcCQFgGasrcxfC/oEPCuLP4iEYm11XOBAN+cduWys=;
        b=fF4alFl28mTpgJ7Ikh2KH0pKrFGK2Qi/BVK1ue4EpZyO5azcthk+YpzWGTOWeOtDze
         8TvxsWU57TfUaqWhuu9CZJ+Ajwza+VAcMfXgygAQdQpbygmqZDGLG/8CfYqoEEELRyAJ
         m+89olmO+ZibTHPqcB1GiGbJt3//IEaArKe4XntCHS8/F9vR2ehI4TQ6wQs2tyVG6PvB
         ci/I2JJ8M/tOB1sTEdmVgyf6V4skG+qte+rq8mn8FIZgkZRrZQUk67lJHyrxq1XarjCj
         G1PybO8TqfAMq8mtFgUkhxsdF/Vc54ksL6wLJye53PFwL+w3vSMocfzupHmCh+zrmjGW
         +tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515194; x=1793119994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+HEcCQFgGasrcxfC/oEPCuLP4iEYm11XOBAN+cduWys=;
        b=biy16Mg7maDkRkiKKeJC9E8tYYaPVJbiLDwhy+7SEUHnjQ7QMJM6o7nn/aWr6ktlhS
         LZM7LyQIchFTxyDoemQlNyqZHb4YDLpQShqow79U50cMv4Bvy5Wubz+GuPcPBgYqTRHS
         qIQ4+92H8A9Eu9BhF/U7hDS0xmMdzHZREppxSSUIAU6UWM4wsJH6zNSHULGm80zHrs8t
         ehlLzPRBSCSACVNtQKswEkrmM/gTXCymiAJkVGmcHguvN4odFnEaFWyPVBWBmqFdZ+gs
         t2+s9zDqweJVaYDDHBxAuZ+hnqImHNGKBKHu8q9xwnXkhzvA5n7UoUVDJe6+cndcvp5R
         AMpw==
X-Gm-Message-State: AFq9FYKU6KsPF4zGKlPb7TdUCSKr9i4nkuqVyCmQsqiSXIwaN/VP96J5
	jAqli2BNWdBf21ltKdoeqx6IY/h/FP1wV6CK4yqaWT8ZHf4uWmccY4cPnYjy/SI/2FJXdDpLOYg
	ceYAufefmsZe5y4tzD9I7G6oiQZubfSA=
X-Gm-Gg: AYBFou3amKsoMEfSlls8JAyqPIvUjaNJ2U9v2AsRa5ySSzUY1HSVYqnNZPi6k5ZJZXH
	VDPCJKDSbTozFWCdtOYRgzEr1wvZ46uXi09h2LCjByYO66MzNwiIVvjYne2uTqXSESYErOhCtfg
	qUYy1JTtrbtJBWZjRS4fnDwZhwVdWBPOd0tyLbYaAihOxpNkDlrfG6jdaSb0My71bnaL8p3daDc
	XbfwbYiVj1esvGprVAX9lQtWoE2qTM6TiOO2QOatlKYNKV3qxjDjDsJKSyvMSpcNdVfqdd0bL/B
	HfFIXEsQ0XPoEL3CPHDWC7EGmBfkpZbP49Go5Al2C0k3EMiYZRqfcqmxOINBvw8X9FcsGyzr6wm
	0n3nwqNAuDDeh
X-Received: by 2002:a17:907:720a:b0:c40:4f39:22e8 with SMTP id
 a640c23a62f3a-c41a04ee605mr951313466b.44.1792515194426; Tue, 20 Oct 2026
 09:53:14 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017105244.90295-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261017105244.90295-1-okhuomonajayi54@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 20 Oct 2026 17:53:02 +0100
X-Gm-Features: AclHuK--IX-kKDU5QQKkuWwP3Dd5-Y4qrmZ2fPItqIg5WHbpeAptYjyN_n3-6j4
Message-ID: <CAPSxiM-OyrVEzYgja0nwa8PikfU1WpsCYbiNiXpcxb4TM4=mOA@mail.gmail.com>
Subject: Re: [Outreachy PATCH] merge-blobs: stop using the_repository
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> merge_blobs() already has the repository through istate.
> Pass it to fill_mmfile_blob() and use it when reading objects.
>
> Remove the USE_THE_REPOSITORY_VARIABLE definition and
> include the headers needed for the structure definitions.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
Good.
>  merge-blobs.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/merge-blobs.c b/merge-blobs.c
> index 49dbec9529..1b0621c814 100644
> --- a/merge-blobs.c
> +++ b/merge-blobs.c
> @@ -1,18 +1,19 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "merge-ll.h"
>  #include "blob.h"
>  #include "merge-blobs.h"
>  #include "odb.h"
> +#include "read-cache-ll.h"
> +#include "repository.h"
>
> -static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
> +static int fill_mmfile_blob(struct repository *r, mmfile_t *f,
> +                           struct blob *obj)

Is there a reason why the repo variable is named "r" instead of repo ?

"repo" seems more "descriptive" than "r". if there is no reason, let's change
it to "repo" from "r"

>  {
>         void *buf;
>         size_t size;
>         enum object_type type;
>
> -       buf = odb_read_object(the_repository->objects, &obj->object.oid,
> +       buf = odb_read_object(r->objects, &obj->object.oid,
>                               &type, &size);
this r->objects will become repo->objects
>         if (!buf)
>                 return -1;
> @@ -79,17 +80,17 @@ void *merge_blobs(struct index_state *istate, const char *path,
>                         return NULL;
>                 if (!our)
>                         our = their;
> -               return odb_read_object(the_repository->objects, &our->object.oid,
> +               return odb_read_object(istate->repo->objects, &our->object.oid,
>                                        &type, size);
>         }
>
> -       if (fill_mmfile_blob(&f1, our) < 0)
> +       if (fill_mmfile_blob(istate->repo, &f1, our) < 0)
>                 goto out_no_mmfile;
> -       if (fill_mmfile_blob(&f2, their) < 0)
> +       if (fill_mmfile_blob(istate->repo, &f2, their) < 0)
>                 goto out_free_f1;
>
>         if (base) {
> -               if (fill_mmfile_blob(&common, base) < 0)
> +               if (fill_mmfile_blob(istate->repo, &common, base) < 0)
>                         goto out_free_f2_f1;
>         } else {
>                 common.ptr = xstrdup("");
> --
apart from the nit about r vs repo this looks good.
> 2.54.0
>
Thanks.
