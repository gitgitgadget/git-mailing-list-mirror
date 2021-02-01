Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610B6C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D8064EA3
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 15:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhBAPQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhBAPQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 10:16:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFA3C061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 07:15:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m22so23236894lfg.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=v0DvBbRyTLaKFdpHvIkccJB+iUgm6iNofCdYOqp7H3s=;
        b=olMjYnm5M5dlroneuksyPWT5KMdzt6WiSw5mIuA0N8fjYafYG603uYGczXpiY7R5g1
         fXE28eQKQHEwwRX8HynbG9FmfX3Cpg1YLm1d274VUBDPVEiwcAZdfbX7MwK0o5Yyv22a
         NwJ09dlLl0wFWAViBM00ynqlR0ui8rMe1QIwirFVO1w8EaLK/yTPat2YOOUdGyJQIr6i
         I/xUt0GKNde9Lujp9I3UhfAgjfnpmm2F8nVhwbZZ28vfgiHp+bMXPCMrp/LYciqJGGOs
         Nkh0mPwhloalW3j6nZhqW2pAZvb85MxdkbS+EZpNlVetxggZXb1Pmwn0JM38B7PqnQpp
         Dvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v0DvBbRyTLaKFdpHvIkccJB+iUgm6iNofCdYOqp7H3s=;
        b=nhrTcXk5Dz0gRs52gra+BGwlEhiy11a3EgueCPVjDepqudM3cWviJ3i8d5eO2r8uGv
         lYDon0qaX/0/08G5GcgELx4/Qih7Do6608qAB1NkHnZ11QB16TTrPJa5+nd8YbIMMhqS
         U2V47CrMRkmmVnknNKmjcQdq4q3krVjN/ZKgFd+NEXS3i50FPiWlG1iBxdKmoxFtfECz
         vnTf0Up1mX2V05w7C820xNmwv4xHwwx/F6KKq3SUn4TyeACbwPlFhgXzzFDCh5H7xksz
         yy/An/c+ziDaGgmcFxzd5KTGSlCdfDOkrt2R/x3XXnt5HfF62HGl5X/SI0kX2U1q8zVW
         vOYg==
X-Gm-Message-State: AOAM532uR8GyN7N/OUmnI4F2JmCcBkh7r0ujWAszknH2JLrTCiTXEV2w
        fuj0lI7q2dgOEu4z6TU+crFyzdLEm1JcdV5SNLREAnzB7wMI74Wq
X-Google-Smtp-Source: ABdhPJzn7jJiDoIsxY8JNjFtHQqYHaQAPHG2VapE37P0xqmwvBVfaViavKQtXBzVP8nBBc2q65s4ZRwUgIjIKnmovls=
X-Received: by 2002:ac2:4ade:: with SMTP id m30mr9482276lfp.231.1612192544665;
 Mon, 01 Feb 2021 07:15:44 -0800 (PST)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Mon, 1 Feb 2021 23:15:33 +0800
Message-ID: <CAGP6POLQ_6cZHh0UCaavNBL7+FcMEX8bwb=VxvNMtmO0ZSCPwg@mail.gmail.com>
Subject: The error subcommand given by git tab completion.
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Ubuntu 20.04, the `git TAB' will give me the following available subcommands:

$ git TAB
add               deborig           merge             rm
am                describe          mergetool         send-email
apply             diff              mv                shortlog
archive           difftool          notes             show
bisect            fetch             pull              show-branch
blame             format-patch      push              sparse-checkout
branch            fsck              range-diff        stage
bundle            gc                rebase            stash
checkout          gitk              reflog            status
cherry            grep              remote            submodule
cherry-pick       gui               repack            switch
citool            help              replace           tag
clean             init              request-pull      whatchanged
clone             instaweb          reset             worktree
commit            latexdiff         restore
config            log               revert

Then I try the following:

$ git gui
git: 'gui' is not a git command. See 'git --help'.

The most similar commands are
    gc
    grep
    init
    pull
    push

The git version is shown as below:

$ git --version
git version 2.25.1

As you can see, gui is among the auto-completed subcommands list, but
it can be run like the manner of other subcommands. Any hints for this
problem?

Regards
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
