Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD1020372
	for <e@80x24.org>; Mon,  9 Oct 2017 22:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755245AbdJIWhN (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 18:37:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33122 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754644AbdJIWhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 18:37:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id m28so30753784pfi.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 15:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i07vv1wS2xXeSmhxXkSnR3RBGpaa62TZXR3oH/Khd8c=;
        b=Rl8vbefT0U++ch/gPSM6mNhgCCe8ZxmyIIsFmGinBEyt1VXwqqYwU++h/Yxfq7OcMH
         R8t0DNgK9+Tu6TyZquWd2Nms9CQ74geSkQynBVovtuQyqX7mB4xCk6OSpyOWCIjPQsBb
         UY1VyCnkjzT52RcmfUDCzSAhIolPp1+5kmNG5UfWcv0HlA8u3bpPUieIyg4xynA/mIQw
         F5hC9iXNZqNDcQ8mCPw/0nbk/1dHl5sZT0fDCC51XjvpWKH0ImXkGD8uMmOjotb6x8xS
         nDqGbKBNMbkGgR6Nrrf/68xCmHGbPhc/FuiPswg589YnBA79wnrGuiY/GCmCw3j8XL6e
         wLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i07vv1wS2xXeSmhxXkSnR3RBGpaa62TZXR3oH/Khd8c=;
        b=lw5MMWMXM3btz4cUNxta2DgwvbzZTMPZLstLj1C5Rw+qLQ00l8t+T5I3Z6zUdU7Pbe
         TVDbvJfaC3Q9mOHt6tgBs0A6HzqcUkZwjdqzsZ6eI4eMxL3WTqfcsVPd+iSp2y2oXHkL
         y6H0Ku1ql+kekuk5hqvQ5nGeIyGjw+xSlPPSHHXdk9nbTL5/pIyygKU2HGAyb5r7wOVK
         YmFxxokTHQPcThL5XG3htdLeLXvxlg3ftQmp0mGpgPUnAASEcV/+mIyZZYO9Vq8zZkLD
         nrHfDWHtaF9s1Dw2Ar/cJliAYmXbkafeGiXdtk2SwftUcikoO+r9TlvXVlH8yj/4i/a5
         lFYw==
X-Gm-Message-State: AMCzsaXV/Kpgolb0NjTwOcRdVrllJWTEgGkY1JbrjbunKM6uRFpV7mse
        jAhreqvqQ4ZEDK/mtA+04Z0=
X-Google-Smtp-Source: AOwi7QDm0223y6lBwQqzk2x+/l6LYmUoUJX113enRNxpiOdrc7e+BOZPXYh+3b6zZidaX5uZQOk5KQ==
X-Received: by 10.98.158.66 with SMTP id s63mr5093215pfd.293.1507588632098;
        Mon, 09 Oct 2017 15:37:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:14f3:fccd:46cc:9e97])
        by smtp.gmail.com with ESMTPSA id j12sm14794589pgs.35.2017.10.09.15.37.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 15:37:11 -0700 (PDT)
Date:   Mon, 9 Oct 2017 15:37:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 01/24] walker: convert to struct object_id
Message-ID: <20171009223709.GE19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-2-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  walker.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

An egrep for 'sha1|unsigned char' finds nothing left in the file after
this change.

[...]
> --- a/walker.c
> +++ b/walker.c
> @@ -7,7 +7,7 @@
>  #include "blob.h"
>  #include "refs.h"
>  
> -static unsigned char current_commit_sha1[20];
> +static struct object_id current_commit_oid;

Yay!

nit, not suggesting changing anything: I would have been tempted to
call this current_commit_id, or even just current_commmit.

[...]
> @@ -259,7 +259,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>  	struct strbuf refname = STRBUF_INIT;
>  	struct strbuf err = STRBUF_INIT;
>  	struct ref_transaction *transaction = NULL;
> -	unsigned char *sha1 = xmalloc(targets * 20);
> +	struct object_id *oids = xmalloc(targets * sizeof(struct object_id));

Not new in this patch, just noticing while we're here: can this
multiplication overflow?

E.g. in remote-curl, it looks like nr_heads gets incremented once per
"fetch" line passed to the remote helper, making it unbounded.

This could use st_mult or ALLOC_ARRAY to protect against that.  The
caller remote-curl.c::parse_fetch also needs an overflow check to
avoid overflowing its "int".  Likewise, walker_targets_stdin needs an
overflow check to avoid overflowing its "int".

[...]
> @@ -321,7 +321,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>  done:
>  	ref_transaction_free(transaction);
>  	free(msg);
> -	free(sha1);
> +	free(oids);

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
