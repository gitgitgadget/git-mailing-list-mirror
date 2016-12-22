Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181BA20968
	for <e@80x24.org>; Thu, 22 Dec 2016 21:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941184AbcLVVlN (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:41:13 -0500
Received: from mout.gmx.net ([212.227.15.15]:55827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756573AbcLVVlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:41:12 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M86PB-1cXjue1ub3-00vgG1; Thu, 22
 Dec 2016 22:41:09 +0100
Date:   Thu, 22 Dec 2016 22:41:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diffstat information to rebase
In-Reply-To: <20161222185609.21139-1-sbeller@google.com>
Message-ID: <alpine.DEB.2.20.1612222239390.155951@virtualbox>
References: <20161222185609.21139-1-sbeller@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eZudV9ZF8TzjFWKGSZs5o3h1xMiE1XWnU7aN9Qxvf91a6kCsAGd
 qDvPMwgQ7k3Bpt3lTWSsHcA5VpBrfKSWFgcpEDzinIR1maNNIaDb4JgBunEoeqsAXoHxkvN
 xCVyuUBJMspLAcfDJ9HflbRABzMt0/OJ+wEV7tJYJUB1xfItU7cq8RMGaMdrQOZkc6Kvb3B
 tK+rllCE83F/TRIMVQwBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5flWPVIkQUw=:oPqMwOTzcv67yroNFGsq4U
 3C1CKzDRcRNHIwTKfOalvgpvEwkRneaWN5F8OrTtmFuOMyVXddJLdXtp3hidzclwlJvwB1yb1
 DUoozPduyirpSaL6mWoGDVE1ZSqoiJv3OToVi+LmEmXLAWzoxRfOGGW7x2Xge2ttWTC9ZXJ/G
 8eDWDOnGmdDux+F1C1GXPDt1E33CvWqDsS7CSazkyrrXOx+bm71+PbmOh0CgnmUMir6ZMKt/m
 +hAUC/JFm2fYHWDKzF0/mWPZ+HyWKELked3cIAnTduvIJwE8IDRTBf75hJtItKf98RLLASCLc
 TBcH43sBxShZXODFlKeKb2Vc2bzoBsnqXsjPl9yolZ+2Ush+glibYhxFbbQzo/5lI5MdTrc/Q
 8DXuegPZ3HnYG+3/TkA8rTfpMALAzUyBTqeU/pj58V0IvAQGXP2I9ILYP6KcObB6EOlGayo5/
 9w9fg9CW5IhuuWV5/jKKsJznqMUFl0bR5+qYFCwarqyMll/18SE9hcvsp/Xhzh+t4MdT/JoIc
 NN0DQwAgETjVDQ9T63GnmH//vwMOboaGB1D40UTgWiUsQ+9zs+HvfaP4iTOzPSJGTm1gjGU1C
 Kdjt5GZf2F4W6nWHjNIjVH/XJXXR0pMMwoOub+BY3o977G51gwkvFa2pSIBLpVJ3XBXSjSwWS
 G3qtrZtKXFbnkcXFUwi/xk8t+VmBUDIvlpWEorE04ZLG4STeGYJZZICQvvMZM3QfRw1taHPE/
 hVB3IKbrwi4PEgteQqilpO6nQc9kOJP7SPT5691WElwx46cE8tptQBh3p/Jjl9+31KAKju4eM
 7SKWik0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 22 Dec 2016, Stefan Beller wrote:

> This is a small hack that adds the diffstat to the interactive rebase
> helping me a bit during the rebase, such that:
> 
>     $ git rebase -i HEAD^^
> 
>     pick 2eaa3f532c Third batch for 2.12
>     # Documentation/RelNotes/2.12.0.txt | 40 +++++++++++++++++++++++++++++++++++++++
>     # 1 file changed, 40 insertions(+)
>     pick 3170a3a57b add information to rebase
>     # git-rebase--interactive.sh | 2 ++
>     # 1 file changed, 2 insertions(+)

If it helps you, fine. But please make it opt-in. I would hate to see it
in all my rebases, I find that information more confusing than helpful.

>  git-rebase--interactive.sh | 2 ++
>  1 file changed, 2 insertions(+)

Oh well. I guess I have to modify sequencer-i yet another time.

Ciao,
Dscho
