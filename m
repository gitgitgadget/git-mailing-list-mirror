Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D23DECAAD8
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 17:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIRR1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 13:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRR1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 13:27:07 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE88C186C8
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663522020; bh=EOPw11yu1Kv7HtImtZNEXceBgtXMWUeSkRoODf/1oCw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ffd5OW2h4JLcebKrkBNUV5NT3Hh0UG9fVb1sX9JeFAP92bfQCQKWBw93FUf2RmCy8
         IJN9rGAd1kF7IfVkPY+VfkslFUhEohRzXRgDYEUed3Im1uoZbiVMRPjQ2Z6RA1H9K4
         TkQwJaCP3lqdIhQ8ZIJbG7MUBja+RpTm1G4M4M2o0/tI66XdlSBZ+HzuS7Y6TjFJHj
         wMGOXp7xYG4QVQcaKMU1PEJJ8+wmCWF6vZve45RyZlTqyK3R5N6X8pyGCsx8nyBf82
         JiiQdImcDi21CpPkNX70qlYzdWBcuRVejcVb34yiJM0jR1GmUf8Se8Tw3XhwPL0uRo
         2yGcOS//wl6pA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCEB-1pUORj1cgN-00w2AW; Sun, 18
 Sep 2022 19:27:00 +0200
Date:   Sun, 18 Sep 2022 19:26:59 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2022, #04; Thu, 15)
Message-ID: <20220918172659.mjkvdpryr3iaitys@tb-raspi4>
References: <xmqq7d24kpck.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7d24kpck.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:L7QkBuhsAmVBHKDzozOWYepFeei9HY5TznOfv63GpxaSmHbahIm
 xEf61PRVYGC4Q6sfSa5/Jj+s4PzVKKvfbNm5n89a38ssPj7zMC7gI6BnEol5DBZd4oZB/zC
 BQtEY4aM7ThWajaOmCmuOCA0R3wEweijbh4nZa+QE0z9VaZKm8DXYjjrHIoRCW2ve7yYlMY
 UShU78zrd2ihVIWQnURnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QcMBEFMEK+I=:UqeuzgY8FDDOy2UonMAohO
 42tiMqqiGO5GwidaQ645o+8DpeVeeqk/EpacPomD7kbL/FUXqBNSXVrH1wSlzzjS4uBdhl7Uz
 rG3XpfB9xtFyHXoxYvtnaFcKRwheWRnXWU8UEE02rdVBGMLSEoyn8ikACFsCRxWh6S0SlTwNW
 pNlv0m1xECvQorsxtOS1+f/71bKlbSZiv32W70q6IhU41j/rh08cw0e+5s0QkOm83JrFq0Lhp
 MUzIpGx+hggc5meFZpayiwiTxluH8fuecsqQaJ7NlL4Uk6y3ldWbX18qK/OylBKOatGOagX+Q
 GT83roYma0/HOwntLHoy2vymVhf6Wj4JbVCPlYz9c62MKMd6KWXQWoMqptUDtcc6mOoHtmDsk
 CRiIRR9j+V/tZIh5BtHcr0hEsEY0l4TMbpYnNpGRt/+kw0D3iNoHXDGfXG1KtZ76idrdeQNSp
 C24rCJWslsEfBcdh4142qKxZNCsxuXw+QkkD8JtDK4Ru4RJD7ui+QvTy2BoHhJHYfP9xFQLVk
 BSVpF3tdN9hdKeS16/e13E3FvXEVj3F48cG7gIsGdeZ9ZyGGvyBq+qMDbUbfN6UGUdeS2POxZ
 C7ovSxd84cYZ2FoE90/e7EV1IIdZAgEoMmo/r/wB7K6UNKt2fxiXaLaKeTMLH9VcAJ813Vd36
 MP6Aj31NX7FNlrxGyI3hdxEYqeFWioH819Xom2Op8KCh/TLZJj4KicM4J7tfTnBa1cQFUWGPo
 +NegmCCcPAcShjokO7Jl57GqqlEt73MVwIC4fK0UeXfOGw+LIFBW3biDMS5eYU2gWbso9v4SZ
 +q1dnBJ7vhzWN+mA9Z1E3bTHoPK32CyJNzYPU4lJNVfc19NE9riTFbenFVnrp9HvObWmilluP
 VJEMB4EWATwiGUbyEjeqU3ShGB5Qz9PGqEB5DRYn4pl8urWRsm9PZnacxu92mJw3+tFTe2uVc
 GYd3SjWjzKNiCn/uM9VvV3JaOx3RZYH1bd/Qag9PavEoMQ3+bw1HLvxmLZmsGQuGgiXashCQD
 yllgWrBvw6xWHafAoY5AmauPBO/AMBhmaDaGFQ2LMMCjQ+clq/Ku7vxz9hi5NJPkTtQE7CQhD
 G5NHgvm7DxMK/4Jztg4/M+Dww2frEcGfwe1R/Ru9vxiQyFo9P6knHEr2GDsG+Wr5G6hroUMne
 dnv64=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * tb/diffstat-with-utf8-strwidth (2022-09-14) 1 commit
>  - diff.c: use utf8_strwidth() to count display width
>
>  "git diff --stat" etc. were invented back when everything was ASCII
>  and strlen() was a way to measure the display width of a string;
>  adjust them to compute the display width assuming UTF-8 pathnames.
>
>  Expecting a reroll.
>  source: <20220914151333.3309-1-tboegi@web.de>
>

Just a question:
Is the patch good "as is" ?

Further developments need to go into different patches anyway.
/Torsten
