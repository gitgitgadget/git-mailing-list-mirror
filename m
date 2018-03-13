Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83CD91F404
	for <e@80x24.org>; Tue, 13 Mar 2018 12:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeCMMGR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 08:06:17 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:56940 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932974AbeCMMGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 08:06:14 -0400
Received: from [192.168.2.201] ([89.242.187.47])
        by smtp.talktalk.net with SMTP
        id vih1etkgHlWlTvih1e2ZyG; Tue, 13 Mar 2018 12:06:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520942772;
        bh=7LWPd0RuuTmyil5qZXkXTvX14CIVL87HXgFeSwRxn9k=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ETSyMIU6KYDrXywlLgIDZWIGRC6dtp6JC3QIxdSlqgkxOfo0Eg0XtRU78Hawu2GEP
         yVPqFHUXz2Dy+GXIAgpdPGnyMe9ChvpFwzwgDrwMMCwIMNZsoIYgN1CVXATfCaqmhZ
         gfRf/fqkd57hqssWucbpwwDNmz/tE0qLUA7yv8Sw=
X-Originating-IP: [89.242.187.47]
X-Spam: 0
X-OAuthority: v=2.3 cv=N4gH6V1B c=1 sm=1 tr=0 a=xTMdeSjPtcrjTRwaJcecEQ==:117
 a=xTMdeSjPtcrjTRwaJcecEQ==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=mX6immz-M_eJrKaGvNEA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] add -p: allow line selection to be inverted
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
 <20180306101750.18794-3-phillip.wood@talktalk.net>
 <xmqq371d3rjz.fsf@gitster-ct.c.googlers.com>
 <6476d776-dbf7-09cf-1c65-e413798b9987@talktalk.net>
 <xmqq371axxm5.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ea4f645f-5cf2-ef84-24cf-fb585f96039d@talktalk.net>
Date:   Tue, 13 Mar 2018 12:06:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq371axxm5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDqJB6hQkgI6H5zKjrzWbf6RTOv2fLzKEmHy4VoMzVphDAYBAZMvQ5qusoSXhYbjgQvSoz8mag0GY1TWs2d33xbP60+jeMWmQALllvFxrqu3nSgYgfnb
 IGfGuvcmznL3g+Yt3y15n4Kc2WW5JqtxbgQdumRNCwCwWj/4i79yVLvCSNr9PgC7xIej7Ko4egvbOpAYewjtj7Fi3jFhbHsHcl9Xn30vghvEuJMtt64i8TQB
 zkBUmo3ICPs7wi16oh4mZi/zQ3VqU8fSf7nyBvgY575XzU0PDzIgkeTXOdVz+ReQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/18 17:53, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> and use a leading '-' for inversion. I'm tempted to keep supporting 'n-'
>> to mean everything from 'n' to the last line though.
> 
> Thanks for double checking.  It would be a better endgame to follow
> up with an update to existing "range selection" code to also support
> "n-", if you go that route.
> 
I'm afraid I'm not sure exactly what you're suggesting. At the moment
the range selection code is in the first patch and supports incomplete
ranges. Are you suggesting that support for incomplete ranges should be
in a separate patch or have I misunderstood?

Thanks

Phillip
