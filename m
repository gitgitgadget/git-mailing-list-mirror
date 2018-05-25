Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F881F42D
	for <e@80x24.org>; Fri, 25 May 2018 00:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966247AbeEYAKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 20:10:03 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36691 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965284AbeEYAIV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 20:08:21 -0400
Received: by mail-qt0-f195.google.com with SMTP id q6-v6so4455308qtn.3
        for <git@vger.kernel.org>; Thu, 24 May 2018 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rENLAsf4+h72pN71TgCpCMvp4a6O5qpwEqkBCr9ggww=;
        b=rtPfK2/XgzSKTDPM0n2+ZW7DdHW1DQoE1tSUU6pAwseoxPAdfUs6yta1+6JaPxL9K5
         5fPpglvTtRjkLtnipcn+BdSeCo97hDg1lBJcJfFDUqllHHPUqy4czUMYqfoDVIZkM76w
         l+iuv8VIKMaSASbU15CvFvNYi7K+wPcfiqwjz0Zoc7+glirTgTe3JVHzFPYf7GpW9vHt
         s9FFnAQ4IUdQUulzBvNGeaw+Vx7p7Oncm8CYfXbQBZiqKzqXv3gFMxSS4f5LFPJU1neC
         DfFbTGsZ0eiF+UJpV5g6WaXG5vW6N6/4zhS+JwpmXhKyKObESC2oDZcu1+z6L99c8xC7
         bqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rENLAsf4+h72pN71TgCpCMvp4a6O5qpwEqkBCr9ggww=;
        b=al06KNgFOxGsz+c+hWRg8kDU0N1cT2Yem6ziJ48AxcOlNmscvp69vZO7bcKKhmaeRB
         OTOYKJfETIejLKqxbzOew4eKao636N+kY4Mmo58zz+WeBvsVueaIdpowNCCtIC2X8047
         2ihf7L9oAhmBTuhK1N9QxWx6OEg5c65MPoAXpdjrLVQcn5PlGDw4JpYJGKgCknC8G5KV
         yQAWoFeqyH54ge5kk8m5U4S47mNS7Zu9U2LGYh6MgzM5IdROtvBzmB1eeEvIfDSnQ7Tm
         +XO+/4NyS6Fe43mn4SMbTmgNNUbgmwC84QpAae4dmG6ifh5vkK0J/mbm53hiaDiFOPK8
         uuhg==
X-Gm-Message-State: ALKqPwd5ozilbNdYqSSMmCkYVqTXhH9K58EBVBVGKN2zATUvlvIgP6mh
        JWfM4VxgMVG7C/li2TCx9Es=
X-Google-Smtp-Source: ADUXVKIcE1EccTukdKhwgu1BvRDZa3MsKf24ABsCcmTZncvJ1XY5uOeESu5B/rdx8B3DpWanhn+Qqg==
X-Received: by 2002:aed:2864:: with SMTP id r91-v6mr118112qtd.233.1527206900348;
        Thu, 24 May 2018 17:08:20 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z50-v6sm17892517qtj.74.2018.05.24.17.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 17:08:19 -0700 (PDT)
Subject: Re: [PATCH v3 01/20] commit-graph: UNLEAK before die()
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-2-dstolee@microsoft.com>
 <CAGZ79kYaC3VsH2kGMvsv0Xn-ghu5t7ENe+yebQCS5nvW5ms1_g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <67f7c4ef-d82e-fe66-b4cb-d118e6366c54@gmail.com>
Date:   Thu, 24 May 2018 20:08:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYaC3VsH2kGMvsv0Xn-ghu5t7ENe+yebQCS5nvW5ms1_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2018 6:47 PM, Stefan Beller wrote:
> On Thu, May 24, 2018 at 9:25 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   builtin/commit-graph.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index 37420ae0fd..f0875b8bf3 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -51,8 +51,11 @@ static int graph_read(int argc, const char **argv)
>>          graph_name = get_commit_graph_filename(opts.obj_dir);
>>          graph = load_commit_graph_one(graph_name);
>>
>> -       if (!graph)
>> +       if (!graph) {
>> +               UNLEAK(graph_name);
>>                  die("graph file %s does not exist", graph_name);
> Unrelated to this patch: Is the command that ends up die()ing here
> a plumbing or porcelain, or: Do we want to translate the message here?
>
> In a lot of commands that show paths we single quote them '%s',
> (speaking from experience with a lot of submodule path code)

This is for the 'git commit-graph read' command, which is plumbing (and 
'read' is really only for testing). I don't think this message requires 
translation.

I'll keep the quotes in mind for the future.

Thanks,

-Stolee

