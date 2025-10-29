Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AD309EF8
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761780309; cv=none; b=ej7JZPuLCSY0PmMdFIMMWW3FkD6xzHX1NWm3gP/GPVoNVkCNJS8X/Kiuj2PJ5xdV0ox9Tr1OOO53xrz9BxVqxGkz1rv3OciVVR2PeRKvAxDuT+IyQA9TeLRN+SS5WwHZpDTdood+TUg4xSKBjIPbvcuGyUfz2NmHTnXYPma0enM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761780309; c=relaxed/simple;
	bh=pBsA1bBrk5eOYyLzZnchnRR5gK0MK6zW5oNrybSR9Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0e0W4hi/xfgkzI6p29zOx7GnZpdpMklYx7HdwL//FpZnvKDSe6g2ws/nP1w/S39NeaxXvJvN2Ew8n65NR+vCbBjvcts1eyVfPkC0CGcZr60bWyUJvpQfkYoZMZ+0apXebC13MxRvibsXePXuuNYnPDWFeUO++qqHQPNh2NoZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=I5cL6FHE; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="I5cL6FHE"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63e3804362cso535561d50.2
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761780305; x=1762385105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBsA1bBrk5eOYyLzZnchnRR5gK0MK6zW5oNrybSR9Hw=;
        b=I5cL6FHEr0NcJ1GDgYgktmVfWeMKilGhDEbk79WGOBpsLyDNDmyRB3tP8/rBLCCt/Z
         WouiUmRW9NfBSu2ol7GowfbnTcHk6sVrLrhcrjOC8OuGfHVp6uQR53xDhZ/5kgmOAYB/
         7ABM+x96sify7n0ZhYH58cIAXY6PNl+qvzsdL55rJYwShjVd6a//LA/9viPF3an5830r
         dsVV+nAEW6sytDC+DPcAFBXQ3MzZsofaJifCAb2wtAueSE+In3NclJIUYlsPNPMZfjcL
         RIaTQeYyqqUmUUD1mhJO2GbDcYdb5bCk2+M/wB05FEfE5JONgxa7En6WP0JsqR1MBl/F
         XubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761780305; x=1762385105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBsA1bBrk5eOYyLzZnchnRR5gK0MK6zW5oNrybSR9Hw=;
        b=VHte8GAZhwGI/AB2KcD0G+E9huhh2tItxZjScJp7JTD7Xh0LNELWSVTHo9xMJH4DjG
         pU6803JljpQhg92EQAdinSyUG2ijrGgK5djefd6vWZpoAmdULrFNjRPZLVKAFqmxvWk9
         3puPsJgqLpU1Gnhek6u7fOD9dim8cKNp5y6ndYKtnzRQVmsQw8e7/1DyaZOfjO6FpKJ7
         YqxX0EjnRIPNBK8ueUQxCF41lcCxS94QtpRrbcur6uR6cdZE/hOzm5fFZx/wjMFIkV7A
         cjmhIevLhAMtIiTBE9Q7yeeMWt50O6uvCmZseZHsG3Wdzg5q4UU+HujbJGz25IGRtaRX
         Y1PQ==
X-Gm-Message-State: AOJu0YwtBxFuIoaBYNjdrNjr5ay4Km/3aFhJ79+V3z1UmapBNph9E3ox
	AUpIZhwhrYZyfpV/31MSI2dAoaOcneca3sE7SCUSy5HOXv48f8OpKwmxDWX/Q3Rhk/4=
X-Gm-Gg: ASbGncuVzVoqMsEv/IslhOQOdkXpApSQw8Z12EtfLiXhBFAL184P5l3h4bRkHVTLYvX
	VnQjo17IOIzo2rS2WVRLI7LDWhYJPseGWwkmErNx9rKKaVKs4wQWAOHneckmmbMxSUgoCOarxuJ
	fqeeeknDe0xYuoOjAZmQU3aF+xGhFdD2GVStX6jIfuUiVhsJa27y/+zJHo77wmadMAmBP/EOUv3
	Dj1ZPu+I8HyR3dWu+/orxPcN01Sqx38R593I+6Vavac7aa2EmRXjm+ZLtHxNTM45sx/qR8YkpPa
	GvmXcTqCrwmTozDrp/RdjulJ93ypPfYl+zbA0uGoC8CotEu/JGsyQl2LOyLTpaetBmo/d6wVTRf
	fnh5ABdRP8abK2bXCedIoiEiPLad7OyfIHppXcKrHDIaITjhk7y+Ltq6M0Nc+/09NnPte5P02cX
	wIU3blXfO1hEKBsgoozdvS+AL9AquZtmfaihTTrcOyK0S5AJLjEiGoLlIBQ7EMbckGonjgyCOzd
	5y8GjIBjYZpfYyDkQ==
X-Google-Smtp-Source: AGHT+IF/gSuH7nBvu4J39N9uv0WORnDDUrMJFdREoU8FjcfTxErEzTWHDML7dBymywiQGavBZPlmew==
X-Received: by 2002:a05:690c:6d13:b0:783:67c9:6d6d with SMTP id 00721157ae682-786390f5ccemr24632407b3.61.1761780305313;
        Wed, 29 Oct 2025 16:25:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-785ed1fb943sm40996097b3.61.2025.10.29.16.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:25:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 19:25:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] packfile: always add packfiles to MRU when adding a
 pack
Message-ID: <aQKiT9JA+3zF4DHA@nand.local>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-7-1a3b82030a7a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-7-1a3b82030a7a@pks.im>

On Tue, Oct 28, 2025 at 12:08:37PM +0100, Patrick Steinhardt wrote:
> When adding a packfile to it store we add it both to the list and map of
> packfiles, but we don't append it to the most-recently-used list of
> packs. We do know to add the packfile to the MRU list as soon as we
> access any of its objects, but in between we're being inconistent. It
> doesn't help that there are some subsystems that _do_ add the packfile
> to the MRU after having added it, which only adds to the confusion.
>
> Refactor the code so that we unconditionally add packfiles to the MRU
> when adding them to a packfile store.

Reading this, I thought that the MRU cache lazily added packs only upon
a successful object lookup, but looking more closely,
packfile_store_prepare_mru() adds all of the known packs to the MRU
cache eagerly.

I think I would probably advocate in the long term that we go the other
way here, which would be to avoid adding packs to the MRU cache until we
have found an object within them. But that is a larger change, since we
don't add packs outside of the MRU cache to them, only move packs which
are already in the MRU cache around.

But I think in the immediate term what you wrote here makes sense, and
it makes the behavior consistent in the meantime.

Thanks,
Taylor
