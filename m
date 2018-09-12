Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1791F428
	for <e@80x24.org>; Wed, 12 Sep 2018 14:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeILTZH (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 15:25:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45256 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeILTZH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 15:25:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id z125-v6so1185122qkb.12
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vJiKQt+BRrSY8lc3hl0LrgeNML23r3G+cc0XnelAEd4=;
        b=uFfIqc6UQZbhOmWiQTA3SA0vKfuiJ/O0loAsoa7Zn29iMk3HkUzZYFnMQIIUxKbIhN
         yFpGCth1Kbplso5VvGqqpWlysk6aZXgZL19jyJ88DEujlEMj37+7dbSMcAbzPsh9n9G/
         HAZAEB9amRuT2KXgIXo+biDO7FQVM0ITObusPHS7Ad1KZONol0s575f48A/RRt8ziFIg
         /gYnHqpEyol5V+ikrEcHZFdoKR/12RqL9pjnmwnI8JWSMKmawK6LrxHR8OmA1oqWT6Qb
         ++O1NVV/SEXxivRocrT44FDMyhp4KPGQeMOzNFDWUNLo68amKS20XkS0cAbNC6cCwxXt
         0i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vJiKQt+BRrSY8lc3hl0LrgeNML23r3G+cc0XnelAEd4=;
        b=Qp4mhCl66X6NOl5+pjEhasrDPgByyUN+Gk/A28NgQXcqU+ouSS5x8jTHFl1T8uHDRK
         gM3Nt7lzZM86M1Tlmao/sTzA4OM90KTffdO5vTsqMmseGLA2TredrhQfs7eroEd5D3Jq
         HIOCytuwBSfzsfvZ4I5ba/WttSWg3GCiOjMVfdwmTnH+We1rhDvhAMNpZsduJxV3iz12
         469+c07Ux7ndB6SrgUaT1PvmajTiaIN8hX/0Z2gNXe3oVE5vnlHDNY6K2/XLD/iozMKJ
         ylCHrRmGcI60P5IzB7kh19411vwC84L9h/2IV6DLH0qu42jCftvzpkLhmisZvfLhamYn
         aPmA==
X-Gm-Message-State: APzg51DdPA+LE7uGNzW1FvEdI7wV0vbOupfU6QoU3bFyx93MrhGsh3r6
        hS5JiMKE/3WwumTB9Hxp8WM=
X-Google-Smtp-Source: ANB0VdYJNGlLN/J4WieH6huHtgRGMiQ/ZyH+RjN37DNx6NTGiFUq8/PlYQpH8nFcr4jSI1lXxcXePg==
X-Received: by 2002:a37:9f90:: with SMTP id i138-v6mr1583846qke.113.1536762023809;
        Wed, 12 Sep 2018 07:20:23 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id s8-v6sm642235qtc.71.2018.09.12.07.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:20:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] t3206-range-diff.sh: cover single-patch case
To:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.37.git.gitgitgadget@gmail.com>
 <58347a962438852be0d37c3957686ea5000b2dbd.1536697263.git.gitgitgadget@gmail.com>
 <CAPig+cQviMsbhdQty8DnBUWQx4hxNvH-FzXkNeHNBKy6mHGz5A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <14fdfb44-8024-113b-8c34-2a60feedffff@gmail.com>
Date:   Wed, 12 Sep 2018 10:20:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQviMsbhdQty8DnBUWQx4hxNvH-FzXkNeHNBKy6mHGz5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2018 5:34 PM, Eric Sunshine wrote:
> On Tue, Sep 11, 2018 at 4:26 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The commit 40ce4160 "format-patch: allow --range-diff to apply to
>> a lone-patch" added the ability to see a range-diff as commentary
>> after the commit message of a single patch series (i.e. [PATCH]
>> instead of [PATCH X/N]). However, this functionality was not
>> covered by a test case.
>>
>> Add a simple test case that checks that a range-diff is written as
>> commentary to the patch.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
>> @@ -154,4 +154,9 @@ do
>> +test_expect_success 'format-patch --range-diff as commentary' '
>> +       git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&
>> +       grep -A 1 -e "\-\-\-" actual | grep "Range-diff:"
>> +'
> Aside from Junio's and Stefan's comments...
>
> Patch 6/14 [1], in addition to checking that a solo patch contains an
> interdiff, takes the extra step of checking that individual patches
> _don't_ contain an interdiff when --cover-letter is used. I wonder if
> the same should be done here, though I don't feel too strongly about
> it. If you do go that route, it might make sense to move this test to
> t4014 as neighbor to the --interdiff tests. The reason 10/14 [2] added
> the "git format-patch --range-diff" test to t3206 instead of t4014 was
> so it could do a thorough check of the embedded range-diff by re-using
> the specially crafted test repo set up by t3206. Your new test is much
> looser, thus could be moved alongside the --interdiff tests. Not a big
> deal, though. Either way is fine. Thanks for working on this.
>
> [1]: https://public-inbox.org/git/20180722095717.17912-7-sunshine@sunshineco.com/
> [2]: https://public-inbox.org/git/20180722095717.17912-11-sunshine@sunshineco.com/
Thanks for these links! In particular, [2] uses this line to test the 
inter-diff appears:

+    test_i18ngrep "^Interdiff:$" 0001-fleep.patch &&

That's a better way to test, especially with the translation. It would 
be enough for my needs.

Thanks,

-Stolee

P.S. Resending because apparently I had HTML in the last response

