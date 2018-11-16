Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118D31F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 13:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeKPX1v (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 18:27:51 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:38751 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeKPX1u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 18:27:50 -0500
Received: by mail-qk1-f176.google.com with SMTP id d19so37232287qkg.5
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 05:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EpWdyVJIpNlR+oWf2X7WfN1YM87WipvADvFLKW+qY9I=;
        b=o4jO880837+G5u/DhlsV1MsedHEJJrNcRnZuqbD53lB1yTRUsqZOhU0yH3VuCuQ5b/
         kGQ5/0PvrkSRD8Zo2wLgRnvmzE7uWtfRJu7GMpi05eGePXRf8P/4hio2zlK4GGtI/ogx
         Rau8Re6OZEkmTXIZvEhuCGoYrLSLUKIkKK1G/oSuUwkUiSG2UhFk+s6N+MnZ6IFHIwlS
         oA9hEZPIj3BTeiPoPURLnzGCwYSSRUcsqU0QhS9mdRScTf9vioBnNY6VlTKnN/AUFixo
         tRu6FxGJqNt9ZLRzyutDc65LG6tPOic1Vu2fg7vINyFTKx/+y+i+DU/sKdBgOLP7TXmo
         lx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EpWdyVJIpNlR+oWf2X7WfN1YM87WipvADvFLKW+qY9I=;
        b=MWRdipPfQ1aokl0cKwOV8wpI9zHtwTBEPU9hshledySekPVS27sW8XGnmO6OsquA56
         G/UCZ/japWMiqs90Cp7lHFfwZIcXabsYAGQlsao8/LL0l7B+NCRlN3akuthVU/ePFp/P
         ZzDU/YUjRH2/bir5t2hzk5aspsF39ypvLJr5jbtovdwSQVJNyRDJIDfkJ/fofKUN0GWY
         iKVLF+sFVboRpRmWqStDm4ZuchSCtax1IxlEJ7YpdlS67YuAGFMCGCL9mkqVrf7Lqn0X
         UV+J1RCkFyc6vvBf2Y6Q7lFqUE7ZeUxzsYWMPxUUF9x1m5DppPl+MEcHHgJTh2s5lSxy
         kGKg==
X-Gm-Message-State: AGRZ1gKJm/eqBr7fcMKIwGr3Wl2h1egCSM7W13XJsr2PofqD7dYoUuM9
        nNXfkEKgmKClQ0XIBVVYFYV6+ywV
X-Google-Smtp-Source: AJdET5c0WzrMrjQklIaOmSO1RUHgAJBzoZRGE9dcxkm2wO9mJcECN+zi+rCxnaZGoM9lp6BT7oensw==
X-Received: by 2002:ac8:748:: with SMTP id k8mr9964638qth.235.1542374128656;
        Fri, 16 Nov 2018 05:15:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:7cc5:d2f5:5f4b:427d? ([2001:4898:8010:0:65fb:d2f5:5f4b:427d])
        by smtp.gmail.com with ESMTPSA id y32sm19367756qth.3.2018.11.16.05.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 05:15:27 -0800 (PST)
Subject: Re: [PATCHv3 00/23] Bring more repository handles into our code base
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        jonathantanmy@google.com
Cc:     git@vger.kernel.org
References: <20181114001306.138053-1-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ffe3a5c3-58ff-43e3-0c35-bf68f16e928c@gmail.com>
Date:   Fri, 16 Nov 2018 08:15:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13/2018 7:12 PM, Stefan Beller wrote:
> Please have a look at the last 4 patches specifically as they were new in
> the last iteration (but did not receive any comment), as they demonstrate
> and fix a problem that is only exposed when using GIT_TEST_COMMIT_GRAPH=1
> for the test suite.

I took a look at these last four and didn't find anything wrong. Rest of 
the series looks good.

While all of the TODOs in the last patch are an imperfect solution, I 
think it's probably the best we can do for now.

Thanks,
-Stolee
