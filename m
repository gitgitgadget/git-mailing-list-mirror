Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C312CD8B
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696179; cv=none; b=Vkpj0DPl8osGk8r0jU1m/rjgMHAY3uPxFQIrNtGXbkEMMGxVvfDFNflbilPQZO0iMikG5C8jgG96msaMiIeqHzeAPt6bafSWKjTg2sBk91rMiCZ6V6ZI1mmiBT3hvDLCfid5prRk/0LeiIWSDe+LJrWCDqUd0IHsbk4L10P9FWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696179; c=relaxed/simple;
	bh=SK5JmgZkJxmdMkN1cJ0x73QVtxJ+7oIlDkKWT9MK3sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIj4EJWhiSz0CgG+mTrWf3EHY+X+2TXpYvlqVw9vKYUijsu8OXUO6AM710OkIYmf6lYeAqAVLBYh74b7SiMhubCDw5CV/vcISB7fVbVyTuQPmBCrO/nRXFhiWg2hL8tszTEpnZZQA78pf9QZFViPZepnqoYui2UJ2VBy/DBPIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Mz60ko+X; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Mz60ko+X"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so6331738276.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729696176; x=1730300976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLEbGTXIa+R05MOv3ubfq02mRQKDRj6gbHeVcN1H1sE=;
        b=Mz60ko+XLLbNbLLiBd8yrsRauoWp3YMP6NBUHIomSHdt5VW4GxZk4nw2RgXeTDZK8h
         /uXrPRu42NK750C2D8bCNRQjzydF5awvm+Ur32pMB3eSCof7IDKb/n4mx+fXebL8hD2n
         DTnzrjT08GAoPdrpOHLWeBcc4At1G/aYLAMf5G1JP0CJKCTQ6y1XV4fvgaBtEN9J35ke
         ZDX31/5sWgvdywxdlmz3HuRIrdTrCTDr5dgcLos6SpS/NX8YBh5LImz4E+bT9I+8awxe
         lX7YuzgQ9dkCdTUa57O+mqymfU/gV2pvrBfRntDcq5m95oFx/NsnpXzhpSIlSe+13mi0
         j+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729696176; x=1730300976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLEbGTXIa+R05MOv3ubfq02mRQKDRj6gbHeVcN1H1sE=;
        b=j80ZO/Mfj7sm2i3N4Du85W5ULbuT384r1j3YPyQCv6wwxa4NbcJ6ouVSddfm4D5QOp
         Yvy0RBr8NFP3B8p7uyooD2PpE4XD7atr9PSNzSkN3thB37sHPgKm9mhXdvjj/JpcL687
         ivKPr2u0OFSY3a9uHNaz4z4H85f3sSNwlTYj0DDBxCsf3oDe9Yp9vLtBechTxZvGDl4t
         ECg/n2TCdOr7I5mYQMR/6q1z+olpvfT+qMbxauzj8BCmKCCqOguoIed5qxaX6elTy01g
         9mDA71bUqw9MklPF0CYPcZIKaJtcvHvjXWEyuBwCp7DlOQVABfMih5fZQ07YcFq5Tq2S
         Eq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeyHfDXXF4r87KMx5CY0m267vcdEtUpCOOUD/yiVlrAVHqZ653fKE7iCFgvHUtTPxEHdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtz8QmMpxiGjdD2d2FVWJOZI6m0ybwP5Zpg7lX3kA6vqNqp0M
	YjlIf9A0AOcUeVsLNhs0jWZKBEjiKsl6NeU+Mk1I6muKf+v4cD2Ng6JgF6aNfw+v/+0Exfn+VdL
	pT2s=
X-Google-Smtp-Source: AGHT+IFBYodB7UKYjhYWVpsKd3HRLVISo0PVq5eaYExXuwplFqYrjPvsHSGcFpW8/GQdKJEQ/7gaGQ==
X-Received: by 2002:a05:6902:d43:b0:e29:f0e:e7c6 with SMTP id 3f1490d57ef6-e2e3a6e5351mr3330297276.53.1729696173536;
        Wed, 23 Oct 2024 08:09:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2e33151354sm582005276.8.2024.10.23.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:09:32 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:09:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 1/8] t/t5505-remote: set default branch to main
Message-ID: <ZxkRq3GNbrO1cqw3@nand.local>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241022194710.3743691-2-bence@ferdinandy.com>
 <79c9cd6d-7bcc-4014-91c0-149505f70136@app.fastmail.com>
 <D52LZ1W0FH29.1GVLRMGN80HPB@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D52LZ1W0FH29.1GVLRMGN80HPB@ferdinandy.com>

On Tue, Oct 22, 2024 at 10:14:12PM +0200, Bence Ferdinandy wrote:
>
> On Tue Oct 22, 2024 at 21:53, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com> wrote:
> > On Tue, Oct 22, 2024, at 21:45, Bence Ferdinandy wrote:
> >> Consider the bare repository called "mirror" in the test.  Running `git
> >> remote add --mirror -f origin ../one` will not change HEAD, consequently
> >> if init.defaultBranch is not the same as what HEAD in the remote
> >> ("one"), HEAD in "mirror" will be pointing to a non-existent reference.
> >> Hence if "mirror" is used as a remote by yet another repository,
> >> ls-remote will not show HEAD. On the other hand, if init.defaultBranch
> >> happens to match HEAD in "one", then ls-remote will show HEAD.
> >>
> >> Since the CI globally exports GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main,
> >> there's a drift between how the test repositories are set up in the CI
> >> and during local testing. This issue does not manifest currently, as the
> >> test does not do any remote HEAD manipulation where this would come up,
> >> but should such things be added, a locally passing test would break the
> >> CI vice-versa.
> >>
> >> Set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main in the test to be
> >> consistent with the CI.
> >> ---
> >>
> >> Notes:
> >>     v9: - new patch
> >>         - a bandaid for the CI issue noticed by Taylor (cf:
> >>           https://lore.kernel.org/git/Zw8IKyPkG0Hr6%2F5t@nand.local/),
> >> but
> >>           see
> >>
> >> https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/
> >> for the root cause in detail
> >
> > Why no signoff?
>
> Because I always forget :( I've been thinking on making it by default, but
> I didn't want to add it to all the work related commits, where I'd be the only
> one doing it, but I just found the format.signoff setting, so I should be
> covered for future patches.
>
> I'll wait some time before sending a fix for this :)

Yeah, I was going to suggest format.signOff as well. If you don't want
to add your S-o-b to work commits but do want to add it to patches you
send to the Git list, you could just stop there (assuming that you don't
use format-patch for work-related patches).

Alternatively, you could set it in your copy of git.git's own
configuration in $GIT_DIR/config, so that it doesn't apply to work you
do outside of that repository.

Either way, I'm going to avoid queueing this round since it is missing
the required Signed-off-by line.

Thanks,
Taylor
