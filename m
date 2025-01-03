Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB161FAC49
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735925278; cv=none; b=fVLP+ul2V/DH0z3JbiUSoV8+EulUP/ueZeiCBrBOdEq5GQu+zfDOl6SEYs+138gmc8cU1j3y57mn8p0+em3sV5ALLi3shIYgyE2aV/yNFqp4ev3u4m++zQhezxt1cGGK7+w91Wed0oT9gGUCTJp4ght63gpQeL+rTw5eSaSBAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735925278; c=relaxed/simple;
	bh=XEMImxRPZx4G2MQEDAKvcJFMwNqeQZEO/y34KGmntfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbkMz4lBGJTkP8Vz4sRCXpkZoOudI03yuCbV+Dd3tvl0cMqqtLQ0PI46dvxtc1kB2xFt9Vd5ZhUrn1TxAfR4SCnof2mXf6qj6J6Hm+KET88PmdvZS0pewVS7SWP5JyWJhtsoxVxWZ0psWMlZGv407fL/iZfH+Mw4qLaXQovvVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE3SPRUd; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE3SPRUd"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467b086e0easo64331561cf.1
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 09:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735925276; x=1736530076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XEMImxRPZx4G2MQEDAKvcJFMwNqeQZEO/y34KGmntfA=;
        b=NE3SPRUdBGQzBWfeI06iP3q+ibAWWg6RTWuM6GpTQGxGfxKgLv85bwodG44Msd+ao/
         XfLCOVubh8NUL6ZuF6cDzQsLCbev73OhQF+w2NGcWGuGC+cnURDtaEf+jxe4yvb9SRth
         3JPskv5/jUW+4fp0ckfmJkSE1yN2bRZWLS033o7qLQXYqlGcI52wRt1XcnGmbJMdq6sq
         5VGFuNA9j6+xqBbypfuQtc0EvKQbDBclLBluLG/Sx7BexB4cTO/ALtzd6UO1Cjt4+uZX
         4gtLBIYAiaq1FWRpc5Ol6QwiS90nPMUGQKXAaFU9kmULjjt7TRG8SlHDJpKOABB8mF3L
         wT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735925276; x=1736530076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEMImxRPZx4G2MQEDAKvcJFMwNqeQZEO/y34KGmntfA=;
        b=BMjoRphjXweKEW5HOGSUGbU3ThB/AixKL61tsQJmwCbjGAjONuTLBQCGK+iiToG0gE
         lc2rn3a3qqDWtsbIwfYC8FRsNB/V2nIKigKcgUnQu2pgAXlqFSAT/qnkf0MUZosTHqc2
         D/RSw54qUNCBrYS7486jlm3MWjh/mZcLWd/cwoafUhUSt0PSjqQAk2f5cqUrg28BBWdY
         sb7pNPdtnbEW7o4GJulFsXoUG79RkT6/jy8jw1Orbygr3RfP7lOfy+fjK9JhnMS2Jcwx
         ZXfbrDwetHIwIIJNFToyEm+2HrYnTxF7SGacmORac+nwWmtS9uoraFS1x0GKxzFYvogC
         8iwg==
X-Gm-Message-State: AOJu0Yx4+UIkNsewR3PQANQYOwHv2mg3y97Rzyx5YnaaUpxTLI3+M1iW
	TYh0jknq5pJt2krbwSkm/AVDHE/V62ZabG2Ai2CbwT0SOv9uoJLUfj/6acs9pyXLM491ZXk8yq3
	iwToLR0TzTLpF+7DfpRqJVlBb3gVN3nV1d0c=
X-Gm-Gg: ASbGnctDpRMVXdZ4fujO5peKOUih7APfBGHJBraDP1HTDsUqdI3QmBsF8xmHoIJY5vi
	gCL1uxXr4AFPKxA6Kj+T73SPBbaomSL0EWM0xoL2orDwksupTMHAQxejvPpwRYAZT9brd
X-Google-Smtp-Source: AGHT+IEAvKZFU4gYtdssgppo4IIXucY1g1L91rLpMmGrylvltuX+c4h58pu3JWZEIuoImHo4fRteXcJvpeLsvj77Qbg=
X-Received: by 2002:ac8:5754:0:b0:466:9738:22de with SMTP id
 d75a77b69052e-46a4a988996mr831861901cf.41.1735925276183; Fri, 03 Jan 2025
 09:27:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z3fM1bT2Z_0GoD4w@pks.im> <20250103130035.79376-1-matteobagnolini2003@gmail.com>
 <Z3fiREGwXdILl-M1@pks.im> <xmqqfrlzsw4j.fsf@gitster.g>
In-Reply-To: <xmqqfrlzsw4j.fsf@gitster.g>
From: Matteo Bagnolini <matteobagnolini2003@gmail.com>
Date: Fri, 3 Jan 2025 18:27:45 +0100
X-Gm-Features: AbW1kvYeCjc2eMx0xzg32U9RvSlwut2_RSDjuLUUeD7v1BixAny5PxGxIlIgfzA
Message-ID: <CADyPGv0T7Wwrf_FidWDtLGOH7A88DcisAG4-jU3eEax106XEcQ@mail.gmail.com>
Subject: Re: [PATCH v2] t7110: replace `test -f` with `test_path_is_*` helpers
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Fri, Jan 03, 2025 at 02:00:35PM +0100, Matteo Bagnolini wrote:
> >> From: matteobagnolini <matteobagnolini2003@gmail.com>
>
> This must match the author ident on the Signed-off-by: line.

So should I send another patch with this correction?
Sorry for questioning, but as you might have noticed, this is my first time
contributing and I'm slowly trying to learn the process.

Matteo
