Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB51BBBC3
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093136; cv=none; b=lzeieL02ntYLGi5vWMHOES/Yc+XIT5fHaPYOI1/2nflyTxxQSviPT9jAMpHFPtTE0CRhKDMYzGjHYmNnmrWJr9ChObmu+1mZX73HkadRKTsoIFD1mCutGCGnFqWU1dCMxjo8f8QL39k03vt8EeENSdoL+dvnv1eSey49Yk+bB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093136; c=relaxed/simple;
	bh=t48DMRi0ZaQhOXT/fp0zV2gtsTO0tqdmC//GWk70HKU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XFvk0cH24kDU49IXFD8OlYJIf6c2JCWvVmyEOXzVoKK1OP7WmkZ9ddSBilzZ6Ld79Dg29HoZrhKtnZf6UmnpI4nBmrbe0z0NAa2Dkc1dXUW9rmcuUOyNY0uySjQRIozMuUM65Dr8HUMqJr2/V3lKgJL8twupAPsv3H3d5iujlXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=rrVVCGG5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="rrVVCGG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726093128; x=1726697928;
	i=johannes.schindelin@gmx.de;
	bh=qiae7qBiZ/5zSuJM/AGjeaoAe16zeboHWCWGSQSQIXE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rrVVCGG5MoT0j20W2dLhX7gdRnikuQKGU9a42yVxurl4zPWql2zS7wQqXBCSuIWR
	 /jBgrnflNn6kNNtFKac8Dcxwvjc87r7VkGjgqIJT/LoqPIt8BH6EUm0UNUcyfQ42K
	 ypBbi4kmY9BUyBZaq1DNsAw8t1CYFh9WWFEDcb2irHEvrJz4NMe9uKRSPnOSCMuy5
	 +AglefFg+En80DJOCgUDVyI6JJDJ9whkz8gXgKTjc97yicTdaBbGPAIBcmVZBiaOi
	 Y3Ncv/dcz207v3a7HXZyFSNv1oBWaPOPcodx+LcMU/bEAg2Gz3OPIKMcyeHsN5onQ
	 BgYTIk+1kAsmHTtKAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.102]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH9i-1sIkp20Cgm-00jaSP; Thu, 12
 Sep 2024 00:18:48 +0200
Date: Thu, 12 Sep 2024 00:18:47 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Todd Zullinger <tmz@pobox.com>
cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>, 
    Victoria Dye <vdye@github.com>, 
    =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
In-Reply-To: <ZWVIRXodL9pQZbtj@pobox.com>
Message-ID: <db0aeda7-f266-8b1a-517f-c0bea4d4e02b@gmx.de>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de> <ZVeUQEG5jIzKbvmT@pobox.com> <4dd9b45d-b352-d8ba-3314-96ab48f7abf7@gmx.de> <ZVgoKPAg6jKZk_M6@pobox.com> <1d83b8f8-b739-6277-ac4f-e7fe6ff2d2fe@gmx.de> <ZWVIRXodL9pQZbtj@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1177098757-1726091494=:99"
Content-ID: <a40fed0a-9a08-5b1a-c819-be9cfae99a56@gitforwindows.org>
X-Provags-ID: V03:K1:q8zR5WRZ29+aIpRI+Qac31Ut/l4rnVluc3JXib6GWF5YdLmr5sD
 9WjZLLBFnrnXQhJtGitWxp6P1p0WmAsTB7cxP/NQ/7H0Es7zBEE2as51F2C9VVc6nbXEh0A
 9nFoX5FQU8d/0A8vQsybI4SMo2IWZsJ6oyVHt4Ugysi2a8uIiPiolyYeqFtLBAKprtY0tuX
 otMvVstZaT8xkZ6xNLxqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jpZ7mClVY8g=;iqkjwImzIUamxJjZ7HSTibBDJ03
 SRW1TP39LoA37mC28MxIcPFUXSbvQkjdBGnorLb1ovzWfyE8ptbxSTSxBqByIdOrSofKb/owe
 H0oCA7oAlRKxSkvZIZcq3mLANNEGTcnmbWbYFxdMaCUoPZZ3pZuKCGzsk7LYQiODAJhH+9Did
 VCiWFWJ8N6ZN509mJOiZIQY4r3mjyB8gYCYpxVLR6buNeX99oPb8nY+viVzqlRuMZXd6qZjD+
 ZaR1XSOX++yQxEL6QdmHZVfqgOh3MxNXf7p6nHS/ydY+BZmYQtbkMyzqXCTlKlooQAt+A+anz
 TEcvuH2YSdPQaJ4uhN3WJJnVudA6kaNIoPR0gFrYRxG0cr9+ruVRRfm0HKBREZIr5Qd++qZYS
 rNZVFJ2C+i7t0Q8ZhVBQzRY91UcaM1BYbDDowXF0WGCpwVPPuapJfhylia7df+oVJn3peYb9E
 6TIirFvCxTFAygwAZ9xtjMuqSiOiY+PAlDNOpuDHmebxWJMbVmvFFvHaIPQ0MC5kXJIaQwjBl
 VERSHYbC6whn1rPGU95TtnuwNuw/D5lg6kNOa36i1yajshGTu6ebW1mMtsZYOlfdRkDVF2DVX
 TzIi9DWJsHU1Z/be3Qzxl8LpFVPRZr9QMcAwi4ss2zQED6Cfo/lrkZg2ErMi5BYE6Q9MOm+A5
 ci0WjF92dyTOV7XeHG3vXdR+ilTfXN1rPIH7EGC6Kn6rYaESiNi7rMbkeUF+l2FTViKut8SIX
 SG7k33Gh3aUflPvdge0LCI+HJWAhv2QoJPDodcEhIQuDh/usbbvAGXCEYV5LYyT8oPK8I0A03
 9gs3kKU8hiJaUrWhIf86O3Dv1cJvaVrAVnQvO5ddcwOCSY4xNdCzc084dlBSlIrMLvslljN+J
 VAzHkeIv9DJ6Drg==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1177098757-1726091494=:99
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <ef701657-1dbc-e50e-31a5-9c225c041e00@gitforwindows.org>

Hi Todd,

On Mon, 27 Nov 2023, Todd Zullinger wrote:

> Johannes Schindelin wrote:
> > I found https://lychee.cli.rs/#/ in the meantime and figured out how t=
o
> > use it in a local setup:
>
> Nice.  That's much faster.
>
> > My most recent lychee run results in 0 broken links.
> >
> > As a bonus, some of the links that are currently broken on
> > https://git-scm.com/ are fixed in https://git.github.io/git-scm.com/.
> > For example, following the `Pull Request Referl=C9=99ri` link at the t=
op of
> > https://git-scm.com/book/az/v2/Appendix-C:-Git-%C6%8Fmrl%C9%99ri-Plumb=
ing-%C6%8Fmrl%C9%99ri/
> > leads to a 404. But following it in
> > https://git.github.io/git-scm.com/book/az/v2/Appendix-C:-Git-%C6%8Fmrl=
%C9%99ri-Plumbing-%C6%8Fmrl%C9%99ri/
> > directs the browser to the correct URL:
> > https://git.github.io/git-scm.com/book/az/v2/GitHub-Bir-Layih%C9%99nin=
-Saxlan%C4%B1lmas%C4%B1/#_pr_refs
> >
> > Another thing that is broken on https://git-scm.com/ are the footnotes=
 in
> > the Czech translation of the ProGit book. These were broken in the Hug=
o
> > version, too, but now they are fixed. See e.g.
> > https://dscho.github.io/git-scm.com/book/cs/v2/Z%C3%A1klady-pr%C3%A1ce=
-se-syst%C3%A9mem-Git-Zobrazen%C3%AD-historie-reviz%C3%AD/#_footnotedef_7
> > and note that the Rails App redirects to
> > https://git-scm.com/book/cs/v2/Z%C3%A1klady-pr%C3%A1ce-se-syst%C3%A9me=
m-Git-Zobrazen%C3%AD-historie-reviz%C3%AD/ch00/_footnotedef_7
> > when clicking on the `[7]`, which 404s.
> >
> > Could you double-check that the links in the current version?
>
> Since I had it already, I ran linkchecker again.  It found
> 25 errors.  I'll attach the output, though I'm not sure if
> the list will pass it along or not.
>
> It looks like a number of errors are due to '?' characters
> in the generated links, e.g.:
>
> https://git.github.io/git-scm.com/book/en/v2/Getting-Started-What-is-Git=
?/

_That_ was quite a quest to investigate and to fix. The problem here is,
of course, the difference in how question marks are handled in file:// vs
https:// URLs: in the latter, they separate the path part from the query.
Therefore, they need to be URI-encoded in https:// URLs.

I verified manually (and with a Playwright-based test that is now run as
part of every deployment and of every PR build) that these URLs with
question marks in them work.

As to using `lychee` to verify the links, I went down quite a rabbit hole
to allow using it on the very same files that are being deployed, with
relative URLs and "ugly" ones at that, too (i.e. with the `.html` suffix
that you do not need to specify when accessing `.html` files on GitHub
Pages). This has not yet been released in an official version, therefore I
need to use the `nightly` version for the time being.

The good news is that the link checking is integrated into the deployment
and PR builds in https://github.com/git/git-scm.com/pull/1804. That will
allow us to catch broken links faster. One caveat, though: for robustness
(and also for speed), only internal links are checked. Links pointing to
other websites are not validated, but it is easy to do that manually by
running Lychee without the `--offline` flag.

Ciao,
Johannes

--8323328-1177098757-1726091494=:99--
