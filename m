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
	by dcvr.yhbt.net (Postfix) with ESMTP id B15A41F462
	for <e@80x24.org>; Tue, 28 May 2019 16:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfE1QqD (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:46:03 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46576 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1QqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:46:03 -0400
Received: by mail-ua1-f67.google.com with SMTP id a95so8187482uaa.13
        for <git@vger.kernel.org>; Tue, 28 May 2019 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7YL3enUTLhKsB1RXIB1N3QAUCCjwF7Xs5aIP2hg28hY=;
        b=pCbZfHQJUq++9Dj7kufyhhNJmYCoBNFwSO4AqKKJ0Hf85EsyWNbDXyrK2VJ7hoAQE0
         goIcZZx3+FI2EUEIyzMYgcirO0MdHi0nUes2mur92New24dK0HmbBGhxESpqTx8xH8Nn
         QyZImAzAr7uRbmBTkHMxKlj5DMOTGc0u0j6DlnxmWORyijuch/d/DRMQ0JRKBvjQVVYg
         ewBtGQoddcqZlYqaZgnBFNNfNEE5hm5Ssn6dnkrhSXpfetKi5V4E22Rn6vg511Kaa7aA
         haEtb4lXCNQnuc9+kTI8DwDeTfjXsnsBN+Qz2kReY37QMtmlKSK8S/WFDVGR9G6PLJ21
         oAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7YL3enUTLhKsB1RXIB1N3QAUCCjwF7Xs5aIP2hg28hY=;
        b=HZghfBXSwo92I9hSbQJWf76C0/fLwEjAeKw/k6wiLfpNtzcG2y6XoiXyP/jpUIE6uZ
         qUxL442JD8ntuL46+NpwtoFjQOyBqjvr5Vn1+SjjwIJKVspGdxUaCJUe6JiPNpmX84RF
         nKJ9na7Z2yC1DGEs/C2GrqMDXVObGy2JkH4V9RehWg2BpFKHM3C6nsdqG2aoFTAguKlD
         hsUZLhxBUCKi+Kdn+zpT4N55LpuXXKTq/cXx99Tn4Un1UZ+s2Mijbiylrp76dcEUntMn
         puqSQGDGp7suea7fIUWVBgVU8dN7Ijqk9EfWLSjip3+7A4jm2OIRvE05HoC2IAm3+rm2
         ZR7Q==
X-Gm-Message-State: APjAAAWjja/1WqGDylR16UjS5QgSKIk1kSkUZCfBWD62VQjgnQb9VVub
        2qbzAvm8XEZ/MUpSBZLhirQj+vwnh94=
X-Google-Smtp-Source: APXvYqwA03hv+uS5HyCjIgiBoo1G36TBbw5oDuFzaCIV1Cd5OQMkzbCmQD3l16TXiqrC+SRxOJ6J8Q==
X-Received: by 2002:a9f:2d9a:: with SMTP id v26mr32131245uaj.83.1559061962235;
        Tue, 28 May 2019 09:46:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:911a:cd17:22da:62b? ([2001:4898:a800:1010:4250:cd17:22da:62b])
        by smtp.gmail.com with ESMTPSA id e187sm14587701vse.16.2019.05.28.09.46.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 09:46:01 -0700 (PDT)
Subject: Re: [PATCH 1/2] trace2: rename environment variables to GIT_TRACE2*
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com,
        git@vger.kernel.org
References: <20190510211502.GS14763@szeder.dev>
 <20190519144309.9597-1-szeder.dev@gmail.com>
 <xmqq36ky5ywr.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f03e2ba6-36d8-d82b-3349-61341365b94e@gmail.com>
Date:   Tue, 28 May 2019 12:46:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqq36ky5ywr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/28/2019 12:25 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> For an environment variable that is supposed to be set by users, the
>> GIT_TR2* env vars are just too unclear, inconsistent, and ugly.
> 
> FWIW, I personally am in favor of this change and would prefer to see
> this done before the use of the names with unguessable abbreviation
> gets ingrained too deeply.  
> 
> I do not see any objections around these two patches after waiting
> for a week or so, but I do not see any Yay!s, either, so ...

Talking with Jeff offline, we have no objections to the new names.

We'll need to do some follow-up work on our side as we update our
version of Git, but that's not an issue.

Thanks,
-Stolee

