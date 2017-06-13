Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748391FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753977AbdFMVNR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:13:17 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33952 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754035AbdFMVNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:13:09 -0400
Received: by mail-io0-f175.google.com with SMTP id i7so81504271ioe.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DvZK+ktDcYO9RTTxyRiXNAuJV7shWHYiNBJHqBgbqoA=;
        b=GXDnMeVt7Yi5jghYTuQD5LPjgriPnG6lLhVzR3ETsoYC9thQGeQF9cYsQjbgDabfVN
         w63HFDozifB7iNifAESm0tpLBhiaenLZMShxtkZNbtxQLc8Ta8Avx2vf6KtWZ3pKINQ1
         Sy0XTBvDncf400jVDPFzDG5WmKMa2kYHLklYHJCCu5mu4CcO5pG1WCI3MVHtXcaTmlnI
         NjFZXvB/OfwMvv9cUCcJbZRUheyY7OCZXFVUwjUjjFjdb1SY3YIlyqb/f7O5fh9hlWPP
         E/sTcs11xjwcv2a3gjGj5ARXw/xNHABWsisowjoRwzChU1nlpLND6+cHkOe35l3C6MC8
         9fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DvZK+ktDcYO9RTTxyRiXNAuJV7shWHYiNBJHqBgbqoA=;
        b=YAngL92xmz6jLWp0702TEW2OWI2Aq6EmHl+N3ZQqpnZZFmI3Wc2qvrpIfSiL2y49TV
         pnEpYY8SLi+QkoB7YB6JvjTF0f83IXV4Yn26+vDr3IUHPEf66m2A/+LuWsjK1AFTU4bs
         qgUzIw6Vf4AADwAKXF27X+QlpBx99tLST9hkyq6xLJuh2AxVYne5gZxrTCfxCxru8k8l
         Bwpi8AXSffOdSTR4KVrTbXtiXQiz8OQyvwzJ2iO7grCzEOA9VIA3NRetYyuUk3SzPaor
         /o5IeaKXMB8B3B+mA1ZSu+FH4zR3a8mYxoiveDc1L67vv0iJlTFPIGcCGBCDH42twBRV
         l2xg==
X-Gm-Message-State: AKS2vOw/V2UfhSLelRapM4S743d1WGwgGmWzHZ01ghkMXL6B1jtjKsC4
        FMspKfwlIobxBA1sW5g=
X-Received: by 10.107.46.135 with SMTP id u7mr2691307iou.10.1497388388576;
        Tue, 13 Jun 2017 14:13:08 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id w16sm6711894iod.26.2017.06.13.14.13.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:13:07 -0700 (PDT)
Date:   Tue, 13 Jun 2017 14:13:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net
Subject: Re: [PATCH v2 1/6] config: create config.h
Message-ID: <20170613211305.GK133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613210321.152978-2-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Move all config related declarations from cache.h to a new config.h
> header file.  This makes cache.h smaller and allows for the opportunity
> in a following patch to only include config.h when needed.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  cache.h  | 190 +------------------------------------------------------------
>  config.h | 194 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 195 insertions(+), 189 deletions(-)
>  create mode 100644 config.h

'git diff HEAD^:cache.h config.h' confirms that this is
straightforward code movement and didn't introduce any unintentional
changes along the way.  Thanks for writing it.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
