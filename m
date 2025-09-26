Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E62BD5AF
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913126; cv=none; b=Xoq6IvityZ59TeN2Ys9BvNKQjUgB7axKaDbv3fJ0sRgcqVHPLTDwTr6qjHsxPifRNLzb8Yb23PU8MyIEHNs3cvAAFIoghuUsZ5ML40KdkzHI3dppiO4nZ+OFu3r1G/Z/9eJdjnEpAYpsGnZA2n462/+64xFO2tjy0t2Xel5yu7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913126; c=relaxed/simple;
	bh=Ec5T7V9JBMZ8ejBKyD0xN0Z9PYiF/ainwyzlnJZuAwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOeWpTeW+BocZzZ02yiJ2t3GzDIOnHzjIOFShx7NjW/BjFUHuI9kng72MspRDDu5y+SZwfair6wQTR2Oq3Kr6SJWTla9Z23R7KNaas8gLtBF2ffzUjx8/bO/AIr+of5FQs9IwAOsAJn8sNycqhGUKhMP7plSOh0mGCF16QHPsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+gmiSs9; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+gmiSs9"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-42480cb4127so27798725ab.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758913124; x=1759517924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjT6XEAWXF5jkNCarNRPxmN2nt1ZNMb3WsnbIm1OGE0=;
        b=a+gmiSs9/i6W0/mSNuWguJd2DRh1kbn36X1sk3A4WRRQ3M/zJ92Z4RhI6IpTjYwhxz
         aoI/RFFc5OtywAleAIJKTpbPf6SEN2zolwWJkqpp8dNeiOvwKFAfDu8+Q6lqDLX2oIYd
         Auyp4kgfaaFY1s2mqqq00ORWCJBnA6l9Cz8+Kgb1gj0LNQFA2uzmc0LI23mRJA9354wP
         RQoybF6Yw3g55zChTC6zarhXdod3s5Ebjt40pgJjDPLkCq3NUzgXSe/XoSa8ssIwIE/Y
         fF+VHOxf5epINjJV3kpFAKAD9IyRJ/WfmazpCKPFKO/LLnbkHeOslg8+hSiZrQPWy0rT
         BDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758913124; x=1759517924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjT6XEAWXF5jkNCarNRPxmN2nt1ZNMb3WsnbIm1OGE0=;
        b=B2auG8JaxCSjWNU7sIBiUn3CUbNQzy6Pb5y2GY/2f7UBNHH4kcb38uoFV6Yq4SdK8p
         ntyiPwGBTUQuJctNjxJJ21lkktr7+6pnpTQV4ND8M8RKI2NP1xqrOpoOPCucizsOcn5V
         IZuDiV06dEYAAilM3QcWVziXG3tLYj0qcZfzh10vqAIdoCGt/SEc677BWmVFT3TcWhkx
         8cfa/cGS//NrP9lZ9sJIDJU/ufm+XIXxzyPlu9dkMsPQt3DLTusLm/GKlOdQS8ypuUIv
         Ks0gATsreWGsHBq0U+/Ap4Rl8O5P3ES2eBO+4uQVvuUUZkYMSiZWKRROCXQ0cweXDdlw
         zk1A==
X-Forwarded-Encrypted: i=1; AJvYcCXXD2SeZsXKvFMERWxc+W4MzakyYesxXXAuF7yhS8XW4KgV6bIl38CUPlbxdWrubHNOY8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWguO4UbIgwEHYAmyJLeBBSIqMggsr25fQHwrDCeLdgQf8kTE
	Xkmw6F0VDmw8U8F3gd+ErXgSwTsB0daD4XvkW7lCjTBZOMwZsNGJU1eJQ96rhwfNeUeCBAVXq4P
	qtwA9PUT1hT7WI62vogFdnhHXq4qKyKw=
X-Gm-Gg: ASbGncuY9BkhT64FYOpF98yXGa2jHjiD2JBpamlN0WktfO++zig+v5MWl6AZTt4VAA5
	mSfoza0dFZ3snEwEFta0sLfflKH3OXggn/TJlHBwCCeEYsggNU5MK9sXi3gx/j+BMWJ07fov2OH
	vxUls7gn3c92t4lEvy0bv4QbvQhBf1nzuxf9aBZnq10gUNgkt9MYR9wxk+Htnxp+NB2FN0zyOq6
	rNVjYzPQ5gIl2vW8ySkY5ZSa/mZ+Sw3eyaj5eaq5A==
X-Google-Smtp-Source: AGHT+IFk3cR/hocd4OGGR4KZkOT4rZLaxO9NtxThJLgwKiLM1Je5AVdbNbDftoeejlSqj8YJ9WoQ0iHC7ZRUitpiJOk=
X-Received: by 2002:a92:c26d:0:b0:425:b6a6:77cf with SMTP id
 e9e14a558f8ab-425b6a679d4mr57365125ab.26.1758913123909; Fri, 26 Sep 2025
 11:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com> <xmqq348rodiw.fsf@gitster.g>
 <71c5d266-18ff-4ad3-81a3-30b9a1fefde2@gmail.com>
In-Reply-To: <71c5d266-18ff-4ad3-81a3-30b9a1fefde2@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 26 Sep 2025 11:58:32 -0700
X-Gm-Features: AS18NWDxJWj_ZdRaQ0viUSJfuRSLkMTr7nchXVMxFRK79Y6O6gB8Drc3nyxXjYo
Message-ID: <CABPp-BFMQSuKd03mv8oJ3+Bm7j4TDs2UrhhRnoyttB3mtdRFiQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] sparse-checkout: add 'clean' command
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 6:40=E2=80=AFAM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> > The updated documentation was easeier to follow (even though I had a
> > "Huh?" moment with "Opportunistically" a bit).  Comparing with the
> > previous version (with my rebase to get rid of the dependence on the
> > other topic) and this one, I see a few more code paths have learned
> > to pass "struct repository *" pointers throughout the callchain,
> > which is very nice.
>
> I'm hoping to see some feedback from Elijah whose feedback on v2 was
> very helpful. Here is a ping to see if he's available.

Sorry for the delay; I saw the series and I've been meaning to review,
but my daughter's hospitalization a few weeks ago (she recovered and
is doing fine now) put me behind on several things.  I should have
some time to take a look next week after the Git Merge conference.
