Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A24C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 03:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FF2610D2
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 03:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbhHTDJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 23:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbhHTDJY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 23:09:24 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56344C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 20:08:47 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id k124so2117827vke.5
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 20:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5cljHzks5oCBSzaA+9RnEWB8N6bNYrKsRSjZjyXXNc=;
        b=hoqMgl+f+TL8f3d7QYEZQ276T9dPkNrYtPcGaUCztpd9FQ/DZtam0pqSx4PcTF5JoP
         G4jTmQ/buPCTJdZ/jC4qs4Unnt1g2lgvczuQryVUXiCmz+3BCAylOTHbVEMFXF3U5+Lt
         RhqK+MlffnSnY4vYQf9BOQ7JaeexgsrPT+YA6eMZPoT8MljmumRvo6hzp2OMlCd1ssEx
         /Uvn+DdoV+f1ZQxz4TrrE0UPXSyGCKUTA8njAk2mL56XuX8GHZIn0jhPTk4uxNaJSs1g
         WF6w2yZOCEECUjiK9mepD21UyO61piBTYz7RxGZ46lTzL3TxWsmj3U5YxHsEMZkswr64
         fD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5cljHzks5oCBSzaA+9RnEWB8N6bNYrKsRSjZjyXXNc=;
        b=nJUV2GKFwrfSyu0TDiD8Kh571hl4PLX81zC1obwqKFTXqoGF29HVT8Yvisu75sKJ0m
         hqYhhPHEEb5Ik+RqOw7y4ylwpdzLyX/r6ii+xEaZKTM3tj0q5uvGzGruRaG7lp342ovy
         aPzzgakIaBiZuTYB9JjzQY2SpJ4cREvAnRrgxpLPNGGBSuojMYWWPp6wEvcAmw/bo1mG
         i9AMgqyD+y6EuAy/CcWHDckkjR9zIBPgkFydzbyB2PTpYs9qcklUO4q6JdHJADSTwiGN
         mY90tsJtPUSHX1OFlLsqnkQRshQJXQoSYpqkAmN2PWl8iCSpJUnQxA5oHrFdDiCpRewW
         e5vA==
X-Gm-Message-State: AOAM531ymDChXUqXDY+YCgjV9QLVqYao2DK5NyAzIIRe8ABHQR/y9zMC
        cr2xvp8eV8zL4ijbq3gNzgW0rE3XYsUgdRw4tIA=
X-Google-Smtp-Source: ABdhPJxMAc/MOtkkt18YefWDWVL5EL4gVoQNJDKhv8yofwMRo4NeFG7wFBSfXRHeoqLqxybR5z0eIT35x9tOzlp/Lns=
X-Received: by 2002:a1f:9457:: with SMTP id w84mr14007443vkd.16.1629428926439;
 Thu, 19 Aug 2021 20:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com> <bf916ad98ccc1526f5298d1c3e1740cabad093af.1629393395.git.gitgitgadget@gmail.com>
In-Reply-To: <bf916ad98ccc1526f5298d1c3e1740cabad093af.1629393395.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 19 Aug 2021 20:08:32 -0700
Message-ID: <CAPUEspiu35JZZ1z6BosGyWeE9z4uOBhSotFL6iF+jEY8tXsjhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib-functions: use user's SHELL, HOME and TERM
 for 'test_pause'
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 10:17 AM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The 'test_pause' function, which is designed to help interactive
> debugging and exploration of tests, currently inherits the value of HOME
> and TERM set by 'test-lib.sh': HOME="$TRASH_DIRECTORY" and TERM=dumb. It
> also invokes the shell defined by SHELL_PATH, which defaults to /bin/sh.

that is a bug, it should have been TEST_SHELL_PATH instead.

goes without saying, that if you don't really need that shell for your
interactive session, nothing prevents you from calling bash and
resetting TERM or even HOME as needed

Carlo
