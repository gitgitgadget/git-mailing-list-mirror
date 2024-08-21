Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3516F0E8
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272129; cv=none; b=fao+HylYsCqxgfrvoi/YS2QawiTmWFgplRgH2Y5HCYLZw67bTI2VZtHX3Lj9yFZoWEYyOusOf4Bp81UiUFMewQXjyhsZdhz86BqjroXKnb3/VabITwPtvsnsthm6dLDz3KEmMOIfp6Cxhk39DAscOXuRGr4ZZy2aPAmuGfSXVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272129; c=relaxed/simple;
	bh=vHq503Ul/HS1yrijxAYtfxapxqJuKtU5ydxzI6UEmcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srmSU9FCmRNbiFAECW/AMbbLyNeD9RyWJ8QTHzjsIBKNAvn11x9R+wbsKRqSrkAGURy0HWhPS77TObSW+FgCF9knnIv1FByt+4jp1inIDqGVWJRZmoyBbKqPD6ZEwgRQCLo7DRGaqrQTnZSTv/NIx5jDpNLEJ5NQaIN438Xnrqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJEgA7eX; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJEgA7eX"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45006bcb482so782791cf.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724272125; x=1724876925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phmfn0w/nR1wJGEef/rarMZzpKTd8ag8qjhA7ep8i+E=;
        b=gJEgA7eXOn9zQf8jPErepe6XnTONDBZsHjDcgrnlQKdcMk/WibbzbyeH4RRaUQ6Ve2
         jEbPmkFrher1XJDtkKnsONUaQSDREJN40pcKL7qaShWI7m4+1cIl+61eZbQ0C+7WwCvZ
         cZn5XmTk8DP/hFgP1Um6vhZMjQIH7eb5WbRyif0OMiZFIoFfKyXQ+dXSdRxWB4F9xHcO
         AHWdEmVujUru9KGWJKmcPy/1INPdishsBT2xukod3Yop+W7zwlyisatbrIq/tU3M8Ya2
         yCfufqyyZKpssgEwa5mQ+Ak0+GFASR3ZF0lWqbYzdUnkfRUbp09fBdXFcWwHIV7XY0B/
         hUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724272125; x=1724876925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phmfn0w/nR1wJGEef/rarMZzpKTd8ag8qjhA7ep8i+E=;
        b=Vp6cisyCj8DyfLAuJjH2zFZ9Jd9rgy1OpWb6z3l2+HxGGMe1tQmHrGH3yHICvnwCY+
         wMMFrFMyhDeWR0KGb7njlxYLNSwfADxbZ294VTaxzfQ17qw57iIJEcK2FiULS+Ysky5+
         1xKz1ENar2hHdLzAZXgdy+IfxrAW5dri7Dk0jhpJE8kjBstf24IWsRUNLzyguQZehGDz
         rwBxcEeqyH3BMHKLD1gBa7KVzpM053iy7o/KHRKxCgqq569n+zdGAzVkhtk2FAYoiiBG
         MWMVVKNC/XaLFITe9Y5Huk0hh8CRTco711/9V6BYlWUiqbeEWeV8r7K37SlRNgfe63ke
         scqA==
X-Gm-Message-State: AOJu0Yx9QUSDGB9SLh8U5H9zgW8U8BnetTI3cwCZ70mMdv5OaVR8bmXf
	9V6dy4H9Ajw1UIzMUGTAdIidH9Dn4pmfTgbTCATi7LI1x/z1otl8ewBnrZ4ER8HunDMGOTvVbKJ
	xYZE9V/XXeGbIHngBj/0imYyg2JOxaNQC
X-Google-Smtp-Source: AGHT+IEjz4EuIWxeDEiVZAilbjwo6e4A9jvUFRyEmfDHXP10Tocd+FMovMt7wOR/16Cz+MUepz2kgO5AM8aGUQFd8eg=
X-Received: by 2002:a05:622a:4894:b0:44f:f7c8:b157 with SMTP id
 d75a77b69052e-454f25872bcmr37205901cf.55.1724272125366; Wed, 21 Aug 2024
 13:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEg0tHTWzgD5bw3oK7-Rtv9oTymqyhvZz3bcJ7yNRhF8wXMLGA@mail.gmail.com>
 <xmqqttfd2734.fsf@gitster.g>
In-Reply-To: <xmqqttfd2734.fsf@gitster.g>
From: Yukai Chou <muzimuzhi@gmail.com>
Date: Thu, 22 Aug 2024 04:28:34 +0800
Message-ID: <CAEg0tHQVK9hgcHTzn-ZPdwoFbbYFB2joeT0jLQgtD6yEH+1GiA@mail.gmail.com>
Subject: Re: builtin/config: --name-only doesn't imply --show-names in "git
 config get"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8822=E6=97=
=A5=E5=91=A8=E5=9B=9B 00:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Yukai Chou <muzimuzhi@gmail.com> writes:
>
> > # get empty line(s)
> > git config get --all --name-only remote.origin.fetch
> > # get lines of name(s)
> > git config get --all --show-names --name-only remote.origin.fetch
> >
> > Either the doc or the behavior of --name-only needs some adjustment.
>
> This argues for making "all" imply we need to show the name of the
> configuration variable,

Sorry can you elaborate on what that "all" meant? A new option "--show-all"=
?

> and introducing an option "--hide-name" to
> omit the name.  That way, you'd need to give clearly contradicting
> "--hide-name" and "--name-only" together to get a nonsense output.

I have a feeling that finally a collection of options shared by "git
config list" and "git config get" will be introduced to fully control
what they output, and even make the form of output given by one of
"git config list" and "git config get" look exactly like the other.

An ideal design:

--show-all
--[no-]show-scope
--[no-]show-origin
--[no-]show-name
--[no-]show-value
--hide-all
--separator=3D<sep> # fuzzy name?

Initial options
- git config list: --hide-all --show-name --show-value --separator=3D"=3D"
- git config get: --hide-all --show-value --separator=3D" "

The drawback is, quite some combinations of such options are nonsense.

Yukai
