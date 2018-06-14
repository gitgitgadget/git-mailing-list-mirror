Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0632D1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964889AbeFNRzN (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:55:13 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34307 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964872AbeFNRzM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:55:12 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so3950902plq.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mMOI5+wtfnSuYEWAscD0IyLx7xyKwJXH9iQW5PsTjOE=;
        b=WIjtWa+dNo7INkXO0buXG9EZJkm5h6KE5tWhEJVeb+ciEO1eTPt2d7lpkveRkex1Md
         fHtyxV+1xglZ0MZseDeABdrigvngekRpYhEXwZ88mK5mqf546bPDfKiQaQ5SSA8JTN3n
         KlnRawomc+l4930jLV7F/YDGD6NtCdF7Z5QX0R6r3U3GrRTtMW5mQkDtJlle4X2AOyvS
         qx62CUAYR7H6R7sLFC+1GuUNUTOe96nNQQbtQmxyc2OcT6G8fnhhd7OLf1AgOVrLwovP
         eurjIS1qveC3RbKmqiVaz9I15mabd0ablYpnQyIDe3zyrKPvRdimz4BI7K1/ioHyUfXs
         eftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mMOI5+wtfnSuYEWAscD0IyLx7xyKwJXH9iQW5PsTjOE=;
        b=J6HMdlQCvQ1Iq4OR4f9eDY7luVdMqhSfdKj01OOoplJSLe25xE50WIHdTyaQdiQmOy
         njVQuJNlFzHlgMu9TAHVA/g3DHrPLE71qUPSvSpB3RZ3NVAWFp+fgE8RX9e5lvDffaOl
         kG4p7UC9PPs//xQ0fLtVLufU6sURcY9n//9QBziDD+yNBTVsQf+JA7+KWfkJwiC2adNI
         221afuxZVi6DkymB3AObfxZlTZ1BA5gBfVORZS+SfEh9ICMVf+au7ADr9t6GSOr5uZHB
         gf54Cnl7znQRukks76h/LsdubwmzxmBkwZQPYQxwIKx7X1RfWaxIWFL0JMC0h0evmzX2
         YIzg==
X-Gm-Message-State: APt69E1Own8iG+i0UB5i2sJgorWsm1MH/TzZrY/u5ULzG1RsDSZNWuoA
        6DIMCfl79ptwpn5KGDxxgmE=
X-Google-Smtp-Source: ADUXVKIh3Y/G+MXrF0GHcUNpFY+tP2gBJdfuK7Nb5AVxxxx0VaOLuv9TmUCOlOCPA/YRRvrCfPgTcw==
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10-v6mr4081316plb.224.1528998911471;
        Thu, 14 Jun 2018 10:55:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b999:779c:9e18:67ca? ([2001:4898:e008:1:42d6:779c:9e18:67ca])
        by smtp.gmail.com with ESMTPSA id i4-v6sm9166739pfk.133.2018.06.14.10.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 10:55:10 -0700 (PDT)
Subject: Re: [PATCH v2 05/31] tree: add repository argument to lookup_tree
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <20180613230522.55335-1-sbeller@google.com>
 <20180613230522.55335-6-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fcb052e0-2308-31bd-aa90-d6d3327642c0@gmail.com>
Date:   Thu, 14 Jun 2018 13:55:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613230522.55335-6-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2018 7:04 PM, Stefan Beller wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index 71125d7cbb6..88a4b0d2a47 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -261,7 +261,7 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>   	item->graph_pos = pos;
>   
>   	hashcpy(oid.hash, commit_data);
> -	item->tree = lookup_tree(&oid);
> +	item->tree = lookup_tree(the_repository, &oid);
>   
>   	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
>   	date_low = get_be32(commit_data + g->hash_len + 12);
> diff --git a/commit.c b/commit.c
> index d76d64d4dfc..755b8b9d94f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -354,7 +354,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>   	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
>   		return error("bad tree pointer in commit %s",
>   			     oid_to_hex(&item->object.oid));
> -	item->tree = lookup_tree(&parent);
> +	item->tree = lookup_tree(the_repository, &parent);
>   	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
>   	pptr = &item->parents;
>   
> diff --git a/fsck.c b/fsck.c
> index 2d372f2a3f3..b07abb9796c 100644

I'm a bit late here, but you don't have ds/lazy-load-trees merged in 
your history, so this will conflict with 'master'. I caught this as I 
was trying to merge ds/generation-numbers with your branch.

The 'tree' member of 'struct commit' was renamed to 'maybe_tree'.

Thanks,
-Stolee
