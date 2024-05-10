Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399324D117
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715371469; cv=none; b=q8NPHkgidS2/u5s+EXdczCBjXdnRIlSsYsHsxPi1TzXeKyUFRgtYQaX4g+FrXJ8q9Xfij9v9EXrjih75pNWszwbyEyNX1GVgoJkpDpMsf+PN+MwCoTDj7GTbrxTRiFfOSF3sDq5XX0YbNkySTATAMAe2N2m3LBoBpqJ8dljIE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715371469; c=relaxed/simple;
	bh=AX3DIEyIByxaCRU9LBJONvBDtko3G5HD6vL35o+fg+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4ggQeptN6G4Hi7hxzT+xpL3qmDfftpqATgLf8FJxwAi7HSP/h67s7xDehUqENOCnw4HPt1JAiK7ivHEOTkGLnHHeHxxf0YKjf/MS4y9MT5HlEbY+ioESblIF9GXry+in93IoO7STqQleey7irhGHxrizco9QFroR15J+Pex7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJPkDuEb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJPkDuEb"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ecddf96313so21152185ad.2
        for <git@vger.kernel.org>; Fri, 10 May 2024 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715371467; x=1715976267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iu48rBOpTj5rSgpGCSIiHvHvCeVknesRXl48eMxEbik=;
        b=LJPkDuEbqQGs3/7Z3e4Gt7Mz85WcDbbC0btoErG46CIz5g3zJZf+D6Z9XmMK/qjXMf
         Wbt9XtEdPlK7zKttJVN9Qj5dg/wYKoQSK/8b6Y7/+PXYM8ID4gDL8FNVsjdQ2Gf1dyAP
         YoI3pf4icuX3uVRo6pLAUM7mn/qb9pQD/ibTdjh06BxvF4GJB6yAmXO9C0kGaHBSni9r
         dx5hWvb7Kf+KlJxsJoLehID1WlJQyYX3jQlN/ALRiKxpgo6cBRxIi72K3M+cZ7qnc0Vu
         otevoWkKwkR7TtFzDo4dMjKClRR5ZhZz55Xhv4ay3OOTliZ8BDFxtqxzseoTEWC/Pbnx
         GJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715371467; x=1715976267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iu48rBOpTj5rSgpGCSIiHvHvCeVknesRXl48eMxEbik=;
        b=XV4Golun6mrQGuc++PW7g5Vivy+Bs0h2tqtivoBViHvO8r3Q+DM3sxj3Kc6c/v7fAF
         YBMt9suswkBHPNN8xQnyazGAQr3pcH0FvdSCATsOh16nUSjZXSs1Bqy4XMgEtzoM1PiB
         Kr3MpzPEJSbKEAInm0zt27fBHX28duOkLilOEVtpHMz5duPsYST7YqkgkVwj6V5U6H8T
         ZclJ9nPQKqVgGpGzYDiOtrf8YjsoveVzvnBPgeHPQEM3pYp0aEO6e2yuGHV6DjsMhtfA
         JHiMEXSlTDffPM1DsDI//U1qsS/mE1lJkdDV/qCTjnIyVk/XPtfQlbqEtgerJej0COUA
         uMCw==
X-Gm-Message-State: AOJu0Yz0zcY5eqgg+Xc8lErNqMym32pdX4IRAh01yFR94UGjKSdLBQPX
	Be/W79a6tUgb1ch5xoT0YUD8Aq5C74RsA+A0REQ5vWbf/Nw/o92A
X-Google-Smtp-Source: AGHT+IFsB3DCicl6LeKDC7EaiGeIDiTmbMtKkKnC1HOa3iKWAoNRyr6Bqxbh4MUPg6PSwPJd4/Qy6A==
X-Received: by 2002:a17:902:b949:b0:1e4:48e7:3dab with SMTP id d9443c01a7336-1ef43e269ddmr42047755ad.38.1715371467355;
        Fri, 10 May 2024 13:04:27 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada3d8sm36345305ad.99.2024.05.10.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 13:04:26 -0700 (PDT)
Date: Sat, 11 May 2024 01:34:24 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Jialuo She <shejialuo@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC] Welcoming our 2024 contributors and thanking our
 applicants
Message-ID: <5y4e3tdyzmybhx4zknp7sekfh6me3qhbdejcoqim22u53bngjf@anmatbfglgkm>
References: <406aa31f-4ea0-496c-aeb6-443be86385c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406aa31f-4ea0-496c-aeb6-443be86385c0@gmail.com>

On Wed, 08 May 2024, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> Hello all,
> 
> As you may be aware, the results for GSoC 2024 have been officially
> announced[1]. We have 3 contributors contributing to Git this year[2]. They
> are as follows:
> 
> 
>   - Chandra Pratap
> 
>     Project: Move and improve reftable tests in the unit
>              testing framework
>     Mentors: Christian Couder and Patrick Steinhardt
> 
> 
>   - Ghanshyam Thakkar
> 
>     Project: Move existing tests to a unit testing framework
>     Mentors: Christian Couder and Kaartic Sivaraam
> 
> 
>   - Jialuo She
> 
>     Project: Implement consistency check for refs
>     Mentors: Patrick Steinhardt and Karthik Nayak
> 
> 
> Let us welcome them and wish them a good summer of contributing to Git via
> GSoC!

Thank you for this opportunity! Congratulations to Chandra and Jialuo,
too. I will post the progress on my blog fortnightly. Here is the first
post:

https://spectre10.github.io/posts/gsoc_beginning/

Thanks!
