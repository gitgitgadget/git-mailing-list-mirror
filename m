Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD4FC6FA86
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 10:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIVKRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiIVKRH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 06:17:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BBD8E3F
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663841822;
        bh=N7OQWkPhhSAjEKpAAlLsFNKcHuvZZ3WUfYsnA+Xxh6s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=IQ+jzL4OOI3xHU4p1bE+pG7g2gjnqzvgoy008PfrXTufkCRNnHc81yQcCJ9g1iOFz
         D8V/Y6uo3WetEN6CSQYgr2BRZm8eKBlHFxJvun0ejiweYqkR4VOoZH5JZgYV+IiPDF
         LPNXDizQ98k7rtZxCsrDoXgkgm0SfFUJ7yUppPtw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az767-997.5kzmkpjakaaulcrpfkoga5aama.gx.internal.cloudapp.net
 ([52.165.40.246]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MJmGZ-1or3vb1bNh-00KCSy; Thu, 22 Sep 2022 12:17:02 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.38.0-rc1
Date:   Thu, 22 Sep 2022 10:16:59 +0000
Message-Id: <20220922101659.4408-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:SzORaS8KNr8kS2mECEi3vEz15NAbbYwhT84dVZxTOCTiM6tKaAc
 v2u92pqnf+3UOsfZ/QvZ2SCkCL+oBlU18JGpbDyveqtaTx2a00kpooUYcvgkAAh6ZXgvFoV
 QhilvrSH5tgDShl/zxB11x9ebB8EDOIDG2o0jHM9NAteEkukuvOScS9CzJ81eypKeaqlXfo
 B2aVu8MsNOareihdfmqVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6WthYAqXtiw=:l2RTmwTlZQONnk+UUCZkM5
 KpvJpULqnwF5GFh/J104lZv07vUY2WDvU3mOgoYFdFVLsabIXbTbK6QRu8Rs1/qWzCr3NhefD
 sgYRO4K4mggkozokaUXzyviJn80+fdHsKm76PFjJMcbfrP8QwJyDShSMMfXPP5oDzcbrhiYI8
 hpwhMv4KIrLJRDcZBYk3FuJP7Mp/Z/+uWQZ6Wnu/b7sVooTxErnCvtH2xHsKzX77IfEB5bAmG
 JVOncwG3o3NDQpLs8LXUT/sYkm8QWJqg8Tm2ZC3hIHhb2sJsS6BZppX+sSXpDNHRlx4npCY+7
 syVbzCGgDv6IQ7joRQLjqBdaWpkKsGdX4ra0xufdNn2rcCnjpVWH8VGB2oSlRnF+E6AvDLG+a
 SYF+yVc4fqQnRgqSlvFbkrnw2FehPkgjjYFiD/fLybn4jqJS8zVSRTmuBzkjnBtKTQqLv5Rxm
 ovyq6OYBXEDxAetnBUT4OQDBuTRL0gch2IVjNQF8B+Wth7r7c9GlW0lRT79X70+snClHjR7M6
 SdC+99fdiNP2NY4LeaSRrTJCHKfFHymiQNVfU9CHAwpnqn94u5zIGi3tQY5yFPxLLpWWvrtQj
 He4uWSJmdUzzLibMopEofBH36HzzB/6XDLDtJde/Omkt1pU/SzYlQ7x6DrPMuRv50RMjp+B09
 hLxJxw/0YcIVHJArkLHlgK+K7qwPjSX+sGuP4J6abGSgOLnqQNf/Tobsq1VdwzVT98XYkjTDK
 Yx3SMXHBPCfiCrFxxVCkBVrmqBeaJbV1kWGEsOPtJi/1NyAKQuCqQAX2GLxyBirsrZD6jOpFc
 NYi2sPmLhBevuD1BluNZYfBec2KMqpzTGV0xJXZVsYx3Pw6JH1xFH27G+7KKX+Un88aTTJiOu
 XPpXHw3wwCw9AweK/YhCJYbzIQ+81/68WW2wiD1EzgnwQktZD6QfsMeMrzcbXlqhno7psmeYx
 Yg1O3ugrSqL8GNqu19aDXxd+U4beQ6pdk4efEkc02sqYCc8dHXc+CcH7IcwwKwc0g8sSl+sjz
 KKxTSJudcKZNPo8gQxlVobWgdwg/Jw4+lckY2zx9TnWfyxn1g1baWIuEAH/ttv0bbBbTVWRiQ
 eN823GG5o/Qq8IErb0s4mWCSFUbZcihP1/XMeQN3igt2D2MkB6H2fqEv6SpzUGV3z0d5DKt6O
 xZxAmouxIDiv+HzEFoQEewZNDp
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.38.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.38.0-rc1.windows.1

Changes since Git for Windows v2.37.3 (August 30th 2022)

New Features

  * Comes with Git v2.38.0-rc1.
  * Comes with cURL v7.85.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.6.
  * Comes with BusyBox v1.34.0.19688.985b51cf7.

Git-2.38.0-rc1-64-bit.exe | 61316e3b35876ce2714e39fc98fbe41b9172d83b01c7eda934fdf41fb49b6d66
Git-2.38.0-rc1-32-bit.exe | c733e9c8d2bfd262d80e714c14b30ca69a2ecb9087971d1ed56588f4a52d58f8
PortableGit-2.38.0-rc1-64-bit.7z.exe | cd8f225dcdf5a2566c1a3f7315fda5d2ae5c6523fe13416eeb54ad523dbaa1f6
PortableGit-2.38.0-rc1-32-bit.7z.exe | 31fcfac77eb024dad13ee07aa32e26bb974a6ddbb8cf7f6ce0b74f896e0a160f
MinGit-2.38.0-rc1-64-bit.zip | cc70d60b980f0ff91abd314677a9395bf0d23d41499cea598013f5c2b2b3e6ff
MinGit-2.38.0-rc1-32-bit.zip | 0630d138c400ad60936ef56097aee8c6e3ba014a1b892861a70b598c9282f536
MinGit-2.38.0-rc1-busybox-64-bit.zip | 9c7fb24bf374019acb8ec2ea82db5309a37aadf44fc1de676e321d5dc34e7e3f
MinGit-2.38.0-rc1-busybox-32-bit.zip | 5ab3297276491f7ff72890cee75a944f7ea4c96c3809dc9dc4e823649c429c28
Git-2.38.0-rc1-64-bit.tar.bz2 | b1481cc5dbde1eec7051886cb9ddd778b3291f2e5b01c5d459686acc7183d0ae
Git-2.38.0-rc1-32-bit.tar.bz2 | 7c5b404e65fa00bd34c2cb413a06524b2c5e14e8b3e8c2e8b91c55c28948d197

Ciao,
Johannes
