Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDF116EC19
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736811233; cv=none; b=Evf5c3HTfN6i7ZwJ9CRPj9na/HYvFkQfovKnzrPWcmOPrk9EHAponbRp4DbyN67PATLBZra3qEJATU4Ho9XTSIijrXxT8kaei7ZPcNezUlN8+lD4weHmivJBQTAs3A77dTOwQXPbu8Jz1hR3PgJqhIZ+DajIm6iIHiffzeqla6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736811233; c=relaxed/simple;
	bh=lKf47v0yJ6Gmnr6gDkoKxrvVdL2q/RyUTILdA4xgDDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgkLuTr3gJ6HwhMTi5YOzPFjXRhDbjbtppM0swhU+O9cGo0AnyGhjyAuX3oDb7h+1/6oUCrlquezDiEcqCJ/R2nXykcN/sC2VUtZ7lufsYU+XpH5ymJmeyFwKxCIYTixonJRuXzPvsmOVnaET0epBoLPsXyUy6rq67WZz61Olbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mCcxVL/Z; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mCcxVL/Z"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e39f43344c5so7092635276.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 15:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736811230; x=1737416030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80R5EqPwRSeASM8Y3Ic7VsiYBHXRVrDv/4bPrWOIkqE=;
        b=mCcxVL/ZY/V39za1WUCXGT1e/QEJU4b82NGf2o58Jvn04F17AdXn8Ud7ZxzIB3b671
         buEzbkhY8ESZHtz2M3ZN4GzHTYddkkKw2dyT1ltHqy83LwATxDPu4gaZoIpZgT++NUAn
         unu44rWTVfyFl6uN2l0kulK+XlHJxQ6xvx0/s1HttpiyrNmjljeoM8PFRQJTr8xxHjpN
         6N2VQxiSMgbLy0WnpS6voEqxScDhoedyuz4kPvZetwQruLgg1COhI9FvqyrZvjcVWmH6
         Qh/V7rHjKYsG5gjDE171VZxMuyov2uE4Z+kAH0M3ROZT/eMqYtK4FW7sPZ1iDZWLhYTk
         syRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736811230; x=1737416030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80R5EqPwRSeASM8Y3Ic7VsiYBHXRVrDv/4bPrWOIkqE=;
        b=Vrhp2A+cpLeOyRi5yaRA7EviQiOfWDurUXHuRMa1Fm8+JrrcXJsDf04znNXM9JTJCD
         /IhrzekYLJXIOMXt2NEq4oW8i3BDPpwlOsgS7b3VzyLiBlvg2PP4d1rEVdPBvWmzBCHC
         mT3SUCZOjUw8D8w9Dt0V03P+fxnJd9MZoLh2lH6H5LrmgLVN3SISVyficnNJfczi2m6w
         w8DZs+rrRJeFh7x2fISuBnPntCO1iwykabM0HpTjICNeJqfKKS/XLmoAfK2EH/ceHHoT
         HJ0ujy7zDqedoJT1iiztkcTAJ8FpbW43xOGQtpqL26fJ6cEeR2cC9GEEpOkvlngkshE/
         /mKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyidMskFYyxPeAQmTh78sod0FiW8wp31FWiXjy3xOTRjDIoSN+e9NANyAP6N6zgd82TcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZoLklTo/vYBNuYtyIyBb6RjxP/vNfxXPlsPt8zo7XzmN1iKp
	yA7OKvCa8ywRBCd2MhTCa8UffsxUu5m2361bjjm9zEY3YLlipX+wk8+/1FCVuZaux+ELRTDiwec
	Yi0E=
X-Gm-Gg: ASbGncuvfGxjFT6hbbxCmwxIiMfcGmcaclIkMCfcaHUEyRMaHTJW9GSdD3SyA4qj2t5
	Z3aam417U1rqwaGhfYlcMVdXZqcv5g00/yf8cdydbkve0hZXU8J+JucnOnHYqkXt2Ajghp+32No
	v4Cag81oVh8PchqfalTFaMEL8MvMThp+ePCVFLdm8qjHSxWnXAGTmZ+M4ElUEOzENV1LMuw0nPr
	/dVp2LYXFROu/e6f6DUtCOyTfuCze4QABgrTtoGZCISX10vPkXv3avkNiwoYsgomnUj1Q8e9mEs
	9BAfyx+8GQINPs6/5Ccl2OLBJu7m
X-Google-Smtp-Source: AGHT+IFRPz4sFPeLUuxuyri4TDbGlimHbKQIrY7GjwyDWikY9t3ju1sVWx/aGJhMlHioDjnkk8G1sw==
X-Received: by 2002:a25:2084:0:b0:e46:9ab4:51aa with SMTP id 3f1490d57ef6-e54ee2368d6mr10218088276.43.1736811230509;
        Mon, 13 Jan 2025 15:33:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e55a595e01dsm1660508276.22.2025.01.13.15.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 15:33:50 -0800 (PST)
Date: Mon, 13 Jan 2025 18:33:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH] help: interpret help.autocorrect=1 as "immediate" rather
 than 0.1s
Message-ID: <Z4Wi3K8Hd41VWWmG@nand.local>
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
 <7553dc2b-7b91-31c9-e86e-aa24d3bb4235@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7553dc2b-7b91-31c9-e86e-aa24d3bb4235@gmx.de>

On Thu, Jan 09, 2025 at 01:18:15AM +0100, Johannes Schindelin wrote:
> For the record, I do think it was a mistake to treat number values as
> "deciseconds" here, it is inconsistent with pretty much any other config
> setting. But I also don't see any way to remediate this design mistake at
> this stage.

I almost made this same mistake when working on pseudo-merge bitmaps, in
particular with the non-integral configuration options like:

  - bitampPseudoMerge.<name>.decay
  - bitampPseudoMerge.<name>.sampleRate

If memory serves, I think this mostly had to do with the lack of a
double parser in the config system. I ended up adding one in 5831f8ac41
(config: introduce `git_config_double()`, 2024-05-23), and made those
configuration options take values like '0.1', etc.

I think it may be worth considering what "starting from scratch" would
look like, as Junio suggested above. To be clear, I think that that
should happen outside of the current patch and not hold it up, as what
Scott is proposing is a strict improvement.

But it may be worth thinking about what a different interface might look
like. If we settle on something we like, perhaps we could start nudging
users towards it and "deprecate" the existing syntax.

> Thank you for working on this and making the feature at least a little bit
> more usable.

I concur.

Thanks,
Taylor
