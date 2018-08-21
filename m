Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41C31F97F
	for <e@80x24.org>; Tue, 21 Aug 2018 13:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeHURRB (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 13:17:01 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35322 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURRB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 13:17:01 -0400
Received: by mail-qk0-f195.google.com with SMTP id 89-v6so7941359qkp.2
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EixBg13v5b60J14F1gle4HpfWGjosUEPLvzV8udDL64=;
        b=cBEFdGtm5j2flOeGpcemkrkEZwnXg4/nFGa6r6bRpbEIa0QWBcUkeidPNJs9LzKAL4
         Wi136BA50M/1e7LX/o+Y7X1DHXdn3pEgoy/gOyrKfpLJLdeJU0jWLAKFqqCaEtAFYJGw
         OGWzGmQxoJVAKj1ZciOlXa4guGPSWPfSqwjvRSG37Wfng65IJ0YVSdfdBsPGVWlnEGzx
         j/mRcMF0d9+7D6aKLzsJ+Mtax9wPDSCF2R3r9VP7MwrJGFxqY6puyNE61XhHNnpbr6S4
         bmw+sm2uxtx8/eT/Ai4u83dL2kOHyFV7ZU82zbQ+NGTDMn8gqGtr2DJFBItqxD35TMJ/
         Iugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EixBg13v5b60J14F1gle4HpfWGjosUEPLvzV8udDL64=;
        b=pN6Gov5nxnIUzsJ9pW3QYXkzcf+q5FyVbiSumEKYwS+iozzH0/T/sPt40gFQ+Thdn8
         fHV0HNYqTkASrvRfh84QjwIWVsgxpl5uYYEDI9BbgTe5LlsaRIF6/kNMhwpCv87qZ7BS
         YWzP6n22uyXJsX34iT+Uwfy3I8uwpHsLs/BAUo6rZrhrSe56fhA/zDwSXNzYDvxbGmOE
         Zzk3/YHIrp5dVd5KdFdzZdXwAwui9t9cac2IeTocfZ3CmmN3BDCXnjUk6bECngT0QjUM
         +jxW2+llpakS3rKYDh+oLnb7u4e4yS89IlU4ZbKORv6WJTmi879+KLPkdjJEUKHr8a3X
         tLBA==
X-Gm-Message-State: AOUpUlG7cq4sJQ8BPHPpXOlfLl2ddyGWtpr19OkFMENUS/HsrWy0jDGm
        NtTZhwZtf1jgiXS/5B+O5zwVbcxP
X-Google-Smtp-Source: AA+uWPwquqqbPXs8OPSwHKbDkU9mycYTsm06pJBnCOuf130KcGYN8vzuh/4X8O/eIy3OFoEyWiLkUA==
X-Received: by 2002:a37:bfc2:: with SMTP id p185-v6mr44578474qkf.169.1534859804712;
        Tue, 21 Aug 2018 06:56:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bcc1:4ea1:6a05:dc2a? ([2001:4898:8010:0:a5f7:4ea1:6a05:dc2a])
        by smtp.gmail.com with ESMTPSA id a5-v6sm7917759qkj.63.2018.08.21.06.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 06:56:43 -0700 (PDT)
Subject: Re: [PATCH 7/9] treewide: use get_all_packs
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>
References: <20180820165124.152146-1-dstolee@microsoft.com>
 <20180820165124.152146-8-dstolee@microsoft.com>
 <CAGZ79kZFXof091d4qXUVyLJ9wGPL0sfs9XruZ-3Hjoq74-tjCg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <05f42490-bf11-8673-61db-e0afd04af43a@gmail.com>
Date:   Tue, 21 Aug 2018 09:56:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZFXof091d4qXUVyLJ9wGPL0sfs9XruZ-3Hjoq74-tjCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2018 6:01 PM, Stefan Beller wrote:
> On Mon, Aug 20, 2018 at 9:52 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>> There are many places in the codebase that want to iterate over
>> all packfiles known to Git. The purposes are wide-ranging, and
>> those that can take advantage of the multi-pack-index already
>> do. So, use get_all_packs() instead of get_packed_git() to be
>> sure we are iterating over all packfiles.
> So get_packed_git shouold not be used any further?
> Do we want to annotate it as deprecated, to be deleted
> in the future? Or even remove it as part of this series
> (that might be an issue with other series in flight).

Perhaps the right thing to do would be to put a big warning over the 
definition to say "only use this if you really don't want 
get_all_packs()" or something. The reason I didn't remove it from 
packfile.h is that it is used in sha1-name.c alongside 
get_multi_pack_index() (so making it 'static' would be incorrect).

