Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2061946C7
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616002; cv=none; b=B8ZHKTi0rU6TkznXrrWbRnwNdYlks+utGfO3l4kOdWWkS83o3ssSEh+lSRHLM5q+20WWVyaEBTufAW6tGGMGYo6vInEPVD2dznBkh0reTVS5EfJljhmXCMX5ohNLhRQG65X51jBLAbRi+fCSNXhNul9SYQdx2LkXuDctYD725pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616002; c=relaxed/simple;
	bh=ZOt6ErX2grrrD3a5e31Q+hQFPbSyAF66GfdUk6d1FiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6aq2lUry2OX22op+7XPNaLOZng7VSU7Kflx6AIulU1D4R8Gky5O9FipoZrTZCHxjeQeu0I8SsGU2RdRtwdhvWBn3uAOESQRCt2tKlLsx5HZgMW3DtVdKXr+iu04xtUnXMqjiMfpmN2Ugojp670p3Se8dk5J+A4ENC07sqxnzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBCiogUE; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBCiogUE"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-601ad30bc0cso671767eaf.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743616000; x=1744220800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOt6ErX2grrrD3a5e31Q+hQFPbSyAF66GfdUk6d1FiU=;
        b=FBCiogUE362vZgzr1b6clNvaB9ur0c8j4cg/m5TyPJr0ktbULS/IT+DsWeEHgUtyiW
         lpNrE8MeAO/oXJVHBFDq/6nyl0u6lin71x7WEqTmlriUJRqBJbvsCBVQEfPljUEJFzmi
         FQPdWp2lTeFXcwUPr4/q7HXk/VGVVOGO8tagWhLQr6O+6ZiAQGNvOAL51hB1tuVFvYYU
         KgmjzYLwnrowxmwfO9Xii+eFxRbEDHpE5Giy0pWSD9Qm0A62V3OLPkp8Of2YO59B/5ht
         VKye2iBaEvFscC5TmEgSvsR+4ArlKDXb9Nlrb0cbEjGjxQRExOaeregRrY3UcoE3cTnc
         xTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743616000; x=1744220800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOt6ErX2grrrD3a5e31Q+hQFPbSyAF66GfdUk6d1FiU=;
        b=Iwh69Wqgtw6j0EqWV5RcG+WDS8Q77J1to5xLCrsta4zUkMRldmGrmiQyQNkv5BaBzm
         iRXwOU33q0bBrytRHA9RF9f4zJJuiygj5C8Ciy5GMkr1W2iF+NmxHKtPUn9DUHb6Gx8O
         bKtBH1cploV3wfQU9x8VEKjOdanEPAThJLzYTAsaOes0d88Y39GWIsFszJVxDVKEw/j/
         yDwT48tJqC31Yhze7x0rk+5Vd/nD0PzlB1IasAM1RLoeQ9C7t2tOFzWEtfRbPbfcFpUj
         FhbvqcQ7aUo7yeVE7dCC5+HzF/+m66YyKclnjr/XfAawjI5/YpgwJfq1TrW49Ug7Ri9r
         Vutg==
X-Gm-Message-State: AOJu0YwEwiB6b5ZtmvXm8hJMI1ShiuOtva6obEzc8IaLSVmB6FVaybuh
	VUOjiUZOj4koOFkvs/p8e3Tk9NcWqpTOCNecLE17CPc5RMQuNiuFpc5AEg==
X-Gm-Gg: ASbGncsA+ocJLXuk4sfUhSYwv4fJJ5/QDwfVM8yY97Y+g8P2vsR5rP53WdXbMI2QA2G
	I90FxxZyB+CF/n9a5JiKZ7+SGnqhErzxUMKZE9c06/TC6mCRf/RO1Y7+S+mMJpFrsg1oxJMimOv
	mZr2/cqfK6pqHGWy8KgnURc/cQ11/yDhMka9CbDly05dGIwtj3oNKBAwmCy1X6LtI9wdW+nlQJt
	1S2hrKOPGn7bptvdlzeucSAFo2KOyn8Faumzl14b8BxlsxaId1vDLPSu7Fz8bQOYinI19I/4IHW
	aOQUHZq9VVGo17MMeXIyXXuO+JFmsqgK55Kkmg==
X-Google-Smtp-Source: AGHT+IF0AeaPKmFQKqXkRS7kRY1AgGglE6ddQKHpS8axPoSv/aUkRTYlaP5GkRbZJDgS9iFpylB1rQ==
X-Received: by 2002:a05:6870:6c1a:b0:29f:bdf0:f0f5 with SMTP id 586e51a60fabf-2cc7a935970mr275165fac.17.1743616000145;
        Wed, 02 Apr 2025 10:46:40 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c86a48d7efsm2864264fac.14.2025.04.02.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 10:46:39 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:42:51 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/16] reftable/blocksource: consolidate code into a
 single file
Message-ID: <i2zpjkbunx5ilmdtjns6dhsuuc7vdncpz3se3my43sajqqjsrf@c7jj2h3z7f3o>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-3-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-pks-reftable-polishing-v1-3-ebed5247434c@pks.im>

On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> The code that implements block sources is distributed across a couple of
> files even though. Consolidate all of it into "reftable/blocksource.c"

even though... ? I think you meant to followup with something here.

> and its accompanying header so that it is easier to locate and more self
> contained.

It looks like some of the block source function get renamed in the
process. It might we worth mentioning that in the commit message too.
Other than that, everything else in this patch seems to be a simple
reorganization. Looks good!

-Justin
