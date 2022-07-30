Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24982C04A68
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 13:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiG3NcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 09:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiG3NcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 09:32:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3125914D05
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 06:32:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so10952428lfr.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=sPc6vrYs2IWLego9KeWZtqcn8vCtn01DuDmdnxtigsU=;
        b=MkNts6odP7vihKVEY4TpJv5GIREY2Gi9XmrO5V6z5am6bSeQ7YjwNid+IjfxCsSBb0
         C0nWUdF/GWQp3Sdw5bRGrgAbUmBH2yAjgxa7lF37+32we0YZ7cz/m7YE4QCWI7xYR4ny
         oOZESL3YVzH6dGOnXYfCHqfdeg0Yv4hLHfEAy67Iaui/VKuAqYmWO+ezNu5flr8TwfyY
         M/Xjzk6UpHFo8v45RFVpIfE+N4+MFtlHT40O8yePxbmAqWTLo7LZIhRFqL+Ruggjh5fA
         yjr3ulvGfj1IRPYvx9pLW7Ut2UVwowQd0C8XKY6X05zwIEIapbDarPgCGOrUnfC62kOG
         C0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=sPc6vrYs2IWLego9KeWZtqcn8vCtn01DuDmdnxtigsU=;
        b=u2P7KdszqzxBoSQxUi3zr47kN5/qEciSlhS+N+kcVvw+p6N0NThHlWlRlgzaqveH//
         O/QNo9uUKN33YOonZe4Q8eDRxvwdXrdepMztiE8TScCrHX3M1pY+T5WBzeZkC8zHR7fM
         Y0teUETxrKKGyWY7ad2dpC7eBclFhKpdajvnUCQnlsUfmQ7/nI5eFa9ogRLFBxAhsK/0
         jr5nxIcK8zfPED7RHbOsXfQe8GWswzbuUGvI5vTvI/g7jHWR943ExLhkUcI8gfLuL40t
         hx1j3FRBB+AOeuAYO2pBMJLhlsi3UtcBx0Jd7O04bcZiSedr7TQu9MZe3i9WA7lACHX5
         dUWQ==
X-Gm-Message-State: AJIora+V//d1LTKsc0tgNpK6+dPHXrliPDD+jWYd+IfiAYX5Wwu26SrF
        wmrZ3DKTmJz1lP1OreICvUiHohk8oluvzi03HLfhtA==
X-Google-Smtp-Source: AA6agR4Gb2zoCF+/qqf9R/cafJNrnKLRtmwZqL1dStn/dyfoGPu7dVCtiFyT+xQgSW4Ymt0vtEYVcL/MTfGmgeLY7Mo=
X-Received: by 2002:a05:6512:3e27:b0:48a:87d8:8ce6 with SMTP id
 i39-20020a0565123e2700b0048a87d88ce6mr2698661lfv.385.1659187923269; Sat, 30
 Jul 2022 06:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <patch-v2-2.9-5f07f87710c-20220729T081959Z-avarab@gmail.com>
In-Reply-To: <patch-v2-2.9-5f07f87710c-20220729T081959Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 10:31:52 -0300
Message-ID: <CAHd-oW4QO_Ron6csvgbxvH2to0sbBPD8aEJ0q=xTbRY7Q5nR8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] grep docs: de-duplicate configuration sections
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 5:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Include the "config/grep.txt" file in "git-grep.txt", instead of
> repeating an almost identical description of the "grep" configuration
> variables in two places.
>
> There is no loss of information here that isn't shown in the addition
> to "grep.txt". This change was made by copying the contents of
> "git-grep.txt"'s version over the "grep.txt" version. Aside from the
> change "grep.txt" being made here the two were identical.
>
> This documentation started being copy/pasted around in
> b22520a37c8 (grep: allow -E and -n to be turned on by default via
> configuration, 2011-03-30). After that in e.g. 6453f7b3486 (grep: add
> grep.fullName config variable, 2014-03-17) they started drifting
> apart, with only grep.fullName being described in the command
> documentation.
>
> In 434e6e753fe (config.txt: move grep.* to a separate file,
> 2018-10-27) we gained the include, but didn't do this next step, let's
> do it now.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config/grep.txt |  7 +++++--
>  Documentation/git-grep.txt    | 29 ++---------------------------
>  2 files changed, 7 insertions(+), 29 deletions(-)

LGTM. (And more elegant than my previous solution :)
