Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBEFC4727E
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 09:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C2D2080A
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 09:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hj26kjcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJFJZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 05:25:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:35853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFJZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 05:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601976337;
        bh=vUrWWG6KZp1BydJVNFs8IIkgNJIOqsClQ5YSbR2VeNo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hj26kjcxlqUPKoICZ8MC6oKMiZ0Zp0NUJeU4tIjUv+fFJo8qmIB05EPDFr5agdm0Y
         b8NXWdFaUdtxBIJj8vclP0VLZN9LuxwYLAWmhS0xWeTbeKfPE9S0Rv79i17UrP6qb5
         EJxoXkwNimd3gA2hZWTizOo9pZuLv2BLF+nzM8Lw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az767.50ehhzigkm4epi02yo0ovvxrsd.bx.internal.cloudapp.net
 ([40.114.55.175]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MvK4Z-1khoJ61o49-00rFzy; Tue, 06 Oct 2020 11:25:37 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.29.0-rc0
Date:   Tue,  6 Oct 2020 09:25:35 +0000
Message-Id: <20201006092535.6419-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:WUoszMGOsKpA/Nr6Y5GZJ/VIY1CiBYlts3xJWT13tvnI46VGSg6
 dymvedl/4m1ZjWrPlDedvRV5XfALV20b0d3UPzjWFCqHaYpfgDcoA2wRHTvKh7FDRZyzhMz
 BuO+q72bbUf5eugwP7Ig/gP/ri25ZMyub3Eys6+tLoe9JG2jGz6ZP9fAXnNRyU/F1kWDOhF
 FhP3XJmuWdj1fgxi/o0QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nmhp7g45274=:mQQqhkh2v7pGdVYaP+6QCh
 ONVApXli3CSNPOEnxvPixjNKWTXqhLMPDmO7xHvAOces/jfELxWaI3igQaLgJaENCiVl8Cwhx
 ritOdpyvxvhxYNFR6gJ99n2WrSvqs9NBRg6vkwKyUO9kS940CeqmRIAHBzovzE9YP0ahxhpeR
 N3wiI7da0t+6QMybv4ERsfOOCnUoNyycmK/1lMfLLpguDhGailu4rdPZftAwwWGLaX5TOXVGV
 8BqJr01bb7N5HkECqwXZMpD4OVOU7V8askXroZo1rx1ftNQIoOmBV7WMT7fKeUUxJrnh/SDB7
 wrnABFu1O90dc3oFmqv1YhzswKGv+ehU9hCSXygjHWAXeS/N4aRdMT8+8FA5dvE7GmNAVg+iu
 n2UVlkHPYoY+GIZNILLgZ/8oU4e8sDuiLB++xGCbtgF9SAkoqkUeb5fxt5jhqqK3UVgPD7H30
 5dULR29hUhPlt2kjnmr2ayLpUo0OJeepuX5ynU+cH5pAcAXrCKmEnkwFT6bNaAYjIwILRRsnD
 jZx3foa9zCx6uTRPW+Z290eSj6NAZ4Q7LPinl5DqbEoL7rRf1pMB92R7r1tcksLNVMIcQtY08
 SXOAjWBqEkOz3uav8+Hp55d2oOmkQO9fzNfRUL4umLDyjYG4yVjFaFmggQShsusSj2cARzR04
 tg9hG0q29N0RaW+NYrUfmltKOjMTOpXjCmfNqLOwuOrpFkYI0wP/TluK4obZQttB4c8HtYnfe
 45Qx3jTBezwdfZ8+l7verYobFJ7kRraZSv2CEABDYg1Jn5YnT9OV6a337H2tCD1893N7kvKDt
 AXyPzr/xtN5zFxECU3RVb8wSulrjFnqiQTUh6Mklb/lzKfpTllJ6j1jDT8no2FqLMn/X0gCOf
 4njMCEuisrvbbFFLpbxHzkURNx75hmfI6TM++mQ+VN6jPUotgt0g2gwDXs7hj2bS8Wkot5Yo6
 3vwNGf19tH7kKb8Gq85AE4gxfObKbPthkIgYDMTwTR1oM/6dZAkGqDnlz+ZHOArkCOPXsXHB2
 ISFSNvJRXsupmeJP1Y5f6rkO1l1THS+gnfcgrMcwXACgnAkNTNFpGs957aVbheapkRfZi9sUF
 9w8hBu3tznQv4evo+CH6iSE92fuSyLPZ7p+cCluGqEBGi0uPuBZd1cY5mlq1r13RAIctZxPyt
 0gmKP7eaR34g6OqBW0Fq6ppqfx/+kwwUeq8YXBdPyz94js0q8ngVCsyKeogO2s4nFN2J6gpb0
 Jzpi114mPW4PwvQ9FmKROR0B7+CYfvbg4nH1Weg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.29.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.29.0-rc0.windows.1

Changes since Git for Windows v2.28.0 (July 28th 2020)

This version upgrades existing users of Git Credential Manager for
Windows (which was just deprecated) to Git Credential Manager Core
("GCM Core", which is the designated successor of the former). This is
necessary because GitHub deprecated password-based authentication and
intends to remove support for it soon, and GCM Core is prepared for
this change.

Also, the option to override the branch name used by git init for the
initial branch is now featured prominently in the installer.

New Features

  * Comes with Git v2.29.0-rc0.
  * Comes with cURL v7.72.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.7.
  * Comes with Git LFS v2.12.0.
  * Comes with GNU Privacy Guard v2.2.23.
  * Comes with OpenSSL v1.1.1h.
  * Comes with libcbor v0.8.0.
  * Comes with libfido2 v1.5.0.
  * Comes with OpenSSH v8.4p1.
  * Comes with Git Credential Manager Core v2.0.252.766.
  * Existing Git Credential Manager for Windows users are now
    automatically upgraded to Git Credential Manager Core.
  * Git for Windows' installer learned to let users override the
    default branch used by git init.
  * The installer size was reduced by dropping a couple unneeded .dll
    files.

Bug Fixes

  * The credential helper selector (used as default credential helper
    in the Portable Git) now persists the users choice correctly again.
  * The full command-lines of MSYS2 processes (such as cp.exe) spawned
    from Git's Bash can now be seen in sysmon, wmic etc by default.
  * A bug preventing Unicode characters from being used in the window
    title of Git Bash was fixed.
  * OpenSSH was patched to no longer warn about an "invalid format"
    when private and public keys are stored separately.
  * Non-ASCII output of paged Git commands is now rendered correctly in
    Windows Terminal.
  * It is now possible to use wordpad.exe as Git's editor of choice.
  * When using Git via the "Run As..." function, it now uses the
    correct home directory.

Git-2.29.0-rc0-64-bit.exe | 97de20d56d3dedb48cb04a2bda94a75430bc2f3c358b163d77e1f979ebd33a41
Git-2.29.0-rc0-32-bit.exe | 043650a6634f6fd1b947efb2cabc64635868da154110b2d79a43e485beca9f3b
PortableGit-2.29.0-rc0-64-bit.7z.exe | 8f58fbc208d8ca3d38d607bd8a4d19a9cce50cf92ec218fcb9ded1cfd2c0a11c
PortableGit-2.29.0-rc0-32-bit.7z.exe | eace70204033b2245ee3715b005c091c9cc15646ec59caaac897f2de9286c507
MinGit-2.29.0-rc0-64-bit.zip | b1b0cdb51c291ad027ee244ac85d7855d1f206d80f8f916d8b36296c388a787e
MinGit-2.29.0-rc0-32-bit.zip | 5e422854824655063481e4d50b9a5d0b15811ca05fa0c034e0f9f22a03e6a915
MinGit-2.29.0-rc0-busybox-64-bit.zip | 1b3102b4fdf511f3008d3b0240faf8ef69a9670c2c2aac961a069753466acb77
MinGit-2.29.0-rc0-busybox-32-bit.zip | a8dbd4bc2b9959ba9fe0d35427084d2ff3fb32bf2f919cebfa25f4ef0efcc46c
Git-2.29.0-rc0-64-bit.tar.bz2 | 9f094b1caa7265253a221c1dcfe3f6ba386da6bd667216e33146db0ca7564bfe
Git-2.29.0-rc0-32-bit.tar.bz2 | 1c8f50b176a82fe1d6018fda7b2c15a4ae7a8cd0036fdada88595c39a9bc7bba

Ciao,
Johannes
