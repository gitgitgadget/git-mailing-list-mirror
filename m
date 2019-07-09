Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307421F461
	for <e@80x24.org>; Tue,  9 Jul 2019 13:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGIN1T (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 09:27:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:54923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfGIN1T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 09:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562678833;
        bh=vY5miicNmUONWJJl1oRHlNSXJyZNOIQexIB6ERsYQUI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N5wgpvvvi1qqWmsnnUk0nHPIUdlhxbWtTsEMV50ybvLtrqZ+iZ/VFI88G7hRDyJvC
         dpTvwzOTsdnf2mdtacX2PW/M2yHpgpjw54uxvwW3WEL9UVB2fQADmpCRssn3na3ZtZ
         bLULJ4+KnKO0rtDcXiNiH0XMp5qFONvy92GAE64A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.104.164.78] ([194.69.102.78]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3u86-1ic7IA3wCA-00rV0S; Tue, 09
 Jul 2019 15:27:13 +0200
Date:   Tue, 9 Jul 2019 15:27:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Avoid illegal filenames when building Documentation
 on NTFS
In-Reply-To: <xmqqv9wcxre3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907091524460.5700@tvgsbejvaqbjf.bet>
References: <pull.216.git.gitgitgadget@gmail.com> <1f0f4fe6fbf0e7a7eea1f3d49db183c70693a895.1562231679.git.gitgitgadget@gmail.com> <xmqqv9wcxre3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1RLa7YJ5agRzamhSR4pb4D8TSS9cWe55LNF3fgGB4XiFDA+Q3vu
 g+lxvJkXXuTExz7L4d+0xwGatY9p2HMk6ra6pT97eYHR2mUzTznsrCZWwyC59HZRZ6bI/4r
 ToMXkJgORR1X6mt4tUI74GWbumACQ69/LJrdef66AZCoJAMBoF9SeMNx0p9A6EkDcmomM3d
 Xe501l0Jw/6uT/Jkj8HTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gMNl1ZY32eQ=:g/Vm5f4TaFdglYP94XJeSq
 zQxLNbfYPSFsNGzR4lyf1VsTWiKOfXTKvzp4tQMTlAzp44mTRkI3CadczKf2Q3g/RdDv3AdIE
 SuTmfFKkwmrmppJG/7FJWx290F9TPap18ebbni1Rzo8Ts4UJ9MeWwv30FOiCubDLX1OYikYJX
 2C2rDHrNNC0Kch1DflBLfaymcSEzFl2rBLm1XEPDHhT5bCVwu6nGGIPBji16cg2cubFzxREot
 rOBynRh6XQgTxQZja+iwfqEafnpAIhqjuEnm/0Jjfm8nMMPdoikjV2kTWy7kMuY3Hjt4O4pU0
 V41nFpD+H+ToqMFcfF705eDzdSEuQmi9qBQq+z+xsQywz77Sj4FIuwZRE2WIaX2ykdFjSOJhl
 5BcABveZGSmzJSVSCc0itTdogMPe8UoWxjK1yZXJXaS6dFFe1gb02ekczwYNRKVRVzTHY8pwe
 Yn0SQk/1KNToNV/tzvmMBoyIc0rnpF6HpEpp1fT3kxq2/Ji2217yd4hpVFSedBfQOYXSxAf8e
 q65yCGRV0/KZYtYwYxVQpQW6e9Eo8Bkyubt0AhazEUyIDTixC/dT24CG379CzsQnZR7Pv/Dc3
 3BA6D6b3D0q7h1TRHCjFkEhxdNmstTZQfh8Qp1lm6woAayUAD7/T8Fja94yTAHRZJakJNCPHT
 qBN6pokeA1awcAsbLtKE6wY61EuZEgNyfxDmVW7VBkf3neF68J19+8g8OAh3NSGjQjCMqZTvP
 6U/rFNyz6bwpu57djuz6/93jOANQL+6JNBk8qlV5ltHyt0GAC4qtbQn/etFX2vnnVMv9RDcD0
 vqt8bmfHT3qUOkEBWhlvDaluMlvZouSLiIh5v8Xbl4aCkKZwusGUp4k3FpI63fspINqq9p3hX
 F2trOHDEOH7UHAWQdAFIdVEaGhy/85Yw/wLBJrehJIooKWRhURJ5DrURCDJgAbk0qZDCRk6ZC
 qNQoZkP6Djm+n56Z0VonV6yMEmcrGNLRhXbslaTtJibSlkVJmCO3ODJQHc5kYJ7acWy3sh7/U
 zHGvJJKHCFdFx3oRZ8Lm/FjnifQHlUinmozH12OeSFqDvSGMafAtfMbzRKJseoIwI4lOHZWfN
 /CiawlGBj95ZXXxPFzrwNfJhaUyGXTL9fvg
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 8 Jul 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > A `+` is not a valid part of a filename with Windows file systems (it =
is
> > reserved because the `+` operator meant file concatenation back in the
> > DOS days).
>
> I'd rather not to take this patch, because "generate in the target
> with plus appended, make sure it succeeds, and then rename it to the
> real target" is quite an established pattern not limited to the
> Documentation/ directory of this project, if your tooling has been
> supporting it and can continue to do so (which was the impression I
> got from the cover letter).  Even the top-level .gitignore file
> knows about it, so does the top-level Makefile and it uses the same
> pattern.

Using `.lock` is actually an even more established pattern. (I used `.new`
because the intention is not to lock files, but I would be prepared to
change the patch to that end.)

In addition, your `+` scheme will break on Windows once it uses `git.exe`
or any other non-MSYS2 helper, so it is not future-proof, no matter how
established you claim it to be.

Ciao,
Dscho
