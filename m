Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23EC5337A
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485041; cv=none; b=F4puqJEtPkReFcYwngJC7bihzAoTEAw3GVIItSA45HxtrENVfKntLI5msOnb9POuaWphXXZMxpVioGqrwcRRPLWrDiMU/o2GEhYLAVFCn1zLamqrlDMj0xqMhGj/ic/95ADxZmKj53ufv+7Ha7Tt24YMZm1JhL3RyCm6iL7EZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485041; c=relaxed/simple;
	bh=tT5jHdaKdguV95VaKNQ+Fz1+sClLvQYmhgDkWLcRaUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCvDIykhH9nRcumydaZJK+XINVo9rTgM4ynB3NhQQLidjNvAKfoR+zKdbzu5NUpdQErAK+aeotrUQ+KRnsQxdjsahs9ShRwRuMa74WJyAX8k103GHf3z3lGhEItPw3FLLCy2G6sJA40SLPky14fOr1dElxXMeFFLIJhpegGSMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aoYd1923; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aoYd1923"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430c4e67d40so38861811cf.3
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711485038; x=1712089838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX+R1f8vZ+O6LMBtbCGKA941PwdA/E9Rm/oSST8e+rw=;
        b=aoYd1923RNboPdF8TBVA1/qQw2uTBLA3SHZ9QgXuvkX/yLMDJ/mKpb+cypNqlrl2Bw
         qAYSNZxoG6Mrp4AQ0gizGlWDi5DhZohQZa2iTJGfCHyiVTlbu3FI5ac1x2+5UmaBKdiV
         FXx4wwT5xm/FGqJ18Pu5iBuvoK+QSztVD1FYHVgHNEqJyRNWtdZePae4dsHCZM0dNKxE
         RyiSAxWAi9UffNrxeDcsYZLRn0smDmuO873Ai4eaXKPInGmOev4SVE9BqBP/iLtN+SPh
         n7kjIcrGnbHeQE02aOSfTWQ1MGi0rfG+WLVt4O782GNCo+w228/fUYMqwrrmT4CbmO1k
         aRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485038; x=1712089838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX+R1f8vZ+O6LMBtbCGKA941PwdA/E9Rm/oSST8e+rw=;
        b=PMX+Scu50CedLb583FSIz8PyrSWzH4yAxofOaYYXlAyH7+uejaSbtYJvXi8v2fXDRG
         FBCvErnwGnIbjxZzd+mbIB/2ogb3pMhKrsKg/uZD5d86bRrZVYsJUBToJ2t3SBSFsEa3
         UgsRrN4RMCKHVSGctKExmlcqikSDIGqqDMFtYkENY7ARq9y9becMPFtgKyPyLX9l0256
         h5wwklA2sK6XchPgR0EDDzRdm4I01GTN+/YGHHmt5+cMC1vShiUWHdWSbYbArcfnP+XK
         OOrZ1tLiGGfR34I88QwpD4FS4mRI/2zoeQH+t5gLWVwf0H2lQ3WvJUTxEm/x3b5hQoTo
         eQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCWwOSLZ9FikSw6PF2GQ4qjjXi2nPYBo+za65OREr0UrnnM2bnw6lDnzdvrqUL3MZhOgmJ/6WJ+1sOSRqXkpfqp//q1t
X-Gm-Message-State: AOJu0YxAt+AqQwdsf71DHKyxKNX8R7XNAc/oGvwMGNYqyZy7ZD8gGIRm
	pQ4d5hlCKPgnrbu/VrE2g+f4nZVYmkBc2VVMTmFDapFCmHbS1UN/Q0hPdu6YXNE=
X-Google-Smtp-Source: AGHT+IGfJAU6W9MXiIY0aNwfL4mbi6HqSnFN8lLZyi2aKkyDvflL2CiYk1GhXsQX+bv9AbSKjY6grQ==
X-Received: by 2002:a05:622a:5e8d:b0:431:768b:c42c with SMTP id er13-20020a05622a5e8d00b00431768bc42cmr2343409qtb.62.1711485038616;
        Tue, 26 Mar 2024 13:30:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05622a489300b0043140b00476sm3841337qtb.83.2024.03.26.13.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:30:37 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:30:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #08; Tue, 26)
Message-ID: <ZgMwaG28aoC7Njcg@nand.local>
References: <xmqqle64algt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqle64algt.fsf@gitster.g>

On Tue, Mar 26, 2024 at 11:37:06AM -0700, Junio C Hamano wrote:
> * tb/pseudo-merge-reachability-bitmap (2024-03-20) 24 commits
>
>  [...]
>
>  The pack-bitmap machinery has been extended to write bitmaps for
>  pseudo-merges, which are imaginary commits which act as octopus
>  merges covering groups of the un-bitmapped parts of history at
>  reference tips.  This is good for ... what ...?

Instead of "this is good for ... what ...", let me know what you think
of:

  This allows for greater bitmap coverage (and, thus, performance when
  using bitmaps) of repositories with many references which ordinarily
  would not receive full coverage.

>  Expecting a reroll.

I'm planning on sending one soon, but was hoping that Peff or someone
else familiar with the bitmap machinery would look over some of the
technical details first.

>  cf. <ZfyxCLpjbaScIdWA@nand.local>
>  source: <cover.1710972293.git.me@ttaylorr.com>

Thanks,
Taylor
