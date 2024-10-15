Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325F1F80A9
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020260; cv=none; b=mVU2JLWT0B5xeF0Jvw2S72Twy0/WJhodz1ms/0MSrIfmNYtRMBWNodZnAclW5QqwnRfcevWGY0Etk5sdok0X2DmlDUcEwy2zJjNfvlg4tsC/XPeVvSqFDE/aMBAZ6WUMDdDgRqP9xv9njavjGIws0nFoCC0ZAKk7PwEnGGqdpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020260; c=relaxed/simple;
	bh=Od4J7m8Y9HldjWT39GmMEj06BeJbZ9u/gRtFUrvnevI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF5bxhd1bAjL6HfRkqb6EFOTQlWlhDPH3CEa9byV3xev0b/ihwbIzMQSym0PJdHoI+QMZNiYX5oQN7gIuztF+CptqqsIEWlTNHlswpCpuX6XBd1+k0XbRqB9ThAhLdpT/v7iIPJvkCtRQd1NR/kwXqOcTHlYCEXzBw04ejFMdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wmBUlCjr; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wmBUlCjr"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e2e427b07dso42226277b3.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729020258; x=1729625058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BcOFQdRTMA5EuXOmAla+zIOj8XQBrcBlgElYX4Wr/EA=;
        b=wmBUlCjr+ohD5lSOKjvOZzEFsnmBhUzmyi4gqIe3EZiER7ZEQ0sugkSs/Bnq9w7Z2C
         Ql0f/lv3o1Ly/eB7Zdg53M6adOtJQ+z1vNuu//qytOPzh7Npnqgjoa3j8jJLRTH2DO8S
         Z6keW+/xEE1A5FETy8j+Xu+woFFWd8+GqUKP5x3D8ip9fQU89PEKkNo8+P++rPpekdxt
         FcFrfcVq+G+CAkOUB2HhsBasiwjwj5aJH4wAwpHYOuVUXMISDVPqlemkAxfOSrxObt2h
         u+DacjSejt3h5zxbPRdLGi/P7ypVp0wi/dHFdAzW3WGY8AAvcz5XK3VLe+vuH6DMyv+U
         B1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020258; x=1729625058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcOFQdRTMA5EuXOmAla+zIOj8XQBrcBlgElYX4Wr/EA=;
        b=svKGcdrtAnqwxKEHIOba5/Y3vzLQkHYCG1WNKB5srRruCxVHFD9tzsRNc49Yl142pa
         KNxKE2iZVToXgEVWcLx4Uzqw6FMx9Aoif2OyYbkYrDd5A3hSJDfYuT05svyiXNBmYuJ1
         VcdJj7yQhSKLo7UE0POfl1fATzQTYosA0t/71ANdyiMuRGRe89zQY9yhwb+39AWXwhTT
         iUjtqULss92o7Cj0TBztimcYC5nbqPN8VXAL2S5+QkTx1VSrfypJBoR8ee18n+vM+dOa
         rBKTvuW3/FYaRR7MSBGniSYBAesiaN+wO3uX3/EMJ0UqueGlbmM5QMr/X7TelfCDDWYX
         aL/w==
X-Gm-Message-State: AOJu0YwwHntesB5ivfETUkP2ltpYvsm85haCVSK/9DzR0HnXe9zwOA/W
	+/1AJh1RgJkIFRm6T6iYqG3RlWAY16D9rHOU6KRJ9R+OiGdYAt3yjAal2czvAaE=
X-Google-Smtp-Source: AGHT+IHoFxe9eHpLJf6EkneUOhcd6iDAUJMrDg2wSqEYrIrTrAJtER+Qm3xpCyCvRmfRj+3P2pfJmQ==
X-Received: by 2002:a05:690c:6305:b0:6e3:3a22:7205 with SMTP id 00721157ae682-6e3644c0082mr113072597b3.44.1729020258009;
        Tue, 15 Oct 2024 12:24:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae32d8sm4119867b3.4.2024.10.15.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:24:16 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:24:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] Makefile: extract script to generate clar
 declarations
Message-ID: <Zw7BX0BEzC07DRby@nand.local>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728985514.git.ps@pks.im>
 <7a619677c7af6ba8213a36208e20ab75c4318e38.1728985514.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a619677c7af6ba8213a36208e20ab75c4318e38.1728985514.git.ps@pks.im>

On Tue, Oct 15, 2024 at 11:46:11AM +0200, Patrick Steinhardt wrote:
> +for suite in "$@"
> +do
> +	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
> +	exit 1
> +done >"$OUTPUT"

Much cleaner, thanks.

> 2.47.0.72.gef8ce8f3d4.dirty

Thanks,
Taylor
