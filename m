Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87151F403
	for <e@80x24.org>; Sun,  3 Jun 2018 13:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeFCNwP (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 09:52:15 -0400
Received: from avasout04.plus.net ([212.159.14.19]:44893 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeFCNwP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 09:52:15 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id PTQafEGhsI9T1PTQbfPLZN; Sun, 03 Jun 2018 14:52:13 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Z6vC4kZA c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=3sOP47CxTJsQGuhIQJUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH 4/7] merge-recursive: fix assumption that head tree
 being merged is HEAD
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     jrnieder@gmail.com
References: <20180603065810.23841-1-newren@gmail.com>
 <20180603065810.23841-5-newren@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d8f9f7a4-16c7-8258-1210-ad3d32f3d57b@ramsayjones.plus.com>
Date:   Sun, 3 Jun 2018 14:52:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180603065810.23841-5-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHvTmedi1Islxs+sK1LzeeAFuafiO10BxWHa6kJptPqoTV0h+SwVtsn3TPuCGzZebTu1hyUjFbSJgFIqF+vr3Yc6qw9IyT9jwX6NQveAXofmMuH/8f0b
 D3HCZ2KlvwxgQX/PlsgvWF//52DmlvPZ8Q+FPQkdZrQCgl5zOZN1bbGw7oQKMPX8rgUIXUZLCxkftw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/06/18 07:58, Elijah Newren wrote:
> `git merge-recursive` does a three-way merge between user-specified trees
> base, head, and remote.  Since the user is allowed to specify head, we can
> not necesarily assume that head == HEAD.
> 
> We modify index_has_changes() to take an extra argument specifying the
> tree to compare the index to.  If NULL, it will compare to HEAD.  We then
> use this from merge-recursive to make sure we compare to the
> user-specified head.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> 
> I'm really unsure where the index_has_changes() declaration should go;
> I stuck it in tree.h, but is there a better spot?

Err, leave it where it is and '#include "tree.h"' ? :-D

ATB,
Ramsay Jones


