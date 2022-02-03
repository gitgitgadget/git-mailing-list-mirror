Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E2DC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353173AbiBCSP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiBCSP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:15:26 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75201C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:15:25 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i186so2947752pfe.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y2xGRVLLKNmDGp5y31ZyHinSFmn60QTmXvqf1y6SXqQ=;
        b=dU2Ofq0zH62i9M6oZWlf1oBHVpEfjmg/WAE1lwMnySfx6CAJ09hpHHCuxvyq6Z3OnM
         kSjR7zCxZzHelLy014tSTzxZVUWx59v5ID91RolZw2uE9x0ZZD+r09knh4zeCyIOJye2
         +oKPnqz28g0VlwmC9RoSi4CDv+V26QdPXdSUgVUPLeTpBs3al0CyPKRfgrFHMaYz5Vw9
         WftDkUMLbf7y4/FugSfxamjEx/+4aya/OTAP6pMmfoJE2o7Ka9zhBYgc7WMXALVKHyBi
         ++U/P5oXvZSfSl4r/FQdjJ3x5btQBudQYq6QjdRE8Iew+9k4FhwFrXl6hWRce7twu/U3
         Yw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y2xGRVLLKNmDGp5y31ZyHinSFmn60QTmXvqf1y6SXqQ=;
        b=VgMsHkQRPg6Hy2HMg6N+AKP9ozx0SJSMgYVnoZffupml1QT/ACXe4SE8EjlDo4ZV3f
         /xXjvgGhcgO392JYUGKT8xPmls2p5JcaDCifo1T8IDn3OSXOmRQyvzbSsScbraOGrYBN
         M3jsB1Ak06X6mMLARqTyJoavQhwSQupqNCnWd1SpK0BLuZ+riDx1oY2Yy0IEa1p8Xpxb
         iyTUN4HAg0is0kZWYNzuL3uGs6tUHgLP6mZ+8IF2k2G96cP2VEG1a2iOb+6Pg1p7oQWO
         9M9KL6x6Rtu6FQX8PyJXca3p4vLlMZ/da84XhKAbZgwopF4T/vCjau0Jdih+nMkIA/Pu
         ACAA==
X-Gm-Message-State: AOAM531HTIL4lCbtdOZXoCCyCii2TbYEwNDXdTBHC2qt4x6N/MA3d3d5
        ZD0zM1sgQj8RIb4xiG53gzQ=
X-Google-Smtp-Source: ABdhPJzq8hoxlFfBRDgJJ4sclsOBK5u0Qw9RCU3KxQt7V81SQ8XzhwcAXs1Gwffe3goAEkXp6gkZSg==
X-Received: by 2002:a65:4c87:: with SMTP id m7mr28988295pgt.509.1643912124965;
        Thu, 03 Feb 2022 10:15:24 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id e17sm18808103pfv.101.2022.02.03.10.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:15:24 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     =?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?= 
        <avarab@gmail.com>,
        =?utf-8?Q?'Jean-No=C3=ABl_Avila'?= <avila.jn@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [Question] Translation Dictionary
References: <016401d81547$728834e0$57989ea0$@nexbridge.com>
        <0c47248d-13b8-9d80-b03f-8ac6fd4ac91e@gmail.com>
        <220203.86sft05kzm.gmgdl@evledraar.gmail.com>
        <02f101d81901$c1ac8400$45058c00$@nexbridge.com>
Date:   Thu, 03 Feb 2022 10:15:24 -0800
In-Reply-To: <02f101d81901$c1ac8400$45058c00$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Thu, 3 Feb 2022 08:27:08 -0500")
Message-ID: <xmqqwnibvmtf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> I would even suggest that gitglossary(7) might ultimately be
> deprecated particularly on systems without 'man(1)'.

Yes, I think the entries in the "git help -w glossay" are good
things to have in the dictionary.  I thought there are folks who are
already translating our manual pages (perhaps with po4a if I recall
correctly but I may be misremembering)?

Thanks.
