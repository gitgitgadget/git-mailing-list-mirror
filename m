Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC73C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 03:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiBRD3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 22:29:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiBRD27 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 22:28:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C5A2A25A
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 19:28:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w3so13126027edu.8
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 19:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VYc1ON1UV+w5+DjajeBlhXlgtYVKFi7a9Wf68SbS5sI=;
        b=L8ANM4qqXR+iVcqTxMnP6oE6Vr+F0w9rC4KpiDnR63ekkt66Ac41nyhahPNJ+uT0vK
         ZLBlTW9NnYStqR2FHC1xyvAGfZHEtAn5UIVVjVJp6xz+OPVlLD2FOqKGY/hyQPw6NF0Y
         SXcO/0Z3B4XTHybgipbHLaD5pXYKcio9L2i5WMepIjs6CgwleSPDuXbajO2QSnLP02lB
         O3g13gJQdRa7CLTQffhRyPuXGVaRxAsg+PhEAbbZgM42FrO0HgQ/SmdJanFm4lnLKi7t
         bOuvSz6LNbzPJCX69toKUrqZBE2O+Nl/VFeH+p92LNW4awRdnCxibWwcuwchPA5gUvuZ
         aiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VYc1ON1UV+w5+DjajeBlhXlgtYVKFi7a9Wf68SbS5sI=;
        b=BiHdH0rmVlSUTO6t9ZWgwgaTrDNTNEBea5o4cGR/rNSR/PTs5BS159Vbs6WqOmY8QJ
         8FblQnHm64ogrcPB5HPYpB4W3iqb7xynjiOzMB3lPQcuOLNvWSy3oqsW+KqrYKJ2uw8o
         NWhOuab3YFxHzcHIWH+X4LO5zAH0wzsx9f6s+yqHVHyPVLQdz20xLPbOmnFZcURIUcub
         rppw11aTdy/iyGCxHPI40hh2Ffs2DP/wNEhcpkJYGYoP1v7ihnvv8o8jDdljWEvzqntK
         OnjEolQF9Qn1fsOq9Ty6mRQVDtVXKwQgBJK9WLaSShfNFYSBu6jC36Ff269cev9LB0ic
         k1yQ==
X-Gm-Message-State: AOAM530GiVON06UVAJJNgyGpDkHM5rgIR5Oxy6+IM+QCtwwSrA0qLCKr
        nCcIiTshUcHI/6Lf73jg9eTDHWTft+xUvOq3YH1ACd2p1L4=
X-Google-Smtp-Source: ABdhPJwk0pcryNonE4kFV8mqKyAOoK6GLOxAKiQm+GyWLwE05Xmr2ao63io/8oZtRy6zCkd0gg+ERIDY2RwHAAkurQ4=
X-Received: by 2002:a05:6402:11cd:b0:410:d432:2e30 with SMTP id
 j13-20020a05640211cd00b00410d4322e30mr5921836edw.119.1645154921763; Thu, 17
 Feb 2022 19:28:41 -0800 (PST)
MIME-Version: 1.0
References: <xmqqley93rkw.fsf@gitster.g>
In-Reply-To: <xmqqley93rkw.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Feb 2022 19:28:30 -0800
Message-ID: <CABPp-BEpQaHwyj_0h5V8tMWSPsqhSg3E42McAow-q50=MNpyyA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2022, #05; Thu, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 5:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/sparse-checkout-fixes (2022-02-17) 5 commits
>  - sparse-checkout: reject arguments in cone-mode that look like patterns
>  - sparse-checkout: error or warn when given individual files
>  - sparse-checkout: pay attention to prefix for {set, add}
>  - sparse-checkout: correctly set non-cone mode when expected
>  - sparse-checkout: correct reapply's handling of options
>
>  Further polishing of "git sparse-checkout".
>
>  Will merge to 'next'?
>  source: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>

Please hold off; I'll send in a re-roll with some improvements
suggested by =C3=86var and you.
