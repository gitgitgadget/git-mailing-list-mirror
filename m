Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93433DD501
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965374; cv=none; b=cDvv3oxpQfq9pVarj57hKqzHsZPjuDNvcsjcpo9gDS12we+KTuLaaFMP61JMtzGSmmNz0baJcsyBx6pdL13+K+ZRV0oGX5BXo8woCR0UfaU8aHk+YZAG1OlXml30D4iFVdGEAMEPQPTHPuyJlB3vtv9GFGhct+SlORZVgQgBr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965374; c=relaxed/simple;
	bh=ee60iv8lki8Xdp1vJuQ7OKmBGEV92X2+uCSZ5xJex3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4/UadYonI3ZgMgwIB2Uv9bu2Jzsm/eR/X9j8pZRxMEnbdIxcCIVbYTdwDS3iTB97xqcS/jLLUHwtF7PBOfcXCd30S8WTdY+GcaQ3QcFvtr4WDZokiG3aOu6SJpDY8sqt5kLecIz4nI2bbmadhdW8JB9w3m027s2eoPi3EK5gzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs9TcBZx; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs9TcBZx"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d9bba96f7dso3023901a34.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774965370; x=1775570170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTjXR8RMA1C7C4KcaoF9p++gerebBVdHLCYT3wf75Bc=;
        b=Cs9TcBZx1WN8xHxDus1Q845O8/Ba9Q01A/nAFnYevcdvloA0IaI10djqBrNbS8x1BQ
         1G86ifH+H1asN6jjiQx+EYqlePWdoVTIzEpQ7m9RoxQOQL5CnnyC8oLIXzthSSfUjUwf
         MggKqWMGQNAzNYUOh1pgybniNayr7b+DlOqa4kC9hMizqB5d8esem6LIU1TdAKQEBCFg
         M4P3T3AwNmqsp/7kSrVgHauCNiKfdzWc2p+eZOsjwFFY/BoFflUcx1c6mFfycQSWxPG9
         43HXKfEJb1fvSzsEv3MRj5rxkrG1sfpoM73qG/BsDbObDOybfOlKnofJoX2VSv/J9exi
         bdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965370; x=1775570170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTjXR8RMA1C7C4KcaoF9p++gerebBVdHLCYT3wf75Bc=;
        b=GUC3xa2n75dUQX1PvHDpVU7FadegBaKjwP4NN3rEOcFWzEuDRmCXkUgafRD9qfX36E
         7sXBlmZDd/SV/uY3QxBOgijI2xyfV1MMU0FQ2DI8Fku1Bhv0NX9CfWSNTKK0S9PDVZCh
         QqcOdCVRiNFWkSolM0pcsH5cill1xlIA74Fm51HBXwT+E2yhi85eIKa3uSIlc/16MdPg
         NeuCl4vXLLAOlmSAVIvONDgGAwdlB3S55//vs1NPPk7IEkYA4QnS7Cgth+WLqdGeEdO/
         i2ltwBxYBPAQYqvM9XL5y1CR8zkiV15f4h6E8F41dH7h9Y9dtJTi+R/VG+iQ+1LuBIvq
         xDLQ==
X-Gm-Message-State: AOJu0YxEpEsH2Hw11pbWQOXIFP3JbptLRPK3Vd0/XL8INardfk63nyoD
	tGrKhJ3M4nz0GkV16wCvYRKfqqBDyTUKLXlDc/aCn+xqsrk2JesIknEJ3qPgTA==
X-Gm-Gg: ATEYQzwZaf8KCfBFO0QjEl4CBHjH6o10g+fgN3gQuNHkV2bnIR6A0nAA+S3dZ72EK5c
	iA70txsWNBViAw295NallKnprE20YX9p6KP14YxhZzvheYL/kc2MS7G4kAeOj2gjvwnrLCeyN95
	fXY/iwygNk8vZBWu2Don8Zhcs6jymqOi+BKdEJWqSMPgbD+vnFi5e8jro7/eA/QBscwXcHQlDGG
	Sww1EWOp9mOx1d+D8PNbSkcLQk049d4RSPQxW26GoqYMoepHFn9MJfPLRVYhZjiXF0dkPI1ehGv
	/zpDBedNzkSEF2ylncJRYP182lIgUnTVsfcHUFlNFumapBiDMgJWRIg2CVc7xrZ1IsPi3B4/Gdt
	WyL5SGzsgKRQ+osWLM/5U035n+PFGo0VLzLD5NEBpGl4IoC7p5NbW+9SJgM1Pyrb2s8VHnTgxep
	PUhLPU7SjmO8SSGaaL
X-Received: by 2002:a05:6830:4126:b0:7d8:39ac:f48 with SMTP id 46e09a7af769-7d9faf214ddmr9632469a34.28.1774965370299;
        Tue, 31 Mar 2026 06:56:10 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336d73sm8238809a34.5.2026.03.31.06.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:56:09 -0700 (PDT)
Date: Tue, 31 Mar 2026 08:56:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] odb: split `struct odb_transaction` into separate
 header
Message-ID: <acvSQ_qeA79LV-8y@denethor>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-2-jltobler@gmail.com>
 <act8SB3hqHvleT_Z@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <act8SB3hqHvleT_Z@pks.im>

On 26/03/31 09:48AM, Patrick Steinhardt wrote:
> On Mon, Mar 30, 2026 at 10:38:30PM -0500, Justin Tobler wrote:
> > The current ODB transaction interface is collocated with other ODB
> 
> s/collocated/colocated/

I wonder if this a regional spelling difference. My spell check doesn't
seem to like this variant.

-Justin
