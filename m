Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2570AC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 17:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIGRoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiIGRos (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 13:44:48 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0B13F80
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662572666;
        bh=nX4MGhB/kmbgg7/MNV3ZSI2hSLt0OHtnmvBD0FBuuwQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UOErLkLgtdpchwfaAiaTKzDcfmXVDWn6JpukD+3Y7Hcf3ArpKQswimg+euyhbQFYv
         V51n93CBYHwyr2XJtuYXH6dP/ckdygF4OTezLZizeeHZGqFpSzOl4OxGdFcWiWJKVj
         DlHpt1Jbgd/IzOSR7EjhZxSk2AdLaYuj5BYLkXso=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.25.52]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxeE-1pBfd43HEO-00kU7d; Wed, 07
 Sep 2022 19:44:26 +0200
Message-ID: <05a52191-89b0-eb55-e6bc-1ed2642842de@web.de>
Date:   Wed, 7 Sep 2022 19:44:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v2 0/2] format-patch: warn if commit msg contains a patch
 delimiter
Content-Language: en-US
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
References: <220905.864jxmme0a.gmgdl@evledraar.gmail.com>
 <cover.1662559356.git.matheus.bernardino@usp.br>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <cover.1662559356.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v5iV/cGQZj0l8UG961+Nnt7i34T4LT6uuLapWd9rE1PyzoY4/1k
 pJeO6Muc9odhN1nNJG0/xPsBrr+pjSFBkFxpWFeuYLk/8hAsTXR7fPi+qlpyTWnIC5LYWKw
 0eDCxRCHTcgTOaaMhcV5iA+EEmfUv8Ja/3pnvXPo0g16pAUaRm/rbbZqkiDmVZB0t3NBgVK
 80TuE7bJYXrPrxlyNMMdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cz+wemHSRvI=:8oGWJcTzPmLhr4qVOd0YCt
 uOvNZwmcn87RbomjE+dunAh9VeqgX0aJMhZwXyk1nrpS9oZzduJE3UWzR6EU/Qgh78T8Np/m+
 3nvh6D4sYyjkh0q9SZK1tLMcyC3j/Q651Cok+6jKgyIqay91dLiLphCwvtZtAgO77Lbs4HTaU
 J+GYOLXAVJ104AqbisTdDc+JVK5j2v/LfLneyU/Zorp31Gz2gQ6J/idawUaeLPmh1yBCoN9uv
 dzyxPCVrFE5aEKg5gENVunbi/Yb0dK7SHwo1qIoY+2hs2sWcwvmZm4bR6rCex7XIOh3IuGV4Y
 X30GifljyTTsCeV/W1KrbHOTgLMMNvsWJCdQX/ORCoHnen7MU6SvlKGrjTSCBN0Iq6O7AlMTi
 0zX5XcPaFpFDGDbaoHLIMrBGM3b8rGJcNArI1BuBSSOH574BChojFEqFJosw/s5YJz0hjdLqW
 EfEnDF/YeZFlPTtuUG9sXBSICIXg22cWQ5bUK3FO5YdPfssagWf+vs5vLi/scjqAewZN+P7Kx
 YufIQzjiFqi0eCB5Zf8Ab1dQxZUGqbKb0nfbF99tuWd4W3myOQwcsRAcNOHTRek/QjdMp4vkM
 S4ebaC/jAy3R8aMekVOMiQ2+D9TwM8FhRFepbptK3e7XH01I2hSMo+hd3nuHoUMCQ41RF+vMk
 0mFmCG1sjPUtKut8UBu4x2mLlZd3ESyonojMFMNjCiUVnkqmq5kem25GFDVtmB9UtcTnNXIN3
 clxHsNliHBFbNCjC3hxuB2RaA/FnBiZDIBSlaq5neUhkf3tHxa1vXa759/7s1ZfvqAEDEjEQE
 3GejH8bz+HvHWczHAX2DXwXx/HMkS0HAqf+Rmq1dMb1FKivywvMEmOjIz7nyJkyy6k0PwgwiW
 Ly6tlnuw9/SUTn67nDMkbIFQ50Z5fjccb+0f6Q9GpKAav5bXDYeni7bgxxI01yZ6/7w4U9tls
 FAhI7hQCIl2n7xjP6z1GxWPU2fH5ywqAFGLE1NOqsLnCxzNV8qsCIXoXJmT+vJBoxs89WLfoz
 yfAjeUDLnY2YmBLffd4S3KkWQO8/HWmEye8spAi5b73+eWIF5z0EFXMgn/dh8IY5zEVklZuoa
 mvAOkLx3I0Z9d4fSw9KJlmpHQDH7iP9Q9m1u8Ng6qpx9mDn/BZx2HRIfevHgoODDw5+d9S9hl
 anxzE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.09.22 um 16:44 schrieb Matheus Tavares:
> This makes format-patch warn on strings like "---" and "-- >8 --", which
> can make a later git am fail to properly apply the generated patch.
>
> Changes in v2:
> - Use heredoc in tests.
> - Add internationalization _()
> - Incorporate Ren=C3=A9 changes to use a buf/size pair.
>
> Ren=C3=A9, I added your changes from [1] as a preparatory patch. Please =
let
> me know if you are OK with that so that I can add your SoB in the next
> re-roll.

Fine with me, but I think they are trivial and you don't actually need my
sign-off.

Ren=C3=A9
