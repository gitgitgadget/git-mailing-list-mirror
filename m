Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E868B20D11
	for <e@80x24.org>; Mon,  5 Jun 2017 14:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdFEOIW (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 10:08:22 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36022 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdFEOIV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 10:08:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id s33so8668982qtg.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kZDZMi7Jdm+zzdWnj0LUvsbLSm1kGx1atJvGxfGvI+c=;
        b=gYytArhVbF4oxYRjCjHeGBWP7FgnILywtw/iKWrws7Ha6rJW3fxsKVpzXeinrFldDZ
         7G6/8GnETV2eGO3pozXG3zIA1p+QYDUFo56J7u/ZfHYcCkZdJlvl05gU2bUlTguQHTs3
         PtozdVWTPO/gGl1oQQDNmgZ9sZMixrSr1X2LzBeOwVHw/DGu/MXHJMrv/quKMdQKJfPy
         DSO8YQyyf/ua17yFX+AfvFwdlnGkIqekRwCEj99m6VytMaN99yy3d5KA9bd3C1PV5fa9
         KW+UO68JZbO+DzttSt4Rpw89r7lvsDh5aojLKC4ynqKNGsly3HKvGgNaTnehUoIo218t
         IZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kZDZMi7Jdm+zzdWnj0LUvsbLSm1kGx1atJvGxfGvI+c=;
        b=M7amj0HCCy9JZAT83Fk2fTeiwhHM0/8CUFnCeA1otcbpzvCFJiz9V1tGwWxPWzZi/S
         5zoNuGz+EJv0ZoNlpz4e1QUSteVgtzJExCr6KJe/VYgePS8JNy5Rs2hNxRn11CySHBzz
         GL3/bR0HqAdgQK+5N4Jov9DiLf3dv8SqNq449KoQ0AuOnFfr9C+5MAkYPrjvSw75gjSN
         sV4tnkgkrVqifE/DS/GecJ8KPTb6nRZmE3yEatPdRjnargn77vivQ/p5xNuBKDdC9rLL
         cuUygZ0R68zRcDWzrK66xkRDwgO00j+qg0fsilcjEJsRwRYCeXK8+NJ3c+LjrdieQPEz
         TDJQ==
X-Gm-Message-State: AODbwcDnNb7gsfeQMzBdaEcP01QONvq1PEEfec4Vxl18HlMi32TGycru
        IgCLB5PORiC1Pg==
X-Received: by 10.237.63.39 with SMTP id p36mr24646551qtf.81.1496671698968;
        Mon, 05 Jun 2017 07:08:18 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j72sm5539133qke.69.2017.06.05.07.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 07:08:18 -0700 (PDT)
Subject: Re: RFC: Would a config fetch.retryCount make sense?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <6762A30E-C558-4085-943B-AB85EBF18706@gmail.com>
 <cf8ce12b-8d5a-ae03-efd8-0f82ea40fce7@gmail.com>
 <9840A095-49EA-4B0C-B318-F86EEF9261B1@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0bd7b8cd-534a-10ca-78b9-8e041c4c98ec@gmail.com>
Date:   Mon, 5 Jun 2017 10:08:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <9840A095-49EA-4B0C-B318-F86EEF9261B1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/5/2017 8:04 AM, Lars Schneider wrote:
> 
>> On 01 Jun 2017, at 15:33, Ben Peart <peartben@gmail.com> wrote:
>>
>>
>>
>> On 6/1/2017 8:48 AM, Lars Schneider wrote:
>>> Hi,
>>> we occasionally see "The remote end hung up unexpectedly" (pkt-line.c:265)
>>> on our `git fetch` calls (most noticeably in our automations). I expect
>>> random network glitches to be the cause.
>>> In some places we added a basic retry mechanism and I was wondering
>>> if this could be a useful feature for Git itself.
>>
>> Having a configurable retry mechanism makes sense especially if it allows continuing an in-progress download rather than aborting and trying over.  I would make it off by default so that any existing higher level retry mechanism doesn't trigger a retry storm if the problem isn't a transient network glitch.
> 
> Agreed.
> 
> 
>> Internally we use a tool (https://github.com/Microsoft/GVFS/tree/master/GVFS/FastFetch) to perform fetch for our build machines.  It has several advantages including retries when downloading pack files.
> 
> That's a "drop-in" replacement for "git fetch"?! I looked a bit through the
> "git fetch" code and retry (especially with continuing in-progress downloads)
> looks like a bigger change than I expected because of the current "die()
> in case of error" implementation.
> 

No, not a drop in replacement.  We only use this on build machines which 
don't need history so it only pulls down the tip commit on the initial 
clone.  This is a big win on large repos with a lot of history but not 
so great for a developer machines where history may be desired.

> 
>> It's biggest advantage is that it uses multiple threads to parallelize the entire fetch and checkout operation from end to end (ie the download happens in parallel as well as checkout happening in parallel with the download) which makes it take a fraction of the overall time.
> 
> Interesting. Do you observe noticeable speed improvements with fetch delta updates,
> too? This is usually fast enough for us.

Since we have our build machines setup to use it for the clone, we kept 
using it for delta updates.  When deltas get large (and with thousands 
of developers pushing that can happen pretty quickly) it is still a nice 
perf win.

> 
> The people I work with usually complain that the "clone operation" is slow. The
> reason is that they clone over and over again to get a "clean checkout". I try
> to explain to them in that case that every machine should clone only once and
> that there are way more efficient ways to get a clean checkout.
> 
> 
>> When time permits, I hope to bring some of these enhancements over into git itself.
> 
> That would be great!
> 
> 
> - Lars
> 
