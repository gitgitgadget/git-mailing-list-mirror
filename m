Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vPq49xF6"
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994A2E3
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 08:48:14 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-425a76bb53fso31074921cf.1
        for <git@vger.kernel.org>; Tue, 12 Dec 2023 08:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702399693; x=1703004493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t95ElcZOvM8SZkh5TtJYw/wghfTlhzZjvRseinyzdqM=;
        b=vPq49xF6+FlZfrgiU/vyUaPRNM1HIlf+UkMP4QZBqYEomsj7Wl4NHow8n8onYuaD3p
         lmVZ6gAaTkwdngLEgup60Mtchz2UXcmvXi+eOfq/bEwfk05SBQF7/IKmWbrOxj6NSs5f
         2bPu/ZMWDMZw7ZaIx9cTtiehCflw1tuBqnD74kZ68oiZG+FmpfX+Y/CIt5qXa4czFaIk
         capHeSZoLXIQWTQdgq/gaCfpLGOLkdEwAr9MOe5MdYrLT6qndLDvbBLGyQmgNUuQvGUb
         hgtz1us8RRMlODna4Qx1Dd5kMUv+N/LOKRZD5hxEGZ6Ua/m5XAuP+yAJEWV6cVcUpFBt
         leUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399693; x=1703004493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t95ElcZOvM8SZkh5TtJYw/wghfTlhzZjvRseinyzdqM=;
        b=MOnBCXOkPAg9i+cd7SYgTG7vLnK2r6nPQoecXdXrTB2vfuQH3Jjwc4kwwoHSJ+v3JZ
         AuXY5QKLzeN2nv3C/Y9LOxvVvrE3SsiNLfXdLEPqvnvcz/vNdd2SSWxkvqlAZf0EPlF/
         +ZBAgU/RT+9TleAg7OBaZmi+ERD0rdVDDnLheksO9dTD+2dwKntIdDKIGn+WnOVUDj0U
         2C6a7Yvb5Vc2D+UTN1j8CAkgAGRbnKTYaXrpILLcVcKBds72sSsZmOsab9LUWQbeXDUv
         gjIV8JBljfgE+VPDuLhDlogVW//uDdqW3ndVF/arLS5CK5yfjQQ+oQGujwK1CMZ2j4SC
         0SsQ==
X-Gm-Message-State: AOJu0YzmJimByRp34373ZXg0b7Ns4zl4XtLlS9k9c25vRN9O+y8wmFIL
	mOyTjYImBIpdaM6OrN1uyimer67HW6uzIIs0ZH4=
X-Google-Smtp-Source: AGHT+IHQOQ2sLpUiZm/pcHv76yl3/sM0dviwli3q1mKyjJ+8UsKb2FSzfPXpzW4YGPKa0MbC2ehf6w==
X-Received: by 2002:ac8:5a86:0:b0:423:93a5:32 with SMTP id c6-20020ac85a86000000b0042393a50032mr10423708qtc.31.1702399693678;
        Tue, 12 Dec 2023 08:48:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id jr12-20020a05622a800c00b004259b7e6bbcsm4160561qtb.33.2023.12.12.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:48:13 -0800 (PST)
Date: Tue, 12 Dec 2023 11:48:12 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/24] pack-bitmap-write: deep-clear the `bb_commit` slab
Message-ID: <ZXiOzN4T06yy/NvV@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <6f5ff96998946f3f49da56fd05c096b949521339.1701198172.git.me@ttaylorr.com>
 <20231212070406.GA1117953@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212070406.GA1117953@coredump.intra.peff.net>

On Tue, Dec 12, 2023 at 02:04:06AM -0500, Jeff King wrote:
> On Tue, Nov 28, 2023 at 02:07:59PM -0500, Taylor Blau wrote:
>
> > +static void clear_bb_commit(struct bb_commit *commit)
> > +{
> > +	free(commit->reverse_edges);
> > +	bitmap_free(commit->commit_mask);
> > +	bitmap_free(commit->bitmap);
> > +}
>
> I think these bitmaps may sometimes be NULL. But double-checking
> bitmap_free(), it sensibly is noop when passed NULL. So this look good
> to me.

Yeah, bitamp_free() handles a NULL input correctly, so we can pass a
possibly-NULL `commit->commit_mask` or `commit->bitmap` argument and be
OK.

Thanks,
Taylor
