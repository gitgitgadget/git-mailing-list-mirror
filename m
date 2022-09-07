Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E89ECAAD3
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 10:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiIGKXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiIGKXD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 06:23:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C4543ED
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662546059;
        bh=Tz245xjHrOwXlhxvBPK2XB/R1UfIYi90UfkzipG1wYU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SEKc+yyoHzjXkYLeuj9y51NaDvZ27hmLReD9T2AJ2Aghnb3vYJJoRrix5vo/4hvGN
         py0vVLCpJHkeffErrtHAomrMS22u+SOl1flniqzWXqI0ScfCgZt5cevlcP6Hg8azUM
         R7nNWi3K185GeMTVd2E92ebJMXCb9di5ryvSdwyo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1pHVgc2xbB-00yzyH; Wed, 07
 Sep 2022 12:20:59 +0200
Date:   Wed, 7 Sep 2022 12:20:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Lana Deere <lana.deere@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
In-Reply-To: <CA+4x=b91W31eAnShPzVw1zta43OYwArsgW0EsU1-0vkOw+qGyA@mail.gmail.com>
Message-ID: <329qn1s7-s61r-277p-2q6n-194438531393@tzk.qr>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com> <9676rprp-s6p4-o2r5-6s86-5939os5qn855@tzk.qr> <CA+4x=b91W31eAnShPzVw1zta43OYwArsgW0EsU1-0vkOw+qGyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Vmt90QrhgZWzMfGXrlbJPg6hXYIXlD38SUd/eqbxTolNFxbcdFn
 H9Tyb46qgms4EwkCcwxKVaGMmGvLhd37seXn9FD2lbB/a7R0RXXSvCY/z4hLRxGkkbaVMkD
 9QJTjHPrcxZEytWjsmsmLOzrG/EMFORM45r5K+RLGl4b1LFwKD2SYlYlNngqQ8+4zFnXeCB
 OCGJaO73FfPg/2dm7PaFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SZirQxPf3eI=:b/BaVeTFGN7y/GD4vgTXMJ
 RMvejRz3j84WSYo9DkEbQ0A9Sij/QjEQsjJOfdmZ6aFmsjwSHmeatTqTvLPanTqAC8opDviJD
 B8CvjBJKdd2FpU/+DGDL45T0rci1VbJGm8ubkHnls36rPcD7EzHqEZiPKnmeuMw5EvYhmA3HP
 YHaOjrfkiTY39rzpj+7E0l9Na10RLQ03MYZbHBZFz2MqjSbkSr1B974ECfaNVkD6styYzPGr+
 QT5NTFqNodViwUiv48DWiVi1qnheg3Q6zEUsHRzUCxATtDb3ddUBvFNxQar+eUThU+h3uTQZW
 +APTwHqhSO5sNKPRV51M32tOst8OKOCvNQX8Ht6VrqEm8kKJxAE7Mma/VctryXlp5biCAxXiZ
 PfIWV6So12SFi/zB8rLa500sE0kGsw6cTHY4Qn6Js8vG9TpNn5aRz3tskgP7/0f4+fRMj4yky
 O+1jxxoEazV3B4OfhfXCWjXfFNXd0gx8h10Z5l5C8UlMKTSjnLdxMx59S/hW6SIxOxpdpZSxj
 VKPhQP1KMozeP8hqd2GA1ERhZ5FI6+0FfGA6lGbci/ycJqaR0mWtiFzP0HXqP9p8pERH9uZz4
 qLXa+JFHMIdBqg1piCS2qEZn1QHIFscwcuXEfEFLHIyyq9Lc5hr/g4+7fKECLFh8R4mhAxN02
 +henheErSSrM+4PkZoI5a8Okn1f0iems/RwKNMhvfHUNo0DtEQo+CVOVaYWu7FM6dU71IfzJi
 KYZupG+kzCA+VBLTveWgIxhXlb6b/XpY2m5M29cAYJWp+uA4kNKWGXcRemVsReujg/BmWvI+Y
 c1HpbKBEuPNN93KOGP1Ri4bO5yez0YjDmpn3KBnqUOJ7R6C6GpNUf9teuXb/DgxT0O1ilxTeH
 +XTepRKrRkdegOrGXwmany59Prjq2dNxbbxYcXiAGeG282W97nyirB+4z5Ws2sh7bGs2hcOdO
 OQjqYzt4vFfizboIYo0MzZJpbnU9ubooeI+gM1f4FEDuBQuxy+TdUTspkk6GdU+9amoUaAzYk
 O/acXZvW1CZroJMcreP5JBZZSwbg/OhrgLszoKHibEiePTeDFutOQL7oXJ3oa8cWiyTVHgjF6
 CkRhI/Vyu+veDmpr+A9KY4DB3V6ID+QpX0GXlK+JZt1POmYKnIk9exoXPKUVGzRWmywIyChCx
 CKIZ0oZHN05sFTQ3WCBKyt+erH
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lana,

Please find my reply inline.

On Tue, 6 Sep 2022, Lana Deere wrote:

> With --prune set, the 2.18.0 pull still works but the 2.37.2 pull
> still fails.  There are several of us sharing this branch and we
> aren't having any issues pushing or pulling with 2.18.0.

Oh, so there _is_ a remote branch called `feature/switch-to-qt5`? What
happens if you call `git pull origin feature/switch-to-qt5` explicitly?

Ciao,
Johannes

>
> .. Lana (lana.deere@gmail.com)
>
>
>
> On Mon, Sep 5, 2022 at 6:25 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Lana,
> >
> > On Fri, 2 Sep 2022, Lana Deere wrote:
> >
> > > I'm testing an upgrade to git 2.37.2 from the current version we're
> > > using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> > > gives me an error but 2.18.0 things all is fine:
> > >
> > > $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> > > Your configuration specifies to merge with the ref
> > > 'refs/heads/feature/switch-to-qt5'
> > > from the remote, but no such ref was fetched.
> >
> > I bet this means that that `switch-to-qt5` branch was deleted on the
> > remote side, in which case...
> >
> > > $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> > > From http://githost:7990/scm/dp/sw
> > >  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> > > Already up to date.
> >
> > ... Git would lie here and simply use the locally-cached version of th=
e
> > last successfully-fetched `switch-to-qt5` branch.
> >
> > To test this, you could pass the `--prune` option to `pull` (see
> > https://git-scm.com/docs/git-pull#Documentation/git-pull.txt---prune f=
or
> > details), then try both pulls, and I bet _both_ will now fail.
> >
> > Ciao,
> > Johannes
> >
> > > Anyone have any ideas about this?  All I could find on google was a
> > > suggestion that the "no such ref" message indicates the remote branc=
h
> > > was deleted, but that's not the case here.
> > >
> > >
> > > .. Lana (lana.deere@gmail.com)
> > >
>
