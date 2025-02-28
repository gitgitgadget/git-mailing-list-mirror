Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE123CB
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701793; cv=none; b=jG2WlAeXswxdWHTFN4F83qie3WbcI8307P6OpmzsN+Ln4Fi1xpFI0kZNIROqPCht7/+7AjqIHIa7M2/BvsrBZiCfj9CPB6xqOA8NtACwJwOOVAPUtjsnXkUTGMuc27CBoa67lBZrF3IR0pN7e02nEE+rvIZ9uV7I1iHtg7IDqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701793; c=relaxed/simple;
	bh=lz97alHdbbI1BDB9Ho/OKeQfrkAAcmgu3jvdobfq3gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRSgwaaxDuoCdvqZxVzlq+GmprdR7VvUYHABFfEb06X4xXso94uPyK0WFIdNZjJC33nPEK5dz/YaATT61N6+P83Zy/PZ0Tk1BilqN9ALXgMfojhalyLJ8tfxSKXB4c25QSBBEUxH83K6IPXeSfB8A5RobNjbg78bJWw4kwCL728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tdiX2avC; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tdiX2avC"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6fb7d64908fso14770727b3.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740701790; x=1741306590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfT8NQRWuFSQRqFyUQgunbhZMgPVKndOr6OeCisGz50=;
        b=tdiX2avCLjwWTfwkUYrTweKgTlSEQGekdz2/+g5bDOWbOk3woEOIrqFTwScsp3CRZm
         umdcuKXLhU3cdIPhn0sYPX8LizYEUohBrg1FmVzdb9uygnq2X70AXNjFtGh7vfy8igYe
         e6l14oODX+nR21cJ8Xi9EXqhvIcXG0STPgr81f6+XEqeu76vHNdoVVjQ+nGokJm6oFLl
         LIefN4qNQRsICW6gvtQsLtSSYEcHijbIXvyIYceLPiy2ZYfznh52XKmxCcf+LxXGJSyL
         e7r5mTyzVCxsEbwnNOw6DhQ2BCHAV52MXOYL7vWM9POtTg5iPybMwnZLqaI5vO94hnRH
         xvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740701790; x=1741306590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfT8NQRWuFSQRqFyUQgunbhZMgPVKndOr6OeCisGz50=;
        b=Zq6DFUUN29qXtJaHXNSYmyyIv/THKN5KB4E2ISepYUEXWQcCH1/S/rIXsYJLt3uvfX
         K1nlBHC681FKKr4+9m6qy8RytqKYCrpWB5f8JLGTl3tLl8dKLkzu/ovEP3zaOHHueeJS
         Eq6QiyJYORicu+JiORuIp5pu2W4H4LPDuHbVh0gsRl4aDW9h73PLMR2M7H43bo+dso0r
         lCp34nc+XhtW7l6hApg52AJkgqss/aOfr2dz3DvJygydenSV7GdsVKoWfwpzuz+FW8tV
         XOeJ+4pFxAr/l9L01eWTPBzfXABM77yxPGK4bhyma9D6GKqCjQIuB4ZSQkSSL3hFZbv2
         1tUw==
X-Forwarded-Encrypted: i=1; AJvYcCWjYTYs8Uc+UX73/BoJA5hchg1UskaAapZUO0Z2L1PixKnEyEidYht5WBDr/5cZhn140Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjfRHzw2JrWq73/06u0YVzxpaC0YDqNSDG8riN+regHLZcPfY
	t3nxU6JXXwjhNolGwdNPStm2hw4DyIO8SvOD+0l97bPJ3l0lcTZ4fwIuleauJExYLE943xfa2la
	c
X-Gm-Gg: ASbGncufU63bUa98Dqpjg1KlV028KWSnMsOK6mTgKce/QF3B+/DXM/sQnnUeNBPnKip
	OVjto6UsG3CU9rluKfNJW8dR5YnhK3OmETtVpJz6zHoScwmJQ4PsQeFbzFsHfhnPDgqCpTbg3Ep
	kdKnnIs1wM0b8GdiN8VPBMuWIq6/2ZW/TPiQYrFlidcoA0JkaQkY0tBteSt5m6MKusZBYfS1UBY
	ncvyC8NuzDQqnipXvdKV9RD5zEXuiNg4QAAnUKJS9bGVKE6YjnXvKs0APiPLfD5g9NbsGXQyjdQ
	zgyNZ9nEgzfvx6oJsMskZDDqzq2uYV4tyaR7wDTC0rKvfseQ7CkgxxsEscgF/1ti+5+If5okNA=
	=
X-Google-Smtp-Source: AGHT+IFskHTC4r4+4Nl0E+6nGEYsgyA7C7QJgRb6NdQC12AKWwO8q0pIqwva4tF9oGU1xhPaxi5SGw==
X-Received: by 2002:a05:690c:7487:b0:6f9:8b50:bac7 with SMTP id 00721157ae682-6fd4a13748cmr17951517b3.29.1740701790253;
        Thu, 27 Feb 2025 16:16:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca6a886sm5142147b3.64.2025.02.27.16.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:16:29 -0800 (PST)
Date: Thu, 27 Feb 2025 19:16:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 01/10] loose_object_info(): BUG() on inflating content
 with unknown type
Message-ID: <Z8EAXIHB4dVYS9t/@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225062824.GA1293961@coredump.intra.peff.net>
 <xmqqv7sxh3xv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7sxh3xv.fsf@gitster.g>

On Tue, Feb 25, 2025 at 05:47:56PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > It really makes me wonder if this "unknown type" stuff has any value
> > at all. You can create an object with any type using "hash-object
> > --literally -t". And you can ask about its type and size. But you can
> > never retrieve the object content! Nor can you pack it or transfer it,
> > since packs use a numeric type field.
>
> Correct.  IIRC, the "--literally" support was mostly for debugging,
> and as you noticed, is very much limited because it can only create
> funny objects that are loose.  And the debugging was not really about
> adding more object types, but was more about "what would our code do
> when we see an object that is corrupt whose type we do not recognise".
>
> I personally think the "--literally" should not survive the Git 3.0
> boundary.

It is quite useful for testing intentionally broken objects, like
commits with malformed author/committer lines, or trees with
out-of-order entries, etc.

Perhaps we could replace that with a test helper that is only accessible
within the test suite that acts like "hash-object --literally" and
remove "--literally" from the plumbing interface? I dunno.

Thanks,
Taylor
