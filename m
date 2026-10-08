Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7831145A1F
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468341; cv=pass; b=SYpqglNdH2KClSEJntZS8lEmNKTVCsm+/K+v3xYpPa0eI2O5QhtOSHB2OQh7Sc+SLmRdGCsjlT+W/aU/ByG7LiKDm2gC8FNHxppjIwd9K9CW9+yXMtt3mQtSOkeBsLvpDbA/4KYVWdjxNtNHJ25LpimLzEcv4aemQ7XyrYqlQF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468341; c=relaxed/simple;
	bh=TwHz7CyrPFygKaQGSlSL/JkR3cnYhbTAQGKb6VoIzvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqAEDmKNfmrHeE37KPLi/7f+fZc1/CAjY6qwsnC7C6zMQwh0SQ8iJIpCttxnhBQwgAxb00Hme/nrP+qMKtlKdodHGu3tWpmkgNA8Oj9I1UPSEZZs4rW1RU1te4pv+hfpMFAsHmlwxE7nvsm49M4a/nbZ3UA8V4rKyJbEIrIF9K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRmgoE98; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRmgoE98"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so4805378a12.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 07:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791468338; cv=none;
        d=google.com; s=arc-20260327;
        b=nHzcBO48T/FLXQ72+3/Fzbj9adf76HuTjK5Ae6Ca2qh2fg+tIxAY43x5Bg6EIfesAS
         uuKAfy+k8wlT0shMg3oPW1objckzXBmaK2u3FGRAwROK0lL8rhgnjPa97/G/wKeA7Izs
         YCPniwxFLWigCnBcvAjDUz9N6a+RZrcCwHyDoRdI1crnJdUaNrbgKJlgMhE3X1CxOKj7
         GVyzzcRYLuME1cZeKk/CuKewqPUxM09dPqlJa2DoHWipGW4SFfiE4e8tnDWCoHU39zRx
         zHWFj+a7NiNvSxNv9dOAo3SJOSga/u75rR0YSDpwYVXfTOZIeqyRc2NENNxV2sLwY3Lv
         FJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDyep13COIuFzxQtHcTDbgJcUdyK2yBdkxBXjyeXny4=;
        fh=SzJQUV4DVO7z3YextDGlGutlCJqbj2tKW7jl0TZBG74=;
        b=GLymK8fo+K4WAhsHM5hTDirjAUnSVwrj37nZL0L9zBurauE4YMaGx4c7dtQdRSq8G9
         HcPLtBKaS6ij7jW/NZ5GVO3cAbeCOLb3zK8OoYp6SWskwPEC++vLY8osuCPZgA82TEeE
         bsIyu2afRIDlLty0K6zWwLhc0wKsdgv/HXcI3QX4ExsFVQqg2QIfBApZSYekm4NxfMuh
         MMtSn0Z2E6x+5wnKeJiMCjFk6CvM+rL2Z/RebuCFnpl0S1EFPFmiPaB16iTXcx2Ir77Z
         G12bCGAlldrh7kM0m1b+F/Scsfqe4wmkSIpA+vfq4emCGJ/Jqs+LV8+S47XAoiO0ZTo6
         5mEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791468338; x=1792073138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDyep13COIuFzxQtHcTDbgJcUdyK2yBdkxBXjyeXny4=;
        b=sRmgoE98bLKsYaa8AAZcH9PTN7Wgl8ojf+uKBE66xcnKE5wWxgQxllkAnwLPWGYJy4
         j/LFehWxmRG2HIjPf18C0Sql6eGkqwfHzoEbtAndGde2CizdjY/1CU0jZG+2DiEKSbJN
         JKJQPNY1Ivq2d/wAd9EEeyUU1KPy5fzrqL7Q9Z9gnuuHXe548YTQdyR0zx3NRq67uuI9
         kYiBEVCbzUoRIjPCfdvrgD/EmLBtVMHpdpLSksJH6G7/g5c9F3nM5wGwZlzyyCuo7BAz
         KvIURY2bJKtKlJHTgneV4TYG5CCkWQ1Ac1w0n0pIAdBvZpjLHq+EJ+sV9vnX3xa2iv9Z
         vG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791468338; x=1792073138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDyep13COIuFzxQtHcTDbgJcUdyK2yBdkxBXjyeXny4=;
        b=VkB29XARcqj778jTu8Fw4nVfyzUbVMluLEdbq73sPPgL4eR89rX7u69buQVpLg9h+m
         KYmgBeD7iczYZJaO8WpcOl4Tm0b36ge7cKmlUE6zQvxuROAO2TEvzfJHoY1ekDIX2zqy
         BfCfqruyUInamDa0ljgxQcUyffOVheF/oDejrTdkFjRkCQq7Pd/D50+sz7U5VDAyexUc
         LrfbFWAYqEJAMHgpMDHIrReuet+K2W+hl9268vGg+/Vs2CY+NcVbz5XyIBSzvhdLDRnw
         d+E8q1VNWVEpNoFUAv4GjZZzLB3hsFVHsRl3h9058WRarbUmqwE36+8mTtfJVN7NPdID
         m2KQ==
X-Forwarded-Encrypted: i=1; AKwUvByEIJZn5dI6tkP0mbyXSeUAx6mcGREv830n8KiEqoD4SaYrnz3kLI/+EtSXtAe9blz1vYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYINhf7VGd0mYYJvl/L9ISg7Mp0FVBcsB6qi1w2hHo/MDPZ/iRAS
	PMc9/VHAvBGkRpsWbIbiObq4NV4F7ZA0nMTPjtP/3kthTLH25JguwS5t8ZTgJFP2k5353+eIuCd
	0t4JEGtJjO4zZLMNAUzQ1DUdGyVs+5bY=
X-Gm-Gg: AYBFou2P2TQIc0GPMqYWXCar4UbAuq/Ed16olucxgupbxu4qTh482rXGiy0SWthdmTL
	QTFzT59wD6TGFYncDadSsQuK2y8hWSNWHFjw6AFo3DXDspcn+IfPy1cPU6+sL1Xsi1j4wfFVN35
	rt6YMteBmjkzbYtgeIj1gzxMvkCsrbPFSKgF8kC06ij8dXQQZpygUM2weBKlgpUhPxDA7f0laZH
	wjRrttZAk7RcT9pKbD5O754MyEQurTsiq16BwFJVyJ74RVWZksgevjDKsP+P86DGttew/w2N63d
	pg+hZwAkYL2iuMl0sjQQQeQivtEv6gW1D++z9I4PClk/EzsO2LELueTYOdMvkq07WsnNw/9qk9y
	PlFTsPq1Uq2we
X-Received: by 2002:a17:907:1ca2:b0:c2e:969:a4b0 with SMTP id
 a640c23a62f3a-c317c11a3efmr516731366b.38.1791468337788; Thu, 08 Oct 2026
 07:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
 <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
 <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
 <DLEWITFIKFFK.NSANTRY5XBCB@gmail.com> <1b904e64-e681-4744-b83e-690f3ca94ea1@gmail.com>
 <CAP8UFD3kd=6QHp2oB+t+g-2D8bY-Oe5+_Vk+RJeaCa_xhxGrsA@mail.gmail.com>
 <fbed7a60-57ab-439b-a550-2d2b76ff24c0@gmail.com> <CAP8UFD2VutDBA54c1e5uiCjFB8v3Y6yS3MTtY2P6sM5+Z9y7PA@mail.gmail.com>
 <DLX41DP10SBK.3JNC50ICRW1RO@gmail.com> <077dca6e-27dc-43fe-9acc-20cf53651b42@gmail.com>
In-Reply-To: <077dca6e-27dc-43fe-9acc-20cf53651b42@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 8 Oct 2026 15:05:25 +0100
X-Gm-Features: AclHuK9X5cAgYYA8aFp_l1dDQtQGdjUq3XPjIgC8dhy3GNo7hxUsGD_oM3NYpgo
Message-ID: <CAPSxiM8_VM_U_pLzS0yCk0Ph+4Y3bqToZGHTuVi6DfPVnQ=fDw@mail.gmail.com>
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	git <git@vger.kernel.org>, Git at SFC <git@sfconservancy.org>, Tian Yuchen <cat@malon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> No worries, Pablo. Thank you for letting us know earler.
> > I'll wait before withdrawing on the Outreachy site, in case you'd like
> > to reorganize things first.
> >
>
> Cool. Feel free to withdraw, though. I think it shouldn't affect us from
> reorganizing.
>
> With this change, I think we can stick to our mentoring capacity of 2.
> We can mentor 2 out of the following 3 projects:
>
>    - Reduce Git=E2=80=99s global state to enable Git's libification
>
>    - Improve how command arguments and options are scanned and parsed
>
>    - Implement promisor remote fetch ordering
>
> We previously had the following mentor allocation:
>
>     - Reduce Git=E2=80=99s global state to enable Git's libification
>
>       - Usman Akinyemi
>       - Pablo Sabater
>
>     - Improve how command arguments and options are scanned and parsed
>
>       - Christian Couder
>       - Siddarth Asthana
>
>     - Implement promisor remote fetch ordering
>
>       - Kaartic Sivaraam
>
> With Pablo dropping off, I think we can keep mentor pair of Christian
> and Siddarth for the "Improve command arguments" project. I can pair
> with Usman to mentor the "Reduce global state" project.
Good.
>
> If we get strong proposals for both the "promisor remote fetch ordering"
> project and the "Reduce global state" project, we might have to discuss
> how to break the tie. I suppose we can only pick one out of the two
> projects.
Valid.
>
> Feel free to share your thoughts.
>
> --
> Sivaraam
>
