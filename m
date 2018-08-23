Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76141F954
	for <e@80x24.org>; Thu, 23 Aug 2018 13:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbeHWQuJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 12:50:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42533 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHWQuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 12:50:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so4626919wrr.9
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sK2LQ8sRMNtjRzpbfJxdoZohxgc1PAKftYRCymckyjc=;
        b=jQqwBm2ttPzRYeSV4iXmaGRLBUXexaZcnIVh1OtwkXEvl1qCwJwuX05oCILuAffIFE
         +LEmG9DlK5R5bu0d96mO+h4/XqjWY6ydjzYhM9w7BCzR2yGdqwqBiuydzZRM70VbIGhT
         1NpBNq5Xf2oiMg4VWwFbs3r0r5l9ziH564GyhpZkO3vWfkUDzbdC69G1cm89+bT5q2Pc
         e8VbU7dRw4HrxbfVywjWS9NJTYEMLio6FCLXjJoWK/jqIY71v9lB6s3+F1BWyZZCBlis
         C7SiEmX354oWjETq2QPWbTCEgluLj4dVUhm3waFm+AoNCl1jdwW+00jrAOpaPXD8khVt
         J3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sK2LQ8sRMNtjRzpbfJxdoZohxgc1PAKftYRCymckyjc=;
        b=bgaL5mkZ6w/UDx3Ht4YNVtUoLhf8BWSkEG9j4AL4JkBlcY/mJxsPtZioWEauqy0wyX
         MnMzzEW2uGjPFJvs136TyjPRloWdMpv0rLrpgfWxtXUUJjiGIPmiOry6IZYzJ0hOn3U2
         m5VjEm0YZXx/IOOA6+IxOIPinKPWLhhTlYxn0R3dK5oM74NcsgqadbylE6fN3xlQl1l8
         qNzaEmIW7Nl1FHsNeiRala/Aq44f4oKDeeqDyvGrRJo1mv+OhScbXuQ0K/FMy+MQx/Mq
         cpCqKqrlH8+4IqDCges9bZ8bavNJpAD13/Q1uqZa4KCh5XnGmKGZe8+5JKVKHB9nfrqc
         8LCQ==
X-Gm-Message-State: APzg51DLDRlM4cDlf0Dr4KDzTDJaT5NT2IssQNUAVCUWoIh/0n+Q0+sf
        YkkEyBThmVdRzSUJTp8hgx0=
X-Google-Smtp-Source: ANB0VdZZZ6gMeKvpmuKjLAeZ0+OcAFF+5oqaJTPZhzTxj2byD/DqBZ76LN2iN7tfycWg/BJPTOEkeg==
X-Received: by 2002:adf:ef51:: with SMTP id c17-v6mr12624810wrp.182.1535030427179;
        Thu, 23 Aug 2018 06:20:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q16-v6sm3101950wrn.41.2018.08.23.06.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 06:20:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
        <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
        <20180821212923.GB24431@sigill.intra.peff.net>
        <20180822004815.GA535143@genre.crustytoothpaste.net>
        <20180822030344.GA14684@sigill.intra.peff.net>
        <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
        <20180822152306.GC32630@sigill.intra.peff.net>
        <20180823012343.GB92374@aiede.svl.corp.google.com>
        <20180823021618.GA12052@sigill.intra.peff.net>
        <20180823022756.GF92374@aiede.svl.corp.google.com>
        <20180823050224.GA318@sigill.intra.peff.net>
Date:   Thu, 23 Aug 2018 06:20:26 -0700
In-Reply-To: <20180823050224.GA318@sigill.intra.peff.net> (Jeff King's message
        of "Thu, 23 Aug 2018 01:02:25 -0400")
Message-ID: <xmqqa7pdkyn9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here are numbers for p0001.2 run against linux.git on a few
> versions. This is using -O2 with gcc 8.2.0.
>
>   Test     v2.18.0             v2.19.0-rc0               HEAD
>   ------------------------------------------------------------------------------
>   0001.2:  34.24(33.81+0.43)   34.83(34.42+0.40) +1.7%   33.90(33.47+0.42) -1.0%

I see what you did to the formatting here, which is a topic of
another thread ;-).

Thanks, as Derrick also noted, I agree this is an appropriate
workaround for the upcoming release and we may want to explore
hasheq() and other solutions as part of the effort during the next
cycle (which can start now if people are bored---after all working
on the codebase is the best way to hunt for recent bugs).

Thanks, will queue.

> diff --git a/cache.h b/cache.h
> index b1fd3d58ab..4d014541ab 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1023,6 +1023,16 @@ extern const struct object_id null_oid;
>  
>  static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  {
> +	/*
> +	 * This is a temporary optimization hack. By asserting the size here,
> +	 * we let the compiler know that it's always going to be 20, which lets
> +	 * it turn this fixed-size memcmp into a few inline instructions.
> +	 *
> +	 * This will need to be extended or ripped out when we learn about
> +	 * hashes of different sizes.
> +	 */
> +	if (the_hash_algo->rawsz != 20)
> +		BUG("hash size not yet supported by hashcmp");
>  	return memcmp(sha1, sha2, the_hash_algo->rawsz);
>  }
