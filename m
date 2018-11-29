Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86225211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeK3BLq (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:11:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:32907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbeK3BLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:11:46 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7pI0-1fWwwW1n0K-00vRmr; Thu, 29
 Nov 2018 15:06:12 +0100
Date:   Thu, 29 Nov 2018 15:06:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v11 00/22] Convert "git stash" to C builtin
In-Reply-To: <nycvar.QRO.7.76.6.1811291352480.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1811291501100.41@tvgsbejvaqbjf.bet>
References: <https://public-inbox.org/git/cover.1539553398.git.ungureanupaulsebastian@gmail.com/>        <cover.1542925164.git.ungureanupaulsebastian@gmail.com>        <20181125215504.GJ4883@hank.intra.tgummerer.com>        <xmqqa7lwz8xm.fsf@gitster-ct.c.googlers.com>
 <xmqq8t1gwano.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811291352480.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Rq2cx6UFuUHyZ+jO7asrE1AI84ZTIg64VJNaoEyOXXbJ5uW8lpo
 2BJ4ZCkC1XHaReQ9nVHaDYW/gNh1jN0UuJYhw9H0y0Y0Qyhwnd8WsPX7C22rEMIavtW2nfI
 CW4zMElY0WzJ1czJqGkg9u6z7wMoEbxZEb9t9B9+7MA+aFLi7rZm7Axn0Hb8XBaULspcbCN
 LhV5JHW59nisLCIQqaHbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bAVvor+r0I4=:KJB0o/PJQGJtYA+QjLszNj
 N0BwNo+XPPLK7lgT8vFG5Xn4hR3b449SfFfOKIaTo9QEvS4gDfVdTSzr8cPruT3XqJzAg3Ffv
 nQTV7t8fKYDNSqfSEBhyvhGgNj7JOdzvxFMP5SHc5AnTPoE8JScSw7M5qtnIE9AGgFbDbGKMF
 6sqseUvqsmUv7s070UpUPmzEhpwLMebZOyje7rhiAq9B+lI6R0YuUh/lGrZsQUvKERezFin9a
 HTZcZvgkuEw9KmGrsT2z7OUSp7lgOG5Ivs+yKq35DWdFOLK6yYC1M0wLFuTHI/yNAB7kveSEA
 i9q+3SVMKLK3qizlexSCF5pz8AI5Bnp9TqYg9Y3GgBuKNV9I+6zoUlhD5sn62XYfBmxlSa1Ac
 hGeQWJJ5w2niCY9SW0pe/lqMcHSUgRnXhC0y5vKUPzetHDhbqOlS/+aEDYgWRUFB52EKdi4Wh
 KF2OdfFHmJvnwAZYEDtElrOcXWYaZs+pGYcRv1t8CxyqQg6zhlfRl+FvDjzB6wUmyGrMCV2Z6
 1oVqlS37SCYE1yNjmEZYcPHV91tBZ9SUeq8VuKCQur/Cst0VcFORFJeICv3aPyA7DS03pS1/l
 D2jrhVh9I2tC0lO5eESR/K4/KI9PlBo0FoLSIxSGUDop6cp7WcLlRhzgrYPgTTYDJ4rijCbcy
 kX1iYeFeYTMoXVABjXeQgmQrBFhmVCA1/Ww3QkpZoqTxjGYetNEhIavX2aiLy2icTDBA+uCrh
 0McsDIoB3YgJvSA5ue+XGoR3iksDO+4dOu0pDmT3oTkA625ZsKiyHu0IOjPt/b8l8Q1u+bn6m
 YJOZaKxSCEeMRv1IdWi28IsDzjPkSwUDfZYRNM2B9AHXLblZ9f447OI5UpLFB70TUAcI/5K6T
 +yjqKvZwfyGyBkuNO1M8m44OvCeAcHfchd2k3233GHzD0g5vpWWwEAQ3padPj2A9VI1Sbt86v
 QIIT8iKWsdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 29 Nov 2018, Johannes Schindelin wrote:

> On Mon, 26 Nov 2018, Junio C Hamano wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Thomas Gummerer <t.gummerer@gmail.com> writes:
> > >
> > >> Thanks for your work on this!  I have read through the range-diff and
> > >> the new patch of this last round, and this addresses all the comments
> > >> I had on v10 (and some more :)).  I consider it
> > >> Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>
> > >
> > > Thanks.
> > >
> > > One thing that bothers me is that this seems to have been rebased on
> > > 'master', but as long as we are rebasing, the updated series must
> > > also take into account of the sd/stash-wo-user-name topic, i.e. if
> > > we are rebasing it, it should be rebased on top of the result of
> > >
> > > 	git checkout -B ps/rebase-in-c master
> > > 	git merge --no-ff sd/stash-wo-user-name
> > >
> > > I think.
> > 
> > https://travis-ci.org/git/git/builds/459619672 would show that this
> > C reimplementation now regresses from the scripted version due to
> > lack of such rebasing (i.e. porting a correction from scripted one).
> 
> Oh, you know, at first I *mis-read* your mail to mean "don't you rebase
> all the time!", but in this case (in contrast to earlier statements about
> rebasing between iterations of patch series), you *do* want Paul to
> rebase.
> 
> Let me see what I can come up with in my `git-stash` branch on
> https://github.com/dscho/git

There. I force-pushed an update that is based on sd/stash-wo-user-name and
adds a `prepare_fallback_ident(name, email)` to `ident.c` for use in the
built-in stash:

https://github.com/dscho/git/commit/d37ce623fbd32e4345c701dea822e56de1a5417f

It passes t3903 in a little over a minute with
GIT_TEST_STASH_USE_BUILTIN=true and in a little less than seven minutes
with GIT_TEST_STASH_USE_BUILTIN=false.

Ciao,
Dscho

