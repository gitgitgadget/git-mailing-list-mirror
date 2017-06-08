Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799161F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 10:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdFHKCz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 06:02:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:63534 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbdFHKCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 06:02:54 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjJCt-1drQsD0pBP-00dX7y; Thu, 08
 Jun 2017 12:02:38 +0200
Date:   Thu, 8 Jun 2017 12:02:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/9] help: use early config when autocorrecting aliases
In-Reply-To: <20170607175122.GC110638@google.com>
Message-ID: <alpine.DEB.2.21.1.1706081202200.171564@virtualbox>
References: <cover.1496851544.git.johannes.schindelin@gmx.de> <d7b77cbd688b7536aebee49df652af594d2a1293.1496851544.git.johannes.schindelin@gmx.de> <20170607175122.GC110638@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Jr0lkYy+flzESBHAxC3Zqbf/OQdTteRjuGZ+rD89fFvFkQ+WH43
 ytKstxPNpUwFglZ3jLac8GV/7YbAkeXKSIcK/MKDOljCbL8YbXy0QkQn8W+QTfjqKkqfW3r
 WzgIIRUcl9lkwq6LsVZXiqinvMERQVdYKJYtRxzVhO2aqWtK19fS6PKMDWDrJzjMKgOrJOj
 MIL9CO+a0GWn6JIut2yrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2QC5qa6H/AY=:wo51pXcEqN+r2Es6Zj9bPX
 WG0dZDelBoIC/oaT6VrrpISkT9o1kDqTcVRnaMZdby1dodirhUj9mIITG3fbOUxEl/8U8BRv3
 h0cPFCymPsHK5ttnmLdxsu422tLt9zsddSu3E5LoV4kmUA/5aTt/favEyeKYt7a29irCab6Il
 ulPK/h221Fy/K6vtv9YjmJ/WiWlSjJ+F6zccgCOMtqGQ7NMwr1at0whNG4HpGWLhht8bmnPAx
 HdKG7fFuJuRfJWBYvXlUtcSim66eYpvoMLLh/rz2rQ8Hdr1LnnXOO2ATl0fVj2oKxYboeToHY
 G2UV2ytYYKzpbkHhTZAa7C4e4DCKL91tfMrgH1GvPXwSP+lpxnT664Wwh8Bh9NJB8tBe5J1ZI
 yAcS6fDygjKkg5wD41krXzNBDdzv6w/AD/A6gY4A7L91frvKS/UkEEyzKILu08Fpc6/zAeep4
 lJX/7wjKiMNHHofe4YBpYOrdwnOicfWv8d9MAvGxDhKq5SnHzWNucXPKFK7Pupro76TRdWaEC
 6Zuj/Sbjpvg3cc1yX7qkyVlr1L90l1mPjobQw2mYCDSkyvkuYBXEigIXE6CfyqQABkDxKmdWe
 gnoR+h50sTyo3ddlxZPEQj+UGH2WkcSvJ2vNkJnYNE6Nn2S+iLWG4NHR4bV06WwlXM0BPauxV
 06OW97c+G6tcwi3zAsq9ZGP4fGgC5fkUT4q4a3ByYwM1/CnlF6Ski3X6EXeG1L4hQizxgg7Zp
 vDm1LE3sILdh80KM0quKkr+js4+Bho6G+y5059MeKC/mG2Af8DOy+GXgqQuQvFj93BV0U9ReN
 BG4LqHY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 7 Jun 2017, Brandon Williams wrote:

> On 06/07, Johannes Schindelin wrote:
> > Git has this feature where suggests similar commands (including aliases)
> 
> nit: s/where/which/
> 
> > in case that the user specified an unknown command.
> 
> s/that//

Oh my. Thank you so much!
Dscho
