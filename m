Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A8DECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 12:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiH2MYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiH2MYM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 08:24:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F1B7E023
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661774863;
        bh=Gy3tmwLSb1lukEdruFqNsCTySYcNdQoZcoGxeWZEmNo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AqSibDFh+VDLpkv1K8BRqL6/KsZgPJBdlcmekl1xPGKOFsSbQlkg4Iu93PR5sN7gA
         8dbteTn4dF0CogBKvmsDNRkYbukixRSgmCVxGwGFv1bH+EkLVfo3ZKGEU51NSU1bfL
         vsgbuVNWU+9VDN8JS1RK63StTadAzWqWvCRodVIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1pBa4H0AAe-00prnc; Mon, 29
 Aug 2022 13:24:29 +0200
Date:   Mon, 29 Aug 2022 13:24:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2022, #09; Fri, 26)
In-Reply-To: <xmqq5yiey6sy.fsf@gitster.g>
Message-ID: <46q59po8-o647-n859-0314-86q214ps668o@tzk.qr>
References: <xmqqbks6ya5d.fsf@gitster.g> <xmqq5yiey6sy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WxYRzyJcJvOJb1HCmXFaL6sQBPctR3wSamRoXUqVkONr5dnxD6k
 el0F35D9La78e4dZqFh26yJlZW1Dnx4c2zis2iaB+3yxqIV+q9ewjFotCvuDBQgZWDfNlyb
 fglL89X79NimJe/pgc+Xj669vaF5rEoGWmWo+/So8LGH+YPPWPPnHTGH7wLjOftosxo5jMn
 Kb9o1RRbOUtPHjkeSkQCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c27sr4TMnEE=:g9za/48lqxfj2FBbPOdIgp
 N9e7lscnXpsjG57hmbfJ7H/CRxXFFfirbcntMQmtlmdsYKrJU1ESgq7VyLtGByqKFRDbZO4Fa
 eEJzE0OT8cUOQ/BN1EzkNEN080KSUtlbGE8XJTnWq7NLAC9apzpJTecyRft6Av+rLF+DNK66t
 hJ1/3RIGJEjVfK7ytdEV8FzJ9fcjJpwoekPaguOJKe8VRKUR/xKKEWGLOp3sexAeKyHJZI3hk
 a0/3kzjW0FoDYNRHHSSA5Hz5lvV9dsqJ4gGC0TTgtOdYPWnjZJBsAo3221q2TkWHg5It9vlGU
 UfEb4jQsd88BITVp0gAwhkK0NoVjDtKR8IrGDcSRpRmsdUd7JOGRFZ7UK/dp98YfVUanRnp3Q
 0isFaFVWGsdRD9kFECJZGDpaH45Gzs53hRJ1tl8TSI8if0WRHFMARCaZObaMUp2fcv8Ca7dQt
 Kuemm8oLWkndZflgi7Wwdy9P+bXuj+uv/RyEdwEEymPWMs4bwnW+3fQxu3dBI2IbL2kgiEhor
 4O7QlAK3b6KaKCL4G0I5Q2pxUuedXTsu+4cXzIeOKr0pQ24W0+5jKXhd+8DfDk4G2JFhGDv6q
 ca8m79kJ7yPwOY4V5pHJh10Q/Nh06qEOs04vn4nKYpQdyYvW1zncjp5nnCz2nBTWAK1AuNtIt
 P5jrSueFVPJsKu1Q+8EUFSiB2ILRLSxk0aGEaYpiNExt6Mk1+MbmCb0hPZATKuRphLHGEOtmX
 snE7zuoCReosxCK+2oO4wTDwT2tJoXqDAQft2cYIFBGFliNZQQjZidZaeXK7cY0Md3ABXdJdI
 0o6/dCN+SZTG7crDdOIGWSYZxw5+Y+h6z06uHmeUF9RgeMZ9RFz33aIYHp3TzoSlAhDq043IV
 KTlZUe1rOG/33nx96UHMjjS7SjPFs/e1XHFcGYeBaM+g8eXhM2j7OSmqJCvdSdkz4/UJgIjhm
 TFco9oVMT7u6F2HusWB7mJEGh7klJEZf66atHPdg0ouM0pfEtXv9ji2l/F3eFZltIKa0jBZ+H
 31JeHLXYM8iy2h9qat14uoQ8DAjvDS9XWdf1wdJ4VhaE8eK70cg5VB/bqZBgReG/6QZX74M5y
 NxcIElzFXJaXsoiw7Wp2Mdg5RX35nMwSEwrJTf86z9UcsO5mKQbrFnw4+BZE14nM+lLIoaY88
 Aq0FQtVpxeTmfehCylJVbWWBB+gv2aPvLJNLt7ZB4bDDVuaw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 26 Aug 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > We are at the end of week #7 in a 12-week cycle toward Git 2.38
> > (tinyurl.com/gitCal).  As we have accumulated enough material on
> > the 'maint' branch, we may want to tag 2.37.3 early next week.
>
> Just a head-up I promised earlier.
>
> As we do not have anything else that is ready and urgent cooking in
> cabal, we are not in a hurry to tag another maintenance release, but
> since we have enough stuff...

Thank you for the heads-up.

Ciao,
Dscho
