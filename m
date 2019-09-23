Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98A91F463
	for <e@80x24.org>; Mon, 23 Sep 2019 21:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503201AbfIWV4B (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 17:56:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45046 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390839AbfIWV4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 17:56:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so7096746pll.11
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 14:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MeV1pTJbGKVm1EgyZS3p8+XdVuvdPpbI1R1nvZeTNbY=;
        b=qt878HdLu29Xb1BRvnP1Nbl2kooIvpZbvm8yqXEFyU6Mf5/fwDrYpr0RLxm3kcu/JB
         XsO2JIg0w/CVEEJAUmJXTCmNZJSkJhjtzLN07eNGl5qp4Qp0sIyg9wYjuOgU+fuy+SxW
         JfY5T3sxzQ4q59CaCjz3KUTjUx6gDrjY/vjisCXAvwM5yYl4S7hgNBoWWAgYGc8t86rU
         wehlm5Ub2PQwZPO/DW5ZxfbC5WKRY5GD2OdUQPKS9TFnXulry0OTa54GTSO0/Aun6ZZ+
         V6ER/K/iNZtuEAWMhPhbWAqevHRA7yqKO9UJaiak+CqL6niLTBUT/AzdlOpYO9+ZbhNC
         3S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MeV1pTJbGKVm1EgyZS3p8+XdVuvdPpbI1R1nvZeTNbY=;
        b=O5G+/zB2Besm1DfPOiqY7GH16vVMovQgy+MRvoUOVpXbcPkWdEFJhbcbZbkPoQUn6n
         kURWwk2RCtcB/pgO0wWF45kWprSTcx2/l2GnZCQu77voTNo3t/G30/FUUWyHB716EFOg
         LrX3E10u0M7rf0UcSvejLR4wwI1eif47yELIFXPbF3Nwg9GVzqg7LyvpDPd2xuTshdEZ
         svBgJWf/41dglll/M4LqUocFywKr3VLTNgqXfn19b5cDNSHmoQvE/o/VtJwf0CYA1+0Q
         99T6pQ8FPmY7dzwIMR0NKoIaZ0CD3ZDBjAi4upKNm7EzWUR63CzNEbMyvLX7YAp4wZ0D
         Tlwg==
X-Gm-Message-State: APjAAAUPP3FhYV/zydV8wwtoXRNS/kANqRTl+/CKqUjolLO+bj7X0Sb+
        DOgQeS9EmeIzIuogghksAW8=
X-Google-Smtp-Source: APXvYqyb7XwGZgLvatt3TdXGh7Aza/UGNfwlKjwrBMTNK8FjQQCYAvoRccAgBbFeP0zK8hJFqhb+bA==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4mr1895456pls.142.1569275761174;
        Mon, 23 Sep 2019 14:56:01 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:b:549a:4edf:133b:7cbf])
        by smtp.gmail.com with ESMTPSA id c6sm13806392pgd.79.2019.09.23.14.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:56:00 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <b5ce3e27-3401-9726-18dc-358f69f1b996@gmail.com>
Date:   Mon, 23 Sep 2019 14:55:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190921121104.GA6787@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/19 5:11 AM, SZEDER Gábor wrote:
>>  
>> +#define MIDX_PROGRESS     (1 << 0)
> 
> Please consider using an enum.
> 
> A preprocessor constant is just that: a number.  It is shown as a
> number while debugging, and there is no clear indication what related
> values belong in the same group (apart from the prefix of the macro
> name), or what possible values an 'unsigned flags' variable might have
> (though in this particular case there is only a single possible
> value...).  
> 
> An enum, however, is much friendlier to humans when debugging, because
> even 'gdb' shows the value using the symbolic names, e.g.:

Thanks for this suggestion.  I agree on the benefits of using an enum
here and will make the switch in my next set of changes.

-William
