Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C491F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 09:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfJBJRX (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 05:17:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:60881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJBJRX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 05:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570007838;
        bh=s9HcLQAsHx966XMNkCOAWM05C1ox9ScOWQVeRGzTcIk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b7+YDt0RJuzkBcDm5GyWx4TG3GwYUNc/adOnSUrkNarqcNSr1E65Mu9rpcYkvGo8F
         jNW5r/FSMqtA6Eha7tlClxuoJ/2VDR0BqF+JL4QD8NtqVJzSj7dRoFNmzjRlpAOWdi
         hgFvysC+htBJwKaR5uyLc3ZsCe1nzVlb0SHtGtAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfJd-1hzyoU3mXf-00v4hP; Wed, 02
 Oct 2019 11:17:18 +0200
Date:   Wed, 2 Oct 2019 11:17:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] ci: run `hdr-check` as part of the `Static Analysis`
 job
In-Reply-To: <xmqq7e5nfzgx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910021116400.46@tvgsbejvaqbjf.bet>
References: <pull.368.git.gitgitgadget@gmail.com> <4b3b58ca6ddff476acff6735129049588c0a1f13.1569928584.git.gitgitgadget@gmail.com> <xmqq7e5nfzgx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2NXv0KW5fHMxfZHuSCyCEMgoybRyONfqZjr0j2AWEK4fSrOso/h
 XDkbSnBwL4Vb3JfPkbcyIC0qtDeMVwgSk+TDrPJgk9yswbacitImgUj8z6GRSonE+ewrqNF
 6urUicZHg9tRf9G5GpUylnuiRGImOSHlyr1eiN3H5QP2FSPKM2g+zjJEmS++pJ6wRGinTMT
 Ge1i7qRZwexwDa5gFgC8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vHRy5v0o+pk=:2zVLToIWHXHIVjmKrjU9/9
 RodZoRu2d6haZGqN7oMJvHcw2chM73bMllPewhDFCYPzKuXBpMoxEB6VfHV/TzVKGI+ClxCPy
 xlQWTfgkEmHapaoFtQwE11sj146LlweNco+1oyhooQtNdvorJgdlX0akq3aX0SN/tiAnGB4h6
 8G1kbToZQZtjWjzn7Q3Zf/BGRxSsmkxN/v+Ck+d4XoPhMx4o0akRZsnrC3hFeeIkhummVmJr0
 U21+T/Rg+zvKwzfvSll1UUbC7+by3lRzynlqq10taFRoeKRBLZmxxGX15nF4biBpAhfntv3DX
 hoyn0DdiLMvSkfuVQ2j1tmISPL1ptbcLiuURZIMIC+pn4XKXcHct0Y9R/rEV9VFt0tdgM4DaB
 LG/gs1+eW/YbSdQEeawWN6DXtWyyWxX8txZKIDRJJh81ch3gSOJNkYdTuOoABCQkX0DBGu+Ca
 TuGHhgNFOnbT9kWaJBaW+7TjS6fShzpsyixiSCLPXiNa4waAShLaYHxnbU9ny0V5sTpplY0t+
 Zl/kPFqlU4MS/1Vx+BaWwGsPeS23NSuh6fAzopXpw+k72LW7Keu9iQqRscgSe00ZCsfpn835Z
 OJRJ06HTgafuAB0ZdMPORCtaMRQ9bTvhT4BrOXrD+CsNbj/UEuvcLYmpAz4PL+8vmozL6hZ3L
 Mp1l5dg9oWogWzN80yYAG6R22bAqU/QyApNYt5S8MEI+rh0Gj3ITEZMRVLMxYXftq18OxrOwH
 hwjfRu0tI5+ueZjo0jON6/U9VYuJ8HI5lVDihq4/4L56hjAiBsLgH9UqsfuXnpRf7IeChggsr
 G4LOryVoh5lplhrZG0cSwDx/zDQXzf4jcJ96fNnRJ68BRGFKTdYuZYZUo6xaW8ItzEa43zIlQ
 CC9GgB7Fh+9v54lyorpopHtF3vHPqohbWWfM/hWhfqfAvy7XBElQs8QNzzzYFWhPYUB48TUtx
 vexRS3yU57Ari5oDq59Yy6lUn45OqHMW2kAFKiyIIBth0uHo4MC7NTtovnH4ylXWChcC0tO7s
 gOQERUosFat+Rbtx1jbOrAli+DEr9T24krQPHA8xAWyCSCTPlLyBRCRLoLYTzbnVT16tIcM8v
 oGotQn0yz99cGt1r6gvU+8UFvJinZEpyuB8JqGhi5bw+c/NB2L/BtjJWBdMxgh78YBKIyxx48
 JW2zpINCldjIcaefDamv51vzOjTsd6Dr38z4F/IWVsggTI+AQbrTjLY+wqboxHik9Lsw+uuVP
 3v+4W8C2/2u8DeqvySGV5qveWJjmWXfhU+PCdQMEovCf6jzDTD/cW7ETZths=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 2 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > -       sudo apt-get install -y coccinelle &&
> > +       sudo apt-get install -y coccinelle  coccinelle libcurl4-openss=
l-dev libssl-dev libexpat-dev gettext &&
>
> I think "s/coccinelle  //" is necessary here (assuming that "apt-get ins=
tall"
> is the same Debian thing I know about).
>
> Will do so locally, so no need to resend, but "Yeah, that was a
> typo" or "no stupid, what I wrote is right" would be a nice
> response to see, especially if I have to undo the local fix.

Yes, this was a copy-edit fail on my part.

Thanks,
Dscho

>
> Thanks.
>
>
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 8cc72503cb..8ce9ce276e 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -49,7 +49,8 @@ osx-clang|osx-gcc)
> >  	;;
> >  StaticAnalysis)
> >  	sudo apt-get -q update
> > -	sudo apt-get -q -y install coccinelle
> > +	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-de=
v \
> > +		libexpat-dev gettext
> >  	;;
> >  Documentation)
> >  	sudo apt-get -q update
> > diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> > index a19aa7ebbc..65bcebda41 100755
> > --- a/ci/run-static-analysis.sh
> > +++ b/ci/run-static-analysis.sh
> > @@ -26,4 +26,7 @@ then
> >  	exit 1
> >  fi
> >
> > +make hdr-check ||
> > +exit 1
> > +
> >  save_good_tree
>
