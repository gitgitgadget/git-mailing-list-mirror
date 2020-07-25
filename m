Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C02C433E0
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 14:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EF620674
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 14:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGYOrs convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 25 Jul 2020 10:47:48 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33319 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgGYOrs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jul 2020 10:47:48 -0400
X-Originating-IP: 209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (Authenticated sender: maxime@saumon.io)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6B87F1BF204
        for <git@vger.kernel.org>; Sat, 25 Jul 2020 14:47:46 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id x9so12826768ljc.5
        for <git@vger.kernel.org>; Sat, 25 Jul 2020 07:47:46 -0700 (PDT)
X-Gm-Message-State: AOAM531Q1VP9VupjZDtA/Kdrw++WsYIVytYOy9j0o4qrxe/CGi+WV/d8
        yq8GHXugihA3rVHIethSEjEHg18VOw7efYraB4g=
X-Google-Smtp-Source: ABdhPJwNNUccS/cASg4RxBBVDa6AtGuH0N4bY7PuSKm7milQ4l2Bi7UiYzq1Ao6Q8GeasAm48U+YaGseVjaXY0z1/ys=
X-Received: by 2002:a2e:a413:: with SMTP id p19mr6358851ljn.145.1595688465676;
 Sat, 25 Jul 2020 07:47:45 -0700 (PDT)
MIME-Version: 1.0
From:   Maxime Louet <maxime@saumon.io>
Date:   Sat, 25 Jul 2020 16:47:19 +0200
X-Gmail-Original-Message-ID: <CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com>
Message-ID: <CADv3qkGq3jA8iXsjhrqfsUX=gW+KOuLyeVgDzmku1tUpsMdvtw@mail.gmail.com>
Subject: Verbose commit message diff not showing changes from pre-commit hook
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm using git version 2.27.0 on Linux.

I have verbose commits enabled (`git commit --verbose`) and a
repository configured to lint code before every commit with a
pre-commit hook. This hook may change files and `git add` them just
before the commit.

However, when that hook actually changes files (and `git add`s them
right away) these changes are not reflected in the commit verbose diff
(the commented lines below the commit message). The changes *are*
taken into account by git, as `git diff --staged` shows — and later
the commit info, after actually making the commit. However the
displayed diff in the commit message file is a snapshot of the diff
*before* the pre-commit hook.

Is this expected behaviour? I find it somehow confusing that the diff
in the commit message isn't the actual commit diff.

Thank you for your help!

Kind regards,

-- 
Maxime Louet
