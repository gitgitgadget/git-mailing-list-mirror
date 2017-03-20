Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423E62090A
	for <e@80x24.org>; Mon, 20 Mar 2017 20:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756583AbdCTUHo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 16:07:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35521 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753218AbdCTUHn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 16:07:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id n11so7497259pfg.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BzP07YCzs09Hs5YC9ZpoTNCO0l+qmjHKN+VpPN7bBIU=;
        b=t+8ZtvmyRFVEIDmVOAgqVUrSNH10Gd4zon2Ba5mslBEjJnXOiDd8nBNQjjbuMLMab3
         MBP/irqsNaL7toLZsUazqYjLERGkp+t4TppPYnrm7gdbrAASNSQxP9SRQDAhYTfBD0eg
         NztD3fzkzaATAUGBREosSh3UZSO5nYdSk1LGIpqkAN8/8cGmwD4xSlUdnVTojW1g/NcN
         +KBl5NpKUWRrcEN7QFGecTsQn4PD5/c11ReRq6mmHtPY7Y85NBGrTQmuU/3MXxV6IA8J
         G9PrqT+0TLn8yg4xBcEuDN9ol5DyU/6PeQmeJ28hxuI0o99l748u3zt3+KzTLqB2zk+W
         gelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BzP07YCzs09Hs5YC9ZpoTNCO0l+qmjHKN+VpPN7bBIU=;
        b=F+ZznyMkvcePVuh5Gpx/IB6D4Ym6ZdGp0NfFAF7LvnX22CsSSTgbdQy2666ojWb7tg
         QcsIRobUld8GxOaR9jgjtbUIaj+opijLfXSExjDnhbAzxFi3r4kU/KHz6yL4OKFjSpaB
         y9AXD0VmEusbCUFB94xVUqsi40NBJqcIl+mFw4NKcqbmZyjhPgIzBFA2GkZ1f+jsM6He
         lBKTbineyT9X1HMeRnQeGA3EfwpUi23DBJ0tBG88T5EZ8oeq6iGoY4HJsGzV1ghc4lyF
         G+wXc6wWxyuyoobOkczbUA0b/pdBhhY07tsGNlF74kwZT2WeRqeYOvjLc0mpF7AgHOLf
         ApsQ==
X-Gm-Message-State: AFeK/H0UIdnLBI30SHEV/WcSeYSh7nEK34EQGOIzwQ+4e4wPpnzOHVThj76t7rm9xeN9cA==
X-Received: by 10.98.200.19 with SMTP id z19mr35592728pff.223.1490040054252;
        Mon, 20 Mar 2017 13:00:54 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:1478:9e4b:5dd1:a569])
        by smtp.gmail.com with ESMTPSA id j62sm35063776pgc.54.2017.03.20.13.00.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 13:00:53 -0700 (PDT)
Date:   Mon, 20 Mar 2017 13:00:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH 2/2] revparse: introduce --is-inside-working-tree
Message-ID: <20170320200052.GW26789@aiede.mtv.corp.google.com>
References: <20170320185038.GU26789@aiede.mtv.corp.google.com>
 <20170320192225.18928-1-sbeller@google.com>
 <20170320192225.18928-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320192225.18928-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> This behaves the same as 'is-inside-worktree' and supersedes it.
> See prior patch for discussion of "working tree" vs. "worktree"
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-rev-parse.txt | 4 ++--
>  builtin/rev-parse.c             | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

This is less invasive than the previous patch and can probably stand
alone.  Some of the same nits apply:

* tests?

* documentation would need to warn people that this option is new, for
  now. In fact it's even tempting to make --is-inside-working-tree
  the hidden/discouraged one for a while, until script authors can
  count on git having had it available for a while, and only then
  encourage its use.

Thanks and hope that helps,
Jonathan
