Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A60C1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 14:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfFSOh4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 10:37:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46254 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfFSOh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 10:37:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id x18so11016856qkn.13
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=64Oy5NySk7j75br7MtOexofyjNAOaZr4/5X32VfR4i4=;
        b=ENVrkTCyBlxdTzES3edmc8ScYQJvH6BtCj8Hsy/igb+kTGM55Za2rwRfT69D+9cTH/
         ePSQHsXCB01Idm8ENLflYFNsdIop8SwqX5nU0s+niX+0sboupZJ1zDOCqHtpWzn8otr5
         3NFgtb4Jrg6VX/TNjKzvgEUDqhTNhGCl8PW3UPP48Zf0Z/6DTq0Ch2qO+Ot0KlKKND+T
         rS8jtagfB3QQeJQh6GsQijROpFCTxUEsMTF7d+ndfoanDIn6YeFChLoshVyL6y7CYnR7
         lZLAz/eVVMjPPFj4UOZnBbCI+f2DJa0ZAPlVBNqToK2THVsPnGz6QqNR/J70o+zBdZa2
         rgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=64Oy5NySk7j75br7MtOexofyjNAOaZr4/5X32VfR4i4=;
        b=bOXEGxIH5myYKxquu0AxwHZPegtKp3lyYHMROxZynLUJrMvSKoXbnixY4gLB7gUsPo
         WKlGT0xqkww+5xsR7Y5gUOkdjc6r5w73JO6oryWYUgcv0eXAQcJTHMz/wXD/yBkGAxsY
         6ZlJzOdu/BTOFGyOkc1fWsRP5afw19X/0ywWo+q7Mk9X4MAFVBCN69Y/sBylzmOdWM7N
         9z2hPOGMGdnyIMwtL7piVC+HZ2lfy4IQux8I/3hHf+Ib1nQTs+MDNjM1BVP6vv+BlLdF
         owHZHpvXdT5Lqp8ytL+wpiz+c+y3HlChawmtNuB7UfhvHvYS3/cfYpVQzVfOFONGbjr9
         EE2Q==
X-Gm-Message-State: APjAAAUoHxNgYTi4749Yu2MYnErFT81IMPrho/hWDSAKoDGl0329J0hZ
        JnTCPE0yfAtoMDOnh/Fk8YT2CRCD
X-Google-Smtp-Source: APXvYqzQS8o+l4CmhMN93yunfHybFhaygQtZlaYuxGw8AtDWIFHdTChmFsreuMJAUGPb4iyPrc9ESg==
X-Received: by 2002:a05:620a:5a:: with SMTP id t26mr5800266qkt.201.1560955074685;
        Wed, 19 Jun 2019 07:37:54 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id f6sm9682107qkk.79.2019.06.19.07.37.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:37:54 -0700 (PDT)
Subject: Re: ds/commit-graph-incremental (was Re: What's cooking in git.git
 (Jun 2019, #04; Fri, 14))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
 <8690d49e-31f5-e12a-ae8c-dc217a5476cc@gmail.com>
 <xmqqo92tr6hj.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bd56bd14-a4e3-7f99-f4d8-982c0b223bb5@gmail.com>
Date:   Wed, 19 Jun 2019 10:37:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqo92tr6hj.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2019 10:32 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 6/14/2019 4:50 PM, Junio C Hamano wrote:
>>> * ds/commit-graph-incremental (2019-06-12) 16 commits
>>>  - commit-graph: test --split across alternate without --split
>>
>> Please hold on this one. I've found multiple issues while integrating
>> this with VFS for Git and there are enough to merit a full re-roll.
> 
> Thanks.
> 
>> Please ignore the two patches I sent yesterday as I will incorporate them
>> into the next version of this series.
> 
> I think I picked up "normalize c-g filenames" and queued it directly
> on top of this topic, but I do not recall the other one, which
> probably means I did ignore it so hopefully no harm done ;-)

Do you mean you applied the v6 patches? [1]

The range-diff included some changes that are necessary due to textual or
semantic conflicts with ds/close-object-store, but one change was hidden
in PATCH 10 that is important:
.
10:  2093bab5b1 ! 10:  65b1cc6ae9 commit-graph: allow cross-alternate chains
     @@ -97,6 +97,8 @@
      -	for (i = 0; i < count && valid; i++) {
      -		char *graph_name;
      -		struct commit_graph *g;
     ++	prepare_alt_odb(r);
     ++
      +	for (i = 0; i < count; i++) {
      +		struct object_directory *odb;

If you replayed the entire v6 series on top of ds/close-object-store, then
everything is as I had hoped. Otherwise, I can take a look at what you have
applied after the next cooking email and send new patches.

Thanks,
-Stolee       

[1] https://public-inbox.org/git/pull.184.v6.git.gitgitgadget@gmail.com/T/#u
