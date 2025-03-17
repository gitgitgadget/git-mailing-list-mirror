Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A6B204F7E
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250231; cv=none; b=hFKUhrTMJDeqVctgWc+WweZEvhTaucwh/gfdHPC0vK//yOTvbeFB1kI+avAI4pt4D+33Rui4BkEqssR9r3WCUcjrtR7JG2KWZsQNswr/vV5GZE4I/lB4NuGpbz4YDGXfQD8ukmeO4lkRxZltBLShT8vOv1qgE4RpwAr57FU/eBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250231; c=relaxed/simple;
	bh=l5DZv81jftm/SDsWJA70quo114LSnDdEg8GTa1Vw28A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3+QDUCWu7Ik1oOPnVDsE/ushat4oDYbuDW8nmINlrGC7FmAeF+uFEPpg/U226a3QHIN6sC+UGo81+CG4JIeh25WRoEZSqFpGs+5tIX72luCTyW8n7SQZE/1dcgvh7hPTHVDAdx7T23GMkXX/QhjjEd7XClaI+zKbH1uH136U/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JZVXjpA2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JZVXjpA2"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47663aeff1bso37130431cf.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742250229; x=1742855029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G79DWwCI4HK+jW8dyj03FkDndkfAxSju/RY1wtATKVE=;
        b=JZVXjpA2KSjPHw/jp9qmgGIYTyU2+PWb8om5BZaGLW6irIK3kvjgBjmwhBYwReBsIw
         hidYYN5PueQkOpn4JDzE/xAlzBeyK/r/Vlu33bfou15TRjumfPVde5ckfsCkYnEBCrUB
         kJzT7DbsI7wviuNnelmTFz9MlyqWUIdtudmSLHtDf5lgSmRPvZsiO9xTrbilcJT7lJ/U
         Fr/c3V+uSGEPR73DoUhe5+SfxRniN9zJrtYY4d7fRh6bSuCW5AjYxn3GDBGi4VDi+1k3
         HCzHn6R8JOftGu7fgCM/DDGH7f4zzIPNI1+uapTrSdXY9+sqwsGlfve6OquCz0uH/E0T
         nhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250229; x=1742855029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G79DWwCI4HK+jW8dyj03FkDndkfAxSju/RY1wtATKVE=;
        b=WrXW5bWdDkH+U5cFFnHGpCFAx95B0vA+BdS8jBKG2k651ZNl5LHoGpBTbioWVFT7Tt
         hxrkY3/aVDwVE4g/CmQRldHVKWhLnYogMAuQmdyKLCIh6whRkd58oF0HFyCIj6bOU3Hs
         5oUV4+hCB8TAcPq/fj6XITDyDmQiczFCPWmj+rRLTNhuL5lsjdkWvooKb5nXt8BkEvuR
         agw3xigSN/k/bsdcLL9wMe78FIhQsgvxOItXAevgOSWbxxUM4yKkK+Y35JLqaVAmeEkv
         tpwGmSPYIZs24GsI1omQ4VUbpwOGOhJP/eCAx6eMrd4YPrSAawrZIvouZfq0LDsgqF4T
         dB0A==
X-Forwarded-Encrypted: i=1; AJvYcCU6pcdbbyIq6LHuEWgCZE4R7vMqTJpXHuJjUcMvqV6BY3cyaWBv1SAAjGe64t1wqqFyEPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpEXRBBpZnGUYJcDh7zPGCcn2WRDKy+hNzBcHVSYtABazKOXp
	shtHvsz0L36Vx4PUtYJVNX5M2lhcyEXRzqLOeqZQaQ6BixCUljxCUdt2ARrxbc4=
X-Gm-Gg: ASbGnctw2iOo2JVWsI0XHawaWUjz9rOwMYx+YpUV6/vLkJulWd57oo6WAsz8bq/5+Gw
	9J8Opl4VVOtAmgatnIuu12y2hDj5RYYSgcQzOPds9hCOcdgeZHL1YetZM15oaw3BN4raob+1649
	vf0ZkV1vIe7yEb0fiwXfm5WfB/eec1mZF5eWPZgkbMC80v+8f8LhhjPTtk8T7r0ySL5ORYmsQMO
	zYtsxh3s6Ll4ypSMENs2WwGXCUU4T214R1J3ZtXs93oUwkUWoIEVdOk2smhB0RhMT7kMCe62FDR
	dhOcku7iATHhkRv9Z/T41Oc7Fs02wqt/OO4SWcWXwM2Q+D7jejEN7yk9kEHJHp3v6MjPzdzjGy/
	B/LYmBLq/yKONMH8i
X-Google-Smtp-Source: AGHT+IHQp7iJNl+fkjP8r+gjngN7e7d5tWlBLoVckJMt6DKPsZctgimmUBjUtmkih0v6C6IuzdsbDA==
X-Received: by 2002:a05:622a:2305:b0:476:9483:febb with SMTP id d75a77b69052e-476fc9b4b88mr20202841cf.29.1742250228996;
        Mon, 17 Mar 2025 15:23:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476e1367676sm24294131cf.13.2025.03.17.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:23:48 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:23:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 6/9] fetch: ask server to advertise HEAD for config-less
 fetch
Message-ID: <Z9ig8yuQ/lEOgRj6@nand.local>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030847.GF2334191@coredump.intra.peff.net>
 <Z9H//JHtYTGqHI3n@nand.local>
 <20250313054644.GF94015@coredump.intra.peff.net>
 <xmqqbju5ru9q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbju5ru9q.fsf@gitster.g>

On Thu, Mar 13, 2025 at 05:26:41AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> >> Any reason to use a bona-fide "commit" here instead of "test_commit"?
> >>
> >> Not a big deal either way, of course, I'm just curious.
> >
> > Nope, I mostly just reach for "git commit" without thinking because
> > that's what I naturally do while debugging or exploring.
> >
> > But since you asked...;)
> >
> > I do find test_commit a bit bloated in general.  It takes several
> > commands versus one, leaves cruft files in the working tree (that you
> > need to care about not using again, lest your commit fail with "no
> > changes"), and by default makes tags that sometimes cause confusion
> > about fetching, reachability, and so on.
> >
> > The one thing it does do that git-commit doesn't is increment test_tick.
> > That sometimes is important (if you care about traversal ordering), but
> > usually doesn't.
> >
> > So I dunno. Maybe I am a bad person for not using test_commit by default
> > and we should have a style suggestion there.
>
> FWIW, my assessment on test_commit exactly matches yours.  The cruft
> files it creates are often not what I want, the tags left by default
> are even worse, and the only good thing about it is the tick support
> but even that does not make much of difference in many scenarios.
>
> To its defence, I _suspect_ the automated creation of default
> changes were useful back when there were no "allow-empty" support.
> But I think it outlived its usefulness.

I don't disagree, but converting the 2,570 instances of 'test_commit'
that I have in my tree would be difficult to do without disrupting lots
of in-flight work ;-).

Thanks,
Taylor
