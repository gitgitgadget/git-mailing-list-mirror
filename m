Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE978C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiCAKLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiCAKLK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:11:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D8723D9
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646129421;
        bh=QYJk+AX4SZeHITA3WEWKt2u/GUon8UglO8MU0JQ93z4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BEcPQ1C0ee/7Do6/xM4N1+PmQ6/NaKg3b6N3o9g3OdzPtDhqx9+rDksHR5olCWuMT
         HwIUQYn0wZhSO8cHcblcoGulXZLyMtXRhbHGJwmAHvza6dD89fF75AvdIgh9zFCDYr
         Uxplb2c1iOgRmI2mSgoQM6m0HTdPR8HUVZzNsPew=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzfv-1niOxw1kz3-00XNh4; Tue, 01
 Mar 2022 11:10:21 +0100
Date:   Tue, 1 Mar 2022 11:10:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     phillip.wood@dunelm.org.uk,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <xmqqzgmd5uzu.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203011109050.11118@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>       
 <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>        <xmqqv8x2dd7j.fsf@gitster.g> <xmqqzgmd5uzu.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9h2rzYVm4xxqsfVmvROEKRCIN84o+ovzHfcOTJnhmDklAaw3Q4S
 F/FnRKuCs6kg4htuEdIKZBjdMmYjDM8nJ/5pv/a3meIYtjH21PeC1kuCpNjX+/arAzV64IZ
 DQq7pfhtJF1hd/wY6Lgc0L8JpPmN6I+MGA1QLASpsjC1lBM3lbhlemOVs59YQzWYBDLziH9
 JBrFSTp2GY1Pfy5myMyTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sdz6x+ODK1E=:6D0/mhsSvVK1tWuYHztqhT
 XjPxL16p6pldLBip2PGgd4hU2byM0MW7n1zFvf3AL84FU/uQR7X8AEVWhRlBLqyRQhaxG6s7i
 JFlbjczSDxTQaozHk+vLNrQLMxLEbX9PTZCjh7h4LahJqlg5nfuX2An/zbSwJY35bMizeRSF5
 TszrD1lfjQfk6qZK+l0U7Lf3VnGXmMaV1NXQzImnL4DSI8rNNx4Z/jJGQYAKXSTEHMX1bcF9I
 9o7vT2IIhrRG3UkcKO6USSScJFVjTYmVs6qxfg90md/0lhz+SBc4ReqtAKCzaQbSMg0QcYvCk
 ATEn33afjX/BshIVPbFKrpErzmr32s3Kg0UJyPKXsd5vBtKK5ARQhe52DoDExNX4sgtrUQUuG
 vuUnH4nvIQjC2+9nY+yIDRNH4mwXKz0Xebro0VIJgt24VUQ0iO/sy7iGDuQb4Vi7508KL5X9c
 +24AjmIMmfKZegWwkmlZSmZNc5qxQXJfTPXpGz4Z6kkMddQIzRS2Cv8Pp5/LOlXuOI8azSzBi
 ACv7fbWQLedv+JWzzZuKvcRWhxr4KFVQ9VB21bW077rGdNFRF8E3YAXo6xE7Dnek/1XZif8GF
 y2XGFtxD8QGxyvMjHjL2tMjaxJ/n7sCaTBZ5Jb2E3hjDR7tswvURQJ5vxUgex3JTrMk7AoWEU
 KLizqxO5PhIXtm2C1JbThbkrXiIQ6DB1JDo10fTaU+idj54LOzoS7VS+bC7XNVjUqYQSPEzqB
 YqcuHR1RRdq3V7NcDEzkLXZVO+fdNOTrms4TZrt1+wMybzpWycj1MWuKFpzRjqAokmUllXvpt
 D072zhx15H/XbT3fNcvutXywaafcZIP80g6O8GlUhZtB3JcMOZgBuquGwJlcx6/NvWuX05lLS
 MTU7PA3pV+L8W0qDWwf31vZo4HpjGhNWG1IIYNUmR2nZ9BK7RdR8aBxvuZG4DRPKV8HMrIE1P
 dwnI89n1Oqz5amNNsTV9mvZ3o2lFukLbZDWEsStxMQImU1bxPV8hLZGNwWngixccCKDccALuG
 AOhLg1PlTdiZvFN0thdaFdT0GrC+6XPcIJ5+x0fCNjFiTc4FeRq/JVL6Nb5OErmu5Bo9yvk7n
 q9zSiGsvA0D11k=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 26 Feb 2022, Junio C Hamano wrote:

> When I highlight a failure at CI, I often give a URL like this:
>
> https://github.com/git/git/runs/5343133021?check_suite_focus=3Dtrue#step=
:4:5520
>
> I notice that this "hide by default" forces the recipient of the URL
> to click the line after the line with a red highlight before they
> can view the breakage.

Yes, that's because line 5520 is the header of that group. If you direct
the reader to
https://github.com/git/git/runs/5343133021?check_suite_focus=3Dtrue#step:4=
:5674
instead, it will get expanded.

If it would not get expanded, that would be a bug, but obviously not in my
patch series.

Ciao,
Dscho
