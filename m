Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E8D1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 23:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbcIBXGs (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 19:06:48 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33651 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbcIBXGs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 19:06:48 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so136180200qkc.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ca8142v0OdRyspNF/pNL5Wg+mnxWmp8/VtSkh6VbVqs=;
        b=UHB+43GduZuklEGjBkYb4wfvpXt7fGXamSJiu1bltfwtdGVxVduBo7eRphcI6c+u8n
         1BXie7uBY2P8leHleKEU5iF6i1VOoYkCidsX0fiNUpsw4e5PV2fJ3kvyeobk3kJZ3MPX
         ZP+Ydg4OZdbc3hJ/YYy2Db88Yec81tGWmSIKMoSr+g5VRa0dpsoksxkNT18Vx+U51oOf
         Cvdh4zjeHcVU/6nAq9w84ydI0g3EQg7z93pqdlKIwiqEdS0/LbHMD0wC/n2I7wntPNGp
         2Fda3aRwzBkVQqXa60yYCi6+dzQd67XxI+eTCjj/d0KDHaKjvE8ol154L9a0Bd/0PTZS
         3/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ca8142v0OdRyspNF/pNL5Wg+mnxWmp8/VtSkh6VbVqs=;
        b=Y1PcVloitMbZUMGhWEv2woWLSlnG/EqKVUfKfOXycie+Nx6fjTz+75vPSc2ncT0drE
         0KLQeRlDXAKYjNhrKspPqVwRpHlb4Qr908lrsASpmRal/qHj0TJiEY+iN7/wREet1kuq
         G+PsPqh7W9a5syhWZ+IwXGo7puSu+VVKdHPwOC9pOL3Gi/Axpm3jWmxvhj7L3sKaV4Ta
         7qrj2nvjhMSU3Q8UfUPdi88sHBrfLGPZoX1OYwfe28rz8YWVJYiZIOwd/Jw8TOpX/+sM
         VDDiISuTa91fTSS4HlZ+YjeMAU3SvTjOVDyHVVgnndrZyylZ7e1lHHLRAwdkRg60RGNE
         Jm2w==
X-Gm-Message-State: AE9vXwNAB0edgsXbuaWf4rWmakEU0rPSQacy75plbDXPbxMDusJY3m1QSJM129a870D7xKM3LH1EkzammRPNYw==
X-Received: by 10.55.201.151 with SMTP id m23mr26033520qkl.268.1472857606980;
 Fri, 02 Sep 2016 16:06:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.57.115 with HTTP; Fri, 2 Sep 2016 16:06:26 -0700 (PDT)
From:   Brian Levinstein <blevinstein@gmail.com>
Date:   Fri, 2 Sep 2016 16:06:26 -0700
Message-ID: <CAMbP-nS_MM0QXgw183DLQPx1YU1BH8ytKCv86p-JSxzdb2jpQA@mail.gmail.com>
Subject: Bug Report: Too many untracked files (gitignore)
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The relevant repo is here:
https://github.com/blevinstein/dotfiles

My gitignore file looks like this:
https://github.com/blevinstein/dotfiles/blob/2400ca8642a7b454a2bfc54e8402343d008836aa/.gitignore
It basically ignores all files, except for specifically whitelisted
files. However, when I run "git status" (git version
2.8.0.rc3.226.g39d4020), I see the following untracked files:

#       .bash_history
#       .bash_logout
#       .cache/
#       [private]
#       [private]
#       .profile
#       .viminfo
#       dev/

I can fix this by removing the following line from my gitignore:

!.vim/colors/*
after which all the untracked files disappear. I also tried changing
that line to:

!.vim/colors/twilight256.vim

but it had no effect.

The same effect can be achieved with any directory name starting with a period:

!.tmux/asdf

!.vim/asdf

where .tmux and .vim are real directories. It does not seem to matter
whether the "asdf" subdirectory exists at all.

Brian Levinstein

blevinstein@gmail.com | bpl4ab@virginia.edu
(703) 673-8711
Google | Software Engineer
University of Virginia | MS Commerce 2014
University of Virginia | BS Computer Science 2013
Alpha Tau Omega | Delta Chapter
http://www.linkedin.com/pub/brian-levinstein/14/620/6ba
https://github.com/blevinstein
