Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93C11F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbeFTUFk (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:05:40 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45569 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932654AbeFTUFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:05:37 -0400
Received: by mail-ot0-f196.google.com with SMTP id a5-v6so898392otf.12
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L99esiMuIiPR6h6VgmsM1+TBb6V3XjjsHil0o+hLoO8=;
        b=ddNKXWm9sKbZA1iQq+i32e+5RdWN7ubmLVTt2SovF1BHU7eVKEkp8XvmBVhmr3deRr
         IkOsmcdGjc3GiHUWMNcP/nSRcIsBuZIhgxzewn5Cx+fcUXg23QASs1C3vTtgdImLWxXd
         idq4tQlnUmB/jGwSbp76YoAYNkroAceFGCcQvDwAB8DaW1uVmHYClJtDB0y/IO8V2Ap/
         sZwA/rUpvP1Kiyh5VC2uW/HC+mnqpIaxqE/0nx0khD/mAJTUouyYSo06kld8CQbY8O1b
         FfTeAhZ/xud0mTlEPNwSi+FCeN/29gsByNfKBlbg5xv1Y8Da9JCu+h8FzeSEoUeltcYR
         is+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L99esiMuIiPR6h6VgmsM1+TBb6V3XjjsHil0o+hLoO8=;
        b=isdzawYChQ4JfLzABALx15I4h4owtYz8C9X8NpidIAncrpXLpwE+AR3H/EVcYxKsXH
         +uj4YkvJM4WQ9hkyVfGNoTxeyHqe54xi6GCWPMbcV2e6zBlMtor7N6tvDtWRgeq/r8bQ
         WqauFE9S2spGbCVaC/tTgx88cNY4VX0pCe1d3XGVC6hFRhIwHIeAUNRZTG/idHw6sclf
         YmcpdQenmrtitSvhUXVRIncDnwE6Z93JQKFaIzxhLM9A6X2iui2po4VcFHxKDMAtAMcQ
         zK5I4frYkD9EgP1fcjehdkYIVtWCnpoOoDaipPkBj/bnFcsXIpermmLuJw89rxS9nH3f
         YjTA==
X-Gm-Message-State: APt69E3LLOvI4zwK86DntDFYWB6Sm/0AHiPgSsLQez5GlpRL1mwkhFdz
        svhue24/B9rlXNoVK70f/q8sgB5daQk=
X-Google-Smtp-Source: ADUXVKIe+TVEKm2BiO8EtrmC68y3SKGA9YqYCk24THhetLw64xCKi5gH7oeHZDIZ0P1vjizLxJtuRA==
X-Received: by 2002:a9d:4a0f:: with SMTP id h15-v6mr12890004otf.243.1529525136138;
        Wed, 20 Jun 2018 13:05:36 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id t7-v6sm1619158oth.12.2018.06.20.13.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 13:05:34 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:05:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 1/7] Documentation/config.txt: camel-case lineNumber for
 consistency
Message-ID: <2da767ef5f90a06df30d85c99562cbe0d16a2e39.1529524852.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529524852.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lineNumber has casing that is inconsistent with surrounding options,
like color.grep.matchContext, and color.grep.matchSelected. Re-case this
documentation in order to be consistent with the text around it, and to
ensure that new entries are consistent, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..58fde4daea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1181,7 +1181,7 @@ color.grep.<slot>::
 	filename prefix (when not using `-h`)
 `function`;;
 	function name lines (when using `-p`)
-`linenumber`;;
+`lineNumber`;;
 	line number prefix (when using `-n`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
-- 
2.17.0.582.gccdcbd54c

