Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37B9202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 20:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbdJZUcN (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 16:32:13 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:50667 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdJZUcM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 16:32:12 -0400
Received: by mail-qt0-f181.google.com with SMTP id d9so5969136qtd.7
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 13:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gRNPnRdm4WkIApS9ndiedcFRJC58hGiSjH1//s0uuoM=;
        b=DAaEJRrFZ3ybXkZJzNNaBIrOBxdt+QOZemN9yyIFktd2Q7v/0J/RToQyksCigsJG6c
         Y1Io09x57D8dOUSBWMSMzBK72KieNXC4EIQLHNOtVOlY/NU0WQZ4//xjYA+EsEloQKtP
         blIs3OyU6zsM+RqvJPVNTfehALMbv3SzZa/7Em1LsPUpBuuN3FKEjk6KA3PtK9lJS0tW
         zuo0bTKGi86iBtJYJ+cXuv0NU9xIlBwcqq1LL90SrieJQM8UEzB067AOQdOd/5cX0eso
         NeysXlpTubTrG2uYnHZJJBQVuf1naseDtWcwABhoF0dpyB1fRWjXJS3zhiBWRLM+g1WV
         uJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gRNPnRdm4WkIApS9ndiedcFRJC58hGiSjH1//s0uuoM=;
        b=OWtadqlMUpmj6v1CuLoa+k1eS2xh9uiaWiUY92Yhiok+ScwT+hbDxD8M7Azg59IGwM
         c47w9PeVqt+WXjJZJmNcyYHPTNSHx/XrI5RI0FQz68lLsOtv+mMnKaamGddCV2mfP+kB
         NRxnb8hUV2Eq2ll5bcd5+bv1FjinPG3P7aXVMWIhhcJNWRRmisUjav0PlNBX800aJYeC
         rY3A+0KuJEAATzXs7l/RB8T8hKjIIsYBlyisN5KS6T1Zw3+LSzmZIT64RcfDCh1pgZdh
         fip/NIjiNbRGvLfeLjBfNpEn6yN2YvjY9ABtP6lC7AaGqydsXM1yZ8Ehx5jfJjPLAQzf
         fgmg==
X-Gm-Message-State: AMCzsaWFk/ncFKEnnsfGv7fqP/PxszyJYndeBqRjpynhoCQ3gwTaH1v3
        eFhrkwRBDAUGoxRh2rwDRrg=
X-Google-Smtp-Source: ABhQp+S39yK7gCRxi6YuS2/mcJYZ1IMGNVKow/pBtx2QhAZx9baeg+0E0RoxU6j3OT9eGNDpD4ODXA==
X-Received: by 10.200.8.239 with SMTP id y44mr35529565qth.245.1509049930940;
        Thu, 26 Oct 2017 13:32:10 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id k43sm4331713qtc.75.2017.10.26.13.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 13:32:09 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] fsmonitor: Don't bother pretty-printing JSON from
 watchman
From:   Ben Peart <peartben@gmail.com>
To:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20171026013117.30034-1-alexmv@dropbox.com>
 <42fd8bccb78992a2894e711e057230a673891628.1508981451.git.alexmv@dropbox.com>
 <9bd24b15-6232-1afd-abbe-02870c51c7ad@gmail.com>
Message-ID: <e7820a80-eb47-2241-b36a-62a70bbceb5a@gmail.com>
Date:   Thu, 26 Oct 2017 16:32:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <9bd24b15-6232-1afd-abbe-02870c51c7ad@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/26/2017 4:05 PM, Ben Peart wrote:
> 
> 
> On 10/25/2017 9:31 PM, Alex Vandiver wrote:
>> This provides modest performance savings.  Benchmarking with the
>> following program, with and without `--no-pretty`, we find savings of
>> 23% (0.316s -> 0.242s) in the git repository, and savings of 8% (5.24s
>> -> 4.86s) on a large repository with 580k files in the working copy.
>>
> 
> Given this patch series is all about speed, it's good to see *any* wins 
> - especially those that don't impact functionality at all.  The 
> performance win of --no-pretty is greater than I expected.
> 
>>      #!/usr/bin/perl
>>
>>      use strict;
>>      use warnings;
>>      use IPC::Open2;
>>
>>      my $pid = open2(\*CHLD_OUT, \*CHLD_IN, "watchman -j @ARGV")
>>          or die "open2() failed: $!\n" .
>>          "Falling back to scanning...\n";
>>
>>      my $query = qq|["query", "$ENV{PWD}", {}]|;
>>
>>      print CHLD_IN $query;
>>      close CHLD_IN;
>>      my $response = do {local $/; <CHLD_OUT>};
>>
>>      my $json_pkg;
>>      eval {
>>          require JSON::XSomething;
>>          $json_pkg = "JSON::XSomething";
>>          1;
>>      } or do {
>>          require JSON::PP;
>>          $json_pkg = "JSON::PP";
>>      };
>>
>>      my $o = $json_pkg->new->utf8->decode($response);
>>
>> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
>> ---
>>   t/t7519/fsmonitor-watchman                 | 2 +-
>>   templates/hooks--fsmonitor-watchman.sample | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
>> index a3e30bf54..79f24325c 100755
>> --- a/t/t7519/fsmonitor-watchman
>> +++ b/t/t7519/fsmonitor-watchman
>> @@ -50,7 +50,7 @@ launch_watchman();
>>   sub launch_watchman {
>> -    my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
>> +    my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
> 
> Since this is a test script performance isn't critical.  This version of 
> the integration script logs the response to a file in 
> .git/watchman-response.json and is much more human readable without the 
> "--no-pretty."  As such, I'd leave this one pretty.

I didn't see anything (including this) worth another roll so only 
address it if something else comes up.

> 
>>           or die "open2() failed: $!\n" .
>>           "Falling back to scanning...\n";
>> diff --git a/templates/hooks--fsmonitor-watchman.sample 
>> b/templates/hooks--fsmonitor-watchman.sample
>> index 9eba8a740..9a082f278 100755
>> --- a/templates/hooks--fsmonitor-watchman.sample
>> +++ b/templates/hooks--fsmonitor-watchman.sample
>> @@ -49,7 +49,7 @@ launch_watchman();
>>   sub launch_watchman {
>> -    my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
>> +    my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')
> 
> No human will see this response so the faster --no-pretty option makes 
> sense.
> 
>>           or die "open2() failed: $!\n" .
>>           "Falling back to scanning...\n";
>>
