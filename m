Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C8B1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 12:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755299AbcK3MbD (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 07:31:03 -0500
Received: from mout.gmx.net ([212.227.15.18]:57932 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbcK3MbB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 07:31:01 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkOeR-1ciepN0fvP-00cOIa; Wed, 30
 Nov 2016 13:30:50 +0100
Date:   Wed, 30 Nov 2016 13:30:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <20161129204915.lo45b2jz57dlfug5@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1611301330100.117539@virtualbox>
References: <alpine.DEB.2.20.1611251841030.117539@virtualbox> <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net> <alpine.DEB.2.20.1611261320050.117539@virtualbox> <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net> <alpine.DEB.2.20.1611261400300.117539@virtualbox>
 <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net> <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611281830040.117539@virtualbox> <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611292128340.117539@virtualbox>
 <20161129204915.lo45b2jz57dlfug5@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:c0INdHF46ggKf+H1EeIfckbrw7vZ8rriGP4gbidOGXw8WHvVTKq
 ic3dA1BPhCrgSGgvlwTZBhrGT75SrTP80clX4EwX3q+swvfwPES3wcQAo9Itoa6BuamrMvC
 CLSfQJyLFrqHQwzGz8KNOjqAcOaGTRNyZNDLbqQlyFOrjuT1DZkr2T8qZzE2zd47G+e+pH1
 DlRN7eVze3nwdvgDKH3PA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VaSdD2VKwto=:SH7LVg8Tqh3+TwUibgvsHi
 Uph62sjChixjifkw8BCWxkkQjwt+LmG4erk6LCVqcfB9FFSj7AJDJXyyCycN0Zh7euBjhYXJq
 SzvAc0LBh6AncnL1Du+IV64A3nxl+IyylMDfvTtbjsSjbzP/WyH2a1DPt0CJQ8jWgwRGgpTqr
 czNNYUYRlVz6tVwwWYLdlsxU1uNZ5NH51buky/bLNDf6RT6Odm1G4Gz9DKpgSmwjmA8/xiTZ9
 gYKd3+BD9TW79E6dLNygrqAigb2x2ZAUGzhzhoCyv9OlA7V+2Vyl1LVHm9krnYNiwO3cRx8GW
 f864XHBjTfqiDDmzgQzt4REqlyBjkV2nvoi6kLvS4g30wOwLqX8SNHs9IrKx6nc6yHp2UScQW
 SBJcOGjhSFuugG8SVfb/0ncC11iwvJX/dsj2SGXRQfkuFfBX+H8IJPJWFCMQ6xqwUNqA9BKpl
 +pBKLLm/JOihPJyGYmFA0zUVuAVPH/77R5QnIBPw1EeTX+Gcn9WVizadZzLZE156Cc5Ngwo+X
 Nqdfo2G0N9cUqupE5c+/hdISj46PzWXUo8gETC8rgAXiEdVizQJ2O2TB5tbywUqI6ZnSoy8jE
 hDiwBnXcLFUiXiwniB/2ZPNKvN+dmpRtZzntOIULg2R/Gvpj+EL7LCQWdDmw3FLeV0930ApZU
 ZInsi7ths9uZ9YJ1aTdv//G5/+npb0gbCbDc/3mgQJjS/eoa9sT5E+1ywpQtPA07HDBaG2Qu1
 bYec+6exNDc36rMPP+LJk3Dld9jwgrGJC/NP1qsTVzba32ZXhwn2W1KaAdMSOf7mR0BswBL9D
 NMZHBoz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 29 Nov 2016, Jeff King wrote:

> On Tue, Nov 29, 2016 at 09:36:55PM +0100, Johannes Schindelin wrote:
> 
> > So the suggestion by both you and Peff, to use an environment variable,
> > which is either global, or requires the user to set it manually per
> > session, is simply not a good idea at all.
> 
> No, my suggestion was to use config and have the test suite use an
> environment variable to test both cases (preferably automatically,
> without the user having to do anything).
> 
> I do not see how that fails to cover all of your use cases.

Oh, so the suggestion is to have *both* a config *and* an environment
variable. That is not elegant.

Ciao,
Dscho
