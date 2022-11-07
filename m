Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F389C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 16:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiKGQ61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 11:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiKGQ6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 11:58:24 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9961306
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 08:58:22 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k2so31869062ejr.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a8OfrsMZzjaVsy7pT9Sb3d5b+wuqkli/RfPjeuZA8/M=;
        b=cXPVhIupkOvg65A3x6QaFdiqirROjRKCu14iR9yy+6DowzTkAvj68m5LkMSIpAjksQ
         KhspAWb1sC+CixpQrR+eZQnSKuUhNSD6xEt2lKjwT+5QELYkOssti6tvxnQren8t58Sr
         hA2o9fXuOKGioQ9jamwo/JFka9eSd99k1l+Rtx54GcXnUdZV7RRKu1xjy1opsup0Ce9A
         SwHCZk7s+nwZxOpAXFlYxsY5nExRaSmmrHP/yATZFNyWOUrzC90NE2DG7jdNX8ZoiQAD
         N2khQO5OhN1tAYb3LgoQ/rrc2VgfeVD5IwxNdlYUkmp4pF/HOafwCv4XHa4cvnyo0Zdk
         xeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8OfrsMZzjaVsy7pT9Sb3d5b+wuqkli/RfPjeuZA8/M=;
        b=lGoAiLWWGCkPGwkbhNMjndGoAf3SiQgpq0KJDE/rxmnDm76eglZDrFRiaQN4P3wmwr
         XDa5yFNl25D6m1dbe1y/gWIwihmegj7tuZ6/hr4KL5lFdeIjonjxMBYxo/+GYGNzlWn9
         jOsgt38aGMjIqQXJvXehHuB+WOfMvdOuQvqWqBn52QOvNPLkaX0ryUBuP+6qaCVvTMCu
         nf1zkj8txjzzWHVRkNm/Jh7y7hzjRQjxGtqLUgeKhJTBeZKfwAcXESIF5TRnQmYASX2F
         KiYoTdQfSyrcGwaL8PTGiDcXbTrpZqZWK55+J64gvz+jdF6XKT2CTaAKGel68UbhzE+f
         dmmQ==
X-Gm-Message-State: ACrzQf2vBIipQhMEEO/RgPLIQ1jTPybqpbxmeGXjx2FKaKLIPCcIsiyS
        2F1F+HwB1nindyVosNT6VSOw223FeuIDHhqNYPEwInUr3+CuzA==
X-Google-Smtp-Source: AMsMyM4OlRq8eF7dNgKWWbwTm0nQRpf7NNvw5ZSvwtrOkEsQOec0vaS9vFVacPQHAf+fahr9wmzYshUBzh+NOpKeSLk=
X-Received: by 2002:a17:907:75f2:b0:7ad:e51e:837f with SMTP id
 jz18-20020a17090775f200b007ade51e837fmr37318940ejc.0.1667840300676; Mon, 07
 Nov 2022 08:58:20 -0800 (PST)
MIME-Version: 1.0
From:   andrey a <gvozdila@gmail.com>
Date:   Mon, 7 Nov 2022 19:58:03 +0300
Message-ID: <CAOvKmB_qjAm66fAuDBmgGQG7J=+=VW6Fayxfp1zPs5qJfdd=-Q@mail.gmail.com>
Subject: bug while cloning http repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

git clone http://git.altlinux.org/gears/r/rust.git


What did you expect to happen? (Expected behavior)

Normal cloned repo appears.

What happened instead? (Actual behavior)

git clone http://git.altlinux.org/gears/r/rust.git
Cloning into 'rust'...
error: Unable to get pack file
http://git.altlinux.org/gears/r/rust.git/objects/pack/pack-42e36950f8cd6e0d242719691491d16dd2e270e6.pack
transfer closed with 7043414950 bytes remaining to read
error: Unable to find 7f4c666c73ca05cecab9089c91d8c6dfff5a7cb7 under
http://git.altlinux.org/gears/r/rust.git
Cannot obtain needed object 7f4c666c73ca05cecab9089c91d8c6dfff5a7cb7
error: fetch failed.

Note that hash of broken object is always same.
What's different between what you expected and what actually happened?

Looks like versions before 2.33.4 works fine. And after 2.33.5 (and
2.34.1 2.35.1) reproduce bug.

Anything else you want to add:

Reproducible on Ubuntu 22(2.34.1), Altlinux p10(2.33.5), Gentoo(2.35.1)
Bug reproducible with latest git version 2.38.1.385.g3b08839926/

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-52-generic #58-Ubuntu SMP Thu Oct 13 08:03:55 UTC
2022 x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash

$ GIT_TRACE2=2 git clone http://git.altlinux.org/gears/r/rust.git
17:28:03.618164 common-main.c:48                  version 2.34.1
17:28:03.618728 common-main.c:49                  start git clone
http://git.altlinux.org/gears/r/rust.git
17:28:03.618840 compat/linux/procinfo.c:170       cmd_ancestry bash <-
konsole <- gnome-shell <- systemd <- systemd
17:28:03.619295 git.c:456                         cmd_name clone (clone)
17:28:03.620976 repository.c:132                  worktree /home/krom/soft/rust
Cloning into 'rust'...
17:28:03.629163 run-command.c:740                 child_start[0] git
remote-http origin http://git.altlinux.org/gears/r/rust.git
17:28:03.641629 common-main.c:48                  version 2.34.1
17:28:03.642043 common-main.c:49                  start
/usr/lib/git-core/git remote-http origin
http://git.altlinux.org/gears/r/rust.git
17:28:03.642169 compat/linux/procinfo.c:170       cmd_ancestry git <-
bash <- konsole <- gnome-shell <- systemd <- systemd
17:28:03.642678 git.c:736                         cmd_name
_run_dashed_ (clone/_run_dashed_)
17:28:03.643132 run-command.c:740                 child_start[0]
git-remote-http origin http://git.altlinux.org/gears/r/rust.git
17:28:03.649348 common-main.c:48                  version 2.34.1
17:28:03.649841 common-main.c:49                  start
/usr/lib/git-core/git-remote-http origin
http://git.altlinux.org/gears/r/rust.git
17:28:03.649975 compat/linux/procinfo.c:170       cmd_ancestry git <-
git <- bash <- konsole <- gnome-shell <- systemd <- systemd
17:28:03.650025 repository.c:132                  worktree /home/krom/soft
17:28:03.650044 remote-curl.c:1493                cmd_name remote-curl
(clone/_run_dashed_/remote-curl)
remote: 09912a27cf9a7028344e23986c14fd03341600af        refs/heads/c7
remote: 09912a27cf9a7028344e23986c14fd03341600af        refs/heads/c7.1

...

remote: d8a6a190551618fae1b205c3210fad9f5955877e        refs/tags/1.58.0-alt1^{}
remote: a3658ef7fb155cfa1f877abf6e59fb95acebc5f9        refs/tags/1.58.1
remote: b2f00be3d04a8f1eeb605957ceaa7e9325f892fe        refs/tags/1.58.1^{}
remote: 12bd79da893d981a2588d6b414da48cc2950fd3b        refs/tags/1.58.1-alt1
remote: e0905262166aff9e8a6c245294dba39f4cc0
17:32:29.224262 usage.c:65                        error unable to
access 'http://git.altlinux.org/gears/r/rust.git/': Recv failure:
Connection reset by peer
fatal: unable to access 'http://git.altlinux.org/gears/r/rust.git/':
Recv failure: Connection reset by peer
17:32:29.224313 usage.c:69                        exit
elapsed:265.575951 code:128
17:32:29.224331 trace2/tr2_tgt_normal.c:123       atexit
elapsed:265.575982 code:128
17:32:29.225644 run-command.c:996                 child_exit[0]
pid:190489 code:128 elapsed:265.582499
17:32:29.225698 git.c:758                         exit
elapsed:265.591604 code:128
17:32:29.225733 trace2/tr2_tgt_normal.c:123       atexit
elapsed:265.591639 code:128
17:32:29.226442 transport-helper.c:581            exit
elapsed:265.971163 code:128
17:32:29.228597 trace2/tr2_tgt_normal.c:123       atexit
elapsed:265.973323 code:128


[Enabled Hooks]
not run from a git repository - no hooks to show

Hope this report can help. Feel free to ask additional questions or
contact me directly.
Andrey Yakunin
