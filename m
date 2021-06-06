Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D0C4743E
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 19:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F526141E
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 19:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFFTSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 15:18:12 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38578 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhFFTSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 15:18:10 -0400
Received: by mail-wr1-f50.google.com with SMTP id c9so6252646wrt.5
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=B8icMQN2NThdSCPqz6jN40Wy+5BpGZj9roMoKs+aC+k=;
        b=OfiCLvbiTZU2YjpLLwwflPCSLjuozd+gNpj2AwBX7JPCJgDfZ3HFYPmDAi+C+zizm8
         PustOlK6cwom5i1tq1UEOXpc8z4eRI71gGZI5+jOq9GkVvN28MGYWJ/noZMISGWit87t
         KUF+PoREBLlC0sVaRyPANE8JAshnE+0lRaFCssLQ6RAFPM5hxe4q+pHoXwM9Q0YqAgku
         jHiEJgmnoTBHt0h+u+vINNOa0pFGGjL0cZaiTXqM1So1W+GEtmMsXqEPMjpt2eJ0G4Hj
         s2/eiLccAnQROshSyEy/IAWz2MQr0J0fsFkEFqi+ghiRAQklBP2HAGSSrNVjFo5frjiq
         Bvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=B8icMQN2NThdSCPqz6jN40Wy+5BpGZj9roMoKs+aC+k=;
        b=rhKpjwY3ERo8aPiL6wIe0AtWK3hKl1RkSTKrD7BE8OC2leSjShvCOgx20iFZUmNKZm
         AP5FMs63KdptN3K2nA388X+tQGmjEWxSoZ4XODXSwEjNOMnXnrPtOQihk1OVjDHBsCE7
         dbQ6wSiHxO0oKR4dUTCNwnZ+Tj+wAoo2F726nhRih2UVp/U+aPDSfRAOLpDGCjnQGPWn
         OTDFuUbtPH5DHDeup+lTFp/2xmuZxuFaHdIs+9u0RwzDgYgoGjGLlNkzMCcLdG7hNqYg
         uyYkwgWwNcg8tmLyXKTWT534hAvBdXa7SOdVIwVTjzUrBCL7exr3ClaLVqJ2YNfmy5C4
         QVgw==
X-Gm-Message-State: AOAM533K+U9P47lW1hQXYsc2Ef9N3Uk1244epojAWqR5iBLdJXIo6UYO
        73KU0DovgUiFa1NtU7HnvCfjhonaa2CzFBNxGRCh1xHcWAMbxA==
X-Google-Smtp-Source: ABdhPJyoSUWziE8F0MDuEl0oQk6LandFnClrOMaD/APF7/50A9fDsB0hPL8MEITQCdJuL0tDYGWF+nijUuVhJkkY1Ak=
X-Received: by 2002:a5d:6546:: with SMTP id z6mr13906451wrv.100.1623006920095;
 Sun, 06 Jun 2021 12:15:20 -0700 (PDT)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 6 Jun 2021 14:15:09 -0500
Message-ID: <CAMP44s3TBooXT9OzWndmf4BxCW1FREZQYsMQPWXDbwMc6VquPA@mail.gmail.com>
Subject: [ANN] git-completion 1.3.2 released
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git-completion is a friendly fork of the official Git completion and
prompt scripts for Zsh and Bash.

The main goal is to provide a more up-to-date completion for Zsh (I'm
the developer), which is basically just a wrapper around the Bash
completion.

Compared to Git upstream, you get many benefits for Zsh, but there's
also benefits for Bash users too.

If you use the official Zsh completion, the main benefit is that it's
blazingly fast. Simply doing "git log <tab>" on the Linux kernel (with
3k+ refs) takes several seconds on the official Zsh completion (about
3 seconds on my machine), with git-complete it's *instantaneous*.

There's other benefits too. Since the Bash completion is actively
maintained by Git developers, everything works as they intend too.

For example "git send-email <tab>" correctly completes branches, as
opposed to files in the Zsh official completion. Also, complex aliases
such as '!f () { }; f' are correctly identified and completed
out-of-the-box.

It's a sister project of the Oh My Zsh gitfast plugin [1], which I maintain too.

Since the last version, the baseline has been updated to git 2.32, but
there's a bunch of other improvements and fixes.

In total there are 44 patches [2] (3 of those 47 were applied) on top
of git's master (plus tests and workarounds).

For installation instructions, and more information, check the wiki
[3], but basically.

 * make install
 * fpath=(~/.local/share/git-completion/zsh $fpath)

And for Arch Linux users I've created an AUR package: [4].

Cheers.

[1] https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gitfast
[2] https://lore.kernel.org/git/20210101021622.798041-1-felipe.contreras@gmail.com/
[3] https://github.com/felipec/git-completion/wiki/Zsh
[4] https://aur.archlinux.org/packages/git-completion/

-- 
Felipe Contreras
