Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED1D1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 01:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965466AbeCABPO (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 20:15:14 -0500
Received: from avasout04.plus.net ([212.159.14.19]:60312 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965379AbeCABPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 20:15:13 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id rCoQeXCVNbfBDrCoSeQxvS; Thu, 01 Mar 2018 01:15:12 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=F4V5iJpN c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=uVD6To77mxPmLAvuhhMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: The case for two trees in a commit ("How to make rebase less
 modal")
To:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Cc:     Sergey Organov <sorganov@gmail.com>, igor.d.djordjevic@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a2c44a68-9fc6-5998-6d84-aba73ea65a61@ramsayjones.plus.com>
Date:   Thu, 1 Mar 2018 01:15:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAWuuStBPZ/TA3oLVPOiuzH3L5yUuhuL9j3TOcaWtUYpZrNnj9dZ5R/W7stU3XT2mwTXG8x3+GzXosG5eq1MeWD+0f7HKkb3s6KugjSOqiunfuniHGUa
 qFFp2FUXfP3dZUD36aERTQFY7T2NAqcbdneiRtH1yQ/X3pU0ES/fd8UbgqSd4MPwrXYSBHf3LKzysQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/02/18 23:30, Stefan Beller wrote:
> $ git hash-object --stdin -w -t commit <<EOF
> tree c70b4a33a0089f15eb3b38092832388d75293e86
> parent 105d5b91138ced892765a84e771a061ede8d63b8
> author Stefan Beller <sbeller@google.com> 1519859216 -0800
> committer Stefan Beller <sbeller@google.com> 1519859216 -0800
> tree 5495266479afc9a4bd9560e9feac465ed43fa63a
> test commit
> EOF
> 19abfc3bf1c5d782045acf23abdf7eed81e16669
> $ git fsck |grep 19abfc3bf1c5d782045acf23abdf7eed81e16669
> $
> 
> So it is technically possible to create a commit with two tree entries
> and fsck is not complaining.

Hmm, it's a while since I looked at that code, but I don't think
you have a commit with two trees - the second 'tree <sha1>' line
is just part of the commit message, isn't it?

ATB,
Ramsay Jones

