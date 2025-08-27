Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C611E51EC
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259120; cv=none; b=FwDTUZNNnoM+/1m3ls8VCstQgEg2SxQ7kPDA/hT8DVAzSLnc9U1Lr5avDpcbE7Z6OfwVg31tBUxKrUrL9jHKvTMXL7HJgEEQEX+NNi5R1S2qDWc9qfj34POT+ddZx8sRLspGBr51ffHGa4eSIvuDOFfshPfTEKn6SzcWEwWOh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259120; c=relaxed/simple;
	bh=2Pe/311JKpWuemcm/au5MQz1p37prB/JyPiM+9RRpsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/RXNm7pdk05W2mzlURT+vkhGEx1uqOFck1wusYL7GFuE5QqH/BMOe8gl8KGdp3eqmSk0TCIAQBM5LBc0deKwX5rQrF3PEC65SHvMwrnYfDBOvfAOBPZITXDXXyQHOUz3DFeAZaNoPo++IUEo7jnEc5fgFtc+GIbFlxeSwnmV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=inu/Ebij; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="inu/Ebij"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e668360ec7so2652215ab.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756259116; x=1756863916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tU7GBcb5m2cAP2tPYwgQ0fNLHU0a0Flxtbr9SVmank=;
        b=inu/EbijebWpGqDY48ke+HV2vSRwXaO7qTim7GHQULEkyCpu4gPizhQZh9YxfKt8r5
         5CBtjA9x7ysJDVveOBVyqhTbrvBV3s/v/RPZ6lYeUvXbzxUD4zWNAlmTLGyzY5dNFjvV
         yQDGsIQQCUX82LtuqXcpEscbFaNoVlIy7faA3yjKgRSq0YnN/7E6dhxSbxP+S017cvg5
         aVPm8fV0hnzQtdqlWek2AL5Ya2RP1jeVXCBrM0ywLSDRDC2Q5CE61eg5CZ6iQIFRc1Mk
         q1FadjT+7gcvAZpl6fomsKzDUlZL7KBqkSZ9ecLScpG1pW3DCJXrLr86H2dLVniS7aqr
         h5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259116; x=1756863916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tU7GBcb5m2cAP2tPYwgQ0fNLHU0a0Flxtbr9SVmank=;
        b=R97U9r+p/ma/tpko1XIb10MBHBqBoIKT2+Fj2LJTqIBGkydUviB/o/F827W2iyXznE
         7Rw9Us0Xhw5RbOvK6xCmKTIhM0B115Df8KIfEtdGBWc+ZDZAQirneCBi+mLlUL6RH5ZJ
         eae9tJZNlog5qdxUxbuWlAGUbpaTdmV00R6ksdLP7ixGZBU2S14BuXcsrR43af66CtTY
         dd2+mA8tjGeGsc+AQTHMzAUYKHBDEh5kb++QvmM3OfKbwAiKsUROdaEoSmZWoX8C63QC
         aRiYkmRbJ9bCwWf2Mff9RI67P9RNeUrdA/SbITjuIAzxzdOlnhnwFjS/kOdiPtPHt85Y
         VJ2Q==
X-Gm-Message-State: AOJu0Ywax/wYBlB26BbANi7msKdjrhivMTwFsZmiJzIGOlFmOc9Emkrl
	FR/6vEo3ZsOOgTF/ol/Q5lahoBrKSytkBlN+HLJlQZ9WHJp0S/boA8muAhb2FfnQ5Tw=
X-Gm-Gg: ASbGncsB3NcLI0BlKEHMz2YkzL+MW1wXt8SgNMt62nvc7Eq07+yZEcWSaegJTBVYOqV
	YoOOhQJvv6QfmM34+rsKCgppWt+hAFSWKOyW0sfMbo9YpODBm/+aZ1h+LO4xqRoPpLwinv+qmsa
	belmmNydUdjYdB3FtltcaZ3B60bS/NBfy8ogB+qKwx6BIPsi86G7zoPe/vBufnJ0w5T0f8N2Wsn
	UzrJrzyoepk5R+lTQ7nJG/DlXg3dYqWAHZFLJbJAzi8VY/bsr/G3atHWAr1efz79ZxTSszGWzzi
	MJWLLtorBmilOAJyyryT2EOVwVnlIYnndbzU+LQrWzFJVlqdqPDa4CudixfT9YM2HKTQgo+oH1E
	R/mUlgxgGU2IOdPGy1CV9B/xyQzoI+uqezVBCy5TJ7Ya6h3ufBTvYDEW/C1tlQiZHuMJhpwdJbY
	n1hkLgvXONVM6MYmyLhg7PBD7uJZ/aaHDOg1RE
X-Google-Smtp-Source: AGHT+IHMV2qBYTO0vCReBGwYn8OHLadnooXnLpqoTMKvoeyCflC22++kO5lOoA0i475cQnzdLjA6eg==
X-Received: by 2002:a05:6e02:18cd:b0:3ea:4980:7d7f with SMTP id e9e14a558f8ab-3ef0894d108mr50381955ab.15.1756259116335;
        Tue, 26 Aug 2025 18:45:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3ea4e45a717sm82042175ab.31.2025.08.26.18.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:45:16 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:45:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 15/16] packfile: refactor `get_all_packs()` to work on
 packfile store
Message-ID: <aK5jK2Q3McLnJ9Uw@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-15-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-15-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:13AM +0200, Patrick Steinhardt wrote:
> The `get_all_packs()` function prepares the packfile store and then
> returns its packfiles. Refactor it to accept a packfile store instead of
> a repository to clarify its scope.

I think that clarifying the scope here is a good idea. But I am a little
sad to see this patch proposing that we drop get_all_packs(), which IMHO
is a useful convenience function.

In effect this is pushing out the implementation details of the
packfile_store out to every caller that wants to use get_all_packs(),
which I am not sure is a win. Should those callers care where the array
of packs is found, or have to write

    packfile_store_get_packs(the_repository->objects->packfiles)

each time they want to get the set of packs in a repository?

I could see an argument in the future where we have object stores that
aren't packfile-based and thus calling "get_all_packs()" is not
meaningful. But I don't think we are there yet, so I think that this
patch is pushing the burden of that future hypothetical on all existing
callers of get_all_packs().

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c          |  2 +-
>  builtin/count-objects.c     |  2 +-
>  builtin/fast-import.c       |  4 ++--
>  builtin/fsck.c              |  8 ++++----
>  builtin/gc.c                |  8 ++++----
>  builtin/pack-objects.c      | 18 +++++++++---------
>  builtin/pack-redundant.c    |  4 ++--
>  builtin/repack.c            |  6 +++---
>  connected.c                 |  2 +-
>  http-backend.c              |  4 ++--
>  http.c                      |  2 +-
>  object-name.c               |  4 ++--
>  pack-bitmap.c               |  4 ++--
>  pack-objects.c              |  2 +-
>  packfile.c                  | 14 +++++++-------
>  packfile.h                  |  7 ++++++-
>  server-info.c               |  2 +-
>  t/helper/test-find-pack.c   |  2 +-
>  t/helper/test-pack-mtimes.c |  2 +-
>  19 files changed, 51 insertions(+), 46 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index fce0b06451c..7124c43fb14 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -854,7 +854,7 @@ static void batch_each_object(struct batch_options *opt,
>  						 batch_one_object_bitmapped, &payload)) {
>  		struct packed_git *pack;
>
> -		for (pack = get_all_packs(the_repository); pack; pack = pack->next) {
> +		for (pack = packfile_store_get_packs(the_repository->objects->packfiles); pack; pack = pack->next) {

If we do go this route, it might be nice to introduce the pattern of
having a stack variable to hold the packfile_store pointer, since the
line above here is getting a little long at >100 characters just to
enumerate packs.

Thanks,
Taylor
