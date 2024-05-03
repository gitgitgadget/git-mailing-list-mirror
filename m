Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DACF2C694
	for <git@vger.kernel.org>; Fri,  3 May 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769445; cv=none; b=JMJd3Upo+VeDpF3+BixiDsacz1COzNdbI/Ua1zyxq1ZsxaIAfTpodmdvdchr0d/vuHaobPRpd0I8OZ3oOqRohdpn6TFka/ZFimB5Q4YwsKGbzIstBTm0umyQ2zlUUuZU3yVcjiJRa8i229PYxulMG9RxTTil1zcO7CgSa8OJILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769445; c=relaxed/simple;
	bh=GRSGDDsmLoW/lnishFAPQIrGzXefDMJeyvHj6qm91S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShIhuK5k5HpkRQthHV4DAjHKH5B6wIfWz7BFH2wWW8SNIZjy2XmqR4LhRadwVdhlm4A7VfyXsEIcZgkgmG7HQsFInFh8aPcwH5XFHyHGf91HHn61QVC3RB6Jr1+k+rsYEyV9ETFVsJeN2IJLIyYtZ29Jh+cuCFt9PkqJTFB+9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Czj9Mp2z; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czj9Mp2z"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa22ebd048so102088eaf.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714769443; x=1715374243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDtxJu2DH6CNFbSwymbwJvgfbvxowBv/EOJ4BmXA4h4=;
        b=Czj9Mp2ze+Y3NfgIrJXmfi4AaDEj24lzFbDveX1cS5wBs+oTmAY7m81Trigrdvyelu
         PP3temGz92Y9796nP6xVP5/od/b/FYruDM1gylHNu1p5JuyuE6sXGoTPTWH7XxUkIYJI
         kQjWnnY1oUkt9FLmYJKIaVD4LiCmw0vrJZYPbYqwy0CQSN7AC2MYRt2C0LiaomCSLyf2
         V7o2xoX0b1p/LTSyG6EVLl0aix7z/+Nyh1taC7Upun6j6sBl2iF25RNWJPQee8NoO3wU
         b95AZBHfKJiCEsbgd5N4FIRy2MPz/N910m1GUsyPANepaCdSyBLIJTYSUaAndeCuMuxS
         PXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714769443; x=1715374243;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDtxJu2DH6CNFbSwymbwJvgfbvxowBv/EOJ4BmXA4h4=;
        b=ILcalaI8YtB7uosBa2KDsrmFuOOX7hrJ5fuzqZI1FTHZh97dPCTg3LphvIYs/mzQgL
         e3FGhqEhGvRHOIz7p/uzWN7bFtERe35o2L7yKCuj0yUHqUX2csCYbzSNXQShFK/wsoCi
         n/Kg2XKr1cwwBLC6aeTeaMqC/CpfVnOYUGiJoIDetbkkHAJtyMj9yZc4CVQW8lR51m3X
         L3lh9mwek9AUfm1SeqPqcfaeKr3h85Q8UVCfiiQKqjsV1sh9PjPwx4+R/OcmKzl+LL6C
         D5FvXDqqCouXy0uAprR54DpwXagA7Tt1Sqlel093X6YaiIquA66vttMZ1BW8qX2N1VOB
         msdg==
X-Gm-Message-State: AOJu0YyHGLBnuUyiOgt8a3ViUomcLmdqmcGaFBDAChFhI8Kfaa1MG+wA
	91zV3TkaEIxNyv3eZrOGd6Z7MRGzX1cZvGSW20UcxUB61lM8vA2p
X-Google-Smtp-Source: AGHT+IGiJoGy6ywN86YLcEgrAB2DAi787MqzgeIEk2w7mS9G5QoqOd2kl/AIvtGPR8a/BMO6HZRUQw==
X-Received: by 2002:a4a:182:0:b0:5af:292b:6982 with SMTP id 124-20020a4a0182000000b005af292b6982mr3730420oor.5.1714769443201;
        Fri, 03 May 2024 13:50:43 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id p14-20020a056830304e00b006ea1add9346sm774317otr.4.2024.05.03.13.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:50:42 -0700 (PDT)
Date: Fri, 3 May 2024 15:49:25 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Karthik Nayak <karthik.188@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/10] refs: root refs can be symbolic refs
Message-ID: <maqra7gbokanvptimdk57gaaitdxdpaxse725odzcvqieqfhbc@sgdmfeuhi5hj>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
 <e90b2f8aa98493e9cd3f2c04cb58318780f9f6e5.1714479928.git.ps@pks.im>
 <zmnute2cow2rbrv3cj5cq4roieyzssaxcnorxhorzyp3wfgllt@ubhsw6dpi5js>
 <ZjNJ3j2wSgui_cG8@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNJ3j2wSgui_cG8@tanuki>

On 24/05/02 10:07AM, Patrick Steinhardt wrote:
> On Tue, Apr 30, 2024 at 12:09:57PM -0500, Justin Tobler wrote:

> > I'm not quite sure I understand why we are changing the behavior of
> > `is_headref()` here. Do we no longer want to validate the ref exists if
> > it is symbolic?
> 
> The implementation does not conform to the definition of a "HEAD" ref.
> Even before this patch series, a "HEAD" ref could either be a symbolic
> or a regular ref. So to answer the question of "Is this a HEAD ref?" you
> only need to check whether the ref exists, not whether its target
> exists.

Thanks Patrick! I think this explantion might be good to add to the
commit message.

> > In a prior commit, `is_headref()` is commented to mention that we check
> > whether the reference exists. Maybe that could use some additional
> > clarification?
> 
> Which particular commit do you refer to? It's not part of this series,
> is it?

I'm refering to the comment added above `is_headref()` in
(refs: classify HEAD as a root ref, 2024-04-30):

"Check whether the reference is "HEAD" and whether it exists."

Maybe I misunderstand its intent though.

-Justin
