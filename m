Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086DA18FDBE
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778547881; cv=none; b=Ex5qdpgBQyF50gM2kIwIDnwr7VfSKhasvfZn7EO0ISNzT9bApnLHLazrATUb0ixQ0VYN8ww55H4OYibvVIOOpcK6ahMRP77Wqdy86eqfrZjTiNyftK1N0q26AFnZKn118qXDSnJSBus4WYcBdNWgiMv7D4LJ74aVZW0zdan3jn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778547881; c=relaxed/simple;
	bh=Ph86pqsOTjDkzTnMJf7jUnpzZN1VP9hhbv/+u0DlkuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3/vn8NK6swlGKuOz1/rK+7l1JkK+12wVm1KDRQWM7v2Ki+yhVDrOhOjss4MbSfXMKaZXU4Ix6IXFh1yTybjTPGep1Cgh0EXxhQ8suLfWqa4bUPypksjn8S2bFyhHRieBd198EWySRtZOonTmCv9H3bOfoRXNL0bwJNTSGm52/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Naylj8fn; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Naylj8fn"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651c7ddf514so5388076d50.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 18:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778547879; x=1779152679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZZyt0ei/kwChplWuQ/KQRcsUJ5LZBT0qt3Vp5S1Ixg=;
        b=Naylj8fnvr8j9eq6CYMdAH31JmiRNbwrA/IlEKFtlCM7Heds7iOkEc2wOOz779jFDG
         MzXCYpza2vHlJx71F4ydWb9lHbq/BpG+4F5+sgp5V1a4V1nxlntKJH1Br2iiwSx9Q13O
         A2ZCV3xM2emYeiUPWNo7f1yi67T8gqn6o/JDOFmAwr7uOByScLMvh3POZESKEM9CpWdR
         ULG0Mebev6NmEaD0LrLaMHqSTZEBxWS5nTbVCZMba3eGd4SUHpV+OTjF7MgS2sayH9DU
         CBdwHLr5XUKrwf340s75xLJfZqdZBXlPHiIkgXMu/gnUeBgkk6Hzj+H383upDcX4qYDJ
         rzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778547879; x=1779152679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZZyt0ei/kwChplWuQ/KQRcsUJ5LZBT0qt3Vp5S1Ixg=;
        b=dUz5j46v4ye01YqII3zN2UtV6/Z68dO/FTYv8Lwe28l9Om/DZJhT/Gojd5qrR+E0up
         Jn0X9egnI+M/1emWtpUXVBzUUS/lmWMQiB6K/PMtPQk8hF3l9mbgQSDub5PlSIXUwpIk
         cobw+tGeTNne8WzfSjXQC5WwRXiAdWDdRPXUfDIs4B0cff4X7ipnR9z4N2qeaK5zDjby
         SeKmmDNYEMvHfy3zPJWg8mbzBEMIiD4uORRbscuZLfG9GsDDJ3B0SBGK4lj0/SpogjBv
         +VeQF9F5kz9ewze3wmyzBO1L6yhj0aNuRxvSCiD66e910Iea9V6vlh3LIm4ucxTQ5Mz7
         /m2A==
X-Gm-Message-State: AOJu0YyOhfcJlAiTOi3NSXSh/PaKxaUm6UNfrJymPMQdXlU8Mdkwt4yc
	3rOsNtl6+6aKcVIgn+Jc3WiVrzTvOzbrmcq/RIo9D9DjcGvpC39zFk3kkuNg8RtbqU4=
X-Gm-Gg: Acq92OEVxH9kFJU/h5uJ/WXJdWytlnWWhzSMB6OrQ3MOaLhuYRChmHSV7oR1syzadrc
	xMH6nPj/TxiBi6mNr6V5p94jBhiRbX6IJXLqJj+fbgeze5EKZnedCK3WZ0wNCwWYl8y349koov4
	ryHPuQc7izCI55YZq1SwjeCQF9RUHpIss5W64HCOOmXf33FOjfxLeFSHNMmdNwoww05b6ta8r98
	UmLZBP8eMGYBHpNfwjOktz+BljBN7bPJp+maB1D5+Gx6l4z+KkKhyy/w0YQi7EY6f3vVZcK1a4W
	vTqM0JM0zDaD0EkGU650qFlA4IqmsbXJF3Jc08RDW3CM+gLhrxgU7+wQsHeSvJB1Bpp9B3QAH0U
	jdOpvxf2e19/szh4ZEYcAH9KIBOP0eC7iUQ3D1eB/7ELU4d00mQifP2mHBbYnuVpXWzUrWLfHCI
	3y7GmTj4J+eoNxpSmG72O6DWUEYSY1JFtK0Lb/T/FrTpXImY4B8tZ9sz219FFST3ow+iLyiRTxu
	42s0hJqyzHxJaNnPFbnZYYYUzRxECnnzMcleg06LyQGkvjPC4etOBjgO5Ye2VASiH/3Mzp/4+do
	IiqOQXDnKYDNhj+8
X-Received: by 2002:a05:690e:4849:b0:651:cd6b:8e59 with SMTP id 956f58d0204a3-65c79f37c13mr17795011d50.62.1778547878993;
        Mon, 11 May 2026 18:04:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96baa3a6sm6228249d50.13.2026.05.11.18.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:04:38 -0700 (PDT)
Date: Mon, 11 May 2026 21:04:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 02/12] pack-objects: pass --objects with --path-walk
Message-ID: <agJ8pTOLq3bT6rrX@nand.local>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <5cc63833800d12b09ebce882ad3e25f61c9c1940.1778523189.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cc63833800d12b09ebce882ad3e25f61c9c1940.1778523189.git.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:12:59PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> When 'git pack-objects' has the --path-walk option enabled, it uses a
> different set of revision walk parameters than normal. For once,

s/once/one/ ? Not sure.

> --objects was previously assumed by the path-walk API and was not needed

s/was not/did not/ ? Also not sure.

> ---
>  builtin/pack-objects.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Looks good.

Thanks,
Taylor
