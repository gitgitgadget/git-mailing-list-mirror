Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3D14F112
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780973246; cv=pass; b=ZlXZ8Oe0TN7/rwoGhHY9zqABgJW9auNWL3DmTAaQ/dGfSMV1wn4xWf3/UB7HT0nvMgjcSy0PmpiRCpVw14pL3JHALFKcUK+kAh84IZMP5+77wdxTa0W0AJWWkTYltmH6nnr85RCXHCtiZUiESsYKn+hpWYo2nZNNfADvectCif4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780973246; c=relaxed/simple;
	bh=oYo8H1kDtvvJ3E10eeD6YyZMY1gHALw6EGOmfhp1grY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNwAppEZpSxp8k42zqIeAalO3krxoanQ7VIeXaHV6cAinfJ+zgvUCkdYxIiOVp5SDa0cS/umF9og2NeUud6QIXT9lw7Poo3di13N5xwdxX4dsWQ8iQpTnFCchQ/c6m7PpWYET6wl+Vka6UCMaPRrjHlIiZXKnqLddnWw+nFhhaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmJsNrMy; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmJsNrMy"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3967717c951so52073361fa.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 19:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780973243; cv=none;
        d=google.com; s=arc-20240605;
        b=Cx8guXkPq/u4JGK4pDxlrn/KEdFHVVmqMdQp1lLzsALV/sAHQs8FhzV+W1e6yoUFwQ
         o35VqJA65kWRvrAjiCVYjD50RiXylVPcZI3EDq8v7ddt2c1KWhq1dHX9QhKppmYMQ8rp
         33drkf0GQbrD4l55ZclgEYsvezL6uFV+ulzi+jkEgQSUVhNFo8odgF2ir4Oo8LOwBG9y
         +V1bj3cj/L6M0SXmuJpyLBKiFiNfiJqCpGGWVD6tImp3aQvuEQjm36dmQqiiSxeE09DH
         Xcp8p2CUUVoVQ9xPUoNTalH7+Jz74j72BRX0Gdh70ILvGFo1yOKAQGvrRr9FqyvPeYXe
         4koA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WfQVTiPEyG3ZTnlWv1SfOG/uM2e/9acNmuCahjmqwEQ=;
        fh=II5UFWVA2YVGzjMzHotJOpZ2kHzaEAQlHI0yuZYNT4o=;
        b=OoNPqvzkgL4q+mWmN0gedSvQ38Xrp+AMRIqIZYKv2u0076yO3p4wn9GfFL+n7qm7TM
         Obwva+ypH5QveVKZ0qXL08TFTebON0UN874IHs0UTdVJgJW8qoCXYd3Bx/1EiVmCkJpq
         f20P9tDSQxQG2r/F+qjmvI1kvN+/E9WdjLBZYT4k2PN08EflBlGHrDMTu1Rd5mDzQKk+
         TRsSiqzfMeCMaGXyGeMcIFJ1NSq2r11ilpmDt3M0Fm9Z2/JXEuuLG/wMeZEOQuDA/eG+
         9skiuS+mufTWH1cS1MdpMwLT4MlhMFAscepLzsBCpTuEcbfx4asejj4PtGPL+LscnSsv
         zbKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780973243; x=1781578043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WfQVTiPEyG3ZTnlWv1SfOG/uM2e/9acNmuCahjmqwEQ=;
        b=lmJsNrMyvrWfHiofvwHZBh8nCTbm609Dtv8WneD8TKVDnBvqx+fQjiJHM5LglQ/k/+
         OE2CciM1p9qIF2UqT+mSPK6TnriFywS8szHNugrzqWJF4EPVi5DS4GK6Rr54lABRIxBZ
         BeEpFbthELjA5KdCwvyY+DH9SjNMuyg031B+HVn3ikLU+qAwXfiTVPV2mIfC1FGaC9Io
         UUBL/uTwaEZi5BNZnUyKvvFSZ+epioW94tWiP+K0qWlCc+6PfVknMmdjmYybvjbNjco0
         YYexyUBn3USKXy0liMVQ77NPENu0Ukumv5rJDQbBEsbbgGr4oj+TN43vUebLpAIXS17N
         Itpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780973243; x=1781578043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfQVTiPEyG3ZTnlWv1SfOG/uM2e/9acNmuCahjmqwEQ=;
        b=W9i4vkbI+pmdASFK/fBsL7MKzHCZN3M3TfSy4CQAt3S24MZS8CITGDK6on22KcfzEj
         EBErvFiFQwlL/G1uSNqK8RNTvj0yuIBYrTXR6RYyU/TneGESKagcUWQJBykfxAhtURQc
         GsOqi31TyJyqmVxnR1Mnru7+Xr1+x2Hf99YJ58/PssaXWPu7ao2QIr6OKT6qEvo0yPIB
         M9ndY77VsM+wMZr06iwGt+gEIt7/io1P9TsfIQGoiSkY4FQc/CD+3SxcOE5X2DBRj2rE
         Uh/kVRKIg6RYd+9+fnaXPJySZmME6ZuLddFcI8oy4JCcRE34D+sTirDMf1SJR8fK9DOy
         P0hg==
X-Gm-Message-State: AOJu0YzA+/XLm2ympU9c7wrrBco5JSQdJcdM8kM5C2RS+/FL8p168KZc
	YSlxnhza9havI5ddfA0NNn0ihmKOVc29EsZBmc2wdsehXZ68+vvBt8y7R0yKOdBkRkUgjjxN4Kr
	kShqPT2ps9diLDIEnBMqiq/yaqNcaAXc=
X-Gm-Gg: Acq92OGdVWXn2gfx/M7nO4idMfmRDFeGneei2A51N5XtfaK13fdVl64/qqtzGq+MteR
	cyx4IDvceaWKK+hjO4vTSGiUXqKR2PZXjqrCPDcN2Oi6Sy9tuCs0aPUOcC4eNe6x7PGMFnnr/bD
	qdUosGKGV96gyIyRjmKA+RJ23E68alavT/eJucaFiDoMO9W/c3gSIKzM6RS0/H0cX726VlJJEQ7
	i+8kyaZMkTlqh5hpq+afL5Z0ptai2fIGR5bRXXr5no3dBneehgzAoShred4eyIOOW9xNpegAzOY
	QdTGuZXXI7X1RAmy1Rb5YzzNxaxYW4AzvwRhxyYvgJSFdtLNQ7z91JttwVEWe9K/ws5ij3dEfEV
	5sTBbCtPUj/JfCDC4agk9Tszm0ISM1xl0G4Mb
X-Received: by 2002:a05:6512:3184:b0:5aa:68ca:7b1e with SMTP id
 2adb3069b0e04-5aa87b8c16cmr5868536e87.9.1780973242576; Mon, 08 Jun 2026
 19:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-2-jayatheerthkulkarni2005@gmail.com> <22E79E77-BCC3-4622-BD39-F4ED7DDA9511@gmail.com>
In-Reply-To: <22E79E77-BCC3-4622-BD39-F4ED7DDA9511@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 9 Jun 2026 08:17:11 +0530
X-Gm-Features: AVVi8Ce6gxxZPK8n4lwIcBKZOElh1ArtYnWwAPf7Zf2Ks532CWSGzGk6Qv1ph2Y
Message-ID: <CA+rGoLdJY7d=331c_DyG9WXJbFxmaabag3yJpbts22uFWTjYPg@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 1/4] path: introduce format_path() for centralized
 path formatting
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, kumarayushjha123@gmail.com, phillip.wood@dunelm.org.uk, 
	sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"

>
> Nitpick: the documentation is clear to me, but maybe the function name
> "format" and the parameter name "buf" can mislead the user to think
> that it only formats the path without appending to the existing string
> in `buf`. My suggestion is to rename them to something like
> `append_formatted_path` and `dest`, respectively.
>

Ok, that's a good point!
I will add this in the next series!


>
> > +test_repo_info_path () {
> > + field_name=$1
> > + expect_absolute_eval=$2
> > + expect_relative=$3
> > + env_prefix=$4
>
> This helper function needs a documentation.
>

Alright, I will add that.

> > + test_expect_success "query individual key: path.$field_name.absolute${env_prefix:+ ($env_prefix)}" '
>
> This makes the output polluted. What about changing it by something like:
>
>         test_expect_success "absolute: $label' '...'
>         test_expect_success "relative: $label' '...'
>
> with a custom label?
>

Ahh, interesting.
I agree, I will look into this!

> > +
> > +test_expect_success 'setup test repository layout for path fields' '
> > + git init test-repo &&
> > + mkdir -p test-repo/sub
> > +'
>
> The helper function `test_repo_info_path` is relying too much on the
> existence of the `test-repo`. I think it would be better to add a new
> parameter `repo_name` (or similar) because
>
> 1. You could move this creation to the helper function and
>    you won't need to place the test after that creation
>
> 2. You could use different for each (test_repo_info_path call, path format)
>    pair. Currently, if more than one test fails, its result is overwritten
>    and the `expect` and `actual` files from the trash directory will be
>    the last of the broken tests.
>
> 3. You won't need to use the hacky 'echo "$(cd .. && pwd)'
>
> This applies my suggestions (feel free to use, adapt or discard it):
>

Thanks!
That is helpful.

Regards,
- K Jayatheerth
