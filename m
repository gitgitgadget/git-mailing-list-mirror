Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541594D179B
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610914; cv=pass; b=luKdrFRebJVW5mXMr1k2wfMH/1t/sfnNP9KKZDqmtyVxvblJSZIJ6ORKpWxc0CVJA5C7HeYv3QZd3k+RWra6r9RtOFPfo3HQcl1lp6Vf807gutPduOqz5HN6LA9dhgl71mRAvUdoyeCbdmxr25gT6ITkqlIypBhvflXgU0LQ/PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610914; c=relaxed/simple;
	bh=YpFA20rM2OTJkAcWCfXgunPU16zadLtsMyMDAFdSmiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYCmDRuSE8kAXvIYw4UOKU/AkLQ7qhXrr+JGA8Py9J/wkRLl0DoF242qJlbqfD8SqRS6MocJWG0XzupkaRHpXWZvrkjeQeUqDRV9H5le0N62kEvuJky9jfKsnJo8ZA6vlYGKilYl6nIdySpEV8m8vUD6o/ZBU+qUoSpSiMyPnjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/jpeJKA; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/jpeJKA"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so2225933a91.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610913; cv=none;
        d=google.com; s=arc-20260327;
        b=pIAHJx5ZjOfJ50zx2AqKuyndHNv14VOlBMfZWW9BxeWB07V0qHaJqQHLIzy0aNJEig
         Lp8kV6XWgaj3mJ2q2VVRK+LBoOjgzJGuMs5xiORgpuzdLJDf8QmTqj1x8RArO27HWvL5
         QeSPH4kvOE7qLJJ5+wmDdzjBp8ajxPMM9v0GcamwN/z1hjZY0lNruGDOFQ4SEyK8EXHU
         lFYXlsPoyimIt3Y4eBDVlZyEJPKytEhnidUZjRaTdyBBjqk0bBKweLkJekmB6o+hSwbZ
         q+DHYZXq+LprEXYfZy0OQ65e/CA7RVkmUvE+X5QOamKh9td2Uxg5Toqxp1pnQSh64+R7
         9JRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YpFA20rM2OTJkAcWCfXgunPU16zadLtsMyMDAFdSmiI=;
        fh=BpQetKOxokViV/viQw6lzNM90ggpRAf/y6UMgbRJ/r0=;
        b=rEIGPZluhJPegy5/S20mVgiPIi6XOfhIVQMMf+VA6DavRC+VgSPnHBPbnpew6WTLsC
         +XpEsfwUgPsYolxGvTCcTPtusGDkfrXA/NDHrmY0J3HjR2gS+4ZPGWOt8XjV+mouqKeE
         /EVL2C+49JGfHktVIUcF4khx868I4iMFonYmGa9TdAZVUDta/j9aZWhAoLK8F0SbNX+V
         Glbcd5ODQie4yXV7KxVbA/pGw0tuSdo4yyyNca1a0BaRIUxgq+tdgL3S7fBcE3ds4aF3
         v9cq566Ak/5iiQwyxiAKFIsXlWgyYTJh8+mmSxaDEkbaj3G3whTp5Peym2CLVtm54iSU
         qSpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610913; x=1791215713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YpFA20rM2OTJkAcWCfXgunPU16zadLtsMyMDAFdSmiI=;
        b=B/jpeJKAXgjX4yIoR7KKUbnudnXU5uI2mh7ewGheNgqcT9MuedcQsHmI4nUhF1Diso
         y/KTbH3SAG0KYMXDPQZzAShNvNVT76NFMc3v+gRhfFHM1TPdf01GkmoD0CmAdEsppxh5
         zpA8HSzof7PAWQ/hHUZiyZ/IbjLbtxvzHTg/RsTUQXSum3eGb8B7j3oqd/TAC6pVI+Sm
         OPUIwunCQW5NyV9qbmDdJzbEo0PaSk18T0+JNd5mBmMcyoRcAOF4SvhJOWvBICbJ1cM9
         I0p1d5pWyB9dQQvDH5rSi0GV8fCpu6Q7iX2/LZpWbTDovGdjfTJNYUMxS3NIbkKcHQA9
         UdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610913; x=1791215713;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpFA20rM2OTJkAcWCfXgunPU16zadLtsMyMDAFdSmiI=;
        b=YKAtjDBRX3fD499PHszA3qouEw0g1iRKwKVX0SNhi1Hx661SPe35YiA5BQ7TRUr6F0
         boisCdBJ64x4gZwF4Htf2R6CmC2xTfic/pvhgdgly11nUigsOfNeLb09wDQuuN5V+TOq
         4oZr9Nd8jCZQHfUHr/yw+rZyFfyC7VLT45u4O8dNIzNQ6boLsgnuK3IybPtaO+hqRv9x
         fm8J8kzB69FrIb64WGZTwL919pJla4HHCLxmfglc3MJi+o53uT5Y1DyjIfZq4IxXxhKU
         lW36PSvBidBDfo8OlLK/D7PGfo3ZGV7T9YcWFY5F/aj80wxYyeFI2Rt0j8JiiwiyH5WB
         R8gw==
X-Gm-Message-State: AFq9FYIwS+QlVdIhWkYHFmJwz/TTKHNCWosWXIcFn/OaYRenHxP20NhK
	t8rMNeLp1zXwRQXS+nQv9++WewtpA4pD3hggOh3vbRk54wJeKae5NZRfKbPL2ivIWVzEbAZoFns
	JKr5JELfIPfQ5P3121widXxGzCfaj8bI=
X-Gm-Gg: AYBFou2JLls27Wd0Rh7K+6BS+QAb5NOMBSKyYYrl1VPcbvNvvTOfthzzlfvCOqEnxSX
	XjvmXShf/eLV0sbb2cYWlwmn6KS1wevpOGnv5s8ukCyqwXJGcWBQW+5MKBVgTUwpTdfKg5iKBlB
	wWa7eFXaoMs+c3XvhoAUop2KOQipnJDiiis+rFMLFDwe6zya1hl/6Uu3f7SZBILi7BuF846QF5K
	kBA/nbkwGTYmJqpo6BTcdNOq8U29SZ5dUBlm5PRHVyu2qdRz5PsymvNVYfRwc1tDw9JYuM4MSrx
	2vWlf+sjYEJt/xKm5r1ilBgXhDqaR6zA7Xy/gTIML2g4U/qwrknfdpSCOQBAomkjMMEvGen7kV+
	+fPDVnrb1O1KXVIdVHH3fl490jdhOmQrJuue9bdnpsPa7spf/RwQDVG/ZHZ9qmkJsI8J0FPfsM6
	hVkDQGFRMIRqJO+XrIrVWGw5IxRnJb1ZE=
X-Received: by 2002:a17:90a:e70e:b0:3a0:c3d7:eaf2 with SMTP id
 98e67ed59e1d1-3a0c3d7ebf8mr5471234a91.8.1790610912476; Mon, 28 Sep 2026
 08:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
 <8b5ea5e6f47ee9a57df3a4d97a457d024b3dec00.1790425008.git.ben.knoble@gmail.com>
 <97f86d82-b5ec-44df-9ccf-8e6cd93e45f4@gmail.com>
In-Reply-To: <97f86d82-b5ec-44df-9ccf-8e6cd93e45f4@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 28 Sep 2026 11:55:01 -0400
X-Gm-Features: AclHuK_zG3sVIA9XrtaPstJ7q329-ae102oqdH5jhQMygXxlTSUVT2C3CxV2wV0
Message-ID: <CALnO6CCX+CvMZcOiyaFB0_nhe0wSv2-E2hx-iTbN4OvSVvNDRw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] t3903: test stash --index merges
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, Elijah Newren <newren@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:44=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Ben
>
> On 26/09/2026 13:16, D. Ben Knoble wrote:
> > A future commit will refactor index handling for applied stashes, and w=
e
> > need to take care to get the order of trees right when merging. Add a
> > test that covers this case.
>
> The test looks good, but without the changes in patch 5 it fails and so
> adding it here breaks running "git bisect" on this series. I'd squash
> this into the final patch

Interesting. I thought I checked that the test passed sans patch 5,
but I'll double check. I can't think of a reason it wouldn't offhand,
but my thoughts on patch 5's changes have become a bit scattered.

> and I think we can probably replace an
> existing "stash apply --index" tests that are not so strict with this
> one, rather than adding a new test.

That's probably a good idea, thanks.
