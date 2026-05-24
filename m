Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1058399356
	for <git@vger.kernel.org>; Sun, 24 May 2026 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779634835; cv=none; b=I0Td2GVQ9QPeAYvPjVPfesadTnSFQmelU2CgQqNU9zLfEOc47ny8XPSFHRrP6AM2T0D8SgpJGLlAikoxOl7ydfpT7gougm644Bn3l75Ml9qyyyv5xjSce0o6n4WgY30JSd9e+CqVrIIrirxrVA/hUbB0ysNN56cGFcN7p7MQxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779634835; c=relaxed/simple;
	bh=yRmRuXodaRF68sCz+VlmBR+HtLcB7zZ9+JI1Nfh5rI4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0GM5tM7hlgbto3W9V8LJHZ5StjRaXIe9a+lt6/svUhMOSRrdL6P63CRnjH5NN4Lt7l/HV39DW0pRGe6r68niluWVcwp54XKCHGkvd+fE1P0CZLM9kc3KBlLToHDuRhyGA728oHYaxv91c4RVUcrkPNzCXS5tp18W4Feqx9vqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l17NO8G3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l17NO8G3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a995ab70d1so11078391e87.3
        for <git@vger.kernel.org>; Sun, 24 May 2026 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779634829; x=1780239629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2XsN6IAp7LNOKPsS4JZdXHa+XAwbDhtMNszRpVsmvc=;
        b=l17NO8G3byLNk0Ygiut1tEKJhf6hpzEfj6np5+5aURUNaVfzzOhVfw8DZd3S05iNox
         ofiuLnIff67LQRDWFFGcInWcMWNdxL3XFcjSVAhlO1NTc61mWN1kS8HiQ3mdhSBPbZKY
         tUW+I+GzQsqaCOy+nzWEaPuBUfXGkOqbSB5rRE1kxWaGnf/7qA/R/PYTMmSLrqgr37tH
         oZAqZnZB+zfx4L0PPyP6JuntorGrTRgC9mue8eO7GWrGvXt7c4IaJs0n1UvB5WO0Q78l
         PhPUFPAYP6ClpgxMtyKs5ybcRP/6m98udPt+bvYRjOVUytZy7m5b/K10mG3pW7HeoxRW
         p8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779634829; x=1780239629;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2XsN6IAp7LNOKPsS4JZdXHa+XAwbDhtMNszRpVsmvc=;
        b=a6e6OUTwb5il2KqJFBqJcDIued1Uh06y95ryhOL0A/958PhDP5uUDwRFjRUDeSpE7R
         7zLR5C+rKPXV9FHV36Y6gpt3jCDZvqWMh1Nx+rqvtbEyNdO0a588KCDOwg37xi1sA9F1
         sVsIXSLQyv/VXWLakCBrcuR4LnKOXsdSW5BpzHb3Pq/U13GEMxP3dqX6JUgnHUkt7GzP
         IZDdIBZ8S0W3xg2c6IRNF06uyyhqgTN86x1eBkQ6cNIRK6UIku/vLmEIpkXd4xTvVY+B
         MwL7geHfWeYd8NzQ7r8liCWsggGTJ5UO6vKlRABbdlRcLalsbFtw6qGjtmkaSQU4DBQV
         uMQQ==
X-Gm-Message-State: AOJu0YzkxHloucR2NCvnjDEIGXarwqIBYNaQcJO8q41nw0CjaYZEz43Z
	R7nCI+0QWCpZbdP67w+807q/lLHLYzf2hSKtHYvGZ+9UUg7DpF9TudccXQDWWw==
X-Gm-Gg: Acq92OFDfQEHIZuAVJ9ZtZONwl+D7scJGGvILsQPD+i+W93p1xBoPZKKCrJQfl1w22S
	5zq0pP7J6ruukQuHxQCTZh0yVVW8Cg5Lzvv13v5LMAFIx+H7nZ/7xA7m4bOY5lJ299DHFD8X2hy
	/MAiFuAiiDo4ha+DOtddgGWuP5wnkc+n2w7BpxCnPAPG6/UF9T8T4YimKOGx9/cJxGqmY/zm0/o
	i3G9xDNwT4CQAIVfa0BP379QLizD0URx7lhb3m1wWNgVNCg0ZRX5uDiWIH21GtdQMu05wQb3oi5
	I1mE2e999wuSnWBO551pLH2HnJcLoaXwFZ713n6eA0N2+24wyRduZc2u9irswem9bOuoks4JW9Y
	46seZf6j8N/OQ/AZo99BDSI4aJ9UDGpjSaRS5g40n/weyeVEACCgs5hzRGeqNSyVBfVHVFCb+ny
	rfdhMN9/CqwMnNbrR23fkHUXRQaCLxvb3TIKjWzZedeSyf3SE2VhtWIiSwsoxmzD9lj4hR3UpIp
	F1gHKVkUJc5VuIDLxBdGycU9jQ/3Xb0UHt7Zb5ZnLJMX1QFZ1+FcMT9o5yyJA==
X-Received: by 2002:a05:6512:3d17:b0:5a8:84a5:bffa with SMTP id 2adb3069b0e04-5aa323a4992mr3115335e87.5.1779634828812;
        Sun, 24 May 2026 08:00:28 -0700 (PDT)
Received: from localhost ([2a02:1406:184:15ad:75eb:b5af:3337:5dd9])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32ceb596sm1958980e87.46.2026.05.24.08.00.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 08:00:28 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
Date: Sun, 24 May 2026 17:00:26 +0200
From: Erik Cervin Edin <erik@cervined.in>
To: git@vger.kernel.org
Subject: Re: [PATCH 1/1] commit: allow -m/-F with --fixup=amend: or reword:
Message-ID: <aguM7UIbAo19Zojv@mbp>
Mail-Followup-To: git@vger.kernel.org
References: <20260518112225.73172-2-erik@cervined.in>
 <20260518112225.73172-4-erik@cervined.in>
 <xmqqik8kc2nj.fsf@gitster.g>
 <ac6aaaca-2b7c-4892-ba93-0dc3e3c18ff7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6aaaca-2b7c-4892-ba93-0dc3e3c18ff7@gmail.com>

> > > --fixup=amend: and --fixup=reword: require an editor to supply the
> > > replacement commit message. The -m and -F flags are rejected: -m is
> > > caught by a die() in prepare_to_commit(), and -F is caught by
> > > die_for_incompatible_opt4() which groups -F with --fixup as mutually
> > > exclusive. This makes these modes unusable in non-interactive
> > > workflows -- notably AI coding agents.
> > 
> > "Unusable" may be stronger than reality, as you can make creatie use
> > of GIT_EDITOR to achieve what you want.  "awkward" or "poorly suited"
> > would be more fitting.
> 
> Indeed

Fair, "poorly suited" is more accurate. It's not impossible, just very
awkward.

> > > Plain --fixup (without amend: or reword:) continues to reject -F but
> > > still accepts -m (even though it's practically a no-op).
> > 
> > Is it "practically a no-op"?

No, I was mistaken. The message is kept until autosquash.

    The `-m` option may be used to supplement the log message of the
    created commit, but the additional commentary will be thrown away
    once the "fixup!" commit is squashed into _<commit>_ by `git rebase
    --autosquash`.

I was trying to fill in the gaps here on the intent of the pre-existing
behavior (to reject -F with --fixup) and I kind of assumed the message
was being discarded.

> > For the same reason, "-F" would be just as useful as "-m" in this context,
> > and it feels a bit inconsistent to allow one while rejecting the other.
> 
> Yes, looking at the way the code is structured I wonder if these options
> were made incompatible to simplify the implementation, or maybe the
> implementation merely reflects those restrictions.

I think it would. I kept the pre-existing behavior because I wasn't sure
if the rejection meant "Error. You are doing something that doesn't make
sense -- you probably meant to do something else" or "Sorry. What you're
trying to do is not supported"

A closer look at the original implementation 30884c9afc (commit: add
support for --fixup <commit> -m"<extra message>", 2017-12-22) makes it
clear the intent here is the latter:

    Those options could also support combining with -m, but given what
    they do I can't think of a good use-case for doing that, so I have not
    made the more invasive change of splitting up the logic in commit.c to
    first act on those, and then on -m options.

There is a case to not reject them, it was just deemed unnecessary
complex for something without a clear use-case.

In the ideal case, given that -m works (and does something useful), it's
reasonable to expect -F to do the same (for the same reasons as
--fixup=reword:.) Although, it's arguably less crucial in this
usecase. Given what its ephemeral nature, such a message is likely a
terse comment, -m "forgot to format" or similar.

I think it makes sense to allow -F for all --fixup variations, for
consistency. For the plain --fixup, -c/-C are probably less justifiable,
but -F mirroring -m seems worthwhile for consistency's sake in all
variations.

> > A potential problem of the above code is if we find something wrong
> > in message and complain later in the control flow
> > in message and complain later in the control flow, we have long lost
> > where the message came from, as the point of the above code is
> > exactly to pretend that "--fixup:amend/reword -F" message did *not*
> > come from a file with the "-F" option, but from the command line via
> > the "-m" option.

Now that you mention this, I guess a message on stdin can be arbitrarily
large, have null bytes and maybe some other oddities which the -m
would never have.

> I wonder how hard it would be to refactor prepare_to_commit()
> so that it can accommodate "--fixup=amend:<commit> -F"

I think this is doable.

> > > +test_expect_success '--fixup=amend: with -m option' '
> > >   	commit_for_rebase_autosquash_setup &&
> > > -	echo "fatal: options '\''-m'\'' and '\''--fixup:reword'\'' cannot be used together" >expect &&
> > > -	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
> > > -	test_cmp expect actual
> > > +	cat >expected <<-EOF &&
> > 
> > This comment is not about the added logic, but I notice that among
> > 86 hits with string "expect" in this file in today's "master", only

> > 14 hits are with string "expected", i.e., the prevalent name for the
> > "golden copy result" that is compared with the actula result (called
> > "actual") is "expect", not "expected".  Please do not make the
> > situation worse.

Mea culpa. I overlooked this distinction.

> In this case it would be better to use
> 
> 	test_commit_message HEAD <<-EOF
> 	amend! $(git log -1 --format=%s HEAD~)
> 
> 	amend commit message
> 	EOF
> 
> and avoid creating actual and expect all together.

That would also work (except it has to be HEAD~2, since the reword
commit advances HEAD by one)

Thank you both for the review. I will reroll as a V2 taking your
suggestions into account.

- Erik
