Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16F091F404
	for <e@80x24.org>; Thu, 16 Aug 2018 20:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeHPXwZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 19:52:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39213 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeHPXwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 19:52:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so3405232edi.6
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jDWwuwVFzeWuBiGdhloyOfp4WdoCMehDdagNPECN5yM=;
        b=RIPv4UGl2Wgfq0V+KcA71vO0aw6FFzahUsNaVMVcp63nYCpkp1+6fIlSXCq8VF9y3Y
         ZvHsaCHJStPU9I1bLG1f0FEhQcDcFuKp5ZjbCV5zG04k1kWmFbt6KFeleg6IbfEj+xAD
         awNXC/ox6BCWrgip1OhtMj5GsgBA5rKip92xAyechWjY7blBjYM6TzV6kPRUo4BB6jyf
         Ds9L7L+rtQ2g89DY7QolGPbGIf43biYxGBj0rEkl8/R4uggTijln5KcqlV2Vbt40aNUF
         TyYnNZCVRnHgXfhwValcNmQti3TC5IRHfVu0Y4QGnK/zxIb5Y8sLWoRlhBAjqMJlkm0v
         sYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDWwuwVFzeWuBiGdhloyOfp4WdoCMehDdagNPECN5yM=;
        b=MCJ8RWuOXV3yypcoKzYghSk2sGRnj9Q4JP0rvkWw8XA8j11TMfbeemuLxcvvLf+Iyh
         49MCnpFTZy3Cwb1wEEFpfrFfLCttZ+ILSrQojm7P1mZtwgcPN8qoaIuojrezo6BivtLd
         tkPm1V2sePJjXm8MgGaoJw43d69sJ9kJGJPUi/m2MvNJnwVHfGAAHI9A0sI3LuETh6N+
         Dlvz5X5CssFtayy/POuRPAJAFgbbECB8NjvH8ZWlIpltJEbNfHRbnzC0QrY1dxV/ce1o
         mmVGnQ6XEWr3Sr2InyEOJh76FSLyDU6L1OeDaO94Ca0Wz5z8upYI5UtOU+yoSOXAl2vJ
         l44w==
X-Gm-Message-State: AOUpUlF7Uhpie4VUvndN/cNY5RsvK+XbVQCkeVPrQ6+MreUtLuzIOTT2
        1uMiJxG7o/zqyNv9gPb4wsM=
X-Google-Smtp-Source: AA+uWPwNgnlQzWnWArQp2ueqVceKbpwE3oVRrUx09uwBFSLPMJ6k1vwWbYzJ4iSBiGxSevYQN4ZphA==
X-Received: by 2002:a50:9135:: with SMTP id e50-v6mr39215265eda.191.1534452706009;
        Thu, 16 Aug 2018 13:51:46 -0700 (PDT)
Received: from [10.46.10.6] ([185.232.21.28])
        by smtp.gmail.com with ESMTPSA id x8-v6sm783165edr.24.2018.08.16.13.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:51:45 -0700 (PDT)
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kirill Smelkov <kirr@nexedi.com>,
        Jeff King <peff@peff.net>
References: <20180814114721.25577-1-szeder.dev@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
Date:   Thu, 16 Aug 2018 22:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814114721.25577-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/08/18 13:47, SZEDER Gábor wrote:
> ... both
> invocations produce empty 'pack{a,b}.objects' files, and the
> subsequent 'test_cmp' happily finds those two empty files identical.

Is test_cmp ever used for empty files? Would it make sense for
test_cmp to issue warning when an empty file is being compared?

> ---
>  t/t5310-pack-bitmaps.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 6ee4d3f2d9..557bd0d0c0 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -9,7 +9,8 @@ objpath () {
>  
>  # show objects present in pack ($1 should be associated *.idx)
>  list_packed_objects () {
> -	git show-index <"$1" | cut -d' ' -f2
> +	git show-index <"$1" >object-list &&
> +	cut -d' ' -f2 object-list
>  }
>  
>  # has_any pattern-file content-file
> @@ -204,8 +205,8 @@ test_expect_success 'pack-objects to file can use bitmap' '
>  	# verify equivalent packs are generated with/without using bitmap index
>  	packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
>  	packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
> -	list_packed_objects <packa-$packasha1.idx >packa.objects &&
> -	list_packed_objects <packb-$packbsha1.idx >packb.objects &&
> +	list_packed_objects packa-$packasha1.idx >packa.objects &&
> +	list_packed_objects packb-$packbsha1.idx >packb.objects &&
>  	test_cmp packa.objects packb.objects
>  '
>  
> 

