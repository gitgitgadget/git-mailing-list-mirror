Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7F230AACB
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772995453; cv=none; b=BKsBA4KxFCAmPE54RRnJjASNtDNjm38JxRG03VrCauZYM09JbTsCBhai111g+XC9EnL7+WUnsa3gfvHjHvbVHuX3BxKUWppkLP+5WlCOWy2sVVXfKI+uJ7GP7eFZ5CM7gzVyGSr4bhQb11s8zExnM1ucDSXflradLLfpy/ZYE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772995453; c=relaxed/simple;
	bh=QxWxpg7aUq1rxg1AO9Aa7O6QPH6twHjmPAoho4HmnoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8SKyYh9fwX1dvP2BFEf0HjAw/agPF04Gq1CuodWLGGgdXFad66upDqLvk1N9BJH2L+pB1oRpsGbIWcTSm8qkk0CG5rNP11HKnXSkKbJeWBj/wYCVO/UOwPNtIBZ88uYBBPpso//dA9UWewqpaFhGjZub83Ni4l3qEDo98VssGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhyR5JAp; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhyR5JAp"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67bb19ac35aso316116eaf.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772995451; x=1773600251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqA69ttWU05NGANnFoQC8LdcBUgIBNNzbvCBqPEy+sU=;
        b=YhyR5JApvUfrChibjG8wuF3AJaOHwDDirNKScHeCFLa1u1MQ9aOC1hrRjwdzhRzAm5
         tfqFT7qmgf4LKgcYfZ0Aa8D5XOBJntUQr+bHnzOvvWAiIyzeVhCL9Rs0xgQoDAK5KoPx
         1iZSVmGruGUWzBjBpGzbvwMWHeSe0bdPFeVE27X/6nzSGjKSuJrk1DKUNj1B3TQBW/UI
         UWNnBqTp9agiyuRWkMrSjCBLkPUE8hc2M+yZ/WYqRTMg62b3sNGFabVc7zgbQF5GnJ/f
         zczVfdA1PPGBKk9Xo4WNcmFt5k+6fl8v7hfpWO5siray3qVFJ/HzIUCjKqCjAD6S7A1c
         q5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772995451; x=1773600251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqA69ttWU05NGANnFoQC8LdcBUgIBNNzbvCBqPEy+sU=;
        b=GyrOM5vb5nLT73p3zP3V6EkZVWmTQo/+jQ0NetwV6twfXplM92meY4Weh1sNurB12E
         CD3pczxVDoWHDDWnW8PJRzuhy72UVYoO/44FjpgBUXyxBQ3CMRqAbtR7M6GvGV10hnIa
         zv39lbm96fvWWR4/Gjwo2RCDWqdpylOaTB3opCFKB675/szJoyCQWbEll2YlxaQ/REfJ
         a4PyN7lFOKhK8D/EnzGDLGJP8e1IYbe1Z64C/ji0D6PSWsIID2kWxkfFiJ+Jd7sD0tMM
         J+ogNqFV8mLr/YWdWmERVSPyEBN8wAzNe6MJjoDFWHd/eMBc940r0UWb/fp9uhAYWuyZ
         VjAw==
X-Gm-Message-State: AOJu0Ywk6OTny/whS8V5fLb8GSd0q2ohkyMFI61AB6JNEc2IjiVJSC6S
	X2AE7SZ7NHGWszrHz7uwkwRpnOtyijb8C1hy6VfkhR+IbIe1547Fjqzmx1Errw==
X-Gm-Gg: ATEYQzzYd6aYuYgSpXy63cKR/xLFaz90TBrx3fGjquTjbpFl4xB/WgRCq/2hBRBC6hq
	M8ar41p5OGhbOk3hIupa4wFRwEbBEskpooMEdt+C1BECORsy7LQ9RbR6ZAl8JGlIcAxAgHuV9U2
	mBJLNhFFJ3DSYQHKtpi/Qk1rxtLKm+sOMStUAx9CkjQ0jUazLwF/oMa4UG7vcoTM44qWYEGpRrH
	idOh6hXcCqRq5TQU9nJes3//GVj2vNFTHpZNcrqjNSiGMvA/HfkekW3RcLvBW27HNRGBx9zsHec
	JV2F66cl1zmJKcmi40sPgox1wxjN6JBtIb4Knt3SbSaoDkheoOV+n/hlU15GzgymANGn/CtjpTL
	7q+IIR0p9Ca1OZAPadbat9e+5qVZZF2E71UNqbcPJVE11VznQpDBc28Tjd/TMkoavhZmw36ShYp
	WTNwAuONIZEgDCz/3+/t9xoCzbVTU=
X-Received: by 2002:a4a:e842:0:b0:677:4fc0:a852 with SMTP id 006d021491bc7-67b9bcd4c6fmr5833779eaf.34.1772995450733;
        Sun, 08 Mar 2026 11:44:10 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67baa9f1d53sm2474941eaf.9.2026.03.08.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:44:10 -0700 (PDT)
Date: Sun, 8 Mar 2026 13:44:09 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, kristofferhaugsbakk@fastmail.com, 
	lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 0/6] builtin/repo: include largest object information
Message-ID: <aa3DNVshSsAjFY1y@denethor>
References: <20260223174120.2356504-1-jltobler@gmail.com>
 <20260302214526.2034279-1-jltobler@gmail.com>
 <xmqqqzq1yjcl.fsf@gitster.g>
 <xmqq342cy49e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq342cy49e.fsf@gitster.g>

On 26/03/06 02:36PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Justin Tobler <jltobler@gmail.com> writes:
> >
> >> Changes from V2:
> >> - When checking for largest objects, zero valued objects were not
> >>   recorded even if they were the "largest" object. In this version, if
> >>   an object ID has not been recorded yet, it is always added even if its
> >>   value is zero.
> >> - Added some helper functions for printing keyvalue info to cut down on
> >>   duplicate code and hopefully make it a bit easier on the eyes.
> >> - Moved the for-each loop that printed table OID annoations inside the
> >>   preceding if-block making it a bit easier to reason about.
> >
> > The changes I see in the diff relative to the previous iteration all
> > look sane to me.  Will replace.  Thanks.
> 
> It seems that no further review comments are coming and new
> iterations are not happening on this topic, so shall we declare
> victory and mark the topic for 'next' now?

From my perspective, I think this topic is good for 'next' now.

Thanks,
-Justin
