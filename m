Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104014A4CC
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785171; cv=none; b=E6B8q32uddNK0mpgm/cOf0pv69PiHJIXyroPCBY/wHao01SXyorltGLinwmddJmeDXZmbALKpAZMzD2GehCW8T79600mnzUHXKlu4b9ESkKOOiOgL+5VjJbhuNCsz9EYGGXOF7gjz/fKloLjZgj7ccivpCr05TyMGkewnQ9CYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785171; c=relaxed/simple;
	bh=WfDkaPLqztVare56k25fbnV1bzPbFD52uLmcDtVK2XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlYtyuzZ5HFpxDNSnggCJ70P2urgAE/+yOIih51ybbDTDLDYajKyJ8lTU88J1I+rjw4HDoDOKLOQbNB6M2CgX5/0Ymi9D4jgaam++B0XOOo+o3qrnBs0eIXwQktQGPxAW30jCS2J3BVXipOZ6KwW+yvs2BffVbL59gMV0pitzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HR0Ry4SG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HR0Ry4SG"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e3a97a6010so12996477b3.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729785168; x=1730389968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfDkaPLqztVare56k25fbnV1bzPbFD52uLmcDtVK2XM=;
        b=HR0Ry4SGlEyOdabTfV3h5TymaCWFDYWsHZJXksoZ/uSONiGIv37QkhF7kG1bJHHevW
         2d/vakaydNfl7rVQ/chYkItVye3FZeCApQPXvOHOKJCGctf/phz3/dOvg7hYmIHYlAHd
         6ncrxflAtkYRclZg60kRX3oyUMjg4oKE7v+0qd7Co+uh/9tZhqdbrTo9U+SNC2eAv67E
         q0wmCWQoqvYqT1vzbqIF6rd3Pyg9IdjxB5ODuO5YBExcoiGEwrGirTFB06jHZclIzVpc
         h19kYxNEchLeQa/0nSynrI3Skve4krAb43rQ5kvOqJxTv4rg1nSOBl8+yTtO7/BeQ7ib
         U4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729785168; x=1730389968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfDkaPLqztVare56k25fbnV1bzPbFD52uLmcDtVK2XM=;
        b=cXGsBRCRDCPncjUGdvYnMOhUBLpA+2sGfvmEU8a0JSMjpGllqjEGQM3m+kG7CWTs4A
         j64TW9IHaBWi738KAXHyXynaqqd/VlbsjA87grlVgtkO6nTrS0Y3zPa5BXo2yMN2PKtr
         PfgiyIIuPh5PPQwbiJRaUXvbq4I9SbJC72tguanILDkkSjmYGbajMLWuAMGeZoIUf89j
         ZLTeUUazdzgt1WN8Sxjecmv16P6UU5H4dyBSqdju22ajsuSSLgYoHjY0BySFEnlvrKzs
         oKjlyBRgeSn87tBdVQXEe05799bdRb2bfj14qro1jrZ3S+qdCNM1MD5lEvsQK7AsTn32
         ndkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Y8L2aY7iksfNoF7iX/hiHVsdnxuxNgyB4YOXB5pUtD5wJE1A48D1+wIzc7Kp9a0VTXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNScG31U0+JG3NAcNdV1g1rtzkhvpRx88J3KljS4YglEeWQxv
	2XNCzjd97tm8tv0FlhLHZLz9zoBT86tn4cxqbmTgzSC+lm5bGx7R3SxX+bt1ZTc=
X-Google-Smtp-Source: AGHT+IHRfpVCfDnEA4aL+TVjiN/0vnBTLuZq7W82V0xeZELY+8BN9ubZlfs9ZVZpkywCmxa7lhHY7A==
X-Received: by 2002:a05:690c:6b09:b0:6e3:31ee:23ab with SMTP id 00721157ae682-6e8581aed96mr30142947b3.25.1729785168604;
        Thu, 24 Oct 2024 08:52:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d6f9dbsm20078547b3.141.2024.10.24.08.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:52:48 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:52:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
Message-ID: <ZxptTxbVZt96e8ZQ@nand.local>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local>
 <dd18a858-31bf-497d-bb19-d371102dfa2a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd18a858-31bf-497d-bb19-d371102dfa2a@gmail.com>

On Thu, Oct 24, 2024 at 09:29:02AM -0400, Derrick Stolee wrote:
> > I know that this topic was split out of a larger one. It may be worth
> > seeing if there is a way to split this topic out into multiple series
> > that are more easily review-able, but still sensible on their own.
>
> I'll see what I can do. I needed to re-roll after discovering an issue
> when trying to integrate the algorithm with shallow clones. The solution
> ends up simplifying the code, which is nice.

It's always nice when that happens :-).

Should we avoid reviewing the current round in anticipation of a
somewhat restructured series, or would you like us to review the current
round as well?

> > I haven't looked in enough depth to know myself whether such a cut
> > exists, but it is worth thinking about if you haven't done so already.
>
> In the current series, there's a natural cut between patches 1-4
> and the rest, if we want to put the API in without a non-test consumer.
>
> I could also split out the 'git repack' changes into a third series.
>
> Finally, the threading implementation could be done separately, but I
> think it's not complicated enough to leave out from the first version
> of the --path-walk option in 'git pack-objects'.

I'd suggest erring on the side of more smaller series rather than a
single large one. If you feel like there are cut points where we can
review them in isolation and still see some benefit, or at least
clearly how they each fit into the larger puzzle, I think that is worth
doing.

But I trust your judgement here, so if you think that the series is best
reviewed as a whole, then that's fine too. Just my $.02 :-).

Thanks,
Taylor
