Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACFB2FD7D3
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895806; cv=none; b=VExFEfwamcwe+PqgfYOEX8SZNeTECBXgBFrLWrKMw21vL+YULNG+M7X7JNBbqCVlhjE3zhentoa/QXVXiCGNBJYK+lO/SwJDh2U4kdxhLpMZWDaNyGOKcVur8azuJqUArxrlcNkw71eDFFCdlBw3DodUObdvsOf5d4N3RQ3IXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895806; c=relaxed/simple;
	bh=S1Fc+WAN1CfOt+3P6wlujbpqMavNkSHnn1wkxG8yf+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtDKQTRqS9+xZKgC/GnTc1GLC87xVfHPlbnwy6yAteJRqNH3mlAWV4uTw0vdUgqJiVP2wcGBlB/DDO9i7O3KDPJ0pyuMBrjN7nnBFJVtfuKdx0ShHq9SkzB9ZLO2N4r/pV1LmWlcHcKBaQot6pnF+erxgsTUn7po3iWwc/YB6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3IX7deq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3IX7deq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so742113a91.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774895804; x=1775500604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1M2ZSwZKnoK2WtgxMKs52Dupo+adwDO46VeW3fToBQ=;
        b=J3IX7deqE9AC3oBDZc6PkFvqeJQK9x3BllBnc+NcgpVpgJ0gDCuTWEXOF0bChY4jkz
         wThrKsj2ywum+f3bdBznw1K2x1/mcX9wzeAOYy7rL6ae310czo1Hxnfq1eJv3sp/Afav
         A/B54vjSPEquOMLWudR5jup3NiwKbbNTrzV/Xp+oywV2A8JCSOGEypyk1xLz9vRCEnOK
         NiPAwE6ux9dn6OsGaGB/nZXq/B768cQaHIHd3WaUFlzpBRoKYpTpfIAjqzJqNpp2zChS
         sqA1w4/RMH9JKA5cXAdsS9sjBP/Vv9AGivbu2B7rKPMDbnYoG9Yu5VGpO+0fwzV2QScS
         V/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774895804; x=1775500604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1M2ZSwZKnoK2WtgxMKs52Dupo+adwDO46VeW3fToBQ=;
        b=bVTcVgiDIXDTco8z4EJR8ZPH1AhJxrK4oo3nTEA+nBxC5Fp4gewBGdd4x+dCAm6o8K
         n82uWgDvxZ7x6Qjwmd4U8AWUDRKacOgjLirV9quMvLmiv31SYAQ6rcmDfhJMst+Ts2Uu
         guSBMq88qS11c46+QGAMSQ1nKJkSFVJdT3bVx5h7kAQhk5qduj/D+TCCRSkUTtCi+s4q
         NtM4fm2awIx5C9IrTr9bnq7qlTOpNFU8wBc7AT0HvK07PVObEKSW8Yklyz0bYDs3Cd4h
         4CuEu1CGSLlRH8dJfIjzZb6B/juHlgq/L9+7UOl82x+91YPrMSIoQLPyIBfpRG/7y6+v
         cVxw==
X-Gm-Message-State: AOJu0YxiJ48e/RWVr15MIqYTrP8jcy7K4ZGDsGPpC/teHHNaK/pnWYH8
	WtTWlFCxlxJRMd0BTDgeAd8osd6BMLAVb3FDQRP2h4Sxlo26rwKBC8fqmUP1FmH/HtA=
X-Gm-Gg: ATEYQzx8/hmBcgB7Y7dC47j1iXhaiWAmg1ZhSXki2XC6BHPKeYjr4aHKCp+XJNL+HBg
	5nOxuZqdlIpwboMIuo0X93o5kB1pgSAT0lq++tQxnjXU7/bb3rjRo7a70GnDYwoSABxzmjoDFhg
	38myBLtQ+u/NjCH35zHZqk3AJ7996/R3s7eGx5gxeZ8YVJb8xps5ZPIUMUBQigfepCRQIFRxyvd
	DEnXvbivBhUV8kY4E0SJADjGCTSEJ4Q5+Bl+oi4xe7FQjEbCHu8PD1vyJcCUwDkcyAQlRNHEfWx
	vJHESk+tqewk6HkzYO5ISEwbmr05VZrAfaUi/RxJKiVumF7HkhJub3HAxOHD8uFWOWjUu36pjV0
	+RAZL/68jfE35FhRDF24hTJ+lec2vVebp/TIePuxNft+oPSe3onZVzs6rNwx+WtbCB4bvshS70U
	c+8BxPBAOAT5jw5B0vzxl9Lu+x057HELg=
X-Received: by 2002:a17:90a:f94e:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-35c30052dffmr12893529a91.16.1774895804421;
        Mon, 30 Mar 2026 11:36:44 -0700 (PDT)
Received: from localhost ([42.114.23.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22ba5700sm13635451a91.8.2026.03.30.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:36:44 -0700 (PDT)
Date: Tue, 31 Mar 2026 01:36:39 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] backfill: error out when HEAD cannot be parsed
Message-ID: <idaildqkkf26ks6hlibt5e7rhdlbytra3x3o7ovd543mnsthtm@h3um5miwhc4l>
References: <20260329183603.538241-1-vikingtc4@gmail.com>
 <0af26f29-5643-4ff2-b659-ae0fa234161a@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af26f29-5643-4ff2-b659-ae0fa234161a@malon.dev>

On Tue, Mar 31, 2026 at 01:41:56AM +0800, Tian Yuchen wrote:
> On 3/30/26 02:36, Trieu Huynh wrote:
> > handle_revision_arg() returns non-zero on failure, but do_backfill()
> > ignored the return value. On an empty repo with no commits, HEAD is
> > unborn and handle_revision_arg() fails, but backfill silently
> > continues with an empty revision walk and exits zero, looks like
> > success but did nothing.
> > 
> > Check the return value and propagate the error, consistent with
> > how builtin/pack-objects.c handles handle_revision_arg() failures.
> > 
> > Add a test to verify that backfill on an empty repository fails
> > with a clear error message.
> > 
> 
> Aside from the minor flaws Karthik mentioned, I think this commit message is
> spot on.
> 
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >   builtin/backfill.c  | 3 ++-
> >   t/t5620-backfill.sh | 6 ++++++
> >   2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/builtin/backfill.c b/builtin/backfill.c
> > index 27a301f9b2..4b2db94173 100644
> > --- a/builtin/backfill.c
> > +++ b/builtin/backfill.c
> > @@ -96,7 +96,8 @@ static int do_backfill(struct backfill_context *ctx)
> >   	}
> >   	repo_init_revisions(ctx->repo, &revs, "");
> > -	handle_revision_arg("HEAD", &revs, 0, 0);
> > +	if (handle_revision_arg("HEAD", &revs, 0, 0))
> > +		return error(_("unable to parse HEAD revision"));
> 
> Looks good to me.
> 
> >   	info.blobs = 1;
> >   	info.tags = info.commits = info.trees = 0;
> > diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> > index ff67e8ecea..91b5115732 100755
> > --- a/t/t5620-backfill.sh
> > +++ b/t/t5620-backfill.sh
> > @@ -101,6 +101,12 @@ test_expect_success 'backfill no flag on non-TTY is silent' '
> >   	test_grep ! "Downloading batches" err
> >   '
> > +test_expect_success 'backfill on empty repo fails gracefully' '
> > +	git init empty-repo &&
> > +	test_must_fail git -C empty-repo backfill 2>err &&
> > +	grep "unable to parse HEAD" err
> 
> Remember your last patch? Wouldn't it be better to use 'test_grep' here?
> It's easy to see that the original code uses 'test_grep' (a few lines
> above):
> 
> 	>   	test_grep ! "Downloading batches" err
> 
> Wouldn't it be better to maintain consistency? ;)
thanks for the spot.
> 
> > +'
> > +
> >   test_expect_success 'backfill --sparse without sparse-checkout fails' '
> >   	git init not-sparse &&
> >   	test_must_fail git -C not-sparse backfill --sparse 2>err &&
> 
> Regards,
> 
> Yuchen
> 
acked, will submit v2, shortly.
