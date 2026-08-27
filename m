Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4183E5A35
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848149; cv=pass; b=tTwxaZAycY8N7g50K30xVk6MdNlKZ+HTpazekUPmrpK3qujHUnxPjdzWdImn4KK/67Of1vLc5dniEbPGxQaYXdcI7wUdlz2q3jNb3R2z5vvqRATco/CkIYKIYmnlN9unhRhZ9Bv/bdVLsrsWBUq26PNS9LxrOt8QOAwP8vLEIsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848149; c=relaxed/simple;
	bh=ul8VzHHc+HN2EwuG1rMEK3J+zGMoScrWoVHGPKxHcx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxn7Cr8ZvICHqMUN8F9DDrcfwPakX9J8gw3sVRGhuLV6NT+Ueui4ornPYUU+xzA/QgeW2JeCLRL/q4INUJUwtK7BObneA4/JOnhVZ1HLKM2+Hlr2cag5FYmK0iWw8iyGiRbEobUraW/OSIXDKogweBzMgM18JxBGCl3zEZlgvAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2ReultD; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2ReultD"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4b28d9537bcso1165999b6e.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 09:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787848147; cv=none;
        d=google.com; s=arc-20260327;
        b=PzPMdMurZojFGjjxI3ArmxGgFtLcH9QIJxnYtkoUvFNk2QdqjoA51kdvQM3rP5rpfT
         ZFNjbXJ6ERhVo3I2r0P320u7eS3d60/zy5+JcIgU1MOmZxd1pZBsli+nx5bxgOA9/9sc
         Vp4nGpv2/5nzh691RdABULvTE0R0ghITAuy1wJYCCbkPFTpMpgqQdi5RpjSczBPM4RSi
         VG81iU+We8ddZ4eKkiJNm2agQjcrreK0f3BQhz/gACr+e1ld67J4A7Go9bJZ1DEvRCoM
         3R9bzu2NfF8q/68oOLAZwvnGhphIWL75/8WTEPpGL+MzVc/oYINmIa0eCSRmtLKRb4No
         Nypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bu8IqI/zx1LgkeW7Nh2IsLYgnVqyFsmQd7jcA4zNGRI=;
        fh=QKVXa8Lecfo0zZmpGkUQ7gwqG8g6nVUUxOShKA//EU0=;
        b=UEnCpKWHnwtm9l1T4SUxkBF2FesZwJLox/kwKPWWMrKKiGvpqlpeZN3v7dKsu9gdWt
         ++McAoyMvSVAkOHXEF4VIHBQDGJbYKuedwWzGDOFVW3+Ib5mzPraL4W2nNs9DwUBtmi2
         LIFcR8ZkpxwcpqpdeQqoiOa9dKhAcpUkJKk4D9FMMuM+rENr3ZxtLdBoMiMyD++GIbnp
         DiAomyAask2ujyjIj/QHzT2IWj6wCby7gmhEmuUDWeSXlgqT08141zKczwxpmuMmYbw5
         XYFLvSNdcFlKMk4dQD2Mlhwi0cCdwgFFz6EbxijVYtSGgiInPvtfRlwu0qC5k/eSH6Rg
         jjPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787848147; x=1788452947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bu8IqI/zx1LgkeW7Nh2IsLYgnVqyFsmQd7jcA4zNGRI=;
        b=i2ReultDqHbQXSqIDUHhbirTjh1hlS08FZike2+/Cv+1j1xWSifXjgd3KP45ynVel0
         kPPKIhSt1JFGGrrgMswwVxeI0yDTlYpxZ5Pdy9xMT9pGxid90xgYGmm+JGjeoFY7/9IA
         oBtolb82VxTvzXFik/ZxKoAgZ5HDTT9reR7p5CvgwkeExjyGli9OyFLBU87jlsVQ76Wa
         OY0pArK7yWxNDRfitPin8hwLpUAQ9GTczVRYQj7rETQRiF+tn76bHJIQsf5xJE77OQhm
         oSCt4TuswsL0KPIV+zLUUetsX0mrwCPnhOLG+FG9EksrOZul+CdcGSJc6O8RN7c8+5IE
         Kqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848147; x=1788452947;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bu8IqI/zx1LgkeW7Nh2IsLYgnVqyFsmQd7jcA4zNGRI=;
        b=mq3N9V4WvbFAuqeu+3Ixtm9jVLCfEoVhsQ6kTXiAMLKH/xyBrt54DMq+TBzEDvB5Qs
         USeWoPkFLDqLd4BGjmcr7vlUtbKq8liWAcYZAyImXk24Pk06c+chiPAmvaeioyJgXp1Y
         tI6BltcWTl5VZEQ29Sezy0qaseOe1QOHkNbknoW8Vanwiwlxty/6cdlyHP+twSYYeciX
         IHrKuJRIO3530hYoOaKnbT0fbz2fw1TIMclzWKySLskIWVQvZrPeu2yeR+PGBYe3382V
         DxzK7mL9xiP4YaPk7so03GNU2qrl91Iv9IP2ceyG2sb5+XOl61ZMj9IhWVC9wS5+l17b
         yMiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1Evm8zdwX/srgq1ceRhG66NL33CYOV2gd1kBpVqSuP0Vmh92fOdsIwMRByP9hLoxdNWE=@vger.kernel.org
X-Gm-Message-State: AFuF++kF3bfgppNnRKhS2+vdbi/jJtA6fKg8FYVR+9tgc+jB84Giahtu
	gA+iuIIABx2Pqvg0W8mkO4HGXlQkiXUBge1suAUYsRiWk3On8xcBPMLRvmAUEP3OaFnuS9yXIcX
	fkEkWrfUjkMpvvqoWxLcm3hgpDGHKo1w=
X-Gm-Gg: AR+sD11A9IVBIDKghm5ggTbyWqZV170UKzofza6n/bzFrAtELH7jqCLeBuIegDsoJ4t
	q7kYvitPGVNFTvcxxsLjloCcE59ndUuB6htjttpp/93gLt8rfG9oPzg6MMaVrAc6/40W9TRAEP2
	iF/N2nXe0BlSWhHZllH0Wtb3lzNYuKM2vtuLgQnETwMCZD8RMLXR0A965FU/VOQavmQhfF2GgEe
	HVk8NuYZxQ0lfh5bO7RDGGMCTrASAAFBPRCB+aWJPTO60eP4qyuBHGXTp+6A8Y439R8/wCy+ku2
	CD9fkvROXtXtRdwyEEcnyleovhyF4xvmResrUyWOy8HGZRYscDCOJSfv0QC+nzy0wBOENUnLTmx
	XbBWoMTKUwGMkHU3F5SaOse59aHXGmhV4Sly1j1mE0nNNEn/W21D9LT5W1Ds96qJAzfO5FVvR
X-Received: by 2002:a05:6808:1a21:b0:496:9ee:e538 with SMTP id
 5614622812f47-4b37c81e675mr5684856b6e.5.1787848146564; Thu, 27 Aug 2026
 09:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com> <6a04525c-d9e7-415a-845f-f11ed1c0f0d5@gmail.com>
In-Reply-To: <6a04525c-d9e7-415a-845f-f11ed1c0f0d5@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Aug 2026 09:28:54 -0700
X-Gm-Features: AcwNN1UTMXLT4TywC0oSAoj2vDfOukAtobi1zx-FUD1LXA0TArmk_GMfDMd1iuA
Message-ID: <CABPp-BG3O1xB3AhU3NfAwT5S1W5UnikT8U9HW=AqA9inYMS76w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] commit: refuse to amend during conflict resolution
To: phillip.wood@dunelm.org.uk
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Thu, Aug 27, 2026 at 8:19=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> > The three patches:
> >
> >   1. reword the two pre-existing "empty commit" rebase messages, which =
were
> >      misleadingly generic
> >   2. refuse git commit --amend during these additional operations
> >   3. refuse partial commits during the same operations.
>
> Thanks for working on this, it is a useful improvement to our UI. I've
> left a couple of comments but this all looks pretty sound to me.

Thanks again for taking a look.  I'll send a v3 incorporating your suggesti=
ons.
