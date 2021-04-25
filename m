Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4066CC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EE76135B
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 14:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhDZOKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:10:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:42625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhDZOKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 10:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619446124;
        bh=nxYxJ5DEByeYNh37FUzN664A0xrO0hzCmIXBSuPTmJU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hehBU0TJmU70KH73kkGk7IOiINTRLOglI7TnJx7lG6TS+1z3SORHqYdBbBC1g/8o8
         4GmR07pnqEUZ2TkH/qGEIul36/3Q3gMQ55lzthV4xDRJE06HDvCMz/pdOWvLdp2P1v
         9WDKTBq/YcYwVTTz3z20ezGA0xpSLgyqFyTah+T8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.111.181] ([89.1.213.207]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1lp6Op39Xr-00HQX7; Mon, 26
 Apr 2021 16:08:44 +0200
Date:   Sun, 25 Apr 2021 04:22:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Adam Dinwoodie <adam@dinwoodie.org>
cc:     git@vger.kernel.org, RyotaK <security@ryotak.me>
Subject: Re: [RFC PATCH] cygwin: disallow backslashes in file names
In-Reply-To: <20210424212117.6165-1-adam@dinwoodie.org>
Message-ID: <nycvar.QRO.7.76.6.2104250413320.54@tvgsbejvaqbjf.bet>
References: <20210424212117.6165-1-adam@dinwoodie.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iki1BerOxffTFrceLe7Kv/UpwdkwO94aESjD+SpS1iVOnTnAMi7
 1wlV68yFnlDRXkb+9zC6ZFRJdXP5qNwvcWqt0uUlRpwTHvGYai6L6L001/fzirEKkNyQPDv
 u29gGBeE/275UfE+mPykaXTcAneN+Kbxmi+4t/XWhbvZ37NxHyLeUrn9HG7Q9MisUaCYfJo
 VpkwfzjhHP/ce0oXHg5Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bCA7+IUfK4U=:BoL/5vkYOiutw1qivSpTyz
 0BiQePR5PTK6vzLk7WZUBikW6uUpUYua+1N1BGdYBxkI+6paIi67NTqj7s1DC1VTB7wxqrqrj
 EOq7B9imgJ1vXdSFhxX1ljoSnCoQk2HScA1gyUVOBSsYFopaGLVSYeg+Huo1VjoEmZXTbHWQm
 8lXImAS7+4wdWAT80Aap7drjWS1DgDcoqTSHWB1Jl3WtgqrhMPyJh1QFVTJjWkDRmC8OdjRX+
 F/EuD7TUXUaxcjZsUfArYd0lj0D7XMWgwRSRMrhmyiaVDv7c2g2pU1l+lc+UYfx2MV9Kp5jMq
 ATIpwkF0FdNbjoMaYzpKDal/39xtc/C4JhE01csIdWPidy0AJHg0C9w5f9kP9vplru09D8h7e
 A4MsdInLLPk7dmYkl911xxer9rVbh4NyXlid5ZpeWYEOMObWItYX7RWSsw/ffzpgOr47M4YVM
 LYkRIGXN5CSgtEncd7FeZgly43O0iZcIud1jHgM3UnKUL0riVEOnQ1mTv632qpsP5bsoco1lE
 uNLyMN8VID2a7oWvj8iGHKCx73yDjRYSZOGL1H6qGcs2Jz1Ndt1JDXHt+jF35Aerm9MixsTQm
 DfYVl+fTjqUqLpSfqkgLAztAFMDfEQP/wplgHaiop31GnBmja7DXyIzHtTVvgkdTbZGbkxigM
 4kCxOzGgU9ZE5v6AgVXqmHt7xc1PRHqrpReScYJg6ZPIPSJFWCzkiq+8zKq3NXr2XnWMs4MnS
 Nsby1ir3X5wY6M80GYEJj9d4N2D304Nt4zDWXWKb/POKfITsTE3R6SFmmxnRX2ByjvgMOUW+F
 FY46B5I1hW/8AWxgfic9RlZEYWme3iF6nkHRpDrTUyCvUpqnT4jxxx6E1IQkzQa14XsT7V+q1
 I95Q9VishLNvPkzAKicB1nF2/t8pJ2Seh+mL6ZrlE7ZieKkvJ7y6SO6Bra4mSeg34gWp1QMVW
 ZbqylCdX8ZMg7w6zrj7YF7nprqXODRUulTtvmp+JB9Ai2Q3uql9C3/sFyBYWVuAo3g+WhnAsT
 Zp7y3L2TADpqJFkYbpHciwockjGrLRO1K/ush9j+gFf68T8m+eXXHFUl7JIJOut8fX3tHByuA
 yqXi9cMCRgyq4YMiGTkpBsy+GBaqD3J2xiCXEAzScF1R4GQUoCxMgk28PNc8A7n7YIkZNgQHY
 NMhUHj+z2gZWoc/B+9238mJshNzRIedktBLAuCU5yJhU0ti4LQ5bqULZLCaJwDCKUAZUPxZaQ
 TasQEi71fEBaowJP8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On Sat, 24 Apr 2021, Adam Dinwoodie wrote:

> The backslash character is not a valid part of a file name on Windows,
> so it should not be possible to write files that were unpacked from tree
> objects where the stored filename contains a backslash character, as it
> will be interpreted as a directory separator.
>
> This caused CVE-2019-1354 in mingw, which was fixed by e1d911dd4c
> ("mingw: disallow backslash characters in tree objects' file names",
> 2019-09-12), however the vulnerability also exists in Cygwin, as while
> Cygwin mostly provides a POSIX-like path system, it will also interpret
> a backslash as a directory separator in the name of compatibility.
>
> To avoid the vulnerability, extend the fix for mingw to also apply to
> Cygwin.
>
> Reported-by: RyotaK <security@ryotak.me>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>
> Notes:
>     The patch to read-cache.c is the one I've applied downstream as the =
Cygwin Git
>     maintainer to resolve this vulnerability, and I've manually tested t=
hat it
>     resolves the vulnerability, so that's the change I'd recommend anyon=
e who needs
>     to build Git on Cygwin themselves take until there's something offic=
ially in
>     the Git source code.
>
>     I'm much less convinced by my approach for the test script.  I defin=
itely think
>     it's worth having a test here, but the test as written still fails, =
as the test
>     seems to be looking for the error message "directory not empty", but=
 running
>     the test on Cygwin produces the error "cannot create submodule direc=
tory d\a".
>     I'm not sure why that difference exists, and whether the correct app=
roach would
>     be to (a) ensure the error messages are consistent across platforms =
or (b) to
>     change the test to expect the appropriate error on the appropriate p=
latform.

Wasn't there something in Cygwin that _allowed_ backslashes as file name
characters? I vaguely remember that the ASCII characters forbidden by
Windows were mapped into some "private page".

Maybe that is responsible for the difference here?

>     I'm also not convinced by my approach of adding a "WINDOWS" prerequi=
site to
>     test-lib.sh. I went with this as I couldn't immediately see a way to=
 pass
>     prerequisites on an "any" rather than "all" basis to test_expect_suc=
cess, and
>     this would allow us to simplify all the tests that currently have
>     "!MINGW,!CYGWIN" as prerequisites, but it still feels a bit clunky t=
o me.

Right, the only way I could think of it would be

	test_lazy_prereq 'test_have_prereq MINGW || test_have_prereq CYGWIN'

Your approach looks fine to me, though.

Ciao,
Dscho

>
>  read-cache.c               | 2 +-
>  t/t7415-submodule-names.sh | 2 +-
>  t/test-lib.sh              | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 5a907af2fb..b6c13bc04e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -985,7 +985,7 @@ int verify_path(const char *path, unsigned mode)
>  				}
>  			}
>  			if (protect_ntfs) {
> -#ifdef GIT_WINDOWS_NATIVE
> +#if defined GIT_WINDOWS_NATIVE || defined __CYGWIN__
>  				if (c =3D=3D '\\')
>  					return 0;
>  #endif
> diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
> index f70368bc2e..6505bc2085 100755
> --- a/t/t7415-submodule-names.sh
> +++ b/t/t7415-submodule-names.sh
> @@ -191,7 +191,7 @@ test_expect_success 'fsck detects corrupt .gitmodule=
s' '
>  	)
>  '
>
> -test_expect_success MINGW 'prevent git~1 squatting on Windows' '
> +test_expect_success WINDOWS 'prevent git~1 squatting on Windows' '
>  	git init squatting &&
>  	(
>  		cd squatting &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 3dec266221..adaa2db601 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1459,14 +1459,16 @@ case $uname_s in
>  	test_set_prereq NATIVE_CRLF
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
> +	test_set_prereq WINDOWS
>  	GIT_TEST_CMP=3Dmingw_test_cmp
>  	;;
>  *CYGWIN*)
>  	test_set_prereq POSIXPERM
>  	test_set_prereq EXECKEEPSPID
>  	test_set_prereq CYGWIN
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
> +	test_set_prereq WINDOWS
>  	;;
>  *)
>  	test_set_prereq POSIXPERM
> --
> 2.31.1
>
>
