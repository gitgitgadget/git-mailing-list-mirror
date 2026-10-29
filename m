Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281519;
	b=ydKBOgOiFJpAri1YpDtG3ux1sAiNh+BovS3trcoFYKcIG6CvQ1LS1sPu5ztGXYHDduF1
	 sXGmfoi1mlTU7k81Ueuh40BewtWD8fBIanZPISARr7ZJrxa9oevqINru6FQWNAziTStaq
	 6bFyjGPc/SzJ5wdDC+DfZiz9VPIiQMZ3ptqDwqSKew+IOnR5KmSAg1tMc31U7QT2N1bYj
	 F4fdcrnP81+yqJu1oo96Iard9yL0KQlotoJKalnlJ02A7O310U83UlMEOBAcuX+UH4zAp
	 Wr0fvS14FBPLIZgluoOql6dQy2bntPadF24+EEYx0RiVwBGOG1jYyhI7NUwaKjdCIPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=wByy2paBPc9U2K1V5Cu+DgMhZahNIK8jSioMcVpI1QQ=;
	b=c6+MQ1joBD+krbYVFZ/xbWOmgGhc4nKGteV/T1r5+jI7A45lCbUIiOzx2pN/p39CSsKc
	 EwhRMtKOwUJ0ByzcWL61v4UVcSpuirwzYI4ylgSGdirjislLgNE7tzM/yI+hmT9hcB1fh
	 5mKpOArlcJbV7cwfSyUdKlNTn/RBtuQeoWOrkrOThtSeWGoH+ZJHPASSGVyKYfvgXoD6E
	 6Z7tsG+3HOVpmIdsptu6wKLL2WJtWiSQYUwuZOqiVsui87TqgqeLqjbrf7RbvWwCUltgc
	 xg7EUWDHnZZ9iSmHyToL0MkILqI1lMMnbAq7wF4wP0ty+WIkwxJPgSrWKzTEcrnH25w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0FhiF5wn;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2B606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EC2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0FhiF5wn
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso23324035e9.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793281517; x=1793886317; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wByy2paBPc9U2K1V5Cu+DgMhZahNIK8jSioMcVpI1QQ=;
        b=0FhiF5wnEyNGnhOL9gRqXuf4EqmCVcThG6rv/YgYfdtzj/StTcpoIQYpujsYA46BGN
         07wfSWmHnSLbVZO9CfBK5eGnjpcxPh125LKHiEv85Dp8Yxf/heRQFN5SbbpNbFgRfvVh
         7ZiaJGuX1+YRswzW8bAMGNJb5+JLhucNJjDgUjtBF1ctqxJk30TixwAIc3BIgQPlW+dv
         XeceZxBsLyfEGWTCnKCHVfyo8ZSJm6kQQBcGAgeqbwDLKZC1x2xWo+CQsRIWwmQxZIm+
         dj723pNA/O15C5eoQAMLfuakZNMzJfMjUIN+TjOQvtXBy30ucMbZHWB/SbUNCXRUM9gZ
         gWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281517; x=1793886317;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wByy2paBPc9U2K1V5Cu+DgMhZahNIK8jSioMcVpI1QQ=;
        b=uG8Obp3/72HkfWaaBMwgzSTME9GftqAFNkui/o4YIt796IFN5VGfuJpsDWOsFBTx1I
         Q4T3C31bJLaWHLoBt1plLen2LfjqXd479AoVZgKp8U4RxwvhPd7mgsfHQgLWh613ZhRe
         fJueZcwYrvCDc12JGTaQC37EJMEPk+URclVhNup8qJiFkxrhuTvlyWq/NWFfCHhyKxCf
         BT2oZPCWpl3XgQk3gcX/bY/4Ylq07xvpdBvxfN9xAsZ86nwkcBMl4aIo1R78tENWKMse
         67gCpCxXPhTM200cpA1pKCfIOVJLgF4XOSD86cY++RCmS/yk014N/RWo+uefYBadhjaP
         TD7w==
X-Forwarded-Encrypted: i=1; AKwUvBw0Nwb4o25+R2rWndIBLW4bADhfcs53/d5GIEVdczPnpYLEkrcHXoGI6ERQdLkBB5wQJdo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9rZO+5TuTBqdOCFAXRZlriWRkzN9WqN4P+PE8lnTs0b13+TED
	L9+ZloB87TEJtUuCK1bKR8OAwpLwSMTv2JFADIVh/2zKIT22Nu9zWBeSen+AX+ZJ
X-Gm-Gg: AYBFou2IRxxYYdC0O/GoF1jubNDqVw7uH4QCjAYvs9Na/fFTy6wX3ZBYs3jJ/yXvW1x
	LUsBo2YAAopW2Sbn6/8H7w+XAIqI/JQ4fUjsoxTLi1VdWqxwvd27CwYKQpboumWfm9qOBB1r26G
	j+wWvkX+V7qYqpNBGZ+1/dwKXdq7mcRHgHP1ffIrdJVN4BsQz6MPbTEKgE/9hXMHW1uW1xl+6to
	8gY52KAjopmT8X2CBwCZeMXCflCuntEEVHg6SlI4F6N2Gu+8r3AG64daHwFePoGelnaz134yWOv
	8yYCknEQZpNC+fXT7tBQr+PtEMmdtwr35LFGOmsjf2RpItEXAMs9zsTfilycJ/QIR0m2f41K/Uj
	UVWdwDEYA7v0Z+UfSfiToGiPKLR+2CW9Kbb4fK1U5j3fOXJ8/njuEzK5CneTMobBgH3+SaUDd9h
	RzB0VDvfutQBG2A8NufH6LV6LJvBMSJXnCqCAOHlKS0AKqQrgB1t39toMTtqvrOe4lMedGEHa52
	I/bh4+ZUqXgXy01o6qNJRKgD7/iIWBgLVor8XF8N3EpWz1Qu1EW25eoUE1i5BzqgCn6sCIiTCX6
	8WjbCkjde2ZfL/wAUsgSqQliE2561xPhX+BS9gDSK+KuA1xeMD5V+J2NWswdGSZFeqNWopSQNbu
	2ZjG7IGfGE6OSKt5A4I9PLaNKGeD7jon7S2lsKrnwSxhP0km/I2DetL/0LbBUotneDd3ZMRlHUm
	tX3wuM/gDAPrUr2mJb9PGq8qBj5X/lM5yVBTCFZasM+cZLn4vXGT3g+Ps=
X-Received: by 2002:a05:600c:8b58:b0:4a2:8f4:96c with SMTP id 5b1f17b1804b1-4a9678c333bmr137744245e9.29.1793281517159;
        Thu, 29 Oct 2026 06:45:17 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:b017:4479:7c99:e3fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdd5b3sm34508328f8f.53.2026.10.29.06.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 06:45:16 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 13:45:15 +0000
Message-Id: <DMHD8RCO7V74.2BK7C9T4HNLHO@gmail.com>
Cc: <toon@iotcl.com>
Subject: Re: [PATCH] bash-completions: add --[no-]graph-indent
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Mirko Faina" <mroik@delayed.space>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
In-Reply-To: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>

[Cc'd Toon because of the mention]

On Tue Oct 13, 2026 at 8:50 PM WEST, Mirko Faina wrote:
> Add missing completion for "git log --graph-indent" and "git log
> --no-graph-indent".
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index c3a49e2e22..2348a3cfb9 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2298,6 +2298,7 @@ __git_log_common_options=3D"
>  	--right-only --show-linear-break
>  	--show-notes-by-default --show-pulls
>  	--since-as-filter --single-worktree
> +	--graph-indent --no-graph-indent

Thanks for Cc'ing.

I didn't know about this so I completely forgot to add it, however from
what I read, this is the __git_log_common_options and I'm not sure if
this is a "common" opt, as I don't even see --graph here.

I searched where --graph is, and it's here:

l 2383-2409 'git-completion.bash'

	__gitcomp "
[more opts]
		--graph
[more opts]
		$merge
		$__git_diff_common_options
		"
	return
	;;

I think it would fit better here (not sure, I just quickly skimmed the
file).

Also, I missed this for the --graph-lane-limit option so maybe it should
be added too?

My main doubt is, both these options proposed (yours and
--graph-lane-limit) are --graph dependent, which means if someone
autocompletes them but doesn't use --graph, they will get an error
saying that --graph is needed. I'd say we do what other --graph
dependent options do, but AFAIK these two are the only ones.

From Toon's Git Merge talk, more options for --graph option will be
developed so we should maybe think about how to do it in a way that=20
doesn't autocomplete if it's going to error? (maybe that does exist,
given the multiple options that depend on other options)

>  "
>  # Options that go well for log and gitk (not shortlog)
>  __git_log_gitk_options=3D"
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd

Thanks,
Pablo

