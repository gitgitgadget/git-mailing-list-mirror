Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA920C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 05:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJDFpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 01:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDFpl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 01:45:41 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57D224F33
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 22:45:39 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 81so8189622ybf.7
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 22:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Fary8lRvDz6LmmPh8A3DDgeK8SMre6v6SvjOD7A2d18=;
        b=jfMHwlxpSrLHb8ZRSRnQyh24r4o7d68A0fgYexVUl0WbVI8m9BgYZNLci1sk9XB9Rm
         ptjjN3tXmrmdJjX2SryzYcl+NvqqtsAWbuRLrdBrtBK2sz+sYLpwETUlBUn66xh3zktx
         Td+aQ+Q4y/MCPLpDVv/MqZZuOBMxGU3QVQylgQWsqQmsAwcZw1HpwHbfEntC6SgFePJX
         AxvRljjZ3kdCx754oLLGUgxMSbxgNlyjyEGGQNYTIsJozMCKsAIxraKhQyj0TS7IurVV
         XYKmgwM5BVzWBaz2uCouMWZbuVMVhcTxJVvc7g2lJqbgyPSE4yYERbMk8ML1d9Ns1xwW
         qApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Fary8lRvDz6LmmPh8A3DDgeK8SMre6v6SvjOD7A2d18=;
        b=TqzI1qX8Hu/2qpVWIfERm/AJcZf2gFVKnm/9fhkNlvSckZ1XbzlEJCXP0pFOHGsH+o
         f8S4lS8ui1RafMNCWYban2RFeDn8isFGQ03C5WQbVb0Gqx8ScLp5+XNEe1oB7Kt4fn3U
         wlM9XsddLDaKf3cMqE8G/BMGwZ3IRvriRYkcrCVQTwQjFwHnlByfDPsty+l4BXPXkHaa
         cxdiStks2VH1HrWGXtCUiDa8yEhg2iZJLxy/Dq/uT+k6uwAQIfob3VHYNB4BfRRBj58W
         YqS2PmFNsGFTI8OIQTuw+k54xS2ih6uwDuQYS1m1drKW7Iw8N3bkdkzL3o9GgYUEopnb
         yyNQ==
X-Gm-Message-State: ACrzQf1E9et15D0kB+uvJeL1i2cGVlktsmONl/D8JtHrB8nB5cOpGGly
        H/ThznLnttg+jsaPIhHl1VYLXgm24nFo/jmGCTQ=
X-Google-Smtp-Source: AMsMyM7crgEd9RwHccUQzMbHbaKAXwR8lZFCLgWcoO67WZnF+bm4+1egq2VFnHr4YZUMF3RQ8MZF2wDUqFkyl53Lq5g=
X-Received: by 2002:a25:8e83:0:b0:6bc:a671:3785 with SMTP id
 q3-20020a258e83000000b006bca6713785mr22873152ybl.381.1664862339003; Mon, 03
 Oct 2022 22:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0_TLWTHpjwxgqAjBLpvBo5BntvpwRLqXrndYosEj7tHw@mail.gmail.com>
 <CAOLTT8S+VcbnEehSo7Cinff4aC-LLu6FJ45ny+82a=FFKQVxwg@mail.gmail.com> <YzrtHLAu110L5oqt@nand.local>
In-Reply-To: <YzrtHLAu110L5oqt@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 4 Oct 2022 13:45:27 +0800
Message-ID: <CAOLTT8T=HK-oYbKCdoWt+iyb5=yN8SOiL6kgynJFggg4UqF68w@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 91
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        lwn@lwn.net, Glen Choo <chooglen@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luca Milanesio <luca.milanesio@gmail.com>,
        Bruno Brito <bruno@git-tower.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tim Hockin <thockin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=883=E6=97=A5=
=E5=91=A8=E4=B8=80 22:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 03, 2022 at 09:41:30PM +0800, ZheNing Hu wrote:
> > Is there any videos about Git Merge Meeting 2022?
>
> We didn't take any video recording of the Contributor's Summit meeting,
> though some notes from that meeting are available on the list.
>
> The talks were recorded, and will be published on GitHub's YouTube
> channel in the next few weeks.
>
> Thanks,
> Taylor

Thanks, I'm looking forward to it ;-)

--
ZheNing Hu
