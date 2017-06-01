Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761FE20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdFAVGl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:06:41 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33078 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAVGk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:06:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id w1so2977531qtg.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+r6kr9oTJgUgmlWGfG7dQhKmOv1wXzl8E3yExAh5WP8=;
        b=kOIKBTv1Br3lGSHaT5uPO+8Hk6vZCN2A+t25j9NPk5sa5v5y2v2ZnYTuwNLLcMKEb8
         4G2ZGCF/zGD187bIB2pgdnh5eu8rPoi4jzO4Q/jNHbWsyS3xzrVtZcld84WmCn7l+OH6
         n3U4jp3+/iPdYo1lCYoKLY8uebXrn0F8KSOhmLFDSMu6XwoPPOYLRaeWYhe02GWcPv3j
         PEXEfN7ipko3hCbeDRtQhzqlSNcKzILrRouuhptQG60/N4hzKhXItDB7Z8DzVatttbUn
         1rmkAuWFENuI3txjhVSK5R/sSpSoI9BCmwAk6HqU3aGkHOXsPWe5bEssDW/owoz4Ko8R
         pwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+r6kr9oTJgUgmlWGfG7dQhKmOv1wXzl8E3yExAh5WP8=;
        b=ElzdsXQ4E2MtM6ITTKm+0EcEScYWie0e4MqsfYRunOf2kX1XuRgUCB6kXFRfezllej
         wdas/1IhLnLAMZvlU0fGUfseO7Zz19Bo9NTflLwULFQmXjAH0VwNaS+WFBpErho8oZFY
         vrxL0aY1t+OIxiLkFQjpyuShzFmVuM+AM0EFLoRE5BC7UuqlbvZbSwA2yigA2aTfSO6d
         9oC9Eh+3kCwO9kDRXCKq4cDFhZplRtELX0y4f07qC1dMh0EnTM1tE9zioXgzMey9W0Dw
         t0tJqnqXt4N/RcIHkYN+wcA8V3utDQ/sl/nS+xcj9eO8clUXFH/VLq8jZDuiiZKKG4yB
         /imw==
X-Gm-Message-State: AKS2vOzioN61KF5cG3T5JH0jJ3NvUP5DkrNnVYRD7y2teSktoI1AUuil
        bMbryXEbzebKgw==
X-Received: by 10.237.52.5 with SMTP id w5mr1110367qtd.136.1496351199798;
        Thu, 01 Jun 2017 14:06:39 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id a45sm13575783qta.39.2017.06.01.14.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 14:06:39 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Fast git status via a file system watcher
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
 <CACBZZX6+V6=gSs0pdN9WU+LPZv5qSAmE5u_f=NFYht2dT-hxEQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <020b09ef-6035-285d-c033-8831564d8752@gmail.com>
Date:   Thu, 1 Jun 2017 17:06:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX6+V6=gSs0pdN9WU+LPZv5qSAmE5u_f=NFYht2dT-hxEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/1/2017 3:57 PM, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jun 1, 2017 at 5:50 PM, Ben Peart <peartben@gmail.com> wrote:
>> Changes from V3 include:
>>   - update test script based on feedback
>>   - update template hook proc with better post-processing code and make
>>     it executable
> 
> Thanks, exciting stuff, do you have this pushed somewhere? I didn't
> spot it it in your github repo. I had some issues applying this on top
> of master @ 0339965c70, on 5/6 I got
> 

I just pushed this to github at 
https://github.com/benpeart/git-for-windows/tree/fsmonitor

>      $ git am /tmp/original_msg.txt
>      Applying: fsmonitor: add documentation for the fsmonitor extension.
>      error: patch failed: Documentation/githooks.txt:448
>      error: Documentation/githooks.txt: patch does not apply
>      Patch failed at 0001 fsmonitor: add documentation for the
> fsmonitor extension.
>      The copy of the patch that failed is found in: .git/rebase-apply/patch
>      When you have resolved this problem, run "git am --continue".
>      If you prefer to skip this patch, run "git am --skip" instead.
>      To restore the original branch and stop patching, run "git am --abort".
> 

Sorry, no idea on why this didn't work.  The patch was formatted with 
git format-patch but it's possible I've got something wrong.

> But it worked with patch, weirdly enough:
> 
>      $ patch -p1 </tmp/original_msg.txt
>      (Stripping trailing CRs from patch; use --binary to disable.)
>      patching file Documentation/config.txt
>      Hunk #1 succeeded at 410 (offset 21 lines).
>      (Stripping trailing CRs from patch; use --binary to disable.)
>      patching file Documentation/githooks.txt
>      Hunk #1 succeeded at 456 with fuzz 1 (offset 8 lines).
>      (Stripping trailing CRs from patch; use --binary to disable.)
>      patching file Documentation/technical/index-format.txt
> 
> The 6/6 patch failed due to an unknown charset y, you have
> "Content-Type: text/plain; charset=y" in the header, worked after
> manually munging it to "UTF-8", although it gave a warning...
> 

The only thing I see different about this patch is the special 
characters of your name in the sign-off line.  The call to git 
send-email prompted me about encoding - I wonder if my answer was 
incorrect?  Given you've probably dealt with your name in git patches 
before :), what should my answer be?
