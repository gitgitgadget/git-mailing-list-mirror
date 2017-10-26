Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD32202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 17:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbdJZRnf (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 13:43:35 -0400
Received: from mout.web.de ([212.227.17.12]:64625 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbdJZRnc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 13:43:32 -0400
Received: from [192.168.178.36] ([91.20.60.28]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiCop-1dLG0X0R19-00nQ6x; Thu, 26
 Oct 2017 19:43:22 +0200
Subject: Re: [PATCH 2/2] diff.c: get rid of duplicate implementation
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
 <20171025184912.21657-1-sbeller@google.com>
 <20171025184912.21657-3-sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b6012c19-c067-1700-12de-2a42c25c9c7d@web.de>
Date:   Thu, 26 Oct 2017 19:43:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171025184912.21657-3-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:j/NHzjTmIl6WXirRNqe1Go72KdlzHzCXle7IZBv9iIwX40x2Ngj
 nvpHAAY4xgFTOdK+W+VpoPkf0pasIXyW8b2a0nfV5RyuvZJYlVoYWvPPqS33VNBHHVcazVt
 UsDSJH5y2qezddrW33ToPxQh9dwykhOuptf8+q3rzINiCLzCv/qEos0blxMbTvSX9eHHMz2
 Ypr+Tz2tIK/+dBx8cg3oQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nKpyqQVCqPk=:NTlP1FvV9QkSfJDYdsv/At
 a6sSlvtqlEWNeapIYjFso26OuIRhivjdB6qD40HPacD8o6wITdM2M7L+jje9O1DUPmpA0sUyu
 KTzNTs4ZjNXjLLI3FuSDIP2/i+7hwx4GZG69UwIfirIfGXJJjjZ/znB8bJrfE/RE7yqaq9zmT
 2xtrLunNthcdb08Pl5HPU0rwD+6Lnpy2y54X8XDcBSEg2egztpeD2qIPf5BSm97Zq2T2I+usS
 3FGDXdQiXNxHHFOZ8naOP5ZGlKDW3JTya+y5rWuC3tkP9WMfR39SJ7hO6VIO9VBv6RGsC1+xq
 0S3c+amK2myxc5FZAe9vqYyQPRhRY3+BbiU3EXzT2JSPIc8dVvjwT+cXa/bR7/pNIDzPrDeU6
 tWMYfUeZtWZsnFd5yYBT6GrkBkNh5GI8oPmEP3yYBTCPA1vZFOTSMbHRUfx5E3izNBP1vfiGe
 d/UFYDLgpBx+4eOjCxtbjXO4Sf+xJ+GxABtYwLsi/giSEVpjtZ90EWFbfALMHZesIz+YwwWAY
 1xnHCLG8PdErxM6zcU3wB7GQ+Ok8eIOMdPwIyex4HzJqTRY22vNZ6lEcgDEw7IC3jiyRHepMh
 xhQPrR3uyfOu71V3pEuOAzLahq3h7WwF8O247PDx49dabHE0ZRTbCChq7g6lJX92So3h6aaUG
 j/eRIaqEfP6Ncc9KNOOjR7l985UIQJFs+gOC2h1rihxZSrUkm/Q8at7+GjoX05uFEuMn9sUZY
 RcHkmXaTQUH+sPSJWtjJC8T66vzX65Mm3zL3kDyekB551CuMWulwotn7PnotkVQ2sODEHBR9f
 9W0o1lbW+lUbiOWNXmk0ZHAVk0/wpfCvYwL4uhkidlRs9fXvyU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.10.2017 um 20:49 schrieb Stefan Beller:
> The implementations in diff.c to detect moved lines needs to compare
> strings and hash strings, which is implemented in that file, as well
> as in the xdiff library.
> 
> Remove the rather recent implementation in diff.c and rely on the well
> exercised code in the xdiff lib.
> 
> With this change the hash used for bucketing the strings for the moved
> line detection changes from FNV32 (that is provided via the hashmaps
> memhash) to DJB2 (which is used internally in xdiff).  Benchmarks found
> on the web[1] do not indicate that these hashes are different in
> performance for readable strings.
> 
> [1] https://softwareengineering.stackexchange.com/questions/49550/which-hashing-algorithm-is-best-for-uniqueness-and-speed

Awesome comparison!  It calls the variant used in libxdiff DJB2a (which
uses xor to mix in the new char) instead of DJB2 (which uses addition).

There's also https://www.strchr.com/hash_functions, which lists DJB2
as Bernstein.  Both functions rank somewhere in the middle of that list.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   diff.c | 82 ++++--------------------------------------------------------------
>   1 file changed, 4 insertions(+), 78 deletions(-)

Very nice.

René
