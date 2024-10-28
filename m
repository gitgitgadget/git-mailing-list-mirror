Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AA1DF251
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137086; cv=none; b=KOVmP5y+Z+x2iIVboJnWFAMkvs4NhreriLxv5zWZoFac1HXXvBw0Y3gGoG2k9MldpjWQ9qgj/u+KmRQ2mwrD81Kl1y3xfxTigK3IrjTwAm+GAIOXgqw5iO/fh02XXQCEPYiPHziz8dK7pLwgr9M40sUo2aYLd1cVfRT0c1201C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137086; c=relaxed/simple;
	bh=TiLL54DZ1M084QjEevdTEXU+dF1Z5gAm5oeMXO0uX3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPrlM4MHsXrnHwwHQcabY0HaG4vgu0CUiqxe/bfPy2xGGwMZq7cGE5QxmtFw355jcxOEGydUt6Cq/Vicz9rNagmwPJTpDtTmE6HY0HL8g3O1D4x1IuW+kZptnO51xuRKkRnrUT6Eka5x1TB/WFrAxHr5+W27soQmODsvkbzBtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZNCQLkHy; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZNCQLkHy"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea0b25695dso8876397b3.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730137083; x=1730741883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCDs5nVv7+iueVV5XfwS2bpjQ0lONHaOZZB0zsvStWE=;
        b=ZNCQLkHyw2p+W2CzhKafRq+RbhcGgnh2qQLiwKi0tzKcwB/BpDGZBIV4MT+e3RFll+
         YYh8lUm5Ccf44VjZJEon+p89PTfmZbJy9YRljV3pFnEGuyCIWbYTl5wMmBNOSLkVsHf6
         zk8GVtYD/RXG3+sMCzmCHz2uizU6cjrZruwT/AnTBOoDYRImn4Z1l3kq0iPhizGY//21
         iJQj8Rg4DSX4oi2ASJkqJMRiOXP81iafE5VQLnUZrGX4apKp0/pEX0HyrmPhzq5OynOW
         QeyNC/FKLVT+Z02MB20+wzxumze/RFwAC2mZz4KShtFaB50LwaRuxNe2MciBR0XIyGHZ
         JZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137083; x=1730741883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCDs5nVv7+iueVV5XfwS2bpjQ0lONHaOZZB0zsvStWE=;
        b=rmc4a7zF5QzvwbkX/nt2kU0o6Jah0Xg17tOH4dlupAWMhl/QVb+xyzkg7SniIeVw3E
         ifvRyovgDi5OfpAN2qIyqSM/Wl4DhImHl/gZKmjmqM5FNWFnd7nmZ40JKxHA4xcoKvrR
         idqYI0eiIVXKSDd5g8fM2y6O4An371BMHCJH24EBOBugSWmUk/JB3QrcFuxxRXTzrgLh
         h4xkEmvX5HYuXF/Aaz91z/RTGPd8+S8nes1HXeNzGnQP4/ES/FilLJ+x+3g0dUPtdnpd
         mfxiiPhdHzqmPYQ+YOxQgspHLA0JmQ5H3NTefIMx2JHCcMRDpIywRXqTl/epEz0jZFJK
         2J6Q==
X-Gm-Message-State: AOJu0Yyj4Oh4uO7XNT3U9bQP5ooDGQ9jOmi34QRMo9eHxPXj0A3yBBwI
	2kwytXkqBSkpr95qS1ZYfsyGBbmhGZtnLNjKyYNZ4su52JAnl655jOy8UJW1vQZqjiLZyZNENWg
	+2CM=
X-Google-Smtp-Source: AGHT+IH2eHEIg7IX3UwISYjejOPbD7LTx0agFrimg6MvT/h13VKtwp5nVSYRQcSeP6NoT1L0ncvDhg==
X-Received: by 2002:a05:690c:ec7:b0:6e3:39c1:1686 with SMTP id 00721157ae682-6e9d88ed1bdmr89117077b3.9.1730137082613;
        Mon, 28 Oct 2024 10:38:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c19d42sm15463047b3.71.2024.10.28.10.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:38:02 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:37:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #11; Fri, 25)
Message-ID: <Zx/L95EP/mLJC+V4@nand.local>
References: <Zxv0SgY0oajpst8s@nand.local>
 <Zx8kbrQVmMyLV0-w@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zx8kbrQVmMyLV0-w@pks.im>

On Mon, Oct 28, 2024 at 06:43:16AM +0100, Patrick Steinhardt wrote:
> On Fri, Oct 25, 2024 at 03:40:58PM -0400, Taylor Blau wrote:
> > * ps/mingw-rename (2024-10-24) 3 commits
> >  - compat/mingw: support POSIX semantics for atomic renames
> >  - compat/mingw: allow deletion of most opened files
> >  - compat/mingw: share file handles created via `CreateFileW()`
> >
> >  Teaches the MinGW compatibility layer to support POSIX semantics for
> >  atomic renames when other process(es) have a file opened at the
> >  destination path.
> >
> >  Will merge to 'next'?
> >  source: <cover.1729770140.git.ps@pks.im>
>
> I'd wait a couple of days for reviews on v3, which I have sent out
> yesterday.

Yeah, this one will cook in 'jch' for a little while longer until we
hear from Johannes Sixt or others on the new round.

> > * ps/leakfixes-part-9 (2024-10-21) 22 commits
> >  - list-objects-filter-options: work around reported leak on error
> >  - builtin/merge: release outbut buffer after performing merge
> >  - dir: fix leak when parsing "status.showUntrackedFiles"
> >  - t/helper: fix leaking buffer in "dump-untracked-cache"
> >  - t/helper: stop re-initialization of `the_repository`
> >  - sparse-index: correctly free EWAH contents
> >  - dir: release untracked cache data
> >  - combine-diff: fix leaking lost lines
> >  - builtin/tag: fix leaking key ID on failure to sign
> >  - transport-helper: fix leaking import/export marks
> >  - builtin/commit: fix leaking cleanup config
> >  - trailer: fix leaking strbufs when formatting trailers
> >  - trailer: fix leaking trailer values
> >  - builtin/commit: fix leaking change data contents
> >  - upload-pack: fix leaking URI protocols
> >  - pretty: clear signature check
> >  - diff-lib: fix leaking diffopts in `do_diff_cache()`
> >  - revision: fix leaking bloom filters
> >  - builtin/grep: fix leak with `--max-count=0`
> >  - grep: fix leak in `grep_splice_or()`
> >  - t/helper: fix leaks in "reach" test tool
> >  - builtin/ls-remote: plug leaking server options
> >
> >  More leakfixes.
> >
> >  Needs review.
> >  source: <cover.1729502823.git.ps@pks.im>
>
> I'd be happy to get some eyes on this series. It's the second-last step
> to make Git leak-free, so there's only going to be one more such tedious
> series. And the last step is already waiting to be sent out :)

That's very exciting. I'll put it on my list (though this week I am
working in San Francisco and have a few other things going on so I have
less review time than usual).

> > * ps/platform-compat-fixes (2024-10-16) 10 commits
> >  (merged to 'next' on 2024-10-22 at 46b99d8301)
> >  + http: fix build error on FreeBSD
> >  + builtin/credential-cache: fix missing parameter for stub function
> >  + t7300: work around platform-specific behaviour with long paths on MinGW
> >  + t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
> >  + t3404: work around platform-specific behaviour on macOS 10.15
> >  + t1401: make invocation of tar(1) work with Win32-provided one
> >  + t/lib-gpg: fix setup of GNUPGHOME in MinGW
> >  + t/lib-gitweb: test against the build version of gitweb
> >  + t/test-lib: wire up NO_ICONV prerequisite
> >  + t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
> >  (this branch is used by ps/build.)
> >
> >  Various platform compatibility fixes split out of the larger effort
> >  to use Meson as the primary build tool.
> >
> >  Will merge to 'master'.
> >  source: <cover.1729060405.git.ps@pks.im>
>
> I've sent a fixup commit for t6006, which got subtly broken [1]. So
> let's first add that fixup and then continue merging down.
>
> [1]: <ccb2d7cf817a181fab8fb083bdc9f1fed4671749.1730092261.git.ps@pks.im>

OK, thanks.

> > * ps/upgrade-clar (2024-10-21) 5 commits
> >  - cmake: set up proper dependencies for generated clar headers
> >  - cmake: fix compilation of clar-based unit tests
> >  - Makefile: extract script to generate clar declarations
> >  - Makefile: adjust sed command for generating "clar-decls.h"
> >  - t/unit-tests: update clar to 206accb
> >  (this branch is used by ps/build.)
> >
> >  Buildfix and upgrade of Clar to a newer version.
> >
> >  Needs review.
> >  source: <cover.1729506329.git.ps@pks.im>
>
> Bagas has tested this series on the previously-broken platform [2] and I've
> got a review from Karthik [3]. So I'd think that it's mostly ready to go by
> now.
>
> [2]: <Zxx3nmfp61DR6vvB@archie.me>
> [3]: <CAOLa=ZR6cnhxy7K7TChxLafm7Ep0XUVFSK+LgNPtNX8yVLyWtA@mail.gmail.com>

Great, yeah, let's start merging this one down then.

Thanks,
Taylor
