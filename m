Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F1EC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9869A20727
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZWiZsVjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgEORcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:32:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:42823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEORcq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 13:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589563964;
        bh=/gCZQ6La9EjFOKqH0v8b45nP7c/VTNahbTs8akt6CqY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZWiZsVjF6X0jQny0AYXBkqqz7JQHoyP+MeSC0ZGr4EluJJsQuIpssFg+qP/Q+jMsi
         ubQFYcs7SHsCfvdJt2+IwXNHPW3vfdBBu5ra9LtwkTS1qUh8p0brPN6UVnu/s4sRHy
         soiBWdk4iXhTAElLW7upSKuXlo4iV6rk69JbPrrM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az767.ypeuddkxwkxebentlcud2u5bld.bx.internal.cloudapp.net
 ([52.226.64.24]) by mail.gmx.com (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MA7KU-1jO8fO19P0-00BgBL; Fri, 15 May 2020 19:32:44 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.27.0-rc0
Date:   Fri, 15 May 2020 17:32:42 +0000
Message-Id: <20200515173242.6154-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ZacoQl1CSfqkr0H56dPfuYuAdE1hj9dmaEmE1jzSuubPwmdx2OH
 cSIbCM3ghsLtbSXA7ragJZm3ELlKSSpbFfPAOsGhzinsm0gZv1+qQu5CNmHcfDZC4bCuZBD
 3NOxYLscIJqdvH690vv3fNc8mcsVJEub639FPGArAPXD91xi93NiQRnS7jtOKy3juhle7+W
 rMQAnaGeGxo9PS3AgHX5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SBiawaxxP0s=:IXTBCQRyBs4vrQY7R68IJf
 nvetG1wlEMyYDlHNEy60WWMJjYWQe6Wa9/q8F+10czQHokKxku6suSPq+gfJ5zhko/I+bhrT9
 hHiDbNFPFlw/5Y4u6wvzMggw8UdCY9pYBqL6of5V5GpYTbdvtHzr4JXMJ3vHmpCW6P+YNaLwl
 KIqoyWKuNd49peZjFJE6n5430AX3nZPH9SWHb2R1ekUJ8EZCz2G8ES7ib5lfX2IP1LMfXZrEP
 INwFVYFrxYbbfldABYqFbzRgQfXEHAfO6vOLuUguaBqSMIJp2LpUYZcOm3p6cbVmSEBJdfx+i
 yTsyeJv9NQVkNRn2dBbow0Dr02mYXMir3DCOYuqAo3ybc+zmqQkp+Z13qM5pXPy/mpP6dtEYr
 qkJ6GPw+deh8uF7Tss1cXd01RGLwNs+p/G8xJlhl/KAeZdyF2vMVJqbAPCQUMhx+ar6bZpNQp
 pz133z+QZrIY9vhdXCE0Hv9WNPpEBKhqCvXUVtPugb7NVF7DwqbaRp5pfm8ldYTLe8FodXaQc
 NUnuE6paIAQlCNzPCh7kcsYHpkUbBP1sI/HmKw2ACLkCSQeJz8GDoqetiUiXpgaWHv0fihO7y
 TIVI+CTW9FdvlwqunqvvvNBlmM6dehQJEK8u2NOil0yEVu2oTmDHxuNvMdpBA8jl8nX2ng7e1
 KASIwAMRaQW19i2gQVq+88wsfeb65nGddV5S9ErRdtXc32nNQEdLp+O3eGQNtO1g0tlXUAZyB
 nIe1DSDROuGlbi3woAguVReKuED04TO85PToPwD1ldpqAfRKrbjSpGfZlmwFn2QrGaK+5ivGr
 Bfqaq7P5WvPg/hSfjZpw20hyZRM4d3X9GYzF0sPTOEvbA6YLCWE8wkDYwIj0EYKBrDIUF4IzG
 Qv/zGYjjH3KYT/qMnWR7AW+Sc9tYisncJCd2z7/0jOiWhcRBf+Pn9dHPPMgWM9caByk0zJivg
 Pabgj5mlS2YubvlOnp6la9aeTmbzhS46MLewpj0MntSrBXhAZIfd8JRVPQy4A26H0hMfmlZvF
 29quisHAONAisRFp758ptGBnaeyx4VB8kJtK9nBxdqDY+0UfaNZBleFggiNQJL/cdb4RvhMQ4
 IGxnF1P7iL/ddjYa8xktEPzZu/UQq9vSj2fHZ4GpWouXPWY2wp32ClrVN3rZ4eYyBb8wx8IVX
 Qk33ah8CIvPFTeRCuwSTFWXxqK4S/S/aXNILAJ3k+c8oPHfI7PQ/jZYL0Mp1SWsptzZL4+rvI
 ELAoPGpOqMakioAUb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.27.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc0.windows.1

Changes since Git for Windows v2.26.2 (April 20th 2020)

New Features

  * Comes with Git v2.27.0-rc0.
  * Comes with OpenSSL v1.1.1g.
  * Comes with perl-YAML-Syck v1.32.
  * Comes with perl-HTML-Parser v3.72.
  * Comes with cURL v7.70.0.
  * Comes with subversion v1.13.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.4.
  * The release notes have been made a bit more readable and are now
    linked from the Start Menu group.
  * The Frequently Asked Questions (FAQ) are now linked in a Start Menu
    item.
  * Comes with perl-Locale-Gettext v1.07.
  * Comes with Git LFS v2.11.0.

Bug Fixes

  * Some Perl packages (e.g. Net::SSLeay) that had been broken recently
    have been fixed.

Git-2.27.0-rc0-64-bit.exe | 14ce81a30c383caab6e31387a4aac1b4b738b63ae33461aac1858f9b878cf530
Git-2.27.0-rc0-32-bit.exe | f38d76a6dc241c3a1d06c15dac79773eee1dcbf9d19bed3ab3fba18c5a08e58d
PortableGit-2.27.0-rc0-64-bit.7z.exe | 90536da1847926b91017736753661c52f01e23842f8fca2a06a4fafeeddac22a
PortableGit-2.27.0-rc0-32-bit.7z.exe | 91a47f140e23e511bb89971760de6a2510ce399177873352e31efcc972abc0d5
MinGit-2.27.0-rc0-64-bit.zip | 5b3e9447c3ec2dce971b3f4ce02f1f06fe4f2097a753e2282306a885a16f3373
MinGit-2.27.0-rc0-32-bit.zip | 631603b87409e735f0e3fde53d46a53d4f191ba40045a049b9f6363a692ca18e
MinGit-2.27.0-rc0-busybox-64-bit.zip | cfe168171ece1b0f8b3df04be3a6e955943d9be0ef9b6f75f042710cf379b642
MinGit-2.27.0-rc0-busybox-32-bit.zip | 1de6b0896fb813ff2f921e34a84d9b44e0ba9b44ee68fad85de09c415d834b24
Git-2.27.0-rc0-64-bit.tar.bz2 | d62ab1326de35486ad78ac9b85c8af448bbb3745f0388820e87534ead48b6869
Git-2.27.0-rc0-32-bit.tar.bz2 | 3e0b27f0f46b59b052fe02c0b0e4ca0cd01586e82ef30da093844b2aae53d4a0

Ciao,
Johannes
