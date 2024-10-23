Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2C154BE0
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714734; cv=none; b=iuRTZSexA8KYBGxMqdHm2uAA2e046sQWatNr3c5lqmJoutMQJly0NCBOGtVW791/Wz3TvWtu5y/pLWtogO5CSjS/Kvpf05yXFJfNBDSJCKYB3e3qHIW5NVpSm1GsB0aHUux4GflmmGruQge47VEBVywVPdfMsZcOFKwi3mPgae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714734; c=relaxed/simple;
	bh=8wwZ8hXWk4aJyR0ZJDdrakJjOTPB5RZqxEIqUWKy68s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtlE8JeC+FWU3H1JbCq0gIcjpvgJRHGHCBGge6OAsPDWHycT03eyHw+AXKlNmecCQn0vHvF2BJRgJMzkW3O4iPjBIElQG3o6D+oILPJSdd6Aj/acJY1APZ6yPUzBLUayN3FywhP3rwksXmbDnAP7yAjCTopy3v8C5UinZs0rbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zHjKEpKn; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zHjKEpKn"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso232556276.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729714731; x=1730319531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQNgVV9/mf9DK1tEVSlGK2zzGn15G95TyDLyHlBSEvc=;
        b=zHjKEpKnW+pjlibnQQvjg88OV1WKcNwhIycZsa5W1ssu0zJ+5/ZOg8kp4wqJtAKp5p
         +YI7FRg61R89WXNpp0GfYfsNnvF5PI6dB2CQiHIu44FdKpnxT045FJ8iEsAxhIwvaYvx
         3vLrgIWmLyZhxkFbO5Qwck/v5syRjL7Wfu+txvz8Jf7nBIt4sbOfBXD6EF+sThAMXoNO
         a3+vU+K+11TCf25PlOkL5kyn9LUTDWNFl9Ylu/Q0TgJFR836wIKoImONdPylU5RAZWPz
         /sF5Qp7ctmR5u1KFm+BMkyG33FDaMsVgsnsIpSDjWQTxw51bJoJB9RJ6bmdC0Ax2My8C
         sgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729714731; x=1730319531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQNgVV9/mf9DK1tEVSlGK2zzGn15G95TyDLyHlBSEvc=;
        b=vhPhJRCLP8jzH2XEKLmFXtaYlCIREfSd+cS3oXN1AIUDfoLDOoFss/FKcZd1902eCh
         fsxVjkLU57JtszXNWHLkJ38za8cP980m//eAKUD1J1guAkQLtCmAk5yNPP5aIonzpMMW
         qf//HnK/0ZEvMNtRX3JuY1CfDpE/dVEPS+awNy1WSaNgQkj/9RvBX98JU15kUaexfGgY
         EJ8tUZLaIvVy9fifAjvX6mCVvaUV2QReDMF9n8YTyzKqLhnRniMZvEdXjuT78tcOeqWm
         mZaCwrItvHnCiNJy97OEzcxZmKujrnw+77ONEMBk6tnW5Ap9hFszd8wSoD9py1lBSNB+
         3qjA==
X-Gm-Message-State: AOJu0YwznHK3dCM36lCQDDu0myrj1lWlwM23bQntjSFhT/YjU3fjLRl2
	4semeKO2hfv01g2SX663adivPpu9aoXTMBuQfVXo0dORqZ1ZGY2EjELR1xZGhzz4hRgzMjq6R54
	oQPg=
X-Google-Smtp-Source: AGHT+IFKGHDozf/P8XzbeDeZbe+S7tvvODsRF6/f/Nu0MDQMZTZauFrCiPyHQkDctY8xBk4OXyjRnw==
X-Received: by 2002:a05:6902:1602:b0:e29:1768:8c2e with SMTP id 3f1490d57ef6-e2e3a6e5cf1mr4437689276.49.1729714731547;
        Wed, 23 Oct 2024 13:18:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc992c0esm1680000276.23.2024.10.23.13.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:18:51 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:18:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #10; Tue, 22)
Message-ID: <ZxlaKsIfh7KsqSaH@nand.local>
References: <ZxgUocb5gH+zuKRw@nand.local>
 <ZxiU1mw1mbRaxoRO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxiU1mw1mbRaxoRO@pks.im>

On Wed, Oct 23, 2024 at 08:17:03AM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 22, 2024 at 05:09:53PM -0400, Taylor Blau wrote:
> > * rj/cygwin-exit (2024-10-18) 1 commit
> >  - credential-cache: treat ECONNABORTED like ECONNRESET
> >
> >  Treat ECONNABORTED the same as ECONNRESET in 'git credential-cache' to
> >  work around a possible Cygwin regression. This resolves a race condition
> >  caused by changes in Cygwin's handling of socket closures, allowing the
> >  client to exit cleanly when encountering ECONNABORTED.
> >
> >  Will merge to 'next'?
> >  source: <20241018052952.GE2408674@coredump.intra.peff.net>
>
> I think this one should be ready to go.
>
> > * sa/notes-edit (2024-10-21) 1 commit
> >  - notes: teach the -e option to edit messages in editor
> >
> >  Teach 'git notes add' and 'git notes append' a new '-e' flag,
> >  instructing them to open the note in $GIT_EDITOR before saving.
> >
> >  Needs review.
> >  source: <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com>
>
> I've just reviewed this and think that the topic is ready to go, as
> well.
>
> > * ss/duplicate-typos (2024-10-21) 1 commit
> >  - global: Fix duplicate word typos
> >
> >  Typofixes.
> >
> >  Will merge to 'next'?
> >  source: <6ce47185-690d-415e-95c9-06a3b828be29e@cs-ware.de>
>
> Looks ready to me.

Thanks all around. I'll mark all three of those topics as ready to merge
to 'next'.

Thanks,
Taylor
