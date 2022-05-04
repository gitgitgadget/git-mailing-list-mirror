Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CDEC433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352190AbiEDPWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352180AbiEDPWC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:22:02 -0400
X-Greylist: delayed 850 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 08:18:02 PDT
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [5.45.198.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1C543EF0
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:18:02 -0700 (PDT)
Received: from myt6-d4eda2ca0046.qloud-c.yandex.net (myt6-d4eda2ca0046.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4e0f:0:640:d4ed:a2ca])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 374BB6CB8085;
        Wed,  4 May 2022 17:51:11 +0300 (MSK)
Received: from myt5-aad1beefab42.qloud-c.yandex.net (myt5-aad1beefab42.qloud-c.yandex.net [2a02:6b8:c12:128:0:640:aad1:beef])
        by myt6-d4eda2ca0046.qloud-c.yandex.net (mxback/Yandex) with ESMTP id uUO5jHdnpe-p9gqU5cu;
        Wed, 04 May 2022 17:51:11 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brilhante.top; s=mail; t=1651675871;
        bh=LhiPTwxJ/yU0dAC4+t5arN9qIkTijMfhB85E54NVKs8=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=GOgPPMxXjxNgxurOOReaPvMUGk4YBfWRq32Rv/Idn0yw6uXTFlptgOMwgHWpJ+9VP
         MuJV9FyPNATxnKrlwR8QdTemdYBfDWLj9JYs+mC0jF/mMKEvSlFEcmW0CkFj/oJMSJ
         rpXhBOo2KDj16F9WzNQ0Ii5NU+zmcgPGHeXRv0yo=
Authentication-Results: myt6-d4eda2ca0046.qloud-c.yandex.net; dkim=pass header.i=@brilhante.top
Received: by myt5-aad1beefab42.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id cdUZUf0qDX-p7NqQQKV;
        Wed, 04 May 2022 17:51:08 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Wed, 4 May 2022 15:51:03 +0100
From:   Daniel Santos <dacs.git@brilhante.top>
To:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?B?RMOtYXo=?= <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 0/9] Incremental po/git.pot update and new l10n workflow
Message-ID: <YnKS1zIr0YAUJ6N4@acer>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <xmqqtua5nz61.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtua5nz61.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't applied the patches and, for me, the prior workflow has no
issues.

Improving the po files in order to not have the 'diff noise' is
something that I consider ok, but still, I also don't see problems
with how it is now. So, it is the only thing that I consider an
improvement, from what I have read.

I believe in eliminating work for the translation team, as much as
possible, not in increasing our work load.

The translation file is already big enough, in terms of translation
needing to be done.
