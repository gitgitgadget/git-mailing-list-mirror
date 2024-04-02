Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57417582
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083533; cv=none; b=NwQVWrHEkVXb0uyGyO2V9qoyhCyBneKPG4i9/1mNNzpsZUOE6wZvzLoRxLKUIVCzCnz7BYg4tWQipjh5jo5UJl5z8S9nYHfiFoGXQKXa0mSOEK4hBTZARVaZKTwldkF7q+fR+bcIVZ0AxR2+j9omRQzoQqiZFqa4d8JcAAsv4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083533; c=relaxed/simple;
	bh=JoqbuyuneqKej2aJcYX6f/Mu5x0O2bmlVeni4/I2dAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnNjbtkSP562Po8fnl3mTKwqcCHAHuJKExU1CeZnPACrX+919ElGBS3DggCn364BkvoBbYLWTSb5zSlqt8X2s1/nTwtKfqCfxtkZ/Xcuptk1cBRwP/OPnjJrcZV2avraLw4qoepJTi8KWPyc8cWhdr/qLm47LGz3Yfi75t7EwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oR0ia30G; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oR0ia30G"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690be110d0dso31972946d6.3
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712083530; x=1712688330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCoeLNENCjDN/5K14Ssuw8fC2ZjYGngw9J02SWbj0Z0=;
        b=oR0ia30GBl9LE535out1E57glV6jGDqy3WsM+21QDcKC/xOo7sOj6D6rp9aoYmRsTS
         eLMmf2b/FJ6YIDZWCAwqtU1hfEVEl1MG/7p07B1m0fnujBfTN49bGm0x01qmTsR8HHNb
         MIL5j2Id9anskh8U9LDKU1bPtB5S3XgynUuvJqCNEPJUXPsutz4QfOuhZMEBN+4E2vka
         xELA6LIhepP0BZfxWFxDyd099n9JjWD5g1XzLg0ewXgZpQ+pPROmFoqXr4FxTzcWhGpI
         8KTx1MTcTHgSbPw48i7hv/5E8aZncfLLz5FFpnk3aAFqqo4L7DgCHiXGiW0l7wE0ET6n
         Vw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712083530; x=1712688330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCoeLNENCjDN/5K14Ssuw8fC2ZjYGngw9J02SWbj0Z0=;
        b=X1sWKh1F1WdC2mqmy0tsaQUyJSSUJdpxy8sUSH4gV3fewp8lA+6PUxH2hmwsgp7zGG
         lcwfeFqjMaOGrIuJTfMFUdT0qV8sDbbGwKor3Suq2GM3kAdJ1r/odBIzD4dDdOa7mW9M
         Z/bKWeigDU0VB0oPoLR24sb7wDtkdb3Lwh6UxkeMROlK2ZFdjazuC8ezQUHSNl05rMgV
         gsx0Vg/MKFAceKpstvtPQCHSAc31+skCNQWVx6WYXQi+jj6q1pK/xE3cSEyZzg2UmUIs
         TSfsBPVfIrTW09Bwa3485nmRP8rBCQJs3iw0U/qtEQk5LoEKycWBJqYbAszYp7tN63UE
         KHbw==
X-Gm-Message-State: AOJu0Yzm43mpWsMbI8k5XzdKGKsz9YIX3c3XBqott3Pr+02Z7ikduCqW
	1dbujXsxxb2VK6zsA4x7w/ngF2b4vFh1bI1eGHtSB6Btf7aRn+N5iSZpNSQ/ytc=
X-Google-Smtp-Source: AGHT+IFKBJZ6Y/xWNAiHJnadZlr5pZQCOpXScPzhfE2b8DjXYQGjxJorFTeKCDoSdvpJJivvELPZ2Q==
X-Received: by 2002:ad4:5486:0:b0:699:a2d:d794 with SMTP id pv6-20020ad45486000000b006990a2dd794mr5505237qvb.50.1712083530611;
        Tue, 02 Apr 2024 11:45:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id gc15-20020a056214230f00b00690fc99a836sm5673467qvb.105.2024.04.02.11.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 11:45:30 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:45:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t7700-repack.sh: fix test breakages with
 `GIT_TEST_MULTI_PACK_INDEX=1`
Message-ID: <ZgxSSKGdAicfVhGA@nand.local>
References: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>
 <xmqqr0fn4nmx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0fn4nmx.fsf@gitster.g>

On Tue, Apr 02, 2024 at 11:37:10AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > There are a handful of related test breakages which are found when
> > running t/t7700-repack.sh with GIT_TEST_MULTI_PACK_INDEX set to "1" in
> > your environment.
> >
> > Both test failures are the result of something like:
> >
> >     git repack --write-midx --write-bitmap-index [...] &&
> >
> >     test_path_is_file $midx &&
> >     test_path_is_file $midx-$(midx_checksum $objdir).bitmap
> >
> > , where we repack instructing Git to write a new MIDX and corresponding
> > MIDX bitamp.
> >
> > The error occurs when GIT_TEST_MULTI_PACK_INDEX=1 is found in the
> > enviornment. This causes Git to write out a second MIDX (after
> > processing the builtin's `--write-midx` argument) which is identical to
> > the first, but does not request a bitmap (since we did not set the
> > GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP variable in the environment).
>
> Doesn't it sound more like a bug, though?  If a command line option
> requests something, should we still be honoring a contradicting
> instruction given by environment variable(s)?
>
> But anyway.

I have generally considered the `--write-midx` and
`GIT_TEST_MULTI_PACK_INDEX` options to be orthogonal to each other. The
latter is a developer-oriented option that forces Git to write a MIDX
post-repack regardless of the command-line option.

It predates the `--write-midx` option by a number of years, and IIUC was
introduced to enhance test coverage while the MIDX was being originally
developed.

I would argue that GIT_TEST_MULTI_PACK_INDEX should be on the list of
GIT_TEST_-variables to get rid of as it has served its purpose.

> > diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> > index 94f9f4a1da..127efe99f8 100755
> > --- a/t/t7700-repack.sh
> > +++ b/t/t7700-repack.sh
> > @@ -629,6 +629,7 @@ test_expect_success '--write-midx with preferred bitmap tips' '
> >  		git log --format="create refs/tags/%s/%s %H" HEAD >refs &&
> >  		git update-ref --stdin <refs &&
> >
> > +		GIT_TEST_MULTI_PACK_INDEX=0 \
> >  		git repack --write-midx --write-bitmap-index &&
> >  		test_path_is_file $midx &&
> >  		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
>
> Is it a viable alternative approach to skip this check (and the
> other one) when GIT_TEST_MULTI_PACK_INDEX is set (i.e., lazy
> prereq).  It will give us a better documentation value, e.g.,
>
> 	test_lazy_prereq FORCED_MIDX '
>                 # Features that are broken when GIT_TEST_* forces it
>                 # to enable are protexted with this prerequisite.
> 		test "$GIT_TEST_MULTI_PACK_INDEX" = 1;
> 	'
>
> 	test_expect_success !FORCED_MIDX '--write-midx with ...' '
> 		...
> 	'
>
> With a single comment, we can annotate any future tests that relies
> on features working correctly even with GIT_TEST_MULTI_PACK_INDEX.

It's possible, but not something that I have seen done elsewhere for
this or any of the other GIT_TEST- variables.

Like I said, I'd like to get rid of this (and many other)
GIT_TEST-related variables, but that is a larger effort than this single
patch.

Thanks,
Taylor
