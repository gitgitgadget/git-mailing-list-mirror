Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A77AC2D0DA
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F4F2073B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="U2NjoK2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLYL4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:56:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:50881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfLYL4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577274989;
        bh=vVOzrvlPzmbe8GHUjgscfOOkTOHJhSXWVm31zOzcTDk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U2NjoK2AKaynVNk0MOkvLIojDC/bTVB5rAAHLYTIoOLpGX80KlcXl4oZTpAU8nYTk
         7ENSzEoYCz/a4Z+7xxaAWHaw34y0Tu0M1pJreV5yPr9JibpnndpdEuakz2uaBrEdKu
         70AUVMPQXSoWUpNNT3wZvQGWsrEOsK8BWyl96LWM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1jYaVZ3C2b-00p2oP; Wed, 25
 Dec 2019 12:56:29 +0100
Date:   Wed, 25 Dec 2019 12:56:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] ci: include the built-in `git add -i` in the
 `linux-gcc` job
In-Reply-To: <20191221225354.GB32750@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1912251255160.46@tvgsbejvaqbjf.bet>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com> <9719604a1fb6ec4cf1b1297875cae86c076c9cdd.1576968120.git.gitgitgadget@gmail.com> <20191221225354.GB32750@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-199454658-1577274989=:46"
X-Provags-ID: V03:K1:gCDar50lRVQwvsvYzyblAEhszXv7OIzDX4tsy0NneMPezGU7Yrc
 dmmiXqyH5MyIo8Pl4imisFVDw8YDEqHKFm0yWmje7M2pDCAOwxcEHdGD7/AMqgWOhoXsVG0
 B3sf/92ie9xfO2AojXLknYotadAIPuMZ9zWS0sN1lcPjfnFP7xuG0lC0axvfe2yp6TC8DJm
 86NtkVzF4y7AVO/KCCTpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lrXXKfxzKfI=:h1d4Ar0QMLSNy0aN9VG31E
 Q7j918eZMj34dc1vhZGBt78jcyQbn+0q5BRKlMWFFKB7yXjuE0Mnyjr4Pqm/9x6+/wWVqoz9D
 hbS5A2ph0f9occaALl1OPe/vfNSFYLkJCzejH8EYSahACMqvNSZWHONXpdg8JVkKzIOGGKhcP
 rJHTeuD8jNmOZBSRPj0lfy3N8iADK+I3SWIHjWmAEs1Nn1ZA8ymp2YK4n7VMpVn5kIWFRVMqV
 cq/87tro5cXPAfpfYXHimjY1N5RNyWPmPXOJnxKS+xV0uaPwNmihFNLB9ZLWqLQqfoohGWnP7
 sCgOQ+meA7+btJ2cI0EKtcVlh+2Bvdopx7DeK19mQrDewr+MsFdA/+FShm4nzx/kAhKmKCECR
 Quhfz2NQ9aR4U5EvD6t46xBcGTHys50K7jlDGgNmo5qZUTxJzvKRZst5lJZ1751558P6OYhDu
 z/XXB76RwdTTpV9eaZKujF9acFe0UWDQF1SrLddZNYOepUTQlDqCH+uBt3NmfwTVtsWCSUs3r
 WKl6yYo/3b90r7sUCPqe/bZObTxOFwf6YloMOp5IuH/QmJMDch5KW5gD+z+tauSyI4XKM3ble
 BM9P6Cc6hGrMSmJExRaEqBzE2IjKfFaxZaoL2ZO2aszfu+SEp/jNZCPHmPDjsX5JgA0m21Hax
 ClYTJuA0J8vY/7wxyI5DiyFMv6DvXHKKljuOQ4JmFrkn0Ba9dB24Osx+BOLWsNOOdBHP82Sw8
 jGat0SvMt7Pd5aP42fMBCgg/YHxQvlysqjOkp3Dm1YtmOoqS9zGJ+srFPwJMfLTyid3m1WPYh
 ihiT6blfl77mw3sc8Vdla4e+Ie5u7ImCAg2637c2E2oA4rAAL3VsGxpb3GU1PX0rE6ylVuCaw
 K4A2D0J+K7hbKZWEjwlNOAK9rThoibwqJ/XoBJ+QR6zZc9zbJ67rK7Re1plwtbxu4qh0JsO7W
 J3e0PdqbVrp7W/ug57dwPLHrgWaiXihMKKPBMv1Yvr8iY8aN1hXR/S1wER2ULKLQ4+ny7YTOC
 e9J1Qll/oscSvCk3gEzJXDbJhX800uunQqHRm4GV2XIeW81gPgz711D3DMftWeL9NaJNd8rhE
 3hl747wiqv+3tudxi6TF+JGyp5IY+GlPljT+OnELEOC0ovmvPiQnrqRZwLitJvAs5PvpCztD9
 LMzOs+CN2EJ3wX1aiEISw5s9jpFw8Cg5RZ2RPWKcGWjeXktL15rfLugKMTgeZKVrkFBZBK3g6
 0lAAjbs3HTNmN96KJ4DUnMw46sRBIJRB5ddy2kbNINrKXOzVC3e8G6IrDLMI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-199454658-1577274989=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Sat, 21 Dec 2019, SZEDER G=C3=A1bor wrote:

> On Sat, Dec 21, 2019 at 10:42:00PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This job runs the test suite twice, once in regular mode, and once wit=
h
> > a whole slew of `GIT_TEST_*` variables set.
> >
> > Now that the built-in version of `git add --interactive` is
> > feature-complete, let's also throw `GIT_TEST_MULTI_PACK_INDEX` into th=
at
>
> GIT_TEST_MULTI_PACK_INDEX? ;)

Whoops. Copy/paste fail.

Fixed in v2,
Dscho

>
> > fray.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/run-build-and-tests.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index ff0ef7f08e..4df54c4efe 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -20,6 +20,7 @@ linux-gcc)
> >  	export GIT_TEST_OE_DELTA_SIZE=3D5
> >  	export GIT_TEST_COMMIT_GRAPH=3D1
> >  	export GIT_TEST_MULTI_PACK_INDEX=3D1
> > +	export GIT_TEST_ADD_I_USE_BUILTIN=3D1
> >  	make test
> >  	;;
> >  linux-gcc-4.8)
> > --
> > gitgitgadget
>
>

--8323328-199454658-1577274989=:46--
