Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB64086A
	for <git@vger.kernel.org>; Sat, 31 May 2025 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748670392; cv=none; b=rS+OTQXktBh9/O4zl9Z+187VqUnoTwXWdK5WNejWMOTQpevYrqJFERCg4+xCE8M0WGgFDDdpHYAuyxh98YgC194wJQf/GuSCxl8nhldyhFVU8o0+ktNuOLJ3gsiiQmIjiesVAGq6+w4UHclNOjcApiOR00DlvzeDFgHAZkBE87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748670392; c=relaxed/simple;
	bh=64FA0F1zHzkh4eaWiCXBQ02EtLl4RibXzanSZH6HZLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8aSKgh7VnC4x3eIuRRcdDA4tAQZwYfUA78XiHF9uMAX5yjhLAe58pGvH1ub1jF3bythaTaRF4okIw402ij71lf6o1FAgADg+ZyCHLSyhwFAN3GxuUny20buFKzp9bq4HY4R2A5CoC8uK6XsSY53/5Qa1RSSGPZFGjetblBDZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=gyRhkc+X; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="gyRhkc+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748670379; x=1749275179; i=tboegi@web.de;
	bh=ShcWBiukKf/t4YpoQQ9cRRxJfginFOyWeOBJmBwwPis=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gyRhkc+XhPNTRmzAyRPHZGzJU5RBISYl0UTEsm8l15/ZWp8HiqITyEWE27VLMck5
	 2lM261/gJjS5pALgGryjbFbUMfpvq1fjk8MjNwS40N0P2k5IDnTCnqj77HE0BRgwb
	 U27tmMP71iO8STXqvKVA4CsdcR1P/eZwmuLxE2XHB6xRLh/hBLkJC0S2osDJuxPxI
	 ING8RqQGHAyF1li0giPBfI1UUvQp8BrXlZ+D3Mf41nVzqaPhpfKKB0YPXbqOuWAZt
	 35IhQL7RzWkqo/N9Dbx4x1yECvu165RXreuFFlBahXB+3uW9yrC+l9RWarqScwsJP
	 CFiH8wzn8vs4NtVR7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGSU-1uBvNA3YqQ-00H3Na; Sat, 31
 May 2025 07:46:18 +0200
Date: Sat, 31 May 2025 07:46:18 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mark Mentovai <mark@chromium.org>,
	Git Development <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] t: run tests from a normalized working directory
Message-ID: <20250531054618.GA30443@tb-raspi4>
References: <20250523193722.68344-1-mark@chromium.org>
 <20250528201737.55268-1-mark@chromium.org>
 <20250528230804.GA16856@tb-raspi4>
 <xmqqfrgmhep3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqfrgmhep3.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:hE5yU4cGz9zyESz0t1lcPYm8w9mPZutAqju7g/D1qxPRS1UPbsn
 FUdxdH5josCzMGLyCPtehmbIC5IP4WQYXiGITRDyWbhdmnlrp3VHOWfc3ByaUETyOPctce7
 8ZRM3SJcE62eap9q6UXenZC2AZTUwl2CSBBmYBtBGdN2RHUyVRjEa+THvNYI5ZoK3VyyE/U
 tg7m3nUp3hPe2Spc1ehUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:abC1evJ4U0Q=;Qx8P+fZNn9k/sMZ8RDZqOvpFATi
 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

On Thu, May 29, 2025 at 10:04:24PM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
> > On Wed, May 28, 2025 at 04:17:37PM -0400, Mark Mentovai wrote:
> >
> > The problem is well described, thanks for that.
> > However, different words and terms are used for the same thing:
> >   "normalized working directory" (which is easy to confuse
> >     with normalized working tree where CRLF-LF conversion had been
> >     done and clean filters applied.
> >   "pathname canonicalization"
> >   "canonical absolute path"
> >   "normalized path"
> > ... and that is done in "strbuf_realpath()"
> >
> > May be the word normalized can be replaced here ?
> > Starting with the head line, how about this:
> > t: run tests from an absolute path
> >
> > And later in the text:
> > use "absolute path" instead of "normalized path" ?
>=20
> Thanks for a careful reading.  When I read the log message for the
> first time, it did not bother me too much that it said canonicalize
> and normalize interchangeably, and the two verbs still do not bother
> me terribly.  I agree with you that clearly describing what the
> canonicalization rules do (i.e. fully resolving symbolic links to
> make the path absolute) very good idea, but I think the last
> sentence of the first paragraph does a good job at it already.
>=20
> Can you offer a rewrite along the lines you suggest so that we can
> compare?  I personally felt that what Mark gave us, albeit a bit on
> the more verbose and repetitive side, were written clearly enough.
>=20
> Thanks.

Here is an attempt to do so.
The word canonical has been removed.
After reading the help for
'pwd -P' and 'cd -P'
"absolute" is replaced by "physical".
A matter of taste.
If absolute is more used here in Git, I am fine with any.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
t: run 7900 tests from the physical working directory

Some tests make git perform actions that produce observable pathnames,
and have expectations on those paths. Tests run with $HOME set to a
$TRASH_DIRECTORY, and with their working directory the same
$TRASH_DIRECTORY, although these paths are physical identical, they do
not observe the same pathname normalization rules and thus might not
be represented by strings that compare equal. In particular, no pathname
normalization is applied to $TRASH_DIRECTORY or $HOME, while tests
change their working directory with `cd -P` which resolves symbolic links
returning the physical path.

t7900's macOS maintenance tests (which are not limited to running on
macOS) have an expectation on a path that `git maintenance` forms by
using abspath.c strbuf_realpath() to resolve the physical path
based on $HOME. When t7900 runs from a working directory that contains
symbolic links in its pathname, $HOME will also contain symbolic links,
which `git maintenance` resolves but the test's expectation does not,
causing a test failure.

Align $TRASH_DIRECTORY and $HOME with the physical path as used for
the working directory by resetting them to match the working directory
after it's established by `cd -P`. With all paths in agreement and
symbolic links resolved, pathname expectations can be set and met based
on string comparison without regard to external environmental factors
such as the presence of symbolic links in a path.
