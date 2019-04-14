Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CEF220248
	for <e@80x24.org>; Sun, 14 Apr 2019 19:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDNTi7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 15:38:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:43933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfDNTi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 15:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555270732;
        bh=O93VHpc0/6cKe38PNEJGwb7w4vtRVYMtWTX9EGDJeIo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IHHE9OwYf5UWuwR/6TCkqsNGx45avb6Vw4rW3YIbXvkcRbFVnOAt/ncgpPsJYcK62
         3LYZcYwEjkXxaYrcDZlnQSW9d3d8gW2Ukf0rZSY91P+0utBi3edKd/dpedTPYFVVwW
         0WvotQGScUBrLiNjzZXHsEuEgxGKBJvxFjYUFFPw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.172] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhny-1h5Le93HP4-00HBLE; Sun, 14
 Apr 2019 21:38:51 +0200
Date:   Sun, 14 Apr 2019 21:38:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Luke Diamand <luke@diamand.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t9822: skip tests if file names cannot be ISO-8895-1
 encoded
In-Reply-To: <CAE5ih79dyauRN3Kc17JMAx+p6dWFsy-P_1G=jTug-i9T=RrKLw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904142138130.45@tvgsbejvaqbjf.bet>
References: <pull.179.git.gitgitgadget@gmail.com> <52681aee0a9657691521baf13f792bcfb9eeb898.1555069181.git.gitgitgadget@gmail.com> <CAE5ih79dyauRN3Kc17JMAx+p6dWFsy-P_1G=jTug-i9T=RrKLw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EBmoVdDAlgy7J/if0rnGa8lTaS4wpYrSC0Ttz6V/5uUBaVfI+9D
 DDML5wRsp1gVwYx8x10ZrrkqsSNQ+bkEaWVpWZfZa6hHhZT+4nf2XyB4C5Pz38iqyNm6k9k
 dJ5cRqSf8cQo2Fv8ownYiVPfI44UETgGa8LPrR22EklXRt+u6sszYg73D/MSfyntDGn4d5B
 E0vMcwlY3x73P10fPqXAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vo92bjhsM4s=:7GIBy5zN3lx1br8Or/o4T/
 BN1vBouk4BRDgxtyJcZ4EC8cTI/GJ94ZkyPtdMGlhJYF3W7AhKJlMbw8QouHysPbulqK+tzaf
 LTtLM2kJtjXKso+PGdIeek5e6/xps2m2w54dw1QYO2HEq3XWf9mwCih43O805nGvXEds/pVN5
 JGL0RpDvmHvf8Nq+dwsKzMFvi+ezyXZ3084maVGmRVLeL2m0zQhQ4aras8+4DTmq5LMht5PTS
 YHq+7Y6YGWjpBy6eFOq0/bLRsJz++P1TgWYJW+DOUeVIzm5uIFGUch50pRePTGfxLbM2N/4+P
 wqa2JX+EBIaGMsGfl1JHoWtsoKCecSrdTYhSb5JZAAFTki/O2jZT5IW3M2//052UqizXM7WD5
 wKZIX2orI3x+K0A8oBgmExACtM5ebIVk+A9cNyHPr0Hwpd+zn+hl0QTCr18pL3HWDhxYX8V74
 Wk86mKa7uCceprdEd1nOy7drkf/fjNgEOJxZiJpM5HzOYsd4g8hU0le/fjne9VowTkKdEBV3s
 FXfb+Z2U50J7a/sQi2bdJvE6EOKn8Z/bC2lLqIIbv86ylacuq4TDcb7qfOGL7AvAuFvueuuEd
 HTcBL8SlpfBfafT1d2SogcEXSkxt0XCQUXw3bZ6039tSE5komwnmGWiPq42uHO7MQ1E9BekJE
 Vyc9ZgzPewciyH5vWJCTEDYgT8vlOIF1d5pdaXGHsWw1TJpvYdnK2Y9/zCFcxQTpxYc1ECwl+
 35NzfGxpXZxF50xP9zIp8+RZ5X0Q7yWYEzZUewY9cBUbtENnt8TWFjS7HTwwzEyL2+s8h11mm
 g8bQC5zbk8V35+VqIIUNQmlfcQkITRKfKp227bW+mZAB/mRo9hC16ch2Xl1s5L4JFEXj3sqmH
 HtCnwk6K9GoMRtprZohe4N6Sj+z2vwQ35w8iOOL5mu5W+BG5TnBvmiwFY5mv3aEEopdxe11Da
 pHmBO4nRqSA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

On Sat, 13 Apr 2019, Luke Diamand wrote:

> On Fri, 12 Apr 2019 at 12:39, Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Most notably, it seems that macOS' APFS does not allow that.
>
> Did you mean in the subject "ISO-8895-1" encoded or "ISO-8859-1" encoded=
?

D'oh... Fixed in v2!

> It seems reasonable other than that!

Thanks,
Dscho
