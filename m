Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA65325728
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092403; cv=none; b=IQDjy21T2LBnodQjiNc4dUJhZ9PYT0WZ/lzcupDXs5i1fADPlOSksOgvLqsSwMUstaRFNm5WIT/cNYBnI7MWWd82z3rIHko/kqk1bxxWC2XSZ5Z0rxZQzQTIPBwqLws5q/vyJyRfhf9nLXuvFrH1Jk1PycEnl/ELIIW2DSuwM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092403; c=relaxed/simple;
	bh=eLXAv43/7TsJ7EK7/fIm4ePZartvJ+5XrHD+DCEdbIA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GKZX7hWv+uU8Fy0Sr+A3WpqKQMRW7YYxMw5dpmlLon04dUk+4V+VE+iAyb2YGuoDzaANirgqIwbdh0bVXBNgHyndiq4lD964LRqx64soYOjxM/kcHh8sBAjFG1kNNJi0j0u7hEO6X4JR64cs4VbUZt77IGNh0bjlD7aACrhTMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=MnplpaQ3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="MnplpaQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764092398; x=1764697198;
	i=johannes.schindelin@gmx.de;
	bh=7pYNRbrpJNGRLjj2M3PXLzGZg8g712ELATPkVI/8xso=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MnplpaQ3bGI+/Ne3UdQRsQoIyyHFejbxpO+twg2QbD9zHXjbHdEgavTDsC8uLD82
	 5d/CDi52EXGb2u5lWA4JMM07j8EiJ/tUbTMhz011qSzrBRGyBAAkkxhrtbIRXQ4cC
	 C/Cj7WW050bfRy6qNo5Qx34RYQ5vLO062jqmCeZSgajyNb3Ljh+X61WO+d67reip+
	 1ExnPl9sKtbmDEY8kTrdlgqNyQCMeAOozzpsToFokqnEFQwP8m+8TKsHEe7DJ0gFy
	 wE9aI6yKuFz210jNUmUtb3zdIu5kOq9jfV0o5Z/U6sXuX65Yt25tKly7R5Oh8FS7Q
	 2GxJjT6OIbkW6+j3Jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1vrDp50Q5N-00jfEf; Tue, 25
 Nov 2025 18:39:58 +0100
Date: Tue, 25 Nov 2025 18:39:57 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci(windows-meson-test): handle options and output
 like other test jobs
In-Reply-To: <20251118093519.GB530438@coredump.intra.peff.net>
Message-ID: <a15a12e5-9099-f43b-fa11-e18d53759c1b@gmx.de>
References: <20251118093221.GA530337@coredump.intra.peff.net> <20251118093519.GB530438@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4Jjw3V6kterq8qE4GFzZRQFOwH711Ot/yACA4NTRI9kAmljcgku
 D4ozXHi48j6r0LiiJ3Bc6eHUEcK6M1h/2mccYRzLLCwnEyVejGfA6sZgDZVDBIo9RZICEo5
 RXH0Fobc2VWE/7ERPrz0nO9GFYp0jqgJwtC2zneqqMd3UJDzaP3pn7i2poBoC8JoO09x/8Q
 S8+jPPCuxNA4zS8g+xGKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JwNFfCL2Nbg=;YzlPFTGQRZ+FVlnmxZwCMocNFtp
 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
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Tue, 18 Nov 2025, Jeff King wrote:

> The GitHub windows-meson-test jobs directly run "meson test" with the
> --slice option. This means they skip all of the ci/lib.sh
> infrastructure, and in particular:
>=20
>   1. They do not actually set any GIT_TEST_OPTS like --verbose-log or
>      -x.
>=20
>   2. They do not do the usual handle_failed_tests() magic to print test
>      failures or tar up failed directories.
>=20
> As a result, you get almost no feedback at all when a test fails in this
> job, making debugging rather tricky.
>=20
> Let's try to make this behave more like the other CI jobs. Because we're
> on Windows, we can't just use the normal run-build-and-tests.sh script.
> Our build runs as a separate job (like the non-meson Windows job), and
> then we parallelize the tests across several job slices. So we need
> something like the run-test-slice.sh script that the "windows-test" job
> uses.
>=20
> In theory we could just swap out the "make" invocation there for
> "meson". But it doesn't quite work, because "make" knows how to pull
> GIT_TEST_OPTS out of GIT-BUILD-OPTIONS automatically. But for meson, we
> have to extract them into the --test-args option ourselves. I tried
> making the logic in run-test-slice.sh conditional, but there ended up
> being hardly any common code at all (and there are some tricky ordering
> constraints). So I added up with a new meson-specific test-slice runner.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thank you for fixing this. The patch looks good to me.

I cannot help but wonder whether switching to Meson was worth it, as we're
not only deviating from the mainstream (if MSYS2 is any indication, Meson
usage is negligible: 16 packages use it in MSYS2, 294 use CMake, and 975
use GNU make), but also are forced to repeat the very same steps we
already took for `make`-based builds and then for CMake builds. This very
much makes me think of some saying I vaguely remember that involves
history and something about repetitions.

> BTW, one curiosity. I tried swapping out "pwsh" as the shell for "bash",
> to match what the non-meson test does. And it _mostly_ works, but
> curiously it causes a handful of mergetool tests to fail (it looks like
> maybe "c:\foo" Windows-style paths get used where we expect "/c/foo"
> paths). I didn't dig further, and just added it to my "things that
> confuse and terrify me about Windows" list.

Indeed, the path conversion kicks in, where `/mingw64` gets converted to
`D:\git-for-windows-minimal\mingw64` or something like that so that
PowerShell isn't losing its mind over paths that simply don't exist. When
you then call Bash (implicitly, as you know all too well Git's test suite
depends on it in a major way, which is still a shame), this conversion is
not reverted, at least not fully.

Ciao,
Johannes

>=20
>  .github/workflows/main.yml | 12 +++++++++++-
>  ci/run-test-slice-meson.sh | 13 +++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100755 ci/run-test-slice-meson.sh
>=20
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 816d5a34c4..27ebf2c8cc 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -298,7 +298,17 @@ jobs:
>          path: build
>      - name: Test
>        shell: pwsh
> -      run: meson test -C build --no-rebuild --print-errorlogs --slice "=
$(1+${{ matrix.nr }})/10"
> +      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
> +    - name: print test failures
> +      if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> +      shell: bash
> +      run: ci/print-test-failures.sh
> +    - name: Upload failed tests' directories
> +      if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
> +      uses: actions/upload-artifact@v4
> +      with:
> +        name: failed-tests-windows-meson-${{ matrix.nr }}
> +        path: ${{env.FAILED_TEST_ARTIFACTS}}
> =20
>    regular:
>      name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
> diff --git a/ci/run-test-slice-meson.sh b/ci/run-test-slice-meson.sh
> new file mode 100755
> index 0000000000..961c94fba0
> --- /dev/null
> +++ b/ci/run-test-slice-meson.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +
> +# We must load the build options so we know where to find
> +# things like TEST_OUTPUT_DIRECTORY. This has to come before
> +# loading lib.sh, though, because it may clobber some CI lib
> +# variables like our custom GIT_TEST_OPTS.
> +. "$1"/GIT-BUILD-OPTIONS
> +. ${0%/*}/lib.sh
> +
> +group "Run tests" \
> +	meson test -C "$1" --no-rebuild --print-errorlogs \
> +		--test-args=3D"$GIT_TEST_OPTS" --slice "$((1+$2))/$3" ||
> +handle_failed_tests
> --=20
> 2.52.0.278.gadc6434dc3
>=20
>=20
