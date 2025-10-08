Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3B2750E6
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956241; cv=none; b=lI2+hIqaHt30yLroHTHeUVETRvGa3DbWcAF6lsxLd7ukfAilcaSIPMF78a/Tf9CvaF7w2sgEqQcPfXWSeXY0aHR+mSMx7QLni7VY7Oco9glNgOo3boDMfE/vtySqAMZ/z6irBdC/OJu2dQBvOBRuHCtbZY3RvtL0wtpxTnQ/ONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956241; c=relaxed/simple;
	bh=t4Kxlktu6IQNbE9EVKNFq+MwLX6Ev0kFXVBEQykq558=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBsgyxDQawbnAS7DLBOLUoLyqQPGtraA01em7H2z/yd3d2sGBXF+iiHGAUMXIvIFEMMhlxE4U2cbhCqHCLztm5pHKIRf9j3rJHlBQ0olHnhWRSwdlPDYjaG8QdE6OXAdf6Iow3MXT/UPLPghuUKqlBJq8T2ufUCFTKCoU3JwoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GWMsqUsT; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GWMsqUsT"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-42f91f09a6aso40255ab.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759956239; x=1760561039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx0vm2Wl69Zg6IGbInRww+oewCA9ZshxAxkXxIPwkc0=;
        b=GWMsqUsTbynrQXuhvSSamI3Ir8GWH+Lolm1y4gcQ4hYhA/k6ZPJDHz8zlCkB5ZLQZU
         2k3EoGTkV2nsoC6GTQ3T9jgfnc2YCVLbwxeTS7H8kg+WUBIJevVqm36fq2zhpo4bzAYJ
         7SfCbwhn24FRDfCf9I7cv35UhRFtKrHAbHAkkl/8JSCR1ndpTf+BMQEbDyyT2h9fbW+y
         fXOGq5ExE+61rqgoV5okmvwCllMCDusPJtQTtx2KytrTrj0zD32Lpr+R3H5Eewr/CJYY
         JT7Ym4P6HFbyCWJKY9iM4aEKyOK1sRQpFbtFVIP2Z+3MeSEiwEpw0Ndf6nPhrl7MBfa+
         LSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759956239; x=1760561039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx0vm2Wl69Zg6IGbInRww+oewCA9ZshxAxkXxIPwkc0=;
        b=sjXjT6yk6A3Jme+2ME4cSR8Pzqh1HauddCCAca2HJLekukfNgR/JmAoIjJgau6fYxJ
         eeFoRkH/QmHGQzpNnEV4i/RrYaSZTVUxOBze3tnjxuS7fh+Si9GdYpLICA80rlBu4qC7
         14sTZa5tcHL/wlwlDEAucciFXabMwpruPJW17PV4Ho8xntzamB4euawinWB+lzT6Tmko
         As5JZZohNTixBHOo5Gxf14Pxk/EioibeZbKJn2Ua5p7EqJMdx6ooXoF/63v/sy5t0lr9
         uS1MnmXrJ7ee+dgUiZVqjwURg8V06hx8nNwCAC6rFsU3vQYRVa5BYn5ef+ZEyb6raNZq
         P/Rg==
X-Gm-Message-State: AOJu0YweK/iXAKbm6KJnlqclsI/4/orFSTOlixtDHLFSEA6IJl9iZJro
	9wOlOMFFQL1YF/c1sleNOgfNodg2q30Pfczqu2uBi6u8ysed991DBjT0VkJMtBv0JTWsPjjf1HA
	pL9jOqlSOKQ==
X-Gm-Gg: ASbGnctpFwHCyOc8n3iItwS4hhd4lkuClg1pNAW7rsuRHQvCF5v0BCXKhvKTrQKnWqd
	VGrSnkk9ZruO88/nUs93CMJQav8S8zFikP7XkG4htp1ij18u/hHBSQ424ZL0/3QHK8KwezYADk2
	25IFf8M4LLeReChlVqE9dcqj2ESkqOQc89KIu3ZnL3LhD9Sn4Xq9lk4lBy2g+Urx2VO4fgj1LKT
	5FThwiZoFIg2q0rFBF4DKkaOX0KZ4Cc0WHuysir6zegswcj39Gd7PRzh9tCcJdLRmezkuPgLug+
	uqATkhYrEMS6Ivrajw0uq9RwZxwcjsyupwQh8aaFTVr3fB3WgEsRLBemF0kn7pk+GiEXS9RJQZm
	lUiL5DHvs1JiJAZT6Yvt/VBbwqSdEHx0/H5vu7ePkQtLIhBr8VYHqGKdsL6CVFSd0Z59mvdl0md
	wb7EBhxeJVBbC1IUoXHbgXxfKWFEfTV2zmQ6dk0nQ3A1Uu3dVQCA==
X-Google-Smtp-Source: AGHT+IEXvdt6XRb8jrWSR8jAWazzvdddoJXGHSUhS1WzPN3TUzHZ9DetOwhWLiPyw4OtTNoMWzqlsg==
X-Received: by 2002:a05:6e02:2782:b0:428:9913:509c with SMTP id e9e14a558f8ab-42f87403c6cmr45379885ab.18.1759956239123;
        Wed, 08 Oct 2025 13:43:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5e9edfd6sm7437506173.9.2025.10.08.13.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:43:58 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:43:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] builtin/grep: simplify how we preload packs
Message-ID: <aObNDRTffcWsYGZ4@nand.local>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251007-pks-packfiles-convert-get-all-v1-3-428227657a89@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-3-428227657a89@pks.im>

On Tue, Oct 07, 2025 at 02:41:09PM +0200, Patrick Steinhardt wrote:
> When using multiple threads in git-grep(1) we eagerly preload both the
> gitmodules file as well as the packfiles so that the threads won't race
> with one another to initialize these data structures.
>
> For packfiles, this is done by calling `packfile_store_get_packs()`,
> which first loads our packfiles and then returns a pointer to the first
> such packfile. This pointer is ignored though, as all we really care
> about is that `packfile_store_prepare()` was called.
>
> Historyically, that function was file-local to "packfile.c", but that

s/Historyically/Historically

> changed with 4188332569 (packfile: move `get_multi_pack_index()` into
> "midx.c", 2025-09-02). We can thus simplify the code by calling that
> function directly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 13841fbf00..53cccf2d25 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1214,7 +1214,7 @@ int cmd_grep(int argc,
>  		if (recurse_submodules)
>  			repo_read_gitmodules(the_repository, 1);
>  		if (startup_info->have_repository)
> -			(void)packfile_store_get_packs(the_repository->objects->packfiles);
> +			packfile_store_prepare(the_repository->objects->packfiles);

Makes sense. That function literally calls packfile_store_prepare() on
its argument, and then returns store->packs. Since we don't care about
the result as you note, calling packfile_store_prepare() directly makes
sense.

Thanks,
Taylor
