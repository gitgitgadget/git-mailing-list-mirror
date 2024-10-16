Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81606125B9
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107916; cv=none; b=Pli3uXfmoK7J4+tZeDkSDqXbUX4xlWuthnNB0qQCYUuvrfodN8cd6dvqdytNobw8mxZY8dJCUwiCxWAa6VdXCkieA70VzGio0BZQuSkF3i4NqmsJ2incCdnzy4riZ6iaXRotl9EVI3Ry/XapBpGGr/SmulnuQyC24Exx4WmBs3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107916; c=relaxed/simple;
	bh=6GFhAbMCcUATR9/AvoELmt5FQxny28KWkQJ2nXop8Ms=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4B9iIayTkU6ZTcwH1OAKprCTlKDgV8/VRerqudwflAgvJ1+cZb6rSQsuFL8he1FEP0t5AviInrz/u9QSWRRtb3lvi2/Fhlek5FwiqIyK54Vhy7Nrutd9sOhDUJ/zdQ8ki3pWTyLTU4qZOvfwzIBES/g+mj0V30BZ5UG6KjFew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1aJHQZ3v; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1aJHQZ3v"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e22f10cc11so2278417b3.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729107913; x=1729712713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoQHaphL1XxoFJ+x4USZVISZphFt8MfNyjtNmR/cceQ=;
        b=1aJHQZ3vGh+DDdhPnBsoTZfBpFGwb42UCWFSjPaW9vAaM2KwM7uSZ0ahbEE2HdKie9
         DE8Kn9/5ppx45x+P8YMNBvTa3cpcCl55kwT4oUzE08nWDJOQe0UDdcnN0c5LwPjjmpS9
         kGx7howRrrCI40V4z3SC+/mdqY6Gkwg0dgaYkZd0MDkks9pW8P+ti2gUFEqzqnYIjado
         L4vBnAxki4tUxuXCkElv1iLTYxDOxw/uXpKFKJSeC3XikZza+AAaElKWyyA7w4Q3Nfyw
         +Rnzccz4jS2LghGX7QclnFDQT3vx+3SEh4/YPiUVPqwRIwkXIJxlNwhSDkKn5Dqv1nED
         p+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729107913; x=1729712713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoQHaphL1XxoFJ+x4USZVISZphFt8MfNyjtNmR/cceQ=;
        b=dNL9A0jvy0Bd8wfPOtA946WmnM0btOidK/sWskxmQyPNMvyJjTqUpQf065U0Sv4vVW
         LdzUGs8/lMoDCXwVdQe6byOk2uyrW99Q3HuM3TW+ol8dYpalM1RCT7iQjcWYXYwbW7WX
         rC1Qr2LHUiQmKhkvNzsiismWzyNM/r+wpmDJzWioIkaeedlmipUM3IwjkUEfV41RK/TJ
         M6D0YweW0CRgHm3orCEV6A7ORxJR72e/yZjUXiyhCINsY/T56SHXk21jVxQBkhX8LvJV
         WADUuvXsMIyuX6DoO6ekbfs9EnWneqs3Ra2cfYVb5im1cewOzeBw51cEAhIfhz05N6hr
         8hEQ==
X-Gm-Message-State: AOJu0YyHsdzu2ihGRu6FnSx6gdM+Te62z/3YrFYuiYB6SqcRVH+lWwJP
	xeYxPlrasepOlrrbVZGH4cgR+16J50umjFXXcDkmA7I9X3HJLwiIVN9wl3chAB95R6jPP9ky9iZ
	D
X-Google-Smtp-Source: AGHT+IE74dCTq0++hXSC99ZBVPd2DszlzT+Y32ijk2oQs+p2/UTmRyiftzoZTUTNm/zkZA4OcCkDug==
X-Received: by 2002:a05:690c:7004:b0:6e3:32e2:ecbf with SMTP id 00721157ae682-6e3d40dc4fbmr62404627b3.24.1729107913214;
        Wed, 16 Oct 2024 12:45:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d26544sm8312737b3.114.2024.10.16.12.45.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:45:12 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:45:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] shortlog: Test reading a log from a SHA256 repo
 in a non-git directory
Message-ID: <ZxAXxp19p9rWeJVK@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
 <20241016182124.48148-3-wolf@oriole.systems>
 <ZxATKIRGv4QCM9Td@nand.local>
 <jpbyxh7o3kip6mef7ie545futmfer2o4qjryvq7yta7qvsqj6f@4zsqyn7t7hnf>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jpbyxh7o3kip6mef7ie545futmfer2o4qjryvq7yta7qvsqj6f@4zsqyn7t7hnf>

On Wed, Oct 16, 2024 at 09:35:46PM +0200, Wolfgang Müller wrote:
> > > @@ -147,6 +147,14 @@ fuzz()
> > >  	echo | nongit git shortlog --author=author
> > >  '
> > >
> > > +test_expect_success 'shortlog from non-git directory reads log from SHA256 repository' '
> > > +	test_when_finished "rm -rf repo" &&
> > > +	git init --object-format=sha256 repo &&
> >
> > I wondered why we needed a separate repo for this test, but I understand
> > now that we need to have a SHA-256 repository to test this on.
> >
> > I'm still dubious as to the value of this test overall, but I think it
> > may be nice to s/repo/sha256-repo/ or something here to indicate its
> > purpose more clearly in the test itself.
> >
> > I don't feel strongly about it, though.
>
> I personally lean towards skipping out on this test, but I can also see
> value in it coming from a point of view of future changes to
> git-shortlog(1) behaviour. Then again, perhaps it would be better then
> to add a relevant test only if new behaviour is added. No strong
> feelings here either, I'd defer to what regular maintainers and
> developers here prefer :-)

I have a vague preference towards just getting rid of it, but I wouldn't
be sad to see it stay, either.

Thanks,
Taylor
