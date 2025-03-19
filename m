Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642D442048
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400113; cv=none; b=mQ1Bjx/7shQip8rLkPUSV0YTHEnXvSvTl5iQCgiHhnCTNFSqExLvXUAV0n4IXSOwXOWU+DBErKTH3Jw86NjJrx2N2p0UbR3adFpvzNpIF38XCq9Pl+v9dmD4B30/MhSLWqEHVgO7UJOnf88HRl/4qLtm0HYZRdEVYddtDtlWSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400113; c=relaxed/simple;
	bh=7XYsN1Sp4pLLSaTp/Qnc3Gw5opwnRCvaeUekwzEbnus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNBl0wSTqahS5Kr5dwiqIApedBYealq1J4xJGZTOt/0HRyJmMfVtUOwUBdmq0XnsNuojfSAziFIRBkxj5u2/H6nMIWSQRK+9FPK2PZ0Fvf5ThxuF0FO6wOxCUvkL3aRdqubIpKflXi0xJod1w633QAGf+uXaWP0TxKSZ8IXw/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwccCc84; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwccCc84"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2bcca6aae0bso5557432fac.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400111; x=1743004911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=29bABbAEsULfwR5CoefzF6opZ+mxI+JvIVkk0pY0iD0=;
        b=fwccCc840VlXUMtl2/lG6299ZHXu/LAEOKtQO3ihQLSvHOJfXc2UX4aHhJ00EZVL2L
         6gq5j3h19ZEo5zJnoYIg4CZYRPDJpOIQVJbkY/ywcKmvNYpsbQ/a2dCwZlmeONGuExBy
         dFFsUUkYdJYY8lvssIXl8n0fbRcrzzuiCW9zdPjksWgDeMD3Lbt0MRw8bVhayOkPuxfw
         z1xs5cZrbHfO7ZOMc/s15tB89pMW1BBGHFdiiapWqjHAgc4FQZhAucJjfg3VLOKkyudI
         5nTQCb4Zjm0SILSNgL0K0iI9nVJnbiqUvrx/e3+ZsF05jPnjSiva7pgQWcMq3CB/SqdK
         XznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400111; x=1743004911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29bABbAEsULfwR5CoefzF6opZ+mxI+JvIVkk0pY0iD0=;
        b=bO4wIP1qhPMA0bBtOJkOR2UMB3Pd+qxMiP5WUXKl+p380Bp70KVTfrnceyBRFDNCNn
         1vCqfbDxwFbt892nyer4OmnJdYP4s7T4+/wnBwHEKv0tI5SKOE0AGu0wMtTyii60sWF/
         aZ/RsRCBKPV0zbp3mZL4G+7xaVWLQa3vA+TVTmuZl0vjK6lU7lHj7IzbOuXxmnpZrUpO
         KLsPVOCMciXWTvSp1JJ4xjpkz/pfFrY7Mj1i0PzgqrK9XeT3RZL5dwYjogrbwm3rFO2e
         NOTZI2cMOT29U/fgzR8LakFHK+mDngtYEpY6x0B3CXPspoHzI6JeWQzD3GiS7Y3yDYhg
         e8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYOeOCxXxO7YbIcyuhnGAqFdzhS0GSvkw5OEZLS0cAv2y1Ca7X2tL4zJeXXPKgMflGgok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRvA0EqV0ZXpQo0aGo32XvdfkBS2+pGCc2OJ2ERUTeGehRF7G9
	eFeqQqTL9S+hOcgKRcBuhqzTAaCPRCn7bdZRw441AklUwuUaaajfwy3NFw==
X-Gm-Gg: ASbGncsjaHPnokiFeZgrW1dxcpHTGID5Cv3fIjvZhspouKXUDDyDtu8CM25nqFQCs2Z
	nqNXZDoLUapB58GsPci5De2nP03HUGIwBhm7y4F37NYpPCYMengdO5Ng9sPrzHAMhFKQ7A8mDh9
	8FDZs9g5eQbGyD/pr9Xzz2Yo9r/JXA8J98OP4eQ0hhOiwf/tVhybuMqbCXRQ7nlzzuKiirxThfF
	D+Uy6zos/VYiSdrCCjT36ZR3Lt0r1Og/aJiuSWFfpJjXnLNkc8ce89HG05yQHmRVsgc8hafs2Uq
	KpYe7xF787jNEPqCZaVw3tD0fmV0wz91jfwEGg==
X-Google-Smtp-Source: AGHT+IGuMfnEouarfAvMw4B1vcKop5Oh03dsP/j3dTY55Cj/680lNPKCvnnoXvZAs/zQHXIMQqbBQA==
X-Received: by 2002:a05:6870:328b:b0:2a7:d856:94a with SMTP id 586e51a60fabf-2c74559f0e4mr2108750fac.22.1742400111383;
        Wed, 19 Mar 2025 09:01:51 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72bb274ed28sm2478275a34.53.2025.03.19.09.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:01:50 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:58:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, ps@pks.im, 
	christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <2aqtmbdpzi5lupflthm4rvoya3pqksv4sqnv5if6camw7tkzuz@ydecphmvo4dc>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250311235720.GA73755@coredump.intra.peff.net>
 <sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>
 <20250313053329.GC94015@coredump.intra.peff.net>
 <qapd7sijizopaefpxh3slgn7g2ecwdtyhzqzufcypciyv6n3qm@turmldwzipwe>
 <20250314024929.GB114103@coredump.intra.peff.net>
 <xmqqsenfk0ks.fsf@gitster.g>
 <20250314185914.GD578421@coredump.intra.peff.net>
 <po5vjngxt6afwdkg7bvpw5j4dhot5h4uz5yudb3o4eug4k2nqu@rwp5rpe5d3u6>
 <xmqqtt7ve2id.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt7ve2id.fsf@gitster.g>

On 25/03/14 02:16PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > If we want to adopt less ambiguous long options names for NUL-delimited
> > input/output options as an alternative to "-z", maybe we could do
> > something like:
> >
> >     $ git rev-list --nul-delimited={all,input,output}
> >
> > where the default for the `--nul-delimited` could be both input/output. 
> 
> I'd prefer not to see that route taken, as it does not look any
> "less ambiguous" at least to me.  Making individual selections are
> almost the same in either syntax, and the only difference is that
> --nul-delimited-input --nul-delimited-output can be independently
> chosen and given and happen to end up selecting both.
> 
> But with --nul-delimited=<value>, you have to plan ahead and choose
> "all".  When your script first wants NUL delimited I/O on the output
> side, you'd write "output".  When later you want to allow it to
> optionally take NUL delimited I/O on the input side, you have to
> notice that you have "output" there already and replace it with "all".
> If the initial version did not have NUL-delimited output, your change
> to add support for NUL-delimited input would be different.
> 
> And you also have to remember that it has to be spelled "all" and
> not "both" when you replace existing "output".
> 
> In other words, I'd prefer to leave independent/orthogonal things as
> such, even if such a general design principle may make the result a
> bit more verbose, at the plumbing level.

That's fair. I agree the explicitness of having two separate options is
nice and, while more verbose, that is probably not a big deal at the
plumbing level.

In my next version I'll return the "-z" option to only setting the
output to be NUL-delimited which would better match the log family of
commands. If we also want to support NUL-delimited stdin parsing, I can
submit a followup series which teaches git-rev-list(1) the
"--nul-delimited-{input,output}" options.

On a side note, I also noticed that git-commit(1) uses the "--null"
option as an alias to "-z". I think it would be nice if going forward
there was greater consistency around the options used to control
input/output delimiters. Maybe "--nul-delimited-{input,output}" could be
that in the future.

Thanks,
-Justin
