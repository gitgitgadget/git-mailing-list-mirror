Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097C207A2C
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355554; cv=none; b=dHWJZcTCzZJSpZbliAtJ9eTq55S8RxA5Yl6W6c/C8PkkPBH3Btbcg6UMZF2ecyzBhf0ie1N7DBWwtx9TpNaJ0m4thqkC0HqwsJIJiark36ETkRQPW0p98WzxebQU25olVgQp6bo+M8jlGdkQtxu2cQLFsS+8X8ydW4eFMd7mug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355554; c=relaxed/simple;
	bh=upnZgjPUDIVOf+m8Wk9DSXSt1R8O1MBXMs0xt0B/07k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCUeK2fiAe/qeNnQYsbOPRaiIGf1LZIa7BePX8T84FB5UI+8iLQfpRSfw3/hLt0Dy1UjEHp/A/m15L1MZUpwylFgqkyUc+tDi8RGIRa0lWV0NOoKu+7e1YJRhAGomyVq8zZTpfUIoPsEG+rh2MTc3Nan3dMvCSPb6OeYRszl3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axudIHUX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axudIHUX"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c053a2118fso373155685a.2
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 02:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739355552; x=1739960352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xAoKYuB8HFUJb0Y6ZtEkwIorehkevX0FRh4+5F+fPo0=;
        b=axudIHUXRAbddE15zYWWCMAlOtIPkscoF7W0QSPEmfph6uzrinR4Lj7Xf6UhFR9YNn
         IDgjhAw/b8qgmqdXSzo3wHAwM3h+nkYMV/LHVMMA9hdgcd7dd8FEPoa5GTa/Cz3DAfne
         O8MQDznJrRzxZmlh2GI+iyAU+xIZQttBqxn6e6VT/lhcnVO6vg1N1EWr6M7kK1Ao5F1p
         4ukbhq35UQF7YEPHj6WPYevZeF3csEOXIc5YR9eWb9gYrXw5F+y2+REdxbrbZLD+5WJh
         lMIigeyil+BWmS/B5fRU0MC2ZHOO5aB3rI8DvYMQfLFBE06sHDsI4S+EIuAq+9a4zh5/
         JDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739355552; x=1739960352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAoKYuB8HFUJb0Y6ZtEkwIorehkevX0FRh4+5F+fPo0=;
        b=L0acaRXWGPeX4WoKbKSLe3Ivu9wWyAhG5aD/OygU04pNWekc/nk7+zCLu2yOBIfA6B
         t0SSZjCo8335jHrMxI9PAfX8MKgGddKnVimvxQOGKj3ug0HRHYEFyB/ys3T1bN9hJ+fT
         L3/k78sNQ/VEZWbeQX/Sim0WQGlQUqX8tgHrisYGJ5go/pgQGiRTTTqu/bSx8zXSMgLk
         idagALwz+waSRBgJAckGwIbWw9mM46UPUPLEpsqP6CQtmXb61Z5XVhq+h8zBLEl9DZZJ
         tDV4YfrcrNXwYsoSrtcx9DFNKKW71zddU3wxAngcSTRxfpwyb8+3NczPQBGRcDfbjP7E
         6AaQ==
X-Gm-Message-State: AOJu0YwD2k3msl5u7KzZOI/Bt+qE5zlFUwnvsj34/T7y9vVhkRYDSUP1
	WEVoMCkOF4DgiAnGFVelr9hjnhc8nfJdXTsD9DBZ/hjSO2kG8cOnSguhnA==
X-Gm-Gg: ASbGncuwdDbeAwiBdRMw9l7/cCxBmxBWr6NHBwtGPYqWw57nov77c05YkwVOjwN+XZE
	LnocntsjmZWSF4dmOOD1P48RVUtRUlXxrkMTM8CxfnoY/pogueodaFutEQGUZ4xQty7soDn3Csq
	5yE1xhxbqXY4u7bhv1f089Fsjh61dFXJtqLBQwUt1q7BxWZsfccwwDPdXgOBMPcwD2nffSg462v
	gh92/hhFBXofXaHK1N6mjPMX4MrwhLEXK7jgAo1P1EhAuFBTIlyd7VE4vA6/vnMkwE4Xw==
X-Google-Smtp-Source: AGHT+IEY1laGu+FtLoEuksHbK98MmZNEwrDtgQ7HFHpmhCQwoYRu+OtZybieEyagqHHnGInzwjTOQA==
X-Received: by 2002:a05:620a:3947:b0:7b6:d97a:2608 with SMTP id af79cd13be357-7c07071b394mr335992685a.17.1739355551795;
        Wed, 12 Feb 2025 02:19:11 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c041ded0e7sm831264385a.8.2025.02.12.02.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:19:11 -0800 (PST)
Date: Wed, 12 Feb 2025 18:21:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 8/8] builtin/fsck: add `git refs verify` child process
Message-ID: <Z6x2EN3ZVikLh4ne@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RP50d7eRsKRCG6@ArchLinux>
 <Z6xwZaYLfmWUVNNR@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6xwZaYLfmWUVNNR@pks.im>

On Wed, Feb 12, 2025 at 10:56:53AM +0100, Patrick Steinhardt wrote:
> On Thu, Feb 06, 2025 at 02:00:07PM +0800, shejialuo wrote:
> > diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
> > index 5b82e4605c..9bd433028f 100644
> > --- a/Documentation/git-fsck.txt
> > +++ b/Documentation/git-fsck.txt
> > @@ -12,7 +12,7 @@ SYNOPSIS
> >  'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
> >  	 [--[no-]full] [--strict] [--verbose] [--lost-found]
> >  	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
> > -	 [--[no-]name-objects] [<object>...]
> > +	 [--[no-]name-objects] [--[no-]references] [<object>...]
> >  
> >  DESCRIPTION
> >  -----------
> > @@ -104,6 +104,10 @@ care about this output and want to speed it up further.
> >  	progress status even if the standard error stream is not
> >  	directed to a terminal.
> >  
> > +--[no-]references::
> > +	Control whether to check the references database consistency
> > +	via 'git refs verify'. See linkgit:git-refs[1] for details.
> 
> I think we should note the default, which is to check them.
> 

OK, let me improve the documentation in the next version.

> It would also be nice to have a couple of tests to verify that the flag
> does what it is intended to do.
> 

Good idea, we could test via trailing contents to do this. Let me
improve this.

> Patrick
