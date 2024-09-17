Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D92161319
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565938; cv=none; b=Hgsri/9D1HVVVkHKna3sawZB5X29jeUtbYId9ISReD60oWut6sZJRZ0vVz5YRkEtUW+MOAYYsWLK6Eb8DHRnWdnWI+eXcH86h+qVMz/GrEOs5IU4Q50AZPpJiKwmFm/Xl5ToWnursWy9l0xn/i6+/hxLqmh46Ae3+SSAWdRwl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565938; c=relaxed/simple;
	bh=jUfc2HHKd5miYKsSt/aUwVxxLMzzXg4MJKOLb4x1/IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvL4PJ/YIm0deIx2OGNhCiX6MFfwS8b6f2RnQOFtAMbIfB3YLJqvIQk+W7g2Hw5dsJhhh12HwAS8ehcKgsYzkLHCe9TSjBwr4TLmILuKfiVNTgrR+WRAg8nxvRnK4hE3YlcU0J6OVUkVQpNyFdVs8WBipEQrCfHb8xlWq1Xn6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=11VAzPk/; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="11VAzPk/"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a09ee2c57aso7608575ab.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726565936; x=1727170736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lw/OKs4C74cVF7o18CiZBzX7mCodwAgRQsUfcQviFgg=;
        b=11VAzPk/5gEv9RMmAY9WYR69kYjKla1UbbRvimO97CqtKIxab2VVvM2+tcNFOPvSdF
         vEzEuHX5U76TvdPN1mWNDZe5nOe3xu8ZJNOTnfPtAvRWqFcANwa2/0aNyPxrSTrtO6Ky
         ugUlTZ23Xa9d35RYWvcggK+mttBaSzhWV7TIyVgEscQIORHlWgSd0++6xhTnBRyrD2k5
         6ueWD2pqF5HDmkWYDUxiIZyKkGgVyLBZVqGeDN7fZzLJXpgw4fQCmnLjwK6zFXXJzEww
         TaYa6M3cvDdHGKJv7BKNe8iKgF9rEmRcPdvA/lPPOj5kVobtKr9RujoLG9utoh+1Frc2
         84uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726565936; x=1727170736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw/OKs4C74cVF7o18CiZBzX7mCodwAgRQsUfcQviFgg=;
        b=wXlw6zq+A8WRmoZUCpwTIeyzM5flDZJeZu5bJs6TavRvQpz2AIKmj6OxOmG3o7/zB2
         KItITmcXMiPsbm937Wk6kaUZ1TItkuJcy1bNalgXYxlNYe6DaiH1xRGp+gMxQ4cgY09M
         3PSTWbsJ716ehtRPAVeZnbr+BLcm7ILr1OZnaCxGhCEf/F9EQ6m4BbNcm7O70XZs25Ra
         giHoixKcXrGMgbmoJUqOK/KoJTGM0ZvRkrcK84MH/ShHAxSuQri51N+mwruMYu4gkGmf
         XiltjAtG5yAZ4LHebjHfqdq3a4JyQ9Op7E0TBvKwv5w6S9gw5dvBBZrxc6yjoRVqbld1
         PcLQ==
X-Gm-Message-State: AOJu0Yw+K+QPCezmYnHwfV1DZwD6W8VGA+gyT+ZTp4mXiIjhGeFbPwd1
	miK47+9QQLhrgvcavQTKRb7bgld7HBbh7MErNsse4ntF00fNdKiAo0gmW4PUpEMDLmMPwo66lZu
	AFso7oA==
X-Google-Smtp-Source: AGHT+IGR2Q3am33Y/IkHrIOPzrwPWqQ/IrrfASEhvGQ3NSICwpEb5kR364GiIDovgQJIO5auaiPG+Q==
X-Received: by 2002:a92:ca4f:0:b0:3a0:a385:9110 with SMTP id e9e14a558f8ab-3a0a3859412mr52503275ab.1.1726565935713;
        Tue, 17 Sep 2024 02:38:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e8f1b7sm21440515ab.74.2024.09.17.02.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:38:55 -0700 (PDT)
Date: Tue, 17 Sep 2024 05:38:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/6] refs: properly apply exclude patterns to
 namespaced refs
Message-ID: <ZulOK5GAWYbPlYeO@nand.local>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <7497166422ea702aabdf4159b0d7780f1422ba13.1726476401.git.ps@pks.im>
 <ZulIB7k18+4CzwZb@nand.local>
 <ZulM4BU7zSn_NHMl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZulM4BU7zSn_NHMl@pks.im>

On Tue, Sep 17, 2024 at 11:33:25AM +0200, Patrick Steinhardt wrote:
> On Tue, Sep 17, 2024 at 05:12:39AM -0400, Taylor Blau wrote:
> > On Mon, Sep 16, 2024 at 10:50:03AM +0200, Patrick Steinhardt wrote:
> > > diff --git a/refs.c b/refs.c
> > > index ceb72d4bd74..b3a367ea12c 100644
> > > --- a/refs.c
> > > +++ b/refs.c
> > > @@ -1517,6 +1517,19 @@ const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
> > >  	return hide_refs->v;
> > >  }
> > >
> > > +const char **get_namespaced_exclude_patterns(const char **exclude_patterns,
> > > +					     const char *namespace,
> > > +					     struct strvec *out)
> > > +{
> > > +	if (!namespace || !*namespace || !exclude_patterns || !*exclude_patterns)
> > > +		return exclude_patterns;
> > > +
> > > +	for (size_t i = 0; exclude_patterns[i]; i++)
> > > +		strvec_pushf(out, "%s%s", namespace, exclude_patterns[i]);
> > > +
> > > +	return out->v;
> > > +}
> > > +
> >
> > Is it safe to concatenate each exclude pattern with the specified
> > namespace? If I'm reading this correctly, I think we silently do the
> > wrong thing for exclude patterns that start with '^'.
> >
> > I guess we reject such patterns in the hidden_refs_to_excludes()
> > function, but perhaps we wouldn't have to if this function stripped
> > those prefixes for us when the caller does or doesn't specify exclude
> > patterns with a '^'?
>
> Yeah, as you mention, `hidden_refs_to_excludes()` drops excludes
> completely in case there's any pattern starting with '^' or '!'. So the
> current assumption should be safe because we don't use excludes in this

Right... but can't exclude_patterns be arbitrary here, as it is a
parameter to the function which is exported via the *.h header file?

IOW, I don't think we can claim at all that we have passed the excluded
patterns through hidden_refs_to_excludes() before calling
get_namespaced_exclude_patterns().

> I also agree that we should eventually think about allowing '^'-scoped
> references. We can handle them correctly, but it requires a bit more
> thought wire that up. So I'd prefer to keep that out of this series, as
> it is basically a new feature.

Yeah, I agree.

Thanks,
Taylor
