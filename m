Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA9306B05
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862829; cv=none; b=SOqYtblVcHct3PYIx88i9fgWgx4pqe20QorLeekudp7k0z2lEfmJaYU5ZaQIKwoBy2jzc6p7FpQEzsr5ocmIl+lTZgQwa0804BSeaP4XmyyEZP6P/RtFCYRSriCel4otXNEOxPEpi62+9FxbCy2bNTfiyqRoI3dZvoVHReMULDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862829; c=relaxed/simple;
	bh=WUbPneILjgVgJtjbAG6trMUPObOfmyD9G5hnY+/nz5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4vjp/YUNQl1XTp8aJxA7NcLEOBdFh+xGEL5aD8zIKxOf2zZdxn2NnqofPkjIZmkY8ti3EddMjYw0lk6GwCR0HRXCJn+9tcbe2fwSHRV9ucTYWRFFn2HaoejR/0NUPQ0/EjY4jSjH5F2ZxXkhf6gDRa/WT4ZBINko/zXOODpiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFbJNW0v; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFbJNW0v"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so2652300fac.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771862827; x=1772467627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ft6wE9RCEUQ5NBXdDOQBQbLkxDFL1RgoafCNB9DYtU=;
        b=nFbJNW0vEIqoLyXbsi/yuc1ILTqlxWERtegFLpoYCQa07pgYTxIR2zg1IO/8rI/nua
         HRm8MR8gPgbsFYxW5zOfNdvHXBhabmFYaSIhJem9ynbZ4+OY/P8SOmcxlDUbVocCbSk5
         aP9HK6SIbhBwZQDecj8GOzdPjAhmBP8wm87jXXULoPLVXOCzeqIDNFvOJyBoGIhQJ6B4
         W5v9NVU00zd0k7D5NwrnBASH2qVnwhNm8+Ro0Zj+dS1gA4asbQhgVnIm8nld+d/6guio
         9HlwElCRE3K5PPGcjyLBZavCZmx3tJS7ocVNimhcr+VElAKmostAyDw04BV4/iDt3mfN
         H6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862827; x=1772467627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ft6wE9RCEUQ5NBXdDOQBQbLkxDFL1RgoafCNB9DYtU=;
        b=XUTWuXWnukyeBBWB/3iTl5fMFh+sJkekZmqCpAFL7K4cKzuy5riP9HuFQtXzV9Cqgj
         /YNK9pOm+y1kooosZ4x7lri1MaNn9l08HO87Vx6OxBxIg2hKyAuDbkohyYBdJeIKDtZ6
         hMmhNgH2op+fke3e7Aqkpop4uwA+yJo+4MvAGS9ufVw9Zzi/TeQ+FLNmm/mDHNnPBi7L
         48AV1weZglt2rxNEyqyxsE+Q5Eh+5wqPvH4cz8lvvFSaudPQpqowEcD3qpfyURgNuxSD
         qHiS4Me9YuuK/MTFXGeMnnS1+t2rBjVYE0dhgSvH088xCzX9VPObvrt6iO2uHQlP6aN8
         yj/g==
X-Gm-Message-State: AOJu0Yxlm9bWilaej06OuZGye2vwLAu++gDmnPhNSpSmhMpfOdAYWV0m
	wjZ7SU0Wcb3zPs97QLFEZL175dmxhj0tirY4JBn7jPR4FOPtwUzW286I
X-Gm-Gg: ATEYQzzopTRuLAh535v9YDlkq4ifTVXo71TI77bSKSUBhm1aAcbV+x0+YefSbuoRLOp
	658iyJ/u3DDhQW9kGkwlnrFhkQ3Ttw2WnfKQwJOh9TSoxwqgJulhZUGnSHFJCC7gkqtrrNfPQYe
	yHwUOWTH9FnkXMwU0XTEFs+eies1egSY5/VgWRNrwoyEBKTe1Tv65I65ffeyAFWpasavfvgoRDk
	3YXTtC2nFljcHwvQVaNttoch5go2pqRdJGQjjaT2y8kCopzY8VLIQy2PClSlB4nuS9207d4peq+
	BkoK4F9Hto/YEQD7z1FGNQTeeaG0hOE5W34haGLiGRWZWNuH76ORkjZiAdWKBHA3Z7MmvNXNfs8
	OS/uhEJ3O6sv9Q0o803jS5aQcZrZmKvnQRn/5bOmGhb2XoffvliQjd/iDOBNMPmbuG1VmS4AAXb
	Ct+F9aspYEDWVYEJc6CnPP4V+deH0=
X-Received: by 2002:a05:6870:41cd:b0:409:96e4:8746 with SMTP id 586e51a60fabf-4157b1ad49dmr4485025fac.51.1771862827271;
        Mon, 23 Feb 2026 08:07:07 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d3a24bdsm7655199fac.18.2026.02.23.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:07:06 -0800 (PST)
Date: Mon, 23 Feb 2026 10:07:06 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/8] t: disable maintenance where we verify object
 database structure
Message-ID: <aZx6eh9r73fGAT2k@denethor>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-2-faeb321ad13b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-2-faeb321ad13b@pks.im>

On 26/02/20 11:15AM, Patrick Steinhardt wrote:
> We have a couple of tests that explicitly verify the structure of the
> object database. Naturally, this structure is dependent on whether or
> not we run repository maintenance: if it decides to optimize the object
> database the expected structure is likely to not materialize.
> 
> Explicitly disable auto-maintenance in such tests so that we are not
> dependent on decisions made by our maintenance.

I assume that these tests previously did not trigger maintenance to
begin with so now explicitly disabling maintenance does not change the
resulting structure. Changing the default to geometric repacking may
change this though.

-Justin
