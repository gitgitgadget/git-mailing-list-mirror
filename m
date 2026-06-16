Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC33E1713
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649479; cv=none; b=crsxlrijN2kEL0KS5URFyVJ8JSJW1ihKp6Bxhxqe/R0A377ZQESoL9ruWOtmypzJTUsK8WiTyZnNLr2cOYJmPIzlOiqQ3IMSWrI4ZntePUEMYK0MTMIbyg2I4AgNGBFTwnK2nb73gOGwYiRcPVwm7snKCJHH3JY2mkOgbxP4PL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649479; c=relaxed/simple;
	bh=9OWNnrack4o/ZPr0aDMlbCvu6udfYvHHACotNqfA8go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fht4dOIVipuUugdy5fyzp4fuVTWo0cVMFhDdUYYu4xZSa5i88UjE5t0urfw1Jd0EDzq8ELBxGmF3mciPVJtP7Yd4MEHw5cZB8DjVBbNQi3KA1cc0741GoeUqnTgll7707B0bv6/7Z8JBjYlvuPs6gVfrHsFYLfHjCGMSkr7fga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pImBZeKq; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pImBZeKq"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6b554044fso4175735a34.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781649477; x=1782254277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2KV4GUhze8/NHeQElraHfl7Ljg3KtwzGU2pNdMUy3A=;
        b=pImBZeKq7hSBNmEudECScItsPTSPQPSzXU8F9dIMU/ygX71mE05deUC8bjYC9NJLQa
         s5nTGpMtoCvoycCra8amOWLK6rz+8/cMTEntWum/1e/VVXjKq0loNcjZa9fnItKC/Eol
         7P1I+S4iQIAPXBz5l55m/CxDIO+6rJb9PsDJ3D2uqMW4rwTyfdMZi5Skt+yCA/DRsZIl
         j8AaiksFnHzCWPUThx3UDxrLODocf1VrkXEo3g5OF2cBsY1S3fpk777rqotAY7sNsZaC
         WSPgGKD8gryRZNOhwBwlAinbRZSuqW74Z6f4SOE8U2Z0X8T06FCqnmGy0JSsd+ra4nO5
         4uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649477; x=1782254277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2KV4GUhze8/NHeQElraHfl7Ljg3KtwzGU2pNdMUy3A=;
        b=Kn9wnfhnFYsF9+tQqou6yRdfzJjLW/peIx8rQYcfIG73Zrj7QvxWr6hnG+piXtVPi/
         UmLF52TWCb/oNIDhCU6Qt25MN9iL+ntIiuEt/c/55TZ76hT+hJlsOhozGpPjQespQkWQ
         qcp4bkhE9vtxyIEDtvxMS+rD3pY9S+ezcw3z+woH3o2L66uRudta70CDpS+ElZ3PxXPq
         S4FaISkg7fCFDwmvMa9BSM5pUpAbeT1AsEM1PhcJ1PxY+DR9QeHyPKyuH8bLCWsTZHzE
         DOF3Y5b1a30hYWB323hW8Pq/1JjRmJxxWz10e55jBODIoL1F1YK/+j0NpaahD0ctvxhG
         FCOQ==
X-Gm-Message-State: AOJu0YwPc2QzkT/RTX1ZYzhTEzos4kNEm5tMFnxGUQUx18mG/pdkrN8x
	hKw2Tq168e9lsELtVkrnX8OWEBCm2f3dJ/Bkza4EPLGSbRlTluKrAb0K
X-Gm-Gg: Acq92OE7ST3BeAx952Dsrln4reOf3L6AzF8tagp2pjDK4JxCiq3KABt1eKEO49UgghK
	HYKqjb5IcsOrlYyDbwEsV+T9IrUDNjI/gaVI7vGEXDg5zB/0+JBgGK66wGyztvgdM7shLCNzacc
	370IXTGccdMQjmmsV7DN38r96KbRh5DsUjtSTp896bp08SQbsKRiOrZSJmmvM15gDvJLUkMJRUw
	vUcKPlr09m8JbqAcCo1qvYPIAxqhinj02OvpB4zeryNIvOBm2+4RgQzNOPjtz8xduK//0oGcbSr
	6A7yW746z1KbveSzJUZnu6ObW/fWlVo5uO7kATYL+mgPYGfZDEmPZypP/jGX6K7amV+piqs4c6Z
	zM2myUb8qL2QL94ruQilLv9H+Y/IMFEziRrYGMR/M/LlswN5yEZA6dfXkKpfhO7kJdY6zrmN0dP
	FSriYNHdPQnIozgkNW
X-Received: by 2002:a05:6808:1301:b0:479:d57b:83b0 with SMTP id 5614622812f47-489445f1806mr1171678b6e.22.1781649476846;
        Tue, 16 Jun 2026 15:37:56 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dda608fsm5327630b6e.3.2026.06.16.15.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:37:56 -0700 (PDT)
Date: Tue, 16 Jun 2026 17:37:53 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 16/17] midx: refactor interfaces to work on "packed"
 source
Message-ID: <ajHKmbimHJnFV2IE@denethor>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
 <20260609-pks-odb-source-packed-v2-16-839089132c8b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-pks-odb-source-packed-v2-16-839089132c8b@pks.im>

On 26/06/09 10:51AM, Patrick Steinhardt wrote:
> Our interfaces used to interact with MIDXs all work on top of the
> generic `struct odb_source`. This doesn't make much sense though: a MIDX
> is strictly tied to the "packed" source, so passing in a generic source
> gives the false sense that it may also work with a different type of
> source.

A `struct odb_source_packed` now acts as the source specific to all
packfiles in the repository. Being that MIDXs only work with packfiles,
it also makes sense to me to use the appropriate concrete source here.

> Fix this conceptual weirdness and instead require the caller to pass in
> a "packed" source explicitly. This also makes the next commit easier to
> implement, where we drop the pointer to the "files" source in the
> "packed" source.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/multi-pack-index.c |  29 +++++------
>  builtin/pack-objects.c     |   3 +-
>  builtin/repack.c           |   8 ++-
>  midx-write.c               |  34 ++++++-------
>  midx.c                     | 118 ++++++++++++++++++++++-----------------------
>  midx.h                     |  30 ++++++------
>  odb/source-packed.c        |  12 ++---
>  pack-bitmap.c              |   8 +--
>  pack-revindex.c            |   6 +--
>  repack-geometry.c          |   3 +-
>  repack-midx.c              |   9 ++--
>  repack.c                   |   6 +--
>  t/helper/test-read-midx.c  |   7 ++-
>  13 files changed, 144 insertions(+), 129 deletions(-)
> 
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 00ffb36394..6e73c85cde 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -10,6 +10,7 @@
>  #include "trace2.h"
>  #include "odb.h"
>  #include "odb/source.h"
> +#include "odb/source-files.h"
>  #include "replace-object.h"
>  #include "repository.h"
>  
> @@ -85,12 +86,12 @@ static int parse_object_dir(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> -static struct odb_source *handle_object_dir_option(struct repository *repo)
> +static struct odb_source_files *handle_object_dir_option(struct repository *repo)
>  {
>  	struct odb_source *source = odb_find_source(repo->objects, opts.object_dir);
>  	if (!source)
>  		source = odb_add_to_alternates_memory(repo->objects, opts.object_dir);
> -	return source;
> +	return odb_source_files_downcast(source);

Now that we are passing around concrete ODB sources to many of these
interfaces, callers may have to handle downcasting explicitly. Since now
the downcasting may happen a bit ealier than previously in some cases, I
wondered if this would alter any error flows. I don't think this would
be the case though because ultimately we only have the "files" source
currently anyways.

The updates to the function signatures and call sites accordingly in
this patch all look good to me.

-Justin
