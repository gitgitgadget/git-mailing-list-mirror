Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7563B1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 12:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbdBHMSS (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 07:18:18 -0500
Received: from mout.gmx.net ([212.227.15.19]:50742 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753007AbdBHMSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 07:18:16 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRo6b-1czSLz1J0b-00SwyQ; Wed, 08
 Feb 2017 13:17:54 +0100
Date:   Wed, 8 Feb 2017 13:17:52 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/2] Demonstrate a critical worktree/gc bug
Message-ID: <cover.1486556262.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vaUy9HbhMXKQI8hRl2vIe46PEzHd4+9Qxg2x+tWyJAzfnYTOaDe
 oolyu+P7dzR+K+Ucy01WmW78qskBaHCeN0I0sSslXbIxz+sjYBCpq+fC4oblP8gAr+WzBww
 2qax3fjVuZbosO6FYMTKT4Jik8kAAKNjGkalYN93olxgcv6HPZrIe0Ue3ywxXJM7yrCrIa+
 gfYk/q2D9y7UoKS8bF5fA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qzl5aUB4cxk=:yTSS5sF3/YE4XF4p4xidNp
 fkyXQn+lmgKwcKL2guWWKmVlgxPWMunCDg3t27K4AGCM3iYbhOXsG/niFhNzJtARdLgEkExU/
 jolLLAhvln4tcxdcixzvg6jlB09D/FD8lAW5wCzpZrkgtO2aYectw10IErDyziaXGHjLIwaEf
 PVTx0+8Zo/2NbljxjttiM8EBPGeJAEpIoymE+xSb05YlsfcKsDhvkfAutQZBquFXFjeNpcNWV
 WfSeayd5vnUkrqX8H1ni7LVmEmZ8AE+dxKzorOXeCDcZI1Rpl7cAOsY0ZI7pEM79PcvpoSxUB
 KapZ283IE2byfornst604LXw291lOFCU073GTdibiLCfJ/Du44bh7cLwOZ9MlyMeV4E2BJmbb
 m9OSjMTmiNu+xZDzFrdWdSMk+34C8/8PY8W05LBBsF0l/xIXywzd8/Iou9cpVylpPHzDEI6wz
 UjSvrPNbDjfYfoZOnZ9vaHeaA/YhXqToezq8XJ5xCx0275f9o5cP5r+UuQ0jExm0d2uaE6ylS
 Ppd4zh95rYovJNhK23LkuNtj4t5n0eFLD4SQYNP84R3id+oAoHPv2hGlJaMWkHlTv3XK6ePgc
 RPY30gwKY7r7F3rf4NfGJws5NEfgCIXtEzeOrsUgdEpfJvGeOmXmEofl1SXcUMlyWyutM53cd
 4xB7utpbJTTHtesyAPQ8Yf+wTzP2xv6xO62Hp9KNFPK+Tf6mRoTXdOCmQsv9VKSTX9UuXeH0h
 zEue0U9tvutRai24SekgoPT88CC8N2kMANvOcS9bxL626wj/On+/eJSOhn46YABC9qHDhGxAR
 ZcjGLf+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

... and a half-working workaround for the auto-gc case.

This patch series really is just another attempt to prod Duy into fixing
this instead of dabbling with shiny new toys ;-)

Changes since "v0":

- split out the test case, both to make it easier for Duy to integrate
  it into the patch series that fixes the bug, as well as to provide a
  little more, very gentle pressure to demonstrate the severity of this
  problem.


Johannes Schindelin (2):
  worktree: demonstrate data lost to auto-gc
  worktree: demonstrate a half-working workaround for auto-gc

 t/t6500-gc.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)


base-commit: 6e3a7b3398559305c7a239a42e447c21a8f39ff8
Published-As: https://github.com/dscho/git/releases/tag/gc-worktree-v1
Fetch-It-Via: git fetch https://github.com/dscho/git gc-worktree-v1

-- 
2.11.1.windows.1

