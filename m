Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138E927CB31
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760138007; cv=none; b=ujHQqdhT+oDal1K9bCD+AC1dVfNPYl5KEGPmeH8kKK9oOvu4Ce23DPXozZ3rOYnRoYZcbI5ZkCYRxn+RlTOcvCR1sdvjYWi4toetEfY5I9zjKvPcrcYfEATeI9X6X2SeKXOh75hXm0tUBjF2WY47C0t6mWABYONy04nMXJOg4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760138007; c=relaxed/simple;
	bh=AYZGTe8Dc2TE46m5EJVJpSX+7y0FCZVSQrHtJ7hJcjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aku8DQTX01UUgO49+q00P4WtfKnh8LRfexLnYNm6VC7T4OYAEi3R1C7OX1Ym2uuMWECm6V8GGaHaLXzg91NiDJ8lWG7fjks+bsX0E2aRsaZFzvJcmkwSl0BhwZPZt9g/l1aVgl8J2o64kXScwFjBiPTw5cHD6b3sI72R9f3LF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PbvzwhrK; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PbvzwhrK"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d71bcab6fso23263107b3.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760138005; x=1760742805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XCKI84YmXInKc8REGNoFCUO7IxGcpWFJ98TnN2YoqI=;
        b=PbvzwhrKUu9odhpsOGOUjAfMizij2txT97WxwMnLxb7/R3YRs83NIa+6WoXhG46tv3
         mJtsDk7pv1CDM2hw9dFHTTAiQ6+h6Lr5E4kasYTPDLFJ4/cAeEYsCPe18PXi9IFUE4AT
         bVQrAEYkuh9kabm491UxP3Qf9J4nS4zQFWnCbnGIaPic1iNXfDJgjAl5E4/wohLD/Hol
         edN2g3AUv3TArhwWvozj2oZxVkGbmCNk4jQcd28G6vqgrfg66yLntJjxmACMqdR9RCda
         6IzNd1AdPkOUxzqTV/cHK8xbFHMYz1k15ZLniKQMeVuiFOM5SkuJM5AF9Jh5ZirTTRLu
         b8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760138005; x=1760742805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XCKI84YmXInKc8REGNoFCUO7IxGcpWFJ98TnN2YoqI=;
        b=T+Rd8N4FWINEDS0w45j/S86Eq9cfbZKTw/sXFQ73V7+WwIH39QLU16wHMoQ9zdM8o2
         p9yY40yBQIea6cARqN72Qu/WRwkmnVbDgVESljooHJhoRQHioCbKb3T65JsgbDRfNUB3
         8VQ6/OCsp5XX7Rc0Ze/FtPQWdr3uiY6NBwJf341iXGAjYYE9tC/t5h9kRY9gTuDDdHVS
         yczHkXW+LmGJWlh6O8OmYZpO5OilPYYuNgT9ZiQn63HZc6gCXcSVsaxiWLZGwtszZHQa
         CMtRq9JZ4SNuFTLCdh+h3sTzyS1oTtAikd4v9NpeboR50xn8ptRCOfh1dXxH2tutGCsF
         Kt1Q==
X-Gm-Message-State: AOJu0Yw/tq+J2G6CgFInStzO1q0Bs6M2SEfPt+AxXne3amFHyvvmgEyg
	qYevCBxB/djOPspm4PLB1Wcf0vWGuP2s+VuSEHCweg6tsWbRTMP6q5GocKGGyZdcVeQ=
X-Gm-Gg: ASbGncsZSJBx2h2/KTLhpOTue/2qxF30xmTUsg1mnGZVBeb3fwXi2p/7nUn/u9Efmww
	8/j+/5lb9T2G8RUsaUIOM4l1bdfNlHM62+EX2pj5VPvFnD3ctRVoGfav+txfy1VmlBEPW5hPJYr
	rnpYEklZmyPoOsXXIG9mQKtd4wcShTcveFTdSYg4y01dW9cPxmJmv3hqgJswYFjMbc7lSIrz1i+
	H5IJYLL1ufukHaabBsfHazuMPktqRFBq+IawLAAfKkoUkIMUT3NI3dlS6MH9SsR+tYB2Lu/FHYD
	GGPHsKjmQNdC/Z0h9Q4jCC2X1mIB4mQcauKYwIlM8qNs4p95YG72rF/wnSSqJrWPDVCCkPm0/3e
	WUvR27DrCWXb5lxYJKdSC5wY4JPgQc6rAQsViWPeYSeRkEMQGd44dfcbHncy7nqwmOSANzC9/GY
	aqQ7cGi1XsJsY2jx4bGJkWj2p50IxYeYpxlwkg+uQxAj+v
X-Google-Smtp-Source: AGHT+IFQYNBFTJ75ZTSV6vTgxM1acNMHtMQkdTfTkJDOOe7qhhsoHCHmp7DuFiB5MChP7w+wed7Lyw==
X-Received: by 2002:a05:690c:d88:b0:780:d282:5f3e with SMTP id 00721157ae682-780e177cb5bmr147308097b3.36.1760138004691;
        Fri, 10 Oct 2025 16:13:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-781071face0sm9008227b3.30.2025.10.10.16.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 16:13:24 -0700 (PDT)
Date: Fri, 10 Oct 2025 19:13:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 40/49] builtin/repack.c: introduce `struct
 write_pack_opts`
Message-ID: <aOmTE0H+22KmHm1O@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <109109618687efeb932bee7dd5882557ab0576f4.1759097191.git.me@ttaylorr.com>
 <aOj75uPA6cFW9WhN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOj75uPA6cFW9WhN@pks.im>

On Fri, Oct 10, 2025 at 02:28:22PM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:09:51PM -0400, Taylor Blau wrote:
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 5fed79e826..6df7c88085 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -138,9 +138,7 @@ static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
> >  	return finish_command(cmd);
> >  }
> >
> > -static int write_filtered_pack(const struct pack_objects_args *args,
> > -			       const char *destination,
> > -			       const char *pack_prefix,
> > +static int write_filtered_pack(struct write_pack_opts *opts,
> >  			       struct existing_packs *existing,
> >  			       struct string_list *names)
>
> Is there any reason why the new argument isn't marked as `const`?

None other than forgetfulness ;-).

I adjusted it locally, which makes me think that I've accumulated enough
to merit sending out another round of this series. I'll plan on doing so
sometime early next week once the review has settled down here.

Thanks,
Taylor
