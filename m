Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0436C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0D364E9C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhBBChA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBBCg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:36:57 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D647FC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:36:16 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l12so22196928ljc.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCv6kXcMaYVbByBIVxL4b61CBEK+F6+5KsLwcvrxsJU=;
        b=bpnLcrTq7/yvfsOrDq7vftnRHa2SLKU+8SPkU02Y3n1txGQGYKoXOxphtITYsP15Fw
         DUPVRst+DIi6Yqaz7RbOBSFZhRUiQuQqwuQ4fv5gVtSq/sOhHIyYZ8pHNCHKgeFvMKlZ
         2zrb4NyO/ous4f4F3TWdwo30XARYFCPgLrujlfzaVBlcnJqOdlv7VKV81YoX9T0JcKdj
         MQZHnd0pD3lh+eOJX7PfvlmZM0Zpi+jqnGItUF0BwHJ4pSelODhbqaP/KKm4BiKuPkY/
         gOliiDDQJ6MtIFroh+GRoHsEYuxe3UO3JLyjM3PPaGr/ZqkoPrMTP9SXk3Ct+ceD7H2x
         Vkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCv6kXcMaYVbByBIVxL4b61CBEK+F6+5KsLwcvrxsJU=;
        b=KjKBFjvy4CSmxeBwGNkkRbFgqe6GFjVZUn5QW1j+9mSxcN+9F8yL/PhIpDL4onl3Tm
         rZvf+RwqMLxl5fHlLxuoOW0faQTydR9JEafUcemfbZ0taVjkBymjcpIKcxABgysE7+/i
         Wa95rotD12OA9SdN6RLcDnSAOKaOG2JJLHF+K2YSgBCf0PDNmQtHlH33dxRhTnHEAvrR
         GfbDCA75odTNPqxm37bMGifaU3o0hAIjmkW2TYntFjEdCCBtPxyhsyG8Wkf7mHDdxGe3
         U5kil89vdCqHU3fVZAwmXFGDta/LwjE+AY4CqatQg3aupPJ5lCyCBmyuV9WxTpdjoqU/
         GOHg==
X-Gm-Message-State: AOAM532UtxIGsv+kyxjVoqPtbB8GV76j2oy66WazbOYUKc4zsq7VAhB0
        Ul62T2Q+13+8rosFiA9sPr5LdciFbxrJcyI4dZGDxPhfFAat1ePf
X-Google-Smtp-Source: ABdhPJyW0FGoEE5ZbokVfyBeHclmxi/q+KN9KihCQ5cYB8zm90G3z6pYnJ9uD+NGT23trXtu014tpTf8emPCn4mP658=
X-Received: by 2002:a2e:95ce:: with SMTP id y14mr11828539ljh.287.1612233375406;
 Mon, 01 Feb 2021 18:36:15 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POLQ_6cZHh0UCaavNBL7+FcMEX8bwb=VxvNMtmO0ZSCPwg@mail.gmail.com>
 <20210201164158.q35j6zniuebspqx2@yadavpratyush.com>
In-Reply-To: <20210201164158.q35j6zniuebspqx2@yadavpratyush.com>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 2 Feb 2021 10:36:03 +0800
Message-ID: <CAGP6POJ22jT-JbbGLfXWpTCf6bEkPAzD=M_y2HVdc9wozi=-Zw@mail.gmail.com>
Subject: Re: The error subcommand given by git tab completion.
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 12:42 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 01/02/21 11:15PM, Hongyi Zhao wrote:
> > On Ubuntu 20.04, the `git TAB' will give me the following available subcommands:
> >
> > $ git TAB
> > add               deborig           merge             rm
> > am                describe          mergetool         send-email
> > apply             diff              mv                shortlog
> > archive           difftool          notes             show
> > bisect            fetch             pull              show-branch
> > blame             format-patch      push              sparse-checkout
> > branch            fsck              range-diff        stage
> > bundle            gc                rebase            stash
> > checkout          gitk              reflog            status
> > cherry            grep              remote            submodule
> > cherry-pick       gui               repack            switch
> > citool            help              replace           tag
> > clean             init              request-pull      whatchanged
> > clone             instaweb          reset             worktree
> > commit            latexdiff         restore
> > config            log               revert
> >
> > Then I try the following:
> >
> > $ git gui
> > git: 'gui' is not a git command. See 'git --help'.
> >
> > The most similar commands are
> >     gc
> >     grep
> >     init
> >     pull
> >     push
> >
> > The git version is shown as below:
> >
> > $ git --version
> > git version 2.25.1
> >
> > As you can see, gui is among the auto-completed subcommands list, but
> > it can be run like the manner of other subcommands. Any hints for this
> > problem?
>
> Do you have git-gui installed? Some distros (like Ubuntu IIRC) don't
> ship git-gui by default and you have to install it separately.

Thanks a lot for your notes. The following command fixes this problem:

$ sudo apt-get install git-gui

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
