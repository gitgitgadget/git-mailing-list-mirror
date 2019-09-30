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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8DD1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 17:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfI3RB5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 13:01:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43462 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbfI3RB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 13:01:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so5943452pfo.10
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VtaNnIZz8GMRDonwSl1t3MWeenfBOlFDiYlY+43pc1M=;
        b=JlY7auq9t1mCKSoGQAKjnhFthAN4nnbKjy6LBE6+ht8kxuXI8TcW29exEfe4wAbQdP
         f/eWguKylmEMQHOPHz/8ydJNF1kj6GneRK8Zv/lceNzIJ67WAXzW6p17oeFHjN0Uwro4
         d7jHI6mKHDhrURU3ZBSkIi6pZrzHSamTvKYLVEt82BWnGN+wylEKBjS4ib0nHVoah3+t
         nOuvjfIXV9o3RkEbOLVyaKK9sLBvoB6XSH8PQ6VkC5MXlth0oQmdbbS8wzx/mPfZD3gh
         5gfaAeVOXmZDsOnik1QaN1lCC3wnXeuXJEuHyQN0yHgxy6F59SNLk5FFXkf0yYoadWzN
         kJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VtaNnIZz8GMRDonwSl1t3MWeenfBOlFDiYlY+43pc1M=;
        b=KVIIYMyJOKF9NvSJpLpNCEOs9HEI5t9T4GEro8Bb0hSaApoXcsohLfSO75S2aBG5tc
         RAH19atgau+9bTeqNi6JVNtJ7xA6OHt/yaOWdG58atQ98CFM4dDEiEeqRd9oFli/87lX
         tKzjwzbsC8X8tOggj/lSCpfv6jpyVichUAqUiqnU6QkZi6OpgEkXpBDnpq2g2FN/QYjj
         X3YhmZgu5WJ5eAGxBDYdfedzfiH0ZDyQtBDSdlX1wARyf2h6ww094d5oMRqdqyJy+9/t
         EGz5AwtMyFDJNOWz4WWfRkYuhp4tjZ9t2KDuPylVHRr+MsUNBLmsyjdaTDeEXnBbvI0/
         /I8w==
X-Gm-Message-State: APjAAAXsQIOgsdV7/WI59VjX+DipavEY8vRGEeDi2gJpoLxCyJjWW2pR
        ksQ52OLjejh1XV4V+bSCNhE=
X-Google-Smtp-Source: APXvYqyyegEWXM7PX4twZCFBuI3n32+i8N9u5xj5BWm2NFNaTYL1EHD6SCN621oCRwyb/aBvgcClnA==
X-Received: by 2002:a17:90a:cf93:: with SMTP id i19mr268053pju.72.1569862916717;
        Mon, 30 Sep 2019 10:01:56 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:b:a89a:71af:9e6e:a9c9])
        by smtp.gmail.com with ESMTPSA id h4sm13197226pfg.159.2019.09.30.10.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 10:01:56 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <2de6b236-7bd8-256b-7d8f-911d63a47498@gmail.com>
Date:   Mon, 30 Sep 2019 10:01:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/19 8:40 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>>> +#define MIDX_PROGRESS     (1 << 0)
>>
>> Please consider using an enum.
> 
> If they are used by assiging one of their values, definitely a good
> idea to use an enum.  Are debuggers clever enough that they can
> tell, when they see something like this:
> 
> 	enum gress {
> 		PROGRESS = 1,
> 		REGRESS = 2,
> 	};
> 
> 	void func(enum gress v);
> 
> 	...
> 
>         void caller(void)
> 	{
> 		func(PROGRESS | REGRESS);
> 		func(PROGRESS + REGRESS);
> 		func(PROGRESS * 3);
> 	}
> 
> how caller came about to give 3?
> 

My debugger was not smart enough to figure out what flags were combined
to give the value of 3 in this example.  

I saw that the code base is currently a mix of #define and enums when it
comes to flags  (e.g. dir_struct.flags and rebase_options.flags are both
enums) and so using one here would not be something new stylistically.

Although my debugger might not be the smartest, I haven't noticed any
downsides to switching this to an enum.

Thanks,
William
