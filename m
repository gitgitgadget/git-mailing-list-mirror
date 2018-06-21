Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594A31F516
	for <e@80x24.org>; Thu, 21 Jun 2018 16:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeFUQEP (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 12:04:15 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:46052 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbeFUQEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 12:04:13 -0400
Received: by mail-oi0-f48.google.com with SMTP id 188-v6so3391495oid.12
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y6UorX0koGt0oH9+sxGYF4oY6Ycd5q12JIHh1rob8Nw=;
        b=B2yK8S/aU88yblKllvY0GD7XvAKR6eLhHYbvw1/2apP7Z0JSbAAORYQIGEjghDcnwz
         ak23L6ljhN76/Q6LZqQTbH6OBmQQkxTLipO+IZg5A0XuSpwzuY22w/53T2gVoTBZvdwg
         C3XibLlO3eB5b0hRQpTbBb1S415l/IiHS+kUhF8FS4wdTAWvod0X/xYtqMBPBILoAtPr
         9fDafvG/j0awUMO+kCQvgTQ2X49TrKx9OtSO45WTJ/dPITW3cuHFxsA1fC10c9GB19Nk
         RE4nTf8BOHpFoHIjoeVIDbmWuOOSDqwm5yTA+O0fk3PVoiFliPadJrL8qjNmSiMzN+/7
         Rsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y6UorX0koGt0oH9+sxGYF4oY6Ycd5q12JIHh1rob8Nw=;
        b=HtZuH/svnLxwxnmS6++20Ler6gXHcIxq9WeMXZrXagdbg5P0CTmPyNsxXmP/q2T7B+
         6IKLZIzjklfRbqbDtKlyV8tKJLhcVIpv9wZsTxa4AR9bMGZY9z0QFm7OUcGIVyWuQbcf
         RRXOXX4UJ7LLWmk2w1j4PNEwQP9D6feQDgtgvbIYYifVvhjy+WhQHpsCcEds2kbcldbn
         FFzxWntrZJho9UYgXrfH0+nwkdh4ZhzPEgN8dDDN8z7jABnJASHoYM1ptSWc0b1kWMtd
         ZhO0X8ZBrK1kqPXL2/hWfDfKe/s+gaZYwJVY1uVanl9Bs/nP6vogwFFtIc99SoR9x/Qk
         uRDw==
X-Gm-Message-State: APt69E36VM5rlM02Krkg1ewsaVXHgb4f3+LVsoc7JZbVSq7VPBcAojRU
        qjVhEfeJiKzvxLlrbe1k13SiGDa3Mbuzs3Ih8sI=
X-Google-Smtp-Source: ADUXVKI9r8RQy6Nnfzkeb1GJm4X5bbce4ckSCrrlS5lkNbYSgaIrTB7GAWCuDsKFYr0CtbYkOUNpOguNseboiGdf3QU=
X-Received: by 2002:aca:d54e:: with SMTP id m75-v6mr13765368oig.160.1529597052042;
 Thu, 21 Jun 2018 09:04:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4047:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 09:04:11
 -0700 (PDT)
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Thu, 21 Jun 2018 12:04:11 -0400
Message-ID: <CAKepmagD1VgRx+79rS9Swe8OL8SOwvRn6Yn-u_FCUy-OCUMeFQ@mail.gmail.com>
Subject: Git not creating new directory when cloning
To:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I was trying to clone a repo into a non-existent directory. but it
gave me a failure:

$  git clone  https://github.com/jelera/vim-javascript-syntax.git
~/.vim/bundle/vim-javascript-syntax
fatal: destination path
'/home/username/.vim/bundle/vim-javascript-syntax' already exists and
is not an empty directory.

(the command was taken from install procedure from
https://github.com/jelera/vim-javascript-syntax)

The directory "/home/username/.vim/bundle" already existed, but
"'/home/username/.vim/bundle/vim-javascript-syntax" did not.  Upon
creating the "vim-javascript-syntax" sub-directory, the clone command
succeeded.  From what I read from the docs
(https://git-scm.com/docs/git-clone):

> git clone [--template=3D<template_directory>]
> [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
> [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
> [--dissociate] [--separate-git-dir <git dir>]
> [--depth <depth>] [--[no-]single-branch] [--no-tags]
> [--recurse-submodules[=3D<pathspec>]] [--[no-]shallow-submodules]
>  [--jobs <n>] [--] <repository> [<directory>]
...
> <directory>
>
> The name of a new directory to clone into. The "humanish" part of the sou=
rce repository is used if no directory is explicitly given (repo for /path/=
to/repo.git and foo for host.xz:foo/.git). Cloning into an existing directo=
ry is only allowed if the directory is empty.

Which to me, implies that the directory doesn't have to exist prior to
cloning.  So is this a bug or a misunderstanding?

Thanks,


A
