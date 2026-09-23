Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D23B38B4
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198256; cv=none; b=LRK0lgy+KtvVYCuxpxiwSkeDyZVf3cMYGb1eHazHcvOoF2bp0JnQrtn6ablHqT5Bl6IVubmT1nxC4aTrOXkup+z0KjmYwCeTqNF+UspHr5XucK/WDH2dihQXN5iXyYa/euFiX2P9SRe6UN6F/BSVCZggYRpBUVhEihdoz1uSKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198256; c=relaxed/simple;
	bh=vjPAD6p8VynVuJpW0DumLHezVNaR0BZNYeiq483+u+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buLba51z8iF/DZ2vMKTn7U57/McvMjEtEH0TLnQFsgGbGIN4Y17GgQSGjg11udqIQ6FoMkvKFRecIlP3sdOlCWxufYVdl1f3iZwba+IrzpsvOh2c1G3DrRqB4BOVlW1rVQBKWyiX/xS6dgZVm4YXJ9Ah9T7NA94rQopzAyNFgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/5EwOW4; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/5EwOW4"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6d33d80855eso612547eaf.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790198250; x=1790803050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=slJG2NLqFunoUNpWyLDVvBnKxsaBIDPTEjEHBFg4mso=;
        b=E/5EwOW4+CWGSAR6vLTOqYhKHr9Hr2/pcSEM/zU2huX9LyIYSnSFu5aqymgISkwzpL
         Zht3tQUDT/NSq/GujQtYxJBSUPFKMtv83cTce1UwvSOMMwAzxlwFoVBMMif45M3KRiqz
         MVQ9vfj1AC+0UF5bFX63qWLrG7NThUkTSqvsHAVbMx8C21L4T3t7iEvtnqwlHJ1tLJaN
         kwe7iNhTLRl3kHYTD2rgBmseIxciHaKBV/aibDk9cpizPdQWjG/Y45FFf4QMF6luZKl7
         ZHxAGGOYE/Ox4s6MXqXAGhN7YNxwiN7rfEFoJoYh+5c8HQgjyMxC0QSavJls9IljEYly
         xuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790198250; x=1790803050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slJG2NLqFunoUNpWyLDVvBnKxsaBIDPTEjEHBFg4mso=;
        b=0AMHZG6JRO/BEcB7yrgYut14oFKd10IfqGERiC+ch4Otb2XWTdIXWKiVDY4WLFPfk3
         6CZrcrzBTbGReZadep30ML9pjfUW6SgWm58j88s66W/YQocI9H+1Kp6yoHxeeCJH5L5H
         9ywJ9gWTTwhmZnz5fNzWc9eYDdnKGqg4a7M70BtOszKDiGPZk1QjBDXLa7jeEWhX12y4
         6AFY4pt4XbBNo8gCNTnlsIn1MTXx33/OuIe/8ZjjWiKjzRXYJ3LOIdHRU/2NWmqWkpyt
         BPj2SLGt+H9el1x0ABN1FG44PLtr4neOnBRTrlcm0XoBZwdTsjsVduMs5z+VyPgQ5S3R
         xKSw==
X-Gm-Message-State: AFuF++lafGX6CL+MlP8G7NlToZ1RMPMtO04cYu37pGAQQ2HyOD+XlHvn
	py+Xz1ryygvi45mI0ZQaOgBm8JytJ9NwqmiqOJLW3MF0sKmcb98i9ayE
X-Gm-Gg: AYBFou1NeD/lPwGryLMD4jE54q1sHayqKt8ox+70ymA2j/X+sFsmqoe4pD51CZ9euB8
	AwU8HIkEomsqG/p74YgRWfFXP7SAWtUVzj+MGqKpddcFEJSAflECNA2xfWBKgQRI3mxkiA98Bnb
	Q0OSKr2Jzhap9RErSNWVLw05t7tabpdUEmqLKjrPnVO4RnlyjzdN1Pf8LT+bPbW8gj9YQAyw6BU
	HpYqOgbpaTqA7fnaYR8Jc2QUJoJYqe1QkG5kZoxEtU6DkFUxUl1BDZTceJiiVoC8mu2fwMW2Kzk
	K8a196STCGh29sLWs/9ml7LrFG3vtxLouxWmqh+IdZckQxxWsNmQfEx5gAFomwPkvKYgqoO57FR
	OZLQ4LiwuxwH83VgrvprQKpDJ2mlveelWsTZpjFfrkrdk0APlt1mfXfG2V9EYJ3y5h4Dr7kkNrc
	+ta3Gkrsg4wegtIebuo0KiZ5BtFZ/SJkut/PRJnBax4v14EdvJy7LOzQbkqoy/ifEYNav167hyK
	nm/QjPqQKIJXs91OBNNWp0=
X-Received: by 2002:a05:6820:4b89:b0:6c9:80d8:a1fc with SMTP id 006d021491bc7-6d4410d5f9bmr429205eaf.57.1790198250428;
        Wed, 23 Sep 2026 14:17:30 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491ed7278fcsm318987fac.9.2026.09.23.14.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:17:30 -0700 (PDT)
Date: Wed, 23 Sep 2026 16:17:26 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: flush transaction packfile before
 migrating objects
Message-ID: <arQ_Uz2R_sE4yzXu@denethor>
References: <cover.1789328612.git.jltobler@gmail.com>
 <18a1798d958d7f089614ec588346096c10b0666a.1789328612.git.jltobler@gmail.com>
 <arPRM191URNQGu7V@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arPRM191URNQGu7V@pks.im>

On 26/09/23 03:16PM, Patrick Steinhardt wrote:
> On Sun, Sep 13, 2026 at 03:26:22PM -0500, Justin Tobler wrote:
> > diff --git a/object-file.c b/object-file.c
> > index 0f123b79fad1..210984f82532 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1262,6 +1262,8 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
> >  		container_of(base, struct odb_transaction_files, base);
> >  	int have_packfile = !!transaction->packfile.f;
> >  
> > +	flush_packfile_transaction(transaction);
> > +
> >  	if (transaction->objdir) {
> >  		struct strbuf temp_path = STRBUF_INIT;
> >  		struct tempfile *temp;
> > @@ -1292,8 +1294,6 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
> >  		transaction->objdir = NULL;
> >  	}
> >  
> > -	flush_packfile_transaction(transaction);
> > -
> >  	if (have_packfile)
> >  		odb_reprepare(transaction->base.source->odb);
> >  
> 
> In the preceding commit you wrote:
> 
>     In a subsequent commit, repreparing the ODB is slightly deferred
>     when committing a "files" ODB transaction.
> 
> But that's not really true -- you don't delay repreparing the object
> database, but instead only flush earlier. The reprepare still happens at
> the same point in time.

That's fair. When I said "deferred" I really meant that
`odb_reprepare()` was now happening after and outside of
`flush_packfile_transaction()`, but logically it is really in the same
place.

I will adapt the commit message accordingly.

> > diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> > index d295c265c75c..fb83c8fba619 100755
> > --- a/t/t1050-large.sh
> > +++ b/t/t1050-large.sh
> > @@ -87,6 +87,22 @@ test_expect_success 'add a large file or two' '
> >  	test $count = 1
> >  '
> >  
> > +test_expect_success 'add large file with loose object in batch fsync' '
> > +	test_when_finished "rm -rf batch" &&
> > +	git init batch &&
> 
> I feel like using a subshell might've helped here for readability. But,
> oh well, it saves us an extra process.

Ya, using a subshell is probably a bit easier on the eyes. Since I'm
making some small changes anyways I'll go ahead and make this change
too.

> > +	git -C batch config core.bigFileThreshold 5 &&
> > +	echo foo >batch/1-small &&
> > +	echo foobar >batch/2-large &&
> > +
> > +	git -C batch -c core.fsync=loose-object -c core.fsyncMethod=batch \
> > +		add 1-small 2-large &&
> > +
> > +	# Neither object may be left behind in a temporary location.
> 
> You don't really verify whether they are left behind, but rather verify
> that the can be read. Which is a bit of a different thing.

That fair, I'm not sure this comment is really that useful anyways so
I'll just go ahead and remove it in the next version.

> Sorry, feels like I'm in a nitpicky mood today :)

It is always welcome and appreciated! :)

Thanks,
-Justin
