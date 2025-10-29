Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804A29E0E7
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777577; cv=none; b=iUggW5fFWMuiMKWHm3RiXtr2tH2uwmrEjGkZIIYySF5RTKp5sdzuqHcxtrJqAx4w9zwcd/TPqbV4xHcFvCQqCidtw9/WDBnNJ6/jP1MIbG9c1w3i+4fQn0rddUmBJothPlxrqQnxYSOQUQQhxcRhm703YNzQR8zxFLp/zu1nbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777577; c=relaxed/simple;
	bh=l5qobD5RzrTVyiHKRA/+yadqMlyCex2Zw+RsToWh83k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kokB/mF8g9a3xz1LVZf3iJIkuBlqo//cceXBMRb+mitRR1ufERUg7/kBKegPEqrtNMmc3xkIdE7x9v7m9ug2VGnzB0S9ScNmZ2wRXs7rcG6n5yXAiT3usAR746EzSFDMpaJkVRpPfd8UMx1A+X9hLq2gQwJcQDaSho6Dj/bxPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=n3O7WMod; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="n3O7WMod"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430d098121cso1513535ab.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761777575; x=1762382375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mp9lMdKVO7Q1Z1qdfeTy+VcNxhGRnytt/2vVpZzaKM=;
        b=n3O7WModa01lkW+OgYdT2hxML+RWCN35MM2mQIFxQCJMsYF2jgxhbAjoTCaS1FE0Q3
         OwO1Omi5KMtBPt7CFmMjzQBPClUjpg/qetJMsbJO4ej0uKRPW/kITeug0MLpTCpOGMaM
         M4VuNpE+ua3lUdxzRH8LMYBYm2cuzhOm76WlagUX6WvbboCGU0TPvr/HARiX3+FpIRZ3
         yj+5Lxot/OtWFKO8IDJJ0rnO6Fi8n8I2gyRxEq8Mc4bdZrHIDXDBYCoxnOpLzUuXdgsc
         YCR1BoGE+QcJgBMuyzPdtJl4mAF84KT/Wu1urKrjEcx0M20z0FhJ/tTGFvwTyjlBylwy
         +/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761777575; x=1762382375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mp9lMdKVO7Q1Z1qdfeTy+VcNxhGRnytt/2vVpZzaKM=;
        b=NLgipdbKIHnwTkQm6XSqXEc028zbbyPXgx1Qz5+HPnq+rPM+vtrw5FSAgS5P46jm5Q
         gMSRgkmmAHlxXZwYwd6HGO3dO4D3gZur+8A945puIJvWNYMEV0KkWxyCbbmt1sSMTnbS
         l8GFPSeigj+CffzzfOo/TmqovySu/yg3B+RAa42NA7JqCcfpV8kV2CVN0wk3ZxvaEBq8
         7Abq2K5/We9QEVL5k1ZI9Fr6HIUnihbPSK9M2fQsgwfDLdnrWkIMjxCu3UddqM77qEL1
         g93ez12FcM/GY326q7q+OaAg8AcWZWFRf5iKShXHhtm45RCntsGmVWIs1sTtb1yq9miI
         yoLg==
X-Gm-Message-State: AOJu0Ywf1/jSk6L+0FjxpIU5578W1qsh45UfIZ/I3Gy6YPaqUew70s51
	SdtGdK0KwqNDXfTj/fCMyFNTO34wDHCzU0o3Ae4ytLslwahsXfbbawIuNJBv/vzPyIBkRPhD8Zo
	eaPaHEvM=
X-Gm-Gg: ASbGncsK9lEVzLa9CzzHwgQPlMUo25KiOIvdDf/ga+56ccC0MkXcF/RX2CKPduLJcXK
	8h8S54PPVBLwJkJpx6D5RpTMIMCzh6BwWo87vqMFFTh2VeYMVazA8ndfk1Yuf7m5cx3QLzsU3qW
	Rxy3cNhT7WMsy6tbD2nJ5C+T4C+woHaCF9FCVeto24lmyIKiTvruIsbnrgK0jL2RtLWv2Tlnt4x
	aJutSwUbnct9hAiP5XHz5y9z0XmJ+PUSVf9XSL9J/REVJ8SCXvgM2GMN7tENaxa9wkhIa2WIIZz
	2wPeDobhBPQbAitddgJkxmIezgQ/OsaC949zebAwNbThcq1K6U15n8zVKj4DW00H+NmZW5kfA4z
	ihB8MK6IF/HgXD4SI4Qd9UgA7us2OybRgO9FUfU9gGzKcTHh/DKYU5wjjFhQNHV02D2bAQimXGN
	f1K3kx9pyJBO6wueECD6c+Y1myW4i6YWItHAWdQyHdRfMvt1oEOZES800SUFPlR1/KS7nU3AoC9
	0UTcgDieyhUaH8tlQ==
X-Google-Smtp-Source: AGHT+IHHyOiH1T2A5B6fhM2pWh4JziaEpPQZcHuWPkKY+wz0oeEmCHZ+FCcpAu0juPk5I8uyVnkhMw==
X-Received: by 2002:a05:6e02:1485:b0:430:9104:3894 with SMTP id e9e14a558f8ab-432f906644fmr57097375ab.30.1761777574863;
        Wed, 29 Oct 2025 15:39:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-431f688c96asm61562125ab.30.2025.10.29.15.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:39:34 -0700 (PDT)
Date: Wed, 29 Oct 2025 18:39:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] packfile: move the MRU list into the packfile store
Message-ID: <aQKXpM8g3Oy3DVAa@nand.local>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-2-1a3b82030a7a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-2-1a3b82030a7a@pks.im>

On Tue, Oct 28, 2025 at 12:08:32PM +0100, Patrick Steinhardt wrote:
> Packfiles have two lists associated to them:
>
>   - A list that keeps track of packfiles in the order that they were
>     added to a packfile store.
>
>   - A list that keeps track of packfiles in most-recently-used order so
>     that packfiles that are more likely to contain a specific object are
>     ordered towards the front.
>
> Both of these lists are hosted by `struct packed_git` itself, So to
> identify all packfiles in a repository you simply need to grab the first
> packfile and then iterate the `->next` pointers or the MRU list. This
> pattern has the problem that all packfiles are part of the same list,
> regardless of whether or not they belong to the same object source.
>
> With the upcoming pluggable object database effort this needs to change:
> packfiles should be contained by a single object source, and reading an
> object from any such packfile should use that source to look up the
> object. Consequently, we need to break up the global lists of packfiles

s/lists/list/

> into per-object-source lists.

How does this work for alternates? My understanding is that each
alternate now has its own object source. So to perform an object lookup
in a repository with alternate(s), I am assuming that at some layer we
need to iterate over those sources to then enumerate the packs in that
source looking for some object.

I would have imagined that packfile.c::find_pack_entry() would have to
be adjusted in a similar way as above, but I couldn't find the changes
in this series, so I feel like I must be missing something in my
understanding of how this all works together :-).

Are packs from different sources still connected somehow such that
iterating over the list of packs from one source will enumerate the list
of packs from all sources?

> A first step towards this goal is to move those lists ouf of `struct

s/ouf/out/

> packed_git` and into the packfile store. While the packfile store is
> currently sitting on the `struct object_database` level, the intent is
> to push it down one level into the `struct odb_source` in a subsequent
> patch series.

Before sending, I was confused by "Consequently, we need to break up the
global lists of packfiles [...]", since it wasn't clear whether or not
this series realizes that goal, or pushes us in the direction towards
it.

But this clarifies things, and I think is the reason that we do not see
more invasive changes like needing to enumerate the MRU cache of each
store in order to find an object like I mentioned above.

> Introduce a new `struct packfile_list` that is used to manage lists of
> packfiles and use it to store the list of most-recently-used packfiles
> in `struct packfile_store`. For now, the new list type is only used in a
> single spot, but we'll expand its usage in subsequent patches.

I am a little curious why we need a new list type and implementation
here. Is it to avoid exposing the list as part of struct packed_git like
we are forced to do with list_head?

I could imagine that you might want to avoid exposing the "struct
list_head mru" part of packed_git to avoid the suggestion that all
packfiles (including those from different sources) are part of the same
list. But if that's the case, I wonder if we couldn't have kept the same
mru list and clarified via comment that it is per-store, not global.

I suppose that is a bit of a foot-gun, and perhaps that is what you are
trying to do here, but after reading the patch message a few times I
wasn't clear on what the motivation for the new type was.

Thanks,
Taylor
