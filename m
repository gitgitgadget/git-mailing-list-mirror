Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7E3C11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 00:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97C661D81
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 00:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhF3APg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 20:15:36 -0400
Received: from avasout02.plus.net ([212.159.14.17]:46947 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhF3APf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 20:15:35 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jun 2021 20:15:35 EDT
Received: from [10.0.2.15] ([195.213.6.104])
        by smtp with ESMTPA
        id yNjPlHzz17QW9yNjQllqBg; Wed, 30 Jun 2021 01:05:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1625011535; bh=7mgqyQ9eHVXAk/w5uY95doZxS6dOnZBq2pBu03w3+Eo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Cr7bBeZyf10+hTAGa/GTKlkjv65HP0N6Wi+w2iIaMiSBtXvCJSGC3WigCV7/UJRC6
         jTaa9wLnXzTh1V8jVs/MMh1bQepWL2sRC71SaGS3HBizjztcTL5I7ANJJOneDLMprT
         Cm76qlQZeT7OmXkpzNOykbeOQKHp8HLStfsZZsnycNLEZsqjuVRfdyaX7FaG7lf97A
         GJtOozr76oN6T805twJ8+BvIrn7E/0YkVAjhet8GQmCXRmrCJHSwrxXm8uhdRUA3QU
         zM0hzp+7+jSRD3KeFywimnCwN+KOC70dL0QSAWY1hUPrizj/NK5SldqAormmPurDO7
         UzhYMbU2Pz1Zg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=H+BAP9Qi c=1 sm=1 tr=0
 a=lJROvGMFj6EKeLAuyrqflg==:117 a=lJROvGMFj6EKeLAuyrqflg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=WhUJ6HUwzuvpw2ubqXUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 4/5] Makefile: don't use "FORCE" for tags targets
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
 <patch-4.5-b924cc3f56-20210629T110837Z-avarab@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <67c45b13-df8f-8065-377a-fbd2f80992ee@ramsayjones.plus.com>
Date:   Wed, 30 Jun 2021 01:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <patch-4.5-b924cc3f56-20210629T110837Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOr/Nb33byJCOR7VWGCGhz7oS1KxTF3hBaCd0MhZWdprD6C88Ie59QzGm7IasSNjgUkwjpxTASyfvxln0LHRbcd/b8a36KIBWgK0SAj0PvQzsvm9jQYw
 U8e7XN5Xl9OjzdFHDrlcox82u7IKO+SNGBO+N4WvLy/2X4K1ini5PQ6CTYxfbQ2ZuSIdd8kv37ZGbg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/06/2021 12:12, Ævar Arnfjörð Bjarmason wrote:
> Remove the "FORCE" dependency from the "tags", "TAGS" and "cscope.out"
> targets, instead make them depend on whether or not the relevant
> source files have changed.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Makefile | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 2e3b257164..7b0d9773b0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2727,19 +2727,21 @@ FIND_SOURCE_FILES = ( \
>  		| sed -e 's|^\./||' \
>  	)
>  
> -$(ETAGS_TARGET): FORCE
> +FOUND_SOURCE_FILES = $(shell $(FIND_SOURCE_FILES))
> +
> +$(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
>  	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
>  	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
>  	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
>  
> -tags: FORCE
> +tags: $(FOUND_SOURCE_FILES)
>  	$(QUIET_GEN)$(RM) tags+ && \
>  	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
>  	mv tags+ tags

I was expecting to see the above targets to be changed, similarly to ...

>  
> -cscope.out:
> +cscope.out: $(FOUND_SOURCE_FILES)
>  	$(QUIET_GEN)$(RM) cscope.out && \
> -	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
> +	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b

... this hunk (ie. 'an "echo <list> | xargs" pattern')
Indeed, the above phrase was taken from the commit message of
the next patch (5/5), which implies that this change had already
happened (presumably in this patch).

ATB,
Ramsay Jones

>  
>  .PHONY: cscope
>  cscope: cscope.out
> @@ -2923,7 +2925,7 @@ check: config-list.h command-list.h
>  		exit 1; \
>  	fi
>  
> -FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> +FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
>  COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
>  
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
> 
