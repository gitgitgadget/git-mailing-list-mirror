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
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E7F1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 20:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfJFUir (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 16:38:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:35321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfJFUiq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 16:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570394321;
        bh=OtHqfE0409V0out+pBcAME3RnHHXfx0iDiK6qClXwjw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aG3t7o7TTgEYX1WWUGuMmXPZPaBNGKfRz4RlTKSVH2tQfEcKed3oEO1d7/3zHTxIR
         BUwJgqMT2YKKmdT/ULz9p3UNrt1zhCfg0OeVKSdkQb2lB14zbjxgYQN3W6G+h8gV2K
         UoOpnGTnC6AaBDTneFnu9/nffK2DmmLaPv60kl8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1ihZr71vto-00QSck; Sun, 06
 Oct 2019 22:38:41 +0200
Date:   Sun, 6 Oct 2019 22:38:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in
 our Azure Pipeline
In-Reply-To: <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1910062237440.46@tvgsbejvaqbjf.bet>
References: <pull.288.v2.git.gitgitgadget@gmail.com> <pull.288.v3.git.gitgitgadget@gmail.com> <xmqqimp26808.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7piZ2u0lPjEwpmCsDLR4M1YWcYDiXkfWnxsujBA0DbP9/Px3kS7
 aktLKAfEZGnabjVQGeYxkWu48FXOnv/Qj2UFplJukd+pRKt7SL6Ba9KIh25ZNw7NmnudyQl
 RbhaNyo0EbAL8SB+hUYV4E3eZQsq3Dy9tlKBKDx4rYYc33uMQW/VlsxusvHLqJS6KctJcEQ
 k7cHsfMscnq+Fd0+Coctg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xNqd+tYCx4k=:fRzvAZ0oQas90X6164gC2y
 p9irPGqmMNQ0wpCCcmP0nJS7fB6ckOd2NruP6wW2di7F/naiRHsAxYQRWz2X8hIKmJzAOXH/S
 ohsl1JBH02waq+7lO0eScr3uGIQe43VOrMvzV/cYvhuU5Rjz1cn+3tpQqmy6OtvVdAHbprLUI
 eHNgaTQiOHChWKS1tqULrylGuLCRUMP84j+9oIR2RGciJvS+iQ3ZbADDpccmcwgXdhOW4+3jS
 JCDuItfKFukv5eAZ2OKLBXxaR2LRFtKKDP3G8whBrQBSZxBJ4g7g4I8/ZrN7tixkRQ6VHuSR5
 Efo0VPUEExb4j7FtuNEEgVdTcgXAsN8A++jnOxpBcSNt100YRbw2xFfoNxcWSm5o47PLpHwX0
 3MTNmiymIVYmTTWpLvIc7DmxduWfDnjJn7gIdvmTBJRc9XrYI6lv8iZXhvikI4kNa6wJZggDP
 RKaUBFUOa7Q0OlDbaDexFBLkNpEqaAbJEzLJqX8PCwQ1gNH5sS+t7Yrv/kuzlXkwdXA4gVzrT
 MRUxUSm81ve34yOvq/B7GOyYawEjssZ1/sNAcPAb102bPqSzXNxiXqOtEVI4iLh97IkDgQ0mh
 e1tEE2jEiON+wb1uE/jLiJa6cGL/EOo5RwINDe+aFpyq629+e8h7nOqeMdbYgk54gHF4RMC7i
 ejtIHcz/2vz28tXgQa0S1qiFkvJFcX8zO0A77+4oG/cmX2Lvj9YM5hN2vgLu+Km/en7xprNog
 h8chJy1dANP6bRZA67C5g9KEslr3Xe/ineHeBPxNhCOroRmMl59G8tMg6rc7PDlSVKfWKBRV1
 9kA/MRlt/U7uxO0z9vDpCCOdsWvyDwSsd5B7MNQH9/keb6hfGg721IhBz47UvG/qFlRuxkazq
 nFXVI9hbEPqwit4sthhfY1Mss1Uh/VVu18YCiAhJGf0MXgy67maNpw7b7vDNsiWj2UIDhdgNG
 uU0+PsVRSA7p0e6Ms6LjwSmnONIgWAt5YkMCvvEnbUZMai4UeL9PGJaRIE3ZRjvbawdzbe6ca
 6pIHtjCA2vWl78w2/3Woz1zQNjYLpTQN3BEmA0+ILjbq5TwyJ/r5yeR9aKy6J4vEAdzjyuXB+
 AC1oVIDr9DmitrDb4/2ckUy74tO2O7YI+U41l7Yn84ISnR1c2XMQKXWwNOPMsY6229miPiKTe
 SJtP+zGh0Oj3BgK3tHz5QWzNMtVKVROh2GV6x501jRyhdW6BFCaJy5oHjzGipvHLmR7q6NpJ0
 aenAxSJzb9+n2Qssj7NANDHo+gO87GsGmxzh8/pca7v5O+KPOKPz1xWZxWSM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 6 Oct 2019, Johannes Schindelin wrote:

> On Sun, 6 Oct 2019, Junio C Hamano wrote:
>
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> > > Range-diff vs v2:
> > >
> > >   1:  4d0b38125a =3D  1:  4d0b38125a push: do not pretend to return =
`int` from `die_push_simple()`
> > >   2:  8800320590 <  -:  ---------- msvc: avoid using minus operator =
on unsigned types
> > >   -:  ---------- >  2:  7fe2a85506 msvc: avoid using minus operator =
on unsigned types
> > >   3:  8512a3e96d =3D  3:  e632a4eef4 winansi: use FLEX_ARRAY to avoi=
d compiler warning
> >
> > This is less useful than it could be.
> >
> > With a larger creation-factor (and we can afford using a larger one,
> > simply because the user of GGG _knows_ that the two series being
> > compared are closely related), what is output is entirely readable
> > (attached at the end).
>
> I just implemented this here:
> https://github.com/gitgitgadget/gitgitgadget/pull/128 (it still needs to
> be reviewed and merged before it takes effect).

FWIW this is now merged.

Ciao,
Dscho
