Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFBB020248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDLJGf (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:06:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:53621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfDLJGf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555059989;
        bh=Prefw5j0qj+iHbARSDNmKDeWRI5wnYmvE7VBMpPAr30=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RNh1B03xyV9gqeWIfKXzyh37lhQjy8ucyELP5U/YXjS1tLf+hfEUY+OK3O7Hm3fIc
         tCko9DgP7v2UdA5yFGbACSd5Lp6zG3iy9DaO6nZbS+ZlTaKmrYR65Mg5WaHSns+eMT
         BctATxH/tc/q2IZWwThUce+wnLnG6TUE6Umltmq8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTkNU-1hNdbA3tAm-00QR73; Fri, 12
 Apr 2019 11:06:29 +0200
Date:   Fri, 12 Apr 2019 11:06:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: allow for configuring option
 abbreviation
In-Reply-To: <xmqqtvfiuhn1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904121100030.41@tvgsbejvaqbjf.bet>
References: <pull.167.git.gitgitgadget@gmail.com> <20190325202329.26033-2-avarab@gmail.com> <CAPig+cR0Ldt3EpQ683ZFNFXggfsTrdeZ3R-V6pDBZNA1N3c+xg@mail.gmail.com> <xmqqtvfiuhn1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1200981579-1555059988=:41"
X-Provags-ID: V03:K1:OPhc/kZRSf61NrmH/ULlNIfbxyA3PIY3fp1nJL5CkocwAlDB7un
 r+ZFOu08DYCo4eizNjmkt0HwoVXZ1vhpxx1+vnZsm2g+L6NbggxR2E8TXsG/V0pdngvQsRp
 8gQxCU24Ae3NV09XHb2P/N9XA847ofBiPX2saIwre45JA4LlxIqmmjH2ClK2nHcDQ3smtKL
 QHmJ2QmYB9JNNLR1SiitA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M5mLBooGjVY=:3vacs9bGqfYDOVAKe0R1Y+
 pihdRnJFjXbVHCyh5VngLBtYGSmibZbOmFneUkYvcEeqaSa3J32iYJShhLfmnK0CNxnH2JzjT
 T48rCB/p73pWdM7gR0k07Qsqrs2S5F5UhUAc5/FzLZFdihEp5/IhUjmLnP+eZrRcp5L84/DMt
 2SZWUee9zJGXcrn4TuhHDNo0XehpCJ4n5coJgiqNkjCo4w/m9d0+4+nC3ryx4I9peT1wi7e2/
 RPdAF43Q7Ae9zyL0rA0do5eieNMtkhjwMakESt7RBZA+P/gmHWFV4pmsYgAshD4POJqkg8cy0
 sjUVIE/bobeNMLuWLHyYg5D5+gL4pQsZta9+s5PIN253yE3UhEOzivgHkbcYkdoDoVv/BRABh
 k2ngYOw/KtWZIQJJDSnaASilKInskE6NURPDZ3Evj1IhA5mL0jRwI0YDRxHLwDch08AOX4g/I
 zbY2s6VG0+/NfHFdqUcGbSZETaA5UQpaFrQHAXRwCple490iiKqCosMVbwVfPj1aOVljPX8Rv
 /BM8+bsiuIVvY/ctkCUpwvFxKRGaoWO51RVTeHJWILdyyhFrBVgUpF/lXBYnz7wOnE/gk8rcW
 l/bLVNPjeTUCMlcYRafNbywT0BR92HNm2BWOT0BVoLiEjUJNk7eT5TSxOBIGGe7K3+w/uV5VH
 SS7byO9cu+NJA5Ol9Ge+s1W7JaAQFXw7MWy36iQ5Nv4RkuzwHRfskjCfqbIO1URC5qBCWbh6w
 tArDySnRrY0jUTijUPZyQxWR0fMM52Z9RcbXXc+m08cnRZWlle0i+uufOwdT4H9SZYyVv2qS5
 1TufHLd0xlhcJvt5kvptItFj0op5uaTyG7gA5qXLUk+BTdKDlvHeQ57pJyn3daU90Siasy17i
 5wue2RK4ES/uXrt+NmUFB2HI/7SkWhVTSx5S91g/yQVBJXbRMwrLnq61G/RNpnRp0TjpcpW6V
 +UqvsyAdESg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1200981579-1555059988=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 1 Apr 2019, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > I don't get why having a configuration option is better for defending
> > scripts against this problem than a simple environment variable. It
> > seems easier for the script prologue to contain:
> >
> >     GIT_TEST_ABBREVIATED_OPTIONS=3Dfalse
> >     export GIT_TEST_ABBREVIATED_OPTIONS
> >
> > than for it to muck about with git-config or use "git -c
> > core.abbreviatedOptions=3Dfalse ..." everywhere. The commit message
> > doesn't do a good enough job of justifying the configuration option
> > over the environment variable.
>
> Absolutely.
>
> One thing that big brotherly types would find config attractive is
> to install centrally managed /etc/gitconfig so that they can tell
> the tracing machinery to log all git command invocations centrally;
> with environment only system, it is not easy to arrange.

I think that in this instance, we should use the fact that we know =C3=86v=
ar
well, and refrain from characterizing him as a Big Brotherly type.

=46rom my reading, it looks like =C3=86var just wants to avoid being woken=
 up for
a Live Site Incident that is caused by a violation of Postel's Law: be
accepting in your input, but stringent in your output. And in this case,
the scripts by their colleagues is the output that should be more
stringent, and enforcing the stringency via a system-wide config variable
is as legit as our instistence that `user.name` and `user.email` must be
provided if you want to create a commit.

And I would not have the faintest problem with adding that patch to
introduce the `core.*` setting to that end (which would be the right
section, too, even if there are already so many `core.*` settings).

Having said that, I get the strong impression that there is a rather
violent pushback against this (which I don't understand). Combined with
the fact that it would protect only against a tiny fraction of "git
upgrade problems", I'm getting more into the "well, then let's just not
bother" camp.

Ciao,
Dscho

--8323328-1200981579-1555059988=:41--
