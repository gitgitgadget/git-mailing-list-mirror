Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524E22071
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737169480; cv=none; b=uC9lYxRdwX3ruhSsRanOnKeoajEWI0ueMPjRFu4Tj0QL5YcH1u5gRvFoxqR2wEcpX0kpWAfTtjDkPa8QHjImmGwDgBJc9PaAptJ9qhhVV15+sawWEqYVEiHfyK2OK7AfqDKBqhyutVYGqu4q9b7KrQpHz+eMcLVWGtaByBe70po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737169480; c=relaxed/simple;
	bh=cg7zbFX+HTqEV9BeoTT32WgBx704D9+s/q/aa/p+TGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQXd21cQQuzN+hi0BoS0WM1To9ksvVKVt5E/0WUgGhaD0t7E4ZXSdDMHIaZezGKvaXKDkWd+F4H1kc2kQv4JjqaP/XT9bp8WrTi0iU6e1oAs+Wz6TOZlWB3i3WrxOJ9F7A1RrBe1muFhPbhIik8rcd1t1pANfUPx+eDdQADl/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu0lkTCR; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu0lkTCR"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e36b27b53so1500980a34.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 19:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737169477; x=1737774277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v2lLhU9bDpbdRMqKpfBKlQ/enIQpmt0thnX+TaPuATQ=;
        b=Fu0lkTCR/MYyL5Hh5i9Z9VXZTkpfEHczQkqYe/aAoHEVKfVqG17yyXl6luBd00GxyL
         eVm4/hlSODqqnPY0QOE4AH14R7yBoYgA15PKDNozmrW1fYacCQc5UZVbXcESpFIEPKbs
         +6GoAE9kbDbEWklLBlGph/Yrl0reOZ++eZEeL10GEarTl40dF1yBXx8b6l4SK0aD8mSd
         paLUM+3qjFemT77fuk//Ns5ZV5YK6a3QAl17iHLU7Lgw2si2O0pQ46jcQbxiCSjh2HXt
         uCRJOOUz2M6imScFT3Rs8AwOzTFAPWWG5NUI2zalS84nGwYHXFA7ZcpjoWaR3OIHzZIa
         GgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737169477; x=1737774277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2lLhU9bDpbdRMqKpfBKlQ/enIQpmt0thnX+TaPuATQ=;
        b=eqlfS7bt4d/+Nc21qlDrEDf1lseOD4YKlo7M9Zh7DDyh/02cHE6idWq1EpYnwjWeIG
         QLn0cTkX04rhl0xGYOFDEyn/ZP+JEDaL76KMiKFtg+u8yANZE7xxEjZWk4eTWK2ClPFt
         h63sNrS4D7jAbXvuIIsuwoxTT3kJMF4G6BH1jUvHiIy9lcvrizcjQzqMfEnd4ZCceLGN
         8mqiGqUa7RDxqLfLiOmW4tTJt0kspNbavSsq9m1i1qloy945pv0QR2mxKNx1dWupyGFa
         YrEsqsblKM0Ub/vcncNcCBf9hI3w2jn9EMkwWsVDoykoWDR3Z84uiwifnVDIEIsPwSGJ
         f2/w==
X-Forwarded-Encrypted: i=1; AJvYcCUZSJOSLvDRNSo1gMyMCOgVTlJVXo0MZzsi/t8YXly0UYaMfVZ9LnKh3DL4nQ0Pz2iZWoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQF7Gptvvbvi05VFaFBujpqsskoRednDzuh2PWKaqSfNcCRJT
	CKMY9WAaywnAb+tiscGYH9Adntfjb8N727XDIRmVOA+xytYr5XoR
X-Gm-Gg: ASbGnctLBTUHjmFCUFbwjqO5KutqPw653hrP+PP4bJ0GTrjg/rf3+1UtTHu0fEQ22Ln
	GktgtHGwU7upGtnhWfSjYwOL/KtHybX3InVssGewNUUstU56psohfCc0RF4S32vfX3QxpqekWXy
	2XYqEtqLj4rtfD2z9HNrKlLaF4LV/ZbCHme6dQ0nU/IL9+MJVgo263cLYgYGZ0KFtGZzxCJZJRF
	0+/YNJk29W/Yvuh4j8z6ZZSJ59Jr7BmfigC/Gwg5oE33j+y
X-Google-Smtp-Source: AGHT+IEX+ohbj+9wouklytkQP50RmIri+lQdkycQRFP7/99c+HYcysVroK01UZF4siaLxPijW6GLug==
X-Received: by 2002:a05:6830:670d:b0:71d:6543:e83f with SMTP id 46e09a7af769-7249da7d8f6mr2634880a34.11.1737169477431;
        Fri, 17 Jan 2025 19:04:37 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7249b4d2d78sm1321222a34.69.2025.01.17.19.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 19:04:36 -0800 (PST)
Date: Sat, 18 Jan 2025 11:05:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/10] packed-backend: check whether the "packed-refs" is
 regular
Message-ID: <Z4sakhF9O7q8dib5@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN6C2IpQTdVn_S@ArchLinux>
 <CAOLa=ZQ-cRJeWjP-_6N2v4GS5P7oYVUyb9_tbY26W7MAJfJ6ZQ@mail.gmail.com>
 <Z4pijwANZWAP2XKH@ArchLinux>
 <CAPig+cRsAPp1APNJ7W337UNtunETr+Lnn-RcGrAXEFUhN1APyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRsAPp1APNJ7W337UNtunETr+Lnn-RcGrAXEFUhN1APyA@mail.gmail.com>

On Fri, Jan 17, 2025 at 05:01:21PM -0500, Eric Sunshine wrote:
> On Fri, Jan 17, 2025 at 8:59 AM shejialuo <shejialuo@gmail.com> wrote:
> > On Tue, Jan 07, 2025 at 08:33:56AM -0800, Karthik Nayak wrote:
> > > shejialuo <shejialuo@gmail.com> writes:
> > > > +test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
> > > > +   test_when_finished "rm -rf repo" &&
> > > > +   git init repo &&
> > > > +   cd repo &&
> > >
> > > This should be in a subshell, so that at the end we can actually remove
> > > the repo. This seems to be applicable to most of the other tests in this
> > > file too. Perhaps, we should clean it up as a precursor commit to this
> > > series?
> >
> > I have searched the usage of "test_when_finished", and I don't know why
> > we need to use subshell. Could you please explain this further here.
> 
> Karthik may have been thinking about operating systems, such as
> Microsoft Windows, which won't allow a directory to be deleted if that
> directory is in use. In this case, because the test cd's into "repo"
> and never cd's elsewhere, the directory is still in use when
> test_when_finished() tries to delete "repo".
> 
> However, there is an even more important reason to use a subshell, and
> that is because a subshell ensures that the current working directory
> is effectively restored to the path which was current before the cd
> command. This is important since it guarantees that subsequent tests
> will be run in the correct directory even if the preceding test bombed
> out part way through. For example:
> 
>     test_expect_success 'foo' '
>         git init repo &&
>         cd repo &&
>         ...some more commands... &&
>         cd ..
>     '
> 
> If one of the commands in "...some more commands..." fails, then the
> `cd ..` will never be reached, and the current working directory will
> remain "repo" rather than reverting to the path prior to the cd
> command. Thus, any tests which follow this one in the script will end
> up running in the wrong directory. The proper way to protect against
> this is:
> 
>     test_expect_success 'foo' '
>         git init repo &&
>         (
>             cd repo &&
>             ...some more commands...
>         )
>     '
> 
> Exiting the subshell will correctly restore the current working
> directory to the original path _regardless_ of whether the test
> succeeds or fails somewhere in "...some more commands...". Using a
> subshell also means that you don't have to manually restore the
> working directory via `cd ..` or similar.

Thanks for above detailed explanation. I somehow understand why there
would be so many "repo/repo/repo" when I execute the test. I have
thought that `test_expect_success` command will make the environment of
each test totally independent. I will improve this in the next version.


Thanks,
Jialuo
