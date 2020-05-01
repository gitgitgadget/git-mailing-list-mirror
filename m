Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812E5C35280
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58811216FD
	for <git@archiver.kernel.org>; Fri,  1 May 2020 20:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SwNrJuix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgEAU46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 16:56:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:50475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgEAU45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 16:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588366606;
        bh=ZXoMwW0JTU4N8ZzfwAn3+u12W4cSw8eUafiV2zIgsRY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SwNrJuixIP4OGO5yyYg/hnh3UknqRd5YJSwo5g1DX7s8t8g4fBvQ4aSEDqM1PRzIV
         HDdmLmyjBcp8Gjh9LS9NvFp2QjfkYyQXI+7ysfQV/0b2jvRIiJE/koofyHO32gw5I6
         F4tvW3RmKWHAnAr5tx3Vepir+/qMIBJw+4mLviKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.255]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N0oBr-1jGXk31a1F-00wkcx; Fri, 01 May 2020 22:56:46 +0200
Date:   Fri, 1 May 2020 22:56:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Son Luong Ngoc <sluongng@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0000: disable GIT_TEST_FAIL_PREREQS in sub-tests
In-Reply-To: <20200428081421.GA2381876@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2005012256140.18039@tvgsbejvaqbjf.bet>
References: <CAL3xRKc6Q1m=9XJYcafhczCU+ONYjapkUgBi0nKMFoMr+bgjYg@mail.gmail.com> <20200428081421.GA2381876@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pOox1mU2FWMouda+KKeAG9H11kJvgQ8lSGV9b03GEkhgKt7ne1y
 TML+Tv+lKu8vhLzKNAS4D/4CKTmbAah39SJ2ieMwNWlJqqKRqMGpeY57svO8vCIurDPDCYo
 7f6Bwqjhz+6ctmfHkRws5zFS4QB/D/eEIgtl5veDdWvS2mO77JdDJHPHD1E9cVLcnENI07k
 5aXLjWRAiR2RfkwPskL5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BniMd1v/wws=:DherZy8oPxbcLZBSvzpIxM
 0xV1nphOUclmQGeJt9ePA08MB8UKZno14b1gxdazzvaQLDVrLjl2C/miW2Y7mAIrRZdT7U+rg
 iPX9hDM/OeAX9NcHzl8wDvHggNsrwG3ZCtdBi2qFhqoZXdLNgpeVS+VRN4ienQlVQ/wGaCw/g
 boU4m3rE0QxhsCjbOEqT9AMLs8T26AJxqlqPwr+zxOOpdUU7FFAC4Np+/iApzfem4IBugW1Gi
 CTnU4Bq2Pt9TulMZWKbVFNHTpcmV0RHRF/ER0vN28FZM7GuZZgeH1UO6qq2K5mCcGSGIr8Xf0
 5Ca9DIW2jg9vccyI7fb3NSyMF9bfxPpYdyofOBOu/wIAi+hCes7EYesDOu0hTsHAwYdspYI9+
 Ze1xiYSPKCwxWMBw3m7WJJ07pee61iQQGadPBpkwT4abZZg5ksvu6YHKMk/2wMtXCO/HrRVsR
 x7mcrBeBe2I+amo5947j+N9hYmYMRyoDXx9RARyq9llUvj1U1hZjZu6FLRnwZW/ZTXS2A7Quu
 6iWIrmwrNWpJqe88l7oElHEKQK6s4e/eqvlRV6phWaBiI/U7vkthzuTBtmVAnGIuQkmD4i450
 3WMbUScwMwRbpY19Mz2mVYZybJU5J44Q+8DhFFviV1oEfHThnYZWRqMRcBKFW3HO/bLCrNBlb
 QMF6p6vxXqW5TcfT2rFK+6U/KAlk52tRlI0Ip4Szy0su/bXm1ERrrnOln2kwZp7MJAwV/PaCr
 YAgmYD2qnjK7i/gKeCZdNcpNgMj2Zt0dL7wGfW1uWR1wB2uwQhzxVkVZ3RJ321w/DHQ4xuCU4
 vUQth5sGlOvJouh2JgQrzU2yl4puQnJiE8njHVKl5AaJfOF2mg61YVNATCPh9ESXod4K8IcND
 WGw1ERthJ2L+X/55NmH5MmYZEYtqFWnqf0oQDRQRwZifidUzM9wrk1bVfZJtCSfeowunT4Ry0
 4rmcgBhZldnd/BZ4VSPz8lFe+1ZnCu/egJ18owafs0semgvWXgMtqFanCJGXPEYZ2bU0Y6tQa
 2xT8yZ6/Hx567GGiNWw1SUDq6iziTRItzRuanU7iXwDqWvl0Itt6zcMAq+RybLVT/GelV5SYt
 A7euv4vPM7+29iwSAIebRWm3gNjlww/z3yz+jZL2A2cVsaWtbYMamBZLET311+AWnzA0go3uG
 JwAib2trmrZ79qk2UsaZHdqVOUv5zYvv/wh0FlBcNuRuOrAY/ygnJZsLCJYXPq2m2yfqigXom
 CpPdSVAT87o62YMg0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 28 Apr 2020, Jeff King wrote:

> On Tue, Apr 28, 2020 at 08:52:34AM +0200, Son Luong Ngoc wrote:
>
> > Running t0000 with GIT_TEST_FAIL_PREREQS=3Dtrue is failing.
> >
> > > GIT_TEST_FAIL_PREREQS=3Dtrue ./t0000-basic.sh
> > t/./t0000-basic.sh:836: error: not ok 45 - lazy prereqs do not turn of=
f tracing
> > #
> > #               run_sub_test_lib_test lazy-prereq-and-tracing
> >  'lazy prereqs and -x' -v -x <<-\EOF &&
> > #               test_lazy_prereq LAZY true
> > #
> > #               test_expect_success lazy 'test_have_prereq LAZY && ech=
o trace'
> > #
> > #               test_done
> > #               EOF
> > #
> > #               grep 'echo trace' lazy-prereq-and-tracing/err
>
> I think the patch below is the right fix.
>
> -- >8 --
> Subject: [PATCH] t0000: disable GIT_TEST_FAIL_PREREQS in sub-tests
>
> The test added by 477dcaddb6 (tests: do not let lazy prereqs inside
> `test_expect_*` turn off tracing, 2020-03-26) runs a sub-test script
> that traces a test with a lazy prereq, like:
>
>   test_have_prereq LAZY && echo trace
>
> That won't work if GIT_TEST_FAIL_PREREQS is set in the environment,
> because our have_prereq will report failure, and we won't run the echo
> at all.
>
> We could work around this by avoiding the &&-chain, but we can
> fix this and any future tests at once by unsetting that variable for our
> sub-tests. These are meant to be controlled environments where we test
> the test-suite itself; the outer test snippet should be in charge of the
> sub-test environment, not whatever mode the user happens to be running
> in.

Thanks for fixing a bug I introduced! The fix looks good to me.

Thank you,
Dscho

>
> Reported-by: Son Luong Ngoc <sluongng@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t0000-basic.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index b859721620..f58f3deaa8 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -98,6 +98,7 @@ _run_sub_test_lib_test_common () {
>  		export TEST_DIRECTORY &&
>  		TEST_OUTPUT_DIRECTORY=3D$(pwd) &&
>  		export TEST_OUTPUT_DIRECTORY &&
> +		sane_unset GIT_TEST_FAIL_PREREQS &&
>  		if test -z "$neg"
>  		then
>  			./"$name.sh" "$@" >out 2>err
> --
> 2.26.2.827.g3c1233342b
>
>
