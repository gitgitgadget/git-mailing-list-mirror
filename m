Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A21E3787
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971393; cv=none; b=S0PTazamWsgG9v5M3Aej4yAO6qrJhfJQ87y7RifLRr6dXdMLBFTM9ig+BJewDSkgd4O1PeNqvPS49Gn9FQde4yvYosZFtn9mfJbu4sU3eUGvlrl+eOV5uD0Si+Wr+wSFs5/VXvJcLniWjaMrp9BCAOP6imcSMOkT4Df7fjLZaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971393; c=relaxed/simple;
	bh=3sHLqD+RI2wKdyHqy+5hnILT8PQ3Rc0cdhQfPWI4NFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbqAnXYdH5jL/m1+JJ8pfR4YN/MCDHAg5C+cvpTjDu3xD0V2AABVbKg2EBjmGgSNUAgxg6QdCb+q6mhoPpX1qhhhXTxeEvrSJ8xDdoPvi2E/XxGjmzZrdAhp11bQ7nFtdks/RLp2KNqlmDbVZDa6sFit3cdi6eYylUSP/7fyU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3Bh9NiX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3Bh9NiX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f2339dcfdso14440555ad.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 05:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739971392; x=1740576192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aO6aJbXMCKxlmYutp2zYyUElzvmOtp2FWixY0SB6Vqs=;
        b=U3Bh9NiXw0FHWWIX7t93K+l4vIUxeyOGA+gDmXO3g+mp71Ju2TC+3k17wbBSxFbIPy
         QPAB+v090QlSLuN+KnG/FIN3FV0Rm34aOlJNEhHguHg5V4olwHJUDfoVvmAkodQJEexc
         F7SwuokxNrK26XTVD8Y1fHp4Hm1ADto7ROCpiorLdPeHis8sHpZUjOgF0aKGanCsUefU
         uJ23HB3331Aa5/rPxTtE5QORJAJs/Lef/4YdODioqjw9b1kbMr55wFZJKuRFqifVX9cs
         JpMX8itGowqy/049e9u+35p3kr3tEwnJLjaFT79tdXTJdD/eiS4RLuGTW0+SOikVG/L1
         LJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971392; x=1740576192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO6aJbXMCKxlmYutp2zYyUElzvmOtp2FWixY0SB6Vqs=;
        b=Q+yHdVXfGHacVPfwt6teqz+UxHEAQDN6ePd/TmRiLMFRU4PiaBOxRhpy+eXovMF6Eg
         o/kgigCGwE0sK8uKQstfdrI9f8oBcX15PrTyvU1Z3pyFC807WMetYtTPPIJW2DjqOpl8
         +EtAn+p5F+fIlhe3UTSfwNO8bKXTp574x4N46Xt9PzxQSXAYGhReONgA39zbeSg9IsKx
         CMUgkJ8TWAj8qZ2hCk5jHdOf6BHnKtkussgtSzXRIjT18vmRHtYOxtcKD2o/9ALsOV4R
         tTROZqTqypDepGIF3UWJ3vvaOIibvgT4o8Dl/MWgL6VFsdNZbCPyhICSqQMCX3W/pNLb
         IltA==
X-Gm-Message-State: AOJu0YxOVXUlaaFtVAgS9RYiJgwZo0ThGPUq2KW/Gbd9lq7mUu1oi8e0
	aa9guTsvDph/wQXLEX2F9EHFNIreX/X+LEsmu2Tm4sUHlISLBhrl
X-Gm-Gg: ASbGncuY5cGAQ5xLfUuHIAsn+Uw578KrDnntOQ1aoj9jpIlunNDvc3reYnIxYEYw3Qe
	kyurIqd6OuJkLUBiuNicoZiKvI2b4pKmJVRrCfJsPPgjCfF6N+qnNki1NbB1GIJmVij37/ymc9F
	3T9sdKuRkIliwxcLLyGDEWCL8hkCamc0A17ltbkfh7PDMvq6qVc3uCoTvbwyEyhNXWMhx+G6nqj
	G7jO1Hp5TAh3FYbpH96MBt7dYwmPobWBfVSjwYF+lX2uFHGVDx6vED2DF8d0wn0qQ8wdN+WrkFM
	ui0K7cCioWA=
X-Google-Smtp-Source: AGHT+IGXfs48OXo/0r0U2UEHi1rOv9MQ1T8W3xotrMNbs+KLP63bO5lzJzlDCAGoDREUPT2NrC7qEg==
X-Received: by 2002:a17:902:d2cb:b0:220:e91f:4408 with SMTP id d9443c01a7336-2216f110ff9mr56835995ad.22.1739971391640;
        Wed, 19 Feb 2025 05:23:11 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d537c921sm104348705ad.104.2025.02.19.05.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:23:11 -0800 (PST)
Date: Wed, 19 Feb 2025 21:23:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Message-ID: <Z7XbP6O7Ul8Ln3WD@ArchLinux>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
 <Z7S6xzmPb3lK-SdT@ArchLinux>
 <Z7XF5pGsa42jrIcN@pks.im>
 <Z7XRX1gfo942QdNR@ArchLinux>
 <Z7XVoeNMjXJnlrmX@pks.im>
 <Z7XXcp9o0fb7FloS@ArchLinux>
 <Z7XZ02obxTyj1tGO@pks.im>
 <Z7Xaj78hBkMt00CN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Xaj78hBkMt00CN@pks.im>

On Wed, Feb 19, 2025 at 02:20:15PM +0100, Patrick Steinhardt wrote:
> On Wed, Feb 19, 2025 at 02:17:07PM +0100, Patrick Steinhardt wrote:
> > On Wed, Feb 19, 2025 at 09:06:58PM +0800, shejialuo wrote:
> > > On Wed, Feb 19, 2025 at 01:59:13PM +0100, Patrick Steinhardt wrote:
> > > > Regarding the question why to even rename `ref_iterator_abort()` itself:
> > > > this is done to avoid confusion going forward. Previously it really only
> > > > had to be called when you actually wanted to abort an ongoing iteration
> > > > over its yielded references. This is not the case anymore, and now you
> > > > have to call it unconditionally after you're done with the iterator. So
> > > > while the naming previously made sense, now it doesn't anymore.
> > > > 
> > > 
> > > Good point, I didn't realise this part. Thanks for the detailed
> > > explanation. I will continue to review the later patches. However, I
> > > won't touch the oid part, because I am not familiar with this. By the
> > > way, I think we miss out one thing in this patch:
> > > 
> > > We forget to free the dir iterator defined in the
> > > "files-backend.c::files_fsck_refs_dir". I have just remembered that I
> > > use dir iterator when checking the ref consistency.
> > 
> > Hm, good point. Why doesn't CI complain about this leak...? I'll
> > investigate, thanks for the hint!
> 
> Wait, no, I had been looking at the wrong branch. We do free the
> iterator:
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 11a620ea11a..859f1c11941 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3837,6 +3820,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>                 ret = error(_("failed to iterate over '%s'"), sb.buf);
> 
>  out:
> +       dir_iterator_free(iter);
>         strbuf_release(&sb);
>         strbuf_release(&refname);
>         return ret;
> 
> Patrick

Oh, my mistake. I omit that part during review... Sorry here.

