Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2E6AAD
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146118; cv=none; b=HLOUnZ1Xz89z5VkOpR47EWEUi0BWKngpBO3O6tJvLPJ+sear/X7j4mco/ukgBSdb52YLp3HLqB09qqMmnMT6mxrz0wqyVVcm5rHT/bPPWf2livaQbdjFqQ3rFovkqwlZKas7rhorFQaogst4cRjhQ3UEj7W8Xxf2PEdwmQaO/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146118; c=relaxed/simple;
	bh=dR90d48bsUtjAespv214aaDf4i3SqKk/f+rPQsJPStg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEpsv4fwVAV/g+P2o6OBADyflIKbrk02OQLTvndN3De/X/22sopkxEPfjfq0FcOw4S5nlzfCAtnV2Lm7q7PEVSplU2/zybHwAQua7OzkzdeUt//49YXw/H03fYOGw+VLXl0gwx3xewqDW7eM2FmG4aVwOSHLZEKNuOf/gusgPys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R47Epwu6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R47Epwu6"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fc22a88bcbso2873327a12.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733146116; x=1733750916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wmizop5IET+/0cwxXMCruqs+xO3yOb8c99Yujh2blfo=;
        b=R47Epwu6u0Ed+gA5+nqU1T+QM5/ItuEjT6/vT6Csm0hCMIOZ9POrgcDOT6UT4csVN9
         JcZA8/mdjoswSX+tilw1bJU2orPVsUclFDbeuQlBy+ihTTVKg0ZSEN5fRpkWNMr393Ek
         eHhFRhnLAvzONobq7cxzCshVsYN8p2q1U7ElN9sMPNH4+JBpy1f8owasSOTbZNwN+sa5
         yEA4CG7xEQVfimE7EHcrQ1r+ReaS7kLAiw9dopn3C8v22x1GEQV+wh5PJAZEVUTj9zlS
         qMobGp435U7Lma8P+8sVLl0sTc0vWDw5MEIGUCwOLO7qkHvrRaFpg/ljGN5EJ9sX5k2v
         S4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733146116; x=1733750916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmizop5IET+/0cwxXMCruqs+xO3yOb8c99Yujh2blfo=;
        b=bahH9IPwW0C992Cq55rgUZCrfyi7M7O5Unvq2u3Amb63GQHGG6NxbeIdtbM8n5m9pt
         WiWD+7JEZOLEh9WX5Q2Of9Y3iSWWywqQy1sdhcfpvObSQsM0AxA+kYMS8UvCeg/5r2Vl
         HT0Z597jRBKPEippfk2ZgQHEYxd+81O2GcQBO9w95wbJZ7xGoL0/4NmXKDaJUmGzaiVC
         taBMgk/8x3gt/7ULZQ1njBHD5mOfWSFxbg6e3DvozRWYZLxdxgQ6AduKYqDhXjlSPdG+
         1agVqfm6Czz/2K7x5ucUSeLpdaiovM20kXlAchPuzZ1+5WtYh3b8VIsl14tzJI1doIEI
         Fy5Q==
X-Gm-Message-State: AOJu0Yy/sGtHTOK6lFD8LtYsZYJxe95yqMhuopY+fFGXAcHTJVus8lMN
	sFKiBdME/4jPjb/eacgz0XbN56iDaXegwclD4Q9Ae/PMLkY6IOgSBfDAEw==
X-Gm-Gg: ASbGncuWxhwEgb8OKstx4whsV0VgpIAZtTPOSfzysZ2pDqrt2RRKlLywhCXNyw7ry+B
	IdI6LHT0/inF3XBaNYVpwSeEYYviiGh1996rWkczK07VFYwTINijiNDWDvfcSQ4X7bmUI38LbTl
	e9bDtZt1s+ozHWEN+dy+Lx3bpzqRExDDHnvwGQcthq15E2j0ZqblmQAFOqnVPmp2ouR0TmefxoZ
	1rWS/OrFBhy5NMl/Dg4NAA/U4di7lWUXCob49KqNRtZJw==
X-Google-Smtp-Source: AGHT+IFaa0ib+lrMGUeyNlWzGwvl9ZqwbLJNtGLcrZpLicFnKnBg1ofUwA4hsv6WKHcGYGbeE9gJ8w==
X-Received: by 2002:a05:6a20:4394:b0:1e0:c247:21d2 with SMTP id adf61e73a8af0-1e0e0b273bdmr37043344637.23.1733146115766;
        Mon, 02 Dec 2024 05:28:35 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c38585csm7821232a12.61.2024.12.02.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:28:35 -0800 (PST)
Date: Mon, 2 Dec 2024 21:28:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/14] Start compiling with `-Wsign-compare`
Message-ID: <Z022GnVCCGhlU-uF@ArchLinux>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>

On Mon, Dec 02, 2024 at 01:04:32PM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> when compiling with DEVELOPER=YesPlease, we explicitly disable the
> "-Wsign-compare" warning. This is mostly because our code base is full
> of cases where we don't bother at all whether something should be signed
> or unsigned, and enabling the warning would thus cause tons of warnings
> to pop up.
> 
> Unfortunately, disabling this warning also masks real issues. There have
> been multiple CVEs in the Git project that would have been flagged by
> this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
> the vicinity of these CVEs). Furthermore, the final audit report by
> X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
> that it might be a good idea to become more strict in this context.
> 
> Now simply enabling the warning globally does not fly due to the stated
> reason above that we simply have too many sites where we use the wrong
> integer types. Instead, this patch series introduces a new macro that
> allows us to explicitly mark files that generate such warnings. Like
> this, we can adapt the codebase over time and hopefully make this class
> of vulnerabilities harder to land.
> 
> Changes in v2:
> 
>   - Explode the 6th patch into multiple patches with more careful
>     analysis and refactorings
> 
>   - Drop the conversion of "gettext.c". To do it properly we'd have to
>     fix the return type of `utf8_strwidth()`, which we have already
>     marked as a todo.
> 
>   - Link to v1: https://lore.kernel.org/r/20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im
> 
> There are a couple of trivial conflicts with kn/midx-wo-the-repository,
> but I don't think it makes sense to make that a dependency of this
> sereis. Let me know in case you disagree and I'll change the base of
> this series.
> 
> Thanks!
> 
> Patrick

The range-diff looks good to me.
