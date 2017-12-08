Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1ED20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbdLHRCO (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:02:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:51194 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752484AbdLHRCL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:02:11 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6SE3-1fFtdC3SdH-00yOMD; Fri, 08
 Dec 2017 18:02:06 +0100
Date:   Fri, 8 Dec 2017 18:01:46 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Offer more information in `git version --build-options`'s
 output
Message-ID: <cover.1512752468.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+lCM/p4OFUtsjOGjadvpwkv1bExHuLhAlI8wGBv+zj+5MiP2J6k
 pqzcS9Y4Ym+VbBtw3kB3Ot5gIoCYicPw7YQk0j7is52i3bW3WnWdvE+w+5Z1O3bLQTzOa0O
 WzqnQ3hsms3MbqZp1NTm0k4tCzWfs0P56N0izEgccYsn7lWFDO75tl8B2KVgQR1H0vDihNN
 DndeT4Z8ucpoxrIuox33w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VbWEHJgFn+U=:6ajQSXC0s6HGFoUHdlacLG
 V5ckbCoNcXWkjucdkUSlLeqTA+TXQmJtCtNGBxvvSx3x+fd0FOCZ3XxBOGXE3aQwmxr4wLysL
 kvBh8iFft5+9uS+DHQvEYedxzy94GCgdpTiMc9ab/qVql0i21ZXdyA85pPgcyvmhUCjeIMero
 05I2fq+9mutCqS2QMOLrV3PPO1npNdSZqn7adAQE7iWWtWtV4pmnLaQ9z2r98imJkRRKCq1+0
 UkjVKlBJ9MbMcsdqmjg/nxvx6oNTmvFgDU5YHN9WqHu4eci8KO5LpZtSL0mBh6fpOjgwHUzPb
 YNxzs+6CaXF+R1FnDDQdL47r3fvXU8oca53NQ9Q99O/tneS/nQWE+LlrPmilfVEG0gmRJx9YJ
 oqnFfPOiCsCmujlvgUDWM6T5E/vUtLchlUGFlGvsKBLwpW7M+RePHRKEk/Dppeogt2+9nqMJE
 yDdepwFh13z7uDnFD9OCWiNNo/HbiyA0lfThdGB+BM/1NhWT0z4JDCe+kPt6cQd1PEfl+Vfau
 I8p0Wq3VDm+8fG8deoytvsEAGxxXWZ0Z8IPCMhAmXj+XY+SC5ao4pX91dhgosn2ZzTqLnUWiO
 FbNY3B1kK3GP1fn/Z8VKxY8Jf/JYfPsdebat+EtcK8Afh3BLcx94rDd7CTDYArgV4vh5q5BED
 KS9Q78TnlX2nOx+wtTUIVQ39vKelSXNXcYEKQDqJp/4e6C+1bFGmoDB+iYc/nkYfWb6l3Hcqv
 WHrJtLrpNwimCA8aBXs7WU8bNXGx4dFLbc5CGAirz0LacCkwRNd7fUhcMESmXpf6jcR/PvWh/
 ZIzHziNFVhmMgSQpXFHeyawmgIYjx2jTJ7E0XQzUItVpJObsJo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git for Windows, we ask users to paste the output of said command
into their bug reports, with the idea that this frequently helps
identify where the problems are coming from.

There are some obvious missing bits of information in said output,
though, and this patch series tries to fill the gaps at least a little.


Adric Norris (1):
  git version --build-options: report the build platform, too

Johannes Schindelin (1):
  version --build-options: report commit, too, if possible

 Makefile  |  4 +++-
 help.c    |  4 ++++
 help.h    | 13 +++++++++++++
 version.c |  1 +
 version.h |  1 +
 5 files changed, 22 insertions(+), 1 deletion(-)


base-commit: 95ec6b1b3393eb6e26da40c565520a8db9796e9f
Published-As: https://github.com/dscho/git/releases/tag/built-from-commit-v1
Fetch-It-Via: git fetch https://github.com/dscho/git built-from-commit-v1
-- 
2.15.1.windows.2

