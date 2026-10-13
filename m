Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904A395AE4
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877299; cv=pass; b=BshgHFfwt+s6ufhNoHuxsXWiTOFe8aDrinITFjhqy3DFw0K50ofDlGE8l3EONXqq5jEoo+JtdaznoRZNFtStu/k2v23209N+IkoBBT/jjHXXhMMSpfBzRo7OnmLZDYtwrbaBWl8F2lCABuR34vHJceeshy20fQ/uDucxUz2Lunw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877299; c=relaxed/simple;
	bh=pYw9Lb9QJ5+TVFpcyC4qpYY6AvpIwoHVBoZR6NrXWM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A03DTUGKmcZ+dOpIH4mJYVu4w0nvvX5s94bOc1b3tI/f9OShvD1lF6bRpTz3sI8a/juIp3D6/2J6K+Dv+qWomx0lrMnKgSQhA6DcZRalsNv2B/IekCvTCmKNPygpyMYLaU+w0rQHNDfSQXvOdUmcIvO6D79uAs183tRvkr2GgfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=C4/1HgKe; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="C4/1HgKe"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-677bf06de21so1846892d50.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 00:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791877297; cv=none;
        d=google.com; s=arc-20260327;
        b=SY4tE5roqEzYdYqy4LnHmCpDDRNITK2tmIYfvVWT45P/ddd2zkcfZ6ARzcxy9dNqt8
         mfqydoOzPP3wSTUoCsI8uBKFlbp4Xs1fVBCfHIkt6mhTwIdLjXW7CzpCTeYKx/35Isvs
         jkdlM1z6DzPmXxBp2xh62yg4c5f4mtlA7hioXgjUbHOlvBWHohTfjF6AU3PhTgE0jdmU
         D+jCbsprX2QJr+gZe3cQ7eOcJUIvtIJ89J3C5y1OiWY7c7tadzfkko5eJI9iRnBcRW0E
         4fsbgQdcrXb8nBYUubiWbF4L9JVIAM8/Th1ek5588ruk+TyBKJwZayVDCtwDhLY5bhWh
         x6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=s3Fb69QM2geZ1fgiqdcnzOoC6TH/1gw8dl9BiJNUv9w=;
        fh=HYS2XvMZofs/SMnHgf8noi6I6ab3zPGAlPHCn94HhF8=;
        b=mH1nBzffTvSJdAbLvBFV34mVIzp03Dy9AM/Qw0gfCcESVuVUgIXenmwYQWG69WM1ya
         3/4ZormcMBOzZ6J5Pz8tOqrGr9QPvH2J2qMqZ9foS6s/OarPDus2qJY43iPbPs1HvdOx
         tgjRft6Nfaod4u0jLRd3LwX9NUEcIHBu+RQpIO4XHDW0ZPNmCViYotMC8toyQzxEi7QA
         DMLBWTqCeSaBEbAowM0omZT0B/MkhKfBKJGlFWA7HoOkNMydijjYVcP86giI5bTik8sv
         y7Y0KpoW5zYOnUrppzRovQM1Nsy4bouNhQxkY/5Os1bq2fe/O1AGEHXEvp9XBHNgRBb4
         XadQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1791877297; x=1792482097; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3Fb69QM2geZ1fgiqdcnzOoC6TH/1gw8dl9BiJNUv9w=;
        b=C4/1HgKe1o+7MLX2nZseI3N2D7mBUF40QoNt2o8RysMmoScZEJyzBqc1XcGZd0Kyt2
         UGaotvQsdkLERLlFJCpl9xnikM0BieQI/ZMF2BRrbzJchDoW3K70QsoilCnGhjQJGcFw
         6P/pM5l8v7icq8VX8yZ8C3kqm1YJNco65LslM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877297; x=1792482097;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s3Fb69QM2geZ1fgiqdcnzOoC6TH/1gw8dl9BiJNUv9w=;
        b=IK+6OiDSY0N6566fXvqjXZZfFCSrndXROGZ1XghO2q9aw59+WpurKPLlURCb+4WGzb
         UE41jGJU5i1YxFAdggQggBddMXjLTkuTqOqYFTNsfTcpWHI8yFGbW4R2VfZOfJB8MuTn
         tI6OQ4dvkz0nrBN1ptd53YhT9NJlFRfHGCAndmS59FbSF5m2/ZfbeGGzlzln111MFXiA
         45eYkkei9fipN6ee8lHEpXCDVEZmEL+jLwBQcJQMxUVnW50SfAAQFPrpZy1GF7ydxHAi
         SNspJsWEs3EetXhUQ0js6sms1OyvGg13N96ktIJWiTN/i47hw8gpGvRP9ljxf4kjW68b
         yPHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJNSC3bRroAA622vbvO8t9xeH4pd2h2fzkkPU4OGwt1RyGzwC/3xLsitRYRgMuQusqBPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUdJ5oe2RvdWIPhMF7iTh5wtF2/Z1m0VXGU1fzKmZXIXi3kxz9
	POhMPY/LgWpMUZBOrWwtl+Tod59N3NOKKjaiJQNUkRdCzyy4/Gu5jmgKbUDNHerHRl1v4VC1W/h
	3UTEbFmaOSdgTXKpE/l8mcPP9wUHn9KsDtTdIwRAHrPL9XmOlYPrq48LacQ==
X-Gm-Gg: AYBFou0JKn34VtglU8HrggYLZR00Ey7Nn/MyNRr/l3mx9AjVOFmYNfazgwzbKSyJIYP
	OhTcg+PCzQEPv+TZqFAm8jdbpZpc5rIEatM5aZu0WhrWXdOwcSGabvVii7Z6dvIoEq4Q5kOxSk+
	xGPoroHKf9740pV+FpY25LBDY8332aQ+lXYzD39hz+tsQXyOojPWXIinJynfXEq3P0PFAC6WNgd
	cQaePnVZeWNWR/3/axagKI+syYxNC94LSF1ypB0TrqW9bEbm+bGsdrhqOopbCwQY84Cf53owxnB
	LZYhl5Z3/IL1aJcA7J4Ucu8q5QLKKVTFipzH/H23yR/xLB46GpQzE5Y=
X-Received: by 2002:a05:690e:b49:b0:672:a02c:61bb with SMTP id
 956f58d0204a3-6796fe86253mr692839d50.41.1791877296994; Tue, 13 Oct 2026
 00:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com> <cdf28f1df6cb36b006f367de0e18e23e3aa8d992.1791806877.git.gitgitgadget@gmail.com>
 <xmqq7bjm7o0r.fsf@gitster.g>
In-Reply-To: <xmqq7bjm7o0r.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 13 Oct 2026 09:41:24 +0200
X-Gm-Features: AclHuK9wd4WPUWkthVZaiDCQV0nVPfjCb74-t5SyyHw9d8yNaQWVB_QqQLwuU2s
Message-ID: <CAL71e4MVf6QcFsAdUnW3XGw_g-OLdUZFyopkELVLsCqvM=Qinw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] connected: add transfer.connectivityCheck config
 and rev-list flag
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Oct 2026 at 20:49, Junio C Hamano <gitster@pobox.com> wrote:
>
> > +static int incremental_check_applicable(struct check_connected_options *opt)
> > +{
> > +     const char *algorithm = NULL;
> > +
> > +     if (repo_config_get_string_tmp(the_repository,
> > +                                    "transfer.connectivitycheck",
> > +                                    &algorithm))
> > +             return 0;
>
> The file does declare USE_THE_REPOSITORY_VARIABLE but I wonder if we
> can easily reduce the dependency to the_repository by adding "struct
> repository *repo" pointer to the check_connected_options structure
> and using it here and passing it to check_connected_promisor() which
> is a file-scope static nearby.

Yes, I could add the repo pointer to the structure if needed.
I initally just considered adding it as a function parameter
(which would not be a large benefit, except pushing out the
repository usage to the outer layers at least) but adding
it to the struct would perhaps be cleaner.

I could also add a slightly larger patch to fix
the entire file and remove USE_THE_REPOSITORY_VARIABLE.
I don't think it would be overly messy.

I will play around a bit with both these ideas and see
where it ends up for the next reroll.

Thanks,
Kristofer
