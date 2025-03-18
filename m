Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461C85626
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338051; cv=none; b=RrVNlVWA1w37JoHqQVS4PH6pyMn4xe1fVXJ4ErwtFB1urDaC53pEdFH8QZdicH6cqx9hxkPD8KBhj0+TY4lFTJn5FzZCt/0N2yu6gPUXPkV6xLcjBDS4t0cV5/8vr/K4bCXe5pOhCktts2sTb3wzLGuPQGom/AdvOuEjguGnXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338051; c=relaxed/simple;
	bh=QKOvErqau86vJ5ZrGHkOFg8YPtUfPuRqMQfr/HWt80I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5cgxdtD/5nYFTMssZL8w3GHi9TOEm0Emw0u3dlHBAbhDLZKq8Ylq9/Q77zM3oQIrblBkZk5ov95mx+8eZOP6Nx4VjPW/SjPQPWBzI6WXpOnKypVZcayijXLv6Sin8eblbUylH1+g/PsHz1Gy+H0USe2ZBJWPxo6Bn1aYZ0cbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Tk7ERjT+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Tk7ERjT+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c59e7039eeso158154485a.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742338048; x=1742942848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o65gc8xIW4+pPfx5UXWfwZhcZSro2aGpxAbbREyFbjU=;
        b=Tk7ERjT+/A+axcG26UIHbXtpKrYW+I3vloZC5LnGfT13Z4mgffDZDiMRDv3Z+kTR+B
         Z2WCRlvncdb41ySXBTDrpFrKxRonZUHHecaGWl+2Xt+agGOvLqCabTViHNunbr6bbkW+
         gUWHTBV6f0srfaxJUEKf/y61z9IzENva/G0wscaUN00B0C9Z2qmlghApqQnYrM3cbBpq
         VK84EOfnFSZD8/3dvKYTAP5JuJ74azAk846CVa49/KKrtc+QevzxOHyjfR/t59WVS3r1
         KURVP5aK9CPRc2cKLV0fiaI2xukMeyu0ZbfHA8wHRf6OxIU56nYodkL1qGMEXurb2bXt
         Qg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338048; x=1742942848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o65gc8xIW4+pPfx5UXWfwZhcZSro2aGpxAbbREyFbjU=;
        b=u5AhtRiQO3ldmxZdh+OJQG6eKaYcgoa4APbx+dngY1asypuJWNWDJAVz9VzUPkO+rE
         +0FFfRWyk7yuYtdEMIUpyBnq/wwqxJfHA+KPulJf5CoIxQR1lrMN/K6zAsm8fNalpwGl
         9JObesAavbN8ZLeeAozesTWuMOLJPrPUTJXA8BC5Nij/G2lQqiaodzLbO5wTElqS84MD
         BOKdVQDci2vtAmbivdJAYnI82IcDhob8Fot37JcrnyojT1I1qApSIhMafKkHNLI4UPDL
         0f8HjO+lnyjXUOBYvEjMjh1ilFtjWRwinQxp2UsYMrJCrhSzk2Z6Am8iMVLaVAiMfyS+
         C2GA==
X-Forwarded-Encrypted: i=1; AJvYcCXHrNE40DQFlB4TP7B4GUWLkLJue2kvFSraTyRNPcy0aeMzAJzVGlarIAKFK9WhDwBXkxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOfS4Sn7Ojo1AMDL8Oekcvd18YEzIBao0uhv9+/+o4/qrzAgOM
	8aKYtA/8zUaPaRADBg9AaiJZftHF4QZWrfKWWbjCsuvLeeIZvQx6WoP7jH0uVg/Gia/lY7r1OW7
	Coho=
X-Gm-Gg: ASbGnctr8SZq/sC9Ps1Xt/UOZ39q94rTEV4y0q5L88yQkFI2+qRIgOdaSpqKos2rFzq
	Q5TdqSSUF07I7cy+YF8QVx+02lRhnbPMzZP7y/a5u5GwJ3k1hYJSz/XqhcgP//P/9Dv6LPGgt08
	EQodlJbv0XAsZwX24bfQmxBAzKMUBMem5OP3OAICXYKHMFuDM2Uqm1tYLRpfq6riC2U+MBJa44+
	pZtNqnYwX7gxj2ev4QgN6hMI6zzd9kgLIKVwyMffXgEQ+/B1O4heDgPGeXM0D32wDMQHKIA3di5
	6W/muxpjnRnZMbNz3kuJkzJ4cP+NTWSIDlrpiGLGPfzKJPGsYLnFdf9FbFZqF1cu6mzi2J54v1/
	0eba7XhQYYDzeYael
X-Google-Smtp-Source: AGHT+IGGSCNOQ5g1Bz5pMbUH5FqhEWp+pP8D1dr9rjA44JzJC0y0Y8ZN2UTRC7de7NgU+acE2Xxajw==
X-Received: by 2002:a05:620a:40d2:b0:7c5:49e8:993b with SMTP id af79cd13be357-7c5a84ba628mr59391685a.56.1742338048286;
        Tue, 18 Mar 2025 15:47:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d89cbdsm768147485a.107.2025.03.18.15.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:47:27 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:47:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 5/9] refspec_ref_prefixes(): clean up refspec_item logic
Message-ID: <Z9n3/vLYNALHnbSN@nand.local>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030706.GE2334191@coredump.intra.peff.net>
 <Z9H+vWHFkATWNLxt@nand.local>
 <20250313054107.GE94015@coredump.intra.peff.net>
 <Z9ibhJxjlc2DxKdX@nand.local>
 <xmqqplif5jfw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplif5jfw.fsf@gitster.g>

On Mon, Mar 17, 2025 at 04:25:07PM -0700, Junio C Hamano wrote:
> So, if we can reasonably expect that the choice will stay between
> fetch and push and we wouldn't be adding a new kind, I think
> reverting the meaning of .fetch to yes/no and getting rid of
> REFSPEC_{FETCH,PUSH} may be a better approach.  If we stil want to
> keep the descriptive CPP macro, then perhaps .transfer (or
> .direction) that lets us choose between fetch or push?  I dunno.

I suppose adding a new direction/mode/transfer/etc is always possible.
But I think that it's unlikely enough to happen any time soon (if at
all) in my view that we should simplify the code anyway. If that changes
in the future *and* those changes fit will in the design of
REFSPEC_FETCH and friends, then we can always resurrect those macros and
reinterpret this field.

But I don't think that we should carry this extra baggage around in the
meantime if we don't need to.

> > , which gives us the "default" case in the switch statement. But this
> > really is a boolean. I wonder if we should just use 0/1 constants and
> > leave the field name alone. That would turn something like:
> >
> >     if (rs->fetch == REFSPEC_FETCH) { ... }
> >
> > into:
> >
> >     if (rs->fetch) { ... }
> >
> > , which I think is cleaner. There's no reason to rename true/false to
> > FETCH and PUSH if the field name itself is already 'fetch'.
>
> Yup, that makes two of us.

Good :-). I'll send a small reroll of the topic anyway to avoid sending
a patch that has a git-diff-pairs binary in it :-<.

Thanks,
Taylor
