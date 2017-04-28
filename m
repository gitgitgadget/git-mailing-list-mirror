Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF1E1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 11:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbdD1LhI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 07:37:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:64183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdD1LhG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 07:37:06 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Meduu-1dSLHY0Vei-00OHGB; Fri, 28
 Apr 2017 13:37:00 +0200
Date:   Fri, 28 Apr 2017 13:36:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/26] Address a couple of issues identified by
 Coverity
In-Reply-To: <966db3c1-a2e4-1309-e178-b885d2a1108f@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704281334060.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <966db3c1-a2e4-1309-e178-b885d2a1108f@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UG1zPUfhquSAJ/b1+60WzCtmV6k88DyVI+QUReW70VIWwMrp0yd
 0BTEvS6tca4y7LYfrH3+JeJRYTBjXBcVwPByvuaVRb80QUGfLYAzK5WriVtegLCcoQIds3F
 2RxRimc6S12j6OwKN2t8ry1PoR0tZzd6hJdn5igTgKGwATiI6CH5vuFHnDflDsoovIsM+nb
 2VE33RiiYSvj+TUseIVEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AehKEs5t7fw=:Uw3d7SDdtT/sCyq7qZUSFH
 ZqGybkkl2uH2ycfCVyriDOSPceME0ZtD7g7DfjevG9u83hudgrYv4Y8IOVMZhueDQFGi5DBlW
 QCBrPumQtseldbl1pLwawvdroIGDgNTYczu3GJb6JaODf8SkNJJS/TDuAEQbFmzxNrE0miUrI
 emr/L1DCf2/dsfaBPCAxy3qLPS8nqaOY1sJUmPjUHfONTIfXRqzqZhGZZ4tWTHncpYUq1nd0T
 vMktrSptEBXEsfNeyil2lZTeW/1SphyaeGjhwUONl26bSCWv33DbcVPfRcM79jeuGzY7jvmbP
 dzGmWn2L4RywRR5Mg8q4tBH2SU+w/rFL8bgTLQ15ib3r8+Llztey2ovqNOo+p1R6+KBo1WHsS
 8vm1prJgoeIMQY0wbXN75uo2Wyo5w6RWzQONsrZprZs9QHO72XXXDcC8ZlspB4HBvEP02FDbq
 UWRY5uKLZJKBNxSd1sEGBzOtoRhQ/LhvWMiB4ha8riSIw0PtZDfyuFk6KlnZIdM/lonllmQ7k
 J/rFQ4lsIchY/eNr9ywtdal7JVcIAzPRAaEgKaC/PQhx+8ZFv4WchEgMbSwYPi6NTaoIGlsOA
 csKMIsEd/ABcmUy3CCUp5tKh7U2eECKqcWnPbpv2TWi69291eohXxsqQcEAJcVmubSKFdRinN
 meCDzJ63PJyY6+GL49yNj3fBD0YS5PE50XYJt4ZxSTVlJn4u5zfd+DhduBqLfoVjO5FFHSHcK
 ZXwG0ckmwp9u+BYABZLJpJkseVKlNn/40/7p/gwiUIuBJIM6bgQ5j5b7b0mG3XMrSXA8uc559
 6l7lfDD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 27 Apr 2017, Johannes Sixt wrote:

> Am 26.04.2017 um 22:19 schrieb Johannes Schindelin:
> > I recently registered the git-for-windows fork with Coverity to ensure
> > that even the Windows-specific patches get some static analysis love.
> >
> > While at it, I squashed a couple of obvious issues in the part that is
> > not Windows-specific.
> 
> Thanks for the fish. I'd looked at the series and had a few comments.
> 
> Hunting memory leaks is the way to insanity.

I hear you. Loud and clear.

> Never again am I going to help with this.

Awww? And here I thought I had your attention... *sniffle*

;-)

> I prefer to rewrite this codebase to C++ and have leak-free code by
> design.

I had the pleasure of working with some software developers in 2004 who
were experts at introducing memory leaks into C++ code.

The same bunch of people later produced Java code that sorted a string
list in cubic time (carefully avoiding java.util.Collections.sort(), of
course).

For every fool-proof system invented, somebody invents a better fool.

Ciao,
Dscho
