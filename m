Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEECC433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 13:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB2861A01
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 13:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhCXNtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:49:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:35837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235684AbhCXNtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 09:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616593752;
        bh=+XrJ4e1BN5SS8SxFDwTiQA7hFp4xwYldVw5Mh7Fc//w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kmBQJOzS/Qzj9omzRjQfWkudgzeecA6qksHCwQxFFBaW5XpuDVcY7CX7502uB3Xcl
         ODOKknCTrujPKqJMhMJq2Buj4yCAyA523OGIcn592WJstRZM35xqn4pkwpQSieqQkx
         qAaj+k+/uOkNlvaNtAXVRoaM7gkWUb/p1eqLDSXo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.9.78] ([213.196.212.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1lhpkq0q84-00s3I8; Wed, 24
 Mar 2021 14:49:12 +0100
Date:   Wed, 24 Mar 2021 13:01:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 16/21] mingw: try to work around issues with the test
 cleanup
In-Reply-To: <87a6qxzocs.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103241257580.50@tvgsbejvaqbjf.bet>
References: <pull.31.v5.git.gitgitgadget@gmail.com> <pull.31.v6.git.gitgitgadget@gmail.com> <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com> <87zgzbgp1i.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2103191515430.57@tvgsbejvaqbjf.bet>
 <87a6qxzocs.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1544568225-1616587311=:50"
X-Provags-ID: V03:K1:Oubbp74T7wZUZt8Qj6DpjBvYiskyeo2cHe/dIe9WTB98/ejNC97
 zxoWAqZIejz0N26N0uQ8oLRv5Jru2YC4pYnL5MeHp6D0N2jiUI3HPJsJjPK7jQ+rtFYKXUA
 kPMtqeH+fmIqgu578thOjAUy2KgvMQSbkwQxT+oRbA/ufiLlBypWyKJqE7PzSEYKkYZJVRo
 79LjovV87VhvPBtlGgnww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:epeyTpo+k2I=:zs1IMDU+rFIQC8lygh0axA
 dCJULiHOCeErq2QWnq3G711P4UcXqvkgvCgIhOabnykcIM5BmFsq4wEbv9AshORiU0/en6N7k
 /q6+bsx2m6gJwxnfRxu0NzQqhKkDXRgFu4GZyvXD24dl6K3aQMNriOschmqpfeqefvcxW9KyF
 m3yt1pER1ZQclAFmnmntb3YC1Wh1zCtqqj2EQTkIWt59iV5Cf02BF3ScjzHPyU5zzaRwAl5M7
 JPOr7eBold9YfdNsOuKoj4xo1V4Y5RPOMt5RATweTN8SWGAtPLrK9dLztyNbTTq8tIaIk7sjb
 66n5eRPoWbIeCCbkxA6kgyfimlEuoyxR+rc5UjP/y+3MUGB96w7qnpznNYY+lQGselo0ZD5JC
 ChggISvnX9L5nh5Sn4Ifm+UhegpRjKm/rw0y9pdm5GHcugGaG29kBDvpmQJO5gfpma/1DxEQO
 UtHhsguZQRaK9uGYkiXDmmGVp8soLbAZjkgBClVYcsfr8F8bk7kw7bMyzcl24VAnyEcg+y+z0
 tsdkXANzON6LVIPZ52ld7xeWdeJzUbfHSp3ue3mRpEo7jLFLaBVeyt92iZLjgqd1rTuVODLCL
 2ibbNCiN6NnQVdumcab4Y5Z1x6P3g3AbZ1+3r+OzhK1ryHEDnMJa2PSg1eZWAua20lUOsP1CI
 Dqkqop5sLrRgr6siVeAFa5QmDAraYPSDdfwgqqF2x6r6R5661J7yyHwAokukiTRWvgkk8Qwub
 pPXsQF3q4ziSm2j+o4P6RxthBVXcbtIKpcyHBm3GeQYd5c5beco+YX/l7JIrx9PHp7NgRVcIb
 zwQm+RRYZFwBYNjcnfkd5J7w3LTy8Dz/ezkLrLThPjbdenaxDmXeffn+ab6HATiMp3uP7LH15
 8DSqgnRqeH4g+g0zqgvoCfaI5aAbKQujL6S6E/OhchW30qjGrQvohw/UX0I3ldVh2f1r0LITc
 K+sXV2GQDPDegGVXyjWYJVyinXbRH96el2/w3Z+utLSekdLXYJc7m2vAKPMwy5KjEvzflxbia
 3SEGjsw5Xgi8tJy+lk5NlgFC/Fvb9NHG/ozO6rf/x7GUmXiUqDycabDrOQAUbiYJtW7C+fcic
 CHmg+shUU7/m6zU+hO1/HEwEnTGj6sMWM6bkAGJY9DyD5VhasDoz9s9UMfaMflWp3e+SIrb81
 ZqrpffM70wcNXe1WOKR9NTc4W2OhETAU48c6SFcv5qY88Qh1znYbTEiR66hOlLHPar72Dcwnt
 RG+wl3WHXqMtZMr7a
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1544568225-1616587311=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Sat, 20 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Mar 19 2021, Johannes Schindelin wrote:
>
> >> On Tue, Jan 29 2019, Johannes Schindelin via GitGitGadget wrote:
> >>
> >> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> >
> >> > It seems that every once in a while in the Git for Windows SDK, the=
re
> >> > are some transient file locking issues preventing the test clean up=
 to
> >> > delete the trash directory. Let's be gentle and try again five seco=
nds
> >> > later, and only error out if it still fails the second time.
> >> >
> >> > This change helps Windows, and does not hurt any other platform
> >> > (normally, it is highly unlikely that said deletion fails, and if i=
t
> >> > does, normally it will fail again even 5 seconds later).
> >> >
> >> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> > ---
> >> >  t/test-lib.sh | 6 +++++-
> >> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> > index f31a1c8f79..9c0ca5effb 100644
> >> > --- a/t/test-lib.sh
> >> > +++ b/t/test-lib.sh
> >> > @@ -1104,7 +1104,11 @@ test_done () {
> >> >  			error "Tests passed but trash directory already removed before =
test cleanup; aborting"
> >> >
> >> >  			cd "$TRASH_DIRECTORY/.." &&
> >> > -			rm -fr "$TRASH_DIRECTORY" ||
> >> > +			rm -fr "$TRASH_DIRECTORY" || {
> >> > +				# try again in a bit
> >> > +				sleep 5;
> >> > +				rm -fr "$TRASH_DIRECTORY"
> >> > +			} ||
> >> >  			error "Tests passed but test cleanup failed; aborting"
> >> >  		fi
> >> >  		test_at_end_hook_
> >>
> >> I saw this sleep while reading some test-lib.sh code, doesn't this br=
eak
> >> df4c0d1a79 (test-lib: abort when can't remove trash directory,
> >> 2017-04-20) for non-Windows platforms?
> >
> > It does not really break it, it just delays the inevitable failure.

I still think this is the best answer to this (implicit) question:

> In any case, your patch clearly undoes whatever canary for gc issues
> df4c0d1a792 was trying to put into the test-lib, but didn't say so in
> its commit message.

I was not _really_ paying attention to that commit when I implemented the
work-around you mentioned above. At the same time I think it does _not_
undo the canary. If the trash directory cannot be removed via `rm -fr`,
and if that is an indicator for something fishy going on, chances are that
the second `rm -fr` a couple seconds later will _also_ fail, and we still
get that error message.

The only reason why the second `rm` should succeed, at least that I can
think of, is that something on Windows blocked those files from being
deleted, and it is no longer blocking after a couple seconds, and that
usually means that an anti-malware scanned those files.

Ciao,
Dscho

--8323328-1544568225-1616587311=:50--
