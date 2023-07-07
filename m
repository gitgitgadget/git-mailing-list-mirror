Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220FBEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 10:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjGGKuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 06:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGGKua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 06:50:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF601725
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688727026; x=1689331826; i=johannes.schindelin@gmx.de;
 bh=JPtuF3e3MqtfDAaXBtqZjFqGj3KiaJlfL1+IMc8sUSI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=N3T3Sk1iPkgrl+EcAla48B/jeJxaD4qe1/VoOx0SR2jAIQHrMYXqvD9MSBHiHpDU3Tba29s
 2lrJE4g66MBvNNGRHseUKyfOhCK2c61OSrb6GKoTS5h0ejP1G/Jko65ik/dYWcL3wkk38Ka8j
 NF1dXrXjvdZfpgR1x186TeXx/lR9Rh08iM6aJ6CI8iR0QBhCEYLL88wxYA0+B4R4mMfnSy8Ks
 ehceDNg1+72bf9M/Ivyd0ymhcmx3LygCU4s4eM1Jg98fPBmvx3F/afg7pzP0mes22J0/TUZ2y
 zPR3RmRC6clJgYqMV/7EVR/g3UL8AnELm5YmtgUfOpQWFzOSa60w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az567-299.lj1xk2mgdexu3igr4w2lmfxu3c.gx.internal.cloudapp.net
 ([40.77.93.32]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MCbIn-1q84G22mUl-009kvL; Fri, 07 Jul 2023 12:50:26 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.41.0(2)
Date:   Fri,  7 Jul 2023 10:50:22 +0000
Message-ID: <20230707105023.4092-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:KRa+X5CqUWeOfqUlF6QnfWhFrS0dtGXXyPiYryXDqYOdtcQNq/N
 tScoO+TjUv7fQZucgF3Wt0dhsaSHbOCbRf1s6rWzPxODxBqP++Xf1l5/QGPP74x0BOx6YVL
 jw++X66+A8winb6x9OT0VLoT5OBUrCQewbUk2whxEZvC5np+dnr/uXTP4b2ND+85w252Dn9
 dqZBrYwLtAbMIle7OvbeA==
UI-OutboundReport: notjunk:1;M01:P0:icJMnM3AtGU=;aVXxA+KbaNy3kqzjFqq1/mCWx4G
 WvQXEGYCo49U+tVDlbtPbItJ5IkucL8ILqSkZ8ypST9sNLHLS1kR5X4x50HpSYME9r5cgriIS
 N1z03ioloCmDfAwzbDkQcb/Bk3rJOU4QQORFjFJ+TxxQImPqgGZEbDn3ElyNcghaAf7ia2gzu
 d3wUkcZKydXX5YpY7XPpWGvSvKMBoDZSvPAGmlDj9YJfRuqvRdzrq8MOdjNXpmTGi9ODNLLuu
 CajB0SX5+L3jfsxCnrFgRurcScZ4f0nz0VrIYSPaS3bePRhfxkrg7COwjuGNTW3SNdGZWtcIP
 LVccusNk24wiRGSjI9FiUPakO2aa8jc2A+1iDCeNy7ICodSIamNJWW7lfMRvrhzH/WdoJVm6b
 SmTAZPbAxyVhmK+Cr/UWlN64ydKUwnWKcfVulvQjUh3AyVaM3b+VXy5/h8b1HQ8NuFRrXE2+6
 yycqFkLvi9AYziAk0a48036ep7X3/JP768bwjf1WSFj5bqzTdVbyWDVZpY3BLOZT3C+xFKoHK
 nZk37Mwt9OEl+AMmBZcqODjBtxEPAJmd6sGMY7W3jq3KQaiF7Kj+GX54BQsQA/Co4iPaGscFi
 eRdX+m3lPr1+tGzUaSXMgzDEr+cRzTBr1dcZTTUCSBYrjlX7DHXoCB0jKx2QjLI8BmROfLcE3
 ptec2XNWBWZCPpTPm6+N+zUvU12SQ9pkDwaybzpoX1MfRs+cevugz8PR/TVctQHr7YioTVk8B
 RvNyw81uZCxSns3h9jLJg8vLJuNFCaagxyBoye3LiOy0heHsIWdu7WNfNjWbQ9F2KM+Q+n+ri
 nUkKcZpZcKAqURziv1vb0YevtiwzoWeqEK+dOLlKqwZaQ4KcpCqWONsk4JaWUznfiWpdptIXO
 Kp6YA+r3c3MbVKhEdWJI14odEnOY1XmlVZeLXut/qIew6E7wq3zbRyney+pK6HsbRwq5QWbzA
 +ysG+g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.41.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.41.0 (June 1st 2023)

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Following the footsteps of the MSYS2 and Cygwin projects on which Git
for Windows depends, the 32-bit variant of Git for Windows is being
phased out. As of Git for Windows v2.41.0, the 32-bit variant of the
POSIX emulation layer (known as "MSYS2 runtime", powering Git Bash
among other components shipped with Git for Windows) is in maintenance
mode and will only see security bug fixes (if any). Users relying on
32-bit Git for Windows are highly encouraged to switch to the 64-bit
version whenever possible.

New Features

  * Comes with MSYS2 runtime v3.4.7.
  * Comes with OpenSSL v3.1.1, a major version upgrade (previously Git
    for Windows distributed OpenSSL v1.1.*).
  * To support interoperability with Windows Subsystem for Linux (WSL)
    better, it is now possible to let Git set e.g. the executable bits
    of files (this needs core.WSLCompat to be set, and the NTFS volume
    needs to be mounted in WSL using the appropriate options).

Bug Fixes

  * Portable Git: The Windows version is now parsed more robustly in
    the post-install script.
  * The labels of the File Explorer menu items installed by the Git for
    Windows installer have been aligned with what is customary ("Open
    Git Bash Here" instead of "Git Bash Here").

Git-2.41.0.2-64-bit.exe | 23599b8a8e2c4e87a94a524b5ce9147b8e3fe1780384e2d8642517d022993190
Git-2.41.0.2-32-bit.exe | b9eaf785633fa7e68adffd1b454ce70f963adbe6aa530b8ce4ef0ffa8ed49873
PortableGit-2.41.0.2-64-bit.7z.exe | 8960ed027f94be7487e0e56c28e0fdaaf7a2dd887c35f84a89179a320a81e830
PortableGit-2.41.0.2-32-bit.7z.exe | b8411ac95f84cf5cff23f44789a9ee313fc7136a224d06cb7abf94561bb3f68c
MinGit-2.41.0.2-64-bit.zip | 06d71967e8f47f82fc2ebf9911d2cf8102221e4e22becb825e2dbec85cc1047e
MinGit-2.41.0.2-32-bit.zip | 890d7810725a2698729446143072a3191915638e0925259a2060a96383d06ee2
MinGit-2.41.0.2-busybox-64-bit.zip | 8ab102ceba7a62cef25c55564a1b519039885e3de9c57ec9b2ec8d99918ad297
MinGit-2.41.0.2-busybox-32-bit.zip | 508a6478dcbaa2bd90347d75d87c9a621fd7baf200762a2a82e77bf5872c7991
Git-2.41.0.2-64-bit.tar.bz2 | e4aaddc71f01321f8f4644944760d41158a0214585d56a0ad8395a006a3e5146
Git-2.41.0.2-32-bit.tar.bz2 | 794329f00c93a41918211933b6231cbcd4798484566de3a120427e403092c7dd

Ciao,
Johannes
