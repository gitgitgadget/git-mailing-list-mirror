Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459532042F
	for <e@80x24.org>; Wed, 16 Nov 2016 22:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422885AbcKPWmO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 17:42:14 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34641 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422670AbcKPWmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 17:42:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so15899018wme.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 14:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1u+S7og5MOgKVof9VWKJF+wOGTLIWQA2e+qdTxyyio4=;
        b=dwx+E6ZTYy7wwDBWAm+RFO4CX1ZA/T/p7VWYaGBGQJFmM0fhpCOVArhiyjdTkwzm6p
         jlHYl+ymHjCfYYkgiiq8+qCw1Y8LOOIdfv5ibR402zFi3ptgs3NWQzIJOb7wz/wpx8AT
         3LcX+BVx5gE6KarYFFnJcJpTGaTyNFouAw8x3ny3ctIQrYoRUD0r5i1HtG3bXt3Ok7fY
         oXEv6St3kfCGosFo6wXBvc3uL1WGAVXhTrRmfSIjYs5wy+dZXUxQ31YxZYd3HAh/UIVh
         a7mvkjilARdhuWq2nMBDVHnPkI8EpVmvbb8phAs76xNoX7KpSic+wZvy2PHp5fomuaKx
         0Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1u+S7og5MOgKVof9VWKJF+wOGTLIWQA2e+qdTxyyio4=;
        b=blIdW1y9deTFro7XXrB/kdL5pr8Ef2Dk9oSwA1k04GrJoLe5OdV27hn369h5q2+2w8
         1J/afdyO7aG49j+zKg7MVbYDOyTgRMLKMnsEq1GeGPcN53hY1Osrkkjv6ivu8yK5bMFT
         ONR9aOp/C2cGgCyyI8nBc7wWxeqx4Q51Q3uSSRr8bA8I4k+e8lmPCUgqG3Hz4CJeyWha
         b1w4DfNS/Nx1GYGFyfSFqrgveAgfwQBE0AM0fzJb1IYOb8nx7JkfV/KtikYJ38v0gHv+
         ROwfeTK4z0Hi0BUsLjv7NGPiB6s9hBoneSn760fCUYKmUx4aNSRngzblzb2EbrXgabA7
         1LFw==
X-Gm-Message-State: ABUngveaF2aq4HKQRd9o343D8uLI4Bb29ECj2PaYXdKNyA9DdYnreq+7mhj9hfScqdmdfw==
X-Received: by 10.28.15.5 with SMTP id 5mr13285836wmp.141.1479336129912;
        Wed, 16 Nov 2016 14:42:09 -0800 (PST)
Received: from [192.168.1.26] (dgr217.neoplus.adsl.tpnet.pl. [83.23.173.217])
        by smtp.googlemail.com with ESMTPSA id i2sm38986119wjx.44.2016.11.16.14.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Nov 2016 14:42:09 -0800 (PST)
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
 <20161115010356.GA29602@starla>
 <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com>
 <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
 <17709AFF-3C2D-4EC0-97DC-BD750F514D0B@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5eb682e8-13cb-67f2-a8a9-ec1fa1d139c6@gmail.com>
Date:   Wed, 16 Nov 2016 23:41:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <17709AFF-3C2D-4EC0-97DC-BD750F514D0B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 16.11.2016 o 10:53, Lars Schneider pisze:
> On 15 Nov 2016, at 19:03, Junio C Hamano <gitster@pobox.com> wrote:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>>> The filter itself would need to be aware of parallelism
>>>> if it lives for multiple objects, right?
>>>
>>> Correct. This way Git doesn't need to deal with threading...
[...]

>> * You'd need to rein in the maximum parallelism somehow, as you do
>>   not want to see hundreds of competing filter processes starting
>>   only to tell the main loop over an index with hundreds of entries
>>   that they are delayed checkouts.
> 
> I intend to implement this feature only for the new long running filter
> process protocol. OK with you?

If I remember and understand it correctly, current version of long
running process protocol processes files sequentially, one by one:
git sends file to filter wholly, and receives response wholly.

In the single-file filter case, git calls filter process as async
task, in a separate thread, so that one thread feeds the filter,
and main thread (I think?) reads from it, to avoid deadlocks.

Couldn't something like this be done for long running filter process,
via protocol extension?  Namely, Git would send in an async task
content to be filtered, and filter process would stream the response
back, in any order.  If it would be not enough, we could borrow
idea of channels, and be sending few files back concurrently in
parallel, as separate channels... though that would probably
require quite a bit of change in caller.

Best,
-- 
Jakub Narębski

