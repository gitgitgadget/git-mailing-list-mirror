Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259211F405
	for <e@80x24.org>; Mon, 17 Dec 2018 13:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeLQNJC (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 08:09:02 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:45589 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeLQNJC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 08:09:02 -0500
Received: by mail-io1-f47.google.com with SMTP id p7so2289380iog.12
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 05:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0GncTl18z2kFbHODavWzAkZNA648JtH+Vinyu3cwXH8=;
        b=LvvdBCHBs5v+IpaWozB7tQziZQ8W/77co+CAt1Hj8cirnWGxGPzkqRGw4PTpRscEaF
         nDRwlYQ42R/E6kHQztgRAKAv0jKI8jKLqOfD7y70LGZsvcDtHOIl+TGsf/hsizaG3psl
         l3kJ5rgmH3vcUhYQkkxCqSL9iuE4Q9GejDRqGw2Pso5idqcCb2Xo5EEl9DJKMjj0PkZR
         zqqyRpR8KiUJGrHLF3F955bh8u3BPhTgwdVCaowUDN/JRq8aK0wz0cDMLFgN1pTQpwnV
         6B7DbKFeugzYXtCRHfZPbAMd0OOEXCDgmz5c6oCr4UXUt7N1Io0LUjTwPqU/p6MH4umO
         EXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0GncTl18z2kFbHODavWzAkZNA648JtH+Vinyu3cwXH8=;
        b=sKe3juPF8bNvHltAApP1pDNI2Dd/X5BQv+y/bTMRkk+yTF456tghlUDcnhOixtE3VH
         Qc38T+Cza89XatraxqMEK7DcoW52lLLua/P0//qA1DFp2qq15g6WhS4z3SU0IOIhYRFv
         4XNS0SIJEKvcEVDsIBy7uf5McDk2DlyI9atbdGt3R+g7FDiKgo8Y2LAoFxKTSOZpuNsO
         VDbhU2khOGsrX5uNr2ZGkqMjPMi2NDGYKVtFFkn4Ot5pBoZ7eU7v6S2rVroSH4yKLIi8
         sNSAGeCme8DyDJm/U1SpAe0u0k3SbYFlPjKggKX5hVtx/wK2Dbhvm3RY81BRt7b2NcQg
         NLAw==
X-Gm-Message-State: AA+aEWaf/Jy+Lw9OqhkxrBWsNkC45Qz/6JIDqDW1rptLWz5FfDi6VRZ+
        j8fijW1l8dI2h9TuSA0UG8IrNpGeao6CuWoOVJANnUwa
X-Google-Smtp-Source: AFSGD/VXtRre2Wy4ErDZr+G+gEU6N/RD60/sBVJtpKScBzjLgc6dxNb5CIEXeCm620yRwouS0DmCc7NXUJrU4ttyp+I=
X-Received: by 2002:a6b:398b:: with SMTP id g133mr11207524ioa.67.1545052141153;
 Mon, 17 Dec 2018 05:09:01 -0800 (PST)
MIME-Version: 1.0
From:   Mark Kharitonov <mark.kharitonov@gmail.com>
Date:   Mon, 17 Dec 2018 08:08:49 -0500
Message-ID: <CAG2YSPzmN5u1uAPVbjsqC3LzVVinFR21-_6wfrkBHdPWhOfMfQ@mail.gmail.com>
Subject: Can git tell me which uncommitted files clash with the incoming changes?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I have asked this question on SO
(https://stackoverflow.com/questions/53679167/can-git-tell-me-which-uncommi=
tted-files-clash-with-the-incoming-changes)
and usually there are tons of responses on Git questions, but not on
this one.

Allow me to quote it now.

Please, observe:

    C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]> git pull
    error: Your local changes to the following files would be
overwritten by merge:
            2.txt
    Please commit your changes or stash them before you merge.
    Aborting
    Updating 2dc8bd0..ea343f8
    C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]>

Does git have a command that can tell me which uncommitted files cause
the this error? I can see them displayed by git pull, but I really do
not want to parse git pull output.

I am fully aware of `pull.rebase` and `rebase.autostash` config
options, please do not bring them up.

**EDIT 1**

It is OK to execute `git pull` first. In fact, the logic to identify
the problematic files will be done after `git pull` fails with this
reason. The way I recognize it in Powershell is:

    git pull
    # Possible exit codes:
    # 1 - either local changes or pull merge conflict (but the merge
has not been started yet)
    # 128 - a merge is in progress
    if ($LASTEXITCODE)
    {
        git merge HEAD 2> $null                      # Disambiguate
the exit code
        if ($LASTEXITCODE -eq 128)
        {
            # Two options:
            #  - pull merge conflict
            #  - a merge is in progress
            git mergetool
        }
        else
        {
            throw "Cannot pull due to uncommitted changes"
        }
    }

So, instead of aborting I would like to identify the problematic files
and essentially replicate the `rebase.autostash`, but without
`rebase`.

**EDIT 2**

I used to think that git pull outputs something like this in case of
clashes with uncommitted changes:

    C:\xyz\test [master =E2=86=934 =E2=86=911 +0 ~3 -0 !]> git pull
    error: Your local changes to the following files would be
overwritten by merge:
            2.txt
            a.txt
    Please commit your changes or stash them before you merge.
    Aborting
    C:\xyz\test [master =E2=86=934 =E2=86=911 +0 ~3 -0 !]>

Which is easy to parse. But today, I got something different:

    C:\xyz\test [master =E2=86=934 =E2=86=911 +0 ~2 -0 | +0 ~1 -0 !]> git p=
ull
    error: Your local changes to the following files would be
overwritten by merge:
      1.txt a.txt
    C:\xyz\test [master =E2=86=934 =E2=86=911 +0 ~2 -0 | +0 ~1 -0 !]>

I do not know if this has something to do with my Powershell console
having gotten botched somehow or with some recent git update, which I
had installed automatically without noticing it.

--=20
Be well and prosper.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
"There are two kinds of people.Those whose guns are loaded and those who di=
g."
   ("The good, the bad and the ugly")
So let us drink for our guns always be loaded.
