Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032B9C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 21:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5687222C3
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 21:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Kd1fDR3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgCJVPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:15:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:42919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbgCJVPY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 17:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583874923;
        bh=BkSAtIN+I52gM+BKy8evphcqFt51W4mkJP08zDA+fXs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Kd1fDR3xTnl7SknH3xNf5k/A2oMXBb0ePe0VApBsdHg21h9oATzTqc/2tYw+jhh0J
         Y2FNZU2cISA+j5PmZcF8xrnTI3MKM7IHN4N8GWZCDM2bSQh8WH9pU6uqxUG8G3Ar0O
         prPY0wI+i0ICWhCVGLH8lWpeJtrjti55p4DOST58=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az773.5vuuk2oyafjelpihmdc2nnmmhf.bx.internal.cloudapp.net
 ([23.96.14.167]) by mail.gmx.com (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Mof5H-1jeqZP33Np-00p2ZW; Tue, 10 Mar 2020 22:15:23 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.26.0-rc1
Date:   Tue, 10 Mar 2020 21:15:20 +0000
Message-Id: <20200310211520.6755-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ymZ+YWcgAMHc/ZrKuDpF/qf8P9UJ9M4h7xkSh+7VUU/VhE8qLZ8
 JelSDziwtVH2AH30Isnwb0g/+3x4sLDyHwivazocdgnNXHMwZZW/kQkvk8QfbdDu3Ely1W7
 pIPoWGpKIGMclFhtQBqyTBAt4s433hQLDnHWlOzK0WMttxxEELQH0TRtVefJx4fXmtKL2dq
 FIX20kQCjecpNwxoj+yxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8xdCXcPAsMI=:tcsXJe703+XKXUO3B9Uq1E
 CzSJkPwke7v5i9G1UoVsOSRQdjJZR45htShECkNHENbMp8EM0GvKz1EQjU/n0uMrcHcpnR8Vq
 jZ+wVBUa3746pFMxiQ8D/eTnXLwjnAovpbIfp96yoOlk5Wbc4uBtSOA5SvBJ32M5NFs0IMnn9
 YLs/NspWzOcQXUTpaTqrgUZ/FmuoJAxWWCg4DanfQgn9p2S8h3fcEnCVn39jJPjrifbN7mRIu
 QQ9Q5S4jqrJVjYktGgoJ4jkjkurZLedPnQPtzA9E4TdkaVnY6F4+kfa4zk9kcF26ea+T2pQCK
 al+LCOOucCCg8rQIwiKxuR1LZk7Wj6PT/rknI8Ym7J5jaRtdPx2W63OtuqwW1FNw1sA5/x7iJ
 1MwwiNoqzQpdFjlr6qNhwf+G4N/BFAQ6j8nea/t3JyB8eGuPiopNbhZK6s6oNyeMr2ggnIpfx
 nkU+fJn1mBwGukGC8DOJdBC2GS9mcIgZz+Zo0yqzHJhOFoUUdevzhXisbkRQxsOq+w3/b2iHT
 Bh/SOviSK93nx4mQe0cHAIkhlyrWNblDDkKEtQ3ENpFvGF4ejm06o4XVv1eWfipw+5ROqLF4E
 exmp3BbxoEwsPeLM81G4kZ0pLfOU9RjdsJknpuICYPvlFZPWXiHGQWOvOCo3r32U0LyFWen82
 VkN/eLomBizX78ibUqMDwYf6itSUglwBY9cvrzQBaXul5MdZBMnMOulMscfr72SuO1dubSKFL
 58OEXp9NV4jH/eVmbaroxLo4hT82DXLoKFGDR7lQGV9xQqW+HDD40Y+zis6qB7RauMcUlFGfp
 JjFcIscy3iUOPVKKB5N3gS5Y2hvKBv69ZIXafFCc14u33EyGfwJ5f2yefOx41GwNY3ckVdkRt
 /5SppylI+9IaSwH7ng6GAjaUV4yfDuwZFMiTe0sZ0+9UomaiSJ8X/ZDaZNK5ajZKTOyNFikRw
 hsgcAOYZ0+i+D9Xorf45WypkYOvTxfilrXLExvKHq/ip8nNkqZXF8cGWN0r/NcAYh38opQlW3
 nwbHvozJ/U8trLfY8NIqrrKtlU0pySwJxiwN/pXrUWg5vqMPWCBpOwpjqQO3B3rFAucot8dG6
 yOYt0el/uOwpUKh7R9yzYXUtHgT1iY1gpiLBRXxGBCRj7a2O8j9pO9SMK9rDhAlVAq3FjRiT+
 9M8WbSxzWGRq6XwhiuHbh4Wq5MPKqRxOQWhwQsg0gfyU5R55+Q33cSFLTVjk0uD0VhtsTENFk
 w33yAspPb0sTX6JaW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.26.0-rc1 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.26.0-rc1.windows.1

Changes since Git for Windows v2.25.1 (February 19th 2020)

New Features

  * Comes with Git v2.26.0-rc1.
  * Comes with cURL v7.69.0.
  * Git for Windows' OpenSSH now can use USB security tokens (e.g.
    Yubikeys).
  * The native Windows HTTPS backend (Secure Channel) has learned to
    work gracefully with Fiddler and corporate proxies.
  * Git for Windows' release notes have been made a bit easier to read/
    navigate.
  * The Free/Libre VSCodium version of Visual Studio Code is now also
    detected as an option for the default Git editor.

Bug Fixes

  * Git for Windows can now clone into directories the current user can
    write to, even if they lack permission to even read the parent
    directory.

Git-2.26.0-rc1-64-bit.exe | 7447a261760145602736497adbb4492c84af9cf3b44b5d3fb4bdc15c8a9ac657
Git-2.26.0-rc1-32-bit.exe | da4fd985249b8cce367fbb556bab0741e22ce16baff5fb84bcf7f18ea1dc03ca
PortableGit-2.26.0-rc1-64-bit.7z.exe | c2df8c33084e62f69d73b71fdcd58deddce1b292a6404bcbae66c3ee20c081fa
PortableGit-2.26.0-rc1-32-bit.7z.exe | c88b8d8380b87b954388fea17a9b78757062dd4912c293014ecdc81934d76709
MinGit-2.26.0-rc1-64-bit.zip | 13a7f99648b6c9fef1b0fe55ae21e90b9a6684f964cf566265de86762d1152e7
MinGit-2.26.0-rc1-32-bit.zip | b92e2d924d2ed27d8a0de1aa474f5d5eec660eb91028fc56906a3f529dfd05c4
MinGit-2.26.0-rc1-busybox-64-bit.zip | 7986aa5656209cc82f7db2ca08557a2d1ee510a5fbb8050a431e4787a2e52616
MinGit-2.26.0-rc1-busybox-32-bit.zip | 21eda67623e16111867f5eed7855b1aefe1c79a7684699c242f5cb678dfd1b05
Git-2.26.0-rc1-64-bit.tar.bz2 | 9254b94723cfa422102fc739facf617ad99d3a90aaf8a2caffa38937578e4f9f
Git-2.26.0-rc1-32-bit.tar.bz2 | b23015a5d3e428215fa30d836b1426b2228821997fb26b1e808cef1d54bdc556

Ciao,
Johannes
