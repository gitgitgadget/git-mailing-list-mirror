Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB571F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeCZV1w (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:27:52 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:37025 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbeCZV1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:27:51 -0400
Received: by mail-qk0-f171.google.com with SMTP id w6so21755614qkb.4
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 14:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=M30gAOXmhwuE0DJC4EZ7hXYgvHOvxZuUXNdTP9jAjCQ=;
        b=O0lIuam5a2yyGpCDyQTj2r+sbXCF1ME0I3yh4Apn8PMlLcJ8CV7Z0sf06DztCm/2HL
         JFJ+TJXuPFuj70vN1Vw30E+0M7nKTqv65sBZdUbESgH+puFPrZNLRhoqstTSbS1kO3LP
         S0AcW3FhE+zPSNMo6m2jk2t/oPK+c+9eZzqPIwekIfhT5cCBT0gS68EysO1XFrgqSxpL
         aQWODATdesHCVKZp0Kxzg8cN4F3ER7OO+WHtXuEOLdEoHIngxNjJP9PPNIgvjosfb4O9
         qerejB/5JvokMpdjNBLT1gJpN/KigbfgW8g0wzVbeGh4Hikc7Lb8uTzakEDAw9d302fz
         DNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=M30gAOXmhwuE0DJC4EZ7hXYgvHOvxZuUXNdTP9jAjCQ=;
        b=DrxbvYMSTMVC4hQiawiM7QVh8cXnFj71FZm9unjDRDMj6FXxQmYZ8VjZ6pKhw2meDi
         RsqTLsTqbviWxJKYYZ7Cdr9TE+tzka7Vl3+O9tSZp8Dwqe/ECsLcelRJwMFpHBs9KS2V
         D9eGiesSivhYPPtSaCXnirKLt2IlhJ4ekoiwUlc4a6CrO6gEEgPmjYE8JICYrjZduhJ2
         Scskt9X0jw60HwTTSPZxko7u+uIv2soIwkdhVZ/h9l/dqG8EDwdZ42TcQSY9SxeVTCWP
         3cN8DbdvyZKrXG2O0kSRBuFflqiQxfIGHIF5UWYOXzRUIqx7BoykljbnyHXjdvdcoiij
         JwEA==
X-Gm-Message-State: AElRT7Flwpk59jmFzHxDX3Eki/Cfp/QBwUB5eHkUBVR8OC1n8orP8g2u
        3aPrq7XeeBF8BNz/irQkYeT1yiKgaRpFkpnsB3KeYPdG
X-Google-Smtp-Source: AIpwx4/Q94m178fb4TndJz+iA5dmhLGvmCMvx9DkXD9GzIVSDuTxZ1EVaMl7gTxW0Ii2vAFvqd7eP6eU5y27pPT7fjU=
X-Received: by 10.55.78.86 with SMTP id c83mr4309363qkb.264.1522099669820;
 Mon, 26 Mar 2018 14:27:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.203.129 with HTTP; Mon, 26 Mar 2018 14:27:09 -0700 (PDT)
From:   Rafael Ascensao <rafa.almas@gmail.com>
Date:   Mon, 26 Mar 2018 22:27:09 +0100
Message-ID: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
Subject: git complains packed-refs is not a directory when used with GIT_DIR
 and GIT_WORK_TREE envvars.
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the tools that manages PKGBUILDS for Arch Linux stores PKGBUILD
git repos inside a cache directory for reuse.

One of the repos is triggering some unexpected behaviour that can be
reproduced in the CLI with:

  $ GIT_DIR=3Dspotify/.git GIT_WORK_TREE=3Dspotify git reset HEAD
  fatal: couldn't read spotify/.git/packed-refs: Not a directory

Moving up one directory works as expected.
  $ cd ..
  $ GIT_DIR=3Dsync/spotify/.git GIT_WORK_TREE=3Dsync/spotify git reset HEAD

Using -C seems to work fine too.
  $ git -C spotify reset HEAD

$ GIT_TRACE_SETUP=3D2 GIT_TRACE=3D2 GIT_DIR=3D"spotify/.git"
GIT_WORK_TREE=3D"spotify" git reset HEAD
22:10:53.020525 trace.c:315             setup: git_dir: spotify/.git
22:10:53.020605 trace.c:316             setup: git_common_dir: spotify/.git
22:10:53.020616 trace.c:317             setup: worktree:
/home/rafasc/.cache/aurutils/sync/spotify
22:10:53.020625 trace.c:318             setup: cwd:
/home/rafasc/.cache/aurutils/sync
22:10:53.020635 trace.c:319             setup: prefix: (null)
22:10:53.020644 git.c:344               trace: built-in: git 'reset' 'HEAD'
fatal: couldn't read spotify/.git/packed-refs: Not a directory

The issue seems to bisect to f57f37e2e1bf11ab4cdfd221ad47e961ba9353a0
I can't pinpoint why this particular repo is behaving differently.

Cumprimentos,
Rafael Ascens=C3=A3o
