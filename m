Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117CDC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 16:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiGNQRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGNQRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 12:17:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093661D70
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657815459;
        bh=JPt8spO7EtdeQU98XVFReWlb5HqQVo3cwfLW1E1EXaE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=G9L3VCtnTxHdRjtn2u+1nKMud5lUBm7D15P11eFrijBbZ6fWCbf2WfK+cKfIOwlWR
         l8TFLKqNudXJKPPb3Erj7N90pMPWZ+ons0grctWyrk+4xywRxp28tXjltgW3m+Oqj/
         CAaOwQ6Fc9ST46CjBGdzJq7ymi0Ij0fURV/OJrxI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.23.67] ([89.1.215.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNNy-1nzMMT1eBm-00VNAm; Thu, 14
 Jul 2022 18:17:39 +0200
Date:   Thu, 14 Jul 2022 18:17:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: gc/bare-repo-discovery (was Re: What's cooking in git.git (Jul
 2022, #03; Mon, 11))
In-Reply-To: <xmqq8roxdlhe.fsf@gitster.g>
Message-ID: <5ps2q552-1rr3-7161-4181-31556pp2ns12@tzk.qr>
References: <xmqqo7xufee7.fsf@gitster.g>        <kl6lpmia55ys.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqq8roxdlhe.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s/nAnADZmAPDiKPAZyn5g8VfC8d3LnjvBX96xk1WnogkiojZj+0
 A6Lo2ucald3BySIB6mla+xZ5QGxSfW+3mKHLX29X+ml4bgJNnY99L7f9169SlA6jnbqTeen
 dJoy6cpJ2sGPbVvjh5sOhHvqZKOkZSk/WQ0k/F03qH/lDeT1hiL8S3K4Sv6Be5TeamxwUtI
 m3xciw8vbAoBQkl4SpXAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X/iRPcQIUrw=:4cA3yz3pqWQ9tAxUsZl72H
 OM8F5WFzdN67RarheJfCC3M0JIlWgrL7bTdeJbtI0YGM7weqpojksSDg5N6RPNni0dUyQCWfF
 zjimmO+qB5HmDI0jXlVpqfQ/DMbNZBj0fk9hwklEssHmn7OxnXpE/XieiMut1Eu4NOoLu8Cxq
 u4vEKojRKw7ltFWE9yrxfdsdNzM4GnWCZsqOoGnOa/yRtHlB3MBO7cnBzQd/mzEFz0vkBFIWJ
 W8iQ4iaZmEppphymFNvIr97SlLbg/ix188b6t0kKjimlTibTdUTW8wjrYmLlA2qzU17HDLk3X
 Pv82+TfARW1QQRfYLDZ+LHVx8F4PCM5E+MqQNIIdgvvKLlosK7uwQPod58jyjpryFgr10pavK
 hArCfMsu2mleBFbBiLFGAZZHCoUNcD3UQOJPZWoik04+7Vv2FXbDK4LBKHf1DgKq03klDATJd
 fqst+e+4HLps8UKUeM1svVGFZICH3NP8t3f0wZi5U51j1O1hJqNDZPHrUuXlJE4uBjT6tTZFz
 cYSq5FE1VKzUMmDfGnzNZ4PGT7rR4m9ZolQQe6KCHctvdxQFM2N1VVFsktY5ALwA/M7DO79tZ
 OSEzLIFGkOp25eZP/jDuFQv28Q952gFnFfItPjR6eGORzd1daMiwsPVqqZpLUffiaHFhiOfns
 +qcyuXfX993KuPJnoeN71xoLpl35Fo/717LoNDHDphR520nnQLUON+rSQhWQhHVC5Sj2qQ+/l
 l3lhce1v+Ebj0RfH115iiB8oE0hmmssoIOOThQDnKXWg9sy5fRmXopNQuVoynHecYwUUuBmM0
 6lQ9Hlbjk279OH+ffGS+QQE6ydbJ5V0VptfO+NPHywfaV4trQoZQ9/12c6MMzUvC11T7f4CiE
 W3pNvMxFqrAxhxFLxZGrfMcqxad0hcVRGubTVxzH2daSpkOl4QmAVueW2TSIcSUcq7t2x7frw
 J7bxdIgPWw29DUwuBfr6Ty5BCaUGSvHmXi07pav3ltw710+3cT+i6mG4EBKSZKIjVZL1oUcmS
 w15pK9sW1q/1ZOoXa3PivyBLAyMocBrrJJM9FP42ZIhgI51ZEFIwfOOJR+Y97iiAnExefplJb
 eoVCIUpXYbHR3xNW4Dk1NWF18hKIsz9b2VeS9I8Wz3QxJE+q2sL/excqQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 13 Jul 2022, Junio C Hamano wrote:

> Glen Choo <chooglen@google.com> writes:
>
> > I also noted your distaste for the `discovery.*` namespace (fair
> > enough). To avoid a reroll-of-the-reroll, I was hoping that we could
> > agree on something on-list (thread here [1]) before I send out the nex=
t
> > version.
>
> I found your idea of adding this new one in the safe.* hierarchy
> quite reasonable.  "safe.discoveredBareRepository =3D yes / no" may be
> quote a mouthful, but I do not think I can think of anything better.

I would find `safe.bareRepository =3D true` or `false` more intuitive, and
more concise.

And if there should be an option to ignore bare repositories when
discovering a Git repository, it could be a tristate, with `ignore` being
the value to trigger that mode.

Thanks,
Dscho
