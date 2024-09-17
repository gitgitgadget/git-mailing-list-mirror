Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C26D13C836
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567900; cv=none; b=NqQuEg/OWb4wtrWcqXgIVxCyzjsvSfpRMfKsFxao4zc8Ro3wf4V9m4fjWh3ynT0nxqby63kbqLCtuYM9hI/oYGmKV7lZW+WcLX2HanN8J2/W2C+gpT5cCBC/7Pck6syI+B2nus8LlQ5kUmsItRPoacX2EciTppgm9IRkexbh/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567900; c=relaxed/simple;
	bh=o1TlbwELwyOEmRPQz6kZGk0YvcBfBrFipkmzYtMwoDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ+HktQcNXTFp34ajpA5LRhwicgfL36KyFXhp5lImVvFOaV/SIzb3nw0cksDGG6uukwFuSGRylIN1ejm3TjahNfjHn/Ki5l+jkbbT/6L9d7r3ldk6zm150dQGY9GkcVUuapkoFnN+3/62H5T1iJSMQN6vOuAkozcCbf5mpT0AW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pIsv/8Jv; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pIsv/8Jv"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cd93a6617so175399339f.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726567898; x=1727172698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JcgwiuIl35+U/5mAqDw+P458cFPgagzGBjuPcQW0FCA=;
        b=pIsv/8JvLlTGyoonVx4konJ282Thr+IprlR1B6HtYarb5m5Nr/qLSC83ri6GnrKX8X
         1qhaU+PxFhB8be28tWSaGIc8BEIZoSEPjUefJm57hPUFpZiz5IIMb/bIlQqKuDgpK8OQ
         SXf5r/LjYgKkO3fA4qmfAr2qu5Blv6bDUm576FLa4DawNOcDszshM1tTB+PNMBSoyyiA
         FpVgjywp1jIKpJFmFukUVcdv1wBBMdYyyllinkQOWrwEFgfYgm0/P3zAshE/HcZ7y3L6
         WQf6Ndq692FaaSsFAo/vToWafYCqJCKEHwz1VJBpPrGQPl1SsY9Wkf0zNstR/s1+5p6W
         HoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726567898; x=1727172698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcgwiuIl35+U/5mAqDw+P458cFPgagzGBjuPcQW0FCA=;
        b=bYs4O/6kuBrkbP9Kd+Jc8h5yyrMGR7hkaVt9qJGdXJ7teSInYJJeQBJbz/D+BExMJY
         WKrxIOTgvej+wRAn/+0Jw7xQvFAL1d8xMRzyrSMT5H2G2qbS9kYQ/PTEncuXq7PcpRsz
         aHLpco2pJaizD81MRD4MZYsPYPdIIVRbY/5RL7vbDU8XKCpHwxXU9qaybvH3TBagtwcJ
         ThgbCqaYnm0rA3Qd8ruNQwwxOHg7PA70GSCCqBdLdp/Hr7ZrtqrmSTYx+6PGQRV+MD1G
         zoaGaHmIifqx1B3vMkOXhBLcuD+aUsX/ACEC0wAS51a4/qFMdJz98Qx2PJcZmKqVbpJa
         Z7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUEqbghiifl+f376yDzXP7UXy95ZbimBPa2P+d+dDz4++YkzwHZwx4mj7mQj/oW2yjAgYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHovQ86dzawvt0JBjagl5d4dNqOcac9rOcFAJNKhnQY8cgGrRd
	gj1NntSZHkrhnUDbYCjsDTZT2VWMLXXMSIluDjPCp6cnRNW+yOdx+aCNZys0/3Q=
X-Google-Smtp-Source: AGHT+IHZQI+ouMW/XPpkw4nR1pzCqqV1Bx7weaAZRIdMgYCKTTnSjN4AtsHd9IBERj+WTdUnzCt4TA==
X-Received: by 2002:a05:6602:2ccc:b0:82d:8a8:b9e with SMTP id ca18e2360f4ac-82d1f8a8e04mr2005648639f.3.1726567898048;
        Tue, 17 Sep 2024 03:11:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec1f268sm1882339173.70.2024.09.17.03.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 03:11:37 -0700 (PDT)
Date: Tue, 17 Sep 2024 06:11:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 03/10] packfile: fix off-by-one in content_limit
 comparison
Message-ID: <ZulV1nSKdvf5MtpA@nand.local>
References: <20240823224630.1180772-1-e@80x24.org>
 <20240823224630.1180772-4-e@80x24.org>
 <xmqq1q2bmdfy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q2bmdfy.fsf@gitster.g>

On Mon, Aug 26, 2024 at 09:55:13AM -0700, Junio C Hamano wrote:
> Eric Wong <e@80x24.org> writes:
>
> > object-file.c::loose_object_info() accepts objects matching
> > content_limit exactly, so it follows packfile handling allows
> > slurping objects which match loose object handling and slurp
> > objects with size matching the content_limit exactly.
> >
> > This change is merely for consistency with the majority of
> > existing code and there is no user visible change in nearly all
> > cases.  The only exception being the corner case when the object
> > size matches content_limit exactly where users will see a
> > speedup from avoiding an extra lookup.
> >
> > Signed-off-by: Eric Wong <e@80x24.org>
> > ---
>
> I would have preferred to see this (and also "is oi->content_limit
> zero?" check I mentioned earlier) as part of the previous step,
> which added this comparison that is not consistent with the majority
> of existing code.  It's not like importing from an external project
> we communicate with only occasionally, in which case we may want to
> import "pristine" source and fix it up separetly in order to make it
> easier to re-import updated material.

Same here. I don't think there is any reason to split this change out
into a separate patch, but I do not feel strongly about it either way.

Thanks,
Taylor
