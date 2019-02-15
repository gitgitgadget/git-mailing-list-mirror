Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA9E1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 20:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfBOUWQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 15:22:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33434 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfBOUWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 15:22:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id x9so6520901qkf.0
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 12:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NBX2DOKIXsBtY9Qc6j4F2aPcHMuyZCOV17bO1CEAaV4=;
        b=V05Lnhpxl3PtJ2FVpGV5fl6ey26yuZbS9y+383PxKIz0F6BGyVFG+GXWuCdznR8Er4
         BGA6fyBjIcHhilgxIVY3BD/wA5pEPG45rNQ3qMbeM2RvpIJFVxHpBWPSp/IfpZEIQKqH
         K9/sIiTHv1lrJmToSOOM4LQLatWwbob71QZcXn0/Oslt7rtTQNMpA3F5VQ5mbDnLNqu7
         LPRDXVvTDi45PyiqjrPMC+x66kHzuy98j/J0a4XGYX7dp7z2h2CpsBG2pbVVm2W8uJiD
         Kcx7sn+/dfhsVVwbYleOQ4a49qrWP/UiHebTCPbF7vW8544SEPG846eAWr5SpZCkJcfn
         CFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NBX2DOKIXsBtY9Qc6j4F2aPcHMuyZCOV17bO1CEAaV4=;
        b=t/u/mZrieHn0pt5UtYTXSHKB95O+AC8btHDF7AS/mAx6F9lD68NqKSGc+Kg7aC2ium
         zrY4i5tNIgTvQ5vMBv7qhfNgLOl+1BpEdwajnUakN/+mvyw3hcpSu6JLmyBaw7fdc+ii
         r+8kse8Nmsat7Q362dFFCSb3SQNVr8UCS+xOSonRCkOAhzC6Te3f1DDwO0XWv0LG74yP
         sruOrzE6OBDKkAQJaKaQ02w8j400+PzHEP6dGxIZwbjWeK9lKTLjt3x1+uBKYuaM9tfX
         C7gCe1rGVSaOEO7kZ8LcvAs7JcmIFr8kMxNUFwvkJcvWrntY0BSGzJ/fZidBoLB+VLj/
         BVTQ==
X-Gm-Message-State: AHQUAubAOuBU1FAM+sfaw9wrtW5fplcPx18EgQUnKCF1mAW1krBsFC5p
        H1UFn1c0x6F8W4JLP8KjCmA=
X-Google-Smtp-Source: AHgI3IaWSAYblwsgi4XGbMtV1rJY5sW1QRiycyNZNC3hsqceP4ua1rDdXqNJEpCPKG5Mz+7qruIwhQ==
X-Received: by 2002:a37:628a:: with SMTP id w132mr8464839qkb.60.1550262134569;
        Fri, 15 Feb 2019 12:22:14 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m12sm3620351qke.17.2019.02.15.12.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 12:22:13 -0800 (PST)
Subject: Re: [PATCH] read-cache.c: index format v5 -- 30% smaller/faster than
 v4
To:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20190213120807.25326-1-pclouds@gmail.com>
 <87bm3ek7qr.fsf@evledraar.gmail.com>
 <CACsJy8DWXcBk3f3heZp5J7dhTM3JL4MeVco56j4WtJNeskz9pw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <11875ebb-5a40-4c87-dce7-b337cc922100@gmail.com>
Date:   Fri, 15 Feb 2019 15:22:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DWXcBk3f3heZp5J7dhTM3JL4MeVco56j4WtJNeskz9pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/14/2019 5:14 AM, Duy Nguyen wrote:
> On Thu, Feb 14, 2019 at 5:02 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>> Take a look at stat data, st_dev, st_uid, st_gid and st_mode are the
>>> same most of the time. ctime should often be the same (or differs just
>>> slightly). And sometimes mtime is the same as well. st_ino is also
>>> always zero on Windows. We're storing a lot of duplicate values.
>>>
>>> Index v5 handles this
>>
>> This looks really promising.
> 
> I was going to reply to Junio. But it turns out I underestimated
> "varint" encoding overhead and it increases read time too much. I
> might get back and try some optimization when I'm bored, but until
> then this is yet another failed experiment.
> 
>>> As a result of this, v5 reduces file size from 30% (git.git) to
>>> 36% (webkit.git) compared to v4. Comparing to v2, webkit.git index file
>>> size is reduced by 63%! A 8.4MB index file is _almost_ acceptable.
>>>

Just for kicks, I tried this out on a couple of repos I have handy.

files	version	index size	%savings
200k	2	25,033,758	0.00%
	3	25,033,758	0.00%
	4	15,269,923	39.00%
	5	9,759,844	61.01%
			
3m	2	446,123,848	0.00%
	3	446,123,848	0.00%
	4	249,631,640	44.04%
	5	82,147,981	81.59%

The 81% savings is very impressive.  I didn't measure performance but 
not writing out an extra 167MB to disk has to help.

I'm definitely also interested in your 'sparse index' format ideas as in 
our 3M repos, there are typically only a few thousand that don't have 
the skip-worktree bit set.  I'm not sure if that is the same 'sparse' 
you had in mind but it would sure be nice!



I've also contemplated multi-threading the index write code path.  My 
thought was in the primary thread to allocate a buffer and when it is 
full have a background thread compute the SHA and write it to disk while 
the primary thread fills the next buffer.

I'm not sure how much it will buy us as I don't know the relative cost 
of computing the SHA/writing to disk vs filling the buffer.  I've 
suspected the filling the buffer thread would end up blocked on the 
background thread most of the time which is why I haven't tried it yet.

>>> Of course we trade off storage with cpu. We now need to spend more
>>> cycles writing or even reading (but still plenty fast compared to
>>> zlib). For reading, I'm counting on multi thread to hide away all this
>>> even if it becomes significant.
>>
>> This would be a bigger change, but have we/you ever done a POC
>> experiment to see how much of this time is eaten up by zlib that
>> wouldn't be eaten up with some of the newer "fast but good enough"
>> compression algorithms, e.g. Snappy and Zstandard?
> 
> I'm quite sure I tried zlib at some point, the only lasting impression
> I have is "not good enough". Other algorithms might improve a bit,
> perhaps on the uncompress/read side, but I find it unlikely we could
> reasonably compress like a hundred megabytes in a few dozen
> milliseconds (a quick google says Snappy compresses 250MB/s, so about
> 400ms per 100MB, too long). Splitting the files and compressing in
> parallel might help. But I will probably focus on "sparse index"
> approach before going that direction.
> 
