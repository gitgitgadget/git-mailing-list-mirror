Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE83C2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 10:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiHPK3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiHPK2n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 06:28:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165E97D56
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660642289;
        bh=J75ZqXHuqWrDAHHcjXBx5jxCQjY4ClPMjIDux6kChXI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Bkt8p4u66f/sMSdGT5yYiFZtPv5f1zLKVsvTASD6P2Us3HWDO3SYVZFa+vB8NJZ8k
         2n4uxmALAOpEafTDknOo+llV27JG+zF44BhoYLh/0k+BupUjjVJ9gip/HgdncjJdMh
         fiocdnNSbO0N+ps5fjo4vSYZwd7DGBYndY29NNjk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1nYaWR3Dhr-00paPQ; Tue, 16
 Aug 2022 11:31:28 +0200
Date:   Tue, 16 Aug 2022 11:31:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Rub=C3=A9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous
 branch"
In-Reply-To: <9693b83f-551e-e579-b267-af1d633dc381@gmail.com>
Message-ID: <9so90892-25nr-0s4o-q98n-2qo76r3s89p3@tzk.qr>
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com> <xmqq4jymvllq.fsf@gitster.g> <9693b83f-551e-e579-b267-af1d633dc381@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1496150523-1660642291=:241"
X-Provags-ID: V03:K1:06/oLrng8c27r1KJY0ukG+IvugPpXIz82te7qOPv3zGgTVxd4yq
 4Fax0Q2Y9DKcEHDRc5UxZpVUvQMSZjiw+EOYqMzo+sTPt1pO+oV8mTs1+e6WEvKiDY/Du6X
 ANNKybROYxJChG/pLoqvehN8SfjqluizdktuzCmpJ8Ly1aXyOJqKm4Cfr5UJceHQrDNPCMr
 MLSbGORP/epoHpydGyyUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A3fdYHmzpJA=:02d6WZ0NyuMnngF2y5j+Kd
 irsKsbPCDboALcnfVqKS43GjzhHhS7OtGTtrXsrK1+xN4zH33K8cxYPhdRyneHSlPqMfLASf0
 YKerUz1hmuWQd1QtxDlLEzmCPlGNL0lG6s+m1B+yicEfkUuA/Jy76RZPD0lNPoxFEZTZQnkbM
 odbWQ0PsYJocEF7TFB9KvkkHBLYWP5oV92R+Ilrw/e/KXp0wIwVNN+RWRcBwgVgxK2rsXvP5P
 RuxkeoM4C/YWrAcjDBG7D4QNKMYJqxT892OVyPp52dd1u0SDCbmfAiceBLEEjPRCnXAQ5Xm5m
 /wEbSC2SdA+Csp1fNWWhT2MvH23PvnaNv8uRVXO0I0PEIq3g3Sku84JRO076jh6QmriLwj9Er
 6vm/7xv8euchrL4/HcTJkAM2MkV1ouSW840/k+NByQyMWBNThb1QlovasLV9k/k8+EUxU1dwP
 Ws4MMnv5tPnpP8cYV9DZrjyAqzu9E0FzroH+e4VpZuOtBNvE+f87A795NUQnbvqrMTL3V7Pdq
 LQzbbjY8MVpNzw9lxekzBJNEpeyCRtrYuRvkuUaH4IGaDRFKCAwbp338MXVZ+U9XvsxG1LVbf
 8JqyPwNQ9n51RV+Eqbns5MHZ0/j3cGh3L5wnbOYMpvJMi0yMXHVHeSaKSUU0xxlX+qhFxsQx4
 EAliH1QGcTbkbdCYxuCF4V+7H/PCjUnn+go/IqfstJ2AMCqujBYkd14BYrCXQQMWqBhXIAuCR
 JffZ77ITC26Vb2M/aCsRm9mujcc3SRMQJyFbJ/BaCshrI0my/eJ3NTt+bm9vxUG+yz71+rhav
 1hnWa0+RaSZ1FHLLw+KUEPp9IO9WfwZV3UR7Ptlgbv5BZML7e+LFJ6Pp3Z5pmo5KgQukm+7KE
 4ZN2JlQyLm0uCKBqXVkzR/6mhSgwbd5boNzY9XDB14nVySv2403Fr0o25WQQMG83kFErluUvw
 OcYhh5ljR/S7mUKX+dhdAg6sIeSGf81ayEVLBzS8R+Lez8buZp58hCYpLFWr7YaXvgs+9Oae1
 XX3zY3+R5DoiXEIj/bhwenzB/JwH0jk2lT0lqP9fUPCJLUOwnkiHRkCLo4dyZ2NJ53c4/Y3nB
 MvFgWW4WdAxmSsqBtaajAcnvfsw2EgfnzTkNL+gb/rHynnVjO8R+dLz2w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1496150523-1660642291=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rub=C3=A9n,

On Sat, 13 Aug 2022, Rub=C3=A9n Justo wrote:

> On Mon, Aug 8, 2022 at 4:47 PM Junio C Hamano<gitster@pobox.com>  wrote:
>
> > The "-d" and "-D" options being the more detructive ones among other
> > operation modes of the command, I am not sure if this change is even
> > desirable.  Even if it were, the implementation to special case a
> > single argument case like this ...
> >
> > > +     if ((argc =3D=3D 1) && !strcmp(argv[0], "-")) {
> > > +             argv[0] =3D "@{-1}";
> > > +     }
> > ... (by the way, we don't write braces around a single statement
> > block) would invite cries from confused users why none of these ...
> >
> >   $ git branch -m - new-name
> >   $ git branch new-branch -
> >   $ git branch --set-upstream-to=3D<upstream> -
> >
> > work and "-" works only for deletion.
>
> Agree. But the approach is to ease the deletion of previous branch,
> aligned with merge:
>
> $ git merge - -
> merge: - - not something we can merge
> $ git merge - old-branch
> merge: - - not something we can merge

This is confusing me: how is the patch supporting `git branch -d -`
aligned with the presented `git merge` invocations?

In any case, you now have two sets of feedback that say that
special-casing one particular command-line and leaving all other
invocations using `-` unchanged is undesirable, if you needed more than
one such feedback.

Ciao,
Dscho

--8323328-1496150523-1660642291=:241--
