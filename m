Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA26C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242415AbiBYQAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbiBYQAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:00:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7EF1E64E1
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645804795;
        bh=055PTez9+a3XR39oR3sllw73m86OzmqGxIq/Ql5CoIQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ok6+m8UdlPMJhZHv69giazDYyT8iJoBvdih2lWZkS3Mh83NydAlNfAW2LyKcFq0rU
         I3GsfzeBP6LuI/y58V2rE0JRyDo/n2BlG0e/742jwUJvvRMC5E4OXipnZTeE76euMy
         5hP1bOF3hNlfsP0y7G76eeE1lW41GAUE2axjnicc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1ncOAX2sAY-00NgqB; Fri, 25
 Feb 2022 16:59:55 +0100
Date:   Fri, 25 Feb 2022 16:59:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 00/14] Finish converting git bisect into a built-in
In-Reply-To: <CABPp-BEOX+zxR9-yyx-EaiOV-Z9yD0YP_Kwvu4iGB8enz40XXQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202251659300.11118@tvgsbejvaqbjf.bet>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com> <CABPp-BEOX+zxR9-yyx-EaiOV-Z9yD0YP_Kwvu4iGB8enz40XXQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BAPde2oGO5qAraqWLH3ouUWRQ6YdhYa0WRI4VILULpUWUjq+AZ5
 0PHjSoYQLW+0P1M3jCpo5fuOeuh/N8OMhxIt2oM+uj2oy/PJjhbW05CpQtq2lKcmlHt0e03
 UTPpWwWzTQv4/wugaNXi9jnoykePVzG826VZgrgtfEyxGA3v6mMC1ItfoBBO/nDA1vVetJk
 vc8mLIJYrh/QRoHganqig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KANceJAidio=:fFtMps9k4yk3RwSdgp7jq6
 xz/Jj6lh80BviBWtBi81X/2UVYq+cSiFABeWu3NkSxUy1hpC/CDEb4mXqG+ZyJZWVLGlAlisn
 KXka1tNTjL7dhT18KGI50yoYC6pcoAMRz0oQXglgoIKlsFsuZLSwNQvB+h9r72Qk7ghYDK7KX
 fj1P4JWCVh8jEiWIU0G5pEwjHJM2+B2Mgv5sufXdsHUcQ7OavxiLUnGTirnd+QHeBtL0Nf0Cz
 PlUgqE/c7hD5v6/lvcJmBcd7nXCPv83QSzqjf7aP/E4PopCH+qhz11ZWdZkm0VaaKGccmpTKz
 w0QSLUi28XbXOCJyVOvO/OMexF/4TGJZ7+A5YIcFDuMACGmpy8rSSXa8Q3YUZYAz9kr6r/Mku
 rl8Z2Ws3VMssCA0Hsp89f3g4kIS37PqqVmLSWsOTGGnEABfFtYx7levPmssXXDquSt8c4/Rqj
 GV5WstYXaDGKx2k1Fn+QFDsNHNecCgjBNQA3N+gpYFu0E1KWxAXtGb0CEiFqylsqMJXQrybha
 0uwLFvdTJiBvcgvMahjh7/icEJ3E5CmNwBEm6ewB+QYVHrOfDcoRWsylIJpjjA6N8+kh+4/E4
 0WDnkFJDicccoeDxfWJkIw1tB4LgAQg7rIAUJIKvfV6VOq4JD+XZyjqYz24o4kF3Q9EKEwj0D
 i4s1YcDHNUU0NSARvAihqmjfw7jH58gC6KKc7R8z5PT57MQQCt6kmUQ1IVzVKaRVsOS/9o1Qt
 mXP3gwW99x+9ULa/cCda88b18WC1+K/cKKkMZYBTQv5RowWlsf5n67DA5o59IzKenmsGp7DcG
 UJfi07gFf7iYiuyLWJ5TxuJoRQ1eM+JvpCyyh/oCINloODS/vF1X78l7qvS/DcKSlVv/L76Q0
 ZRB3F6Ii9VyBTVljRwey/IUfDzE2sN0oIw4k51kscfJxUzjp42SHn+wk0WW2fqg/cZm11To5g
 HYbzqDMsANFAF93zqR3m8hxqHHUyl6wDmoIZFdgS/gcUYiRXw3SZt3WsI8WIy3eV6r/PPQI6A
 eRrznRX5ODCaCiZUrtAwfkRGt8h6i2m15yV/ZfADVYnLqBNmarV+N1XrjtYakkgXu1nGPnQVg
 7PFJwf9mvPpZjA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 22 Feb 2022, Elijah Newren wrote:

> You've addressed all my feedback from v1, and I've looked over the
> changes and they look good to me:
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thank you for helping me improve the patch series!
Dscho
