Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C03520229
	for <e@80x24.org>; Tue,  1 Nov 2016 17:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbcKARis (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 13:38:48 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36593 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753655AbcKARir (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 13:38:47 -0400
Received: by mail-pf0-f182.google.com with SMTP id 189so45084468pfz.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IQIWzslC9oHThmWx462lHumzaKG1KQBU2QBF255Sye0=;
        b=CIiMvNeIeDE0rcMn9tvRt2MegVGfwLeD3g7TmOIUSEPu+eubud/9LtuN0pWGlXu3Na
         HPl8x1J/I4aboavc2Ld6cKEXuAweOfNqQukJZ0vlhASTiQI2KDGvJd7gPAo6vPLXhKMP
         CYF1UDl2RQm4sdz3rqjyiyH9mht8rjtk3i/Cxhr4A1nRtwMOkr62GTYaeww8wez+q7+I
         uMsBYjjh0yfuvciPM2ausrwRGXYz7jBuk26lF6yp8iqWrxs2z9r8QVipPUtWS2/V4u5x
         Ykl5IkL+NMCDwcRWxZgMiPhtMqQrKW48IBsnBy96qnZzRS+Dp8ReXmKMcRt7m1f3RacE
         Jqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IQIWzslC9oHThmWx462lHumzaKG1KQBU2QBF255Sye0=;
        b=TZ+qa0SvPrXeAw0/QgOgQZs6CvCPBBPwTWgerOi8NrcwJJpcp76ea+bAi+nX8t8h5R
         TGUnY4TQ7ivypRb29v66U5kfC70oK+Q7G03uNEIBpUws2Nj2WuBOKgI5Raq038TmfHtZ
         KukW4fFATwA2hFyy+Cv6oZAUCk6pX81ySc1fCB0dbLY75wV1ouzwkPJZex/EjFMEXC4y
         AN/PeIYG7r1yKiSvW+lYeKGUJ6sTVhleshuZfC8b6CZBy5fipAASs39DG83O13daifvJ
         98VNqB7Xd618QX+v7LeduN9FMWYeF3WIsaJ8kjN+cgxBvU/+2TJTuKUA3hzVHbTp0/Cr
         nZzQ==
X-Gm-Message-State: ABUngvd8C+Tg7kGcLNeIVHmrkVwfUBJ9u26Ny5ur2t4DlhCmn0jhrm0XZnZP1ufKoYfBHsnm
X-Received: by 10.99.106.200 with SMTP id f191mr10347267pgc.143.1478021926102;
        Tue, 01 Nov 2016 10:38:46 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:294b:6247:1bca:2342])
        by smtp.gmail.com with ESMTPSA id yk6sm43618932pab.43.2016.11.01.10.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2016 10:38:44 -0700 (PDT)
Subject: Re: [PATCH 4/4] sequencer: use trailer's trailer layout
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1477698917.git.jonathantanmy@google.com>
 <cover.1477698917.git.jonathantanmy@google.com>
 <602ae84920300cdbb439eca8098c5e092ca322f7.1477698917.git.jonathantanmy@google.com>
 <xmqqeg2wqa1e.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <a416ab9b-ff1f-9a71-3e58-60fd4f8a6b8e@google.com>
Date:   Tue, 1 Nov 2016 10:38:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqeg2wqa1e.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/31/2016 06:11 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index ba4902d..635b394 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -1277,8 +1277,7 @@ EOF
>>  4:Subject: [PATCH] subject
>>  8:
>>  9:I want to mention about Signed-off-by: here.
>> -10:
>> -11:Signed-off-by: C O Mitter <committer@example.com>
>> +10:Signed-off-by: C O Mitter <committer@example.com>
>>  EOF
>>  	test_cmp expected actual
>>  '
>
> The original log message is a single-liner subject line, blank, "I
> want to mention..." and when asked to append S-o-b:, we would want
> to see a blank before the added S-o-b, no?
>
> This seems a bit weird.

This is because the "I want to mention" block has 100% trailer lines 
(since its only line contains a colon). We could forbid spaces in 
trailer field names, but as you said [1], it might be better to allow 
them since users might include them.

The original sequencer.c interpreted this block as not a trailer block, 
because it only accepted alphanumeric characters or '-' before the colon 
(and no spaces) - hence the difference in behavior.

[1] <xmqqbmyhr4vt.fsf@gitster.mtv.corp.google.com>
