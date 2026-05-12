Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA82D595D
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550411; cv=none; b=UEVwWIPkTx1fl+0Z5tUwsmbLc4ECr70XqdMTxvpnrIuuByaz7tXtp+LLXAMn5OQWPvO1zxg4UR8XXsWRDpmYBe3K7cFBgJt01dqhFKPhoc8OzKv5yn7TQBMpT7wJKyhO0JudksF90JAIKbLkTyJl1OV9h0SQtg7HyPNtjaHwQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550411; c=relaxed/simple;
	bh=vHdOdrLLEfBf6D6ZhqisANQSH4ZE4hJ1mPGdDkjYpbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3pwX8Luv0/i9gJLm+xIUdqkOf89nGvrzz3ZOTEkDGOUocBBhe+FBuIpXECbJXfaV07NBZms+dXnRKobEPcxeT72s7xktStLtu3cg6xIm7TKpN3UXVFkxJ2FycWCN65HcpML79mNPyJmxZYOEiVnIVPI4lwoQ3Y5S2tgE9vjWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=JQn1AIOW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="JQn1AIOW"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd6f65c781so44906227b3.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 18:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778550409; x=1779155209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32AFxVVmoUs0e35dXlH+ygnQr6q4xWKq+xPiNGUaSn0=;
        b=JQn1AIOWobRU+AAqgj0b6htFUAO0meS/JQvca8etayRyF3fwsdWuIeyEpSgajo4vyX
         N3HmYZ9YOUad46+oT3pZWjfAqYNMNziShNxn/OWtEyTXuchiG7vqtUd3O+qsSD9xUygG
         qfndzYvc7vzUEiD17E/8ywA36INLAdINVY1UtmsN7+DgdpmqlDGBu4dLgxoqh9Cx9YTP
         YNVZeARA4jz5xtqay7fonKTxYAY7/0A8C7now5LluaLU4vnnuYUu4r2cjRJXwezhDkmC
         vKqQlEGUQwoHUjifkgkvFw3FL9JyOmKkkk1AKRF/SlOUZB5y8PrI6lsUD1NRekMvUwxO
         nopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778550409; x=1779155209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32AFxVVmoUs0e35dXlH+ygnQr6q4xWKq+xPiNGUaSn0=;
        b=iLg8khe3So+/uL9+e6lAlw8A8nC+ZKrQ75IvYO1PfCOf6pWfdGrrkHMJoTKbqNPCpB
         erNisE8aq/FntNT8zAPW/qCsmPZgUHxhf8TeYKx82KrDxX/DicowBpk69XA84FIT8oZM
         tus7i9elTw3D2ihKoQBfO0uQ5SFbPnLGU5h0J7MO0gme4++37ZHWPtsGzoYZ13DcWGJv
         gF8WZRfhduS4TcaPndIvRGvdx+zbJEoZ1oMGDVzTdAniDJ2gIL+ZCmfzpMkFND1XutqD
         0CtKHLyOmiZ+FLU9fU8JoJblHQIsHMSIJptbuztD4cYJZ9DNRMcAfvfp7uR5u8qnWM9Q
         VEtg==
X-Gm-Message-State: AOJu0Yz1PPEtUiEjQNrBv6KbGHgRw9sT9RwPdjN9n+jYlpq5hJxQ1tQC
	od3o3nuatNWLk1BtVKA4JgOXICRtQ3MzpgNWgqRoC4rZFyPau+byvBf1c0ZXcvj1TPDioU4R2Mo
	Sl2VV0jakSw==
X-Gm-Gg: Acq92OFu9e/Up7Zyx/uF7uH9GWy86o4ARl7vZlL+JZhihqRQiQXViIu7Fu24OVI08St
	OXT6QN6ty2Bz+amfwZ7FVG0ePoYJjx2bp1QWI68Y0wuR3l6E6hwnhFQ7LnAUNNve23T8JFCPtPL
	qgi75NJvVZTJPXKtEgEgEfI12NXUTTKJW/YnpBKuJ8RVEInyX0jCdq9LY8DTNLCUJWTwVVR5nda
	2xZSbBCwhnd+i4fMqHvUYJXGcg6CUeDClsdldvlIjSiF6M91cE6lKy7YHRnFP1zBRBvsek0fT7m
	dnQsul4fOSxHKj16NcetkFm1IW35j9ke1snywS/8+RMGL86N3K5QxsVIPUd4EmP6qL+kZ84sYV5
	ubfTNBvKnHpi30feQH5kYhaK7ibc4i4gG2Sf3Se1ANpeknhEpIZ4FW7yvjKaT4XQbiIe2NV8awF
	b0U7y/1Mo9OZE8xGAtwvjmV9CqT6EnyQsXxhgKHJXngL0dDn47OUvD70fKWAEXg0wlVDOn+c2oQ
	gmY7Q4zVenTvLSntfAm8Xsd0DVQTS2SAM4oFGVgjgnh4rwkkew/Y04TfndsI5IDzu2wZSjOw5Zv
	HFBOWZNmwYLWRqW4cVlRi6r/eYY=
X-Received: by 2002:a05:690c:4509:b0:7bf:b4a:179b with SMTP id 00721157ae682-7c5101a01b2mr19032757b3.18.1778550408894;
        Mon, 11 May 2026 18:46:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bdff00b6e9sm85725057b3.29.2026.05.11.18.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:46:48 -0700 (PDT)
Date: Mon, 11 May 2026 21:46:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/9] pack-bitmap: fix various pseudo-merge bugs
Message-ID: <agKGh/zv8RF/E/uB@nand.local>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1778546804.git.me@ttaylorr.com>
 <xmqqse7xpftn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqse7xpftn.fsf@gitster.g>

On Tue, May 12, 2026 at 10:38:44AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > [Note to the maintainer: this series has been rebased onto the current
> > tip of master, which is 7760f83b597 (Merge branch
> > 'jc/neuter-sideband-fixup', 2026-05-11) at the time of writing].
>
> A note like this is very much appreciated, but please also state the
> reason why the rebase was necessary.  "Because the current tip of
> 'master' has advanced" is not a good reason.  "The previous
> synthetic base was made by merging topic X and topic Y on
> then-current 'master', but both have graduated" is a so-so ok
> reason.  "Because the updated implementation of this series uses
> facilities that appeared in recent 'master' that come from topics A
> and B, which the previous iteration did not use" and "Recent updates
> to 'master' brings in conflicting changes from topic C" are
> excellent reasons.

I think the reason here was "bad habit that I am trying to break" ;-).

(Joking aside, I usually rebase my series locally before sending to
ensure they can still be merged in cleanly. I usually remember to toss
that rebased version aside and send the non-rebased version, but clearly
forgot to do so here. Sorry about that.)

Thanks for queueing regardless.

Thanks,
Taylor
