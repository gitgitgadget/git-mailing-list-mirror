Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3AAC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 17:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjHHRN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjHHRNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 13:13:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D81BCE
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691510685; x=1692115485; i=johannes.schindelin@gmx.de;
 bh=zXhCziIyw37V6UDwjlr5CRiubTE15IFLdhueQ8Tnht8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=cToiMFTPkaWwqFBJ+ZBA9mxJnvxFsnDSA2nv3dO5inVEAggWjxqDDCN1PrLseD5Ekz8Wn6v
 rmESfB5dEo24dEEdvbAlu5gl3TuwjbVXi0p3iR6G1Ba7kzGzvz8cSofgxMj5nI0unf/umJSzr
 ebYFIMifvuXDlTdnYD5C47FDaZeXYL6L+nRdq24lvQrgo/FnDi8e/xK1lnu2VbzkN7k3lWDC8
 z7lQbP8XhxRE6P4DjRtnS832P4xQaF1gBxgnzswiOXYhPFg4Gl/hX9rnz7ydTkzaykO5pFWbH
 udlD0A1pfCGR65DbC1dSGLP8OP8GVGXYi5oxljU4VtxUmBArgSXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az887-564.kyhrjabtieueri5x0cgfkhfc1a.bx.internal.cloudapp.net
 ([20.39.63.96]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MYeMt-1qFvBA2bWl-00Vfv0; Tue, 08 Aug 2023 13:55:31 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.42.0-rc0
Date:   Tue,  8 Aug 2023 11:55:29 +0000
Message-ID: <20230808115529.4147-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:PS3TfG+8qgzKN8MDc7GSpIQyi4dyPdaXctnoEwDc2KgU1NHTc+v
 DEIETwvyEjhdz8nyIkEh4ONAS+AS/jH0jLmLrQDbmTk7hxHk7KeTKMuDy++Y1FiHGlm+e69
 HkpxDTWmd2tKWhNcH06J3h+E1WAuKJglQE0iCPT0Kiez9St8s7D/D4U+rf+FNY4eZwuZDV8
 2XaozIhJiqenGXWCXsz0Q==
UI-OutboundReport: notjunk:1;M01:P0:u1NQiHDmho4=;wpfknPh3DKKuJQQ427LRiPSNy/y
 dB4cTy9tlkgphS5VMTatABXpVQGvK2kOZRaX0kCN6Vlw3R59b2yt0xtkzwtd7Q7RzSvjQAKl3
 M5KxCfBVdRW7ODQLevo7HTGDLgi92EcNEC1Wy9kxcyN6MAY4Dfaerf1mZ8uJLN+rObfPIId8o
 9SRhDoQTvJp+7aI3XEJJ1/KZxdCP9cgPkUIqba1hCvvxLoOJa80Cn8TLl0h+xuGrcTKZH1K73
 i+bRHLuOd8JrL4ojPxTik/EGgV9HTyjUL5e6BcCwp7nAzFWn/f5xs+TWipEUDoXxPx9hAQ/Oy
 47iyU+L+UgBEv1z0TZ/5GKL0lkNZE9TRlhOi3m6MSQTdn0OER1u9BQhaqtjQr4EF2m2Rz13ih
 MCHL2my0zDk5SDfHVz7N40MA2bcWctRAdIA1xdgVneAItpEtDncp60MDlFmfTzEYEJPT2zMlJ
 aAbORuemSk3X7faXStKyV4bNlW37uebdUcXpLJAodzDVHGt/1rlJi2XobZMciYPeqO1CpRYwf
 KbXTw/6nYfYYXuENic5m5ZuoO2zpTWRE89GgPrMYWi804mJ1w1p3q2UXG3amdJXcnUAVR2eZb
 UTrs2OA3FtXwLf0K9XFdKLkU7UWETbxZOEleH/Tk14xGHz+9FcilA5pZskNR8ZGMNnpWlHwoM
 l7J02S13SlI0dv2avGnPQoXMVAjCKo+eh43fHVpuAuwqbIM2nraBDAQF14Zz4iiLJM0bE54bc
 nX5HTsmJ9/G3CZcAAMLNY8KXadq1r0+RYy62eSXTPF96gaB9mgCcWbleJ1oWNzXtdMoPWs/7s
 N7MEdqtZi2yJSfaCPjCSJKi2Fi5n0vmG4CMihdB2aBl2wRrt0/zVP3S17Etnf8zZUfw1159o0
 9sKvIEuNGirvkMHjLpYeQbikY/mznEP3NQaZ+Wyw2WhKVYaJMPyuZmlhisoJ0Zit5TQqNwQzW
 rwZOWA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.42.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.42.0-rc0.windows.1

Changes since Git for Windows v2.41.0(3) (July 13th 2023)

New Features

  * Comes with Git v2.42.0-rc0.
  * Comes with OpenSSH v9.3.P2.
  * Comes with cURL v8.2.1.
  * Comes with Git LFS v3.4.0.
  * Comes with OpenSSL v3.1.2.
  * Comes with Git Credential Manager v2.3.0.

Bug Fixes

  * When init.defaultBranch is changed manually in the system config,
    subsequent Git for Windows upgrades would overwrite that change.
    This has been fixed.
  * When running on a remote APFS share, Git would fail, which has been
    fixed.

Git-2.42.0-rc0-64-bit.exe | b3e71e5ed580631c1eb08b3054e9e23d50c067c3b14dfd1991685d59c89436a1
Git-2.42.0-rc0-32-bit.exe | dd17207fade13189f6c8b453f6e58d4581df90c418d9f955d7bd7c7fd2b8eaf4
PortableGit-2.42.0-rc0-64-bit.7z.exe | d27891ada8bb801a18419b3365832e57935ed4cda73f2b341475b0fb7c9254aa
PortableGit-2.42.0-rc0-32-bit.7z.exe | eec6b352552841736b4b5e8800f9727b814630792e568a8aa68d2f5c469d04ac
MinGit-2.42.0-rc0-64-bit.zip | 298f6b2ec055a28d7818769dff1dc441fc831e8034fc1616102bf02e4b236416
MinGit-2.42.0-rc0-32-bit.zip | db63872425e432bd98f842e6b1607c3ca16ee019db1af13b079afc2d0ee6a30b
MinGit-2.42.0-rc0-busybox-64-bit.zip | cd6366db4f405da787806b2543bdd8a4173f6d9fa8d5eb9f34dcce69e1ad408c
MinGit-2.42.0-rc0-busybox-32-bit.zip | edd98eeee5bb89e76d68d87cff3d76ef3696989038444935ccbf193d36ce8e91
Git-2.42.0-rc0-64-bit.tar.bz2 | 6f28ffb0cd8438cd597eb5ff0b544e0290da8b705028911b3bb41f91ed08a26e
Git-2.42.0-rc0-32-bit.tar.bz2 | 99dc31bcd4fc20885a29d7be85769c9226513048c1d90d865d6bd42b84dda316

Ciao,
Johannes
