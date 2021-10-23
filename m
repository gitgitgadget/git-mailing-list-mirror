Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D05BC433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 07:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6ED960FC4
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 07:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhJWHYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 03:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhJWHY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 03:24:29 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F318EC061764
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 00:22:10 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id u5so11830857uao.13
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rQLgdfuAPK5QfIVuEayGvXm6fkC4RpFOT0aoYp5LGSU=;
        b=QZT1/vPsjk4W8DyPYqX5Yq336xY6IUDiKlC1DbrHv/VY2BZeseQ7BEknDDLZj3Tld+
         tv+65n05lAdtxskqgc4Mnk5U0ecDAtyJHRq07gqdmSY8pZUNAngluEtO3gVwLYU4ay8G
         mL6nhFbPsaX+qS466Qh+jXVjrCmzB9RBNyp2CZcW7+XCPPeY0qAMBPcBGhxyjgFxiXDe
         0AHvdYtgjrWSnfC0euwGUmaz1wS/boXiGzt2zA/wfyWAbU6RLUHuX4W354jUVU5fHnIz
         TyGMPevE8nxIugqsuEj4XPbNsVcN/y6o/RHcqGj1++0WuK/R6OX1B2xdDOP9PCsvnW8Q
         yPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rQLgdfuAPK5QfIVuEayGvXm6fkC4RpFOT0aoYp5LGSU=;
        b=SZRxtBsEGStKgG/0LTGltRNVx6IDKbpXQM6VLc4Okzev9vuSXXa8dgo2trsGAIQ1ea
         MUo3SfPAPlc1FCu3IfUgosrmuOJZg4+YzYbK8urASs5zGF2I8qjEhYDg3DBILPET2Sx6
         tltDh05/mKnGkYW0cABgr8Bq4304ZurqvKKqS1eXN8R1tZO+R90uVkhIkjY71+n38KL6
         nd88Po3zCAUQ4AGuBhhcD2niNtF+eIR8Z3tuw3ufeFF8qmsSsQ24OtUMoYe8KcGZlDYn
         RGV9N9nOsKIF4wVXxpIUgWrd/EicN5GXMKuQ61RskgSRFr605ODOIyNheZXU9sZjdOpZ
         8snw==
X-Gm-Message-State: AOAM5337lY4QTP7zQE415kNpfzjq0MZpTn1LPD5ltNUEAlfBFdV8BXyy
        n/0K6EN/2kL7q+p0bcSPpOKvKgpQpmx6jd/nuZbyvHJLZBs=
X-Google-Smtp-Source: ABdhPJzIgUVv5TDL8WozTvQpY+5QKWargWoQ7cNdPfdpdL5HzJ5jrYcGHGpbYx64XF8fGvspsZ0hGKbzpLvwb2zbiPk=
X-Received: by 2002:a67:f1ca:: with SMTP id v10mr2291789vsm.55.1634973729982;
 Sat, 23 Oct 2021 00:22:09 -0700 (PDT)
MIME-Version: 1.0
From:   Kraymer <kraymer@gmail.com>
Date:   Sat, 23 Oct 2021 09:21:44 +0200
Message-ID: <CAAjS6zO2E043KEcqEJr_5QbtdZEjxVWObCc518Ti3sW-p6LX5A@mail.gmail.com>
Subject: Bug report: branch display in git stash output
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

=E2=9D=AF git checkout -b branch/with/slash
Switched to a new branch 'branch/with/slash'
=E2=9D=AF echo "foobar" > foobar.txt
=E2=9D=AF git stash
Saved working directory and index state WIP on slash: 41dc5da git:
update .gitconfig

What did you expect to happen? (Expected behavior)

=E2=9D=AF git stash list
stash@{0}: WIP on branch/with/slash: 41dc5da git: update .gitconfig

What happened instead? (Actual behavior)

=E2=9D=AF git stash list
stash@{0}: WIP on slash: 41dc5da git: update .gitconfig

What's different between what you expected and what actually happened?

the displayed branch name in `git stash` output is truncated


[System Info]
git version:
git version 2.33.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.11.0-38-generic #42~20.04.1-Ubuntu SMP Tue Sep 28
20:41:07 UTC 2021 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]

--=20
Fabrice
