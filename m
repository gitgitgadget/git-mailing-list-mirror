Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D0C62070F
	for <e@80x24.org>; Mon, 19 Sep 2016 14:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750745AbcISO0p (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 10:26:45 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35494 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750701AbcISO0n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 10:26:43 -0400
Received: by mail-qt0-f172.google.com with SMTP id 93so72274339qtg.2
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=3u2LH8CWmkcN1EelaympxmP9bZidciAfwOi6GkMShl4=;
        b=hjgPLgC0MEBtnUm6GE2xBkf7bv0p6cFGxKkiD5+Zw60Jup25jeoDwOf8gaBGjcKrzQ
         hmplLKg042O3JvxP2jOxlwD+K4oZ5PZe6DwlxYtkl20QqcZhHKOdLXdEZLzjsEK6zz5B
         3zjnxbpF41XmhzTr5+D03c4zc8EYBQdvTu44jLZI9Rt8p3Y9O7eovplkGTlv4Me26uZ5
         R19O7gKcOPYDgmg9bU7NKtOsoR2TGbn20Ry3Wf5HqRI/TNoDhn/FcgrT+7vXRwmn2AXE
         2vFon9prX4moJ66nW2ewHFrU3bpXJuRnqkzIWDSPhG37yOJ7bgJPM7yrBB33ijSoyk0N
         /qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3u2LH8CWmkcN1EelaympxmP9bZidciAfwOi6GkMShl4=;
        b=AB4hCRhX/TJrp2YHfuJPNfpbVOnRicHJweEhOQl18o9uehVNmnU+QlzV87hqknKSoP
         GakDzZlqgnHxmNDlpIzxFlWnpXiTLM4QcKufZ88jB8pr4c/yZMF1chItNYLIea1WiXfn
         Uu9xD/Y3MtbItlLJqrQ10qlOAkTSIUt7/Zsq70U2aoEp5ESGv4SldDmcwUjpcJFiinUV
         rBu0BGNr/RJ40MMc79h2lnIzOQFOFWT1DNJLkutN7etkelJnni9fLJqKgiwqYYar8JHg
         y5iCPS5SEvB2cz6e8GVHdUF92en0l0BtE+i3fi3z0lyEWIxqtXllcPnK1IpvYYPkPT2s
         CPVQ==
X-Gm-Message-State: AE9vXwNxrim9flAgHQ/O8n395W3jRxSD7SEmAmGJxdfqVhFsCMgVMvfiJFta8hcHluE1FgIXoP6TruPJujeEfQ==
X-Received: by 10.200.49.81 with SMTP id h17mr29976954qtb.48.1474295202745;
 Mon, 19 Sep 2016 07:26:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.30.133 with HTTP; Mon, 19 Sep 2016 07:26:42 -0700 (PDT)
From:   Nicolas Cuillery <nicolas.cuillery@gmail.com>
Date:   Mon, 19 Sep 2016 16:26:42 +0200
Message-ID: <CACmQg1hE=ytaatDfUJLkhL0p5c43wZZvgt+8pc5zoo0YFdQw6A@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBug=5D_Custom_git=2Ddir_directory_shouldn=27t_be_listed_a?=
        =?UTF-8?Q?s_=E2=80=9Cuntracked=E2=80=9D?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I want to create a local repository with a custom dir name instead
of ".git", I used the env vars GIT_DIR and WORK_TREE:
>export GIT_DIR=".customgitdir"
>export GIT_WORK_TREE="."

Then I created a repo in an empty directory:
>$ git init
>Initialized empty Git repository in XXXXXXXXX/.customgitdir/

Then I ran git status:
>$ git status
>On branch master
>
>Initial commit
>
>Untracked files:
>  (use "git add <file>..." to include in what will be committed)
>
>    .customgitdir/
>
>nothing added to commit but untracked files present (use "git add" to track)

The local repo directory listed as "untracked files" which is a
problem when using "git add ." afterwards.

When using the default directory ".git", it logically doesn't appear
in the "git status" command's output. Don't you think it should be the
same when using a custom dir name ?

Git version 2.6.4 on MacOSX 10.11

Regards,
Nicolas
