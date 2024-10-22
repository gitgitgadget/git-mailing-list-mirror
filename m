Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7374A18
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610321; cv=none; b=PHy+0Dae9RiXOqxUd81Ub11qhuk4Wfrg/8uL5SrAIbFxpNCiwsFl244/R1Rwl7aDeCuj6mu9gUWWg2UxfIzRxRDB+79c7wC76bUgSSKJAtzzqSWvcz71NYgYh6YS5pBv4hE7x00+/DfKSQWmBT+UK/mzrfEyXZ/kZRPHkEMpWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610321; c=relaxed/simple;
	bh=oGkYBPJy9/LCq49/n6xTlGBFhO0RNC7a0JgBNWs9Nv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rO2FTcGxeN2CB26iKqFbQOvFvuY2DuwVcsbewn2lSAZInuPHfHdlB0tdpxPeRAnu8CHZozeCTCGvBI/LhTHUWT8P90hdTMGEVvy3OZQhvW31R+7vFSHrA0D9R/XN5qx0OKrfY2HCEfLeK6clYE4S/WwN1f+RkThzubZQoiutqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Fvc3e/zO; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Fvc3e/zO"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e3b7b3e9acso53198667b3.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729610319; x=1730215119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F13KuzMumkwWEJtZIjq8jraZoRWXARqmUaW/swtek4o=;
        b=Fvc3e/zOVRFq2F3mFgYiheKevXXt3O6HQExQwuThJ+3L9UD1NFje2dNngUJZTCWWx4
         zWnnnV/yVSqNsiKp8+DjOdaqHQN1pYD0HFm3uxJ+0tUysjv2W7inm4NfoAPfc6CE0AM4
         gdo6skWawFVcm7d4NoCpV+ahKnN9qHJUXdhDcpkiHDAsGswFd2OgdldZSCVpPd5wogov
         rlgSjcj5H+OnYpwbAgQTjnSD2IRJD4ebfRis7JMmMxZ3eRAFCoilMoDcpV8gV7Dc+r+b
         sPPD2l1+RDILGMZ6GCRehiVsR6Fx0jgzej+lnUkoqAAkEyG9YukYRzScQU2MIpnb2m6n
         SQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610319; x=1730215119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F13KuzMumkwWEJtZIjq8jraZoRWXARqmUaW/swtek4o=;
        b=pvMWfutOjFSnxX85WOukiLsEzjVr15fRoxaN1P6ml48Z6hr2J+HfdM8sOG19CgK9jh
         JGnf4q29K3z8pCZAy1y1dUE+vSy51gA0dTTfRob9kjHrbIZhQvbWEY7aLcpvwr6lIdMG
         TnP3h0tenMFLiHj3An7PKBSaFXPqro/LLpbbDIw+JrsnfQ0NDoXcHbVPKEYhwhs624I9
         ZhegsdvjHkh0dt7klwDHfOnmiOdO2rnQK36KCDNLGtOzPU21ZvXYqL/ye2dQ6G+nJB+t
         vMrDN5Dzl6YH567C+SjaS52Se97L0qaFv/RZgc6+fYAuIJH7vChFvG8RgLsV8ZLZzerK
         BOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtF2iS6DwVXA3FwUpZ7zwbtX1307mXfWoB0vyKkfZ/m3N3oQi3AmOGaJYBszhepSH7xcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFTb6iqIXplcrW2RsZwDChJXJ1TdTgf4JWWJbvgNfolC3Ou0G
	2NsfJrsGTWvfKxSpIgkkG8PCxZREI2kZqRJNAIp6qrvVCT+gSeQxDYe6pnRKZWMuKJnIqEreq+T
	SJCWefA==
X-Google-Smtp-Source: AGHT+IEpphsNL6hq14Cl/lHRkrslv0H3Qjg8e6kcDaEYbgD/Lx4EBTiLGC5p8Tx5P/yybbdz3Yaaew==
X-Received: by 2002:a05:690c:dc7:b0:6e5:e6e8:d6b7 with SMTP id 00721157ae682-6e5e6e8dae9mr93161787b3.1.1729610318670;
        Tue, 22 Oct 2024 08:18:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d30bfesm10991697b3.128.2024.10.22.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:18:38 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:18:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-ID: <ZxfCTO+COaoablPe@nand.local>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <20241020012455.GA599236@coredump.intra.peff.net>
 <20241020024022.GA615104@coredump.intra.peff.net>
 <Zxa6ixwP2aOJdfmL@nand.local>
 <20241022051402.GB1247135@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022051402.GB1247135@coredump.intra.peff.net>

On Tue, Oct 22, 2024 at 01:14:02AM -0400, Jeff King wrote:
> > > +static char *pack_path_from_idx(const char *idx_path)
> > > +{
> > > +	size_t len;
> > > +	if (!strip_suffix(idx_path, ".idx", &len))
> > > +		BUG("idx path does not end in .idx: %s", idx_path);
> > > +	return xstrfmt("%.*s.pack", (int)len, idx_path);
> > > +}
> > > +
> > >  struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
> > >  {
> > > -	const char *path = sha1_pack_name(sha1);
> > > +	char *path = pack_path_from_idx(idx_path);
> >
> > Huh. I would have thought we have such a helper function already. I
> > guess we probably do, but that it's also defined statically because it's
> > so easy to write.
>
> I thought so, too, but couldn't find one. We have pack_bitmap_filename()
> (and so on for .rev and .midx files) that goes from .pack to those
> extensions. But here we want to go from .idx to .pack. I think most
> stuff goes from ".pack" because that's what we store in the packed_git
> struct.
>
> There's also sha1_pack_index_name(), but that goes from a csum-file hash
> to a filename.
>
> I grepped around and strip_suffix() seems to be par for the course in
> similar situations within pack/repack code, so I think it's OK here.

It would kind of be nice to have a convenient function like:

    const char *pack_ext_name(const struct packed_git *p,
                              const char *ext);

in our codebase, but that is well outside the scope of this patch ;-).

> > In any case, this looks like the right thing to do here. It would be
> > nice to have a corresponding test here, since unlike the other
> > finalize_object_file() changes, this one can be provoked
> > deterministically.
> >
> > Would you mind submitting this as a bona-fide patch, which I can then
> > pick up and start merging down?
>
> Yeah, the test is easy:
>
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index 58189c9f7d..50a7b98813 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -507,4 +507,14 @@ test_expect_success 'fetching via http alternates works' '
>  	git -c http.followredirects=true clone "$HTTPD_URL/dumb/alt-child.git"
>  '
>
> +test_expect_success 'dumb http can fetch index v1' '
> +	server=$HTTPD_DOCUMENT_ROOT_PATH/idx-v1.git &&
> +	git init --bare "$server" &&
> +	git -C "$server" --work-tree=. commit --allow-empty -m foo &&
> +	git -C "$server" -c pack.indexVersion=1 gc &&
> +
> +	git clone "$HTTPD_URL/dumb/idx-v1.git" &&
> +	git -C idx-v1 fsck
> +'
> +
>  test_done

Beautifully written. I wondered why you didn't use `test_commit -C
$server`, but it's because that repository is bare, and so needs
`--work-tree=.`, so what you wrote here makes sense.

> I raised some other more philosophical issues in the other part of the
> thread, but assuming the answer is "no, let's do the simplest thing",
> then I think this approach is OK.
>
> I'd also like to see if I can clean things up around parse_pack_index(),
> whose semantics I'm changing here (and which violates all manner of
> assumptions that we usually have about packed_git structs). It's used
> only by the dumb-http code, and I think we want to refactor it a bit so
> that nobody else is tempted to use it.
>
> I'll try to send something out tonight or tomorrow.

Sounds all good. Thanks!

> -Peff

Thanks,
Taylor
