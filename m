Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1D3C433E0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 20:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B9520754
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 20:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbhACUQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 15:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbhACUQe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 15:16:34 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B8C061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 12:15:54 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id n18so8446613ual.9
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjn4d6wu1LTPt7z6dn4zJd0GEoJAimhnFwNMPBozycw=;
        b=B/tzafhWxGihGi4cn1hvfr90xZMPyiYC3U1eD9N5bSEzsHMyzdlMOeOeHHqqAsznAO
         e5CJOWft0MCWzGDf7nwMeGjk3zkThkBHqd/NTTbtN8kdhsn1rRixDHAlwOQ6s1FOj3EQ
         pWXoSDkZgYR+6lxvzI6B7ssLDfDH3+U26CxvurCwsWA7LphF91AT49WNsJyz/My2OlAi
         P19UCbhTL8BGQ9pUkSLLFMQug4Bp+5X4fxxnOfA6c+/sFbRY01FU45eHMh+GdnfLL5dR
         uyMawIxLy0hkhrwQlnqFszkDLgLcnHBA3Bsny1spUIAjrYl0UVPosaUBFFYeitTgB4re
         5Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjn4d6wu1LTPt7z6dn4zJd0GEoJAimhnFwNMPBozycw=;
        b=l5JrCbXbaBzjlQrzb2/0ryYZC4+x2dcJd8vRmfQ5Rt8pPkXEBgVbZuIK4tz+sm7teJ
         3m4V45O+GI/KVWXnu8ppbybXBMoDJYPnz0NedyfMP1m3vKH3SiD6j2x6dlPoFEqAyCOB
         xJrgIndOUXbUq3iQRohxQ5YgXXNjNuWrsvaGKPgVvaZvAK5PdVMm8bvFua3MHy43IiRS
         a8Wo3+HW4bJRcGhawL6avRB+8wM9sBIyz7n4PdQ/VOSP4zLI7bHpP85QO64Ayyd3ujGm
         BBSS2Ff9w/Mst0kaWAgcRW/iwSPvDfqeMr5HMed7j9caTPK7oK/mEF5+QJhDl8ROa8jc
         r4/g==
X-Gm-Message-State: AOAM533xH0ZNc9quXkjSFvrDhMBLV8KJGQ+i15fXyA1UG/wensBaiKFx
        4TOtDa1/Rkhv76owLiXqBvrEGphUyongD/wYJIk=
X-Google-Smtp-Source: ABdhPJzn3VrA+Nn4mnN+wddVCCaShaI/B4YKzSOkgT1v7t70kmz1K0xxmAS6RI3hvZwpHE5Z22iYCF7lgfNMCpZXnrM=
X-Received: by 2002:ab0:3b59:: with SMTP id o25mr44553798uaw.62.1609704953573;
 Sun, 03 Jan 2021 12:15:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com> <pull.942.v2.git.git.1609695736001.gitgitgadget@gmail.com>
In-Reply-To: <pull.942.v2.git.git.1609695736001.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 3 Jan 2021 21:15:42 +0100
Message-ID: <CAN0heSpGyHKkiod6TE5jvVc_Y2MTWVY6DLS1Dg4FvS_m71Gs4A@mail.gmail.com>
Subject: Re: [PATCH v2] gitmodules.txt: fix 'GIT_WORK_TREE' variable name
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustaf Hendeby <hendeby@isy.liu.se>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Sun, 3 Jan 2021 at 18:42, Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
>     Changes since v1:
>
>      * added Martin's suggestions

Yup, this looks good to me.

Martin
