Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B807D221DA6
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473701; cv=none; b=EZS0a3ZVj4SDHweq0QE2STfe63u4xD640xQ+ejlt5rk4FuHlzhKUtfchU/8svpV+FyDPCfE+XY1yb9svRuWoKyFEjYQETjeuqgQKmAOkjCjJLhC1X5XFwVoMYD+GQ2tixBhJBvTYO/deH+5TzDsVUh/q6oYOzlGanarbmKsYjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473701; c=relaxed/simple;
	bh=dDLa2T0rqU+jZPgpmhaAZVLwBhbKKkGgpb4FCj4sTCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViS5HKdpf3u/3nBR0uDbWqOB3HWvWJc/lbkAriKYLZPA/NPTwQMfYJsyw9JMfTPWIXetXUOkbdLYg2olHAX86iuTv8EEfrcsH0myuI8LZDbXch9gFQwAk7YjzYXnjPv3kETVuVGIrruCQly5zHkPpq7vLvxCtRJ9LUT3Re6oEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=IZ1AxiGq; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="IZ1AxiGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1748473685; x=1749078485; i=tboegi@web.de;
	bh=8mC3FkdvG1Y2Voa5+eTTJPKtTJPwGdGGngcRDKpW9DM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IZ1AxiGqg7kiBdZj2z2BVbaiErhKsV26XFTcS7XFcrXFpn8vrkous2AaskEhaGIe
	 kBnkLcQBb+OqQFcx8x13yMDTSFwUXGfWqLc2R6gYtbw8vNUE2mI5OU9+nSSqx0hyC
	 8Hig/vZWTWse0Oz+RIzbxk39sG2h9uVIR4V6qvcEJkl5UjNzOxKveYfNAe0WCNVU6
	 oPVmc7Le1WtDonCvDBmE4pFczQmT3pbt2gFqb0kJHg47ECF0peM0t4DONqKMVQsSu
	 9iTMpXAso/Oxxi/iWyRMd8lQ7GFJjLfxXPmUPplDD1GiFD/ONF9oNJhrMZX2VuYVR
	 Hj9YsbpYQGnCAJXB1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qvH-1v5Lai0FVN-00x2ba; Thu, 29
 May 2025 01:08:05 +0200
Date: Thu, 29 May 2025 01:08:04 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Mark Mentovai <mark@chromium.org>
Cc: Git Development <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] t: run tests from a normalized working directory
Message-ID: <20250528230804.GA16856@tb-raspi4>
References: <20250523193722.68344-1-mark@chromium.org>
 <20250528201737.55268-1-mark@chromium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528201737.55268-1-mark@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:PT9EGInaF0JXxVnyQPs1zx6FSB6aDcODZgnClvE3ZVNTzNqIHGv
 Hjz3BryOLf2edgvNbRTjoVy7CzjiEbQroFS5Sno8ztEsVmfsLc0YSsH3mMYo0lOv5neuHtd
 1nkn2oEs1gSXkOLFpmbBOuNKTUFGaH2AEanEimrpCmKcm2PhoGsGRCqSLKVT8comOthQswk
 ANgtfniqbS0+xsscYNcnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zDwcPL+r+OE=;mnVqAhUAHChyynAsP1NT2g441TQ
 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
 +O6Ep+vU4rqs9fAl
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 04:17:37PM -0400, Mark Mentovai wrote:

The problem is well described, thanks for that.
However, different words and terms are used for the same thing:
  "normalized working directory" (which is easy to confuse
    with normalized working tree where CRLF-LF conversion had been
    done and clean filters applied.
  "pathname canonicalization"
  "canonical absolute path"
  "normalized path"
... and that is done in "strbuf_realpath()"

May be the word normalized can be replaced here ?
Starting with the head line, how about this:
t: run tests from an absolute path

And later in the text:
use "absolute path" instead of "normalized path" ?

> Some tests make git perform actions that produce observable pathnames,
> and have expectations on those paths. Tests run with $HOME set to a
> $TRASH_DIRECTORY, and with their working directory the same
> $TRASH_DIRECTORY, although these paths are logically identical, they do
> not observe the same pathname canonicalization rules and thus might not
> be represented by strings that compare equal. In particular, no pathname
> normalization is applied to $TRASH_DIRECTORY or $HOME, while tests
> change their working directory with `cd -P`, which normalizes the
> working directory's path by fully resolving symbolic links.
>=20
> t7900's macOS maintenance tests (which are not limited to running on
> macOS) have an expectation on a path that `git maintenance` forms by
> using abspath.c strbuf_realpath() to resolve a canonical absolute path
> based on $HOME. When t7900 runs from a working directory that contains
> symbolic links in its pathname, $HOME will also contain symbolic links,
> which `git maintenance` resolves but the test's expectation does not,
> causing a test failure.
>=20
> Align $TRASH_DIRECTORY and $HOME with the normalized path as used for
> the working directory by resetting them to match the working directory
> after it's established by `cd -P`. With all paths in agreement and
> symbolic links resolved, pathname expectations can be set and met based
> on string comparison without regard to external environmental factors
> such as the presence of symbolic links in a path.
>=20
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Mark Mentovai <mark@chromium.org>
> ---
>  t/test-lib.sh | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index af722d383d9b..92d0db13d742 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1577,6 +1577,8 @@ fi
>  # Use -P to resolve symlinks in our working directory so that the cwd
>  # in subprocesses like git equals our $PWD (for pathname comparisons).
>  cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTOR=
Y\""
> +TRASH_DIRECTORY=3D$(pwd)
> +HOME=3D"$TRASH_DIRECTORY"
> =20
>  start_test_output "$0"
> =20
>=20
