Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631D301471
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532073; cv=none; b=qSe0O3Zm+7h6Qj0Xd6hxoIHHY7kGD1Anda03opXYnQ+oiCvt4G7qpC6EOKzbiQCQc2I0BnnrjGFTKBuNPKJLk2/ZGfQTYEJlkSnB9CNTcAzQc8HbaIDyvO81gT3dDWgEhDEOSKKe/6f6ksHpAanEEtJagN3GHSkbXeNmy2sa9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532073; c=relaxed/simple;
	bh=Pk2mWbEuFIRfCh+3eHFWFOflvSsjIRr+u+8L4ElHXno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM8ssymCkH73+vUZItdA8XxpP+3rV5VXGdf1+pCs4IT5pcSrgyUJGwwdQVEjkEbBLvDne8AQcKtvmnrnRJZz04FTRnwygrm9yRe1MvrW9T1dcFZj5J2TxXElkXIxOCX7V85HSWnYbObPs7GC0gCAvKD5kcZDq3NhVB++S8iRrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B85SeIm6; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B85SeIm6"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a30bcadd96so30584eaf.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783532071; x=1784136871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tBWdgWINd300uvDk9X0UJNA6ECn3kF86DiRvumW/bNY=;
        b=B85SeIm6pP0eROiTSZIpA2Q1Pek9UWfC9FSfcRJNRFc3e6ywvmwSh69+CccSUoUKK/
         1GiAf0T69hV3Kl4da+HD5aaVhmq+laP2ANjuoELaOHen9A+tyqu4rXAbJqDhS/ntXvac
         CrFTMO0J2lnVktGHw0w6U7jOQJWN5S2Uot4422sua2Ie+KJo5UI4ez5ETZGioLomF6Lm
         2xFkAuF3CfD0g+UOJLx7WPSTXoBW/dAb8rD5FMNYCy+cJFPX/gJ17UCLa8wkZMnwOISf
         +S8IQBPdQ1M9aAompL9ZMl85mLtE85Zw84WjAXZspy/S6fkvF3T+GyXh1lFsRrRH5lXM
         3oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532071; x=1784136871;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tBWdgWINd300uvDk9X0UJNA6ECn3kF86DiRvumW/bNY=;
        b=WbUmMBSQHPpwiXR090O8wVA34qJCP/U1Yq9ImWd47M08Zz0c2TGftg2D6V6xL0tToE
         oFVKtP8daOu9ZT2POGvbHjbQQMaP2D+pU58oGbMHjmKHiqKWAVcVNupYAZ/A4GKP4aMk
         7Wx6ha7uPMjoJnt6TbvrqOm/tL/tZN1M/wzYW9OuKh+8Fn1E7cb/fXP0mgKuo9XPbqSJ
         jJAV5CzO1Jd2FOg4RGxe9vdL0sPDWpLr89YhEYUZTqJ0V2fmloyRKZggAsZPeP9A9W2Q
         1L8cm0XvwrENnPtaD4RKp8h8r5+NjZAlSMaBOK2IfGcm5RkxyDcjguGgVj/FuxplPpO9
         Dz7w==
X-Gm-Message-State: AOJu0YwG/kUpq0od4wLngxoDjJ3Sax4YJQS4tzOm3NRFOrGKu5Vlg5O/
	zE34QputrSaA7hHzxgoakDnSVznGcb2JjJ1WiHyB4J2Isap7sOIaEJMA
X-Gm-Gg: AfdE7cl0sQ61/2IG9E89l8ZKl1qgNSBeK+g/JO6hvyjEezbSwkmatFbO5whbhvsTFGF
	Q6GS/qIkoIpIMOV67qeurgezIfntqo+bx0gfoXOGh69o5kcJfjkV9nKJuTp+ToIMaJb/h8jBCxT
	Sx/oLCWjwCwNBqmGp6nRJ9TlSuhrM0NpkkwukH4KcBleCuthdJE6u4ZjLjlFCNRvKlQETc//Dq9
	nxDlf0/WHFA0/hXcJ5aH/T9iD3m29u/T8xqTaWjcoC6ZK444pzndER95ja82PPS5OD2oOk3+zD/
	NH8B4VFkS8LjHkYLGRqrICg+gI2CpEU07zbKRI1a7JyaKnFDhM+LzWkSJL3jNFJ5R9C2Gih0pLm
	i3lqr6rzC4Mw9v8KU6596aG3hj0Jr1duTwCpn4GKC+IWgBcngZ458KbvSiZhA60bRZcAT90hcB0
	tdCrrNTg==
X-Received: by 2002:a05:6820:1506:b0:69d:e6eb:ad37 with SMTP id 006d021491bc7-6a36da60db9mr2394128eaf.34.1783532070788;
        Wed, 08 Jul 2026 10:34:30 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-450fd2cfbf5sm7482324fac.0.2026.07.08.10.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:34:30 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:34:27 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 09/11] odb/transaction: introduce ODB transaction flags
Message-ID: <ak6IGmwhoJKLrrlr@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-10-jltobler@gmail.com>
 <ak3xMNbhQnGCMe2c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak3xMNbhQnGCMe2c@pks.im>

On 26/07/08 08:41AM, Patrick Steinhardt wrote:
> On Tue, Jul 07, 2026 at 11:14:10PM -0500, Justin Tobler wrote:
> > +/* Flags used to configure an ODB transaction. */
> > +enum odb_transaction_flags {
> > +	/* Configures the transaction for use with git-receive-pack(1). */
> > +	ODB_TRANSACTION_RECEIVE = (1 << 0),
> > +};
> > +
> >  /*
> >   * Starts an ODB transaction and returns it via `out`. Subsequent objects are
> >   * written to the transaction and not committed until odb_transaction_commit()
> 
> And this is the reason you have to add the include, so that the flags
> are visible in both "odb/source.h" and in "odb/transaction.h".
> 
> This makes me wonder whether there's really much value in having this
> header here be split out of "odb/source.h".

Ya, I've started wondering the same thing. A transaction implementation
is always going to be tightly coupled to the ODB source it pertains too.
It probably makes sense to merge "odb/transaction.{c,h}" with
"odb/source.{c,h}". I'll leave it as-is for now and likely explore this
is a future series though.

-Justin
