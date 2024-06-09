Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4F28F0
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717963266; cv=none; b=g5ukV6ZNoOG1f6v9hNTFzyMAaALl2zxdi6mLMc2bxYgB+jHCXVBwYfqYjVwgV9MT+Yq1NJXef+SeGeP1PYbNgptOqZiEYLmx2A6l8ZgoBh6G1uC9uYPEWTif9QCpT3agprkCd8vh5OtExY5wFCSLlFPS6bQKFHPhrlnmkDhVT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717963266; c=relaxed/simple;
	bh=1UwQ9K9bq/EbLCTeN6t7AdLm/Spvd7tQulBwcass2+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vx1VFerCEdVGGn0g2crFdZpDRtZX6ZUjoTEXLvkuA3aB7hGQmcuD+XqQp41+ivRzwdem6uEMO2MlypApf28stHmKEb/cet3+iqR9OtUCAQvdniNmtn4fs33OkqRRJVvoNy9kqRfjhSAlQTR7U5QI0PrLOYwSIc6hYklfqh7z9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZwQrDrcw; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZwQrDrcw"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-795524bb721so119827785a.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717963264; x=1718568064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1UwQ9K9bq/EbLCTeN6t7AdLm/Spvd7tQulBwcass2+4=;
        b=ZwQrDrcwyVBB3XSHzd9tk1UidF45MXtL4sr1Li7vfcYJQWAXWN4fekg46oB04LNDu5
         ah3lyCJeRJXXWG+loOj18OnmkiCU1FbvQHlSyAi6QJY9y35ce5BXsV8qiCrrGob16L+b
         2oTTdet1ViqCqJwFk0krx8Z1DvYoxXOcTGA5q5dcbwZXFBrXXWgXO2zCdMHB0dqBnGpu
         goZ2m0ehYe45I27NLZHVX4XEUUVW7ZrQ1XlNOmNuzonWpLmvCSCg2maEPymZGwgjKut9
         AatllIpBXjuihCjOdiRO7IILxvCmJUl97j+I8m6E9tDifCuRmEAaXval4TVsP+8yboa0
         CXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717963264; x=1718568064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UwQ9K9bq/EbLCTeN6t7AdLm/Spvd7tQulBwcass2+4=;
        b=BsL4P6bjdW4YTmL+dZTw8+HyK3ftG0hGNJeKIcTzoLvpc+mYuN/Veype/wcJkpTmkH
         anDeg/Wy0IxCgvWAGdwdN/viyYNmldVrnk2sUP48Y+IiDg1cpgCTQuI/2dhd7SWRfV+a
         5+6sfZDyxCKieLKurBIctrwjM4nqw+RCXv3tdQ6p1MBCsD4f3l4fgXjj6Lqt0un11tt+
         g89Z7lbrWa34s+L/Kf98pizAHoNa6Smko0MM9d2AEGJUpnJgFyXw7C7PsCNiMHPigE/5
         jdGnFnVWNERBqTMFtLyRIOdMdNTihDnuc2AWcFNAdrQuB6qrN8aB/MmWOfp8BaOvjYy+
         TwMg==
X-Forwarded-Encrypted: i=1; AJvYcCVeC3Iki8epmgG8/WSNHOUBtEg21xXC2w7uQR1rmpZ/Fc7vqDngrCjOXm68OiAvF8VogWFFZ1YCgapcxZpAfDm55vvw
X-Gm-Message-State: AOJu0YwfywZoQJQajY3dyLy+vk8ksllZgtgu9WSSo4BMn9KxEdQoLIMi
	/wg9VBxCxxOcVM794U7NfOst84yTssy2VZynjOOYPKYqPzIw079ekHf4oXkLv3Q=
X-Google-Smtp-Source: AGHT+IGoA6fPWEhhJYTofVAqZm23c+kwAeVyZ5il3Kra1TizxA0D3+wkQQfgkq+bYK4OFo6uonnIcA==
X-Received: by 2002:a05:620a:28c9:b0:795:5dbe:8724 with SMTP id af79cd13be357-7955dbe87cemr306240885a.18.1717963263719;
        Sun, 09 Jun 2024 13:01:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955b9b88acsm108130685a.1.2024.06.09.13.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:01:03 -0700 (PDT)
Date: Sun, 9 Jun 2024 16:00:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Kyle Lippincott <spectral@google.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: MSan failures in pack-bitmap
Message-ID: <ZmYJ+d3+j1E08Ms/@nand.local>
References: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
 <20240608081855.GA2390433@coredump.intra.peff.net>
 <ZmXKzJ9CpbYTmTwC@nand.local>
 <xmqqmsnuaqus.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsnuaqus.fsf@gitster.g>

On Sun, Jun 09, 2024 at 11:55:07AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Unfortunately, the regression happened in 795006fff4, so this is in a
> > released version of Git. But this is all behind a configuration option,
> > so affected users can reasonably work around this issue.
>
> Can you elaborate a bit about "reasonably work around"?
>
> I am imagining that you are saying that the user can say "do not use
> bitmap, because it may be corrupted due to an earlier regression" in
> some configuration, so that a corrupt bitmap data is not used to
> further spread the damage, but how does a user find out that on-disc
> midx is broken and a workaround needs to be employed in the first
> place?

I don't think the issue here is a corrupt on-disk bitmap or MIDX. The
regression that Kyle reported was a logic issue reading a
ordinary/non-corrupt MIDX file, not a result of some on-disk corruption.

I think it is possible to generate a corrupt pack as a result of this
bug which would incorrectly "reuse" parts of an existing MIDX's
preferred pack, but the result would be far worse than a corrupt MIDX
(which, again, I don't think is what's happening here).

But I do not think that repository corruption is a likely outcome here,
since we only do pack reuse when packing to stdout (i.e. by passing the
`--stdout` option to `pack-objects`). So repacks (which would otherwise
be the thing I'm most worried about) are safe: repacks trigger
pack-objects to write a tempfile directly, and so `pack_to_stdout` is
zero'd, and we do not allow verbatim pack reuse to take place.

So a doomsday scenario whereby we'd write a corrupt pack based on this
bug and then delete a non-corrupt pack is not directly possible via
'repack' alone. The lesser-used 'git multi-pack-index repack' is also
not affected, since it similarly does not use `pack-objects --stdout`.

A more likely outcome would be if a Git client who was using MIDX
bitmaps, but only doing single-pack reuse tried to generate a pack to
push to some remote (or vice-versa, replacing client and server/remote)
which ended up being corrupt in some fashion. I haven't had enough of a
chance to determine if this possible, though I suspect it is.

Thanks,
Taylor
