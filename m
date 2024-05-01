Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811812E6A
	for <git@vger.kernel.org>; Wed,  1 May 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574423; cv=none; b=n7z7BBnXKOZ6TqZPMutMkhaPyUxuEZwKi4+9VGmqnpWz2e7OyB47kjR6xlHjC7Tg+Hve1KJ/h868ttya/3ggOzjzjt69BqMnh0c0JhjyZ7FrdoB5B0nIZtsY5LRQYJZImiobMXck30PozbfroRR0Za2Lvtut9ILfTA7m4sM6KRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574423; c=relaxed/simple;
	bh=Bb8FztRAl+1w6ImWnjazwI/LyL5qcqHsjpOdzVNESBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j18LA4qBrITkm60nW1/I20aXc/r/ty5N1YAwWckkAGgf3reKQvKCTutXkzgptJqqCMkckFWSdKEW+KkVyMkKdTfO20FNm457rXNJ/Z+HpcgaU8N9VMEbI6DtAKUumjbRrV4q+LuhlFRn9PPOwLZqNPU1hm33Onky9N3/4Uoz7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ar5pOT3r; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ar5pOT3r"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b7d2de292so27095006d6.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714574421; x=1715179221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJgYH7QJq+4GEIqrJGTt9JaHBy8AlzsDQnv0NMJwxZM=;
        b=ar5pOT3rU6Pq9tAsBx0zPh1qvHcXZo+e2LXBHIhrHKWYMnr6Eb1jb/aD2t5+v7lrZx
         RIa//VT6jU/2ltXLv1mjN0mlg0G+y6SC4/gvqqKqctQ3tFe9w/a30JXJs+ja1UYdilie
         kfj2aYw62ZPhpSaFgZ1iJxR9uKj2JM93gZ0iYX0FyyP8+hVVcbmA4eMSIrT6Y9u9lvEU
         6izTffZmrd1IgWie6BtaoGDPZCnUzzz0i4AJO+Mf9fKkevYRitOz4oWCvQ2PXReDY+Fa
         vsNfJIh/RDkh6htEg0kJHbTqNj0w81wIRL36aXAnRq21uQsLtKkwfwYsOc6n8lVt4TDk
         WX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714574421; x=1715179221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJgYH7QJq+4GEIqrJGTt9JaHBy8AlzsDQnv0NMJwxZM=;
        b=XGtFo3HAeh7rG7V7YTiI2r/sUm71y3/JtqEwAg8sKPmkVNkggMGS+ec/pKwA4Ypsvo
         mR+lCHiywicm2gK0ZWxb+QIED/4ontBjUH/5jviS0DaiRp8y4J03skTIKuLNprnzD+0+
         zJKkYPbSpVrGT0Pintco8nH0j7Rxl8XvsTSmZb0b4vvHP7BJT3FaEglvw4VOTXbYvij5
         KiApoNGCoIJAaMYoi4qoSfgMnpN00wY73A6hZJiT6GG3ElUMH/j/hFykqR3vFKxRi+bm
         vJVZONurNEelIxDEQ5uaZEmaz0yrzR5+OSLrtP4WXIy/Kbv7cxNG7ieJuOteQwpvjkFv
         mQlA==
X-Gm-Message-State: AOJu0Yz5wfGL15sLhpxnuGnw/tmbbjSRWgGAgAQEEn9Ece29BvHe8g7T
	Klw+Ymw5aQjd3p0IQEqoYOi0e694ER9r1ifn0noJBq5E04m3TjEN+PVDnL+G5bw=
X-Google-Smtp-Source: AGHT+IFPhqfSyfqUyNGnCl35U2fqphFyTveMel57p1FIXCh/cpSicy3n2VmvEcLos3waKbSMRFQ0iQ==
X-Received: by 2002:ad4:5f45:0:b0:6a0:b3de:e3b5 with SMTP id p5-20020ad45f45000000b006a0b3dee3b5mr3164980qvg.47.1714574421150;
        Wed, 01 May 2024 07:40:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d19-20020a0ce453000000b0068f35e9e9a2sm7080382qvm.8.2024.05.01.07.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:40:20 -0700 (PDT)
Date: Wed, 1 May 2024 10:40:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/23] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <ZjJUTlzOijT6E8pr@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <xmqq34r2zkgp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34r2zkgp.fsf@gitster.g>

On Tue, Apr 30, 2024 at 01:03:50PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >   - Rebased onto 2.45, so this is now based on 'master', which is at
> >     786a3e4b8d (Git 2.45, 2024-04-29) at the time of writing.
>
> Is there any notable reason for the rebase (other than "2.45 is out
> now") that needs to be called out?  Something along the lines of
> "topic X and Y has graduated and the helper function used by this
> topic has changed its external interface"?

It's mostly that 2.45 is out, but there were a couple of topics that
merged that produced minor conflicts that I wanted to resolve for you:

- 625ef1c6f1 (Merge branch 'tb/t7700-fixup', 2024-04-16) introduced a
  minor conflict (both sides add GIT_TEST_MULTI_PACK_INDEX=0 to the
  relevant test invocations).

- d8360a86ed (Merge branch 'tb/midx-write', 2024-04-12) introduced a
  conflict where this branch adds a call to the new
  `bitmap_writer_init()` function in midx.c, but tb/midx-write moved all
  of that code over to midx-write.c

Those are the two main ones, but I mostly just wanted to take care of it
since we're on the other side of 2.45.

> Thanks, queued.

Thanks,
Taylor
