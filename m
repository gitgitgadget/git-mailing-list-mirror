Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C1C215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbeD3PRz (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:17:55 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38859 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754239AbeD3PRx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:17:53 -0400
Received: by mail-qt0-f194.google.com with SMTP id z23-v6so11317398qti.5
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z2QLkC6KVWV/VYKhggsPF9wqZ2UvbrFupJe1S1stZ5Q=;
        b=SZheQr7v+79JLpR9/KH1Xhk2CsW97MS+EP4RbK/7lp0SytdxpkLG3ppDax6OiHJFJh
         adsPfKkSAYGc2Ey3rb/JauxrQvDiXGEEic/vBRBggbkaDHEHmRz7nUurKaTQM+i/HOJ2
         VITnlMeUmFwPAecQN3GIyip8oHxPgHMzSI+UN86JDUVhiW+/EM1v4JxnLhd9H/MwezK0
         tz6Qt3vQwVUwU3AAjUZuBcG3/eKM69rdLpHUL2jBlegaXUSMldEwGc2wKj/jdxB8zuiL
         QmrDLMQ+TB0WmxYcGnTY6hn6dEHlE9GqU2X6xdgxA8bUVOS0Z/9SLwYs9jpuho1inQ/x
         Gu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z2QLkC6KVWV/VYKhggsPF9wqZ2UvbrFupJe1S1stZ5Q=;
        b=m+uoJlJp6aRPnQvzP35zu48ZBtNsg6Y3BZXSHpIzNPbEIH6pvlhkHXPItRee8E5SDe
         3441NTsBuXJ6dpss2E1Vp0Rbdx7chZuFxpYe8PUE2gqpZABMkRtT0F5WHRpIDrA4BdPi
         JEBfrB0TgqyF2r7XQBd4SbO4jn6NchcUYa/5ucRNneLwdv25SrpATBwrQEw8VUm7hCLB
         micWDjlAJ1b3rJKGA7NaINmY7rt6eWkDPMOturcqstFdWW43QK8CMuKEARvoPZGvvZu8
         qB26db+rEHu149CgHJtKWCEoWy2ho1c9pPic9XFdY1rQU4jRs720m/8qi04G/wnP3061
         PVbg==
X-Gm-Message-State: ALQs6tCzPzYPn6VlqN61ogXLmQgDzGjDGE/dR4leRvEaNYLgphDVExvo
        oOhs9rlzFZXsff2jP1Gasnk=
X-Google-Smtp-Source: AB8JxZqoT/a19eUsn4UW5vipHiqFQnK29bWajoGL0TgdtDZO0UaKdjSmsuCs4L864JcBt25lvzUniw==
X-Received: by 2002:aed:3f17:: with SMTP id p23-v6mr11623310qtf.57.1525101473024;
        Mon, 30 Apr 2018 08:17:53 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id a4sm5746533qkc.83.2018.04.30.08.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 08:17:52 -0700 (PDT)
Subject: Re: [PATCH v1] test-drop-caches: simplify delay loading of
 NtSetSystemInformation
To:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
References: <20180430142555.23260-1-benpeart@microsoft.com>
 <CACsJy8CY1fNY9OPq9nisDC3X93QXjntre-vFgQ0OeuO=B0YV=Q@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c05d652d-3275-4b04-c350-452e1c409493@gmail.com>
Date:   Mon, 30 Apr 2018 11:17:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CY1fNY9OPq9nisDC3X93QXjntre-vFgQ0OeuO=B0YV=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/30/2018 10:57 AM, Duy Nguyen wrote:
> On Mon, Apr 30, 2018 at 4:26 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> Take advantage of the recent addition of support for lazy loading functions
>> on Windows to simplfy the loading of NtSetSystemInformation.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>
>> Notes:
>>      Base Ref: master
>>      Web-Diff: https://github.com/benpeart/git/commit/6e6ce4a788
>>      Checkout: git fetch https://github.com/benpeart/git test-drop-caches-v1 && git checkout 6e6ce4a788
>>
>>   t/helper/test-drop-caches.c | 16 ++++------------
>>   1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
>> index 838760898b..dd41da1a2c 100644
>> --- a/t/helper/test-drop-caches.c
>> +++ b/t/helper/test-drop-caches.c
>> @@ -1,5 +1,6 @@
>>   #include "test-tool.h"
>>   #include "git-compat-util.h"
>> +#include "lazyload.h"
> 
> This is in compat/win32, should it be inside the "if defined
> (GIT_WINDOWS_NATIVE)" block instead of here?
> 

Yes, that does make sense.  No other platform will need/want it.  I'll 
wait to see if there is any other feedback and will submit an updated 
patch.  Thanks for the catch.
