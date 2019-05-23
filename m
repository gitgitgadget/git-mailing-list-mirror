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
	by dcvr.yhbt.net (Postfix) with ESMTP id 885681F462
	for <e@80x24.org>; Thu, 23 May 2019 06:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfEWGok (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 02:44:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:38491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfEWGok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 02:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558593871;
        bh=nBD83VWzuwt+LpUUk5npIetGEHA248qYzKxrYgB0mxU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ctwXAaYSr/oImYGZDypS3LvNS3riqfYx2VYdjWA2vAJq90D2gh7yQ2mI45/SUfep/
         /fK9KiPk+5MnyUyjGbhPZz6BFMj0PyupSGZKWl+tp8Aqga1YrlpqditKBEcRqdgnHK
         gbkOP0e4VPsDir9WvRLbm4gkga7oAos443jPR7fE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lskr7-1gWgpb47KL-012G2K; Thu, 23
 May 2019 08:44:31 +0200
Date:   Thu, 23 May 2019 08:44:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Alejandro Sanchez <asanchez1987@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] am: drop tty requirement for --interactive
In-Reply-To: <20190520125016.GA13474@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905230840450.46@tvgsbejvaqbjf.bet>
References: <20190520120636.GA12634@sigill.intra.peff.net> <20190520121113.GC11212@sigill.intra.peff.net> <20190520125016.GA13474@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vWtEicHXODl5hJlFrbDqTweLWu5mVfdj18yNGeeATpAzk1XXEgz
 sEp95VrJtuR82Upe3yjDpzYgN3zDPDKnGcL0aMxN6VH2H9B9YasKArFrPMQzSIlR1o6mNzB
 M6fRUPcqctEPrdq5S+zeLZkJpZunmvloWvvsTt06rbL+GefFtAvsQr3At5KVl1biJ+cbR7V
 Q3td2Jv+XoILKiN4163WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mED7TocUpto=:2V/l8q4pdUuUVOS+c7B32w
 Sr/5XxA7X8HMzkInWevu0Ob60Wit+wh4GkhTVM6vVl2dYyi1Va9mcfdV2JsGOKims3AXGEGkL
 bzlpyE9/j+t92X13qzWSxGUAvU2NtALBJDpeD5XhcLW9AkPDDf8aveFbbeAFCmmnt7dQhPdzw
 1FOlLgdOcRvJlPq2UCYI5z5sf3s1LmIRfOYxU2QZm5rrI/nMJewVWdxrWR7JTU5/D+bJTXwzv
 2tyN57CQPSFq4ieGNfMysIF/lhGS9ALQzXaVAd8Q7LzYuBUZQRdaZsM5qGI53+ooCHfXEJjh5
 BjRtjfXycdO97b4C3imCOpq0mrWKy1RAfL2uTqk6Q9+RVLmYIdoGhnbZQNVDxB+xb4zmJpbKH
 ew+Uq2DrbXLOalkX2KtNyFqAJFKH9mHLuuEdJBHAvMjyZVKelUG1+1Nb1u9cNIorM2rr4qTdU
 KXijc3wVt3bVwk+XFHXPYlL1Pp6WTy0Ws9jAj0Yos//55kVcEi11kBayqXGhs+5G8BOA49FMR
 lGx3MNeL0eH8C9DushB3ly7BU8KDmt9o9y4AF+JLMxnfEGsNdcN0hpOTVOC/kaLnbXsa57kQi
 00s2daSx3l5bWycTwL6UtuyN/9y46ddnKqXUHBwrLBIcv73/Q6J2GBI97SXzhCfNsQLYOV5xf
 +8c/uxLkkRlq2YLuaPM4AsXMxhWYOUHmURZqP5/armWqTpBhnojFhDoLkD2NcmUTNnMsvgdOr
 cvKwirVFxldghj7lTz5Q74CBA7GoLwCMmLvJZ6NHMi+DJlEOwp+fTMxlA2WFCBG12msUCmANa
 Xofo06AmHwMUA9ybF+SvQb+bByWcH40r9d3yAmaEhQuYotY3EstibRqqPE9hqd4LycdohTuB6
 werxhpCSwsyjWEQ5pNmMuYxM5Bb8R31ee9lyKU29LcDAouRmelvKzSkBRyPrYnIZp9cVtpJ5Z
 rmm3gUrr4V31bJWX9eK78LRDvhOoEI5WXpDgOdqXjT+V/hMgMfNcz
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 20 May 2019, Jeff King wrote:

> On Mon, May 20, 2019 at 08:11:13AM -0400, Jeff King wrote:
>
> > We have required that the stdin of "am --interactive" be a tty since
> > a1451104ac (git-am: interactive should fail gracefully., 2005-10-12).
> > However, this isn't strictly necessary, and makes the tool harder to
> > test (and is unlike all of our other --interactive commands).
>
> I think this is worth doing for simplicity and consistency. But as you
> might guess, my ulterior motive was making it easier to add tests.
>
> In theory we _should_ be able to use test_terminal for this, but it
> seems to be racy, because it will quickly read all input and close the
> descriptor (to give the reader EOF). But after that close, isatty() will
> no longer report it correctly. E.g., if I run this:
>
>   perl test-terminal.perl sh -c '
> 	for i in 0 1 2; do
> 		echo $i is $(test -t $i || echo not) a tty
> 	done
>   ' </dev/null
>
> it _usually_ says "0 is a tty", but racily may say "not a tty". If you
> put a sleep into the beginning of the shell, then it will basically
> always lose the race and say "not".

This is just another nail in the coffin for `test-terminal.perl`, as far
as I am concerned.

In the built-in `add -i` patch series, I followed a strategy where I move
totally away from `test-terminal`, in favor of using some knobs to force
Git into thinking that we are in a terminal.

But at the same time, I *also* remove the limitation (for most cases) of
"read from /dev/tty", in favor of reading from stdin, and making things
testable, and more importantly: scriptable.

So I am *very* much in favor of this here patch.

Thanks,
Dscho

P.S.: There are even more reasons to get rid of `test-terminal`, of
course: it is an unnecessary dependency on Perl, works only when certain
Perl modules are installed (that are *not* installed on Ubuntu by default,
for example), and it requires pseudo terminals, so it will *never* work on
Windows.

> It might be possible to overcome this by making test-terminal more
> clever (i.e., is there a way for us to send an "EOF" over the pty
> without actually _closing_ it? That would behave like a real terminal,
> where you can hit ^D to generate an EOF but then type more).
>
> But barring that, this works by just avoiding it entirely. :)
>
> Curiously, my script above also reports consistently that stdout is not
> a tty, but that stderr is. I'm not sure why this is, but it no tests
> seem to care either way.
>
> -Peff
>
