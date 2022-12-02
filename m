Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F105DC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 06:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiLBGEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 01:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLBGEU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 01:04:20 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC8DC4F3
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 22:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669961057; bh=MBYnr5V8c9UUJQ6QymWb0xGh4NNheVoqPnOB1vgGQzQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=qt++pIznud49xeJajw1sV3VbYmljSdEYM+8lzh69GwJB8XOVuu8E2nKt0AoGjt3Nx
         P5W45siXYBKkQUWJ0cFuGlf55kcbnJSWigstpW5dIR6tGs6mhm7NOL06jtSzRh9Xy5
         R0+r9ARq5Z9O7Ij/Xqi51aJgveUvAK81MpiDyMAG/F7CTCEcspIHJEYfd8prHnB2mx
         pyV5Bjlp6I4TykV54p2Z9JQ86YDTCFkUUsDFcpuMwcIokeu4x7E9NaVa/cTpLAnLgn
         mGZ2ywgLjgkENAb8WuFkyOSLdbyG+PyjEFgCHXzLRaUbOiH04MPWE0L9WhRb+8iOL9
         qiHsLN26njulg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECCP-1pAdiB1jYz-00AEkZ; Fri, 02
 Dec 2022 06:59:06 +0100
Date:   Fri, 2 Dec 2022 06:59:05 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/8] auto-crlf tests: check "git checkout" exit code
Message-ID: <20221202055905.2rqp26xu4nuknlxw@tb-raspi4>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-2.8-345a667d5bb-20221202T000227Z-avarab@gmail.com>
 <02ead668-5b5d-877c-1e40-3656fd85945f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <02ead668-5b5d-877c-1e40-3656fd85945f@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:FrkZg7G9C9N+Ervs27oTjGWoOOCXoVFGyRgJemCU3+6+bXLl8dn
 CbwDPnFBqGGU4tEIN2w2h75quGfaC+b2WtNdDhQwanfLahG4j8OYCAJQULomKxjAdh8DuiJ
 g0VsMMFDoXFMHUtAaKAXCQA46C4h3+t7fFR+QjRB7boUSBjRUnOl+/BT5gcSQ8QO+e/0KxC
 qzOTW0pCuCFUow/P/783A==
UI-OutboundReport: notjunk:1;M01:P0:RQwt2d5QJxk=;j3FdlKkQSWpzjMm5trgKEDyTT9/
 52fWNzwaZ3s3LRSbzwodpwnp3MHBRhMb/IEzdd87+iv3y08igigFPicMpl4LSsGefV66zgYVV
 98ORe93WPt6agmdMeBX1X4EREDdV4lN79QPQPr+Ubigz17kQGLyI4dJH8H1iQWhBsHMBmnt58
 bp/j5glmWpkqcfIAc+ufLWu5szxu+LC802X4ougLqrfrCdXJMpmPaaKNLmPk4TlQ/XfJi2gSN
 ZM7V8U8oA4x6nBzydOp+nJS/f8raz7g/3NWfgeOcNg9NrAtLqJtrf0aBfuyhj62m4oz1C8yQs
 J+ALndPaIcIjOT5RCwQUXXVqFL/0p1G8KMomtde6JZqHciwP8mgtPuIcIO/8yBdIKRsEuRUoK
 So+HvVNS9BGuANy3Gwlw826d/dejXq2bMGeqc0KXE/axeSVuYAFFFJO76gvrQy9Z5OaswrFsH
 4/g+c8gxDqIji+9DMozKJYuuUN64sSVnU00IQOpY2cCy5cRB7XPegEuRj5omgMVxsB3XXCwj2
 qCigaDKNvqjwde6hSeCcGFxKEwPBtWU+MaG9VcxHSeALAqfZPAW5sTbQrTzOcJudQMU84De+7
 ZBcjE4lzMPppmjyfLAe/aDJcrPSXM+a9hJMnWsnjxnNECHaJPdeWdy+V8Ryg4rqo3gphqk95r
 mNQQNBGR0SNjwwfZh6k3QvLov870yAaGSbQ45Anz8+ZzymXiZ1dDDhOcFQdzji1dYolNnbD/9
 AorzYOKXy/aHWoaekhZV875CRVxxLUfDwHKhh1STdjHuKBaelV+qg3eYGgukku/rT3KAS1TYw
 gMSFUz3JPngDHX+VvKzsuTZUM6ICjd2Wrb+LWeqMR8eooPO+AHVrbJ88kwV2gsLsy87e6oiEt
 IPGaQRy1AP2xuomsXZO1YTdDRgMrwGTzOqCvhhIP1gHZCZQfZh0lHrkU0n4UK99X6OFdFMC1x
 CNlgixRxjhaBoot8vP4lQ7WTMv4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2022 at 02:02:55AM +0100, Ren=E9 Scharfe wrote:
> Am 02.12.2022 um 01:06 schrieb =C6var Arnfj=F6r=F0 Bjarmason:
> > Don't hide the exit code from the "git checkout" we run to checkout
> > our attributes file.
> >
> > This fixes cases where we'd have e.g. missed memory leaks under
> > SANITIZE=3Dleak, this code doesn't leak (the relevant "git checkout"
> > leak has been fixed), but in a past version of git we'd continue past
> > this failure under SANITIZE=3Dleak when these invocations had errored
> > out, even under "--immediate".
> >
> > Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> > ---
> >  t/t0027-auto-crlf.sh | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> > index a94ac1eae37..574344a99db 100755
> > --- a/t/t0027-auto-crlf.sh
> > +++ b/t/t0027-auto-crlf.sh
> > @@ -294,11 +294,17 @@ checkout_files () {
> >  	pfx=3Deol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
> >  	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
> >  	do
> > -		rm crlf_false_attr__$f.txt &&
> > -		if test -z "$ceol"; then
> > -			git checkout -- crlf_false_attr__$f.txt
> > +		if test -z "$ceol"
> > +		then
> > +			test_expect_success "setup $f checkout" '
> > +				rm crlf_false_attr__$f.txt &&
> > +				git checkout -- crlf_false_attr__$f.txt
> > +			'
> >  		else
> > -			git -c core.eol=3D$ceol checkout -- crlf_false_attr__$f.txt
> > +			test_expect_success "setup $f checkout with core.eol=3D$ceol" '
> > +				rm crlf_false_attr__$f.txt &&
> > +				git -c core.eol=3D$ceol checkout -- crlf_false_attr__$f.txt
> > +			'
>
> That adds five test_expect_success calls.  Wouldn't one suffice, for the
> whole for loop, and a "|| return 1"?
>
> One line above the context there's a "git config" call that should also
> be covered, right?
>
> Side note: The checkout commands only differ in their -c parameter.
> They could be unified like this, which might simplify handling their
> return code:
>
> 	git ${ceol:+-c core.eol=3D$ceol} checkout -- crlf_false_attr__$f.txt
>
> >  		fi
> >  	done
> >

That is a nice one. (I learned about the ${:+} yesterday).
Is it supported by all the shells/os combinations ?
If not, we can still extract the if:

        if test -z "$ceol"; then
          CEOL=3D"-c core.eol=3D$ceol"
        else
          CEOL=3D""
        fi
        git $CEOL checkout -- crlf_false_attr__$f.txt &&


The original reasoning (for not looking at the return code) was that
if the checkout fails, the test suite will fail further down anyway.
But checking for failures early is a good thing.
Thanks for cleaning up my mess.
