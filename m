Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="S61ef8hU"
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897FA2
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 13:59:37 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7bae8dd095cso66912241.3
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 13:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701295177; x=1701899977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2knPUlO6juIZ/vkvQoPyb/4ZCcUYgE2FVOPjF28Npk=;
        b=S61ef8hURD8AUwMWv/ORX52CO5qAHFPoTqq9G+k2Te2XEFamzbV1znLMd1fE+j6jp+
         emp3kX6hIfuyK40s4/g7TEwrpgx5FDvd7fbD4QCfgimU02udULaVch1U6gzoaU1l3wHQ
         jmd/Cc62SWByVRoc5xGgCg1PMqestWg4VVgKKl3xgK3VLIaqMUzJ9WRlP4hIdxUkdiAa
         1bRUnmkT9CZG49X0+DWshyG3mfZLnTzhlgti/dRtdr6X1+XNYnIRt3ANontUu1q3PkNT
         MGotjY5DaJEyXYJIxyO5j5BkZV9MsxCtFapZx4iaAr5RmTg+W9uHFCpeMStbAWIiwk+N
         JC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295177; x=1701899977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2knPUlO6juIZ/vkvQoPyb/4ZCcUYgE2FVOPjF28Npk=;
        b=ZEO/G2A6BK7AJy4VCw+DUPMMadUSh4V0IFVeGkbnStp5smk6qEuv1v/fjL8KcMn4vx
         WyMfimg4PcLF4ACQXEriCAbIx/hmAdRK8wsCDalm0iIMxaiRoIvNSzjeyLZ290QbARxH
         N6J8voiDo6gXLWy4hQx1rxjnRSnx3qB9OmRVNUyzl8+6Ms6YPrVAjwgRghYPbjhgngkC
         EzvJYjOoEm8yrbuLfFNbLlfImbnPPkViUAdgPoIhd6yz3c/PQcxdSk9ddsbp8tsnWV5O
         lWxLSXzk4AzAno9UYVuo2XxiWutZ8S2BhujEz/r14ZNo4xX2jtfnSO2XNZR5Jt5Fo4yR
         SOoA==
X-Gm-Message-State: AOJu0Ywn1ComyKiWYpz6Np4o2k1Ju65EHgcueBRZOF+PQFCaDFRpvJSf
	o2rUWxT6i7KNSFrmxG/FuZghvg==
X-Google-Smtp-Source: AGHT+IGuyQLiEaK0ya241UMZ7Pz7gUNkLHHm1o1pC1zz6cfCJgdEWeRYwIKb6spqFsE6sei2M1AnWQ==
X-Received: by 2002:a67:fe4d:0:b0:462:85e1:c46e with SMTP id m13-20020a67fe4d000000b0046285e1c46emr19787484vsr.29.1701295176852;
        Wed, 29 Nov 2023 13:59:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t5-20020a0cf985000000b0067a33133420sm4391526qvn.110.2023.11.29.13.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:59:36 -0800 (PST)
Date: Wed, 29 Nov 2023 16:59:35 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 3/4] refs: complete list of special refs
Message-ID: <ZWe0RzOoHI9QZMox@nand.local>
References: <cover.1701243201.git.ps@pks.im>
 <0e38103114a206bedbbbd7ea97cb77fa05fd3c29.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e38103114a206bedbbbd7ea97cb77fa05fd3c29.1701243201.git.ps@pks.im>

On Wed, Nov 29, 2023 at 09:14:20AM +0100, Patrick Steinhardt wrote:
> We have some references that are more special than others. The reason
> for them being special is that they either do not follow the usual
> format of references, or that they are written to the filesystem
> directly by the respective owning subsystem and thus circumvent the
> reference backend.
>
> This works perfectly fine right now because the reffiles backend will
> know how to read those refs just fine. But with the prospect of gaining
> a new reference backend implementation we need to be a lot more careful
> here:
>
>   - We need to make sure that we are consistent about how those refs are
>     written. They must either always be written via the filesystem, or
>     they must always be written via the reference backend. Any mixture
>     will lead to inconsistent state.
>
>   - We need to make sure that such special refs are always handled
>     specially when reading them.
>
> We're already mostly good with regard to the first item, except for
> `BISECT_EXPECTED_REV` which will be addressed in a subsequent commit.
> But the current list of special refs is missing a lot of refs that
> really should be treated specially. Right now, we only treat
> `FETCH_HEAD` and `MERGE_HEAD` specially here.
>
> Introduce a new function `is_special_ref()` that contains all current
> instances of special refs to fix the reading path.
>
> Based-on-patch-by: Han-Wen Nienhuys <hanwenn@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 7d4a057f36..2d39d3fe80 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1822,15 +1822,69 @@ static int refs_read_special_head(struct ref_store *ref_store,
>  	return result;
>  }
>
> +static int is_special_ref(const char *refname)
> +{
> +	/*
> +	 * Special references get written and read directly via the filesystem
> +	 * by the subsystems that create them. Thus, they must not go through
> +	 * the reference backend but must instead be read directly. It is
> +	 * arguable whether this behaviour is sensible, or whether it's simply
> +	 * a leaky abstraction enabled by us only having a single reference
> +	 * backend implementation. But at least for a subset of references it
> +	 * indeed does make sense to treat them specially:
> +	 *
> +	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
> +	 *   carries additional metadata like where it came from.
> +	 *
> +	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
> +	 *   heads.
> +	 *
> +	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
> +	 *   rebases, where keeping it closely together feels sensible.
> +	 *
> +	 * There are some exceptions that you might expect to see on this list
> +	 * but which are handled exclusively via the reference backend:
> +	 *
> +	 * - CHERRY_PICK_HEAD
> +	 * - HEAD
> +	 * - ORIG_HEAD
> +	 *
> +	 * Writing or deleting references must consistently go either through
> +	 * the filesystem (special refs) or through the reference backend
> +	 * (normal ones).
> +	 */
> +	const char * const special_refs[] = {
> +		"AUTO_MERGE",
> +		"BISECT_EXPECTED_REV",
> +		"FETCH_HEAD",
> +		"MERGE_AUTOSTASH",
> +		"MERGE_HEAD",
> +	};

Is there a reason that we don't want to declare this statically? If we
did, I think we could drop one const, since the strings would instead
reside in the .rodata section.

> +	int i;

Not that it matters for this case, but it may be worth declaring i to be
an unsigned type, since it's used as an index into an array. size_t
seems like an appropriate choice there.

> +	for (i = 0; i < ARRAY_SIZE(special_refs); i++)
> +		if (!strcmp(refname, special_refs[i]))
> +			return 1;
> +
> +	/*
> +	 * git-rebase(1) stores its state in `rebase-apply/` or
> +	 * `rebase-merge/`, including various reference-like bits.
> +	 */
> +	if (starts_with(refname, "rebase-apply/") ||
> +	    starts_with(refname, "rebase-merge/"))

Do we care about case sensitivity here? Definitely not on case-sensitive
filesystems, but I'm not sure about case-insensitive ones. For instance,
on macOS, I can do:

    $ git rev-parse hEAd

and get the same value as "git rev-parse HEAD" (on my Linux workstation,
this fails as expected).

I doubt that there are many users in the wild asking to resolve
reBASe-APPLY/xyz, but I think that after this patch that would no longer
work as-is, so we may want to replace this with istarts_with() instead.

Thanks,
Taylor
