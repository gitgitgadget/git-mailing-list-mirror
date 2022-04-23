Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0C5C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 09:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiDWJam (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 05:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiDWJam (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 05:30:42 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E36107736
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650706060;
        bh=cDbp1HF0u+ic6qfddwlbo6UzoQr6u/QqpJaH73KFt+w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=pF/UGsakMZvbonMHOKUiUIdYDZwSyUcFYa7DDhFe+cogQ7nuhoMsMDIFfuZM4vFUX
         4QHhErddIOumfdXb5Gg92o1++VbQuibO71fTZHUAPdoVeGFS7PH1Q6GWPXAqD2/Vjk
         P4A8t4UqEgRHh9mfkHEKOAp1VZrFuT52iMu2onUs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4bA-1nb5Jm1lxi-00BaSo; Sat, 23
 Apr 2022 11:27:40 +0200
Message-ID: <8424860b-e557-55b1-49a0-246a2eb112d4@web.de>
Date:   Sat, 23 Apr 2022 11:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: gitk regression in version 2.36.0
Content-Language: en-US
To:     =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <AM0PR04MB6019ECF053F1FB7B29D75AB7A5F69@AM0PR04MB6019.eurprd04.prod.outlook.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <AM0PR04MB6019ECF053F1FB7B29D75AB7A5F69@AM0PR04MB6019.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d5BmTwMq+1g99baeEo2XTHpUphNO1oypMo9X+DJN1AMHW22OfMO
 imzAb5+JVX2SLigKknQWPl+AK4boqG3My4P0L6AeWrw0x0tujCvXb91a5yp9uesoXOc62Ez
 3qj8PtgEANWlfcFkopJFzG2qoAFYtrNCuOpJikMvEMwkZ8PpYnpfeRlfR9m4A/r8iiIxig3
 XYKvgCeQqzKg+zQmPIR9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kEgLyRydYWU=:W1rvOutywAcKcjU+lV2G2Q
 oA1n4E6UWce1QxdmEKaG6wcqY9MGABKtMscB2IcnUOjVbRRXdAP9xp08DYBngKzDb9KPbcKHS
 iKfS5aMdCpJEFTe87yUw8C4638mOOBl02flSHRCl/xDZhu9GaCoY3G84FiFA7DikN4Fk6l+rU
 U5GW43RZMpMW7FgTfAhPWQy7Q+Vvhkv8f5afdEBa+IRHT80in7NIoJBDQWs7IRnYVV4+NwA44
 vWoQj7yAJVPxXtHJSLC41MswkjxKPMJf3W2QrCa2pckaPolzB1NqpEBFoCxHHO8YXiEbkHk63
 /xeVN0dlOuvIIK+rDsiWhOn5hXm9DxxdGUB/07mmKnFfOf4sg4CBftA+Y4sJvp7JUYD61SJbG
 lQrRqvIDiO75viOkgG/94F6dFMO/xXHlsuVwczCi91amrIEKw52bX1eqzo9zaNKcWOGPGjzg/
 us05exs/Cz+NJsNqwLwo8U6K4Bf+Q58EX2J+RdrNDebEEaC7oxHANCGgUmhxOdf+WG4H0RsZ+
 glSt2EusO9H9TyQXDWAYtnHZ0NRsw5bM7YCbndxFj6Mqn1tnyZymkBiZAlCl2DeNfLpYKYjnm
 b8Z5RLuUB+ela+GrR6TLFkuYmw36ibuHGoQBGnMbaLgZpgxwOV57t+J7PByM7NzE9hcGfKhgY
 fzJ/wABLUyJM+VYKy5edb7OClgG5Ut+ufZNtZUQhHfNuwrJoou+LaEOhlP959zx3ywDm/63R0
 BsLQau9bpsoRi7KyMDi6cN/b7D+b7UW2J9h017pLTv21zfnJ74f0Am0AUOJphLBSRORQmKXOT
 L80CLUDVW6IIlmCg+HxcRVR3jLlDCDWjPTViygNFjtYEJZBtqhVAXkQE1bOIStJtW2ElLysXz
 zbgqhdM/UZAR1+2yX6871eu7jKiOBqkrpByRZivHl/gAiaOdu8L3h4to+i4buXH7e3yIjZZ+o
 1wuVWe4OMnkdOGThIvyHQ9OIWdpoNr+9uExbA6MQyRX6YyMeVx+6mkandxrBFCGyf/1bRJIeI
 6OEACrEcrsG32ghgeclw6PREU7sf5uAJhbN8MWAHW+qH38BWet1BJv9dqut1B0+P1Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.04.22 um 07:25 schrieb Matthias A=C3=9Fhauer:
> Git 2.36.0 (or more precisely 244c27242f (diff.[ch]: have diff_free()
> call clear_pathspec(opts.pathspec), 2022-02-16)) introduced some
> change in behaviour that causes gitks highlight feature not to work
> correctly anymore.
>
> Here's a quick reproducer based on git.git:
>
> git checkout 244c27242f44e6b88e3a381c90bde08d134c274b~1
> make install
> git checkout 244c27242f44e6b88e3a381c90bde08d134c274b
> PATH=3D~/bin:$PATH ~/bin/gitk
> # In commit 4c53a8c20f (Git 2.35.1, 2022-01-28) (2nd from the top)
> # right click GIT-VERSION-GEN and select "Highlight this only".
> # You'll see 4c53a8c20f (Git 2.35.1, 2022-01-28) and
> # 89bece5c8c (Git 2.35, 2022-01-24) highlighted, but not the surrounding
> # commits. Exit gitk.
> make install
> PATH=3D~/bin:$PATH ~/bin/gitk
> # In commit 4c53a8c20f (Git 2.35.1, 2022-01-28) (2nd from the top)
> # right click GIT-VERSION-GEN and select "Highlight this only".
> # Almost every non-merge commmit will be highlighted.
>
> I think this is a change in behaviour in `git diff-tree`, but I'm
> honestly not sure what arguments gitk passes to `git diff-tree`, so
> I'm struggling to figure out what exactly changed.
>
> This issue was originally reported as a Git for Windows issue [1],
> but I can also reproduce it on Linux.
>
> [1] https://github.com/git-for-windows/git/issues/3815

gitk does something like this to find commits that touched that file
(just with more commits):

   # v2.25.3
   $ git rev-parse 4c53a8c20f ff5b7913f0 | git diff-tree -r -s --stdin GIT=
-VERSION-GEN
   4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a

   # 244c27242f (diff.[ch]: have diff_free() call clear_pathspec(opts.path=
spec), 2022-02-16))
   $ git rev-parse 4c53a8c20f ff5b7913f0 | git diff-tree -r -s --stdin GIT=
-VERSION-GEN
   4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
   ff5b7913f0af62c26682b0376d0aa2d7f5d74b2e

Somewhere in diff-tree a struct diff_options is reused between commits,
and the caller expects its pathspec to be preserved, but 244c27242f
clears it.  With the path filter gone, the following commits match.

Ren=C3=A9
