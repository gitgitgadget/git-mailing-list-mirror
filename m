Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2F420986
	for <e@80x24.org>; Mon,  3 Oct 2016 11:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbcJCLGk (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 07:06:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:61141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbcJCLGi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 07:06:38 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MSY2q-1bRkyl3zlc-00RagH; Mon, 03 Oct 2016 13:06:12
 +0200
Date:   Mon, 3 Oct 2016 13:06:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Q] would it be bad to make /etc/gitconfig runtime
 configurable?
In-Reply-To: <20160927192539.ybooc34iodnzs2ab@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1610031303000.35196@virtualbox>
References: <xmqqoa39p926.fsf@gitster.mtv.corp.google.com> <20160927192539.ybooc34iodnzs2ab@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:izWTzoS0y3bYj0JWYRxYm4wV6ap5SfKufOlPctkmF6ZA8nqGcDu
 MMY3J636AIx1ikYhylKXBvOogDAtLaEI/vUXuLV8TxWsx0ktd+G41s09hN0Dsj7stegrzl7
 Q2Y8EKeuDnMJKu5VQExYkZyKLx3rSEKcl2hAIyHP9JB+lSLmO6QmVwlhj/oe3FDOMVdzOd5
 ZT8+Ks7MvPKrPh47wadRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GQF6+1u2XtQ=:BWsS8xibC3u6ZQlhF3/1Gr
 XzJPfxS5rho8LCOJlh2qh7/XWTZ8IZWQdQxJUMnkU0cUJI7OaChbXQzw0BWnYoBx8klXnTCQV
 lTWZ+7pf8F1p44B9y4wnU8IXCnQ8behTWXx7zw3oJexj+naO9u5Kuykl+bDKeBIOvuHcIxocC
 a0EpWfSXoSXIIyohPKi+hG3IRnX0PDlsh8s84A61xeZsQC39kvTIo1BP7DtwvM6Y2BDS92cT9
 Gkysrbdlp7ECZ9khvqtye8J+q1m1MQ99+kDFJkoHZ3Ym+si0V7fxjRAEVYYsS5WjyrBFpbWyk
 54NDIcfBj4r8kYa0qlqsQzclac4WLWE2U/Q7cfvK5Bw98SLlZbbCzKI07Ucs+rRHZvlRa3FSE
 znMLG4V2cvZc2dDMTxPaxoVG34dGwG00RJ546pjlYofdjfnq7ZERSaHaFuYZMB/uW2YC+yAfr
 HmuTq0OwoIUlzvI1w769MmEUKc5XU8k+3lp/cF7VYvU3g83XHIeH1On6eJnlVwTY7O76jSQRR
 Z641R/ewuBTXzjpEburD4EBuVFvpy1GvqiCsqfubikcEjd/c2uYlYHKc1kb3BV9fpRtHVlUGf
 8i0OV1ttnVBcQxYpi2kzGY6y0NSJIe1vC8vsU1AYoEA22rV1wxJZqZi1NmCkKDsQhgmzSopz8
 1gVK2G/HtnIo5Kubglm6f44p8wpyUpbXtCtzWVOZ6mXjvu3mW7xzK7HHL9yRo4GmTh5PNK1ig
 wQ3z+1LK4w8mWdykxkXJYkIUy0rW5e60eYhww66eHfQtNa8omUnwx32FNE0FkKJRxRK/gc5l2
 acTA7RX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 27 Sep 2016, Jeff King wrote:

> On Tue, Sep 27, 2016 at 10:05:37AM -0700, Junio C Hamano wrote:
> 
> > The subject says it all.  Would it be bad if we introduce an
> > environment variable, GIT_SYSTEM_CONFIG=/etc/gitconfig, that names
> > an alternative location of the system-wide configuration file?
> > 
> > That would supersede/deprecate GIT_CONFIG_NOSYSTEM that we
> > introduced primarily so that we can run our tests without getting
> > affected by the configuration that happens to be effective on the
> > host that the test is being run.
> 
> I can't think of a reason it would be bad.

I cannot think of any reason right now, either, but my gut tells me that
this needs to simmer a while in the backs of our minds, to give potential
reasons a chance to come forward.

What would be the use case, BTW? IOW what would it solve that cannot
already be solved by using XDG_CONFIG_HOME?

Ciao,
Dscho
