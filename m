Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25014A11
	for <git@vger.kernel.org>; Wed,  7 May 2025 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583705; cv=none; b=Zz/vAh/jXQpB5Fyo02FLlH4dzlM3+cbLnKS2NSfBNxXD6GsEufbEVTHm16GPZZKGi9EPBfGOQM1VXuaf0+Tgk2IzSX/gaWRF3PQCEy0Kohaw5daif1HE28Sb3gNTKqhajZb8mKjOuJVZkq/5KrMkoEXA+6UEqp1v1cncHG/uEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583705; c=relaxed/simple;
	bh=dd9Bf5kxx3hnIB2ktLX9V0fS6mzhcszR0ZFRWoCHVmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhvXGJ24lDZACRkT6vAf+rPV5frWaSp3t5He1QWVDPiF1UDk/d0Bd7jFgiaUYXCRgAFLnejyJA84GlTItez88rln07qE5tMkFn4OvgPMXYrP9INjh3aWRmlGjQ6Gq2iwbELVB9YWL92FYbVgbjenn8G1z6LSnXgPm2rLO380SVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Cp1aAjJ2; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Cp1aAjJ2"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f5373067b3so16068816d6.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 19:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746583702; x=1747188502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhihn6EbM08vkV6hO54lLNviGuqvPhfl7dCvMBLt3+g=;
        b=Cp1aAjJ2VK8CrplWdGNOAUu10tHoYD1L/TSox+ZbgrPSJ3LHsnA/ye4F20ybJMzJuF
         c2BKxeYjya2SsldqnpUtiiPZ4cqaiAQY+sM86+Aq6BbB1e/XubXGcXMErvZTKUw/gt4P
         kfw9rqw38+JTLM+eWzuYB+zyYS4Wmn1fPOstgo2NMPAyjTw4d0xGNPdNZ5QOBKWvLHrq
         6gP3ITei+MkIoqP2aHkfVfvN6HipKWH/83HTe2qqp4AorFxFOdNZDqA5uKaJnrCKegHk
         rzrYqFMA8leTp7iLZXV/N3+a85bIxrmauGj0H1MKvfVCfyGxmX7k9nex5g9U2EnssMTy
         hc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746583702; x=1747188502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhihn6EbM08vkV6hO54lLNviGuqvPhfl7dCvMBLt3+g=;
        b=Rcq7gIQYtngug+9/K33hbbtrzhR/IzsqcTkMUPkwx0ZsfJCaeCFhSivI5zj0h34uiy
         ThF2QNyLAMAl4rEAZYIslfgaV+TXmuY0pkN5c2oRq1Z0Agy+zc87fMEUG3tqkLQ4wjHU
         kCxVNlNBZlnua5B+SQ+CuNjATocV501pnJVHBYhIje5oK0v0JMLMTMrU/+22ABmQiRMq
         S3F8si8GOeYoBsgn7BiXETB/Q9hA0jAn4/P1Gez7O6Q8tge7Wx4ZJyVTzP6vdOBtiv/J
         LrEX34IVXrEkFvnxa0v8XAseRjOfivlHeqpU/2z0OJsf2wau6oHWQff3KPY5ka/24XNv
         phfw==
X-Gm-Message-State: AOJu0YwJyU13ViHL6I/m+h2h+kmI/z8RKYv6TTQ6NSB1XDujcSpSfc4c
	ljDCIPGeuJeNCGmxG4oyVOpnY5ATxb0EnPsWOJhJ6MRvFWQqIcAqOAoLwvWjPfs=
X-Gm-Gg: ASbGncvg7NJZDfQp3HG3gYME5DJobzX5QrVTcK260AjitluRYrRyB20g7e1wxaxB2Zb
	VgOXKb+bi2NuEq2cxMC2h/JC1A+PcXWacyRx09pl8C4yDo2swSg3xvxIhbj+1FRRwqdmgNWO+cN
	7EMpHj4bawWHQ4MVRE3O/mVToZ/j9qODvU6zZp+SFXCTct5Z3oEK3K0sgxTfpX0S5dqc4n8FJst
	o8kTAOckRBHWiw60KHt8f59dbbTNhHWvEwp8ejFsrbxOpSIxtnNOAmF4RbrR8udnNa+tsED0h2n
	GRlq33uNU8stiOua7ithrr2o4UBygmJl48UWKyN10OpTLdXgZWyaBr5MuD/10jeg0Oe/kvJq/uq
	fOPB9I/1UisHr
X-Google-Smtp-Source: AGHT+IFC4daviCQMkDZTsbwTXyYah/5gaB13Iw+4dgpYncOJUxu2UqF+lpVv0FU+gMOwN6Ikhlad7Q==
X-Received: by 2002:ad4:5aee:0:b0:6e8:97c0:76f8 with SMTP id 6a1803df08f44-6f542aa8825mr22345556d6.27.1746583702480;
        Tue, 06 May 2025 19:08:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f54266e5ecsm6396636d6.44.2025.05.06.19.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 19:08:22 -0700 (PDT)
Date: Tue, 6 May 2025 22:08:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/3] index-pack: allow revisiting REF_DELTA chains
Message-ID: <aBrAlc8k8uxzrIV9@nand.local>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <pull.1906.v2.git.1745871885.gitgitgadget@gmail.com>
 <1358039b2f3bf893fffc63c1065f1d6862b74957.1745871885.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1358039b2f3bf893fffc63c1065f1d6862b74957.1745871885.git.gitgitgadget@gmail.com>

On Mon, Apr 28, 2025 at 08:24:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> The crux of the matter is how the algorithm works when the REF_DELTAs
> point to base objects that exist in the local repository.

Hmm. I'm having trouble squaring this with these next two paragraphs:

> Consider the case where the packfile has two REF_DELTA objects, A and B,
> and the delta chain looks like "A depends on B" and "B depends on C" for
> some third object C, where C is already in the current repository. The
> algorithm _should_ start with all objects that depend on C, finding B,
> and then moving on to all objects depending on B, finding A.
>
> However, if the repository also already has object B, then the delta
> chain can be analyzed in a different order. The deltas with base B can
> be analyzed first, finding A, and then the deltas with base C are
> analyzed, finding B. The algorithm currently continues to look for
> objects that depend on B, finding A again. This fails due to A's
> 'real_type' member already being overwritten from OBJ_REF_DELTA to the
> correct object type.

ISTM that this A->B->C chain is a problem because (in the above example)
the server sent B as a REF_DELTA base for A but also had its own
pre-existing copy of B.

But the first quoted sentence suggests that the issue is with REF_DELTAs
that point to base objects that exist in the local repository. Does
"point to" mean that the REF_DELTA's base is the local object, or that
the local object itself was sent as a REF_DELTA against some other base?

I haven't fully wrapped my head around the implications of this all yet,
but I think that it's the former, though admittedly even typing this I
am not quite sure of myself. I *think* that doing this is OK if the only
path from base objects to their corresponding deltas is unique, and/or
there were no such paths at all.

I'm trying to think through the implications of this against my
series[1] from a while ago that converts OFS_DELTAs that weren't usable
as part of verbatim pack-reuse into REF_DELTAs. There are two cases
there that I was considering:

  - For some (delta, base) pair in a pack, there was an additional copy
    of 'base' in some other pack, and the MIDX chose the copy from that
    pack. That forms what I'm calling a "cross-pack" delta. This isn't
    currently reusable as an OFS_DELTA for a variety of reasons, but is
    OK as a REF_DELTA provided we know that the client either already
    has the base object or we are sending it as part of the pack anyway.

  - The other case is that we the client wants the delta-half of a
    delta/base-pair, but not the base object. In this case, we can't
    currently reuse the OFS_DELTA verbatim, but could if we converted it
    to a REF_DELTA based on the knowledge that the client already has
    the base object.

The latter is doable based on the information in the wants/haves bitmap.
The process there looks like: determine that the client doesn't want the
base object, realize that its bit is set in the 'haves' bitmap, and then
convert the delta object from a OFS_DELTA to a REF_DELTA.

But I think that all breaks for older clients that don't meet the unique
paths condition above. Does that sound right to you?

I think the cross-pack case is fine, provided we know ahead of time that
the client doesn't have the (converted-to-REF_DELTA) delta object in its
local copy.

Unfortunately, I think this means that [1] is a bit of a dead-end for
serves that have older clients (running a version that does not include
this patch). At least, I think that's true if we can construct a
situation where the server sends a REF_DELTA that it thinks the client
doesn't have but actually does. I'm not immediately sure what such a
situation would look like beyond cases like: "the client verbatim asked
for an object it already has, but isn't reachable from the set of
provided 'haves'".

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1728505840.git.me@ttaylorr.com/
