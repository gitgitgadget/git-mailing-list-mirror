Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551F11F404
	for <e@80x24.org>; Tue,  6 Feb 2018 18:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeBFSzn (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 13:55:43 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:38071 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbeBFSzl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 13:55:41 -0500
Received: by mail-qt0-f182.google.com with SMTP id z10so3668351qti.5
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uK4QE0VAO0SlgxCk+a178ajj0ejRr/dCfqiwUAbtIr8=;
        b=MKfKvwi5BZtWk+ieqmsFgNU35diRVcKL/69YDF+JcaH12sPTc2eex4J9L4/SNDWudS
         5drIX6BTbc7TGNG/llN4yl/jYNZQAcWhZBrBARwverk4RJ426g31f6Wqbq02hYdYxYAB
         DPDMs0O+sPK8vWo/WWQHjwsCuGikF0hdrnzzA4Ocd3PB7bJ1ZLrRfyPZHgyq4Lx2rMKI
         emnIyyjPXnEfLoWZbjPyq2n4Jd65KrQWVUAgqy696CGH9kJt2fEA/sE7Kb5FjIYjSe6L
         fvEN80QliJEIP8MexOiEGfDGwT7N6VEYmt9NwIH3YgeZyEXNSBK8fNruShehByP01LA9
         fqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uK4QE0VAO0SlgxCk+a178ajj0ejRr/dCfqiwUAbtIr8=;
        b=DbT+f04jmsFXioRcYKyDybKDGC96XHt782ruulL12o5uPubVIhNQOsDV/sHT4UZ66e
         YSwKwReu3HLk9HuWieY0e8RYggak3dW5O5WTHTteyeuf6CWmrYc3twGyMrDmG+EiAqjm
         ZC106+nsdFZddM3xCic1OwDWZVSNlZHOleLtSvl12j0oRYqO233Hu7W7J/9C0F5ftnsS
         kq0Ov8HCBFD8nDQIxkGJ57JyBrb0+BYutxhEYOaiCHW3vx71AYQAl+RWe063Vq+QK8Jq
         EXFRoi3E+Tn4GpXspIEcyCxUTgNoeGsCtRkPZKOsjrqktfjRsZa6TeuNfXiHxdBZe0YU
         /LQQ==
X-Gm-Message-State: APf1xPDIaeu6vtmCy2C3cCUfErZ0H9sAPwzMeX/zkmjQZHITNPlvrmp3
        ANnjsGQQmn3RmWr33qQcf+c=
X-Google-Smtp-Source: AH8x225kwaTg9rlOPEXrUcogzJPkMpJRx7UQoNW0SjXFCGJlz2wCoxtSXlHX0wrnFc1F9XAhfOBrWw==
X-Received: by 10.200.28.145 with SMTP id f17mr4989266qtl.15.1517943341141;
        Tue, 06 Feb 2018 10:55:41 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:88ad:1fb1:3dd7:9d03? ([2001:4898:8010:0:71e3:1fb1:3dd7:9d03])
        by smtp.gmail.com with ESMTPSA id j6sm4000654qke.11.2018.02.06.10.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2018 10:55:40 -0800 (PST)
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>, szeder.dev@gmail.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
 <20180201153349.c94fe3de6b632e2fd8f843cf@google.com>
 <CAGZ79kb8kHAb6HYrxY_oMq5v3p1+AHX_ad40nwUEwiDKe=i+Ng@mail.gmail.com>
 <xmqq607fc8j8.fsf@gitster-ct.c.googlers.com>
 <25571438-bdb1-81ce-ac5e-18dd0b6292d5@gmail.com>
 <20180203092806.GA25927@sigill.intra.peff.net>
 <xmqqd11jb7ca.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4dce1997-e0fe-8a7f-622f-94f409f822ec@gmail.com>
Date:   Tue, 6 Feb 2018 13:55:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqd11jb7ca.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/5/2018 1:48 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> The big advantage of your scheme is that you can update the graph index
>> without repacking. The traditional advice has been that you should
>> always do a full repack during a gc (since it gives the most delta
>> opportunities). So metadata like reachability bitmaps were happy to tied
>> to packs, since you're repacking anyway during a gc. But my
>> understanding is that this doesn't really fly with the Windows
>> repository, where it's simply so big that you never obtain a single
>> pack, and just pass around slices of history in pack format.
>>
>> So I think I'm OK with the direction here of keeping metadata caches
>> separate from the pack storage.
> OK.  I guess that the topology information surviving repacking is a
> reason good enough to keep this separate from pack files, and I
> agree with your "If they're not tied to packs,..." below, too.
>
> Thanks.
>
>> If they're not tied to packs, then I think having a separate builtin
>> like this is the best approach. It gives you a plumbing command to
>> experiment with, and it can easily be called from git-gc.
>>
>> -Peff

Thanks for all the advice here. In addition to the many cleanups that 
were suggested, I'm going to take a try at the "subcommand" approach. 
I'll use git-submodule--helper and git-remote as models for my 
implementation.

Thanks,
-Stolee
