Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3511847
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710554197; cv=none; b=J9qzuWaRQjPKgGLwdEWmdUavx8/Fof/BRcIWGJCe5mJjH2HhBnRWUQzuZZiDlkFYU/ywPTNnhZGbhRieUsPskguf3lbYxKQqlZzlqhyVRnfkYSafTvRSUTETnY4R6OHoJcA3ASB4Akkqq/0z5XjER3sxGsERospLQfD+I00vBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710554197; c=relaxed/simple;
	bh=oTBkWeEP5ZTZ5l3KBEQIRvEIAK/cB5THgTYOrE4cRCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7cTzEdatBUpp5QAoPm/SVDycB9dqJ6k5tW4zUXBRDbosfdfE3qfCvMmUSvx0qrlhf/x+VdosHCaByT65Jrx88ag/v7IolOTsWVBKdoGrATYWIOz8vJ8FJqCYGtIKfflJjq1hMxQ01K8PY/Bq8t1Fb6ueKoFWmZYlfZKQ8RTWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UKnqHDI2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UKnqHDI2"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e29149883so11419101cf.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710554195; x=1711158995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CExa02mAo3LKklM6HOPNIsHZHEgf6VyX3E8eWBMYqs4=;
        b=UKnqHDI2n9wuQxssMtQvLw3yb66YPS/yeViGpWws3kQk9PSeuzxzFZtrV0XtHqMco9
         od67uPeta81N+u8yFDQCJdPdapGJi4Nbv4KsJ/ENOaVXNeWdGnFzf+kLaJPKg1oc70fO
         0BlundldXhSnmji/TkiXI0lRoJQl11uFdbvcfPK3QE4zJ0rKdH8rydC2e6987DyAMddm
         Cf0vD5mlGb2j9TN57skfXinjHBZbbJHxk19dPeP1JlLx1EznmK/8R351TRoK9mYZaKu/
         bkI/yf4Iii4z4YE1T8Zbxbr2GiirqQLY3uNQpT/dQoMOYsRu8joQu7V4COV7tRvr3awg
         apzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710554195; x=1711158995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CExa02mAo3LKklM6HOPNIsHZHEgf6VyX3E8eWBMYqs4=;
        b=u2MRrXWBhdZiw7+JGkhb0o9wdxebmBqrElKBxojYGKLzWBK7M7r4UBU/4F2cK6cVIQ
         LTxYxxX3Ma4i0VfX3iWFa1CSRjpnCPNQcFeM+w7XP9cEIHfxId8nGSBZ6MVSpE2agZhZ
         kaiqp850dLE77edozK5F8iw8iCQhhz4n5txo23ZmY07SvVJtCPjbxKDTfN8IO+SvjPWU
         RKxG6PsALaggQ68Q+RJvnR6s4TGddxMsSOF+/rWJGsQitxf28GjgVXxgXqBkMsMt++cr
         MboXYhOk+DHZw56DpjEoQuAff+/Ezv/UqTET2reKERSc77Oggh5DQNfISBr36AGHkE4n
         WPXw==
X-Gm-Message-State: AOJu0YyJ0rVcfDHZo5EKY0WIiR3IhK6WscWiV65Lakgtel0tEmrjlj3K
	eLYOhI/PqT7JOw1mBcEMBH35luAA6kIwl2Ye6DHnxvvL626cESvaXIWwmfXhVg4=
X-Google-Smtp-Source: AGHT+IH/MZ2VGviehLWGtfQP6BLIDiEsqIFz+RXVeJVduOnYIA4+6mAdrgHseUfs+1RFeu51aSq7mw==
X-Received: by 2002:ac8:7d92:0:b0:42e:b063:a35f with SMTP id c18-20020ac87d92000000b0042eb063a35fmr6539192qtd.8.1710554195429;
        Fri, 15 Mar 2024 18:56:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bb2-20020a05622a1b0200b0042f541ee072sm1123203qtb.4.2024.03.15.18.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 18:56:35 -0700 (PDT)
Date: Fri, 15 Mar 2024 21:56:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jiamu Sun <baiorettohr@gmail.com>
Cc: git@vger.kernel.org, barroit@linux.com
Subject: Re: [PATCH v3] bugreport.c: fix a crash in `git bugreport` with
 `--no-suffix` option
Message-ID: <ZfT8UiDM3DQhRX5x@nand.local>
References: <pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
 <20240314223406.79283-1-barroit@linux.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240314223406.79283-1-barroit@linux.com>

On Fri, Mar 15, 2024 at 07:34:06AM +0900, Jiamu Sun wrote:
> executing `git bugreport --no-suffix` led to a segmentation fault
> due to strbuf_addftime() being called with a NULL option_suffix
> variable. This occurs because negating the "--[no-]suffix" option
> causes the parser to set option_suffix to NULL, which is not
> handled prior to calling strbuf_addftime().
>
> By adding a NULL check, the `--no-suffix` option is now available.
> Using this option disables the suffix, and the file is just named
> `git-bugreport` without any disambiguation measure.
>
> Signed-off-by: Jiamu Sun <barroit@linux.com>
> ---

    Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
