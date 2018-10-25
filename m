Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670681F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJZD2f (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:28:35 -0400
Received: from avasout03.plus.net ([84.93.230.244]:45316 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZD2f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:28:35 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id FkmBgG7iGO2g2FkmCggLr9; Thu, 25 Oct 2018 19:54:37 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=T8oogXnD9fka918mQtgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 3/3] commit-slab: missing definitions and forward
 declarations (hdr-check)
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, chriscool@tuxfamily.org,
        l.s.r@web.de
References: <20181025110427.13655-1-carenas@gmail.com>
 <20181025110427.13655-4-carenas@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b6fe7e58-5b3f-f139-be8d-210526a26767@ramsayjones.plus.com>
Date:   Thu, 25 Oct 2018 19:54:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025110427.13655-4-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGoSLWp/pnD/SYE22R32FWh+gUSh2N5dO3W7tWVtFMnNKUP4Qp+zBXBXDOIdgX/A3gJY7ZwJuL2aSJnxtJIDiTSGmfHayFGAqSKUo5w9ridEpnmzTgsm
 equ3B8a9nr43+EpAPhgCcmLXfBOaIhBqvgpi5D85o7FXwWpQVMDJydL/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/10/2018 12:04, Carlo Marcelo Arenas Belón wrote:
> struct commmit needs to be defined before commit-slab can generate
> working code, object_id should be at least known through a forward
> declaration
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  commit-slab-impl.h | 2 ++
>  commit-slab.h      | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/commit-slab-impl.h b/commit-slab-impl.h
> index e352c2f8c1..db7cf3f19b 100644
> --- a/commit-slab-impl.h
> +++ b/commit-slab-impl.h
> @@ -1,6 +1,8 @@
>  #ifndef COMMIT_SLAB_IMPL_H
>  #define COMMIT_SLAB_IMPL_H
>  
> +#include "commit.h"
> +
>  #define implement_static_commit_slab(slabname, elemtype) \
>  	implement_commit_slab(slabname, elemtype, MAYBE_UNUSED static)
>  
> diff --git a/commit-slab.h b/commit-slab.h
> index 69bf0c807c..722252de61 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -1,6 +1,8 @@
>  #ifndef COMMIT_SLAB_H
>  #define COMMIT_SLAB_H
>  
> +struct object_id;
> +
>  #include "commit-slab-decl.h"
>  #include "commit-slab-impl.h"
>  
> 

Hmm, sorry, I don't see how this patch has anything to do
with the other two patches! ;-)

Also, I have a patch to fix up the 'commit-reach.h' header
(it was part of my original series, just had to update the
commit message), which adds these very #includes and forward
declarations when _using_ the commit-slab.

I haven't tried applying your patches yet, which may answer
my questions, so I am a little puzzled.

ATB,
Ramsay Jones

