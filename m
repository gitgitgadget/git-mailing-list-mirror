Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A4FC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 16:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF46208CD
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 16:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Itskc+Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgCFQDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:03:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:58773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFQDf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 11:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583510613;
        bh=/fzXg53fHqPn/k4JiAoBRhDfl+LZ7KRcrT/ie3Ga8mw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Itskc+ClKTdf5IUH1/MyAo9c+l8hfutBQGhknAfO9boItr2DDCfZRlxOxyoWENbNO
         gjz4DHOCHTJS7ASOKq/kW21l90sqGVvXxLOrJg8DclmtspQwpTZ1bP6pTmYcbi5Eko
         UIil6GrPHQYAZ7W4Pk4wMl60G4XphOp5v6HRxRgA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az773.lgwt1dslmtaudee0053yusaswh.bx.internal.cloudapp.net
 ([20.185.220.64]) by mail.gmx.com (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MqaxO-1jf8I125NQ-00mbw1; Fri, 06 Mar 2020 17:03:33 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.26.0-rc0
Date:   Fri,  6 Mar 2020 16:03:30 +0000
Message-Id: <20200306160330.6409-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:RA33yurcti128ilAg/1dffgrDMmPil6DEcIwvhd4LFpMN9S/CQf
 bZOQynztTuiwUzZ3StjQ+IHc0y8XJU/dI11jiWyxdmuVfb0khZnMrYkBLC0EWeWjmA/KISM
 DfJgz24ncH7jfveNKdclalBAgTaQqu6KAs0buHBfO3YDgY+5g4tNDP+HFlBIjRspUGxKC4B
 d4NiMvaZmLLpTOwPChkAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r/NSdFNTi8I=:/R1p5LgbiYOQyqeziohs5D
 szEiEXlFzRIihix559ALzq8U63oEJTCC9+Pnt0r8r6pozyfaSQvrp1Zpn2HCoxY9yIyjIOpR0
 uXEH/B1bcGpXOyTg4V9zc10XHOgRmrTNlf4f6PVcioh5LcjketEB+KVVQyedsCi6rPqYV24RP
 jxWSAQXAT5BrfnKyE1d+e0FGBQEmbq7E+/XmpqFQH/GRKdRv438Qf9Sx22MMQeFWFzsGDC6kQ
 UuScktzDZw+eTZmbSOE3DPvxbDJACMauSjVaa9CI6hUE/saH1hOUZoAIdKzYXiAtcZFBzXnNc
 2jMUANsSuaLAE0tQxRJvbXGBDxMCZpaKJUAitff892u8YJ//Zy37nExG0HMW+QLah5D3pewz1
 r3Cpg1+FsAlvShpgCE82jJZI/izaDOJ2+pibUk2J8OoIwj+v/qXQKRFUziVhAdBZ6muivnC/G
 g3OsXL2SEr8M4aqpv+9sUO93hGEBIXOrNpg9RW+f4F8FWwDMN+oytrsPiUyKALOcpfWHugveT
 4l2ePHKSa8F9kZCE0o9EbLN0wjLTLXjuIuXWwWxxX1mq5a0Kjssl3rcgMp8wfIO72jAVfVgMW
 7FHMhkmcSgkYYOzq17CxwEQWqxUUFir+a3v5afUy7M4dvYbP/ijhV1QKtpekFlsugU7tXUyA7
 Ma9HiLEJ4gjsbOUBqOtcWe0zjbKiGM+7C/UNXbE7NHo4C8JXkBrahBCWqAn1pxB4u4La9x3b9
 NUBR4mna8nXvSo/tdXm+RKn6/tdKP1JPz3kr/Qg5QB21miDpmHMDPfQqHI6fo+dCzAMuzV7sc
 zCOCVFLfWKBmVdG+YXaxc9/jqPF3J28QRw6Uj+YeAoaokro+T/4hKAHmYQR2fA1IfGS+pfm/B
 ttk61s7Lsx4zCjXXT0r+8a32BYxyUSsJAGQGaHABI0zMviK7UHtqi+DkgJuZkyuF/KGFDvgl5
 zlq3922+k1ccqqOcxBcX90Isl2yOBjZRVnZhspsw5Yyq92EzGzdSCCXq4lJHyolYvAdvyKWZe
 zBn21QZ0OHLcvxfCRidKIdYpVj/jm24rapAA4T7+uLO0F6aP83EzWwqj3DyzFG27s0chUs631
 Y3A/8ixyyxZGLSyjz7FZDN4Bsuug+pRRpwY895J+pBN0kdzd4Hhokf4Zbe+NE7/kxT9KHtkIA
 tST+u2wdQjpx7CFoFOj2YFfpVtS9GbQ2+xQsRR3JtVZepULJENzZSSQRWdlagFNcpc4TAgyUH
 jHcClwdl3+BDOaqi6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.26.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.26.0-rc0.windows.1

Changes since Git for Windows v2.25.1 (February 19th 2020)

New Features

  * Comes with Git v2.26.0-rc0.
  * Comes with cURL v7.69.0.
  * Git for Windows' OpenSSH now can use USB security tokens (e.g.
    Yubikeys).
  * The native Windows HTTPS backend (Secure Channel) has learned to
    work gracefully with Fiddler and corporate proxies.

Bug Fixes

  * Git for Windows can now clone into directories the current user can
    write to, even if they lack permission to even read the parent
    directory.

Git-2.26.0-rc0-64-bit.exe | 5120d8570f49789439d82204a849d7b5b92c01e8abf0ef265d691b80180cb0c2
Git-2.26.0-rc0-32-bit.exe | 8a60499e0f99f717d62af96c2a9e6d76a90b6042ea738b9dcad6c1f486332c92
PortableGit-2.26.0-rc0-64-bit.7z.exe | bb0bbedfe49547391c5ed2c1c04d1f9b1efc6bad6ef6bd61a296e2cd36620881
PortableGit-2.26.0-rc0-32-bit.7z.exe | b65de03991c1d31699e43f3016f4ab3ed73e1a72c661477989ff699fa654e6e5
MinGit-2.26.0-rc0-64-bit.zip | 99d5a807d18feb823881ca06a1f619982c553c73aefd2859f9e7ac8479ddaf9e
MinGit-2.26.0-rc0-32-bit.zip | 4581ff8f1e6ec23aea7650da6f27e13694c771200f23695d4a9102e6a008145a
MinGit-2.26.0-rc0-busybox-64-bit.zip | 5a08abe581b27e8a4b1312cbb704cb07de48960452a7b98ecdbf8fc3b1fc289f
MinGit-2.26.0-rc0-busybox-32-bit.zip | 637f994d86d4c9039b33b86854ab42f0b48ba55c7e3509d2fc772b9defed7ca4
Git-2.26.0-rc0-64-bit.tar.bz2 | 1636cd2b65e8c335b1544f27f21d8ecf16dc4fb608836f7567d49a4f6d3ee02c
Git-2.26.0-rc0-32-bit.tar.bz2 | f3f2979ba674d142bc5938416e6a692332eaa769804cc9cbb4ae04648ba61b6e

Ciao,
Johannes
