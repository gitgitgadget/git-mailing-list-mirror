Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD0F1E0DBF
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545774; cv=none; b=MtJsjiBoKdPr0byWbMmHCELCk2MEj7UnIIVL0B10qiGolHYP6foLcHV/keyvl36i8486yLIBLc4Ecmuk0doBo5Mjp05R99U09aAaVSW/YPy01a4Tu1rIxyy3my8uNF0Lqv9mNVEwNmmRQGr4BGIauPNbMvGwcXqx50A1+INTaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545774; c=relaxed/simple;
	bh=mSZjrWVBCO8LzvrV81L595fI8A15WY9qcDhhJ2SAON0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtJIJ6Y2GL6xFqW+Atv2TjdZiHUrTbDrJfJyaddRnFW0YOT7uJYP2pwfH9yEUIcHtsOC6gOm+8uvQ5Ibq+BRsTLN7UOIitrGoRGSqAkghY4qig57XdfSFVwntgRE4VcFJNUc8D5GHAFqxfEQ/ksIWT/GXD1uotMjn4R9DSwhp9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=c/6oDgLP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="c/6oDgLP"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6db20e22c85so42488627b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729545772; x=1730150572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uRizya4Sz0hyhJS2osZRzi8UoDCN5XdcqjqNVCPYNi4=;
        b=c/6oDgLPZeLTylbVcV3fMRXe5XFQp7gMPihaMppznLB4dyCQi2T3sBs3sq7AZ92zaZ
         Ubcc7pU0MD+D8raC/4J68zg9ra2pawAUtKRg8nQJThfsqcEsL6VG7XVe+cw627uAgABI
         X4dEirJlvp1ZTQxOFQfxiNpzlDPNfYwOFNmsDGllDxE9Ip0eYxF8fCRINJdsjiQ1CF3G
         tfnZCbcQjWNg/9/WfQDx6Et/dyx2pfSCKw6HgMCYbQU1H+xaXAI1WdZEMV3ECrSp0/3Y
         7vYz7sQPVbfx+OXkNGk9LMtUinzK3+ChBkf2Wf6qQ+dV21jiy0FetBIve33DyqM5piqW
         6t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545772; x=1730150572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRizya4Sz0hyhJS2osZRzi8UoDCN5XdcqjqNVCPYNi4=;
        b=cMLSznPFeMkPjjVKNuCznW4N+ZQ1RshdTubXk7jSqpBJtK0X95Bm1mytizxGH04sz3
         fN+Mwy8fJhge2s9YXt8TOaYXLaT+dfVFAGta/NEmgaKPjbZoy7E9g2IcpJqhLbEVczP4
         7qNOoGCm+qxIYxnQh6FSjAYyB/Op6TQp4kXjFV5MSH6hAiOXPwTd8ZjeJiRJAPSnw381
         E3QQQFWrvlmFNmUQtwN393KsaDrhECuQLwlGwniF+8kEEFqgk5cBD9/yzszaAAwoz5cO
         mcc6FlG6B+OBgUxigN8BKr5e/NmwssSFo8QHmMG2ta+UCkC7UksNwIeVQ9A8q577zdnx
         r7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Gh5DwU2JrmPHr2wJXLJHCus3EIoVeyNnQM86ONjQlyo/W9v4VEyC86/vT4K7xq9BxFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZFyP11e+LekcBydPThf9FNxCSMEGBI/Vw8IzzHKnr+0W/8ZG
	vx6sRFhDX/VtnynvMg8tgF7xkOArWBx5WitW8KOSmgblxaEKJRxHPCndV4HxBNOjcjvmyaH8jAE
	l
X-Google-Smtp-Source: AGHT+IH3elVzgTPnUYNG89IoyB++zsP8rej0drPrgUYNdBkdPFw2KL5djz+vrd+fyCoMKApF9Nl0jA==
X-Received: by 2002:a05:690c:dc8:b0:6e2:f61e:8c9 with SMTP id 00721157ae682-6e5bfd4ca84mr129344257b3.30.1729545772219;
        Mon, 21 Oct 2024 14:22:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f577bd4fsm8390177b3.0.2024.10.21.14.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:22:51 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:22:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Josh Soref <jsoref@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] SubmittingPatches: tags -> trailers
Message-ID: <ZxbGKvsrTdlxsJNS@nand.local>
References: <d3a1ba01104da8496d52308c07c5c274fd30b0c2.1729443395.git.code@khaugsbakk.name>
 <CACZqfqBnqPpngxkYPhokOPdQN0T6tH4Zuzwv_wLgFCnY9FTXLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACZqfqBnqPpngxkYPhokOPdQN0T6tH4Zuzwv_wLgFCnY9FTXLA@mail.gmail.com>

On Sun, Oct 20, 2024 at 05:29:14PM -0400, Josh Soref wrote:
> Kristoffer Haugsbakk wrote:
> > “Trailer” is the preferred nomenclature in this project.  Also add a
> > definite article where I think it makes sense.
> >
> > As we can see the rest of the document already prefers this term.  This
> > just gets rid of the last stragglers.
> >
> > Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> > ---
> >
> > Notes (series):
> >     Commit message:
> >
> >       “ “Trailer” is the preferred nomenclature in this project.
> >
> >     Must surely be true since git-interpret-trailers(1) does not even
> >     contain the string “tag”.
> >
> >     I did a grep in this directory:
> >
> >         git grep tags ':(exclude)RelNotes'
> >
> >     It didn’t look like there were any other mentions of “tags” in this
> >     sense.  Of course it was difficult to look through.
> >
> >     +CC: Josh Soref <jsoref@gmail.com> based on
> >     e.g. ac9fff2bf1c (SubmittingPatches: discourage new trailers,
> >     2023-12-28)
>
> This change makes sense to me.

To me as well. Thanks, both. Will queue.

Thanks,
Taylor
