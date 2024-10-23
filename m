Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30C12D758
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704628; cv=none; b=BeStJ28f5DjFCHk7+R42qmIMGLNVDwacxBc07OHiL/U2DPN4K1HU1hSSNiFXGRVhSgP/OA0zEOFX6vV+dshAVtu08tA2IGnP34G02t0/MI5LpJyKfGKy9JvbS1OCf7PzOqKHFBKz3QCnUuGzOAEUJseNucOV1DMVUWxFoC0jc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704628; c=relaxed/simple;
	bh=toaNFGNt7DZBxJu3AXsa/llU4Nq3rOnzTtkh52BOsNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIpGbqB8NCS3zXcoFRiJpGu1FnIoJtUdHC++4mJFkJnQ02xKJkrbllevoqoMej+jMYopmEh6OB84yOSunKyBtYlHMm+A4kT7BvRrfQ41bx7YQ0kWImF7TPoSRCdGTfvzz94Pj5H+1CiUCrq19mm6IBdCMnMniPDHRp+wSs1MWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tqzBL9V6; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tqzBL9V6"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e29327636f3so39866276.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729704626; x=1730309426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+BMnHxNvsj7C8ifny3EowAD6spwDqP10wzDYua/Wicw=;
        b=tqzBL9V6Vj6BduhgFgmzvLnob8S4k2z4L01Z4rqQ5xTehODCpyzQ4lIbz73wfBSnKv
         p5cMI1rQHYifSJI8Jg5yp3BO/vcuwzXYPFLYNJqBVnn0qqTyfJ6Eda2X0HADA8nSTpVc
         YsrnrrkmF6JVT19j3ZCa+Tl04JWR/M2OTGJnyxI/u3qfbwHxzXPhzyT5Ay/MsCWYbX/H
         3cr8AQbOEyszn39JoUaPPOflQcC00Vc5YZTSFE006fiQvTx81XQ/U6oxaKXdJnJzA3iR
         1Neb66LFWYa7u0cdIBwPjipg5rayaJyrZQQIciltC6xdLjKgyXKntxH2VDMAoONlahjm
         X6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704626; x=1730309426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BMnHxNvsj7C8ifny3EowAD6spwDqP10wzDYua/Wicw=;
        b=vUYTjJLw5HPwbk7CKWi+pSKdILJP9FTU8VGKzfxsaF8DLh7Fkvs19l2/iucqcTAoFr
         nAEL67en+X0DYmEX3CDOaAHlkLp5uUqvC23Pmi6wuKId+si2vWf8xV0mftswsAPi7R52
         +ErYHsseJQIGgYn+yoGqKDvBzBdM3e6F1KiXnauf1d0x9mHxi2z1uVN5LUxNkBPriRXE
         +H03meRpmQJBFRcF22Us7/ctUQGDH7/OlRlBpSBwDtgyraqCR1uOobnfgXki833A+ymG
         jTn6RxVPI+lKQedYvH+BPNv+gIyIYY8JqHo2ytYXaXfCIwyXDu9AeBdchfJinegzfvUz
         pIfg==
X-Forwarded-Encrypted: i=1; AJvYcCUt3DHYR2SCeCVV8VhGj7HkLlhmOHLFTQdOf2k5T6ELbXb4DYCXDI7/S8Wyiq4Cd7J9Gso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjSV1qC8eRusSA/bsAkTSrJ5P00YboJimzYJb2DcpUq4jzLYi
	gtIaEf0UHck/fuEY61bNcjB4q6TZX0Op0b6MH7n5NhIg0YMV8HjjQ0jsT930LMPuYOGn6i5Zy+x
	4QW4=
X-Google-Smtp-Source: AGHT+IHAXOaWqUjCI598EbktrPNB8p0U3znujJi2/kX+SUeMOCzRFFO5F0Q4XeFbIUJXSzvBP3V5bg==
X-Received: by 2002:a05:6902:18c8:b0:e29:c45:9272 with SMTP id 3f1490d57ef6-e2e3a6070d9mr3877778276.9.1729704625676;
        Wed, 23 Oct 2024 10:30:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcaec280sm1624581276.43.2024.10.23.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:30:25 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:30:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] compat/mingw: allow deletion of most opened files
Message-ID: <ZxkysCb/d3+PJjW4@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <3552feddb332b31744c2ab723b112b9b08926436.1729695349.git.ps@pks.im>
 <bc829d84-6696-4e16-9687-8ba611af29ff@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc829d84-6696-4e16-9687-8ba611af29ff@app.fastmail.com>

On Wed, Oct 23, 2024 at 06:17:15PM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Oct 23, 2024, at 17:05, Patrick Steinhardt wrote:
> > On Windows, we emulate open(3p) via `mingw_open()`. This function
> > implements handling of some platform- specific quirks that are required
>
> s/platform- specific/platform-specific/
>
> Linewrapping artifact?

Looks like it. Thanks for spotting.

> > to make it behave as closely as possible like open(3p) would, but for
> > most cases we just call the Windows-specific `_wopen()` function.
> >
> > This function has a major downside though: it does not allow us to
> > specify the sharing mode. While there is `_wsopen()` that allows us to
> > pass sharing flags, those sharing flags are not the same `FILE_SHARE_*`
> > flags as `CreateFileW()` accepts. Instead, `_wsopen()` only allows
> > concurrent read- and write-access, but does not allow for concurrent
> > deletions. Unfortunately though, we have to allow concurrent deletions
> > if we want to have POSIX-style atomic renames on top of an existing file
> > that has open file handles.
> >
> > Implement a new function that emulates open(3p) for existing files via
> > `CreateFileW()` such that we can set the required sharing flags.
> >
> > While we have the same issue when calling open(3p) with `O_CREAT`,
>
> s/O_CREAT/O_CREATE/ ?

No, O_CREAT is the flag name.

> > +	};
> > +	HANDLE handle;
> > +	int access;
> > +	int fd;
> > +
> > +	/* We only support basic flags. */
> > +	if (oflags & ~(O_ACCMODE | O_NOINHERIT))
> > +		return errno = ENOSYS, -1;
>
> This use of the comma operator is maybe an idiom to save space and avoid
> a brace around the `if`?  This pattern is already in use in
> `mingw_open_append`.  I see in `mingw.h` that it uses:
>
> ```
> static inline int symlink(const char *oldpath UNUSED, const char *newpath UNUSED)
> { errno = ENOSYS; return -1; }
> ```
>

Yeah. What Patrick wrote here is not technically wrong, but I would not
consider it in the style of the rest of the project. Perhaps
compat/mingw-stuff is a bit of a wild west, but I think it would be
match the rest of the project's conventions here.

I actually think from grepping around that mingw_open_append is the only
other function in the tree that uses the "return errno = XXX, -1;"
trick. It might be nice to keep it that way, and/or rewrite that portion
like so:

--- 8< ---
diff --git a/compat/mingw.c b/compat/mingw.c
index df78f61f7f..c36147549a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -494,8 +494,10 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	DWORD create = (oflags & O_CREAT) ? OPEN_ALWAYS : OPEN_EXISTING;

 	/* only these flags are supported */
-	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND))
-		return errno = ENOSYS, -1;
+	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND)) {
+		errno = ENOSYS;
+		return -1;
+	}

 	/*
 	 * FILE_SHARE_WRITE is required to permit child processes
--- >8 ---

Thanks,
Taylor
