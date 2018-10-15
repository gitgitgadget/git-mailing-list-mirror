Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839A81F453
	for <e@80x24.org>; Mon, 15 Oct 2018 15:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeJOW4O (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:56:14 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:38506 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeJOW4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:56:14 -0400
Received: by mail-qt1-f182.google.com with SMTP id l9-v6so21818747qtf.5
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1H2+d5bQEeMOElxT2vipVvo2uZZrrL2kT7A6P6BjnPU=;
        b=fuWIYs64DlOtcrCamXzqrvOo2wBv5hGgXR/p38kAG8sfUn8EjAE5AfBbdbvakBzLZE
         G+GVujdaDq2fWaibu0xn6E/j9nD0tqWX5OTIQn1wmPX6mZwLuQtYH19k3PPonIENohSY
         WDcJ+QMHsUQiBrSl3b96eWFruNqaXuqCfCRdfJe/xaP2cOlMlvng/Zo7g5jCQ8OeQMbN
         kdlvAxYRUwl7JBf5DnW6rmbwAhRiBiueKZs4dChf6qQ6QNMarPYHFqxGv3ByVJee9ySF
         pzWBex/9RqbeNgxkij5bx76v/42JQt88Io+KIvZkzqiE8CkSsj3lvThcom3mBsTu0t96
         xrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1H2+d5bQEeMOElxT2vipVvo2uZZrrL2kT7A6P6BjnPU=;
        b=pIVis/hJqJY6wl4LTXWrh/+bijkE4rwz4NVDZGfjh8WIqoSxHunzlCTDCQBPtXQdFa
         xp98ULzDq/RcjaMkRDaKhA+voranOzt0N/QH0vJzo9nrpzzz9aUSgK3A4x7L+3o/Os/0
         OmV/Us/D+4K8ZB158iWrErm68WTTMZ+Nn44oNzyDG8Tj14Vu2yXdHSizTlTEhATX2ct1
         uP6497f0XUTOPUt8lMnBfVeFhxEPvBhDrHI0s4HOB/Ugk78+tSbxTn1ryyNco9OAQA8o
         cIPbJnYHwW0p0R4i5906WzN65CJcoNENnTfZP3Z3a/+Lu2wWnYuyDevglvmSw3NJR3dj
         BAiQ==
X-Gm-Message-State: ABuFfohNEDU4W8RDYChwcUdXAG8SOpSmR3IHJXuR0d1k0z+cAhSGfKfl
        D93foRE1ri593W5aeXdBeLQ=
X-Google-Smtp-Source: ACcGV61b8yctC5FSfp96Z1nTK8fV2MoDp26sIgq99ezixpi3o6jvzvxhAtPEMbroD/37WmKXONJuYQ==
X-Received: by 2002:ac8:3829:: with SMTP id q38-v6mr15591283qtb.91.1539616234072;
        Mon, 15 Oct 2018 08:10:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a017:1942:43e1:ced3? ([2001:4898:8010:0:894d:1942:43e1:ced3])
        by smtp.gmail.com with ESMTPSA id g4-v6sm6316853qkb.64.2018.10.15.08.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:10:33 -0700 (PDT)
Subject: Re: [PATCH v2 09/13] commit-graph: convert to using the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-10-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9dfd76b3-d706-9844-35e3-3a2318181a7c@gmail.com>
Date:   Mon, 15 Oct 2018 11:10:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181015021900.1030041-10-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2018 10:18 PM, brian m. carlson wrote:
> Instead of using hard-coded constants for object sizes, use
> the_hash_algo to look them up.  In addition, use a function call to look
> up the object ID version and produce the correct value.
This looks good and I can see already how this new organization will 
help make the hash size more flexible.

Thanks!
-Stolee

