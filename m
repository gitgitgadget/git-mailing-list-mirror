Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5681F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 14:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeKOAcT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 19:32:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:48855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeKOAcT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 19:32:19 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Metpl-1g7s8y0Jjd-00OVU4; Wed, 14
 Nov 2018 15:28:37 +0100
Date:   Wed, 14 Nov 2018 15:28:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] rebase: understand -C again, refactor
In-Reply-To: <20181114072909.GD19904@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811141525080.39@tvgsbejvaqbjf.bet>
References: <pull.76.git.gitgitgadget@gmail.com> <20181114072909.GD19904@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HzhL6Fp7O5lqdtDUdipXERu96ynIvj+VL53kfYOedjHfobjq6dw
 6C4r6izgZKb81FBVvHJvk/yQMWk7XX8jLLyWTKWpcTMjzYS5dTqJdE2wckZuc+XfLFWSlkZ
 B/lw0RMA/jRr0nKl/T5rYnbXlCM0LUnoAJdGhcCTHQdB9V/BpE3TtLemcSaVXWQPe4ACMR+
 3I7Q26shLxY1obBiNqF4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pBy/pP2Berw=:NJxwYeY6XbO1/N+J+ZV0mG
 +F9a2O4JzNnGgqOOye6QShxdfq3GjLnxHe5Rj5cz/ZfIvLnYzx+heihada+IAxVwWhdUo+K4e
 RTrhS1ehKjG8iZQFaYk04n70lMqWTtVVlQT8SAC/EOH0KoCAmfnMVB4FeKTq57LGKj1ASnZ2/
 2ho886pIwqAhmgVBCW8qK4+vqGQ4Hx2Z0ezyPSJUZl+EB5W/0XTYZ/7OF5WOB4xeM5IX36OrL
 C26OX0zhfdAbTI0nXbgvGHaBiXdw9ivuC1figz3fuYXdhBsopwtqBLa+2Hb9OU+m1ffD7935y
 1H0/VlrxNxHsJ4v8we0cmqoGmK9LkrMtuG3xwnXCMpfCwJ6Rk4YEgQjev+6akf1W2JAse/5I/
 yztwvyDxHLKEA5Er1PyTNPVin2p1poyq0T1wH5gqUHIdVawkNVESbxNnwItO4+DDGAuehts4d
 mm1xJgLUiDINOoSrbWdQqejgZFJjshsPeYK70eriU3dBsKwqbnzd4Ty4muF3xB6FMNQHXSQoN
 AFQVFA1foubxhEXnjT7RsKPxL9Zggazkx1biQbiIimk12TOPFrn+kqGP9Qx9mYSFqa7Em9lO6
 pibFzqEhqVV19WvjneWHFS1t26cqxd77GyNJjefwE23dg5NgKVy9Y/lW41YKu6+5uh9Zehu6/
 De7v2nzMr8Yo4vzs8IUlBGyK/IPdkCOrLJRJl0eAtYlm1RjRcsiG29oSoMVkz9Mj9JEBVxbzE
 GU6iuJhbSjO5nwlVm91bNSf5dbW6YmyCZ+TsVSr4mhLPztyTbtRG/ZNr8P89DzVTAZK24wfVj
 j0TstBvFnMJ4twrpX7CWbzZ06EgFyzQa4w4WtpOR1/v/ECeBvjgGRJX/sm2vtK6Trp3F+idPa
 OSL8W7+6FKbL0uvrR7vTQz4l0DNE22xwDvXBySXcVdchNuQeAEKPjANHqhdNozhulewYoziK7
 dc/lMGgDddg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 14 Nov 2018, Jeff King wrote:

> On Tue, Nov 13, 2018 at 04:38:24AM -0800, Johannes Schindelin via GitGitGadget wrote:
> 
> > Phillip Wood reported a problem where the built-in rebase did not understand
> > options like -C1, i.e. it did not expect the option argument.
> > 
> > While investigating how to address this best, I stumbled upon 
> > OPT_PASSTHRU_ARGV (which I was so far happily unaware of).
> 
> I was unaware of it, too.

Thanks, that makes me feel better ;-)

> Looking at the OPT_PASSTHRU and its ARGV counterpart, I think the
> original intent was that you'd pass through normal last-one-wins
> individual options with OPT_PASSTHRU, and then list-like options with
> OPT_PASSTHRU_ARGV. But here you've used the latter to pass sets of
> individual last-one-wins options.
> 
> That said, I think what you've done here is way simpler and more
> readable than using a bunch of OPT_PASSTHRUs would have been. And even
> if it was not the original intent of the ARGV variant, I can't see any
> reason to avoid doing it this way.

Thank you, that makes me feel *even* better ;-)

Together with the extra-early error checking for incorrect -C and
--whitespace options, I think we're in a much better place now.

Ciao,
Dscho
