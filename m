Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D43A20899
	for <e@80x24.org>; Fri, 11 Aug 2017 17:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbdHKRSQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 13:18:16 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:62276 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753386AbdHKRSP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 13:18:15 -0400
X-Greylist: delayed 1108 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Aug 2017 13:18:15 EDT
Received: from [46.91.38.38] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dgDZd-0004Sq-AM; Fri, 11 Aug 2017 19:18:13 +0200
Date:   Fri, 11 Aug 2017 19:18:11 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, Jens.Lehmann@web.de
Subject: Re: [PATCH v2 14/15] unpack-trees: improve loading of .gitmodules
Message-ID: <20170811171811.GC1472@book.hvoigt.net>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
 <20170803182000.179328-15-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170803182000.179328-15-bmwill@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 03, 2017 at 11:19:59AM -0700, Brandon Williams wrote:
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 5dce7ff7d..3c7f464fa 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1,5 +1,6 @@
>  #define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
> +#include "repository.h"
>  #include "config.h"
>  #include "dir.h"
>  #include "tree.h"
> @@ -268,22 +269,28 @@ static int check_submodule_move_head(const struct cache_entry *ce,
>  	return 0;
>  }
>  
> -static void reload_gitmodules_file(struct index_state *index,
> -				   struct checkout *state)
> +/*
> + * Preform the loading of the repository's gitmodules file.  This function is

s/Preform/Perform/

and a nit: There is some extra space after the end of this sentence.

Cheers Heiko
