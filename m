Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024249480B
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047774; cv=pass; b=HiciE07W5XfQTiRQ9x47nsycu833dj6dLuAmlnWgMuaMW3ftkv1nX4YYZNxc4rsuXy/xtv6YCMqLgOXjno+rttJhlKWkz4Sgk3OTUcJE1vrQVoW3rNKn3po/ONeJsRzzrDC1DML99N3ylLTjAOmZxDmhzJFgkbo9E53kvH8t9Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047774; c=relaxed/simple;
	bh=uWdo1dlc+QYlC5/ArC+eCkRr5tVDUliyhws7E9EbUUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtQZZ2tD96T6LnOgV2hRzcepprbONjTvaNFjKdDUXooyZ9AkicYvH5i0YtYlFeyUgLhQn3KWtyaz98uP+/tAxiMrZWZ3CTgTi3lz5I8euTEVJN0Fcc+TakgDUP9jqH1R5AD68lMHrfie2ZRWcJhKD3ZiEkPGaydC2MwURiJ5LtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm/Eub0g; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm/Eub0g"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5ea63f01606so121923e0c.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 00:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792047768; cv=none;
        d=google.com; s=arc-20260327;
        b=YALOehOWeW9IxWZytJSTZkZVywd15mEBZMAyqcWz/M87m0RdqDTxjKQCd7MRrNy5Sr
         XfJQAJJ6PyNu+HaZRJAYOaN4ucVHMCon1Uec0/xgAnG6Ja6z/h7Zcna51evQHBsC/YIn
         eBUImtQM05o3QjV6RZ0GsePf/2nlpi941j2f5U89JPIcsT2EVuvWxidQgMhAaZSfXNS6
         5zulgozNCJ4HO56MWrZncgqRwmlGhScIXXfZW2l3zAnokOHRwN/LE7BG/6kX3zZlPkRf
         QjdQ45+7cbVZUsKOChTpaxpm9yfYenXxQ20/XKg2+sMDlQDlGAQtbRjG0rblq2YIPziO
         918w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5ImeTwfSRWzgVjk4g2S09ldxM5TelpNvUtxrV/OVwPc=;
        fh=hQQG8E13DbOPT8+z3ynd+cYIwOJpJsi3zJnzB+tANps=;
        b=gOGNTl31e/tNdHeKnYWkQ15rw2QRqeoMrl6ABIHKL3+OCh667kO3efbgtFNBG/Lcj0
         B2mzngMwyqfCVJY74OIBn9DspUZa0ekkcMGyMsYRAwCnaAF5HuMY4BIqAn5vPxuEWNG4
         NyxHCJ5WmqGJCGiJeB9YW5gchacnk0/PwNujcxKLWlkJHBiS2m2p8p3jKhDeo6G2PxQf
         sskElKING9xV6gDcvrQ4sj2KmlsAwfRJL/iz/ifABpa3ak5BB8k6ZNU1+GpPvQvEnLNw
         TA5NucGQ9j2HSgefW7rE55fNSiV2Q1SemoRQUh5ev7xzUPYY7RyGj2OKz5B5iqO14GdW
         nXTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792047768; x=1792652568; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ImeTwfSRWzgVjk4g2S09ldxM5TelpNvUtxrV/OVwPc=;
        b=Mm/Eub0g3qnfVYnu+QfOLEeHtpmLvdObyT5TEapDrLp/ARqCACmfnFpmaXbMuNiYku
         w076r5xRSbFuBHV6zB5HCs2+NA0aLaN6fIYXpArdiuXtCoh1UA8H1DOYPBOecuKnFD+r
         6e0KFK5C40PN2fswrxigM35A/H8oeD2/XsWW2cvNwsz7nV3HPoZE8mIVMq0jrxlN5Nci
         Kn4hqF0uUYyQXJStu/1sI+iWVDfIbxoz2fjMShJ0iGfg3IBt+IYujedmlI87K+DrurO4
         zaTinVexESD72/BPqQrzhldTzJXzh2XeTSH5oBeVTJClsJ3SIohyGgQ2r4knWfM30kBw
         HZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792047768; x=1792652568;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5ImeTwfSRWzgVjk4g2S09ldxM5TelpNvUtxrV/OVwPc=;
        b=B7rPOqgPKaHlNN/0zf3LZGzncvUMc6Y9rofzuhpKJpVCY08lqjR132oQy26NTFHmTR
         IWY0pH2vJXweeTprKpIrmUlX26TvKz3Ys90cOXRnBaKwoFGbTUoijawkRl9YJYm597Fu
         dzmcslB5c208BhsNf+kw00PB6gbowCdE1MEo3MFhjTpLlZhbLWl6PlM1UWj7buNBcmOx
         YYFgs6qagoS2FR2BmtZAyozFqf59pQWkEetFDeSqmXGx5KfH7Tnh5t+/To/AuZFyZhbU
         X3NOs1TxZNEssL0TDFlDwmFnCtPuBtYoZ2nGFA0Y7fOsp8kJ+z9MoBQiIVZW3F4CrkO/
         fyHg==
X-Forwarded-Encrypted: i=1; AKwUvBzyqJMa4TSpWhgH79Ts7Zpr5woNuOoPlySNShDn1maFUxl0qQzQw/VnN55ILBlnvLfd47s=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6YTNVE0icN53oJ1Qt9G8gXMk7Kyfw2bfeN8NrKdgjJZNd1Xkz
	epjU4gHhKV/+7uagjeKfBxjet48nXJ59ticprW8qHY/UkCIzaypVL+W8XrqCwBZ5C6NKR5gqSKt
	HsBZKSzMrvPpj1ldRKp0CMOKOxYi7Q+0=
X-Gm-Gg: AYBFou0VFUbbO4lg2fuw0cHbfFbnFwTK+jMZo30AxIdQqqZQ6dXMPbHlhCdoFOQpPMV
	58abfHWeMNqpJw2fiLikkjknTZZyS0xAk1bw8tuTlVk1VDJ7iemWOuctOqXgL65ply0NGOIjzI1
	HUim3ACzNn1IA5a7FmoszO7lEzvnWoXaZd9Yz69YUltQiYSfAkvXfjEFvtI7mu0Ue6iiF+nbRYg
	R1Nlhes8ivVVF8izVfCfhTOA3YwG73nDy6rrb7Mkb7Q78Q54GdKPVM3VSzJswSsmhO48MWp5CO/
	6pVj02WnYFcfijHa6tHuVgt8j71FKsmJAxFse6c8wo3AO+DBr43C3Z9z
X-Received: by 2002:a05:6102:f8b:b0:7a7:5355:7fb6 with SMTP id
 ada2fe7eead31-7cb3737be51mr3791131137.24.1792047768349; Thu, 15 Oct 2026
 00:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
 <CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com> <xmqqzewgosyw.fsf@gitster.g>
In-Reply-To: <xmqqzewgosyw.fsf@gitster.g>
From: Shashank S <shashu8660@gmail.com>
Date: Thu, 15 Oct 2026 12:32:37 +0530
X-Gm-Features: AclHuK8_fDbqHLtcO2Nv-sBrhxZHcd8PcjD49j8_oKPX_fttWvofYY_VsZFV7kM
Message-ID: <CANHmUQR7TJ7VQJVnxMpJ3KNL5DLoMcJFR_jcg_64Vn31EVgJLQ@mail.gmail.com>
Subject: Re: [PATCH] t0081: modernize the code testing whether a file exists
To: Junio C Hamano <gitster@pobox.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 03:17, Junio C Hamano <gitster@pobox.com> wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> >> From: Shashank <shashu8660@gmail.com>

> Since many candidates are working on similar microprojects (which is
> fine) and making the same mistakes (which is expected), perhaps mentors
> should tell them to read the review exchanges on other candidates'
> patches and learn from them, instead of or in addition to giving the
> same advice repeatedly.

thank you for the explanation and the review , from now on i will go
through the other candidates patches and look in to them and  mentor
reviews in them and learn from that
