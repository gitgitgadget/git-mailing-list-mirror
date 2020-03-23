Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A034C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA3120722
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lv4cq3vK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgCWNUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:20:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:47667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbgCWNUY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 09:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584969622;
        bh=FYEpCTZh40SD39V9ieH6nlDi1nCaAPPxEJwDQGwoGbc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lv4cq3vKDNj7p6fONDdflMbmtG2jrQtyD9lUYPTsF4iv7bKU/0Lj29jcnUYEIkW/V
         0uHHZS0oKPCZHdirrBdmWl987I+KWN3klfzWzSrez2x0VGmrcRSFdfrP5CQkiLZNbL
         zodXNxEYcPLrmEeYg+3PE9ZIlZztCfqq+fvRWTo0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az764.5uvkoi5p2leu1bg455njebltkc.dx.internal.cloudapp.net
 ([23.99.81.249]) by mail.gmx.com (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MWzfv-1ijfjg2z6X-00XNEd; Mon, 23 Mar 2020 14:20:22 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.26.0
Date:   Mon, 23 Mar 2020 13:20:18 +0000
Message-Id: <20200323132018.7087-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.25.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:AgTGYL9a/VwgDk+Qtjdz+PZTnMFgbtbC21DlwaAvdRacNZarkbg
 B64HUSoZVVKkX/jIdUew4qBvhEYuF1vVYEa43aLtAroCRsf+eRYwnIMyM1K3YS+BBGTbwsH
 cg7GElKEXmn/waoQuhHgY0l/OoRVssNFgPHjXreMjuGObztpYuTBwXNp5YK6NcrQ6V/r7Zj
 gImw3HjM60PGCsYSVEvkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R7XZzKacR5k=:xrSwrJ/N4LJHHjFBcTwvPE
 o+YTuT47eviLccB154MiJENDbS0bxuyP8/j4qf8C4Ag0b+cwiei7EK2MKs/PyVJrRoq+mmwRT
 on6vVj36q0QQupBfH9+cbUKTvM59KNpC2ieyrdxCMLyeSPsWuX18lgOlzYWTthWG7WE3IK4kG
 n9MlhvPrg5W5JOyrUcRPsK+J9Q9JMVyBhhjFGOldTDdOhWkdW2SSkQPTJXiLseSFOlDiOKFAN
 CIuP9VmslYYJM1nRIhYCgmToKO7SbL2RUh42gTGXTatROoRts3L93T8q+VXXn7GwFJ0IB6x/A
 8Jj+Ui1v8bi35nLommJoiFDmOp2dDbxnC74YI0npQ2cE7BU1BSNdl3HI5MLFrfenWlfXLF+OP
 48+hXTuegu6rgCw0OaKxczhLrRgw7OhL+yg9gRzecXSu5U8P+NkZKy84w1s53iivaehhZbR1G
 tu2+Fnz+xPyqwb/VoIStax7fHZBbPzE04gaFrawdHrCsImTXpb92Gdg760qzuOri30vXLaZmf
 IBVDfeRxW8F0MsqqWUtZpqWTxgiV0foTPRNpz/U+vCQmAINoRm6GHb7e5MsA/vqubhFSjj7mf
 znkAEwFeaQwiS6ogtPco1aHwRAyv/kGEaJ5k7aVX2BLYiB4vRhTbazXHMDOsTz8INIPMthLdM
 gVtYDUDaqXoaTsC5AcvjuQ+abUFoB4pMM2IASfClPq4fxfVkJth/6oGasydz8b2yf3MVh65lO
 ZwsR+CbTic+NS6+I78hAukh1S8agko2v3HudLCuGD/mduYMm7E7tozyXHSRnToiTIpJHMpIvm
 qVb8LAtkJuVg+sFcxqYAhMChvKGSG2zIQiOnmcgUWwKxH9BfnDxdMxc7SexsQ5642CFfe0vS1
 AtF2lasps1fPpA28A+wb3ScpRLLCkPxh3jqv0FKrYX6c5OCrybODEK9pn5iNaX+eVIJMKQlAi
 tsWhQ97qVZS24pbRkUUY4Vsq8sbZ2G3t8CDfLFtoFZmDxB5MD2qn6GlLoofkEDNrQkn/xDxUV
 A4fXuRLvGcqBToYcC3jI8U4UEmuLSknMzp/yd14yTRvlTi3/UiSf897rQWrNbrbWqG3KwcXfd
 W2k80//F8VZBK63caP3wS5820lYyMHDVD/sQKyWimubG5XDmAVVNduUnnQpFH78QB5306HUIZ
 jLsbTIKqjx+CGPZl+IsqAeiv+xE14aksksFtpGNUcPKe6lpl461SPCyJqWlA7Im6cqDzelkYZ
 BwZWbEUBQV1xECEd8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.26.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.25.1 (February 19th 2020)

New Features

  * Comes with Git v2.26.0.
  * Git for Windows' OpenSSH now can use USB security tokens (e.g.
    Yubikeys).
  * The native Windows HTTPS backend (Secure Channel) has learned to
    work gracefully with Fiddler and corporate proxies.
  * Git for Windows' release notes have been made a bit easier to read/
    navigate.
  * The Free/Libre VSCodium version of Visual Studio Code is now also
    detected as an option for the default Git editor.
  * Comes with cURL v7.69.1.
  * Comes with OpenSSL v1.1.1e.
  * Comes with GNU Privacy Guard v2.2.20.

Bug Fixes

  * Git for Windows can now clone into directories the current user can
    write to, even if they lack permission to even read the parent
    directory.
  * When asking for a password via Git GUI, non-ASCII characters are
    now handled correctly.
  * git update-git-for-windows -y now is fully automatable.

Git-2.26.0-64-bit.exe | c8cd522b8a1eacd421a10591227cc6279f31485876462cd9fc335914584429f5
Git-2.26.0-32-bit.exe | 8d5e451dffb0be07c128dc21338a365aa2c81c09036a065735b42e627d38e683
PortableGit-2.26.0-64-bit.7z.exe | f14aeccf0b63700c13a9c3829c4b9a6d3933d6cc5adfbc52b5aa62921725fb73
PortableGit-2.26.0-32-bit.7z.exe | c3afa6bb711b36c5fd1e80cc7a2536b0df083511b87d9686fec713ed4f410ada
MinGit-2.26.0-64-bit.zip | e19662da49c2891cb2ac04e9f4f413d13c0c0974b6221169a5717eb62e2288f3
MinGit-2.26.0-32-bit.zip | e57761114a74a045972903146922ebe42ba399cb9e306e51bdd63465e856f5c8
MinGit-2.26.0-busybox-64-bit.zip | 24b18a2327cc27ad2e979a9543c41e6dd54cbca92ca6383d6cea6fd7d007cc7f
MinGit-2.26.0-busybox-32-bit.zip | b562dc79515f8527d6e55fcc9dabe87ad8770affd75bed443854a70b24a41900
Git-2.26.0-64-bit.tar.bz2 | c9502dedae1f9ea5b16052296f2297c28e8bd82d43f6227042e7d2f79ce2551f
Git-2.26.0-32-bit.tar.bz2 | 5e8ec3dd5d8697e64c29f662b423a50298bc3b2e8b6083c3469a02402f7c1d2d

Ciao,
Johannes
