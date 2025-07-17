Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122242FA64F
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768721; cv=none; b=Bk/InOOkZ56UH7s/NUO8OXBI91DVh0DuaOCoz06XdT/S3um3tmG5PpioO1fCKtN4ZUObg2trV6OcdiMuXvmXbLXqRblQgJU88tGMGSnuc7v8uR16hVrSMk0tYAvrmhAJRFqG1NeaI/Sz5Yx3Gb98/p4e5CgZoGgKpfJNjZM8lrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768721; c=relaxed/simple;
	bh=Xb9Mgd3/jPPHfKrbal1NP/mYS8U637AekqLsWcvi2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOJtvH+L6j9ase3i4/7LEUqro/J+He1GrXb21JNlB085RxYj+syp+leFTw8ytf+heuRwcmXeOeGVXeiscSw177z/2uFAvIiEeGsduvl9eTzDDHEV4N/dECC2FF5vt4ox8tJsLxtdPEwHXXngnqJodXa6mS51ooMgI46nsHP6FQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+ZSqmuL; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+ZSqmuL"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61590f8fea4so258397eaf.2
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752768719; x=1753373519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3hjAGdtmcqNq+xFU9N8ebZmtnhcYTFv0TYSLkS5xPA=;
        b=A+ZSqmuLgRuh7SFo31rOaT7bbAB6bjBltlU/ZajUOqlA8hhOsk0ABpUV9z5HBX/8U7
         Abpzx/9uChIqdA4zwz3TIdXQcQ4NJYTX/JTLqcmUIOpeU960Qm85XBnXcUsjgJOzwDh8
         jA/Y4dmjoY3nakQVohKh5ufiHoW6K/T9dRrZEO2e+CUB3pOYf91NCDzoH5C0Fiy5Mk8G
         QtAJlqPKfM1tfcmmBeoHxZPAc9ws1DHTJHm+PwSVmRaG2f5zeE1yWNHFn9KlCII/nO1l
         klrrtwmN5pL03rVGNYlq3b0FTPAFNN7OIRp2vgQEasPDAfqtAD183gUbhlfbR3Sg+WR2
         EZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768719; x=1753373519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3hjAGdtmcqNq+xFU9N8ebZmtnhcYTFv0TYSLkS5xPA=;
        b=WvOLqaEjOXrcIOfOC4sbKjGUdjpv0/bETG3q8UV1azyVlKr8BTdxGmDlFl6LS1tras
         QFuvnlvF23Us5+NMSd8KuYL/8ZW81MjSjKLXL7l+upFRQS0vHNwB3BEWX2OlZGRM6oRd
         NyZbF556dG3n/jIzl0B5kHdb25v56ZjfYacjhCIG2pR9PfjhT5QsQYi7LkoDB1Dqq10h
         Ly0Ekr3T0tgl4uBSS4MONSpgMzwvLVPOkPUY1b+ggaXkTT8BUGhFxIVfkDh+lFH81IvC
         GdbTq/6I6YEJ4YLwRg2X+5FHCbTfkvqsCzodQ3FKmdZSuVY2issX5OIjNdUOdMTewZ0z
         9SiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeO3o/QaLYBTrjzY3QLq9AG1gaHBd1DkCuu38qeD1QJ827XKov3Ul5wyJk/yWNgD0FbL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuIuVEU4VNal2RG4/hJU/kKDyCAozm1N1zKJ+oelWjIkm9aSTN
	fJoL7I/hnYnEuv+JUUaAc9ehXgAtjIgm6VwbDuA5h8sEhyRZ7H7EKK1h
X-Gm-Gg: ASbGncu12WVAIzNwzcn2NYSkZRt2Al5enLdxdvMLBom9QKwHjqodz1rjGZh7UIIVorb
	I0Deuw71/D/updh0U9J5LyXQ4tbE218XLJv52wDqdn5xc4TsXkfkxSxzXa5hASwqnuyu+VkvfN8
	kjwO9KI4adImdWYN4IA4bYTCYfsKpDmt4/F+8QFpxGf9uhPw30SlXUPTvYMSpLIHcXnnSWnQP9J
	xRbWKyI6THSCaTV92R9zvFFUd3W7LTEZDHzctqqmoISO4BMUqHZDkVq2lEtm4Ir6b1bIepWKhjg
	sdWLL/vG3JfwADOzyZliiwEcKrDgaTiAmSEzF/O1SDFAHNGhDUGhbhpnQgb/20I2DTy0SBiUUNV
	1/xU1ORpJDaQKDbs=
X-Google-Smtp-Source: AGHT+IGioJQIIAAlNckwRjO1ZSDaYVFefyp1occpRYuOUg4GeG3uJ0IyDA7Q6sp1iEs2Bdt6lK/JMQ==
X-Received: by 2002:a4a:ee0e:0:b0:615:7d3f:b3b7 with SMTP id 006d021491bc7-615a1df56cfmr4732195eaf.0.1752768718816;
        Thu, 17 Jul 2025 09:11:58 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-615aa61b45bsm821480eaf.21.2025.07.17.09.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:11:58 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:06:14 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
Message-ID: <oir6mpubnuplnjatdhlyljslakmh72wlax4afuqnsiyob65xfh@5rft32ln2zvk>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-3-lucasseikioshiro@gmail.com>
 <mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg>
 <aHc6y9FGFXjowkU1@pks.im>
 <2v7b6mpufnn6cj7u7tactgu2ibggn4xpuezl2bsfjxv62afrsa@chfrii6vkrx3>
 <aHj0lF5Kbirzv3pZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHj0lF5Kbirzv3pZ@pks.im>

On 25/07/17 03:03PM, Patrick Steinhardt wrote:
> On Wed, Jul 16, 2025 at 09:04:40AM -0500, Justin Tobler wrote:
> > If we already plan to support additional output formats, they I agree we
> > should probably a `--format=<output-type>` flag from the start. I still
> > think it would be nice to have a `-z` flag that is shorthand for
> > `--format=nul` though as that is fairly common across other commands to
> > have such an option.
> > 
> > Out of curiousity, is there a reason we are interested in supporting a
> > JSON output format in addition to what is already proposed? From an
> > earlier conversation I had with Lucas, it didn't seem like there was any
> > particular reason for JSON.
> 
> I don't care much about the JSON output format. What I do care about is
> to have a default format that we are free to iterate on, especially in
> the context of `git repo size`. If we ever want to have output that is
> as user friendly as git-sizer(1)'s we need to have that freedom.
> 
> From my perspective that necessitates two things:
> 
>   - That we are able to change formats with a proper `--format=` flag.
>     `-z` alone doesn't fit that bill, as we are already talking about
>     there formats: user friendly, key-value pairs, and key-value pairs
>     with NUL termination.
> 
>     That being said I'm not opposed to also have `-z` as an alias as
>     long as we also have `--format=`.
> 
>   - That the _default_ format is the user friendly format that we can
>     iterate on, at least for `git repo size`. Otherwise we have already
>     failed on our mission to supply a user-friendly alternative to
>     git-sizer(1).

I was originally of the mindset that git-repo(1) would focus on being
more of a plumbing commmand and if we wanted to provide a more
user-friendly decorated format for something akin to git-sizer(1) info,
that would be better done through a separate command.

Thinking about this some more though, I agree with you that we should
probably just have git-repo(1) be the single stop and provide the
various output flavors for its subcommands. If this is the route we go
down, the default mode should be user-friendly.

I think a key attribute of this user-friendly mode is that it should be
free to change and be iterated on. If a user wants a stable output
format, they should request the key-value output form that is
line/nul-delimited.

So maybe we have three different output modes for `--format=<mode>`:
`user` (default), `keyvalue`, and `nul`? For `git repo info`, I'm not
entirely certain how the default user-friendly mode would/should differ
from the key-value one, but maybe that is not something we need to worry
about right now. For now, the two modes could match and over time update
the user mode as desired.

-Justin
