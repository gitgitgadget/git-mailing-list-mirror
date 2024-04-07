Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025FFEBE
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712454611; cv=none; b=ohii24Flo0dqFR9ceiF2C3F9wDoojaBSsA+Kh6Id/S+HIihL8e9qK948U5no5zP1ynInX4ledhmthki7GvefjTvCDRzzIutP/0lEJxtBpoFsAHZ1WfTPNn0Ju7Yi0I2L2fZahYrys9D2N4XQHzLnx7mxgTGu9A5Nnt4++0DeqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712454611; c=relaxed/simple;
	bh=/2DRnj4yOl/S8uu1oyIW1r15mI+JCqV5iOD9s85Zf7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea3wjbxlYjONYw3l8bmEpRJSxGx10GtpOUjtmvpUBiCswssEwVbU5v1P0na7DJTQA4nqOdB99RZcVa+ITFl6I0kqK2YwU4DoDx3gMODSTGJzzG9a4OqiiM7wx0dPUrPwbaspYCm4Cs6WM3FUuGkIBHkXBFaeXJBhbPZ3dgx77CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX/TLieQ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX/TLieQ"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4f9f94e77so2032449eaf.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 18:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712454609; x=1713059409; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+OajewHaAUNF9BkXehzXtGBK6MqEq6CpJU6zFa0PAE=;
        b=cX/TLieQbOjkNCMCPbddR/2FcoeOt65PtblDTgCCyPZ8wMLgKHPYWgv8bfqAb++qwr
         YbducvNXQ24Uh9ajTQXToFRTXo6Y2Wi3mLcW1wwSlfpVS+/jpfM2TSk04DpQMQJDj1PG
         Dieow/36LqTmS45uLdbhx/cjZn0UqJuFkf/jIMVY37NrIERX6mYCU+7BVT591/PYI6I2
         RvJeKES4bxsm8OjPHDqKKPpA1mYLSzYr5/7XsTpmQx3p0eBmbcOMJBxacHmZBq+Pr+cv
         ehEG72oUMz2ho95WjyHP2dGyh54IxtispJQUIjaXg2Z6QDl8vCbrCc9hjrMoKst5gOI9
         hpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712454609; x=1713059409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+OajewHaAUNF9BkXehzXtGBK6MqEq6CpJU6zFa0PAE=;
        b=Qeet93MiSHCGln+Mp/0eTZsZRW5udrE2oIC8wDP0PCnvJa7rCJOZbLWLgglAoqKvfZ
         ut6FD7BIGB33lrlKjST3MTLj99eKCqemyHzd8k+2fg+SrM30Hv97ofJA66twP4FEVds3
         K4IJ59hdyIj16oZFHfUUOfdFc4SzanN/2515UNIjboAQxM3N94zNxJZlwJ6RdZKHvcZF
         nV8ci+htBp2BYGzgTo0O885IJ0RJ1d0OyL3uidShZNxdoEc1i3Y0nhIpWQtgpSHHcMAm
         lh74X5fILWqjRNqp3ruSLCN7v/G2D+yTgJsqiH9tynHzOaihqo4ug4QOdNgMqRV/SGsJ
         mA+w==
X-Gm-Message-State: AOJu0Yzck3Gcs30cdTeBui4j/LslCPsoezRdEYB1kfkHTe8z3zg7aWBV
	GmvAIntrpT7OljV6SQtgdUgh5NFjtq+BFLWhyvVPk1FAFxBdKAYpIc0HghKz
X-Google-Smtp-Source: AGHT+IF/3wc1NaoUb7hw3Gz92BwSxhdXDfXt4YkUDLsFdKCLKPC+FcptxzO20UNGTD73hDLxLC1+GA==
X-Received: by 2002:a05:6358:4b0e:b0:186:1c4f:29c7 with SMTP id kr14-20020a0563584b0e00b001861c4f29c7mr514556rwc.27.1712454609044;
        Sat, 06 Apr 2024 18:50:09 -0700 (PDT)
Received: from localhost ([14.191.223.174])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090a2dce00b002a25bf61931sm5557110pjm.29.2024.04.06.18.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 18:50:08 -0700 (PDT)
Date: Sun, 7 Apr 2024 08:50:06 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t9604: Fix test for musl libc and new Debian
Message-ID: <ZhH7zp4EEegdo2Fw@danh.dev>
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
 <20240407013312.GD1085004@coredump.intra.peff.net>
 <ZhH6wq5eTUTZS_zE@danh.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhH6wq5eTUTZS_zE@danh.dev>

On 2024-04-07 08:45:38+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2024-04-06 21:33:12-0400, Jeff King <peff@peff.net> wrote:
> > On Sat, Apr 06, 2024 at 10:29:10AM +0700, Đoàn Trần Công Danh wrote:
> > 
> > > CST6CDT and the like are POSIX timezone, with no rule for transition.
> > > And POSIX doesn't enforce how to interpret the rule if it's omited.
> > > Some libc resorted back to IANA (formerly Olson) db rules for those
> > > timezones.  Other libc (e.g. musl) interpret that as no transition at
> > > all [1].
> > > 
> > > In addition, distributions (notoriously Debian-derived, which uses IANA
> > > db for CST6CDT and the like) started to split "legacy" timezones
> > > like CST6CDT, EST5EDT into `tzdata-legacy', which will not be installed
> > > by default [2].
> > > 
> > > In those cases, t9604 will run into failure.
> > > 
> > > Let's switch to POSIX timezone with rules to change timezone.
> > 
> > This made me wonder if we are losing EST5, etc. We use that in t0006,
> > for example. But I guess not, since I do not have tzdata-legacy
> > installed (I am on Debian unstable) and haven't run into issues (I
> > didn't notice the cvsimport one because I lack other prereqs to run
> > those tests).
> 
> Nah, EST5 is a conformance POSIX timezone.  It read:
> 
>     The timezone name is EST, offset is 5hours behinds Universal timezone.

Correction: it reads
      The timezone name is EST, offset is 5hours behinds Universal timezone,
      all year round.

Since POSIX says that:

	if dst is missing, then the alternative time does not apply in
	this locale.

> 
> You can check by trying today (or on anyday with DST on):
> 
> 	TZ=EST5 date
> 	TZ=EST5EDT date
> 	TZ=America/New_York date
> 
> - The first one will always interpret 5 hours behinds UTC.
> - The second one is implementation defined behavior, on glibc system,
>   it will depends on the existence of /usr/share/zoneinfo/EST5EDT
> - The third one will interpret today time as 4 hours behinds UTC.
> 
> glibc normally check if a timezone exist in /usr/share/zoneinfo first,
> if not, it will interpret by POSIX rule.
> 
> -- 
> Danh

-- 
Danh
