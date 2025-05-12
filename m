Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B15265CA3
	for <git@vger.kernel.org>; Mon, 12 May 2025 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747046078; cv=none; b=tvS68vGVCXU+kKOcfsEOE8EaKpOFoqBFaxxjubaNmwoSqAt5T1W0ahlNJdJM6DOX/NktNgQ+eD9YVCi6lsXo7HZa4eX2Dtm6LC3swPJXemIsRmJjbHfM7cSxxV2M5K4W1Jix6bIGDpAXuzpcu/BVxDswvuWmrnUSw9aCuiRGoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747046078; c=relaxed/simple;
	bh=cHEeg8o7WDA2ywkZDnwy5t2NMPayr7n0umSCeD5Ov74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXm2Hg+0/3qaCXs96rQaV6/lxVQ1D5hRGzov8DHV5axPMtZXTU81Ev1g5gICQzpXYPxlTVZGPYikA2jylysL8ZQ8N2sqIOvNETayzvynxG6D4gmJyYgFc3h9L38BeY/KW6X3m3VezQrKA0hXVIdxmThGezyGQ0g5ipuSj5zZCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSu03KdY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSu03KdY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22fa414c565so29914515ad.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 03:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747046076; x=1747650876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4qmJKU2JEJSeFtZFN7I54HwOMYbC+cIhiIFdzdUiE4=;
        b=bSu03KdYKLdyB142qsgBMAhy6gH9VCz8RiWO7x0mvMJMMGCBKxFGj/sh2mEIA77YrE
         rdVgtTtX0vXbw7p/VnP1BTLSdkbOZkDxZoHZaXMAnWLOrNsfM7n3yvpg4evdzTykikov
         6u3lCWNTPjF+vPpq7MBJt6X+tlJKECd9NPtZ/bP4fMfG5o8kmI56fx+OgnKnoQNHDtDL
         nv1cF6c3KHxTzBux3adZthTkQDAs/oaKzgWcYbLFpeVQnHBmLMWEiAtMFR1REgsY1osO
         688gkdb2Rq4C9NHSBDudmNIMebg0PzF09/KVQDA/+eemh4ESRYhZWwbeaoIfHHNP/UBX
         xJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747046076; x=1747650876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4qmJKU2JEJSeFtZFN7I54HwOMYbC+cIhiIFdzdUiE4=;
        b=S960y1xAqYhF6ttM2HH6D8lqLoo4HXTaLVTsgSUNWfzkaED8MnyFtxa1CpM2qg6MhH
         qYJQte5z6hn546FGHzYctp+khFgZVKj4mV3djuAXTanWLskSqGJb6BXKuMJ1r/BSBLp2
         SHcGQYUwjNkKS5xNpFAXoA5HMg8mlObcot2z3k5Yas9K/2ko06/Z9ugZviFv8fl2y5Vs
         RuTo+/hZUoC6vxMnQQkZcqRDoMEIoi/2X1Hx+HLvFf3CWEEih1W7njFGQuUnufuATrl6
         i1zOALU+8Xp7+6dFCN+9AG5jwbfW6VQ0Oht4cH1N6wmiWk1se37+Ka0MXmoWFXJqYxaL
         Ev1g==
X-Gm-Message-State: AOJu0YxuwJv2w0itOtPk2rscOYgnV0Bwl4G8m9SBxwl/7KomFNFvQO97
	OF3fhTELNZ06OQ7qsImOAOerseYW0R4pC4V09ErRmFJKdMlxUAyG8ZfNbQ==
X-Gm-Gg: ASbGncv+3F7kifC6NAIblA1s2dHV3NiKQKA2sFE1oTc4jKV/Noxq+2z78aGGoBpWYwS
	sg3+IkDQoCBBVeB/aKV06J6QvhbeSFsP2gV3q2wFjPoIlVbndI4QBYaoDoynR9P/5OWoQKjRW6c
	q753ftlP7BmQLBgGsPXCvHJWVZTjvyzGQmVi6z+SqBkVwJwsXt8CS5RmWRcoZ0wE0OQoeKMWA0U
	2WVK9dyAIZzYJBK8NoN6LRlheeC6e49m5RVlP0pFGzMkz48SHriSgSsSIJi5MXi+H0BptIyUa7Q
	NfJd8MFr8mMgC0qDPnlxWn7f7KfyrAMpt0OAucDXxkU8xdc=
X-Google-Smtp-Source: AGHT+IGdUGqjwCEM/3WFu7eDdmG0GX3Fuw8XtgLv5EQ853bomDJkhmOmDwXbTb/S0Kfy9/atQ/ytew==
X-Received: by 2002:a17:902:ccd1:b0:224:a74:28c2 with SMTP id d9443c01a7336-22fc8b76a88mr188737915ad.29.1747046075933;
        Mon, 12 May 2025 03:34:35 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc75469d3sm59719325ad.41.2025.05.12.03.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 03:34:35 -0700 (PDT)
Date: Mon, 12 May 2025 18:35:05 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <aCHO2dqWM2m6xt9m@ArchLinux>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtzm2bDRSTgEO-@ArchLinux>
 <aCGzLxcXlcQLtorC@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCGzLxcXlcQLtorC@pks.im>

On Mon, May 12, 2025 at 10:37:03AM +0200, Patrick Steinhardt wrote:
> On Sun, May 11, 2025 at 10:01:50PM +0800, shejialuo wrote:
> > "load_contents" would choose which way to load the content of the
> > "packed-refs". However, we cannot directly use this function when
> > checking the consistency due to we don't want to open the file. And we
> > also need to reuse the logic to avoid causing repetition.
> > 
> > Let's create a new helper function "allocate_snapshot_buffer" to extract
> > the snapshot allocation logic in "load_contents" and update the
> > "load_contents" to align with the behavior.
> > 
> > Suggested-by: Jeff King <peff@peff.net>
> > Suggested-by: Patrick Steinhardt <ps@pks.im>
> 
> Huh. Are you sure I suggested this? :) I cannot remember at least.
> 

Because you explain me a lot how Gitlab handles and Peff tells me how
Github handles, I add both of you.

> That being said, the change looks sensible.
> 
> Patrick
