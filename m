Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E72E7376
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484169; cv=pass; b=QzAQ9xt0QhMENMubv9g7IaovfvU3YsSmSifnmtXCOe/zonSU0mHVddBpUEpcGDpLIJFkSF/pIICUyo3G5ppgMn8osFM8lcLnVvqr/yexzW8faSEUYmv/upic0X2fupKq7pr54uyMNl6544OxrDXoqmTuu9KBdTglXDF9QTxAwXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484169; c=relaxed/simple;
	bh=IcCrkuLpZJyC2PUTFmg97Indwfix0GhoHeVguU9m8/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMzluV33I7xnCbL3hOEP16Xb4IP6uBzf6oc1HRB2MgC6BDOqZE4nvfz3bqh389WhGr6OBEbphEg3EUM6jvdhMmxD72D+oEsi6kzFAd3jD1rtPXBVEu2UC0EZ9dUAdqNXQ9zcFKAiAywFCR2Ipw+gRG7YC5MxSfYyP9snVYC7ppo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=ajOwM868; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="ajOwM868"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6611689dc10so1174235d50.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782484164; cv=none;
        d=google.com; s=arc-20260327;
        b=T3VHpXYHsc7FFky6g+FLgo/v2+FGs+qrQuxrBy/NbsLIPTYRgKflgVexPm5FCLVFCq
         3EtzCZBswc/1M63b/r6a8HrXFuRJ5iJsKBF2uDVohPKejkqnEsbD/OVtDsF+CYkAmZeU
         PbtEPCVcPTl46axetNAcCvyqrOu0jobgUfdIm14RS3UKBZeoaXyx3qTSVf7Br++pECBp
         B9Mt0InaxVnpQX9qGky5yd4PlKQqvqQEK5P2W20ljC2QRlsFUbw8WbP5CGuPeqRqxPWU
         RlOWIHsreqk5x/g1dRK5SzQcT+INawKB210tNGHLhoBG1jPvE++N2FqEX47rpYgPakQc
         KRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=28wQyVZgL4ZmLpMETFPcxxZ4Lv8n4jopqUZhaOFEblk=;
        fh=tXwkwlp1gPdEPqYEU3wr/lfdJh4Y1HUol4Mx382jUNg=;
        b=szVI+ZrnPI3e7iyeiMRlFy5S+qfsIDpD0XXTvS+tTGHKF13AQJo5JGgqQIosEDAutj
         F/sl9bAE0yw0TBsd57baTERtUb9rAXXJ3V4Zv4Sd13Z7L9HiPBsBDW1M4Bz+jkZJazh9
         Ac6Fe9Rt7nf7ulQ0U8hDt/CObsmc2Sudhqzjlk93KJFYUKkpfjPmvKSj3aJG61GqYnLs
         B71/IgP/5mUQJS+Liv7jYxEZyM+2MLd78UEetdnoi9XGj5pEj+h3FqmMoHnONQx0eFY/
         doKwwwLS5e77pTg51EXOyiBMQ0uChdrLbQGaaT4XxZyer2NPCs5CoA0Y8hk25x7SK9VS
         wmSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782484164; x=1783088964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28wQyVZgL4ZmLpMETFPcxxZ4Lv8n4jopqUZhaOFEblk=;
        b=ajOwM868VVRxhAPIJY43p3TP4gwN2WGP2q14W7Fx6IiyNdbdUyinDE5uYqQM1sB7Ih
         emGZmD578yXoZhNUSTalIvd4cTaknpEn9wBSveXyaz1R+ouoCgnB7hMLvRvGLtaZiBQo
         Wx8xKhjAz2ag3oe/QZ8IC9mbG4aLLu6YY6/b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484164; x=1783088964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28wQyVZgL4ZmLpMETFPcxxZ4Lv8n4jopqUZhaOFEblk=;
        b=OiwTOoorMyDL1gSIcYHl5qzC/PLlwOw6bI2G4k5oJ1V7ZkbzFwpOWoUbiVStdd6oKI
         xpdlc/m0yqhGpiL2zcPfSM1ryQZ4b+QSDDfMZqOVTfdpzuPp0wP7yQOXkAM2N5u6ygrM
         Z6Tg+9KbZqgG65p2nraB/SzU/iu/4z6TSoETcNjWuNnjSbyJ+hpmCxLIYEsUnAOuSix5
         OoYB9THHc28ClVAirta9VuJ+Q9CxRUrRlU+XoWd4G8wJyPGS2A5N+AVCJzLdnLjhoRwd
         wlrD4GIne23db5z4fap+QphE4/x76CS9TCPy/7gG2T9RfX7EUMD67CRGP9U6P80XaI0d
         N+9w==
X-Gm-Message-State: AOJu0YxvbO2+7z3D8WACxhIsSxNm54Mjed+nl80CgzHzw7urokKTF0HQ
	4v28FTFeUvYQ7AdyS2IHfegFxn6PtDXYa+ji0nAscIEcRrPr+r8iq0CCu7xoPKXx9mvOh2we9Ws
	WCviz3qL/YsQzPLcrXVgObO6WBe/F4DP60ofUj5nELp4yq3ZwlAuVagslrQ==
X-Gm-Gg: AfdE7ckOHXupEUE+W6lpgWdnmREHLwH4JgWWDuj6eK0/mozVUvBQJ3velo5jThV1I/r
	80xSo9DzRl5rkt90eHlo50MohYoDAOjJTVoO2dJo4xtW9hFt0eytFLiXkK+18Kxb/XqOEzmAU3P
	+iGbmr+ENvN3GEX9bRN+N6NsQE5Ncr72ECSm371VpV+K+4QnOsXbPDFhbzbZTmBNwQLNzSbYTD2
	7eVlovXr3ttQUk8cE9BlKIr90ZsDjEoVLdnnXmr8LmwAI0hn7yZfa3/ujwIwrnQw7iz7FLhig==
X-Received: by 2002:a05:690e:408e:b0:663:ac22:88 with SMTP id
 956f58d0204a3-66487bdea02mr5372627d50.16.1782484163822; Fri, 26 Jun 2026
 07:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com> <f3572a8a89c74fad54a9e53be6f0e34daa2d50c2.1782479286.git.gitgitgadget@gmail.com>
In-Reply-To: <f3572a8a89c74fad54a9e53be6f0e34daa2d50c2.1782479286.git.gitgitgadget@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 26 Jun 2026 16:29:12 +0200
X-Gm-Features: AVVi8Ccq1g0nLoU6MwGmgi315mRJWXA11AOujzhhFDjfC6f66bv3W3cMjQ8AaKY
Message-ID: <CAL71e4N3RPHSrXscwYJUiLWc8-a172h+nE13yuUBRV7Uu3zGzw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 15:08, Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> -               if (min_generation && generation > last_gen)
> +               if (generation > last_gen)

I have to note that I accidentally pushed this version before noticing
that it now fails for a subset of commit-graph modes.
Apologies for that - I will rework the logic here later
to preserve the behavior better.

I think (and hope) the rest of the patch series is in good shape though
and addressed the previous feedback, so any partial new review
feedback would still be appreciated.

Thanks,
Kristofer
