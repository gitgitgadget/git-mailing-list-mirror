Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nAabd3ST"
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F903D8
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 11:59:45 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4259cd18f85so28035371cf.3
        for <git@vger.kernel.org>; Mon, 11 Dec 2023 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702324784; x=1702929584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yp42bgQcCvWtmFa2p4tfcGrxkccezn6nCn+HQlwWE8g=;
        b=nAabd3STTMB7BJYcpE0boCIAPwLja4nPi8QEYM+OV6pvxb7aP/qjv6OzTODOLxR2fx
         sbPDOiNMDAQeRkqBc8rAKD+o73kHz0pwkVvwPha6iB/0jlnr+GKBljxjK/vxZjlxvt6+
         D6BcNJcYoqWMRVuco0lmXD4dB89m9xtyGVW7aOz6QR7PhDk6h+nJnL8WBH3BV7DXUPCx
         Fo4ZyS+j1lsKjfd4HZM7tTGsd3BHAlNlrQk0bo43FlBTMcOTqbP8DwPD2ZJeH2pjsmL7
         YyjSUGpYtx/HtdzXpuzZduNpT2IgVRkqZKzCjPkHnDH1BZVqWXcd9Ry+dajeETE4VnqJ
         wJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702324784; x=1702929584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp42bgQcCvWtmFa2p4tfcGrxkccezn6nCn+HQlwWE8g=;
        b=GZ0Akku1cFn2HqqcWW7Gs00uU6Xsie2pMV0wj+rmGX+2lAaIfDUDoZFSmMVeMf2ilP
         26CRhAFYW3Yf5cePK5D/MR0c2+FfYFSvYg+m2Y+94ctMpv+l/H69Vd1fK1bcmBeCpWGS
         Tgsg6WZGuoEdGvNhFlAPmUTxlwRsIEZFVtSgBB+v66dxktMhPpKNW9ohWz2ip1TZqxVo
         wS+Pl3z0sm07Vr3Bo6nGe5d2iZPSLAGSBBKcU7+RhGOmn/Za5KNSy/uKETNDQTrsKvV8
         jCI7ZpZqQvTbla+zu+nnx9L03CzGJ5M8JJhSVvev7hQKD/qxGQ3gmUzhHdiHUe252L/3
         gjfQ==
X-Gm-Message-State: AOJu0YxSinRnW/aeLto8K9fbmH7JOCIghNv/fw1t6yohFZIJ8CahgRP7
	NPTRVCkgpQY9Rmj6FvY+olgtV2sPsP+XPnjE2sQ=
X-Google-Smtp-Source: AGHT+IE5m+RJFS7FxioM1/AHbWoYF3rrnpEb67Nm1/vyJaFWsI9GYX7chg8g4NHeT6yXKxvzkLj1lQ==
X-Received: by 2002:a05:622a:138b:b0:425:8638:d0b2 with SMTP id o11-20020a05622a138b00b004258638d0b2mr7222405qtk.122.1702324784603;
        Mon, 11 Dec 2023 11:59:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z24-20020ac86b98000000b00421b14f7e7csm3471565qts.48.2023.12.11.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:59:43 -0800 (PST)
Date: Mon, 11 Dec 2023 14:59:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/24] repack: implement `--extend-disjoint` mode
Message-ID: <ZXdqLhkvqpJ9Jx9t@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <b75869befba26899d88d6c6d413cc756aeadbd80.1701198172.git.me@ttaylorr.com>
 <ZXHE5Lce_6CAWKFT@tanuki>
 <ZXIq4mjDUoqlGvgW@nand.local>
 <ZXLRjeu66qE6J1K1@tanuki>
 <ZXOdPLotcS5daNke@nand.local>
 <ZXbF2O4qjIr2L7b8@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXbF2O4qjIr2L7b8@tanuki>

On Mon, Dec 11, 2023 at 09:18:32AM +0100, Patrick Steinhardt wrote:
> > If you have the bulk of your repositories in the alternate, then I think
> > you might want to consider how we combine the two.
>
> Yes, in the general case the bulk of objects is indeed contained in the
> alternate.

I thought about this for a while this morning, and think that while it
is possible, I'm not sure I can think of a compelling use-case where
you'd want to reuse objects from packs across an alternate boundary.

On the "I think it's possible front":

The challenge is making sure that the set of disjoint packs among each
object store is globally disjoint in one direction along the alternate
path. I think the rule would require you to honor the disjointed-ness of
any packs in alternate(s) you might have when constructing new disjoint
packs.

So if repository fork.git is an alternate of network.git (and both had
long-lived MIDXs), network.git is free to make any set of disjoint packs
it chooses, and fork.git can only create disjoint packs which are
disjoint with respect to (a) the other disjoint packs in fork.git (if
any), and (b) the disjoint packs in network.git (and recursively for any
repositories that network.git is an alternate of in the general case).

Now on the "I can't think of a compelling use-case front":

I think the only reason you'd want to be able to reuse objects from
MIDXs across the alternates boundary is if you have MIDX bitmaps in both
the repository and its alternate. Indeed, the only time that we kick in
pack-reuse in general is when we have a bitmap, so in order to reuse
objects from both the repo and its alternate, you'd have to have a
bitmap in both repositories.

But having a MIDX bitmap means that any packs in the MIDX for which
you're generating a bitmap have to be closed over object reachability.
So unless the repository and its alternate have totally distinct lines
of history (in which case, I'm not sure you would want to share objects
between the two in the first place), any pack you bitmap in the child
repository fundamentally couldn't be disjoint with respect to its
parent.

This is because if it were to be disjoint, it would have to be repacked
with '-l' (or some equivalent '-l'-like flag that only ignores non-local
packs which are marked as disjoint). But if you exclude those objects
and any one (or more) of them is reachable from some object(s) you
didn't exclude, you wouldn't be able to generate a bitmap in the first
place.

It's very possible that there's something about your setup that I'm not
fully grokking, but I don't think in general this is something that we'd
want to do (even if it is theoretically possible).

> > Whether or not this is a feature that you/others need, I definitely
> > think we should leave it out of this series, since I am (a) fairly
> > certain that this is possible to do, and (b) already feel like this
> > series on its own is complicated enough.
>
> I'm perfectly fine if we say that the benefits of your patch series
> cannot yet be applied to repositories with alternates. But from my point
> of view it's a requirement that this patch series does not silently
> break this usecase due to Git starting to generate disjointed packs
> where it cannot ensure that the disjointedness property holds.

I think one thing you could reasonably do is use *only* the non-local
MIDX bitmaps when doing pack reuse.

Currently we'll use the first MIDX we find, which is guaranteed to be
the local one, if it exists. This was the case before this series, and
this series does not change that behavior. Unless you had a pack bitmap
in the alternated repository (which I think is unlikely, since it would
require a full reachability closure, thus eliminating any de-duplication
benefits you'd otherwise get when using alternates), you'd be find
before and after this series.

> As I haven't yet read through this whole patch series, the question is
> boils down to whether the end result is opt-in or opt-out. If it was
> opt-out then I could see the above usecase breaking silently. If it was
> opt-in then things should be fine and we can address this ommission in a
> follow up patch series. We at GitLab would definitely be interested in
> helping out with this given that it directly affects us and that the
> demonstrated savings seem very promising.

The end result is opt-in, you have to change the `pack.allowPackReuse`
configuration from its default value of "true" (or the alternate
spelling taught in this series, "single") to "multi" in order to enable
the new behavior.

Thanks,
Taylor
