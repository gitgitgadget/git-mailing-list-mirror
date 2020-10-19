Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6FAC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A11A22282
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K7UrS+ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgJSVDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:03:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:44355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbgJSVDV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603141399;
        bh=XnH6MkGyWU9zavepPk7PSZwjY2ORU5P2paZWEolX3Ek=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=K7UrS+hah81Jfk8lYIDT0iLYRzUdBTg5tcr+m8ocL6nCkr80Af3EXnPYKLbu5kJS7
         rEWS0pRNjm5TqZmg33fP5OR/s7uzdqUxawvdqNzR+cnNLCHTfYfjb3/IfafMpAxjBV
         jVEd1Pk9dM7Z1JTVbBszOn6w9Mv0/HtnSa58sA24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az773.ybc2zd551kxepg3sp0liwfrbrd.bx.internal.cloudapp.net
 ([52.255.175.68]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MQ5rO-1kqWuN18Xw-00M4ny; Mon, 19 Oct 2020 23:03:19 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.29.0
Date:   Mon, 19 Oct 2020 21:03:17 +0000
Message-Id: <20201019210317.6178-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:MRMXRf3E02m+LyjisApL+zyofPwVGwS9VhJceo7uKiP/gSLrJsl
 0bAcgQiS6cYG712CvLdNN2J020AAOLba7Y1QJs0zk3+z7ocDlp0ZAzj3tNrMStbD7xdkviq
 i0kTjkqWNpsMbeRd8nKfTQLCMuST4cVyecUbDJ/Jz22HwgyJwBtupEVcXE8qJf/tkvCDPSB
 AtgY0xDxYqEZChv0/DPiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9qM9aUNrhD0=:Ikap89198hpJZZgqsiGLwa
 5arpPzzs6zvPb2e9rqXIhYD+o6Kn8iwsYoD1GDxoppKPZEnV2eb0rRoe9fLUwYkRnBYcEwVMc
 v+lU5HTUL8Qjk4dYQ0HgWmabZ3U/5ik7Ih2n4FIwJkpnexYIV7E/DZiAQMKg0FIWsstIv+BRq
 bcS1kLaLrMUL1DZCofYpw6TOeAqqDpJLzAYp2InC84MohBUQl/t6yvFsTV8YaNzGAfOSMUYFY
 z+cHuUGl97CaWgwTzNjDiI0SeaghuuAEI2poADApc/g+YX5yc85E4YHNXcSnZ1hfdtz+akTRD
 /VQKTo03MiVOKculrXqrLuJ0kUTbvYsCHX36skKkVVebtJod1aJ2C+8cjc2Y+97QBN9613P0J
 UQIpVU2DYYO8CwtF+fizlFvLUkY8qR51B+x16l8lF+ME2uIvSWutpCAAU39a9R3MKivtdAOUK
 /UT6fxa2RPBoPKU0J6WfUkVbs6yq+rQbVL4WZakyHE7d/C6+SJy8oEK442R+roiCQZuS0U1aJ
 B7+q70CGfQNQjg9axQpI2OpOxRcyF++jqWYzU8VuMHkYyTgTzE5VfH2+cE3Of+yc1vR2ZZ4YX
 4Os0hPIVisF4mmAnlPRPAx4oofuBp7MdZAn1SUMYj24Yy0CrQ4Zc4cyivUxRvuvSD7EXAHzUH
 SCJP4FbfUN3sttO0zDk7vxJofqRfVXEDwNpD/83TeJjIvdEE8/QCCCvj4I5mLecn21p223hjR
 OvRhQG99V/WmJhAx9b3KmWxQ+CvEaRYKYY7Xa88r21zo40gfzSNl2xnIyh47de35ERQ2tbc3U
 H+NM5kHb9DVndcdLmptVAc2iGuRH4/ACn2cM83qboIWtYBv5CGJyjI4GQp0SPRrj2nYegj6Lf
 SCXqQj1MRuK8hhtg7JRU4TsIQ/CSGQBrhbWS2bTnc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.29.0 is available from:

    https://gitforwindows.org/

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

  * Comes with Git v2.29.0.
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
  * Comes with cURL v7.73.0.

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
  * The Git Bash prompt now works even after calling set -u.
  * Git for Windows can now be installed even with stale AutoRun
    registry entries (e.g. left-overs from a Miniconda installation).

Git-2.29.0-64-bit.exe | a87a5b2abf44021cc61709218c6ffbb994a79126c5d3953368a45fecbc23cce0
Git-2.29.0-32-bit.exe | 0b212081cc42f7f07f2dd2b1cdc17c3cd8f33dc62a3f0c9eef9e3d34a3d15bea
PortableGit-2.29.0-64-bit.7z.exe | d2915bff1de726c0ab296ece5f1bddc930a3ea6ee7dd299a4f096db403d2158b
PortableGit-2.29.0-32-bit.7z.exe | 56d78e5c3e0a0c9cc6567d80bf45c0140ef4f8441a00bcb08fcbbea279344714
MinGit-2.29.0-64-bit.zip | b10bc7aa7222f3537071604bc7f9394e72f78a21c3c2bae24490270ba5259863
MinGit-2.29.0-32-bit.zip | a591b7bc8de30767a2b771ed195f7349753890b3c767492a6ce3bbf2bac7f8cf
MinGit-2.29.0-busybox-64-bit.zip | d6dfaecebe65abf4239a41f909da56c430ae90cf17f1110412998377dfee0045
MinGit-2.29.0-busybox-32-bit.zip | 9297d6e813fd7d70edba120df213f665fcb57c5c04aa8e9a7152cea5398646a8
Git-2.29.0-64-bit.tar.bz2 | 67b5f595a63237b83cbc5c999ff0f2c10e46facdf478520f6509791230f4c8c8
Git-2.29.0-32-bit.tar.bz2 | 1f782452c0329555f266ca0c846712e21ebb5ca93f5b62ccf3224215c0138e5e

Ciao,
Johannes
