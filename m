Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11DC71FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbdFGQJW (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:09:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:56926 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdFGQJV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:09:21 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZkv0-1dZlEK1wcw-00LSqi; Wed, 07
 Jun 2017 18:09:06 +0200
Date:   Wed, 7 Jun 2017 18:09:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Avoid problem where git_dir is set after alias
 expansion
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.21.1.1706071808040.171564@virtualbox>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3hKBgSH0HzIGskZ+kkd8PWcCgN0Wq6W5nx++36E0pK0jjjoy4hg
 xXEgXpe3my4qelhiSpPfrxsv3LKiTgMFEzCmOT14gzDt5+XkIZ4e9hD24guSeIVAmmTq/zH
 4BHtIyVU58nq/U35vV2FkthxtqzrZwfZsm061jPyExZ5MnVRDUuz5DEI8RIcuddUD8zqDQs
 VmwIvfyNLstg2fRgHl20A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iJI88fMN/3M=:NEJAN0vvw62oy1+Hvqtx5n
 Ah0WyaVWbFg0oDgSUc5ouC7V/xxBTeUgP9cpDD4ZTWijYoeKkMhGhs80W1T+23hZsj3ixGRSD
 5J17uCdWZj/NCw0xAFjDyNciAov6nU65GttvmrH2QYqmMMHLk8X5ht+BfkzJ2KdF90e7M/pnz
 va9UH08KVgmuYcrA4JrgnGk7Vm8jQU5hZ6jlPyzTV0uTLWoUHnR8SFY9e65v/lSI0J1USdCIv
 KA+GwRVAuX2nhB+g7keAFteA1PKH1pAX/PsvbZGdN4Qbz1b3qDTeyzdCMgJBwMVGlpfyh+sTN
 AWGwKokzqgRC+HVR3H/mvClwwC9PPyuX0mlVY4d0bN/6I7Zpj/9kSew/8/XYnRTyHsmCl4kxq
 soowFYTrVuu+f0vXHXjtMhohiR/2UTAHbKRq+j17vC6r4iztoBWANPQlmoaTyQ1WFTLyvD1Ku
 AP/ML7axLn/LnxpBzDLbICO0h9ja+aTamnDBbFwYRNu15NVVDVzSrYaiZ3MbbTaBoSVmRBiPx
 xPVSD+9YbMgdIzlucLvzTut/USNgNBABtJCf1bGgWJGvJThUlvfIsvfwdzLTcflTTjUHGtMyd
 eYifAWK2pTpiSQzHoyLdap10EMsPC7Tws7kREnKmQDrzHW8PrsHPPeD8bzgA+xXjWTCWO1U4A
 thX4Pu3zVoFAuGGar12kUrP6nbMPK6RpoCXgJK2jagFcY/MMISMrGcln2AvpBa7/LxRqVnTB8
 Ly5lSJE6PM4SYFsst0ysHAGYaK84s3SfVcM4tKW/+j8bcCPgUMzhfL+T2BdHa6JEV9fS99pIq
 DwLft4Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 7 Jun 2017, Johannes Schindelin wrote:

> Johannes Schindelin (9):
>   discover_git_directory(): avoid setting invalid git_dir
>   config: report correct line number upon error
>   help: use early config when autocorrecting aliases
>   read_early_config(): optionally return the worktree's top-level
>     directory
>   t1308: relax the test verifying that empty alias values are disallowed
>   t7006: demonstrate a problem with aliases in subdirectories
>   alias_lookup(): optionally return top-level directory
>   Use the early config machinery to expand aliases
>   TODO:

The 9/9 is obviously an empty commit that I used to track things still to
do. Please ignore that "TODO:" entry and rest assured that there is no 9/9
in this first iteration of the patch series.

Ciao,
Johannes
