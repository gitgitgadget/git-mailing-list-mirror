Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF21C32773
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 13:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349517AbiHSN6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349351AbiHSN56 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 09:57:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFFC100956
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660917469;
        bh=U1ndVtyu80dxk6SslkqZs3VJRV+aZDMz/qFZkJFCibE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IlfJn1AZX026Plz1W8vE0A2zFuIe5nBGS+S/pR7hZP7/KuRRemWjGIl4zYmox+c0k
         aPSOHg4644A3I633ki0OaAjf7eRdVgHVEy1oEL0pjyQ0En5GrUvXQSj4gJwvH6yHNg
         oc/pvasEMDZFxaBJ1M1rLuox2MHmGVvzZnWu+l2s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1nR0rP25aU-00y8cq; Fri, 19
 Aug 2022 15:57:49 +0200
Date:   Fri, 19 Aug 2022 15:57:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] cmake: align CTest definition with Git's CI runs
In-Reply-To: <xmqqmtc4xlr5.fsf@gitster.g>
Message-ID: <870o76sq-1056-n0q2-002p-3s2po0808335@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <9cf14984c0a71b1ccdff7db0699571bf5af1209b.1660143750.git.gitgitgadget@gmail.com> <xmqqczd8m1lr.fsf@gitster.g> <7ss9r585-14rs-so68-o2n3-9qn9qn530742@tzk.qr> <xmqqmtc4xlr5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QNAB7euXxAurKB1mglSv08fYj2DsOfXZH4GFMcmg6s5n6G46TxE
 FKUX87cpAGGB5oHrIXEF4YQCXvPYXWF656puQehozO2+Mce6DNMj/71HO73yMUAcRXHlMVd
 cfEYQ9XIzTDt6e/3Ur/tqv7MI4RMWfDvwWrO0/E0nd600uTzytz5Os5W0OzJgqA+4Um54zT
 N68KQBzn/oFzjBi5arVjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kzIf9ZabHVQ=:+n+EWsd1Ke6f/tHYm5t7ei
 WA5Ts4jiJSz4RuyPczcj8oUSflPtF734CPKTRXfM5t1zRbZmUpAuRRAZiSV0Dje8j3D/WdWPk
 KjxWDgiK5T971EgG1dMyUv1dyVTXrH4lwRUIwxFxaAoR7LI7dsembROkqsocQxbD+VGStTTbY
 PZWVEI+vW8BQLzd+75uu0ETHggWnPqzs5zui2DGtjYlZ4HW6HhIe4YhJ43NkZ67/ouwqPMyCS
 MquNt15yHAQY5K0j5J30lEIFGM4I8T8ItfkhQoZkT/K9x3BwuK7PdVNZkKtA1sOtmaiGGYdpG
 ZLZhk1xWfnD/3EvG8wLv2+b6h3aT5Ikc3soeAI2WxUHYWvjAKHmRnwO6ZfDFkGPjNO1Y6nFIe
 WUcNLsuiLI46dS/ftLP0oapSpXRUPVaDlnm47zoQTVPOTuznrn6vykgFLfpmbrClxDZCrvua2
 hREKShj6K+UlWDftKEPaIG31UDfIdQkHkKVX1aUro32LOhgZT6n/OO/wNPllg8tyB1PsiEahE
 2rbz5Mw9Z6c4z1D0l6UsLLkaeIYk0Xofl996guXMAbcmofZvV7QKfainFRsQeAl+KJhUIHA2m
 BYtFgdFl+nc4PEZokWIvDW7On+Dwo6zmAg1FmyVbdWGCSN4Usd1nGW7OPxGWUckyFeW6wUMZq
 HOsVYZQfWKKDdsqibDB416RDUAc+4ua70DDju2sEhcNyJEpSP67NSG7o/Upx+cya8uwnyP2D0
 c07K+LLs+Xb2mvAz7vvXn3dc56u2W57jGjquflAP/P2w44C2TKr/SsjgBaALQn/QWsP2BLx5g
 bv/b9EJRTknY0UZXigamnshWOBdbre2g6X1O2z0qMWYKwFcPCAbbRSCGrqcRr0G2qMVlepWZM
 HZiyhvGXDXSwZBtK73jcZvxKccNX7kEst1FGM0sXW4NEd/1s/yybhBT8Q4TKr53wuGtT2XHGI
 829/NHQ34l0efC7dxj0iqgGDc2wC4yJwgy/3T7q+mL2h6gSya+rgLuoHjJr4CCfKe0IvQ8SfB
 PRRn85SCD81J/mQKPW+m/QZYy0lJLMxEHtEd4yu/9Qx6qH20VPnlkew6t+mdQpJVruHmQ4rBb
 u1QOu8emz/EHEHVf5p4zL0Pz1tLFkHLQsWHoPhqxaDel35k8gLV/HwChw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 16 Aug 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 10 Aug 2022, Junio C Hamano wrote:
> >
> >> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> >> writes:
> >>
> >> > While at it, enable the command trace via `-x` and verbose output v=
ia
> >> > `-v`, otherwise it would be near impossible to diagnose any problem=
s.
> >>
> >> This sounds like a completely unrelated change.
> >
> > It may sound like it, but it is not. In order to make sense of the bro=
ken
> > tests, I needed access to more verbose output than our test scripts
> > provide by default.
> >
> > When running the test suite on the command-line, it is easy to tell th=
e
> > user "oh, if you need more information, just call the test script with
> > these here options: ...".
> >
> > This is not an option when running the tests within Visual Studio.
>
> I gave an example of "CI environment it is cumbersome to go back and
> run only a single one" in the review you are responding to that may
> explain why such a change is needed, and you gave us exactly the
> context that was lacking here.  The environment does not let users
> run the tests as anything but a single monolithic ball of wax.

Good, I will amend the commit message.

> > Does this clarify the intention and validity of the proposed patch? If=
 so,
> > I will gladly try my best to improve the commit message to explain tha=
t
> > intention better.
>
> It explains why -x -v is needed and needs to be a part of VS+CMake
> topic, and it will help readers to have it in the explanation.  It
> still does not justify why it has to be a part of a step to omit
> bin-warppers and skip chain-lint that has nothing to do it, though.

Oh, that ;-)

To be honest, I reflexively do that on Windows because it saves _so much
time_.

I will amend the commit message to clarify that, too.

Ciao,
Dscho
