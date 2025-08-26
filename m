Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452215D3
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172478; cv=none; b=ZhwWDvctbVnd6GiKp+PyxGwlFPtsc8ssLGLqMCKPt65KmHJfWB8dfV9FR0uya3RN+uGZ4cuH02HjUyNUe7cWOF54Z5jpZSXgulT53slUUrOgygJ0+67R1mVCOFU9gxjtiPL+sd5MovxIpZ7k7c9uo63cJe3Dx+3kC6z133cJ5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172478; c=relaxed/simple;
	bh=YXoM5SHq9AwAdK/pixCmFwu/VpqLj76Y1CD9aYimFPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0u2FNkgUpYXWh6dbMlf2nESAJfMQnSnTcPUpoaL3HExZHT70zqFV7/Z4cCUoQswBMLK6naaMAXHdfUs2B+ZLgKhen53/WI1k+ZMrBECu90zGLPyN7GoTcf33D97qryTrIMyl6QuNkxxkzRSXpR2m31LIlO1y4tiaQH7rPRhLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iVyMq9rc; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iVyMq9rc"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ec4802d359so10302255ab.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756172475; x=1756777275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXoM5SHq9AwAdK/pixCmFwu/VpqLj76Y1CD9aYimFPA=;
        b=iVyMq9rc+eS2LUuDt4ISUmOhtNIbQnmqqbOLI2i1xK+KWTtLF6dCKADzxh8sW0s2xV
         I9cli5BaNO8eWTEnrtLA5KQPGFox9/OTQ/RRHSPVxriw+Bsdpk2WY+mttIlm3xUkXJxa
         imQx1PjtayL0Jyh1CxPnsl15MDzpT/aG4YrfsMQYK/VJqcxor7KtK4IzwYW9nBBPciJz
         zs7TltxmM58pgquGu1OzbormHriAPkrCHgLgemdBoryRW4BLJpCOUnaehMMJBa2xHb/x
         SzsD85wufkfWesBkEiz90MC/5KaA7GazrFfEn58QquhgvVDo3+I2GLxjFrA4fFABuJF7
         EiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756172475; x=1756777275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXoM5SHq9AwAdK/pixCmFwu/VpqLj76Y1CD9aYimFPA=;
        b=mng6h1MuYbKtAf79X9ZrITe1lTchAHwP4tGCgWomd2ljuc48o2Li5d7D+jDvqyj1pr
         dptdgyro3qxGOiaQJa1l3A/se9tQHdbY+aTDPQf6Icd/Gcu/FKawhbNfhSlyYWnmaTSp
         V6VozqHtWAybdgRMl1mPz2dVnuJ3TWRlCetBz5yUPLCg9FlbQsF0KM1XDAaDT3ydbpVa
         B0yFuRZLe91Cm/mWKeDzRGf/8UaGFMLFHqv/s4ImG7Fol/nFxP74NEQybfNzcb+Olk02
         4BVKVq1VUzeRLi9jM/FukzLz3JkzxtXy61rSyaB+cMZ7etTW4PZz7d3SCdFOLKyHWjCK
         33iA==
X-Gm-Message-State: AOJu0YwSSCFsxnv+3fzC5bJX7ScbtAUaG8hjU+Pg2iBgaV1cFZ5Xivcx
	LwwmH234GLr7DHlrrG5RwKfgUN6c7BVW84trkvG14Z6CSdmULYVKRrkCmKhEEhr3jiQ=
X-Gm-Gg: ASbGncs+luXYTgTWkT5ny1PK4gWTiq3eLe8+XSW7vitn0uf+CX9BYbpGPT0mlQgy5pM
	Cr4EqzApce3J50/UAQkBKlBOu38Ao4nz1LUil5opQlrDde5MK4JXl9eu9MjoyTl1E/V9vFVQDFW
	Jg1uJoyto+FSlKZrY/RtvvoCfgn5Gfhxnb7SyA3HwYINSIInnkcSgNsnS86MJWAil8sAJQ6MaZJ
	X7Dw6FqC7mUhq9C//zfyIumM9lsH8uuoDaOH7/pg5p8h0VagcTzW+b0GU/SrTMZuupD8TRgXpSu
	uK9lcUnpOpgtHu4IMVqSymvP3N0p6BciEcYHgfqoeQzNj6Gf1Hly207eXwPg54u1sqHK9KQtwFJ
	BDeaagzcwZCE/eP0k3M/QT70DlEJjWoi4R27ohCJDno0alcEQ8f5T/sVoWcpInGx7yx5XUqcvqC
	059x8uANo0z8NDl570Vzo1VOpzQg==
X-Google-Smtp-Source: AGHT+IFEBPAh5Tq1E2/G5X36Cla5uKilClVgU7CBblHq1MnCYdnRe1I6LkEykkF9oGfy/dYgZY0tmw==
X-Received: by 2002:a05:6e02:2167:b0:3e5:4942:88dc with SMTP id e9e14a558f8ab-3ea4a866cb2mr148964565ab.9.1756172474734;
        Mon, 25 Aug 2025 18:41:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3ea4c761718sm59357845ab.23.2025.08.25.18.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:41:14 -0700 (PDT)
Date: Mon, 25 Aug 2025 21:41:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 04/16] odb: move packfile map into `struct
 packfile_store`
Message-ID: <aK0QudxvIR4Jx7KK@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-4-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-4-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:02AM +0200, Patrick Steinhardt wrote:
> The object database tracks a map of packfiles by their respective paths,
> which is used to figure out whether a given packfile has already been
> loaded.With the introduction of the `struct packfile_store` we have a
> better place to host this list though.
>
> Move the map accordingly. `pack_map_entry_cmp()` isn't used anywhere but
> in "packfile.c" anymore after this change, so we convert it to a static
> function, as well.

This patch looks exactly as expected, let's keep reading...

Thanks,
Taylor
