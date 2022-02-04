Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3D0C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 11:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354050AbiBDL0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 06:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiBDL0o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 06:26:44 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D6C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 03:26:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ee12so11704684edb.8
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 03:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CFdLoQ1KQJmGHonoGsfe7eTkwe+CskHVHpBBYhwMQGc=;
        b=d5rHHxgqEQwI+oYTjbqa6Od3zvet86baAyyC2Dl6kyCu4rNLAsFsqqwFZAlJNagRo+
         g8O6OZx+S+FpyierBdx6TuoVLCgyxK1copvtIWPfW+wxWedWnBQxdbFboAzwRe65uT4H
         KNkmbLfEXvneB8ckKAS/2aIxAlnajJZaiDJ0Z8WgcmRsL8dsuZCrkVoEthe3Y6NtPlmG
         tzjlwfGyTpJz2ioSWJDzWf7dPykNq1iFXeKv5sf5PNqE5ugfFEcYQY9Gk6AycWr8n8nt
         0pyMMgskZuxmbnSnezcRniqYFsYVDg0S5j0A6WfeDsspVHVz4s+ICxMxnw/LGeyVeSRx
         m1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CFdLoQ1KQJmGHonoGsfe7eTkwe+CskHVHpBBYhwMQGc=;
        b=rCTtfb+5EzzLiCXM2Ja/0uSlw1O16HG/ywuZlEiwsgPbWUYx/C7zOyy4SRHt7nqTYs
         4nu9sD8i0OqDDlemorNZFPdtGHoIcCm1CYWmyBuo7jUSKO3gHlepHMw+U759oS+o3sWh
         lSrDzy1FrbmPaVCRVcKKUCKUZf3NfJspeLh/dxNnHRTmQoYjaJm/u8h1NlGYZmNnekeI
         DYb4fFDuSPq3k7K1J/sP1+yko7eS+xBykZmJ4q1KF/XdbupMEurwtwG2UpivtYcLSeUw
         Lk71POXzV+XB7D1TVOvgYboRnaYyBXjbHzUc2YwdoCRS8yt9JfrsUPr/iK+Iq9QD1q6S
         M0BA==
X-Gm-Message-State: AOAM531DdjqnDffuEsCjQpzqCUSeddDRO/g1a86gAod0f35sPp2QN40W
        2mHrA9DFZRGU6EPTkNTm1a7HYhpHEguR3g==
X-Google-Smtp-Source: ABdhPJxz8HSBzeWV58BdQn91DmJo0lqWOT9Qj8hy5frmviqNFRaRGZ+s5N1jy3+y1QjOysY/oJA1GQ==
X-Received: by 2002:a05:6402:4313:: with SMTP id m19mr2583111edc.332.1643974002366;
        Fri, 04 Feb 2022 03:26:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b16sm549101eja.211.2022.02.04.03.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 03:26:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFwjh-0061sk-4w;
        Fri, 04 Feb 2022 12:26:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: jc/doc-log-messages (was: What's cooking in git.git (Feb 2022, #01;
 Thu, 3))
Date:   Fri, 04 Feb 2022 12:25:57 +0100
References: <xmqqr18jnr2t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr18jnr2t.fsf@gitster.g>
Message-ID: <220204.868ruq50um.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Junio C Hamano wrote:

> * jc/doc-log-messages (2022-01-27) 3 commits
>  - SubmittingPatches: explain why we care about log messages
>  - CodingGuidelines: hint why we value clearly written log messages
>  - SubmittingPatches: write problem statement in the log in the present tense
>
>  Update the contributor-facing documents on proposed log messages.
>
>  Will merge to 'next'?
>  source: <20220126234205.2923388-1-gitster@pobox.com>

I looked this over again now (after skimming it at the time), and all
those updates look good to me. Thanks for improving this part of the
docs.
