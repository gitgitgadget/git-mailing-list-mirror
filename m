Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97FF4208BD
	for <e@80x24.org>; Thu, 10 Aug 2017 12:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbdHJMgp (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 08:36:45 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:51298 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751982AbdHJMgp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Aug 2017 08:36:45 -0400
Received: from tri.shiar.net ([IPv6:2001:982:11b7:1:dacb:8aff:fee3:29ec])
        by smtp-cloud8.xs4all.net with ESMTP
        id fmhedIzIpcQyLfmhfd4efM; Thu, 10 Aug 2017 14:36:43 +0200
Received: by tri.shiar.net (Postfix, from userid 1000)
        id DBE94FD39D; Thu, 10 Aug 2017 14:36:41 +0200 (CEST)
Date:   Thu, 10 Aug 2017 14:36:41 +0200
From:   Mischa POSLAWSKY <git@shiar.nl>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] http: drop support for curl < 7.19.4
Message-ID: <20170810123641.GG2363@shiar.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
User-Agent: Mutt 1.5.23 + Vim 7.4 (Debian 8.8 GNU/Linux 3.16.0-4-amd64)
X-URL:  http://shiar.nl/
X-Accept-Language: nl, eo, en
X-CMAE-Envelope: MS4wfD4u0F+D/kdL5Y9T2EAGupQBUeUqdbQQVZV/nPTQlAiRkfFguIbWCcuZRIuyv+kSDOz/0+IxOzhltEx3NRwDv3uscQfWMJeIL+MQh8Qr51ZGs2lhi/AG
 xzsAtjwPqspluAtbdWLSavio/1T+kdaghQUT28kkzfewsZMaySQYRExWLNNM0Dv5dX5G0BbDJQ3trQo8f/vQQRYq5L2BRuG0FlFV+9JCFcZkSqjKKcbLZBI6
 5rLtrN790I8Z/biFPFigoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> -#if LIBCURL_VERSION_NUM >= 0x071301
>  	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> -#elif LIBCURL_VERSION_NUM >= 0x071101
>  	curl_easy_setopt(result, CURLOPT_POST301, 1);
> -#endif

This seems to be an unintended behavioural change: the second condition
wouldn't have applied previously and overrides the first option
(equivalent to CURLOPT_POSTREDIR = CURL_REDIR_POST_301).

-- 
Mischa
