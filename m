Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D322D374F
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765533736; cv=none; b=BdQ6GPYN89CoQjBQ6MEAnDU7lwL6uPpJSj1wBWZqZMo3txJUtBTuF6OgZf9zVZTAB2iqOcD33cSXkd6IBD7usz5S+7DT3BHRsgH+7VJEY5B9LqDK/oblVrtncMFTcXBmBGqt/kFfpo6/SaF3VyLUhN+ptb7Bev38fTa/4fOatdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765533736; c=relaxed/simple;
	bh=8C1if5dRKbh+RJtNlEt6VESvGzHs/PHJspjvRbcppAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTEGssZfQzHBTF2QtcKxv9CgLr8HGqlP8VrirfCD1NQ20GNHu0ajoTnuMsSSMJDKVEeexP5YYeGLnRt/+QPv9RdjAjxq6gpoVk1zyJ1QDoeQgPpHUpOPzo6tyNvqmYyu/0u+eDzKyIYuOknwkYbRnTEEezJm3eXKT3Ne02lnpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnuOQM/G; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnuOQM/G"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29845b06dd2so12491515ad.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 02:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765533734; x=1766138534; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zz99LdV+C+5R0QWrOYqykNgvCejgPRglat1jJjKJNDQ=;
        b=HnuOQM/G9f4QoVF5h8TL8TeZXLGDsxSGBc/GwjUcLjjrno+ZelKxbkKgJAfZp0cPw/
         TVhF2tUT90mZv1ZwYJ1GKGfvlv8X5do+A0+eRBB1nGsXwezkyAhNrMF9CXIHD+8/Si7t
         XTl3pHgzg63kLjS3km7oN2MY/Ra55ptKFHA2TECt4iPhxx9AcBlq9lGQsxCIPuFpRrIS
         RUP6aZBHdazChnlaGd8rEUZMQdJUkNtCbnv4X5Ey+97Ox9WyJJGDRSy0TTRGrPRSh1dH
         PDoMHa1xVOsHP1hiJTLvxcXg2QvY70us/uiM6YfjyNhGk2Fnjhx6lSWcZAlixQVrkNjn
         c2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765533734; x=1766138534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz99LdV+C+5R0QWrOYqykNgvCejgPRglat1jJjKJNDQ=;
        b=gGT4mzSKxxCjf+JyJydTuh8NN55GOexbX3o7y50V9YL2r+gXhOkLuqROWvZv2G4lu7
         R7KqgD2y3j1HgPhYqK4Ebpp/r16PJdXgMLu9FYEgd8GXhbU9nNUn5+1Bl4unj3R5gIkg
         8RhI+16vNe8I6qsrDwCs5MwxMuP/PjDp7C6EQT7Ow3YAAqRFrHYq6eSVA9AJQD4QonB7
         HTKuZGvAc9kDgR45694JFCeEDQTvcwvbF2AY7WwxwpPS/VagCdsO5RKx6KEiBEk3+uFd
         6mqPGs3FaTa9Z2oMKwvT5fMSQk8N8v+iTOqOhqatAEnxy75BuaVE7GkGQ2V8X4rtNGpj
         YgAw==
X-Forwarded-Encrypted: i=1; AJvYcCVHbIZYSSdW9TOgkfTAAQqHxKK3gawf+0gliz03RPh1QuGgTlSR1zCe/N82uvxW6Y/hFIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrT4+qvVjFd2McNDHgxWvOBRxu7u1eh++SC9Yf4dTUVrvaSCgr
	+c7ral3aEuGozAzrzhPmBS9kRytaT63Yv3t4NJ+PYEYbr5mMqraKMG8P
X-Gm-Gg: AY/fxX4p4EPk0v1Ek2L1zz/wPWJv5jqoxKJ3wIq5JF5D1kfvrkQfsP7Svtks70uuyNm
	LA+RjhaGW+Oq77oFpfuEptbaTP1O4evBLHizycFzey2bEck/2/+DyoE8MXWKtBECpUFb5QsFv5r
	Wco/BhdOVwBM1CLKL6Rkg3kZb2YYsZb8eRXEralllNnvN+V0JXTvKfMnr5OzFFXD0gD0MNWFeUD
	ALcLwn41CSm5sNpVIVlpO0zhyX4cI6DFnGGEixOpsbiIJJYgc/W9A5x78ZTN/Pi+MlDpgFqzv9R
	m0c0SoHZzFP4zVjWlIB0EYjgpkuQz8U4QAzPq6FrH1fq15MO1CjacUC0pfWG5bBcDK07DR3L93J
	m3OH9bRo1YMKK+5cRW5/quJw6BZEa8BhhWjY78r2nOtKHZFbXSMMzWt6MmsbcyU+URjcxOS6de6
	V7dbZwlPWXuND3na67HMZ+0Eg0THFvIJqJXt517Xctn0XiFMB5wSUxuHjByXNd4WGhYaWeLmTVu
	2fD2PzDG6eM1tmF7nx1g70UCN/e93NCJdBVPjM=
X-Google-Smtp-Source: AGHT+IFiWHTxnw6suOkkORUTGP5SauEqMZsL8BL1mjSN45FlCcSOmbS2iP04roNKL32eIqZ6ICkZew==
X-Received: by 2002:a05:7022:f319:b0:11e:3e9:3e96 with SMTP id a92af1059eb24-11f34c3a095mr788776c88.50.1765533733919;
        Fri, 12 Dec 2025 02:02:13 -0800 (PST)
Received: from Carlos-MacBook-Air.local ([2601:640:8e80:3680:98c5:68b7:30d0:ac4a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e3048d9sm16274965c88.14.2025.12.12.02.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 02:02:13 -0800 (PST)
Date: Fri, 12 Dec 2025 02:02:12 -0800
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
	Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
Message-ID: <mmbxugkhxhioxdx46yz47syj2cvj6cfukmzfxtdx5yqolmsc65@ftfrd26tenco>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
 <qnb77j3b5m6rfbzr3qhmwalo5lha4gqslvzqsfuq6zur74ze7j@wqriu4w7wbzw>
 <1b3509d7-e421-4136-a62c-de86213d65b2@web.de>
 <xmqq7buthgq4.fsf@gitster.g>
 <vxi7g67b322sre7ylkcfwujf3n34j3f5vtpl62zhrj4ds6f675@hyyh2rxhaib6>
 <xmqq7buse906.fsf@gitster.g>
 <3ac57efd-a0c6-49da-b63d-825d97b3821c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ac57efd-a0c6-49da-b63d-825d97b3821c@web.de>

On Fri, Dec 12, 2025 at 10:16:02AM -0800, René Scharfe wrote:
> On 12/12/25 3:20 AM, Junio C Hamano wrote:
> > Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> > 
> >>> I am looking at relevant parts of Makefile
> >>>
> >>> # Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
> >>> # installed in /sw, but don't want GIT to link against any libraries
> >>> # installed there.  If defined you may specify your own (or Fink's)
> >>> # include directories and library directories by defining CFLAGS
> >>> # and LDFLAGS appropriately.
> >>> #
> >>> # Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
> >>> # have DarwinPorts installed in /opt/local, but don't want GIT to
> >>> # link against any libraries installed there.  If defined you may
> >>> # specify your own (or DarwinPort's) include directories and
> >>> # library directories by defining CFLAGS and LDFLAGS appropriately.
> >>>
> >>> and notice that /opt/local/ is mentioned for DarwinPorts.  The patch
> >>> that started this thread talks about defaulting ICONVDIR to that of
> >>> Homebrew if available, but the new code checks /opt/homebrew and
> >>> then /usr/local/ (and let it override it).  Should the log message
> >>> be talking about DarwinPorts as well?
> >>>
> >>>     As a workaround, set the default libiconv location to
> >>>     /opt/homebrew when the user has one from Homebrew, or
> >>>     to /opt/local when the user has one from MacPorts.
> >>>
> >>> or something along the line?
> >>
> >> Since the original patch was only meant to help with Homebrew it
> >> might not be worth mentioning the OTHER package managers IMHO.
> > 
> > Meaing that the original patch should have included only
> > /opt/homebrew and we should drop the part about /opt/local?
> > 
> > Or do you mean Homebrew may use /opt/local instead of /opt/homebrew
> > and both parts of the original patch are needed to give coverage to
> > different Homebrew installations?
> > 
> > If the latter, perhaps we can say something in the proposed commit
> > log message to explain having both /opt/{homebrew,local}/ is
> > necessary (and why)?
> 
> Homebrew uses /opt/homebrew for Apple Silicon and /usr/local for macOS
> Intel (https://docs.brew.sh/Installation).

not always; you can install it anywhere you want, and indeed you might
need to (like I do) when given access to a remote instance of macOS
that you have no root on.

as you mentioned too, these settings are in the wrong Makefile (mainly
because they predate the split and creation of config.mak.uname) but
also because they are TOO peculiar of a case to be inside the latter
and because changing that might break some setups.

FWIW the use of "user" package managers is not unique to macOS. all
other UNIX have them as well, but luckily they are far less popular
and their use is declining (ex: AIX and Solaris the main two that remain
once HPUX is sunset, and not counting NONSTOP which we support directly)

Carlo
