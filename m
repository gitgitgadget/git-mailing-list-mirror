Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002171F516
	for <e@80x24.org>; Fri, 22 Jun 2018 20:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeFVUr0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 16:47:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40451 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbeFVUrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 16:47:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so3729862pfe.7
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7xatoRYMWWIuRZ9Mro5odE7/6StxyUoCQ4AlGzQYKus=;
        b=ZDb52MMCCJDeUbQDCZrbaKfUYcr+tXWxjpgeHJOC4K71TIw0R3LiraRFsq93Noa2xm
         8P8O/RFgDu634ERSFlkcjQ/1C0BlUTVmJzEQoF+qWno6U9/NQrkdTJS7d7CBEnpSOcRD
         uIxJiJMIV5MHv6oeDXkKiH8jtAk/30dFLCsjqtQkjbQij6Ctmwh0UFygSQvSLhlkt7/+
         m3ZWv48/OXSmH9mI3k65A3rvML2kwd3FdViWIRY2HzH3qtqudXfHArCHHmQZ7jU3eNAp
         EQZH+V60o09w5HHor7cj3Qx11O/N0GkWSQXfK3QAs1Y/1AHIAhCiHufEEylHQSldLZr6
         ASnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7xatoRYMWWIuRZ9Mro5odE7/6StxyUoCQ4AlGzQYKus=;
        b=sGyG0CodfiHu4inU1ScFAwZXrhUViru/bQLon15jRCChOrinsXQj+N9yEhjjqw3KUs
         yU8cP4kicD9OfltbqHpmRj+v4btRRxZLkDS2VKUzG1L8Q/PjnCW8idVSj8tt8w7nfaW8
         nsp57kFG4GmXkzCM9lVj+8myfC7GkVtjW1RnBpJZJeEvy8OVxHX7pekjAJL8ZM80cX8o
         ksNWxlvg/n+NQQLGb9kYd+twUmYmedXOaX47RDNjibjw9ToxYH1JCjD9XGQQ7aW0+0Kc
         JuWlrxqN6deMWF68Lr2BHplEnbfcb7fnotbGKCJgdjVH5FL5b7TTZHN/gN/W1luoF4IV
         Mrvg==
X-Gm-Message-State: APt69E3G+cG8fJWHYGC9C19d0QDYfZn6EbDcx/czGPyL0O/Itkz9Tq59
        x/+BGbU0nD8eiasHJbOr5mI=
X-Google-Smtp-Source: ADUXVKLPP+s8i7s5n7s8R1y/GTM2uCHBKK/S8YXL0UuCnKLGnV2xrtCWh+e/t4m8C5GYXl8qvVVDoQ==
X-Received: by 2002:a63:bc0a:: with SMTP id q10-v6mr2730184pge.70.1529700444295;
        Fri, 22 Jun 2018 13:47:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 67-v6sm15690509pfm.171.2018.06.22.13.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 13:47:23 -0700 (PDT)
Date:   Fri, 22 Jun 2018 13:47:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH] protocol-v2 doc: put HTTP headers after request
Message-ID: <20180622204722.GG12013@aiede.svl.corp.google.com>
References: <20180622190112.7559-1-steadmon@google.com>
 <20180622193757.GF12013@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622193757.GF12013@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Josh Steadmon wrote:

>> HTTP servers return 400 if you send headers before the GET request.
[...]
> Tested using
>
>   openssl s_client -connect github.com:443
>
> with input
>
>   GET /git/git/info/refs?service=git-upload-pack HTTP/1.0
>   Host: github.com
>   Git-Protocol: version=2
>
> which produces a 404 instead of the 400 that putting Git-Protocol
> in front would produce.

I figured out how to produce a 200:

	printf '%s\r\n' \
		'GET /git/git/info/refs?service=git-upload-pack HTTP/1.0' \
		'Host: github.com' \
		'User-Agent: git/jrn-at-keyboard' \
		'Git-Protocol: version=2' '' |
	openssl s_client -connect github.com:443 -quiet

The critical part is the User-Agent starting with git/.

So we should probably update Documentation/technical/http-protocol.txt
to indicate that clients MUST have a user-agent string starting with
Git/ to allow the kind of request routing that github does.

That's all orthogonal to this patch.  The patch still looks good to me.

Sincerely,
Jonathan
