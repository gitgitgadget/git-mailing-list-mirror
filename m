Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456AD1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753958AbdFMVPB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:15:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34744 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbdFMVPA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:15:00 -0400
Received: by mail-it0-f66.google.com with SMTP id 201so13850106itu.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9nSnfY7VBV9wdzldg7+ReVpqvha0I3PrdA2PSUwwEYQ=;
        b=tLsKgw52FzpKecgPKXrpEXdd6EbVPtObkdpf8q1uMn2pZplSskplVgGRP7xuGWvs7v
         td6lN4JXETG9DCWkaUEy0MKYNX/fYU96Fr0BjkKUGGjEpnu5d61/HR78VqhtznWC9Jcf
         gyfxKTYI5D87trrQByiK3252t3dWeKa9psxtBKXjoMzo4GwIE3us+0fqJXfVsedq9Sk7
         ZXNkSNiwFlOYHM7iH6s+ZeYcT1PYMvD4F6p8CoyNjVlUm/UPvP5KR5vqqBYDqzg2NwPT
         uZzf+dMNrIMU6D7nZK/1Q2mJYuOv9HqmKWJgmp/63Uv3GRqHps1BiZzKqXUJWi6RppNz
         UdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nSnfY7VBV9wdzldg7+ReVpqvha0I3PrdA2PSUwwEYQ=;
        b=FzQ/tEksvUBtirscN5oARyW5sQtwHggjX9jRtF18DDM6Xhk7gvYjf8iaukR7L+Gzfn
         x8LqNNMbvHI07zBjoWIXLlHnagO0PhJFmOrR5QNM0nC4QVqna12U90nxbZcbVCbqM0kp
         JIhfVbF+Zfbog0pNgLtQM/sAiko/AyDs2bvBCRp1W0g3mzzNfxB6/ntFskbtEHuqILOu
         GMYJfWm441EvwvAt20l+RCT6vTjRi80I6dUdcVbOhvzCYw/me5bnBzigsxbJ4J/vspaw
         hnFPv66gmzgjJjBwQmp7voD3EzrYN2nbksq34vfQle4txV7nYsVudeyDNGx4JVZPY///
         9weQ==
X-Gm-Message-State: AODbwcBTJZCycllGC4XjCvWthHmRe52VMFZbNZkTj6Oax560gdGCEk++
        icm8aPSXiNQ+BQ==
X-Received: by 10.36.81.20 with SMTP id s20mr18909954ita.29.1497388499920;
        Tue, 13 Jun 2017 14:14:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id y188sm6569232ity.9.2017.06.13.14.14.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:14:58 -0700 (PDT)
Date:   Tue, 13 Jun 2017 14:14:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net
Subject: Re: [PATCH v2 2/6] config: remove git_config_iter
Message-ID: <20170613211456.GL133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-3-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613210321.152978-3-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Since there is no implementation of the function 'git_config_iter' lets
> stop exporting it and remove the prototype from config.h.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  config.h | 1 -
>  1 file changed, 1 deletion(-)

Language nit:

	s/' lets/', let's/

That is, there is a comma and an apostrophe missing.

With or without that tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
