Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32071F403
	for <e@80x24.org>; Wed, 20 Jun 2018 13:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeFTNdx (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 09:33:53 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41711 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeFTNdw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 09:33:52 -0400
Received: by mail-qt0-f169.google.com with SMTP id y20-v6so2890854qto.8
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GjMLPL2FlMAFcYlb6HJ6LU+2RDzAHJKGMZgdJYF83iU=;
        b=g07yOMHQkps+tPM4nKjSyA1wtbUoiy+GPeoJi9GRTOz7XGXdQS3FUoqnC5Vli/UAVx
         WxkciyEOtKG5Ph9huvesPeQhB2EOUbBK7n70BxiIIucmi1bnl707VHZMJo/9HVkmCMab
         ToULAbJ3uRTyXexXzU4o1CzazmbdcnT/6CFeZ0f6VSLeTW85smwqPPL4IKBGYJHI46ku
         7ZYaA2Etv+088uNAgsU1G1+S9rfqF00jV9bJrvQSurw37umobp/tpj59QrcGTQAqt8Y1
         lria/+YCqyFOp4lbKvOnsMxDlIXaFrQvth0N8oYuWajV8xDp/DVjSmqEX3V0CnpWcuX1
         c4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GjMLPL2FlMAFcYlb6HJ6LU+2RDzAHJKGMZgdJYF83iU=;
        b=E3diI5gzxBMjoJTEXWCyt5AMu4dT4ImrkCV/69mtB3F/CHW8ej3I9OEiH86evWNwzC
         18Y0Y8EZTIsaR5rlHNdO5zoX8MEHp3oA7DSpWwKKuVj1UhcOxM3Evj6SO7s/I1++NG5L
         IeLzOSApH91XyIpnudGer2L7ugt/CXMalrlxGD5Oj1i5iEDK+mEm1x6ZFlc9e2xJ+3Ma
         qRR6lJbniOst/RXZnTZwQYOrzNRt35wsdIvgt3BhXZtfmbQJzXGrhh569LaYrnjeuTtE
         WVYWCA3mJhMH1VwRpldGV76D7O6jlj8I4mdQsnLjzrHLBWEpVC2FmRwofW2SL98moyBj
         FwDA==
X-Gm-Message-State: APt69E2uVHDHoUUCpJOdtLf86pcDZJGp81mZvHvQeCWERKDtm5SIrJ9o
        7Te9WSOvnuvFbC0s9thginmEs6NRM7g=
X-Google-Smtp-Source: ADUXVKIhCYoyAC5VwViQjasYjh7aUsNFxdDDpZdS8rxXwMok05C7gFu489xrbikbEp5WONHe93vc7w==
X-Received: by 2002:a0c:c206:: with SMTP id l6-v6mr18303142qvh.17.1529501632081;
        Wed, 20 Jun 2018 06:33:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:111c:d99:f232:cfaa? ([2001:4898:8010:0:fa51:d99:f232:cfaa])
        by smtp.gmail.com with ESMTPSA id d200-v6sm1641508qkg.18.2018.06.20.06.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 06:33:51 -0700 (PDT)
Subject: Re: [PATCH 06/23] midx: struct midxed_git and 'read' subcommand
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-7-dstolee@microsoft.com>
 <CACsJy8DG1-YTSBSFkpM8BPcnKmvC-BjjK0W0+EckkdENPC7Ohg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2906e8e8-ca32-828f-e8d0-35b0dff7db81@gmail.com>
Date:   Wed, 20 Jun 2018 09:33:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DG1-YTSBSFkpM8BPcnKmvC-BjjK0W0+EckkdENPC7Ohg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2018 2:31 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
>> index dcaeb1a91b..919283fdd8 100644
>> --- a/Documentation/git-midx.txt
>> +++ b/Documentation/git-midx.txt
>> @@ -23,6 +23,11 @@ OPTIONS
>>          <dir>/packs/multi-pack-index for the current MIDX file, and
>>          <dir>/packs for the pack-files to index.
>>
>> +read::
>> +       When given as the verb, read the current MIDX file and output
>> +       basic information about its contents. Used for debugging
>> +       purposes only.
> On second thought. If you just need a temporary debugging interface,
> adding a program in t/helper may be a better option. In the end we
> might still need 'read' to dump a file out, but we should have some
> stable output format (and json might be a good choice).

My intention with this 'read' pattern in the MIDX (and commit-graph) is 
two-fold:

1. We can test that we are writing the correct data in our test suite. A 
test-tool builtin would suffice for this purpose.

2. We can help trouble-shoot users who may be having trouble with their 
MIDX files. Having the subcommand in a plumbing command allows us to do 
this in the shipped versions of Git.

Maybe this second purpose isn't enough to justify the feature in Git and 
we should move this to the test-tool, especially with the 'verify' mode 
coming in a second series. Note that a 'verify' mode doesn't satisfy 
item (1).

Thanks,
-Stolee
