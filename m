Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF513A87C
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408879; cv=none; b=ub8XX0XQq03IhXxa8QpCmKSzT275w67WPbqK6v+0kJcmpeTdShiEHCAq4qV9KXay5ZgYTjceQEcWXkefokVNdYlOLGqL6iafIehmLKMza25bZyFOdaw/cIBwCUJ7E5nGT5z2EY9x+zARPwnhH8faE6pJCpqvHIGTSfkVxNBTkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408879; c=relaxed/simple;
	bh=lSYLEQSRN3czv9snxIjSOZNb7ePEgBZPm8SrMny3dW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSRTZs75h2JlnladK/Yqi0Ml8zYTWk8eyPaVhRCvhatj1AtmiPlrstSIzJDTryqELvy3EtI+a8q+rjiDlrxU5kEC/gELskGBBnCrbgtTidj3JlEi063jTPBTXMAxbNdJTekVy/6bnKTIV7V2LgT9UQUEmj1+rzQQlHTfkh5L54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eVtOSyV0; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eVtOSyV0"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so1276307276.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730408872; x=1731013672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSYLEQSRN3czv9snxIjSOZNb7ePEgBZPm8SrMny3dW4=;
        b=eVtOSyV066c9qwwRKrinFaTbr3LfWQCkJipryxGlGnIof2kS2JkRIE/CDKpTYMxeBR
         l10pVYJJUaHWzwHxAdlaH3bTdF4yuzxIO4cDyMnRtRiSNVnz9cWPorohq+Wvc/CP7eH6
         7H57hEJZQlKnjwTmPrRrYUWTvWk6BVmEGEnDLtv/kgYfJoK/BaiFsh3UtO1vYx+r/cUM
         jgJdNZ2T4kngMJ76cUMPIwQE8Rp94+xYj0/fe+2ckLMM5aP5JlVXCSFKA+ba6AkNSvoJ
         VFloPkLKymIf6CsT830r4CsRUDPfc5gYOOMYCUCfjnXjuyvwFgYYmYEBmn1OZ8mgiymo
         dyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408872; x=1731013672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSYLEQSRN3czv9snxIjSOZNb7ePEgBZPm8SrMny3dW4=;
        b=epzxrR7Ha6sDSpv8f7JrJC8Ks9z7LzdizSqkiOu9judvcZCYk9tChi/YDhE8Pc+zsp
         3aOOtAe9puWL/AWq93gR5+vyxTIAUNnUuQhqAY04VapJkaH1VVjIW8kohd0qxHaW+u1E
         4HOtU7vCwp6Cojmjvl8Q86lQMqs4hkkSI4fUiehuuGpsUMkDVw+ZbNyvRo5BSaix3XS7
         X14DS18Yk+V3CReHXjMvHiEM1xfAUcXWFbJIy21pWxbh8leAc+g+D5KKoAqntyYDpPps
         PDluJpW4OTLbZQTzBcHPGSLKSG+m0CawW2WSXtyIGtioXAHtadiFrDRuHg1kMnMQm/bh
         rMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzSwI5LaB9BTdxIbznZliHD4ZkC5RGGOM4L6Vszvb4BP3RqWB4fSeRefODjihM8i5Dnog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq88+Z+cWOceeGEeWk/q8Kib+ts+xU8NDJz1o55U4C3nC66nRf
	yro6JMI88ySb6kjz9iE6bArxnrsb/l+nar5SovcnpglBN28xhDU2xg5zXZM6ob4=
X-Google-Smtp-Source: AGHT+IHiq2QQiXSZB8V4Oprm/SMY9SFo7ZYOGPj2OlHl/aIZHo3jtxqfQhPLq6Ns1gG29MUQV7nE1Q==
X-Received: by 2002:a05:6902:723:b0:e2b:cd24:4b7d with SMTP id 3f1490d57ef6-e3087a6b88amr21027912276.23.1730408872236;
        Thu, 31 Oct 2024 14:07:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8acc47esm452618276.43.2024.10.31.14.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:07:51 -0700 (PDT)
Date: Thu, 31 Oct 2024 17:07:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
Message-ID: <ZyPxprSncGa1CKep@nand.local>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local>
 <Zx8lHzDyqyBpzrAE@pks.im>
 <Zx/AGrGTN2mQZqGs@nand.local>
 <00d80855-0530-4384-8d2f-5370ace9c0d5@gmail.com>
 <Zx/I+9icWGsRz11x@nand.local>
 <85d3c75c-d7c2-498f-8afe-34c49337ba37@gmail.com>
 <ZyEjHOcf9A4eMSFG@nand.local>
 <9aa2471b-0850-4707-9733-d3b33609f5f2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9aa2471b-0850-4707-9733-d3b33609f5f2@gmail.com>

On Wed, Oct 30, 2024 at 10:28:22PM -0400, Derrick Stolee wrote:
> On 10/29/24 2:02 PM, Taylor Blau wrote:
> > On Mon, Oct 28, 2024 at 03:46:11PM -0400, Derrick Stolee wrote:
> >> On 10/28/24 1:25 PM, Taylor Blau wrote:
> >>> Unfortunately, there is no easy way to reuse the format of the existing
> >>> hashcache extension as-is to indicate to the reader whether they are
> >>> recording traditional name-hash values, or the new --path-walk hash
> >>> values.
> >>
> >> The --path-walk option does not mess with the name-hash. You're thinking
> >> of the --full-name-hash feature [1] that was pulled out due to a lack of
> >> interest (and better results with --path-walk).
> >>
> >> [1] https://lore.kernel.org/git/pull.1785.git.1725890210.gitgitgadget@gmail.com/
> >
> > Ah, gotcha. Thanks for clarifying.
> >
> > What is the incompatibility between the two, then? Is it just that
> > bitmaps give us the objects in pack- or pseudo-pack order, and we don't
> > have a way to permute that back into the order that --path-walk would
> > give us?
>
> The incompatibility of reading bitmaps and using the path-walk API is
> that the path-walk API does not check a bitmap to see if an object is
> already discovered. Thus, it does not use the reachability information
> from the bitmap at all and would parse commits and trees to find the
> objects that should be in the pack-file.

Sure, I think what I'm trying to understand here is whether this
"incapability" is a fundamental one, or just that we haven't implemented
checking bitmaps in the path-walk API yet.

Thanks,
Taylor
