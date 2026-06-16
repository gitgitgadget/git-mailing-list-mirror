Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AC39768C
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781644450; cv=none; b=Rcf3jtZR+I8LnU2JxfWVJPDWOmna2EcsmSpxatnqkkgmgPafRVJQUmlT6C6ETeIxYwL4cW40Crfe9IODrSF4kWEYtmUbaB66d1+is/aVJ2e9vGjU6VEbO0K+OT0gDHQZ83pp2DESnhxMuFls3Jz6+nRdV8aF1fkSHqfzkFsAwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781644450; c=relaxed/simple;
	bh=l5sSaY1CK/60xefihMzmhr2tTwfcntLNvkYp3vPu4QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHaMzK/NiU1zwNyHl1fa6bK4k0wt3VbFa3T66a7x7mGh5Kzwx6Td0odScr8QvhdQU4DjuHnSzm+815h20UY7ZAtmLQvBF0bZBh1Iz4BaOcl3UaM/OY5vRNaGjModU9dEegrWkX4g9SJw1fj9qQTVjCNsUDavQzWeDXydaeLWF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrCC2abF; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrCC2abF"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43d2ff651f2so4184771fac.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781644448; x=1782249248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpvuYS+YSeK2dX92zmrM7OSY4raK0z5Ie6bPgbl7HaU=;
        b=JrCC2abF7ZApSX3hIIjUVikobjj01w9uUzAGxTutQx1tzX9ONbN2A2eSCvbAWeRPwe
         eJBf9ZAt52UCytE1CicS/GxWOvTJz3h/wnWU/JNO2XIrMJlDmuoJ9WTtpShBzwoOX/GJ
         t/RKc6py0mND5PX8siAr71RFBaz1VohANRIaWAHl+qBXI6OaJgW307sbPqIpKRvhiP7D
         aFEWPA3HBDwn3eoGbbySc0/elb0isSh42YRXaUBMvVY1kCNdcKxT5EM59Ib61mh465BB
         +rKNMwtTOLhqaZEosXSL2ng7eONGtQ4fRTyAnfPHFdwg86F5u1QnJ8nZbnCLt+J9byP9
         nTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781644448; x=1782249248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpvuYS+YSeK2dX92zmrM7OSY4raK0z5Ie6bPgbl7HaU=;
        b=ByXT7mO3jwxbK7WpvJ4zaBfXO42ji7DFaNMKUoshS4xMH9MKnf5WdM+gbAwTdRZ7lq
         gKN5kpZawRbezA7Lck6k8jVvXyj/1xfeGpwXfyLJMqoBMfjZ6VEV0WxMCF5jZiSuR1U2
         Psq2SyUqH4q6rFgFaRrSR/hqvax/kihw3qpUXaqzjRLAoW7eivtNvlg6n8VmCxM75PaJ
         z+WeI6QhNyd3zYokw3GNHIQEQMTTh9Hodet/LOZl2HIyRBRRgxj+SzhNNBy3WrFhFEEJ
         DpEunUB3aNLHuhWGKvJEoMxqR6Pj2j4YhsKOXUh8AGOsK2suvwdpVlmX6dD+pIdsM77x
         Am1g==
X-Gm-Message-State: AOJu0Yx5HcueL4RGaYUNjICP91KUyk9qNK7eGXUUbS8QdYXCC1IsaN8m
	HqyjS2LkcNy4m6aBMNUPZiUTXTglVbDVxCKEX3o6yuBtqEzW04x/2Vqr
X-Gm-Gg: Acq92OEEoxNLHuO1lcqWR7F+SU+kBC6w4NAnx3/pTauSk2qqV6jYYkVSBcrxsEHSGXB
	dAQf2/hSns1ULboGD3e/hJEJVK9YIWMkLUSTSDTke65dBinuBg+ne3bKXqYvmTf27EbFc5xpYue
	Gm5hKP/CPOacs0YQz0Uo6U84eluxNdeuvZ/ZgyKh/ET3nMsdC3esdnxN+VPGkCyTiKqkoOwikfl
	2oNOo6xc+QgkV/o7FHT8FxNKkDXPNH6N6sAdbEi8zbKGW7o09u1hqo69peSgAoim+aHr2OPp0qx
	+osAdMexlkf+6HBhFArphDLU3/LFYIOnvEs8PLNdNquuhjSVbmWwzEl04MQ41jLsABaUm9eIkj+
	Ex6w5QZKZs4DevoNtZLPo3IEm4ZNugXAWNUvRdmuvRgQGrZNDInbKmJKWVntnLQ7121ecMtb1+J
	Ep+STQK+04qDSO7/oc
X-Received: by 2002:a05:6820:1c95:b0:69d:fcff:a3c9 with SMTP id 006d021491bc7-6a0b619207emr669447eaf.43.1781644447938;
        Tue, 16 Jun 2026 14:14:07 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00d2138dsm5736876eaf.5.2026.06.16.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:14:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:14:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/17] odb/source-packed: store pointer to "files"
 instead of generic source
Message-ID: <ajG69JZHx_u2mt7q@denethor>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-4-839089132c8b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-pks-odb-source-packed-v2-4-839089132c8b@pks.im>

On 26/06/09 10:50AM, Patrick Steinhardt wrote:
> The `struct odb_source_packed` holds a pointer to its owning parent
> source. The way that Git is currently structured, this parent is always
> the "files" source. In subsequent commits we're going to detangle that
> so that the "packed" source doesn't have any owning parent source at
> all, which makes it usable as a completely standalone source.

Out of curiousity, `struct odb_source_loose` also stores a similar to
pointer to its owning parent. Is the plan to also eventually do the same
there?

> Detangling this mess is somewhat intricate though, and is made even more
> intricate because it's not always clear which kind of source one is
> holding at a specific point in time -- either the parent "files" source,
> or the child "packed" source.
> 
> Make this relationship more explicit by storing a pointer to the "files"
> source instead of storing a pointer to a generic `struct odb_source`.
> This will help make subsequent steps a bit clearer.
> 
> Note that this is a temporary step, only. At the end of this series
> we will have dropped the parent pointer completely.

Ok, so IIUC the eventual goal is to get rid of the pointer entirely, but
for now we are just making its concrete type explicit without having to
downcast. It's not immediately obvious to me how this step gets us
closer to that goal, but that may become more obvious in the next
patches. :)

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c  |  2 +-
>  odb/source-packed.c |  4 ++--
>  odb/source-packed.h |  4 ++--
>  packfile.c          | 12 ++++++------
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 191562f316..e04525fb08 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -269,7 +269,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  	CALLOC_ARRAY(files, 1);
>  	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
>  	files->loose = odb_source_loose_new(odb, path, local);
> -	files->packed = odb_source_packed_new(&files->base);
> +	files->packed = odb_source_packed_new(files);
>  
>  	files->base.free = odb_source_files_free;
>  	files->base.close = odb_source_files_close;
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 1e94b47ea0..12e785be48 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -1,11 +1,11 @@
>  #include "git-compat-util.h"
>  #include "odb/source-packed.h"
>  
> -struct odb_source_packed *odb_source_packed_new(struct odb_source *source)
> +struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
>  {
>  	struct odb_source_packed *store;
>  	CALLOC_ARRAY(store, 1);
> -	store->source = source;
> +	store->files = parent;
>  	strmap_init(&store->packs_by_path);
>  	return store;
>  }
> diff --git a/odb/source-packed.h b/odb/source-packed.h
> index 327be4ad65..3c2d229a17 100644
> --- a/odb/source-packed.h
> +++ b/odb/source-packed.h
> @@ -9,7 +9,7 @@
>   * A store that manages packfiles for a given object database.
>   */
>  struct odb_source_packed {
> -	struct odb_source *source;
> +	struct odb_source_files *files;

The rest of this patch updates the callsites accordingly and looks
correct.

-Justin
