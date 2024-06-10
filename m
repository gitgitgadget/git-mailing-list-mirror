Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D6135A65
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031479; cv=none; b=AFwg9JDZy2nsjCivee8F0q6XqmHVtkuFrq0GGPuWZE9UjgDiYBQNOOFKqQ277oSzM842GEzQhsdRMOhFgSaWiwVdKlri7zJgGkE2WOncHHsLZsk34t5eCtLFbu9dPEyH5YAbDEeOm2PauzrejigxBdgFeAGAXdJFOFmMnXW29Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031479; c=relaxed/simple;
	bh=iyxziCK2NyIK92T+7DULMhflzrVzZDwVOctNtmrF7nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmR3vft/MzFQ/B6le2RpoBjLt/RwqTgFupb8ICUrBSY1G0m14v+/q6M7hGmADpK+k+WscgY20dxr2c5yYge5nG8OuVC9TvYCTMmUt/Wvj3E2K9NsllieFWkabuBRgcb+aB+zRlWRxcRu7qzYVgtLMhDoF1TqtlRmX0mr3aXJxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DkTYgYtL; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DkTYgYtL"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b060f0f48aso143476d6.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718031477; x=1718636277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ1JSd9BRuq/pde/Qwz1OcEjF/kgq3e4YM5CtBAnEDU=;
        b=DkTYgYtLEHtEOpyjLJDzErlaLSj5Y22xDdT1rPf5uJt2ARuUHhpWbkpOoDGo8ZTsxB
         7j2KpNVhNCVXEhqBHEqvsduP8lcOO2vHCLqDnGWOrS766DVWZMvn4rMUp9QLOL02b8Xy
         eCXF+Casmj4QeESPz8GndDJPBh5nViRZr+WQY2LQCLVRFucix4Tlti5fe/A+5jy3JL6g
         VqM/63UefPMfP7G/RCEBYYmM0ymhMn9A7aVUMIbNQzYZ04ZtnMJr6lWidmVNYi8BRRCe
         +j3802Ou1Ci13nQt/Xk0z+Yu3ydJsl+7DV8OiclGuB04boDhBTzTlSoqsH6KPkSGKOr1
         P0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718031477; x=1718636277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ1JSd9BRuq/pde/Qwz1OcEjF/kgq3e4YM5CtBAnEDU=;
        b=YZKA0iygRTSJDvBCNygL1Ooo5tyVbo8qFeW9/plTEQweWK1km7HshUtqPVtC5dN8jH
         BrBLdeUVmhcphkSVu5QWAoQcoJEOjfggBfRU1jOqzDiQ8foap1npyG3yyj/Gm323JrHi
         KEaYGzWT+dygyDUpJWprpJiECawq6Ph4MXTnxAOvF5SoAyWJFsKGMxLV5qKEpQJt3S6K
         dBM/R58uHdz9osZYR86egJKR4tsdcmi0xxT1hVMb+KCDdDptF2aXt501tytk7CkYLdsK
         LEdHpcKO78IZJFc969ElCcN49zIk5Ru+192bQKAm4J4S6265ENSEt7laegUaFNA73plG
         +Rng==
X-Gm-Message-State: AOJu0Yya4J5T86Nf61VCY97CvaZetpsZrpUKZ33x+RVJWRhiU2EH4Bwb
	4FVwbSgY9/Z3LfFqYrmfNyUPSFmyMefhqPJqiDtyKORgl58pogRM57Gcr0D1ubjLeXFKo+8MClS
	h9bg=
X-Google-Smtp-Source: AGHT+IELrK6PagYrzkCTuyFeadIL4ZZyFDYKMR1jd7JAFGWAsItXFCljcEeZ9WPwOXltjKM2Em5r1w==
X-Received: by 2002:a05:6214:4a8f:b0:6b0:6837:752c with SMTP id 6a1803df08f44-6b068377582mr75082796d6.24.1718031476682;
        Mon, 10 Jun 2024 07:57:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6beaa4sm47452346d6.50.2024.06.10.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:57:56 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:57:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] pack-bitmap.c: avoid uninitialized `pack_int_id` during
 reuse
Message-ID: <ZmcUclCErqwyad9D@nand.local>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
 <ZmaVYnmgyAr0vapK@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmaVYnmgyAr0vapK@tanuki>

On Mon, Jun 10, 2024 at 07:55:46AM +0200, Patrick Steinhardt wrote:
> On Sun, Jun 09, 2024 at 11:27:35AM -0400, Taylor Blau wrote:
> > In 795006fff4 (pack-bitmap: gracefully handle missing BTMP chunks,
> > 2024-04-15), we refactored the reuse_partial_packfile_from_bitmap()
> > function and stopped assigning the pack_int_id field when reusing only
> > the MIDX's preferred pack. This results in an uninitialized read down in
> > try_partial_reuse() like so:
>
> I feel like I'm blind, but I cannot see how the patch changed what we do
> with `pack_int_id`. It's not mentioned a single time in the diff, so how
> did it have the effect of not setting it anymore?

It's because prior to 795006fff4, we handled reusing a single pack from
a MIDX differently than in the post-image of that commit. Prior to
795006fff4, the loop looked like:

    if (bitmap_is_midx(bitmap_git)) {
            for (i = 0; i < bitmap_git->midx->num_packs; i++) {
                    struct bitmapped_pack pack;
                    if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
                          /* ... */
                          return;
                    }
                    if (!pack.bitmap_nr)
                          continue;
                    if (!multi_pack_reuse && pack.bitmap_pos)
                          continue;

                    ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
                    memcpy(&packs[packs_nr++], &pack, sizeof(pack));
            }
    }

Since nth_bitmapped_pack() fills out the pack_int_id field, we got it
automatically since we just memcpy()'d the result of
nth_bitmapped_pack() into our array.

In the single pack bitmap case, we don't need to initialize the
pack_int_id field because we never read it, hence the lack of MSan
failures in that mode.

But since 795006fff4 combined these two single pack cases (that is,
single-pack bitmaps, and reusing only a single pack out of a MIDX
bitmap) into one, 795006fff4 neglected to initialize the pack_int_id
field, causing this issue.

Thanks,
Taylor
