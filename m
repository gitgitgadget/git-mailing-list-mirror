Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229601F859
	for <e@80x24.org>; Thu,  8 Sep 2016 01:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753748AbcIHBeg (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 21:34:36 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34045 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbcIHBef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 21:34:35 -0400
Received: by mail-pf0-f180.google.com with SMTP id p64so12249635pfb.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 18:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NIo3GPxWrHM2ZCMo+grQkGIkgY3S4427zaYJkmv6p5U=;
        b=NotmYHDvH0tDwY+h+x6Y3mnHSN6BYcDKgJLW5HXzFElN4AeP2jUDj+HY8yvHMBhikM
         cfh0V+nqTlv6PeLN2KRteVLghswMUMG72kQU1tTgLrTmTFReZzhWI0OLpD5OLg0adf+I
         WS3eUXnQDLSoBXGGyJ+EE7YfayNhxsF5HFL/MS2T1CtcUTvRUd/wPLv5P+72FjZlPnIg
         1cqtSp3zZWLY/R8jRtaq3UvzseExxw4PqqaANxzKP4ls34+46Pq4LNPIKvkfQ8EaCG3J
         hDhRPYTjvv7d7G5HH60LjgpzMG+uXXyU9UaDWxaEtU1m9qOBLJ97KBueF3dQ2sgVdAVC
         ABrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NIo3GPxWrHM2ZCMo+grQkGIkgY3S4427zaYJkmv6p5U=;
        b=EB85mNtWHA85R2PUxQ9fNPXXhmwWZ5FR2+LkFp+rG2pfLvgQYnhiY8V437X3ZNwt+R
         sVrhljAW3AV06fgwVrMA+UubHAoC3Ib2wK8sstbZ2ZF+Xaex16ffjcQ3A0jOQS+lkbr8
         BcSVEdqH564g2aXzU6v0jiJonEK8B3jikZoeg0M020Purh4UjZPBrdDczxoqrKqsHc6u
         MszcgiKRsVGOclJl7vkEr11cRT7fQyEwWPwwnYNeBzWMvf1nym5gWtr9MmYQVcMwPaZY
         sMnH9hJ1+bUdNfUZOB4Wx/JOUY0DuSIgNyJk2MHi6ZDPdqMZXzrxxS4WS+QbDeIIzVXK
         Go3Q==
X-Gm-Message-State: AE9vXwP7w2UGr62shv0Rxq2FJJpi5J744w5fmE1M11qbuUfQcI3b7K5lXqCZdmgjPoi5xA==
X-Received: by 10.98.130.137 with SMTP id w131mr87279710pfd.5.1473298474239;
        Wed, 07 Sep 2016 18:34:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:60fa:bcd3:3f9b:dd2])
        by smtp.gmail.com with ESMTPSA id v26sm51586110pfi.41.2016.09.07.18.34.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 18:34:33 -0700 (PDT)
Date:   Wed, 7 Sep 2016 18:34:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v3 2/2] connect: advertized capability is not a ref
Message-ID: <20160908013431.GC25016@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1473291819.git.jonathantanmy@google.com>
 <4b09bb7a5b7f4eb5fc31df3d98ce7ffc042eb367.1473291819.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b09bb7a5b7f4eb5fc31df3d98ce7ffc042eb367.1473291819.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Git advertises the same capabilities^{} ref in its ref advertisement for push
> but since it never remembered to do so for fetch, the client forgot to handle
> this case. Handle it.

The comment in the previous review was that this doesn't describe the
history correctly.  It can instead say something like

	Git advertises the same capabilities^{} ref in its ref advertisement for push
	but since it never did so for fetch, the client didn't need to handle this
	case. Handle it.

[...]
> @@ -165,8 +166,24 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  			continue;
>  		}
>  
> +		if (!strcmp(name, "capabilities^{}")) {
> +			if (got_at_least_one_head)
> +				warning("protocol error: unexpected dummy ref for "
> +				        "capabilities declaration, continuing anyway");

Can this die() instead of warning?

I think mentioning capabilities^{} in the error message would make it
easier to debug.

> +			if (got_dummy_ref_with_capabilities_declaration)
> +				warning("protocol error: multiple dummy refs for "
> +				        "capabilities declaration, continuing anyway");

Likewise.

> +			got_dummy_ref_with_capabilities_declaration = 1;
> +			continue;

I think we can make this stricter.  The capabilities^{} line is supposed
to be the first advertised ref, before any 'shallow' lines or .have
extra refs.

(Alas, Documentation/technical/pack-protocol.txt doesn't describe
.have refs --- v1.6.1-rc1~203^2~1, push: prepare sender to receive
extended ref information from the receiver, 2008-09-09.)

'die_initial_contact' uses got_at_least_one_head to determine whether
it was on the first line but code paths added later that use
'continue' don't populate it properly (see b06dcd7d, 40c155ff, and
1a7141ff).  We could do

	int first_line = 1;

	for (;; first_line = 0) {
		...
	}

and use !first_line instead of got_at_least_one_head (removing
got_at_least_one_head in the process since it has no other purpose).

Thanks,
Jonathan
