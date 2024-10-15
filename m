Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9301D61BB
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990491; cv=none; b=AR8NcNM5pNUDCPQMHrcMRBh7LN4xNeBccYX2GGvw3NaYwtuQoDGUNVjfEoOgYyPcdfKWnQgPQL9PPWU/SP/ljMnTktX4kaJZacaENvCDjjbKILcGqfb4GYGFZkdo+lo3RzsX1lVzZlgg5lIOym9Z758kGvtv68BremvpRN/ChMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990491; c=relaxed/simple;
	bh=AlOLvZzxg4WeAIrlbJgnzQx7DnhMj5pgkxd51RzDmPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPuoVz63Zi+nNXIiSVSRoVPVi7CC8p7OXCEOd5ol/1wTdYczdAh/6ttc1/DYTXlM/m8skgbD+6zsOBHG+4+4R4bAxXKTA9cnAZLXR+tz2QKKpdEfCMbucP0OkVhuJFy23Scl3sbyiF+H824Lovm/kdJhrszf9GGPUESgHfc5VuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P029OuaU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P029OuaU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99650da839so896951066b.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728990488; x=1729595288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ica/9qeER/onhhf6ngDuds9iqIqY7ud90ZcNOkdSvc=;
        b=P029OuaU7p1hP54ZoMxUTZ7hoHsjacqF2Fb0UsUg54zkSabh0IWNQH+zFmtaMAHFYa
         2k/JdWAB4IE8Fi7KDZRWll5oJ3Fr2U74fGIQ5oixTHgCBJur6W4IW120Kvnly8FBeBI0
         xI78PFRIkNv0sh4oVH+ZS3MkBeLy/0aQTYePQlhtnba3rg+zv092mPcm4I1zvAzUYuyv
         SFvfhs1MmWc+1goWcGaWTAGaGkDSE4DVNbYA2UppEUxuLsX59JjTxVVmVApCrXWmHzFW
         2ln1iPQFydj4ZHrHFA3oeloVLCfShiNOgRXsCIqM3Jqv1TenpkRCNQ5qkX+gopRRboeG
         noSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990488; x=1729595288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ica/9qeER/onhhf6ngDuds9iqIqY7ud90ZcNOkdSvc=;
        b=Xg+WSmDQ9PV4++xgY6ggnrAWtqe5kiuldXYdlNdp1ld06Zy9FmL8pjBcSk5F/DNJUE
         ZOAlAjCYeBRCaFTAFiHObPFLmZmQh73kfH64B+3h2ttPPmplBOlUnp3UP0/pfu7wUrJ+
         SfKT8RRqpgtWnWGomzFsvugVx8+LcbR6LbvQD32gJf4mmDkDbrL2ISpXujFd0M4a8Tle
         HMeSU5zHEf+fBSD06uRzb+bEWiFTKQG79ZgTAG777rq91i8OPGfALUmQ9RXIw+jeTQT6
         TjPo9bTvqrpaQbnMPhOwnvtzb4iSjeuqRMKNrASAdzfTda98zX2n/meNR0k9d2bexXmr
         AjkA==
X-Gm-Message-State: AOJu0YyGnF6cfnTwnSijBm/TjrhRVMoUzXFB1byGbqKXUaw3oEHwjnr8
	9IFZZeSS+s3LpDloawW5DpGnsbndBPrNnGZTQqk3iQYRHFKOQ8ObAYsHMsBrZKsLKgN9Fx1SyO9
	q8mBZCRWWm5eb+0Qr6mnrbb6N
X-Google-Smtp-Source: AGHT+IHtR3ElSPisYR2o/1neXhEaD6X2s4EVZpb0O2bNd2yknXz2wfjs21kpuppknC/YWIiMAibsuR8DC5VPuut2PgE=
X-Received: by 2002:a17:907:848:b0:a99:d587:6045 with SMTP id
 a640c23a62f3a-a99e3b319efmr1211270866b.19.1728990487315; Tue, 15 Oct 2024
 04:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012062126.603967-1-chizobajames21@gmail.com>
 <20241014152411.11052-1-chizobajames21@gmail.com> <Zw2T3PmdbgRGrIdF@nand.local>
In-Reply-To: <Zw2T3PmdbgRGrIdF@nand.local>
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Tue, 15 Oct 2024 12:07:55 +0100
Message-ID: <CACwP9aqecUKmN37JYW2qYRhe6nw-Owp5Cp-6Xjb1k7=_zaYmbQ@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v6] t6050: avoid pipes with upstream Git commands
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood@dunelm.org.uk, 
	ps@pks.im, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"

Hi Taylor

On Mon, 14 Oct 2024 at 22:57, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Oct 14, 2024 at 04:24:11PM +0100, chizobajames21@gmail.com wrote:
> >  test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
> > -     GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 | grep "author A U Thor" &&
> > -     GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
> > +     GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 >actual &&
> > +     test_grep "author A U Thor"  actual &&
>
> Nit: it looks like there is an extra space between the closing '"' quote
> character and the filename 'actual'.
>
Thanks for spotting this out. I will fix this up in the next patch.
> > @@ -284,8 +313,8 @@ test_expect_success 'bisect and replacements' '
> >  '
> >
> >  test_expect_success 'index-pack and replacements' '
> > -     git --no-replace-objects rev-list --objects HEAD |
> > -     git --no-replace-objects pack-objects test- &&
> > +     git --no-replace-objects rev-list --objects HEAD >actual &&
> > +     git --no-replace-objects pack-objects test- <actual &&
> >       git index-pack test-*.pack
> >  '
>
> Hmm. In other instances, actual seems like an OK name choice, but here I
> wonder if 'in' would be more appropriate, since we're feeding it as
> input to another Git command.
>
Given that it's actually (puns intended) an output from the Git command in the
preceding line, isn't a neutral name, like 'actual' a better choice than 'in'.
> Other than those couple of comments, these all look pretty reasonable to
> me.
>
> Thanks,
> Taylor
Thanks for the comments.
Chizoba
