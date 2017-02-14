Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A321FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 16:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932103AbdBNQ6y (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 11:58:54 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34110 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932101AbdBNQ6w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 11:58:52 -0500
Received: by mail-oi0-f51.google.com with SMTP id s203so73435833oie.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YemFXL//P3aWnNBNPfDGzRlmovCbRY40DeXyxDbDFbc=;
        b=IPlqVHzWNT9g4Sa+4i0Z7ldGaFFsPXs0/yP7uj4PT9oofaRcJgSmQb4/frQPKuXWVb
         YAazfgvQJggXtrMSNi+CNv0g2wNnieQSIpLGft9r4EYY6wjAb0gEg59ow65owgKN9JqU
         nIphd+DcluYbqUJc8WMlnw6xfoUkEjtN251iyKfKd9XL85Dk9Hvj4WQesg3HCyFvOoP2
         uMy/29xraPlugrgJIqIuCEvDcHRTB7PR3BTonz8z9p1Uz1Xby6SvNuaC9V5PMlieQPMb
         FCqFzAW7kXyreLZWkXP3rKDZTPy8SZwvYdT5U5m+2aSrlB82VvppNumNY4iqdQTm5h/k
         H/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YemFXL//P3aWnNBNPfDGzRlmovCbRY40DeXyxDbDFbc=;
        b=csU/Di1+LAxCFT6RiWE5F58/mS17wqk30Onow7xMQ5T2TrZxh5nqrdNUjZBDWxUURb
         3UKifHADYuo/KB801mPNUsMgaQrnQLut8CR0s1vQZ0MgHQ2d7B9GT9uvcR71T8szrYgj
         vEZ62zz8M+cGPiD5SCWI6rh7hmXo7vZkcFeFlBAz6ikt4LwcLsxpAlL2qhIgnO1RDL1Y
         lksZoBknICNtGFBMUvkt49gxK9Dja61Wg9W+yBr7TcjhvJ9aGEobFgM5WHHladrupBOo
         SFsXtXIsSdMArxC7D8jH1pA6bnl9BPAE/fekNu63CBfGFmnw59K+zx1Ojz9t5IWKc5xa
         oK8g==
X-Gm-Message-State: AMke39lbfIQuNKFaMqitYf2P47AP8hjQTSG5eCAQslGOm2qpkmx+qcBfFMWeszoF30PCzN8u
X-Received: by 10.84.170.67 with SMTP id i61mr37360468plb.88.1487091531703;
        Tue, 14 Feb 2017 08:58:51 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:55a2:e20d:aab0:fd6b])
        by smtp.gmail.com with ESMTPSA id v67sm2333945pfd.105.2017.02.14.08.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 08:58:50 -0800 (PST)
Subject: Re: [PATCH 0/7] grep rev/path parsing fixes
To:     Jeff King <peff@peff.net>
References: <20170214001159.19079-1-jonathantanmy@google.com>
 <20170214012037.u2eg2n7mvteullcx@sigill.intra.peff.net>
 <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <77693036-756d-3be3-c885-ca7891da533c@google.com>
Date:   Tue, 14 Feb 2017 08:58:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13/2017 10:00 PM, Jeff King wrote:
> I've fixed that, along with a few other bugs and cleanups. The complete
> series is below. Patch 2 is your (untouched) patch. My suggestions for
> your test are in patch 3, which can either remain on its own or be
> squashed in.
>
>   [1/7]: grep: move thread initialization a little lower
>   [2/7]: grep: do not unnecessarily query repo for "--"
>   [3/7]: t7810: make "--no-index --" test more robust
>   [4/7]: grep: re-order rev-parsing loop
>   [5/7]: grep: fix "--" rev/pathspec disambiguation
>   [6/7]: grep: avoid resolving revision names in --no-index case
>   [7/7]: grep: do not diagnose misspelt revs with --no-index

Thanks - these look good to me. I replied to 6/7 with a comment, but I 
also think that these are good as-is. Also, 3/7 can probably be squashed in.
