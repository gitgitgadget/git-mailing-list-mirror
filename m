Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A351F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 13:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754402AbdIFNYA (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 09:24:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:59392 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753959AbdIFNX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 09:23:56 -0400
Received: from virtualbox ([37.201.193.79]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQeET-1duiA61MwH-00U12F; Wed, 06
 Sep 2017 15:23:43 +0200
Date:   Wed, 6 Sep 2017 15:23:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] system_path: move RUNTIME_PREFIX to a sub-function
In-Reply-To: <20170906123027.w5y7s33p5p2kfzia@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1709061522420.4132@virtualbox>
References: <20170906122834.s7a6je4b7casdfxx@sigill.intra.peff.net> <20170906123027.w5y7s33p5p2kfzia@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:474kf9XsSI/zKdNdB01obI/Dye5mM6/vXUrL4/Jt24/I8+cSJA1
 iI+HrQiuYZpLWH1Niz3pl8vHBTxWEPeDLj53snQ2V7ru5FeYrku99LFVfq3rBodwbI5b7iO
 vCTcfrTJCa6M5pAvbNeFHRCb1xBo6RDvqI/cF3O9WnDt4mWo696u8LSXYyQn2BrKoolalwA
 /4RuVF/FFwBBP4u45wxxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mLGfglJnyrQ=:3UNE3g1IguJ6RCLr27Dipw
 akKRRSGry80Cucj+wbSlU5FJdG9nRY/iedyrVoL1EQY5yHGlMmX69MzP2C3HOZOhwaARJa6RL
 WS12AXSfA7b/wZ7v4/FxA8CGrPYxUT7I29Q7gUE7j9PlBsczbE9xUW+Du/uQrDkYem0cG924v
 z7fPwz8o/tY0IfvmF8y5mfrCJ4up5TCamTRlVInEPmKGJPhzVpMhrHMusLjikgqgaUurgdFT5
 lC3zszrn4wrCYl414Yhis3FrRlU3WHRrZeHQ3GgU1TjdaJRPwLO5CjfzlzNFlnYhZT7S16QhH
 LOlHS5J/S8Ra6ndBf1QKlmb6e9eFCZrh1Tyu8mEkTL41z9Eaw9l0/62s9lF1PTNenfAa3V+9R
 r8L9NBUIVoAAFxK6dWz4QUaq8XNTHMqbxfpu4ZykuEs30bGghhCbm+qfh6chkExgXpiPTVbrw
 oAgXMIvQh5XCBoOw13fBzUiMD5epkxvn4537PzNjJBBjf9/JyQFsN77nqFe5oucn3FtowUs2h
 RgzmQ1R4P4RP+mlemqb2eyE+H3vF9tO7SpXY7lgS5LqKKLcl5QUXR85bWViJ4F4NVkomljyxD
 l8b9wVTeP3Bb/PrFtAOMF7fadzTV/Ht4VaWCWFGysNT909hS3zXYQppvNhyHYKAYN6hr5EbrI
 k3YBRWi0YP+sm3nLpik0fzbTFesxkiAOTP8X4of5n6oPOYvrfdyqD3kvl4XvVFamGuk4ZPeMT
 kRNmKV627MzPwpeXCaGjzBWccXs1n7O6JNhnaYyMRs9FMTS1obY5aZT8XfaRuLKmZaYJl+hbU
 sS42jW0M8pJmheYpe8pKwkicP+Mir7Cv3QDYHZYfnxC57qif8A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 6 Sep 2017, Jeff King wrote:

> I find the diff hard to read because it shows the opposite of what I did
> (moving the big block to its own function, rather than moving the little
> bits to a new copy of the function).

I guess --patience would have made it slightly more readable. I did not
find any commit in your fork on GitHub with the commit subject, else I
would have pasted the output of `git diff --patience` here.

Ciao,
Dscho
