Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA926E71B
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956110; cv=none; b=pFP85XTjez5lFeqeB1qC3Qms82DYLlE9B032gkhbsxPXXAwPh6ES7Ak9gFo1goqh0vgv0NCcV7wnW9h0sCMfoyVK7YZ/l7UhB+D9XcXdQiY8XVA6WESBbjXU2D0Mq592O8MG9wxebXET5hjYOeC5tQQKQ5dV6vpBm6lId1rlgeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956110; c=relaxed/simple;
	bh=KKgaTa+TUXHT5vClmHqKU5VSr7ZuHJil2gr3KkAzQxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BElHXAP3DNu0RXZkGyZD4++HqGElFKF5Vg4r0sx39Q+ZI8oLpEOKFtkRZAFUdjVtfoAqFGwVBPgt5frfIygiZS3LYX6vNdhuAgRqRoCt4hli2n62Df76E1Elme5qruEUmWwEBtSlke6lRq0cQFdLC++jB+ha7sf0fGQ650CQe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFf/zh96; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFf/zh96"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74a61973bedso4203664a34.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757956107; x=1758560907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFT76iaCOQcigCnSqH0Fkw4oxGNaxF3S7K2m7aA+BAQ=;
        b=IFf/zh96ex3fw9Inc6vljahR8O2H8TynLi5O3BYI/oelXiFVUyZBE+gy3FnuGjyzF3
         fheRFqtKSrJeS4W5w9GW91ygNMsDaMHuK3/F5B4Q/2hHCV55Nqb9fzzfdybG85TrLYCd
         m4Sgr681SyW3nF5HNFvBSK57HjtgNGHqgUYIUNGnkR9goXI0dQ25OZpmKeMA7X+6Wypw
         +I/qPqvaVaIHZYa8jmmbA4zKo9eGsgLD/pq7VWBterwQclgieOyDU+dQfs54qFaRXhix
         sX4inWNGPrNQDxgIrE1+3MtVqaotKFY4NktzjAAKPQbnIxa2Ps/U2agO8GYXYmavTX7B
         OY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956107; x=1758560907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFT76iaCOQcigCnSqH0Fkw4oxGNaxF3S7K2m7aA+BAQ=;
        b=LlYAImZI8u9Ircd0h5pMiX54IsHvnmQ0eIJ5h4A0T2mrZG/xDmcW9eYktvnBeT8E4g
         BD1rwD4qzcyTOgX3S9o5v7PdWQZ1wu6dHDwR2PevHPVPWRH8KGxjvWbzsrCEDZIzXqiI
         BBLHlWolNUZ8x/aL8OTPQTevgx3JpLxkQraCihmknNPmMLYl7NKE7wU39SGfbbW2TDuZ
         gtmJL6twv5XS+eivzbgcuvGuzOTn+DeClGww31e1hhA8ja0as2BwAke8JC6COfAki1EK
         ycF9wouhIntnmvTWyy4405v0nRFdWio3zXxRYRTA9Ew4H3QjyG41R9+tFGuldpGDTwoz
         /xcw==
X-Gm-Message-State: AOJu0YzRf+6GdktpY/V36I06gx694P3K0eHBKRiWmgNVDFHo+xnCaZtg
	6XKAXlQqqDjgPffm+xHQKuItoERu/Q8zAv2Ab4Qvg0rV5TbjV9ONgK1n10OJUA==
X-Gm-Gg: ASbGnctGA7hJmiaoi+nIBXESH64+DITZmMo3uYKs1Ehvr0mFLwGr9NlJ4p+iRyBpVz0
	SxUTpsXwUQZ7SgL0YFScPZJ09IcCFIZ5RMASCXqaflMG6rzpxFVX9SfH+1BTXlV7fOwNwz+Xz5G
	yA79i9sgWrYdtpWdaWwEhtgx4xssJrCwvF5D8VdYtapYS9FKmUjy2gZvESbX7DGJfSJB8zvyRhP
	leVqC665vOL7HZX61ZPr8VklHcGp/9iTuJ25Kfu48YRuWRMjaGlsKJqegW0+uUoKTqAZsTBNj77
	ZK35h+SJAOrL6I26IFxhyMXlH/67aIuu7sI2mJYmbxgNHZbHPrG5tdCdN4M9vJd/afbko/KjPn7
	dQB2cqJANvqo7kziVNCPlBYTG8M0=
X-Google-Smtp-Source: AGHT+IHEIKLlaZGP3ECU7/xcjLDxVbZCZFVFCTr8EPm0QDsRG24ZXI1cReqjP6bHMsYYzqm9rIdAOg==
X-Received: by 2002:a05:6830:6689:b0:745:a08d:cbc8 with SMTP id 46e09a7af769-753551ddea4mr6837389a34.24.1757956107103;
        Mon, 15 Sep 2025 10:08:27 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-62341c04af0sm513631eaf.22.2025.09.15.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:08:26 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:08:26 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/update-index: end ODB transaction when
 --verbose is specified
Message-ID: <273dcsi6xmsdb356adxrlhh3renuimnl5wopfzkxxnryi5fmwd@xud2pvwdz57g>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-3-jltobler@gmail.com>
 <aMJu7vPKfnxt9UiC@pks.im>
 <3cmqsfz5j2h36mw7yzwbrgfgchaettcnidvkiboqqktkm3dd5k@h6rmgjnqdmq2>
 <aMetaZxCN8CDsr6g@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMetaZxCN8CDsr6g@pks.im>

On 25/09/15 08:08AM, Patrick Steinhardt wrote:
> On Thu, Sep 11, 2025 at 10:34:42AM -0500, Justin Tobler wrote:
> > We only start reporting updates when the --verbose option is first
> > encountered. Options are not all processed upfront. This means in the
> > follow example:
> > 
> >   $ git update-index --add foo --add bar --verbose --stdin
> > 
> > both "foo" and "bar" are silently added via a transaction. After the
> > --verbose option, subsequent updates are reported. At this point there
> > is no reason for the transaction to continue as all subsequent object
> > writes must be fully written before being reported. Thus the transaction
> > is ended early.
> 
> That's... huh. I really have no idea, but is this design intentional or
> an accident?

I think it is likely that the behavior of the verbose flag here is just
a side effect of how options parsing is handled by git-update-index(1).
Instead of just using parse_options() to parse the options in one go,
parse_options_step() is used to handle filename arguments as the come.

Looking into this a bit further, I originally thought this was so you
could do something like:

  $ git update-index --remove foo --add bar

but this doesn't work because as soon as the --remove option is
encountered, all subsequent file arguments are treated as a removed.
This does mean though something like the following _does_ work:

  $ git update-index --add foo --remove bar

This is probably unintentional though and rather awkward. Due to the
nature of argument parsing here, this interface has several other order
related quirks like this.

Looking at the history, this appears to come from 309be813c9
(update-index: migrate to parse-options API, 2010-12-01). I might be
missing something, but I'm not entirely sure why though we need to
process the filename arguments as the come instead of waiting to end to
process them all. We could explore tighening this interface by updating
to use the normal parse_options(), but I do have some concerns though
that there may be users out there relying on this quirky interface.

-Justin
