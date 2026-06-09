Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC243F1651
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028142; cv=none; b=V6h8VP0cG5NoC5VQ8ilAmBzGVutkpeqQr5plylUIGN8BLCCFhMb6nEuYPqPda9jVx5GyJeYJSGXXm6Q+rq9XbxXYZByhGYpDRC90NSjuVMnv6UgfAuOjpLH2LS4UH2iNyW2X7aFVXshqoie/dGjrf1gtuMDUrybqe2YNvVxBq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028142; c=relaxed/simple;
	bh=cEWHDIs7VrEQWpeJGf0ZRyakdDwSVLq3lSfJfwEWC14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2atI4Pr/Xo9OZvULPq4pmHVchAP0X2smUve2kdxtKVrBrJh1W2VPa179SV04a8Nzkdgr9a+6SII4Nm5FZtDMtGzzI38VqVjOnjl41cCJKg1fUjJHFZSPQbaqH1PUke3SPIxeprdWL62K9wCP7B66gdIl5JRcf/5dSGLqy3TMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a02orCuI; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a02orCuI"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43d08bc82deso4560303fac.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781028140; x=1781632940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gPTb+Zv5bTd2W5EcJwkIvshPwh8sypkgAwK5qqZIKxI=;
        b=a02orCuIDbbXWEIKCwfFXXrQA/DBgxFeEvIaEuD65jAeWbgxqrYoXHkqdb/zIFLp9Y
         WRVhnCbBpwB0XxzMfz4aEVcMHnYejNyS/6ydiUOj3w/dXVvV8Toc0cW57HQ8OuFq/tK7
         rLYxlBm2y69UFFOxIvBzr8y9VXSeCAOyikvibza1OTNEEUQw93xSaVgsP4wGvF0XOhc3
         gR7VGggJk0YpiHm6EDenx6QgrwpjMyvEdp+mP5q/ewBqiNDrsxbRUrR29/+9rgPta/Wr
         PuE9gVSVe5i14krzLQ50Bnw3C3srZ+Z4uozsJ4bh0kbL50zhB7XyDpLf9Q4AeuAezaKo
         BlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028140; x=1781632940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPTb+Zv5bTd2W5EcJwkIvshPwh8sypkgAwK5qqZIKxI=;
        b=rBIs5pzcaepUEQzv3szWZ7/MFryZcyHwUf8qmDXB1DGSVcI8IA4tF1DNW0pDbrARUI
         SLXA4gZhFagXVDwp2q9OjFnfRTWEI8yRqmHzxZzT5hAgO4+zkWperEmSPNu2AmCv/ovR
         OxyZS9T2OxdC/O4eIVDKiSeopQf3LQWm1v0lDJc/CGUKFV5svE6/lSxXTRcwHzFhnfW/
         pxOA8rOM4TtRCDj0bSiELfQKmikDTQ52TQZf2/MGf8dutGm8gtEmaj01JqJXZ8B2Xk/U
         RrLjDGyakkMIHRk0y3DkYND2VpDlpVgpOsVub6oVQd3jHu0pnL+ek+yuNe1PbORKVKGR
         /rYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8s3xDMoOunvRR27gCJbxNqNY8aBimS6DFTr2ChufRRMMqPrZqw9qnMWGeuXae209FUEGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySCSAPIKdeQ/Zu/X8upubdEFhZXMXcyO8+nuZQNWT/MCXDB1yk
	TI5ms2opdfEaA8Hb3QCmwZM1vkLB1oIUZKEb9t5nAw0a82WbiRSvachL
X-Gm-Gg: Acq92OFGYZ2+mBHonKG20bWsGgY25dbpFXi5Ijyz7GXA7yqKZ1qvZAWTKMdPXGJpqpI
	A1JiBXeq7KvQEh2rUFdpu0H/meUrj1i/Gdc+HbkPgaM/tcBdxz1S5w+pBlFYu1c2ZE/R8oiqoAp
	sDy6sPCeaoljOZCuNI0cqqiLdYZMmqCSqoc5koMcRhdBeIUykWCL+ef8WxTdi5kpqTldvvYT4lr
	0MrdIZOKGR0d2OE07FR/TKb8JRYqoHCnb0ExIXJJHUiKBla+R/VHFDQjkc/RMkENn9t6dmBE/Zr
	yerN5+ZlOWDCNI3kH9oTjLVFvDWzKNx7eVC6TPsdtkYQjWVFRhy/nl8CoIBCc2vSIRYXDbqFI/C
	iKmyDt9KZQhwmbUw7TUrf26vJ3FcA6f9z2bpxr2qHkYLFymoHuy9zciWIJkYEcyM7kjM6FTVNZh
	wdDSk5VZsf87sBLkzbZyUvIIkcFnU=
X-Received: by 2002:a05:6871:de:b0:43d:352b:2bcc with SMTP id 586e51a60fabf-441ed4994a1mr2511134fac.2.1781028138186;
        Tue, 09 Jun 2026 11:02:18 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8448e3csm19022528fac.13.2026.06.09.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:02:17 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:02:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, cat@malon.dev, ps@pks.im, 
	kaartic.sivaraam@gmail.com, ben.knoble@gmail.com
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
Message-ID: <aihH8ye-r4QuXlRD@denethor>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
 <20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
 <54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com>
 <xmqq4ijbsn2m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ijbsn2m.fsf@gitster.g>

On 26/06/09 09:20AM, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > Hi Pablo
> >
> > On 09/06/2026 11:42, Pablo Sabater wrote:
> >>   static int commit_tree_ext(struct repository *repo,
> >> @@ -135,6 +136,13 @@ static int commit_tree_ext(struct repository *repo,
> >>   					  original_body, action, &commit_message);
> >>   		if (ret < 0)
> >>   			goto out;
> >> +
> >> +		if (flags & COMMIT_TREE_ABORT_ON_SAME_MESSAGE &&
> >> +		    !strcmp(original_body, commit_message.buf)) {
> >> +			fprintf(stderr, _("Message unchanged, aborting reword.\n"));
> >> +			ret = 1;
> >> +			goto out;
> >> +		}
> >
> > I wonder if we should check that the committer identity is unchanged as 
> > well in case anyone is using this to fix commits after committing with 
> > the wrong identity.
> >
> > Aborting when the message and committer identity are unchanged seems 
> > like a good idea.
> 
> I am not sure why it would be a good idea.  The user wanted to make
> the commit have this message, and the commit ended up having the
> same message as the user gave.  That message may have been identical
> to what the commit originally had, or it may be different.  Why is
> the former an abort-worthy event?  A simple note, I may understand,
> but aborting with an error message?

I can see a situation where a user performs:

  git history reword abcd1234

with the intention to modify a commit message, but then for some reason
changes their mind and doesn't want history to change. Maybe the wrong
commit was referenced, or they decide the current message is actually
fine. From my understanding, there isn't a great way to abort rewording
a commit during editing and thus the user would have to reset history
afterwards if they care enough to go back to the previous point.

So I do see some value in a mechanism to abort rewriting a commit
message. An unchanged commit message does seem like a reasonable signal
to essentially abort the reword. I'm not sure committer identity should
be taken into consideration though since it would inhibit a users
ability to abort the reword if they ever touch a commit that they
themselves are not the previous committer. 

I don't think there is a need to have an error message though. Even in
the case where the user leaves the commit message unchanged and history
is left untouched, git-history(1) would be following exactly what the
user instructed it to do. I don't really see why the user should care
whether history was actually modified or not in such a scenario.

-Justin
