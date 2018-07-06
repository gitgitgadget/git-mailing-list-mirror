Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52CA11F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeGFV0i (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:26:38 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:40533 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932878AbeGFV0f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:26:35 -0400
Received: by mail-yb0-f196.google.com with SMTP id y11-v6so5085980ybm.7
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oD9yFJIeaeqy9hG0P7U1DVPGXKdqqlFTEFsSDXR3U5I=;
        b=u7qXebywWvIn/ayH8ipClmyrLB/2wLh9Ft3hoepBmiKFcYmrwWXc54xo6vnXGTfrms
         J+yOImYuv0/Ohc8R3+Dx43vs3aKyryiikd2kYG0f8Rm4ocfjd9Jo7T+FMHosKEbyeh/J
         5Rox0iPge8pNV1hu3owokFnjxvBQR15DhcQ9c2ihsUZ2Ey49IxGfATCUSLU34JZQJa8n
         0IdSIr+6banigTCf4nCsuXpCGup6RwuWA05g8Dh1ggaVFSqO6opDDPTUSZV50uzaqMcs
         61h64/DZ65K53TSgNfkx2TfMSdfXSLJJ/i6Ool5kHQ1aXd88TIqGJA7MB47f9eVpDFVj
         Ua0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oD9yFJIeaeqy9hG0P7U1DVPGXKdqqlFTEFsSDXR3U5I=;
        b=cs/bvEnk8WXdUBHNyLHV/3kguKSJUnthbdS2jY3OKQGmz3O4wai68CaQ2in0B6LqcO
         cb9JKVSsFZYW6ZGA3ly65OeKPuVglEIyYF4yupD53d4HLjr6d/p6fvU0lKOw264yMLbn
         yeLp20Hw/9K4W85RAhynKZrurj8KE0yYbG6qjvt2LWDvDqiQ6vp2CRyqDzIhNMnSTnrF
         UUtDnpaFxNx6ceb9CgvX8vBPjqp43Tl8rTOmn8Zy9qEgEtNUNuDcqrpYryPi9L9Bz4nW
         5jUyA99l9TLD9Vl4tGc9eQ1zqrEad2MglanFFrCw0PyrcTNufuIugFPF/1dRM6GIjvcH
         AsDw==
X-Gm-Message-State: APt69E3uNQJTu/Lg6Tn2Qh/KYvLwFFsxZmIeO/SieSZ75PjBPAYUwzs+
        MM3Mbo70wOJDc6h11dxbYiQX137S
X-Google-Smtp-Source: AAOMgpep4S9tw/M3rVd5IGwN/fixw7Rrm5hI6LABCeLZGaavNu4Tz+sDgUFZXfyTfg579iTbGGGBJg==
X-Received: by 2002:a25:5702:: with SMTP id l2-v6mr3663976ybb.24.1530912394830;
        Fri, 06 Jul 2018 14:26:34 -0700 (PDT)
Received: from [10.20.131.237] ([70.63.112.210])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2509716ywm.6.2018.07.06.14.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 14:26:34 -0700 (PDT)
Subject: Re: [PATCH 1/3] ls-tree: make <tree-ish> optional
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20180703035802.24060-1-jyn514@gmail.com>
 <CABPp-BFu+m-7Fyf4kj8hUO33vhAxKuAu5JnyL5Tzc7c6Kq+Hjg@mail.gmail.com>
 <xmqqbmbonff3.fsf@gitster-ct.c.googlers.com>
 <CABPp-BGJjJGhOEBiJJ5J5rnMXfLndKgwU-4_JVqumBB81DUHpQ@mail.gmail.com>
 <xmqqh8lcmh7u.fsf@gitster-ct.c.googlers.com>
From:   Joshua Nelson <jyn514@gmail.com>
Message-ID: <6d7eca9f-bf3f-5724-42ed-bd579a4d604f@gmail.com>
Date:   Fri, 6 Jul 2018 17:26:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8lcmh7u.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 07/06/2018 01:01 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>>> I'd prefer *not* to have such a DWIM in a command like ls-tree, aka
>>> plumbing commands, where predictability is worth 1000 times more
>>> than ease of typing.
>>
>> Fair enough.  However, what if no <tree-ish> or <path> are specified,
>> though -- would you be okay with the HEAD being assumed instead of
>> erroring out in that case?
> 
> If we wrote ls-tree to do so 12 years ago, then I wouldn't have
> opposed.  Changing the behaviour now?  Not so sure if it is worth
> having to worry about updating the code, docs and making sure we
> spot all the possible typoes.
> 

I have to say, as a first time contributor, reading this is extremely
discouraging. I'm not being told the patch can be improved, or that I've
made some error that should be corrected. I'm being told that the entire
idea of the patch is unwanted, that it doesn't have a place in a mature
project like git, that only bug fixes and security issues should be
accepted.

That makes me not want to contribute.
