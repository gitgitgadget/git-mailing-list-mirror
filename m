Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA8195390
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712672; cv=none; b=m6xv+20IpkSyCwwkPzRbtuDgyVtCp4l/cW50R1JsLUUM9/9AKjWhIYq7jZ/2GZYbg9S7tLkJH4LANSJ5ilA5twp/EpRL/zDfiBu5LefCjsu54o+MM1Du/m2WPRjzFgOO3Goxqetz+xfEDl065PSv/WPI8AtB7zu16Ganmxkmp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712672; c=relaxed/simple;
	bh=XsZVq7mliTy2l/nqVYoKEWsrmzvo43pF+HmXVrq07VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH82IwsGHjc01lQnV1pydAeCayybLm1bayqg52TWF5eukUQcTGljdYBeHdMRmdW8khKJcgocaWRfRiThSAxulUIV1bHh9l1L/+KaV7MZ+LrQdnEFkcP+XS3DCxqAyEc6EES6aaAHmVP/6Lcv5gsV2hos5nsOzoXVbQEPSrgOazY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vDRJz4AO; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vDRJz4AO"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e21b4d7236so38104457b3.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727712668; x=1728317468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsZVq7mliTy2l/nqVYoKEWsrmzvo43pF+HmXVrq07VM=;
        b=vDRJz4AO83eYhuu58MiCePe8aXcY2nsfz9BJrB1+7Id/vGCg1skkmkmYJvaiW3qbLS
         +N+y2qiBPejLUQNipg+cU9PDxyW/HG4cr+MLfUfrIuj+aPaP8pyVBrG7+l7XyJO164mB
         +hHAf1oldOdmU+Euf7vQibQ15z59ZW003lOEajAVfmhCLsAw61GNwCJntk+n8m9+N5EC
         exLOy4AWTfsk0kRARLPDTtJvC94JplLFej58zpZgyYeOSefO2U5pXEgK8Clq3EH4cDfr
         GJFIi4uhNeHO+E1VadpdM9SaCpA03yTe26EUT6rnResUAzzDjFWUY8AIbt4Meib5skU4
         4MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727712668; x=1728317468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsZVq7mliTy2l/nqVYoKEWsrmzvo43pF+HmXVrq07VM=;
        b=eMDwE/aKuFZURo85kuM/a1NpRT6HkbDQap8fKTs1vZLDInmf1PXry/y+R2XjI3vuIL
         XrwT/5CBTR36Lfxr97/SAu3kmC98xQEYHF3LuX1DhvPitYAczoSATFs4cyZUVqm8THo1
         0vOLXdlSyB7yRG56HWE+Iuxv1I9lT63bnxUgFSTJRWJg+w5JDJ+3/tfQT63Qg2hJlVed
         oWCiFFz8EuyUohrBquEXXnin0pJHXVowz4VSZ26Lb/va8oD+TjoVdTZfDPv3S1bjEiwW
         JKmsSEQ0ZIGzaDljaiDHxQPuUScCQp5+QF3YnKzj9d8VGgXZv8uiGzvx+0tE0+RTzLJE
         cI8w==
X-Gm-Message-State: AOJu0Yy8rag+WFDPLLdbEFM7q45f8SX0QBBHq99zBG8CdKIW8qxSABjh
	tjg26J58tzfTA96n7p6BxdyL1vr5PFwjHWgJmJObBOhNH0NReH5dZUXR/1CFOUpkC7dZyAeY9Ay
	ss1c=
X-Google-Smtp-Source: AGHT+IFzS2EbNi6tsZINcAL6FFDYOx3DJVUi+LswLr2HtzYjhxX5Lwb0lNXmvdeo+k0h38YyyNJEgA==
X-Received: by 2002:a05:690c:6187:b0:6db:e526:cf55 with SMTP id 00721157ae682-6e2475e309amr120169447b3.43.1727712668255;
        Mon, 30 Sep 2024 09:11:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f9b39sm14226117b3.25.2024.09.30.09.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:11:07 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:11:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: git-scm.com is now a static website
Message-ID: <ZvrNmsycmamx2dcR@nand.local>
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
 <ZvM65LqtFW8f9uqC@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvM65LqtFW8f9uqC@nand.local>

On Tue, Sep 24, 2024 at 06:19:16PM -0400, Taylor Blau wrote:
> I haven't yet spun down the dynos on Heroku, on the off-chance that we
> need to quickly get back to the non-static version of the site. But the
> rollout has gone so smoothly that I doubt doing so will be necessary. In
> a couple of days I'll go ahead and spin them down, assuming nothing has
> changed.

I had a reminder in my personal calendar today to shut down our Heroku
account, which is now mostly done.

I de-provisioned all of our add-ons (which were the Heroku Scheduler,
Postgres, and Bonsai instances), and then deleted the app.

The only thing that is left is to actually delete the account itself,
which can't be done until our last invoice is cleared, which should
happen on sometime later today. Our final invoice is $61.86 USD. Once
that is cleared, I'll delete the account entirely.

(As an aside, this is a significant cost-savings for the project. Our
usual invoices are around $65 USD/mo, but that is taking into account
the OSS credits[1] that Heroku provides us, which are worth $40 USD/mo.
So the real cost-savings is somewhere around $1,200 USD/yr, which is
awesome.)

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZZ7zezSRZfdklS4u@nand.local/
