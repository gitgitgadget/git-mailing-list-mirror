Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0221171F
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745013460; cv=none; b=bpsYwxW9ah9ZIAtDlb3NLmLqD2TSUYGpJUsfvsvs8bwVGtyWNd8poXleAzfjWTmk2qzBeyNV1Lm64hIH7Pg2gyFZkEO6AYTPPu1B/hivX0vFWa/zSLtJ+Hd9WCL8nDOIpsgsFQAYLblhDL2PcMZ+W4VQOJ1vo5+kqYxYl82d7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745013460; c=relaxed/simple;
	bh=UZeRTi36ENqdUs3RiamPv+8oTvrFHbmqLLUliO4ppaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/Av781n2Ag3SwRy1BNYIpGG6XDUosveG9PX5QEQvHtuc4in8LqtSxXe8VobTETvdNnPDKegAdF212KxX2SzFWt5AlYc7Y7nqV39YH+r4Xo51UU8YbHoHdp6wSWMSw/zdboqTSb3pfjE4ZlTOogK+GQ4si6LREwydio0cyUQhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=sC1GV7XC; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="sC1GV7XC"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ecf99dd567so27455626d6.0
        for <git@vger.kernel.org>; Fri, 18 Apr 2025 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1745013458; x=1745618258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=da5b0YZ40tnliwjsgkPZaLf9KXhtWDXxH9pV9+apB/U=;
        b=sC1GV7XCZ4VsOmKfYnXQM0vECYQIUaEi0X+6TgQRNCmkYthhzkTt0tPoBybP1bxzmi
         s2DDR5ElhyQT3t+d5u5FU9Lqr9IImSW74CKQHXSWXRENQiRn0JgdYxEXz9WLvGEujjgv
         8PfsVjshBF15rLCQw5pCiKYIFJpfApKMossz0oOG8PXYN3z6jS9oL5I9Kaj8wLTko6uK
         9+WlbiNoJBeCAK6wiT8/BtPA0EIsEf1f89AWlUH3ibTJu2Xps43oUZT5Ls9nDQ6aLeCQ
         ng7ly2VO2mtWs7WeJyN4QNQ84J1GsTypeq8yB3Mh+G65jTSCzI70dwSggHz/ISFjrTR4
         5imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745013458; x=1745618258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da5b0YZ40tnliwjsgkPZaLf9KXhtWDXxH9pV9+apB/U=;
        b=uA81rSe/kWB4J7yEyV+MPJ2rhOGaUhJDDIulOB5FdMJEB/uCI49V2lNAViOrc4h7z6
         RZkc5F+oBzIMOgMVv07KbIXud1j7aU7tci0AJknRvKZXOSDUGIPDv6xbYxJjWCZsbKkH
         nAMD2sZy1OH3h67rN0aMPthihNxssHvVlqkV38rzQs58iZCryIpqIVzFDzn4ELBxl7+H
         5iK9bETLXv2vmhkLe09gwwPoCbRXSAdtvVV37H4tf9IugQJDTGA6ZhiAq40ULO1/Gnq+
         i8gh2vNfkC0Ep1en4yVQbm6xHfS/CzI2EjeToCq7xsjkh39e3parqvK+TyfaIrHfoqy8
         zQ2g==
X-Gm-Message-State: AOJu0Yx8PDseATnzGoi2eTWA6wVc9ufrQnMu6hFMvC7jlBD/2OcAXcHc
	NbfK/j3cZq9ZCXRJC1k+cuvH1L9tUsNki3OxQJtA/hpFt1rMGNj8+vEkfS5twx8=
X-Gm-Gg: ASbGncsd9iX48xB9+qNJewIUq6iqv/kVInIdpelRs6IMtzSbpUw2cl9v1cyPROiA419
	g1yYMkX8M7l+Mauujk+Bzf3IRJb1SjzjmPUexNKGdMZTaRqlOdr8fOh34VY9SbRkGwKVZ84o3LE
	JKDz/A8fa6HDr455849EARb2Q4rfDdxeN6tUrRlsiKaFSj4/njSJhI02gZD0MoN/jyo6RVFl3pW
	/VFgN5YfaPmBJv+KcVHouJYYRUUGTPRv6RWSd2IVHy2rDlUY4NtRRzdb8S4Bkl7hG/BtDYMR/za
	WUdr5oMTjVeCBNBUMbBzFe+bppKtwQq8UGeZyDa/Q66wYJ1utPdWP0ElN9vM9M4MILBW2JESSGQ
	bai9T27KpeyPV
X-Google-Smtp-Source: AGHT+IFbkmwyuTHdsoPu+JzUgR+Bw8Osqpr6Nx3AQ75ccQ6uDcnMEEe+qsEEhnbDByrBLqXy9YWGbQ==
X-Received: by 2002:a05:6214:4103:b0:6ea:d393:962c with SMTP id 6a1803df08f44-6f2c463f961mr45990136d6.30.1745013457825;
        Fri, 18 Apr 2025 14:57:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2c2c21c32sm14765726d6.110.2025.04.18.14.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 14:57:37 -0700 (PDT)
Date: Fri, 18 Apr 2025 17:57:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] p5312: removed duplicate performance test script
Message-ID: <aALK0JlOZDVPUHUR@nand.local>
References: <cover.1744924321.git.me@ttaylorr.com>
 <51c4604e16c886d888138f2b513e4d3407b10728.1744924321.git.me@ttaylorr.com>
 <xmqqh62me8zo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh62me8zo.fsf@gitster.g>

On Thu, Apr 17, 2025 at 03:08:59PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Subject: Re: [PATCH 2/4] p5312: removed duplicate performance test script
>
> "removed" -> "remove"???
>
> > When the reachability bitmap format learned to read and write a lookup
> > table containing the set of commits which received reachability bitmaps,
> > commit 761416ef91 (bitmap-lookup-table: add performance tests for lookup
> > table, 2022-08-14) added that mirrored p5310 but with reverse indexes
> > enabled.
>
> "added that" -> "added a <something> that"???

I am embarrassed. These are both awful. Here's the relevant portion of
the range-diff:

2:  51c4604e16 ! 2:  a80a7b5e60 p5312: removed duplicate performance test script
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>

      ## Commit message ##
    -    p5312: removed duplicate performance test script
    +    p5312: remove duplicate performance test script

         When the reachability bitmap format learned to read and write a lookup
         table containing the set of commits which received reachability bitmaps,
         commit 761416ef91 (bitmap-lookup-table: add performance tests for lookup
    -    table, 2022-08-14) added that mirrored p5310 but with reverse indexes
    -    enabled.
    +    table, 2022-08-14) added a new performance test script mirroring p5310
    +    but with reverse indexes enabled.

         Later on in a8dd7e05b1 (config: enable `pack.writeReverseIndex` by
         default, 2023-04-12), we enabled reverse indexes by default, which made

> > Later on in a8dd7e05b1 (config: enable `pack.writeReverseIndex` by
> > default, 2023-04-12), we enabled reverse indexes by default, which made
> > these two tests indistinguishable from one another. Commit a8dd7e05b1
> > should have removed p5312 as a duplicate, but didn't do so.
>
> Or to retain the same coverage, it should have explicitly disabled
> reverse index in one of the tests, while allowing the other to use
> the reverse index enabled by default, perhaps?

I don't think we necessarily would benefit from having two variants of
this performance test. It is a little annoying to maintain, but that
isn't the main reason that I proposed removing it here.

I think that the pair of performance tests were useful in proving out
the lookup table extension as useful to bitmaps' performance
characteristics by comparison to the non-lookup table version. In that
sense, I think the pair of performance tests were useful as a contrast
to one another. Since we have evidence of their usefulness, the contrast
is less important IMHO.

I think we still want to keep the "lookup table enabled" version to
prevent regressions, though.

Thanks,
Taylor
