Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EFE369D5C
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643506; cv=pass; b=jIqq3SpKgrehYTWGKnYd7v72nQypGVXV9cd35MQoMTURs8EdBI05exnV+58420HWxmf7Znu/8gnQYdV+Ob8KjUqPvirwPH9TTglVmu5DZHPvxRBuYrfsnuHv2QI7DPMVkpSMWe7xQWiNrIWrt/lRQiuWgb6FhESAmbmgGNLSxNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643506; c=relaxed/simple;
	bh=e9BhbWcon46zFCNaoYebF3jwZZDHSjfqLvXSHrySpAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF22UjUbsGzKCcOij5zkJu/x5hkyY9jP81fHyBQUdvCGqFc5j1Gclwzj9UKtzILx70nmtfqn4beNXWTC/vIGdRkv/cderfTSjeCCIy43qCQlFp5TCAseVJnkkx78Y0aMG6wyQXEX9NU5E+yEuV0XIeW0LsFgwSbpdf8B8KmR+JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXsWH0c4; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXsWH0c4"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-499f6e0bbabso3699041b6e.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 00:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787643504; cv=none;
        d=google.com; s=arc-20260327;
        b=S8+wjYSZhUzXMPwZF9jUQWIqMqvAxegN3MvFNYSRRgMTYWp7wy5xpLfrddHg6cmz9v
         Rwd4srPU6TE68vvBH0AKGDKFxvpaumvhadeXfUUIMSLeZwEMEu85HkDtv723J4KpNoRh
         aQ6MsJulSalPbUt47XdC54don3tadEbGgk58VGL19ADDmAI/RBZUPLtpNcbdWrVRA+CA
         SGlhQKkjRL+YneTI98yOeiKCHcRe7ZBANE14ZAV6xfR7dlDdiE4XcGqHC9PuPIMcdUPG
         +jhCpzB5iEvE4waEQl08vKeCuznP3+XNQ8m3wnJEdVMrqeiQE6SkMSK7ati/23JQdVCG
         hsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WRU8/9h9bVq0x+GMzviHyQ4GCEJtxChMZ4W9wuRs8m4=;
        fh=mSRYjSH51792JGZZiSLKKDsFtFqAqSD64onPUVWdyPo=;
        b=kWyxpwqeqehp06O+bEXiYmOl/NJG8aIi6vheF4kAdEHq2ukfJABuokPXTI0SX9rLvK
         b3qmsaO/PwK0suPK0Du8C+xNymgqrVUmb5xDT3V0ZpP+lL0WcyXLRkFLgrLaV0FhD+NJ
         PNvXSJzOji65gGsruB+O33g2gF93bApuivFXnDLbfBsugABgY9dabrspaErDFlga1s1o
         1fYs2cCIEmc6PyMuQKY5zw6r0gI9OA6w+/R/DT5fHDr30I3509Pdc8ydjD1UUB1mt5OA
         pclwV6CEDe8jyIkN0XafogCga2kYv5ImcLie4PxmdrpM21OVtvyRJwchCA6Ez1YFXj9s
         V8Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787643504; x=1788248304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WRU8/9h9bVq0x+GMzviHyQ4GCEJtxChMZ4W9wuRs8m4=;
        b=fXsWH0c4qYGkpfLyQfvKqgdlPZvb+11aM0Ri+NumKuYFH56CBLXkm6dYFVZd53vKp7
         kbj3YsCR9DU4d1g9WUf5EbVHB9B7lOcVaxiDaYtj/AVZSDRfe/SQtLw1e40WjU3ptRdd
         r9SMNOwyrUAMiA3iM8XxCBLYKS6w/wA604DHk6BK8kIrQggpDVw3P7ZH4XSEAp9bwmGE
         O8MZWsEDjCtHl1eVlwxg/7I9N4YN76XUHyROftmqQoEF01hbsis9vuBhoXobeSKWZGgf
         MXsZ+pF5khFvJCabrOXAtYO8RpcKET1GiHtT2zmlNuADn8NunqlWseH7WMgWoUM9giad
         LV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787643504; x=1788248304;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRU8/9h9bVq0x+GMzviHyQ4GCEJtxChMZ4W9wuRs8m4=;
        b=IGso1QoV/rhJy67j/NIaZJmVTUHBCFvgGWY9J/qquYpht+CIXpAAAQRFm5YOAsVv1/
         TYtDpVBWAfbPUIXQIHiIq4RZcWMldaqMXqQmo22CK39CWS3U2nq+lud/LdtAd3s1yEEQ
         RoBu6a7d3tibJKXhh5zDjwe1G7TJfsn7Y52v1v1mnJ3E/VHcJSygk16A3o3vgwIsq6B8
         rnwBuWKn1z+he7EfikdUn6ToW4MzEigex7sexO182UqijXtMtoYbrzYEyQCwL0IC/oe5
         VRSJMLqkCCqbX9pJDe0PWCFrrPvnw1KCe4G8tK0+ef2IIYrR4eQpBzFjGOBon0kiLhDc
         Ezug==
X-Forwarded-Encrypted: i=1; AHgh+RoiXgZHF7INu+3AeZtgMSsVXljr/NB77hBvxMplCW6p8Yfww1pu4GL1MsFM/n6SnpFq1FA=@vger.kernel.org
X-Gm-Message-State: AFuF++kGWDxdo11fbC1nGHFEM6KzfqkZ+2n6re/MbiN0yAcH3GT0sgGU
	rZTWK69Z3T3ljh5+uvnVLziXSS4PAITkck2yhGxt1xGpautmZDZm2NxyBDwGuDrfhhddKGo/q0e
	uhqjA2JdfPlI3vBz3UPwume/sCpzzmWE=
X-Gm-Gg: AR+sD11o1yMeYPEJa1K9CI8xbZbMAmecp3T33aIb6dRwHDycdXuZIHBWhbk0HFPsE8j
	BIVPfOf9zxA6ADU6npjrTwlyq+aKg9P+/SwbSP5Q33JUt6+cwzG3AQjzGeemnFew7eIn2/JkDny
	qHf6EBNtMga1gs0ZQmgn4hM6TwJDP5HS5Kt3OFalqrWq/mCwTf+RT8pSYHoXUeSpDwc9f4jedzD
	EYU78FWdMCiBNBkPVS5kSNzYsgmRVzxi1XgalI0woX+oWru7j+AJ9AM2VlOywtUKXdf13qLCd40
	mrOs7n4EKLnYXmXrVJgSeJccdIbJKHBjtSP97uuxbjjDPGPui5+1u+AAmFkMsvFohrBnLGfqonD
	l3gwPfwIqSI6Q4L6SvIOi2Y05VV6bFmDgtp9uucJJ4/lsuT+dq+Fy8TF2JQDX
X-Received: by 2002:a05:6808:5183:b0:4aa:cad:cb4c with SMTP id
 5614622812f47-4b35034cfa5mr4812559b6e.1.1787643503617; Tue, 25 Aug 2026
 00:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <ebaae70f-9e21-4673-b051-09e30420631e@gmail.com>
In-Reply-To: <ebaae70f-9e21-4673-b051-09e30420631e@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Aug 2026 00:38:12 -0700
X-Gm-Features: AcwNN1W8vA3ZcpOvSXBEga10lYTWNKiB8xRwYHhjgCVwnrNtEOUANh4b65PXrW4
Message-ID: <CABPp-BHz2EsFvqpcAAiHSa7Lu28pkoai9GLR_ts=b1098d03vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 7:45=E2=80=AFAM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 8/18/2026 6:34 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When a geometric repack runs concurrently with other git processes, it
> > can write a new pack and multi-pack-index and then delete older packs
> > that the new one subsumes.  One or more of those older packs may have
> > been indexed by the previous multi-pack-index.  A process that already
> > had the previous multi-pack-index open keeps using it, and that stale
> > index still records the removed pack(s) as owning some objects.
>
> This kind of race is why 'git multi-pack-index expire' exists, to
> delete packfiles whose objects are all referenced within other
> packfiles. The inclusion of these "stale" packs in the multi-pack-index
> helps halt reads of those packfiles by new processes while allowing
> them to be read by existing processes.
>
> This is currently used in the incremental repacks done by 'git
> multi-pack-index repack' and maybe could be used again in this kind
> of geometric repack.
>
> (This dance is more important on Windows platforms where read handles
> prevent deletions, so it's common to have a foreground operation
> prevent a packfile deletion in background maintenance.)
>
> I do think your attempts to be more robust to missing packs is good,
> but the comment thread does show that it's a complicated situation
> that we may want to avoid whenever possible. Leaving some redundant
> data around for some time interval can reduce the number of times
> that the fallback logic is triggered.

Oh, good pointer.  It may make sense to teach geometric repacking
about "git multi-pack-index expire", which I think would be
complementary and reduce how often we fall into recovery, while the
changes in this patch help keep us correct when we do fall into
recovery.
