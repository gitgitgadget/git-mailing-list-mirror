Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D04156E8
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376568; cv=none; b=q9h+2V1Aeop9XGpw4zISHhXdW/tZAXqDTVwe994Bw34cuYF+i6syemEhTgBYSs2hSazf52b6JGGdfrgIhwcKnMtKDotOFpQjc5jdNHyeBWadh2liqVpXajrDvrjo7tqJtaHs5DJ/VdNVdkWDmjL+wPcwciLsjX02MUw3vKb1Tac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376568; c=relaxed/simple;
	bh=2I3AF+QXFqpI5SY++YY/tEzQkyjcPnm3RaXTFKVneI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AX/p20jzIKb1Nt0w6kvZPaB5TsRl4THYhIhFHd8Cwi0sb0c9xgC+6ehIrzbEyGQOBCHosz/fFljAvtyYMvTWSOemoZZhJgOUEY+b30XctEvFHVahbGF8TGm7qCHFJCeAvZMH9+1L/5mAk42MrAEUz8to/bAGLp5dY3joL1uiu1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvU8tB/D; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvU8tB/D"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44cb057311bso1095597fac.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786376566; x=1786981366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oXzWs0OGR+GBtXtJ4AIjgvFRVlndL2aUTtlX+9kQiK4=;
        b=fvU8tB/DifMm8JdBeJftrUXdJDTSbot6swXaWQ2iJGvzjbXd++HHufz8PmRqxaFYuJ
         2+s9mfeeePxmKetlTFRvJv9dpsvmzBmm7dcgID0BeAd/h9Ck6MZEiAPBa5iuwKgcQ0Gm
         tb12FCZF3oD3O21c8EjPLaU8+m+0XftQNU4zZccngACFXWMPiLMJ1pyEhwuS0SKHZnp8
         Zphpg2rpmCbjSPfge4Ba4eTM+JSEls/jyYw+hao0vtU3EU88xJwXRitSla17HGOOaRyy
         lU9olq7ZVx05gPKwrw75a6jTStCL6yL5IxZAurrwYYzJnlsjsuTIijXQ/K+/K6IY2B5h
         I+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786376566; x=1786981366;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXzWs0OGR+GBtXtJ4AIjgvFRVlndL2aUTtlX+9kQiK4=;
        b=XtlG5fwdiZAwdmD2ly2vXo49dc4dn5C8EQaroqXffX3VumIbXO7RYMp+4NlR/sHL1L
         ScVGEyTm5RtBK7wjs8zt8yPRM426bGPRd1K0KtRW5qoPw1L4cb8ysJCUx2EXyp7zfdwb
         RhNwfRs79jwtAbcydAX5JB9uLLnheh5VqlMM99KA1+e/uk2VqpT3JlDsXy60wbWJt8ld
         QUedmJGIWvA0kBaNDsgRx9jHXzCs0tOQiScY+KTm/tma954VmuIa3Cu9KxoJSY9XF0kx
         r8q2e1l9skmpdlmntrgN172LckiE5uDXiwZ3dlD+GqRcznQUas3/olPKOvoZkBQFKNdQ
         DB9w==
X-Gm-Message-State: AOJu0YwpinZb7Q6DQ1F3ozELKRDE9Y2osGsJp6zWx2RSWr80e7/sq4Wk
	ECEcHqrkvHMwEd6pj+y13gkH2MaxuLxQ/O3mmeWCVMicBfy3FWAH/4/JBzYz0Q==
X-Gm-Gg: AR+sD12+oJZ5iO32j6V/n9WFWAgSC2de4kwrPDvEMR0WkwjL5ec1OeoyAe0gDpVj2Fo
	8zdYhF6SC1kwuSDzkGcmO+BRkShH+bTFLERE9UbdocRo5Z+POaIN0cwyPsWHj7+fwOnCwFj6euY
	WXyLHUkHAGYdnzjPzE/FD8FR0lQN/jJuELIFBB1k3PjUhRCCkLSbO90qyI0g9dJsFgMQS/Ktrwd
	KwKV5lqIF7NU9/dMXqFdVzKk2VYwumoPqQZFl4JknLAitJwlP4ajNdAhylEVIPiQ/yBFKrKy/mT
	372lxW05RBanH821ZvnkgddS0UjcU8SCWYJEPwWRmuF6HF0MBgFpE8VFSgNpTuJfqN40UOOoOny
	faUpW6bMD4G9K+lHSQQRDboqoCfgTwvC7xGcD0ah4CHusMEdk2I5wHgvysycVMic9hnZJYIh8oh
	q+USoaiB6DobYajkLWacl8Xlf68mU/TNwtogrJIuNkswoL+tmQF9iyQw==
X-Received: by 2002:a05:6870:46a8:b0:442:e783:8b2d with SMTP id 586e51a60fabf-4599eead67emr22472467fac.17.1786376564695;
        Mon, 10 Aug 2026 08:42:44 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1a76701sm8519864fac.5.2026.08.10.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:42:44 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:42:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/7] builtin/receive-pack: read unpack limit config
 lazily
Message-ID: <annwLmJ08J7q9GoW@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
 <20260809190106.1565882-4-jltobler@gmail.com>
 <anlegs6zfUysbx0C@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anlegs6zfUysbx0C@pks.im>

On 26/08/10 07:15AM, Patrick Steinhardt wrote:
> On Sun, Aug 09, 2026 at 02:01:02PM -0500, Justin Tobler wrote:
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 78d2911c00..5264d70467 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -2333,6 +2320,30 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
> >  		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
> >  }
> >  
> > +static int get_unpack_limit(struct repository *repo)
> 
> Shouldn't the function return `unsigned int`? We always expect it to be
> a positiv value, and in the final commit we have to add a cast because
> of that.

Will update.

> > +{
> > +	static int limit = -1;
> 
> Is it really necessary to have this be a static variable? As far as I
> can see we'd only call `unpack()` once. Also, the cache would become
> stale if we ever tried to read the limit for multiple different repos.

Good point and yes in practice we really will only be reading this once
so there isn't really point to caching it. Will update.

> > +	if (limit < 0) {
> > +		int receive_limit = -1;
> > +		int transfer_limit = -1;
> > +
> > +		repo_config_get_int(repo, "receive.unpacklimit",
> > +				    &receive_limit);
> > +		repo_config_get_int(repo, "transfer.unpacklimit",
> > +				    &transfer_limit);
> > +
> > +		if (receive_limit >= 0)
> > +			limit = receive_limit;
> > +		else if (transfer_limit >= 0)
> > +			limit = transfer_limit;
> > +		else
> > +			limit = 100;
> > +	}
> > +
> > +	return limit;
> > +}
> 
> So how about something like this instead?
> 
> 	static unsigned int get_unpack_limit(struct repository *repo)
> 	{
> 		unsigned int limit = 100;
> 		if (!repo_config_get_uint(repo, "receive.unpacklimit", &receive_limit) ||
> 		    !repo_config_get_uint(repo, "receive.unpacklimit", &receive_limit))
> 			/* do nothing */;
> 		return limit;
> 	}

Good suggestion. Because `repo_config_get_uint()` leaves the value
untouched if no config is set, we could probably simplify even further
to something like this:

  static unsigned int get_unpack_limit(struct repository *repo)
  {
  	unsigned int limit = 100;
  
  	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
  	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
  
  	return limit;
  }

Thanks,
-Justin
