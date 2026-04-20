Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A3A39DBD6
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718364; cv=none; b=AjrEWJTDlgT1nKp4A0rBxSGoq+J+W3qqmjnL2cZtyeRjBOJSw+F+D8uUhiiG85wQMETn1y7Flg/nHTAS7mZ8ngLp2YeVX/JURWvPr91pEAiDoDmDhG1TZFg3bvC+myLRhrYsTmXuMfFmIj/qcBPIhR17jq7jzlheQxR6cT4VEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718364; c=relaxed/simple;
	bh=KNtheMCP91qD9dI6kQcgNWVcc9LrNRDSXT8+oL7RgNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2w4sslnQ2XJk6WuGz9XNAtQYBnYZS/PAfJ5xx9WzDG9VbDIbv0RZo1uKXxUryRD23lnSxSCIZrTguwhqxvneFRJE0f6b9Nx5mWXnqDh5YA1rEI+Kj65EvD43+m3CXJijF+oLnF7pBQjOkavPZFiq9dlfzWMOT21hOAeHNi90tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6vvjTpM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6vvjTpM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so6956835e9.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776718361; x=1777323161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xRSjrq9QCyZsE/GhbwrGZEmpRouesyQRYJ1Y/KHkF8o=;
        b=U6vvjTpMWNg5wnTuBMpMeOh+KUcM5+YSUVyFM/wJBe4lvG9IjWtAj9mC3ORRsWtD50
         uKyX586/fN/dl7mIRDe7Y//iVzNIdIs9+AcW5wHDJTVh3asHSoYfKYHgWIDiU2SNMDhU
         2gRkXVMxoH8joRTnmSGaB/j83OcLlvrRnDKyWZLT9qTyD8bAfnyYMhEr+SJhnI326Okf
         rLby81jS6nnstfyn63tfhlJqAK59cv6/DeKUq+IYQU4REet8DJ89eT20b//zFKl559ih
         Ph+ve1o3jZv34pY70oNAyrKkid+RAs7AB1IqsE2VYxKzeuLsi/Xdscx5jpETFvTfjV4A
         j69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776718361; x=1777323161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRSjrq9QCyZsE/GhbwrGZEmpRouesyQRYJ1Y/KHkF8o=;
        b=CNQcl18rB3BSSgbhVg1VLeUho03BMaKvJCABfkiNPOxwB5fiU63V0fvyPBm7o6Bauf
         lrbVK+SOGbNJ1Y/CjT0D04jMtbS3LYp0WDvCVErshPX2GUVPbp6eKlDOSYHJ0JU6Jrkp
         XroSGJs+12gU+9S9UpWc5XQSKbDVUPg8NStk26uGcHIHcguRxcIOiFuWZ86gA6rTSO/d
         w3ZUtpwY3ep0JGrz+lbLug6T0SEAGgw7zyjwcWhiPkhAbZG9g07hCAhf6DBk9j7B5U/w
         B+TiDTAshDhJeki2TdoDoTwmI0/OGpkCguDeM4OKngfR9mH8+JA3kO/FmMxU/ZJXlngv
         Yglg==
X-Gm-Message-State: AOJu0YyQmUPLnVE+7+1DDbu0mvwfXint8h/KgGUxvVUaKKuKw63nh2O9
	SywXuZbBy+l6CFHgoxd+7Vs9V/Tww0+lIrJatWRbO2TJb8PRIVEaORei
X-Gm-Gg: AeBDievnWfr02qv5vpOVLoSio6RW1/2Fz7inxEJxbg3c/4rFOtXrMF0wxCZOLDl186Z
	x4EzzARWkFFPpDmXdx5jD69Np18YLBHXVPiQynD69rPzMCx9v8HrvoNaEV+iutRgq/Q53dejbM3
	sxnhxXFUUyPRS3AsOqXz+OQYA4nBFg8l+yCKcOmFCl5JegY3iPqJRaacy9dIatha8EzIUlU/7XE
	6IbJMCMfFUlD+CcdWxPXCE0h7MxuTzpsus/1QOe+3zsB12ZE+xeVUtmgIx+F3zZB4pc++Wcdehw
	eOR74OUecx9KCLn2j7G0OXHCo9VALCZeE7wndYfIcZUNO07jToYvL9nM4+sfGf67dMhtVJ9z9oI
	2RGC8UTXMTRJ9QlXbQdbzmvbb/Q1vb4gwsqN58WpUvr5bGuqIFhftVgCtNRB+pah1Gx3GvgcHHv
	fp/dSphFvPYCLXm/25iUDA949nO7C31KhoZ2ndkgaFwFkgNrD47+Slbt21R3Hg6u3K4hu0VwY=
X-Received: by 2002:a05:600c:a305:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48a53cb8949mr19592355e9.14.1776718360527;
        Mon, 20 Apr 2026 13:52:40 -0700 (PDT)
Received: from localhost (94-21-29-205.pool.digikabel.hu. [94.21.29.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm44858135e9.13.2026.04.20.13.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:52:39 -0700 (PDT)
Date: Mon, 20 Apr 2026 22:52:16 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t6112: avoid tilde expansion
Message-ID: <aeaSAMOqg5RzfdIA@szeder.dev>
References: <20260418163236.2382826-1-szeder.dev@gmail.com>
 <CABPp-BGV4DGwoSDCjjW2NWBhWXNDfeXwb-tPWSH_13mF0DCiRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGV4DGwoSDCjjW2NWBhWXNDfeXwb-tPWSH_13mF0DCiRg@mail.gmail.com>

On Sat, Apr 18, 2026 at 06:26:00PM -0700, Elijah Newren wrote:
> On Sat, Apr 18, 2026 at 9:33 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > e987df5fe6 (list-objects-filter: implement composite filters,
> > 2019-06-27) introduced a test to "t6112-rev-list-filters-objects.sh"
> > that checks the output of a Git command with the following commands:
> >
> >   grep ~$omitted_1 actual &&
> >   grep ~$omitted_2 actual &&
> >   grep ~$omitted_3 actual &&
> >
> > Since the leading tilde in the pattern is not quoted/escaped, it is
> > subject to tilde expansion.  So if the system has a user whose
> > username happens to be equal to the content of one of those
> > "$omitted_*" variables, then "grep" would look for the user's home
> > directory.  Luckily, those variables contain object hashes, so this is
> > not very likely.

On second thought, tilde expansion should happen before
parameter/variable expansion, so the above is wrong: we are looking
for a user named "$omitted_1" and not a user named like whatever
object hash the "$omitted_1" variable holds.

Still unlikely, but we should still avoid it.

> > Furthermore, Bash versions v5.0 and earlier seem to be buggy and don't
> > handle this particular tilde expansion very well, and either segfault
> > right away or, in case of v3.2, get stuck in an endless loop and
> > segfault upon receiving ctrl-c.
> 
> Interesting find on the bash segfault behavior.

Actually, I'm going to take back that statement about the Bash
segfault.

I tested older Bash versions with binaries that I compiled myself from
the sources at git://git.savannah.gnu.org/bash.git, and those
exhibited the segfault in v5.0 and below.  Bisect shows that v5.1 is
not just the first release but the first commit that doesn't segfault
on t6112.

However.

Bash v5.1 was released on 2020-12-06, about a year and a half after
those unintended tilde expansions were added.  I find it hard to
believe that noone stumbled upon this issue during that time...
Suspicious, I booted my old laptop running an outdated Debian
derivative with distro shipped Bash 5.0.17, and, lo and behold, t6112
passed just fine.

So I'm inclined to think that something is wrong here...  No idea
what, though.  I can reproduce the segfault with something as simple
as "./bash-v5.0 -c 'v=~a'", and the segfault doesn't even come from
Bash but from within getpwnam() called during tilde expansion.
Oh, well.

Will send a patch with updated log message some time later.

