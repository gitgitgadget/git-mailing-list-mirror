Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3D374EE
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Yftf8SJT"
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F5D3C0C
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 13:22:19 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cd4446cf5so8803681cf.3
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 13:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699564938; x=1700169738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKlkyE+o+1zNvrT4ACnIJJrhQ8bpp+BecOTD6r9p4DI=;
        b=Yftf8SJTJDPa/oNrGveBxoYkOLuV+Ew/Hk+O7pb+b0VsYbHunDoerpxnu+7ENxgmvT
         HTNlI8k4Lpxr7mcBWUVjyZUUpFHfQIu2waro2m0MGQyBWXiyg0qbZnQZTeCgzyR8irbQ
         AImTf26+dUJmLGGn1HS10aZQyXGJJqZ28PsZnA6EW25aFEpDQ7MkP8H+smWz8ckaG62D
         ASPEcE4qONfs+0vzys3ANdLy85EeEqZ3qd+IeUBa4dm5dywlgsiPSCrsTuaKfU0BNBat
         ivXDvix1M+QYTmY1rETAsCbxJhw2TdD/OeTsWSDc5Go3KOSp8l/62N8EVasEokvCShOh
         Icbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564938; x=1700169738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKlkyE+o+1zNvrT4ACnIJJrhQ8bpp+BecOTD6r9p4DI=;
        b=LB5Aa3RJjN+xHiu9g9u1OWKV9KECclf/Zrdd+x4tADzQ/s/RfrPRnv1gQ9IBIc65wG
         R9V3jnH/9cawN1rKsVfDjDWrVslFgAftRYYtf0vnHzuXEQjdNtxhMI+JJ75Arl1PCPjD
         1k+LFOr6ZWML1RTHLxinFCFaLotdk4T7dkBLBUQzoUKviGlwsG1f8pXWI6e2GDopGTn8
         iWSssES+QOh9c9nD9dbCFqmD9n5/OdC7ISP8T2S0V7eEhSabTvEx6DjjPGxR5DPmpW4x
         lbjY/m0LFzTnGyHunfNVUPWkvLRluDuhxqcYGOkKxbuzcv+xVKrfSPFPG8n0D0dXUoSR
         GoDw==
X-Gm-Message-State: AOJu0YzJ+3Opki+p7GHaeOpMuFM9NHgsNOo3ajs6k8qnajkkdsJ9aVvC
	PU4evIdEyPzg9kEIwJXaZUISe/j3Ps9bdP0pL21fqQ==
X-Google-Smtp-Source: AGHT+IEs7uioKwFe6nyWEQP/HYwOwy3ydAFlWDRlW57BnEzUNXwhMsm5ufoNfNVvPk43lY1oy1z44g==
X-Received: by 2002:ac8:57d3:0:b0:418:1002:cfd8 with SMTP id w19-20020ac857d3000000b004181002cfd8mr6857208qta.67.1699564938485;
        Thu, 09 Nov 2023 13:22:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w6-20020ac86b06000000b00419732075b4sm2265785qts.84.2023.11.09.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:22:18 -0800 (PST)
Date: Thu, 9 Nov 2023 16:22:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] some more chunk-file bounds-checks fixes
Message-ID: <ZU1NiRs2eN5hDNgI@nand.local>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109070310.GA2697602@coredump.intra.peff.net>

On Thu, Nov 09, 2023 at 02:03:10AM -0500, Jeff King wrote:
> This is a follow-up to the series from:
>
>   https://lore.kernel.org/git/20231009205544.GA3281950@coredump.intra.peff.net/
>
> which was merged to master as jk/chunk-bounds. There were a few issues
> left open by that series and its review:
>
>   1. the midx code didn't check fanout ordering
>
>   2. whether we needed to sprinkle some more st_mult() on it
>
>   3. improving some of the error messages (translations, some
>      consistency, maybe more details)
>
>   4. possible refactoring with a pair_chunk_expect() API (Taylor posted
>      a series in that direction, which is currently in limbo)

I read this series thoroughly and was very pleased with the result.
Thanks for patching these up.

I think that I am still of the mind that it would be useful to have some
kind of pair_chunk_expect() function, so I'll try and rebase/rewrite my
patches on top of your new ones here.

In the meantime, this series LGTM.

Thanks,
Taylor
