Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF34C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 10:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIGKGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIGKGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 06:06:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8640E20BF0
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662545195;
        bh=EjTAY6EtlVlNShlnC8WI7LsbtIdjyka6C5r/k8qvHEg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NZu/qGmvn4JFLsg5IVBVyP475rnBmpv1B865Kf7Vul6Ou436ZT501PaG9pvT4Fxu8
         dX23Rz2oxgCqNh32HGSDtyfQN65c3T0uiGmL1zwPvA0kIL2bi7akHHKJay7KG7Ni57
         DkUE70vGMf1VW/txbzFVw2ULjaFGGRo9I/NBjpwc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacSY-1p3Y4e3pWM-00c7Mr; Wed, 07
 Sep 2022 12:06:35 +0200
Date:   Wed, 7 Sep 2022 12:06:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] diff --no-index: unleak paths[] elements
In-Reply-To: <220905.86zgfekrqq.gmgdl@evledraar.gmail.com>
Message-ID: <36q9s463-rno9-9rs1-7qsq-5oqq23o30o0r@tzk.qr>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g> <01pn98p2-qppn-260p-8o80-n5483p41859o@tzk.qr> <220905.86zgfekrqq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-158401198-1662545195=:189"
X-Provags-ID: V03:K1:AI6wB+XjfSGverkfh8Sq3r3mV/c/K/WH9ooJlDLURZjFGClGT+6
 ZnNyxaKlba+83oDiWMJlMNzo/gLejJWhyLei3oje/4nt/LJRhmuPT0gNUHBfykQv6wXiMe/
 T0YYWkp/rby/dsQj8wrLqEDglgLd/Z9gm558IqXJ6z5Xz6KQCxvFC0CeAskm9BYHKOPAasK
 EoUPywIKG+semWc39oPSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cYpxg/6vgB4=:dQIdx5D1bqAPMUFFMXJlWb
 X5p/OqMVYLwfq04laQ4YP/Tf/6l1xDgjNScFkM2R4yULFkRbifxOzUX9uxijHvdCkue9E6Qsi
 ByAvCSCKfedihnf0E06YZq1NSxQBRi6Sm6euviKU+ChZpK4aiCmMoOXaqDha6oHA7S4/lCcnb
 1wIaLYCaYUkoi2OmY4HY3n5mmsM8jV9il/gjEAEsAWR6aDz8WimeJxM2M5e6B07uhBkhnIRPO
 1r65lr8SB4zGSyD5Eaw4f/reMK4hY8xZ1dYBhxQUy4qWQ9XdBioDvhzEmOtWfLSLfD+MLwHUO
 1Nh4lRBZskohSngOdfWzEVBbeIEOxJ/2hDVfWAXPZOD6NQc+W2RUCPd1qmSdrJnBTetYjI7K7
 yTwA6J6+PeBZwSg0Bul5vqEAWGlr/CLqct20KrRc8U6Ho8eeBCbl0iNVuCJsiwTxBElrVEEXc
 Y0oFVUhEMVWtOH95+vvCQ4dGeamdjc3WoumWwhf0DyiZADz9sjF7IkmbBndfa7/H1hMySGz8Q
 +zpgpUd0nbMChE0dDcbSlJiyEauBTTkd4Ilw9dieyiUgZJfWp7o4rd46Tu5XuyIlh9wcho8N4
 PBuVvOZfVGqXRIvmw0/5BrScHIi5vnzeDASoAV07+pnSRn6EfmhkRjMSZrG6JWdnmqDyZeYx5
 XRqkJfhxviKxpvg51GSLLNjak6ANHNAwxhxNmHHbqNnT/zjYnDozqcywTSET0JwubLa4it5kp
 tA5yFJORjOBXyII/B2FYx7/+fThpqwt2lfu0JNO1ZiE1ygnfx/IxkpbKGBHOen/VyhFdiv+lq
 e7Z51JNfTa0Yju5t2LyM0ar5557KER2QuBfdQA/jVHNqFkpJ4mxbAyj7lkFSLqwUtpdEyWXEd
 ke2EIvp7N0tAjOXePboFOjioiZGmpQFO/kA86Z0Lp9hU+Kn+BGBz9+lGwlWOaDwT480k/SZj1
 FyUlJ4EDnEeIb94WxFesWq7nuWITXkMCXhV0PqJ2kQC8LWpnpj5ufXB85VHCnje9iWfY0iKsn
 LqcokBdcW97J0rJVXKglz+YoNBnK/vgtUskCnHicF50LksL8VdD0XfapFLMtSOTpbt+jrQiUY
 X/s2Ec5bI3jit0sTd9EzdzjQbL56ksHGsuW6qayklph13Rx/+XpNkLxjC6zuE9YQN0J6PIIiq
 2nZGI+u2ECjbyVTZU5k8zJdv1b
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-158401198-1662545195=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 5 Sep 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Sep 05 2022, Johannes Schindelin wrote:
>
> [...]
> > +	string_list_clear(&to_release, 1);
> [...]
>
>  * The free_util=3D1 in your code isn't needed/is a bug, we make no use =
of
>    "util" here, so it should be free_util=3D0

Calling it a bug is a bit strong, and misses the reason why I did it:
future-proofing.

In any case, Ren=C3=A9 took up Junio's ask and provided a new iteration th=
at
side-steps this concern altogether, therefore the point is now moot.

Ciao,
Johannes

--8323328-158401198-1662545195=:189--
