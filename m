Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C0C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 23:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiDHX2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 19:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbiDHX23 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 19:28:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7D3BA61
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649460379;
        bh=gxoZwOE6BT6EPv6nxufg9NoZOprVLsD24RaNhNRkaZY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IxsnUQn5/0PUW5ibQ3hZjgWCOp/VAe86Nhgd9/e84i4Fft7KfYE+mutg3F7aJJLgA
         /qt53VB7n/7Ej1vMWX9N8Ps3Ux5oMR+JkZN2JEMODpMvWzYDLo3KnCSEhBTLS3RlTC
         cPxxPyyn1ZuoIBplRHEr5wQGLENHH6H5Z6S/TOCE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az92-378.nbrkuvepa5puroylvvx1wzp50h.ex.internal.cloudapp.net
 ([20.241.23.119]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Ml6mE-1oOAFj0sFo-00lSiO; Sat, 09 Apr 2022 01:26:19 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.36.0-rc1
Date:   Fri,  8 Apr 2022 23:26:16 +0000
Message-Id: <20220408232616.4125-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:qgyHPR4je4FZkKc5jRMZSNG+XnXErswvFrLkgopTsHQz1G1LeG9
 VA5A/dzkoWM8DF/n8MjwtkJ8DDQ6fb8dp1bpCR2xKxLoBqP26wGtWQMHXgigDmF+UmoLayD
 RJskmlVDpxSGfsXeKfqQYUe8GQxTTpwz/ElfLV8Te7jjpKg2dt8lr5Low1m564/I9m9/OWY
 Ck3d2hA5GFyHsv6aHbb7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AlIpJF4up3I=:J+6HTx+GfLp3kOA5lse3Lc
 V/6CmtEbMqU9zBMcq/su63bCYIMg8lmIPCGxBwdnc2fg0elBjwJyiV4zA+p1A/3M6il8cJuEn
 Izv4k/hByhZ3JWWb9x/gpTjW9Q3r6F+aOfWuErP3D4huWDxxLRAQlsVA/nyp4Gp8zg2+y84dz
 hFQKUjwVDPlPRQ7E8T4lHmVKAxU2wo/8ijXkqxqnTdTU3G6rA3LTh8+qa1dOqewMxKtt2Bqql
 JSc9ifwPjeMUrSvvObxOR7PERTr3ldh01/c/JZvUDi+3Du5EMI16JwDa6zB/jWRX9XpJ5jPWt
 RLNmYqB6Z0IuN3SP0Spl7Nnum8JNim5kek/6IFI6Qe6sE5YewvliZo2dAzViBmHTJgwHFR9xq
 /PdnCy2D3Ur6zRvlvj6WvYBOfcsvFic19zXUyNhiTXfmIgiemnOBd8TgiixCWIfcLVJsF2PXR
 JzMuhQkXsBHPDHbWobqegeLqdlHt+Ot5N+xCOfwtsvbEPSg0kOaEescvUcvrq65lV8vszermX
 6FBDT/zl14/rjeICz3QqRwCL5Hxcssg+4vl8AwbImSU3ZBb6UBQl7AYj2bCsX8tVbKBYhzN7Q
 SNAzzCb8x0ZUWXpx5q2kupijUS9gTRgZzp9MIMizdXFx8wUtKaKHYxWXfeER9P/ZYbQwCFjAI
 2C0C5UD0BcpfcmF1lCK9FavFDPF2V4l/vpFqf1SaRSZxt6TxbT4e8FU2YCbZNJFdP9CF+6L5M
 xLWDbcbZHwffbVq+bOlsDlNxdXfYWCtE914jtgon2Mvn00mBvx338zMsdb4cwlkb/quupsDJa
 dpRyq6SeTF2fsWceCAffWm+zsVMcFtIWRGIBNTA9p3ho1P+eviJhdd+A8YsohTJxN/nAcWwGH
 urOw/WskrdDIYIT1QhjCdhBmJg8K1ZiMRpoO8eH2EVo0MWmSV051D86h71K4ETiYyPsjOsqxl
 6SotLX0vMdRq6Pl4FqMEdSChDSj5Q1gfBeCUiGNoHEZ1jfPj403bsqHrL0D1proTUrnZVlp2h
 b26ttY20ftoUTfbZmcHqzOAq5+DxvkHLVwi2RtqbelfD7ObmPcuPs4ILs0CwwzJOMu5Y2LCq/
 hBG8BU/og92kiA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.36.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.36.0-rc1.windows.1

Changes since Git for Windows v2.35.1(2) (February 1st 2022)

Upcoming breaking changes

We plan to update the included bash to version 5.1 (currently 4.4) soon
after Git for Windows 2.36.0 is released. Please check your shell
scripts for potential compatibility issues.

Git for Windows will also stop supporting Windows Vista soon after Git
for Windows 2.36.0 is released. Around the beginning of 2023, Git for
Windows will drop support for Windows 7 and for Windows 8, following
Cygwin's and MSYS2's lead (Git for Windows relies on MSYS2 for
components such as Bash and Perl).

New Features

  * Comes with Git v2.36.0-rc1.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.4.
  * Comes with Git LFS v3.1.2.
  * Comes with OpenSSH v8.9p1.
  * Comes with cURL v7.82.0.
  * Comes with OpenSSL v1.1.1n.
  * Comes with Git Credential Manager Core v2.0.696.
  * Comes with GNU TLS v3.7.4.

Git-2.36.0-rc1-64-bit.exe | 1faa20a778afb06a1fb00f30801ff5bd9000596f886b0740b0ccb7fd189ae45a
Git-2.36.0-rc1-32-bit.exe | c3c798f05e93776bdb4b99bd4b048993264c69481be2d05ca01062f88beedca8
PortableGit-2.36.0-rc1-64-bit.7z.exe | 408f82478f89b7ca505d7f47d920993493c07f39caf1bde4bf8ebb00a8faed8e
PortableGit-2.36.0-rc1-32-bit.7z.exe | 1494df620c93177be430c460644cdd5297a8611e5a9d53d511550b2508dd61d1
MinGit-2.36.0-rc1-64-bit.zip | 05ba2f96ea1e04380aa8bfe06af86adf687c3f14ac44e72905a3f18b4b8d1ebb
MinGit-2.36.0-rc1-32-bit.zip | 94a52db4c1391618d6e65a5e60447b853e455b136d9540c24c73fc054b016815
MinGit-2.36.0-rc1-busybox-64-bit.zip | 9ff27015cc2c91695281828ec83ab3c8b0c12745b8f2184754b8b7930d128fe1
MinGit-2.36.0-rc1-busybox-32-bit.zip | 675dca2fd1379329838f5523efc5d0e16e370e32a9aae0e0b414549708f1a15b
Git-2.36.0-rc1-64-bit.tar.bz2 | d4d762d0d6925a4f1bfb2e9f4f46efe27a937b11f3875455bd15d6692eeaacae
Git-2.36.0-rc1-32-bit.tar.bz2 | 644470cdae2f5778a6b7534e17365d3fc572d7c1fdb5b693ce2f8fff98fd6b5e

Ciao,
Johannes
