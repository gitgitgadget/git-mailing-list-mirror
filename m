Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF40207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954930AbdDYVvZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:51:25 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35055 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954926AbdDYVvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:51:20 -0400
Received: by mail-pf0-f170.google.com with SMTP id v14so28674349pfd.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=e3E7t/XjcU0hZ7RANh19NVQa+7PYHgFLny7dw5G9kfQ=;
        b=rb5hQHj9BVt+1vbI4F7RMEgmMXJWtguu9HEv0/x7QS0Gb51qknJh3752a/6NPv/o7m
         ypzdlqGG9SXOngRtABbZQD9GjwXpxr+jogiRxVjkRHtHRVPQUpXJ1kl/gUpaLXZlhfcV
         tt4fa+tMW+pzolcRQ8Oc6C4cAzzSbNAayT2WSiJscb8185bGgKfnP5+Le727xcczl0Yu
         pSCEAtGxffUf6jWvXoZWLZJHyuJRXlAmxDlSypoar/gPiS2duKzdE1qsLXp05nx7cd/D
         qcLqhkVUyp2mB2hqu920jtPbqmy55erjVsu3gKtwNOC7SfiCN3IA5Kdn8QwGxKKyUNFv
         jk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=e3E7t/XjcU0hZ7RANh19NVQa+7PYHgFLny7dw5G9kfQ=;
        b=lSpenTgPbkD9OQ+K1q50Jr1h05Xs/vAuXvRAALsQoZJDgsOFCzqLIGLD4DXNCcC5V0
         eD2DI8Rnewj5OkoxDUlAdUq4gZKRvnDLtmGJFI3WjBZUykHnP191glO2WNE+M6WuiJev
         rUG59VD4BbcFiVHAnXmzlmjwR7BQwjrp3JKtHJC9iinwdShTmFKxrBO7/13+FJZHjple
         zpmbAj6m1DabjyiRJYydATkpr7S5DDll7cFdYGAaXngg8De6dQpm9d7DBSDnczR55brR
         m7D7r9HGrY5I65T3aWWWIZCaLAf2Wph5f4gTuaghF0iM52BqjEnX0qWG0rWHcufMJVkl
         DWEA==
X-Gm-Message-State: AN3rC/5Ug2AVFl2WzXCN+X9vmyes8D8tDJuLrRsqee//EJIpYWuJySS5
        PcFju9+mJRYdLA0C
X-Received: by 10.99.123.7 with SMTP id w7mr15719071pgc.82.1493157079446;
        Tue, 25 Apr 2017 14:51:19 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f44b:9806:7409:952])
        by smtp.gmail.com with ESMTPSA id h89sm38166851pfh.45.2017.04.25.14.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:51:18 -0700 (PDT)
Subject: Re: [PATCH] sequencer: require trailing NL in footers
To:     Stefan Beller <sbeller@google.com>
References: <20170421220155.GA142345@google.com>
 <20170425190651.8910-1-jonathantanmy@google.com>
 <CAGZ79kapU5AL_iPJXCavCKAQ0Fw=pqWZS4F6Vri-Q1M1WMVs_w@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <f49a858b-26da-7e8c-e0f2-8d66158f016a@google.com>
Date:   Tue, 25 Apr 2017 14:51:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kapU5AL_iPJXCavCKAQ0Fw=pqWZS4F6Vri-Q1M1WMVs_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/25/2017 02:04 PM, Stefan Beller wrote:
> Thanks for the fix. :)
> Do we want to test for this use case in the future?

Thanks!

I'm not sure of the value of including a test for this specific use 
case, because Git normally does not create commit messages with no 
trailing newlines. (To test this, I suspect I would need to use 
hash-object with a specifically crafted commit object.)

>
>> @@ -151,6 +151,12 @@ static const char *get_todo_path(const struct replay_opts *opts)
>>   * Returns 1 for conforming footer
>>   * Returns 2 when sob exists within conforming footer
>>   * Returns 3 when sob exists within conforming footer as last entry
>> + *
>> + * A footer that does not end in a newline is considered non-conforming.
>> + *
>> + * ignore_footer, if not zero, should be the return value of an invocation to
>> + * ignore_non_trailer. See the documentation of that function for more
>> + * information.
>>   */
>
> Makes sense. Maybe s/ignore_non_trailer/ignore_non_trailer()/ which makes
> it easier to recognize it as a function? I'd also drop the last
> sentence as it is
> implied in the previous sentence (sort of).

OK, I'll add the parentheses if I need to reroll. As for the last 
sentence, the documentation for ignore_non_trailer is a bit unusual in 
that it says specifically "to be fed as the second parameter to 
append_signoff()", so I want to call extra attention to that.
