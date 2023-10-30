Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A15D266
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="N3oDvJob"
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CEEEE
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:01:27 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2df2fb611so3493544b6e.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698696086; x=1699300886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8O7RY7wJhk9GEgWPSSlcx4BlqF5rxtETRLxxrlB9bQ=;
        b=N3oDvJobwS/wRUeT94W+OyfB8Sog+EQ6RIEKj+NPC8DD/z2DMtILMWb2xUwoXClwUh
         MU7yNG0G+3WMXTtksa+7iqil1Q7RnB0t6vtyYoPjvljAzFdLMnNcwfJEaHuZ6tCOfqF+
         3Co9pXYCQxfzsIiU8Pvz1JLloiPUOu7hUbTP2PDE75fQ3gAWZzPWiwh4QGizC8YGbxZ3
         4wRsdocFA+ne+6WIFkZ/RI2++DHpzeDd4gn8EB+pa0gv2Ag1LK0TDrso9msC5IHsOcx2
         vi+mZRmFzi3Ztp3Fc1cCn3ahMpgtTA/kz1P0cKsTEgAg3JXxZufUenZ2gBZvA+E5svE/
         zFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696086; x=1699300886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8O7RY7wJhk9GEgWPSSlcx4BlqF5rxtETRLxxrlB9bQ=;
        b=BMk1KNTrXGmSs9dhPeV3ifbt8ksQOkIr0zmXcsjvttNIYS+GTfGNGKUlqHIrTVP9ng
         QB1W9UW73mvmz2lYlUN5X9VcWdVempUm/z6+K6oTNo5RPp7aIL4VFFTJuqTJol/yf3Ql
         BfLsRxmJoSyfKSIScHaHNfkrDTiLnAAdw4naYgKghI00wS9x8zzRyyCObKE6nNotXHGg
         civet1raqZ+bD5qZKi44AEgJw5T8UHH+wt9Dsg0byg5jX96rb8URUiHuZ1LM3dN48stA
         lqjFhsDI/5hYKmDRCIXQyg5CAsHQb4h6Ugo7pSXcpfIFrN1Ctn99TJDD6B/GCQoq0MzP
         2uqQ==
X-Gm-Message-State: AOJu0Yx5FVAdiPAGkTvN3u/uEBuWIMJ4dCHu8pqJJvXcuepLxp21UEtV
	DgPg93AyK2r9x8wGHPtZkipO1g==
X-Google-Smtp-Source: AGHT+IGtJHdGhusJUFfiaOtRTITag2qYxEWRik5j9O6z+S3+xGzJO9Xgp6zOVElVSJah+hy3HYCm2w==
X-Received: by 2002:aca:909:0:b0:3b0:da4a:4823 with SMTP id 9-20020aca0909000000b003b0da4a4823mr11738595oij.56.1698696086560;
        Mon, 30 Oct 2023 13:01:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c2-20020a0cf2c2000000b0066db331b4cdsm3720533qvm.86.2023.10.30.13.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:01:26 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:01:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ruslan Yakauleu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
Message-ID: <ZUALkdSJZ70+KBYq@nand.local>
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>

Hi Ruslan,

On Wed, Oct 25, 2023 at 08:58:00AM +0000, Ruslan Yakauleu via GitGitGadget wrote:
> From: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
>
> A new option --ff-one-only to control the merging strategy.
> For one commit option works like -ff to avoid extra merge commit.
> In other cases the option works like --no-ff to create merge commit for
> complex features.

This seems like a pretty niche feature to want to introduce a new option
for. I would imagine the alternative is something like:

    ff="--no-ff"
    if test 1 -eq $(git rev-list @{u}..)
    then
        ff="--ff"
    fi

    [on upstream @{u}]
    git merge "$ff" "$branch"

I don't have a great sense of how many users might want or benefit from
something like this. My sense is that there aren't many, but I could
very easily be wrong here.

In any case, my sense is that this is probably too niche to introduce a
new command-line option just to implement this behavior when the above
implementation is pretty straightforward. Regardless, here's my review
of the patch...

> @@ -631,6 +633,8 @@ static int git_merge_config(const char *k, const char *v,
>  			fast_forward = boolval ? FF_ALLOW : FF_NO;
>  		} else if (v && !strcmp(v, "only")) {
>  			fast_forward = FF_ONLY;
> +		} else if (v && !strcmp(v, "one-only")) {
> +			fast_forward = FF_ONE_ONLY;

The configuration handling and documentation all look good.

>  		} /* do not barf on values from future versions of git */
>  		return 0;
>  	} else if (!strcmp(k, "merge.defaulttoupstream")) {
> @@ -1527,6 +1531,18 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		free(list);
>  	}
>
> +	if (fast_forward == FF_ONE_ONLY) {
> +		fast_forward = FF_NO;
> +
> +		/* check that we have one and only one commit to merge */
> +		if (squash || ((!remoteheads->next &&
> +				!common->next &&
> +				oideq(&common->item->object.oid, &head_commit->object.oid)) &&
> +				oideq(&remoteheads->item->parents->item->object.oid, &head_commit->object.oid))) {
> +			fast_forward = FF_ALLOW;
> +		}

And this rather long conditional looks right, too. This patch could
definitely benefit from some tests, though...

Thanks,
Taylor
