Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A131F667
	for <e@80x24.org>; Tue, 15 Aug 2017 10:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbdHOKXN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 06:23:13 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34709 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753585AbdHOKXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 06:23:12 -0400
Received: by mail-pg0-f44.google.com with SMTP id u185so3547598pgb.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZftCYRm1mJNOPSk26IeUkPs5kwLsnfdWiM8zHCtUgIE=;
        b=mViPwev7mkauDEerDN05ySgILoq0z62KpZU3Mj1UIZG0NNWcru2O+CAbWtc2inieSo
         6vD05yynSDz5Ufa1NUgSdplXNLNhUXtG+54MaRyhj2DY15XfpRAlIF/x2T8LESnFoWKI
         IrXpwzqmf+5LqMUjwV7n4ZY4n0/0STIqLKN8duOAmIb6t8tmzXd6cI957D4TEZm54LSk
         lMfpugwIlnrHnfIuLUMxeegyKERwXQv606WCuJqk1rtBiPXj05IEs1vG+TaYM8/oB6tb
         DYF/YjKDTRdOxfnXV860tNUycwmRbjhehi8S4c81mdG21nygyuJCrzbJGZHAtbXLFMcR
         GghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZftCYRm1mJNOPSk26IeUkPs5kwLsnfdWiM8zHCtUgIE=;
        b=cfZI2obUWCoGgW8drBJm6TcfwxzCbZ/75EGjvs1N+0zR0xPVvYjCO3qwuW257Rav2C
         t2fc6AUE/ywDRwTXjBczuvw3GAbppn2GIfp0ASoEfWVuDqtjY9VTZFTo9M6M+L8Ronuv
         hzsSLmr+fwvQimRdo4JNPnmAiiA6xlyu3hW5JFRkdc57I0SiNYYZtwqr/lC8GIvBUgga
         44woekADZojvNJv+pMNeUQ8f/r0cH5FOVedzbWkCqmqxgSa0aDhrS5jEvJcRGFJr16xF
         +kUkO/25S79BGx02bgS99I5/rvilPTbSf21gZ1RkHuJeWHwGcjlkxTaRE1PRWVrmsCgu
         ZAuA==
X-Gm-Message-State: AHYfb5j+CTqanYPek1CCX3I45fBiOyn5pQHzOzZTLWF7RGXuX9f90kd9
        harRqmJp9E07uqzVFww=
X-Received: by 10.98.216.70 with SMTP id e67mr27831558pfg.299.1502792591504;
        Tue, 15 Aug 2017 03:23:11 -0700 (PDT)
Received: from ?IPv6:2405:204:700b:d138:d4f3:b513:ec16:b5d5? ([2405:204:700b:d138:d4f3:b513:ec16:b5d5])
        by smtp.gmail.com with ESMTPSA id 133sm16310629pge.29.2017.08.15.03.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 03:23:10 -0700 (PDT)
Subject: Re: [PATCH v3 1/2 / RFC] builtin/branch: stop supporting the use of
 --set-upstream option
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
 <20170814085442.31174-1-kaarticsivaraam91196@gmail.com>
 <CAN0heSr1FjayzX-SnNVcgQuh+Cc-f=AjY8H=pGG6uvf8rrJM=A@mail.gmail.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <b12f73f0-b4de-e96e-f102-2ec919ca8db5@gmail.com>
Date:   Tue, 15 Aug 2017 15:53:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSr1FjayzX-SnNVcgQuh+Cc-f=AjY8H=pGG6uvf8rrJM=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 15 August 2017 12:44 AM, Martin Ågren wrote:
>>   --set-upstream::
>> -       If specified branch does not exist yet or if `--force` has been
>> -       given, acts exactly like `--track`. Otherwise sets up configuration
>> -       like `--track` would when creating the branch, except that where
>> -       branch points to is not changed.
>> +       As this option has confusing syntax it's no longer supported. Please use
> "has" or "had"? (I guess when someone reads this, it "has" no syntax at
> all. ;) )
Got it.
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index dd37ac47c..249be4b1a 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -561,7 +561,8 @@ test_expect_success 'use --set-upstream-to modify a particular branch' '
>>          git branch my13 &&
>>          git branch --set-upstream-to master my13 &&
>>          test "$(git config branch.my13.remote)" = "." &&
>> -       test "$(git config branch.my13.merge)" = "refs/heads/master"
>> +       test "$(git config branch.my13.merge)" = "refs/heads/master" &&
>> +       git branch --unset-upstream my13
> I think it would be safer to use test_when_finished like on line 625.
> Out of curiosity: are you adding this out of caution, or did some later
> test fail without this?
One test seems to fail without this. I guess it's better to keep this 
change as a separate
commit.

>> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
>> index 97a07655a..4b522f456 100755
>> --- a/t/t6040-tracking-info.sh
>> +++ b/t/t6040-tracking-info.sh
>> @@ -188,35 +188,35 @@ test_expect_success 'fail to track annotated tags' '
>>          test_must_fail git checkout heavytrack
>>   '
>>
>> -test_expect_success 'setup tracking with branch --set-upstream on existing branch' '
>> +test_expect_success 'setup tracking with branch --set-upstream-to on existing branch' '
>>          git branch from-master master &&
>>          test_must_fail git config branch.from-master.merge > actual &&
>> -       git branch --set-upstream from-master master &&
>> +       git branch --set-upstream-to master from-master &&
>>          git config branch.from-master.merge > actual &&
>>          grep -q "^refs/heads/master$" actual
>>   '
>>
>> -test_expect_success '--set-upstream does not change branch' '
>> +test_expect_success '--set-upstream-to does not change branch' '
>>          git branch from-master2 master &&
>>          test_must_fail git config branch.from-master2.merge > actual &&
>>          git rev-list from-master2 &&
>>          git update-ref refs/heads/from-master2 from-master2^ &&
>>          git rev-parse from-master2 >expect2 &&
>> -       git branch --set-upstream from-master2 master &&
>> +       git branch --set-upstream-to master from-master2 &&
>>          git config branch.from-master.merge > actual &&
>>          git rev-parse from-master2 >actual2 &&
>>          grep -q "^refs/heads/master$" actual &&
>>          cmp expect2 actual2
>>   '
> The two tests above were added when --set-upstream was originally added.
> Now that you're converting them to use --set-upstream-to, to what extent
> do they just test the same thing as the tests in t3200?
The first seems useless, I'll remove it. Regarding the second one, as 
far as I could see
there's no test in t3200 that does something similar so I guess it could 
be kept back.

---
Kaartic
