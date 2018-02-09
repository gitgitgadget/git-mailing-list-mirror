Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9631F404
	for <e@80x24.org>; Fri,  9 Feb 2018 17:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBIR2P (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 12:28:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:40071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeBIR2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 12:28:15 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MV6EP-1eBlyB0LoD-00YNeL; Fri, 09 Feb 2018 18:28:10 +0100
Date:   Fri, 9 Feb 2018 18:28:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Gregory Herrero <gregory.herrero@oracle.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase -p: fix incorrect commit message when calling
 `git merge`.
In-Reply-To: <20180208204241.19324-1-gregory.herrero@oracle.com>
Message-ID: <nycvar.QRO.7.76.6.1802091827470.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180208204241.19324-1-gregory.herrero@oracle.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cFiDXEZgA1R+Dkl3StlQZyWQ4kmUj6n0Uo0j4JqmwHPIK8vIUgM
 AC8yP8dAsp4YOp8BfJRa4A2j3Yjg89caO3BJXct4pnswn2n/tpqwIREoJHQngLM8a9XnzQa
 /5j6KqUnpKm2t2YaqYNzD7xTwj5nqQc/wapACgCU4/ik0f2q4iFyw7+Q7ne2HMIG6URZ9Bl
 zWqBAV0xGP/LOTq2YUi5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:61eAwOObZG4=:YuBmIs3Jwg+kRAWE5Xj7TF
 /24pYHWSSIVaBQua0gzWJwEN+4v56xgIeK8qOsxOzO3muXBlZVNqr/5GDy2pWNCss6+63ZLiD
 m6KRPqVq2dHO8uVFiw6IGvWkWhsc2ks78zlSrlfOPRGjQyvFNbj8SDGB4WD4zB+WDD3LcLoUY
 g6jn3lf4TuMad8HOkp8KX2xLHwPdwabepLzWszxvH85AbQOcbIGQLRqlvD0ABNLH1zbA4YzIQ
 sUaCt9JBNtiCd8YgH1xHgcV294e4mtfcgHYIcqQajpLuqRrK4/dgEuOOIzqZ5nlwdisS8wP7F
 +dB/mpc06jZsuXmCLfN6M0HEJsy76mMjjKOijxTcrbGeTW21NldamMx2qdEaXVwx4TbioA8+N
 pheTlBPhBAij2Svqgmjpe9N2pBtRCOIDhJWEaCjDuI3XyBnfj6werojYn8uuUEMeUO1a4UAO3
 qEkGfLND6Wk0GAzghp4EtwmKQTnu+AJtSM6l1Xi/xAp9hCjch0OWsZzyoR7iYEejDlbRc/0eH
 yEaa5b0Nj/BRt9bUhadkgrfjfimJZvkT4lvhLk5JXk8t5LgQjIvxODYpNjqJmKJuhoDggAXzj
 Qe3m8E/5RbjYsiCWn0KN71qQcBDuptM0Kl9oTeBFp7XaLCsBqbpN1KW6x/0NBM3DmXxGizHpk
 BeW3IzvafibwwZNWhXeSPURLjRb7UGqldSupU/SRPSFJLcJw+JCDxxBXpGx/1gS1JgRJLuF+O
 iN3DRJCNV6FeYaB5RqRzI2I2PuOr1oPTMxZaO2gQPIIrbUb0Pv5aZ48bHmwg5B1p1N0DbFJRy
 y0SgbRJ8EVOjyX+3FkfkpCfAZYq3dECNVC0rdVrXbToQIlsGok=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 8 Feb 2018, gregory.herrero@oracle.com wrote:

> From: Gregory Herrero <gregory.herrero@oracle.com>
> 
> Since commit dd6fb0053 ("rebase -p: fix quoting when calling `git
> merge`"), commit message of the merge commit being rebased is passed to
> the merge command using a subshell executing 'git rev-parse --sq-quote'.

Thanks for fixing my incomplete fix.

Ciao,
Johannes
