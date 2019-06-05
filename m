Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583071F462
	for <e@80x24.org>; Wed,  5 Jun 2019 19:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfFETkv (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 15:40:51 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:39849 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFETkv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 15:40:51 -0400
Received: by mail-qk1-f181.google.com with SMTP id i125so5938734qkd.6
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g0L5WuUEenU2EgKq1woau1GKAkItzUmv5XspcfqmEww=;
        b=OtbLsDwdotc1XK+ZlPNB//xZnxlqEzuefxyj2ByyywpovDA0Cew4LnplKk1BYIsaRG
         l4ZAFutgsFuN1ZKQA//NsDw5Cn95gJrANxhfuXPxC6A8GgVD7WykIVzAQx6+owOJYOnc
         5jZEUDeSJvgsDKY1HimYZ8qubIHZTpMNaK35cUVj9fDjT1wtkzuNnso10VY/N3c3rPkX
         L1b535LTxXyDNZs0MuyyaXo8XL712h0ueHVLuqqBOHynQbFdvOn6B3xFTmD9Pg2P7+Uz
         sKbc7frJE5yntFMd4Xb+7JMICfZ/vHbituQWn5P9903tKg6rmg57XlOQtv1WMYEwMlkV
         UtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0L5WuUEenU2EgKq1woau1GKAkItzUmv5XspcfqmEww=;
        b=So+93+ptQwOtQn9F3vr1pLMBDq5SQe0p0gxGuYbQoXwEq/oX+Hfxr4xLPxPrZAHf0w
         mGNGPqSQb64Rd/RTZ9vgO9/q9z4RHcdgrVwsV2JBJf+uMFqUGgZ0gYk+Nnq1SjqNrLb+
         VEQwXkryAEHfjU8kt6SU4hUaVtUjBjHX/0QxmUNNbHUXXRTVCAeX/4chv/zBC8OOoVVC
         g253c7I+EcqQVWcxV2xf2Jz7U7a4eGhAb/b7VJPrY0YlJelDwsfgBSrBK/HXuSW2VO7u
         49SsS2yyS/L2vrJ5Dyj/JSx+Tk6l6Hb2hK5/CMTk3ibOrCQ0U5i1rpeAJuIyRH21KHbH
         /GMQ==
X-Gm-Message-State: APjAAAWxtl8uqlA0Q+7DO6Swn6z5VhuGNlabvipaL27iktL2tpSwPJ3z
        Iqh90TcqZHox76ghvoCQLGipUAb8CK8=
X-Google-Smtp-Source: APXvYqzaM/1c12nQeIQRZT3yA2OWMzCArMMNldT9ijgJIvN4Cz7/SNKqD3pX+NcPnrsqJZusGdYPQw==
X-Received: by 2002:ae9:ed48:: with SMTP id c69mr34255769qkg.114.1559763649974;
        Wed, 05 Jun 2019 12:40:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f8bc:cb1d:88e9:2127? ([2001:4898:a800:1012:a9f0:cb1d:88e9:2127])
        by smtp.gmail.com with ESMTPSA id k5sm11022735qkc.75.2019.06.05.12.40.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:40:49 -0700 (PDT)
Subject: Re: [PATCH] t5551: test usage of chunked encoding explicitly
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20190605192624.129677-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <38419c39-cf69-099e-7ab1-2d4c4d9fbb74@gmail.com>
Date:   Wed, 5 Jun 2019 15:40:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190605192624.129677-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/5/2019 3:26 PM, Jonathan Tan wrote:
> When run using GIT_TEST_PROTOCOL_VERSION=2, a test in t5551 fails
> because 4 POSTs (probe, ls-refs, probe, fetch) are sent instead of 2
> (probe, fetch).
> 
> One way to resolve this would be to relax the condition (from "= 2" to
> greater than 1, say), but upon further inspection, the test probably
> shouldn't be counting the number of POSTs. This test states that large
> requests are split across POSTs, but this is not correct; the main
> change is that chunked transfer encoding is used, but the request is
> still contained within one POST. (The test coincidentally works because
> Git indeed sends 2 POSTs in the case of a large request, but that is
> because, as stated above, the first POST is a probing RPC - see
> post_rpc() in remote-curl.c for more information.)
> 
> Therefore, instead of counting POSTs, check that chunked transfer
> encoding is used. This also has the desirable side effect of passing
> with GIT_TEST_PROTOCOL_VERSION=2.

I'm all for testing the _right_ thing.

> -test_expect_success 'large fetch-pack requests can be split across POSTs' '
> +test_expect_success 'large fetch-pack requests can be sent using chunked encoding' '
>  	GIT_TRACE_CURL=true git -c http.postbuffer=65536 \
>  		clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
> -	grep "^=> Send header: POST" err >posts &&
> -	test_line_count = 2 posts
> +	grep "^=> Send header: Transfer-Encoding: chunked" err
>  '

And this does seem to be testing what you now claim it tests.

LGTM.
-Stolee

