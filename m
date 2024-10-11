Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3059A198832
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662406; cv=none; b=L69WiEC/36swd43o3ih15NS85dBjucADe/HufTBAxDqI6wPlkMj0Kom1mwVGm2fwagMoSb/CzQlyqGngkORHrZDKL9w2YPJ3a4W+rhmR3TGE0oJZSZbzZmvf43U8HOEzHAJWdJuZkZB0+CixsKM4xMMdI5XXH6dme2GWmvntFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662406; c=relaxed/simple;
	bh=Qzit2eRXBNzn7JNT+Y7Ncc+xSA392+XZOSmnLt6EnF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFokcJK/bKLWtmUpQn5ymXUdBn6cIFm114hxD7hDUKye5CEGNjXNeknv1oXs/4MkLAu8qSlKw2PpNQPIGsOhqlCazd7gm+IlmR9ne7iAKCd+j2v38WAiV2QrCLjQrHtz2ZPQXZF3uJhTO+K9D8xvjVPXEGojPI/UN3X2cfNm4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QzgCrByH; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QzgCrByH"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2ef9af517so18236997b3.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728662403; x=1729267203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qzit2eRXBNzn7JNT+Y7Ncc+xSA392+XZOSmnLt6EnF8=;
        b=QzgCrByHV+FyoPQhEwOPMlNIFvKUyx02uQUxYFR17cCZOvym6w3yBkyL2BKooHX36U
         E4iIKWHCn7eFsP/jRDBVrcFZB8jmz3ikJLFPLzyKalcJ0iybYG0Np4lf95RM8Gb743Mi
         G6Bze0sxkj1gLS0K4pYvgMJbDynBuLGH/Q5PN2JcjtHElPIllGDPK1VsdqhmCbvA/bpg
         6zJTwLcdr6UmeYgHMe95IZEbmZ9z4YVZrIA/ABpPCcpgd+fDF2PTSvBlFSh5qrokCfz/
         bPbzXT99C/wfyy3JQPXkgMKc55+jI1ZJmcauZdq1PPG7q23WdVTqH3szQlVTwhg4CiZE
         qWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728662403; x=1729267203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qzit2eRXBNzn7JNT+Y7Ncc+xSA392+XZOSmnLt6EnF8=;
        b=lKF9yyywzLe91pQNIBbsfjZ71pfSar5nRcJEimio19otsJhKMzZDVtv2oBOcTnxaRK
         68s6rgp/lYA/A19yMl8K2goClyNnVmICBZqy8pUt8QriDaXpEfyrVXXuHS10OOretBv6
         uB2hkGF2G1znU9swdrDAAE8s44TExD9DEyt4Xz+DFVv0VRCMUjCSkTyqFiBQLMzZXXBU
         BM8WDvgaf+vjf8+A3R4PUjBBpdfm4YLX4sMdhMKVD4EUW97uhtIfDOlaQGodugk2h+et
         Q13uGfF0D5Mb9QrOpl20aYvqed6VG7eJ9Tad5pZQlODg5PKb3V3H5qVS9UxvmjUu2Uye
         bl3w==
X-Forwarded-Encrypted: i=1; AJvYcCWjHh+0n4Wu9FS9QenIDjmQG9O7AanGcxepb9p35Act4uClihaarW9lLqkCwIRxM/B91oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNERK28NrMeFaNLl5GcIGen6g68j9TKBljP9C97cgitOBkYEjO
	0gx0zSzdC+JVxMO4Qk8x7HTolFAGB/dbSnsK+9RhtMA2AJdlcnLGFrh/Ve1nA4Q=
X-Google-Smtp-Source: AGHT+IGSpmRfieU7iocbA3KtziiI/22rwCD0L11jnbiWtVD3nGFf98aTw4aRdTRpsqI+KrFCvifICw==
X-Received: by 2002:a05:690c:4c8f:b0:6de:b23:f2a1 with SMTP id 00721157ae682-6e3479bafb4mr22718007b3.15.1728662402846;
        Fri, 11 Oct 2024 09:00:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332baa9acsm6391417b3.61.2024.10.11.09.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:00:02 -0700 (PDT)
Date: Fri, 11 Oct 2024 12:00:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Scott Chacon <schacon@gmail.com>
Cc: Emily Shaffer <nasamuffin@google.com>, Git List <git@vger.kernel.org>
Subject: Re: Interest in a Git meetup in Bay Area, California?
Message-ID: <ZwlLgJ6e5aWQKJgm@nand.local>
References: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
 <CAP2yMaJc8ZDiyZrxym-azUpkUOCTjLWEkv6gO_hJ1TqU==Bdcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP2yMaJc8ZDiyZrxym-azUpkUOCTjLWEkv6gO_hJ1TqU==Bdcg@mail.gmail.com>

On Thu, Oct 10, 2024 at 08:53:18AM +0200, Scott Chacon wrote:
> Or, what also might be interesting is to do one in the evening on Mon
> Oct 28th, as there will be a lot of people in town for GitHub
> Universe.

I'll be in town for that, and it would be a lot of fun to meet up with
some CA-local Git folks while I'm there, too.

Thanks,
Taylor
