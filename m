Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86D13D8A3
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215420; cv=none; b=ozvA8O8eo4ZRe4CIn6SJUOzYRWbiieA4rqqSL0yIMjAdolBA5uJAdF4Wm5XTegEYol3fhF9RTYFvDSfJNGikINZ8rJqDk+UWTryD2dejjsgCZDwfWxVecNM8L0ILuMDp5HmNBUOvWJgx+a0tChn5zhClvfamcqepPpF0TyIcHAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215420; c=relaxed/simple;
	bh=dLkQTsmABzZhssm9F2ww4IFsPnYn1KAJzCrW49mZpkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it/C7WkEAvQcyr1qVTkc69Az6B21FOnKE7o7JKlAbQegwfhnYqA3e3z0X0drA+rz1Fo8rSP2XNqd+cSwXQOw0QhRf6lyKl6s605QbcJN40Nod0IR5dl14tOyRyk0+r+QsZPONc6f7fLdtroet+MqSvshzRUXxb+b7zTJhF314FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dceDmVRV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dceDmVRV"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6db67400db4so56422317b3.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727215417; x=1727820217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X8Iviz4T96drXtVlynP/ZagFpK1j9bRWZOqxKBj6SiQ=;
        b=dceDmVRVy44xLE67xumJS5QJ/WNtYk/E7iuHRFsukzhESfrj+PS0dhQ5yRHdKaNr7X
         Q9plkUT4S1WlsAigrT9pfXtE4XcCXedHvcN3MRF7Oh/wUcgPxDPHvt39+9Sc/c644CQW
         /LiJj6kBIg7xzWqkgpX+JV8YReor6IC9LacZcTNolPApEkuegwnj1qsIg0yUs2hPNmVn
         HdxbyypcurqcRVbsousGVDHAdE9toaZLGr1mVxhgDJSZc98fw9D2maDYKsCpKWraByju
         qcOku6aTHBLn/LkxM4GjPbvNv/EiSlXhkaRwTJcGAEDObP8Lu4F6C5pKl5mP574fYvBs
         ebUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727215417; x=1727820217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8Iviz4T96drXtVlynP/ZagFpK1j9bRWZOqxKBj6SiQ=;
        b=DoMqikqZIkIGCwbcCGpDwlq+3zQG159pk/0wcHaJkpjbamuP0M5p/Eze3KI+otVfer
         GmHfoPHHNHHhwdSAmJRsp1mQlYWfNBx+Y6kaSrEcJRRHlKVP2cDNuqS0FqYSN7BPpajh
         c1sYVoou64zR44TUp5+8M5G0jqUswVyNZbj3uA6A0jL9qYehc51rHiIX+MRgnD7g/5DD
         riehmXLRdDTgIBI2BzjRdy4ak/JapaKOVVyFWALNW6eUPMp1+zz2RNY45sfIyr9zqWZe
         N57lqIFkUEpOpfCVqilA7bbSmJ5ebZDXAMqU1Jn6fQ4Qyw4hkUnzZTQg3dyr/7e3nqlQ
         TUAg==
X-Forwarded-Encrypted: i=1; AJvYcCVcglDCets4LMXfx50WMw8PCtdR6yz6sWv4CMVpRs8g0stKYkQmDcCbTfX8KeFLIsgq2ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOTNYrHV7J7iUAz2/zz67m8xzMCgsboFfeWRIKBd+X8N5PpCSp
	vfrEfDpwkXsKV2iZLA/0IJda809GkNPDLSB1qEUBX/5fw5wZWaa0/HXfOo/cnzs=
X-Google-Smtp-Source: AGHT+IFRJMWKAu2F7S1mZXDkPBBk0VlD8ke2QiCBvF7ZW+fBjboedOypBLZ86m9VRlRT44pGPkhFfg==
X-Received: by 2002:a05:690c:4910:b0:6e2:1062:9b90 with SMTP id 00721157ae682-6e21da19637mr10397797b3.44.1727215417219;
        Tue, 24 Sep 2024 15:03:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d16fc34sm3950757b3.92.2024.09.24.15.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:03:36 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:03:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-jump: ignore deleted files in diff mode
Message-ID: <ZvM3N3+JJNlkpZSa@nand.local>
References: <20240915111119.GA2017770@coredump.intra.peff.net>
 <20240915112024.GB2017851@coredump.intra.peff.net>
 <ZulEwjnNQet6th8w@nand.local>
 <xmqqed5il3ui.fsf@gitster.g>
 <20240924205558.GC586150@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924205558.GC586150@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 04:55:58PM -0400, Jeff King wrote:
> On Tue, Sep 17, 2024 at 08:03:33AM -0700, Junio C Hamano wrote:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > On Sun, Sep 15, 2024 at 07:20:24AM -0400, Jeff King wrote:
> > >> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> > >> index 78e7394406..3f69675961 100755
> > >> --- a/contrib/git-jump/git-jump
> > >> +++ b/contrib/git-jump/git-jump
> > >> @@ -44,7 +44,7 @@ open_editor() {
> > >>  mode_diff() {
> > >>  	git diff --no-prefix --relative "$@" |
> > >>  	perl -ne '
> > >> -	if (m{^\+\+\+ (.*)}) { $file = $1; next }
> > >> +	if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }
> > >
> > > I was surprised to not see you use `--diff-filter` here, but I think
> > > that that makes sense. You only would want to exclude deletions, since
> > > that would be the only time the post-image is /dev/null AFAICT.
> >
> > So "--diff-filter=d" (lowercase)?
>
> Hmm, yeah, I think that probably would work. In my mind, we are
> accepting arbitrary diffs from the user because of the "$@". But anybody
> who overrides us with
>
>   git jump diff --diff-filter=D
>
> maybe gets what they want/deserve. I think it's mostly academic, and as
> the original has already graduated, I'm inclined to leave it unless
> somebody comes back with some use case.

Yeah, this is definitely all academic. I do not at all mind the
implementation that you went with here.

> (Sorry for the slow reply, I am quite behind due to travel last week).

Hopefully your travel back went smoothly. Welcome back :-).

Thanks,
Taylor
