Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE226215770
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514013; cv=none; b=aJKnwgyhsSsrpAkMFN3OX+UMmFhciNQB7GfoWyXOYZur1FJs555f4wZ53ztedOZ7T7NIWVtiIoVtZSx+cKvfPbZe119JMIJFoKM5R27q3dcGvSuV026rVD1qRIhxwRh0z8u8r/wSLMiPT17q92TXmhk9ArZPGIwXYcPDpj9QYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514013; c=relaxed/simple;
	bh=Wy5N04rQLXARz9g54l8F4qA80Em1UT/mMtalK/6nTps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxj9Y/SOdoxCYR56Qyp+wteWvwJEkQBwkbzug1bXx2ARQK+6mxM0HGxZGgxy/r1QJaqi/8oTcTi988oH3s2Wds49/26hbCrEbN3vMU7KElIzGBuH6zoGyYX4Vki0iU8qca5IxkgHcyp9s0GvEaLfShliSH/fiDekEsPsVJnNEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMRW3dhM; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMRW3dhM"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6003b679812so299113eaf.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742514011; x=1743118811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b58wiqRkDo5hoUf5Kenjp5h6GZ6B9o4X0mhjbOTFFdM=;
        b=QMRW3dhMkP22ckKszmhM0mwpa8nZDbdac4chPtAVbm2Cq4wjxRRApxzqQMArQdj8SZ
         2s9YBmkCyxSdJMw12do9qvKxhT+tp+Q8rxpjy58faCxPIr/NnkWUkOWkqtZbLAja2Iky
         iwaG7lms6m9+Y/ZIwGlpbORrKr2IwezwAgy3/xxd6NFi4jVA/C8bd1OM+X3ERtlOzxav
         6/bpa386ITG8vORZvCrFCzTq8ar5AJbit+VNSMJtn51coSePrA0VGbqMi2t7OGH5HF0S
         Guermec+UPWXr5jLyNBCPxfzKbJTXho9s7wnuN+qEWy4SLVnxU6CT+TxB0O8al+JAEES
         uQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742514011; x=1743118811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b58wiqRkDo5hoUf5Kenjp5h6GZ6B9o4X0mhjbOTFFdM=;
        b=Ds5EEyVLzMwsDu7h2E2oS+/vcDftoLbjWhwT3ViiDhr14Mko0/fKHY+BXlu3zS4OVN
         A3P3fhKm2/uNVLIfqvZbF0of77YqKvipfOit5VCmx2NtgWP89RhMW0c0t33Vykobvnor
         kIKvszju9IBS9mcIhDUoBNSIwEQm3t7YJwn4X4yMM3xgH6/2wOsxovWopyia9WPT4qxr
         6YeKXzHhTMDs32tkvU8uizPPA9eftb4AC5FWMVhoKKa3rltygnlSYtHxccqyUQSRQwN4
         3HJeqN4nFdm4Q0FmhyX6tFOCy7SpMpBuVg3DQszEG8vk0JHTuZe2HYqtq0ViKV/rJ4kE
         yugg==
X-Gm-Message-State: AOJu0YzSYkDg/DNDk+IMKnJkV2FNHB0DPSFFCzulx1Awmdq7JS+Rj5z7
	EmBmSb9h6mNKEb25mvDfW8cgMhDxOr90zIGQtonZxpjh9YJJTu9x
X-Gm-Gg: ASbGncu6z244FmyXI+IV2atuhgFdeGUaAfR2uax82OFdfQ1+FweJYyKxgXWXTzeiCKt
	PuJTRrPl1ldZNzL2mTiBYx43wxsj1BMuaj046wfJSu9GqGK30F7zPaHSAn6Fyzjd0Ss864fTbNm
	MKKGLElxiWe6nGHs0ICyiRzd7+13qvZaIEjFLh6QoeD22jRhXC9OrZQwzkRKLuBmNc+AZxMuhmu
	0SdD3H8pgQKFRWrlZK1yuXs+SmSvx4PYgLOeYmPhvwxjMwy7mWT5BPcCf1R7X9S/ni6sleXj+eL
	sKd6vBBYsJRBvEf72hcjQwaE/kA/Fkj6sy4eBw==
X-Google-Smtp-Source: AGHT+IEcvsI2xlw2n/M9vj52WDBIi7beDyGTxDyNfv4DKnOotJHBOgYTCWYRPH/5eZxW14JEpUaFog==
X-Received: by 2002:a05:6871:724:b0:2c2:2f08:5e5b with SMTP id 586e51a60fabf-2c7802980b0mr1012710fac.13.1742514010890;
        Thu, 20 Mar 2025 16:40:10 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c77f05ec92sm198402fac.35.2025.03.20.16.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:40:10 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:36:35 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] clone: suppress unexpected default branch advice
Message-ID: <7id72d5g7glcp3xbsvhl4p2tpavs6dfisxhz7xvvdavdnkd5gp@nqznubj7rnbr>
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
 <20250320014646.2899791-1-jltobler@gmail.com>
 <20250320014646.2899791-3-jltobler@gmail.com>
 <Z9ukEUvuiPUQ3eiI@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9ukEUvuiPUQ3eiI@pks.im>

On 25/03/20 06:13AM, Patrick Steinhardt wrote:
> On Wed, Mar 19, 2025 at 08:46:46PM -0500, Justin Tobler wrote:
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 9eb66234bc..3b166b05e3 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -1523,7 +1523,7 @@ int cmd_clone(int argc,
> >  	}
> >  
> >  	remote_head = find_ref_by_name(refs, "HEAD");
> > -	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0, 0);
> > +	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0, 1);
> >  
> >  	if (option_branch) {
> >  		our_head_points_at = find_remote_branch(mapped_refs, option_branch);
> 
> Makes sense. You don't have control over the branch name anyway when
> cloning, so it's nonsensical to print that advise. Another subsequent
> step could be to turn the `advise()` into `advise_if_enabled()`, but
> that change isn't really needed for git-clone(1) because there wouldn't
> ever be a reason to print it.

As you mentioned, in this specific situation printing the advice
doesn't make much sense. It would probably be a good idea to allow this
message to be suppressed from other call sites if requested to do so
though. I'll add another patch that turns it into `advise_if_enabled()`
to support this.

> Do we want to add a test somewhere that demonstrates that we don't print
> the advise anymore?

Ya, I'll go ahead and include this in my next version.

Thanks,
-Justin
