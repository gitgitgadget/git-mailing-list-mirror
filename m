Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFD2367A0
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 05:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756530257; cv=none; b=PBiV2nzNiy1gDXeb2u65v41H28mgY1+drH/CBOBeHyup7z1CnPkFY+r1vaZUnaVPrHnLZn0ZAdTNPS5YjtqPCmxo8xvoOPJWI6rsN8NBTwV4tfZmTKtKIjF0LPGWmX6ugUGmB9G4ma5a+ow553lT0iIHrNjgWJfPR4fYe2LNWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756530257; c=relaxed/simple;
	bh=xjgpT4xdS4HoRlwxGGWqDCuRo4jucR6RWksbjoLrMTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6dPI22fuE297BB8aU0v0dkFJnTnoNI9RNqsA+fA2mFade/MJoapcfDFIAkQ9ayMwnmWI15iIjX5wM8yFfCSk8mrCGU6yJK8F8Y50nFEwSESQyXiGxP9pfwf0/fpey5xtK3Rjs+LKQJlDkL5DUyxB5YiSHG3MLn6vhqdenSoPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNGudeyb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNGudeyb"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so2897411b3a.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 22:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756530251; x=1757135051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjGTtM8+2S5SrqOnceFJklgq4sIB4nNnfrBHPY4fUDU=;
        b=MNGudeybCGI2FmGxd0xC7T62Q6w0x6F2lFP2CY8fd/EiYIYzx6K0jtvSNmRarI6LfQ
         bayQkcXtI3H+3BHHOalUOV62wL09NzyGAbDDaLSjwtOEkiay/Jf4ff1bPSrzheTEL1+h
         DLMyRxiJuUtQX1qhPmZPmD+r5hqiBhsdio/V6LK3Kh1ohbnX++LctUGlL8OH4SPVG44M
         qHvaJ773YubuKcGM5VUQfp4++A1m8tP1GZkLvzlEc8C5oZjZzKTU+J6/zpQ9VRgAguaN
         ojKhzBYrchADhTHUzqUMV47K+Mm2yEK+irWnhFVk0RdUU+cIIqIG+PmwzjwHu2yBSTa2
         Khag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756530251; x=1757135051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjGTtM8+2S5SrqOnceFJklgq4sIB4nNnfrBHPY4fUDU=;
        b=aSvnfIiGxO9UgbTuAQvseK8btfbGOky6ctXdW4LZfMNUkJ4qFMmyGe8+hBmr0Y9nsD
         xmw3i9eiMnLHS2LoM4d8jaIT8nY2mCHQOflnvyaoTcQqS9q+NchJkp75xKhDA7d8UWu0
         9Z/MV5AYY61m57D6OYl4IGY3mv4d6dBvrd1scMhXOamxR3zucYTwNFIekpYwEDkIDlio
         vDaj6lptFWJnkOLSeTimwIyvqA0fjqSTHqE52fZCmZNle11b5xlpC6SSf/d+JD+Jk86B
         9Nn1tSAeU44GASUq+s9i7nwnE3FmL70VJnG/oG+j2eMBqm0HoDiYIrbwRvSaHaqZDNeh
         Pamw==
X-Gm-Message-State: AOJu0YxfpY3qwDZbrAWM4xrwYnIO4G4XJgtgm8CIYqihucswBhy0jrgz
	cXg5UxxojISwsWZTV+4WgPMGc7H2OX+SUTR03X/l7fuxxam+YQy9RkBt8IJvIg==
X-Gm-Gg: ASbGncu2zH8rdS5pnp9mbY3Lw9gP3ySzjdxVJNDpM3ugGkvqfvMy3CkAuQHXnzd1NIf
	JtDNwoR/P8vrVAhU/q7uI8+h2z+2Dl7C+HwDMy7/Dgn97q65izV8inrrOS9XVw65+u7w2Kr52NG
	958ZFS1ul61n+hxesenKwiRxoOPUslp+niYDM6TXL70QOTFSlaWO3YBzs2NnFpBgrKWi5ASjrth
	CbpprCRHh9CK8FAQE4LOLsZ1MKDCHmpb0Id9TOP0aIFc4zZhwdzuqwCqA0CVYsGxfNRKQKHSV6A
	6lTD2Pp9Uwli3xlsviX4Mid7N1y8zMBws2tNOybf2cPeAtfQbhQ/qkKD3anTat4BOxzVYoFY+56
	C9XATf1DU6iKRke1evg==
X-Google-Smtp-Source: AGHT+IE8I3AyF8OpB8Ib5P0PSezlB7tkcmM+dVqqM9EbOdt3fiof2EJ5F3iRBpYF8t7F7BR95jyHsA==
X-Received: by 2002:a05:6a00:a29:b0:76e:885a:c33a with SMTP id d2e1a72fcca58-7723e3efc04mr1537216b3a.32.1756530251364;
        Fri, 29 Aug 2025 22:04:11 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a4bd1ccsm3962512b3a.47.2025.08.29.22.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 22:04:10 -0700 (PDT)
Date: Sat, 30 Aug 2025 13:04:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [ANNOUNCE] Contributor's Summit updates
Message-ID: <aLKGTQljGZ2cmOan@ArchLinux>
References: <aLDEPRnXqazmxwzq@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLDEPRnXqazmxwzq@nand.local>

On Thu, Aug 28, 2025 at 05:03:57PM -0400, Taylor Blau wrote:
> Hi again,
> 
> Following up on my earlier announcements[1, 2], I have some more details
> for the Contributor Summit at Git Merge this year:
> 
>   When:  September 30th, 11am-4pm(ish) PDT (UTC-7)
>   Where: GitHub HQ, 88 Colin P Kelly Jr St, San Francisco, CA 94107
>   What:  Contributor's Summit
>   Who:   Git contributors (more below)
> 
> If you haven't yet registered for the Contributor's Summit (whether or
> not you are planning on attending in person), you can do so using the
> following link:
> 
>     https://git-merge-2025.eventbrite.com/
> 
> In order to grab tickets for the Contributor's Summit, **you'll have to
> enter in the special code "git-20-25" to expose that as an add-on**.
> 

If I understand correctly here, I'd want to join the Contributor's
Summit remotely, the only thing I need to do is get a free remote pass?

Thanks,
Jialuo
