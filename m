Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F71EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 12:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiFPMyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiFPMyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 08:54:13 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E486C38DB4
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 05:54:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 19so1347017iou.12
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ngs0kjn++/mdTrTd4FMohxU++508EiQwBiYhIN7gNes=;
        b=ddVYt1uYgADlIKz5isDCv1kEQkeE1Hm4dGNaYgVaXG6XMHZGnQ2+wbafPPHfYv9OMd
         wywsB1SHe9o9MFo23QS4r9WvGT/nRuvCGmlUmzJFS5FLT+VSVdkgCBmdQ9yT9pbu0Urj
         YOm5YPR2gi7RBxHnu5Hd5YLtpV7afdJiIiqL83av6kVw2gXL4lApMKwpzhzAHxLsiXzZ
         gmdEnMJsZOFKnRE0m4xG3nyuUQKV5wCDZtGuklgRoFh8OvGfpOFVjcFZ0PhPkRhJ0ZVs
         Al3/E8ELfwmhdpi+hhX6UlMX+2eIDxfX5Seww2VxfAJ+/rUTS1VULWmqAs3rdzpcQTKM
         D+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ngs0kjn++/mdTrTd4FMohxU++508EiQwBiYhIN7gNes=;
        b=Hgi7lhSTjA3i+Gjh0zb91qqbEj4yMepO2m7WwlMKY/7+AaNGVs3u4tdKsZy0ZpAoqT
         lhfL1fc/BJD9mODUg10wCcAEEcOa04TCUaDv1rlNM12C8CQ3a9FjsDx8RSy50RJP3PQU
         /TUWFm17XOs4SwSNS0Ag/po15FRjhA71f7pn16OwWeye97fTtbmeBddUychQ2QjJyaKJ
         1fa8xjeUF3fmuaeRKzA/aTJ7rTkR1oRLxfFN3SL2r9qIHCWHXuhtIHMNh3TWwXlWH6Kb
         EJllyp4ikZkRW/tW7aVaU6keCzdx6MVSW5hhdC8kU2wytmY73skfC7Sb2q8GLhSbSS6h
         9jYA==
X-Gm-Message-State: AJIora+UFahe0J2Sfu75K+qRxE7+YQbNmRvy6yrRmaHViz02NjWxvWeG
        e/+9YhcsaHDgbAN/74r5eVil
X-Google-Smtp-Source: AGRyM1uKKdwKXDxtdyTY2KQQd3vNapaOY00VAgxMbVYVvTHGV4HIeaVUQWPJ6lHr2nNi7flQPoqXTA==
X-Received: by 2002:a5e:c90d:0:b0:669:daa8:f59e with SMTP id z13-20020a5ec90d000000b00669daa8f59emr2456404iol.1.1655384052257;
        Thu, 16 Jun 2022 05:54:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:cfb:ad5:8ed2:9eba? ([2600:1700:e72:80a0:cfb:ad5:8ed2:9eba])
        by smtp.gmail.com with ESMTPSA id p20-20020a927414000000b002d1d8de99e7sm966885ilc.40.2022.06.16.05.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 05:54:11 -0700 (PDT)
Message-ID: <a5c4ca33-abf5-7adf-2a91-2dadf7a98d9b@github.com>
Date:   Thu, 16 Jun 2022 08:54:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] t2107: test 'git update-index --verbose'
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
 <c6803df1b6afead99a0a6a383ab9aa563920f464.1655242070.git.gitgitgadget@gmail.com>
 <CAPig+cTtZ3=r62XDTE4gpy0Fk_gkzOROm34gW6gkuGRjdQRBTA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPig+cTtZ3=r62XDTE4gpy0Fk_gkzOROm34gW6gkuGRjdQRBTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2022 7:18 PM, Eric Sunshine wrote:
> On Tue, Jun 14, 2022 at 5:36 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The '--verbose' option reports what is being added and removed from the
>> index, but has not been tested up to this point. Augment the tests in
>> t2107 to check the '--verbose' option in some scenarios.
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>> diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
>> @@ -20,7 +20,7 @@ test_expect_success 'do not switch branches with dirty file' '
>>         echo dirt >file &&
>> -       git update-index --assume-unchanged file &&
>> +       git update-index --verbose --assume-unchanged file &&
>>         test_must_fail git checkout - 2>err &&
>>         test_i18ngrep overwritten err
>>  '
> 
> If this test passes with or without the addition of `--verbose`, then
> adding `--verbose` unnecessarily only pollutes what is (presumably)
> the minimum code necessary to implement what the test is checking, and
> may confuse future readers into thinking that something subtle is
> going on.

Thanks for pointing this out. I shouldn't have left this change in.
 
>> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
>> @@ -36,9 +36,14 @@ test_expect_success '--cacheinfo does not accept blob null sha1' '
>>         echo content >file &&
>>         git add file &&
>>         git rev-parse :file >expect &&
>> -       test_must_fail git update-index --cacheinfo 100644 $ZERO_OID file &&
>> +       test_must_fail git update-index --verbose --cacheinfo 100644 $ZERO_OID file >out &&
>>         git rev-parse :file >actual &&
>> -       test_cmp expect actual
>> +       test_cmp expect actual &&
>> +
>> +       cat >expect <<-\EOF &&
>> +       add '\''file'\''
>> +       EOF
>> +       test_cmp expect out
>>  '
> 
> While I understand your desire to address a gap in the test coverage,
> I worry that this sort of change, which is orthogonal to the test's
> stated purpose, has the same downsides as mentioned above (i.e.
> polluting the minimum necessary code, and potentially confusing
> readers). Rather than piggybacking on existing tests, adding one or
> two new standalone tests dedicated to checking `--verbose` would be
> more palatable, more understandable, and be less likely to confuse
> future readers. The same comment applies to the remaining changes in
> this patch.

I understand that the test wants to test specific behavior, and that
behavior is focused on certain inputs to 'git update-index', but I
also think that the --verbose option presents _additional information_
about what is expected from these behaviors. It doesn't change the
already-tested behavior, only enhances it.

If I separate things out and only had test for --verbose, I would need
to replicate many of these behaviors just for that option, which would
be wasteful.

In this particular case, I'm demonstrating that the --verbose mode
still reports the file as added (because of the earlier 'git add file')
even though the command as a whole failed due to an invalid OID.

Thanks,
-Stolee
