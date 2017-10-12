Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2005D20467
	for <e@80x24.org>; Thu, 12 Oct 2017 20:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756596AbdJLUQn (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:16:43 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:48512 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756587AbdJLUQk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:16:40 -0400
Received: by mail-qk0-f193.google.com with SMTP id d67so2622837qkg.5
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nib9qeKYyMlrQKXxXy4ObER8TaZ2rlhGuJDQEKNWuyo=;
        b=jPMh+Q5BBDR9eGQir/9ZpgC0/yBD6BVCuWE9PlDgF+gNtlMtHPrnf6BaOu33phsrlL
         150cIOh4iEx6nxlYG+eYl5zxRCF3m9BMdRIcrHB92Uu9mkI/HHTC2UuyWj2yJ88+mOg1
         Uzf8kwEGjyY0wSk3RoSIGkcjAyL3hHe3mIvcvYZfDVZyXXRBytqWmu8LICEKdkVuoalc
         p1o6OpNYDLfjb5Rc73gHGmmyf4QtalM8dyNlmRCihmv6ZV/DvSvUdEJcIOpg/Hl4cAGI
         oqBlePdkJozFc6uwyoDCOwRX3JbWvfe5zAgT6GC/4MV8plOmE+VgburJqz68FnKath94
         51+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nib9qeKYyMlrQKXxXy4ObER8TaZ2rlhGuJDQEKNWuyo=;
        b=ChgqXdaNNoiYys/VttO5G5l7BDYc5iw6oqls3whDskPYsKo40GW0quUF7clW0unVuO
         P3fs8jsDDhkRkW81dHD1MYrtKsb0rMToqaPzMSujTt4aRz1aYIy8Lv7aej4CtQit3Dc+
         yyIEjifOLn9zVIoT8C1+guiHWDmcnFp+9bpfkkPct+oGgO5ErwzLaxudMjCa0R9ylTH9
         9OQ42rYJCjhlZRk7tzt6lDWErNxb1YvaiYVwGpqSi15obQEFcmd+gAIjigipbrm0Nube
         6+UV0C5hDihmNTjbD4lnRNVxiAXGhBDP0NSPKi+H8HPndNio9boD4g/YMs1L6cY/cZ6S
         t0qw==
X-Gm-Message-State: AMCzsaWgE8hBqiuD/KaSX0r6YofRSxQSxRpTkPDDjbrErV76DO37Qm46
        5LPTsWkuR0M4/lQQQjcovic=
X-Google-Smtp-Source: ABhQp+Qm1tZGK/695wwmJcA+XvR0Z3X9QFrEaECdBUHwQ79Q2HKals2QMwi/wIuiAtpDFRbdYm5Vzw==
X-Received: by 10.55.159.209 with SMTP id i200mr2192649qke.277.1507839399597;
        Thu, 12 Oct 2017 13:16:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id z192sm9814452qka.91.2017.10.12.13.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 13:16:39 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] Add tests around status handling of ignored
 arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171011133504.15049-1-jamill@microsoft.com>
 <20171011133504.15049-6-jamill@microsoft.com>
 <xmqqefq91041.fsf@gitster.mtv.corp.google.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <06a99e74-441e-ab22-fb4c-45302523d5cb@gmail.com>
Date:   Thu, 12 Oct 2017 16:16:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqefq91041.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/12/2017 12:06 AM, Junio C Hamano wrote:
> Jameson Miller <jameson.miller81@gmail.com> writes:
>
>> Add tests for status handling of '--ignored=matching` and
>> `--untracked-files=normal`.
>>
>> Signed-off-by: Jameson Miller <jamill@microsoft.com>
>> ---
> Hmph, having some tests in 3/5, changes in 4/5 and even more tests
> in 5/5 makes me as a reader a bit confused, as the description for
> these two test patches does not make it clear how they are related
> and how they are different.  Is it that changes in 1/5 alone does
> not fulfill the promise made by documentation added at 2/5 so 3/5
> only has tests for behaviour that works with 1/5 alone but is broken
> with respect to what 2/5 claims until 4/5 is applied, and these "not
> working with 1/5 alone, but works after 4/5" are added in this step?

Correct. The changes in 1/5 are to implement "--ignored=matching"
with "--untracked-files=all" with corresponding tests in 3/5. The
changes in 4/5 are to implement "--ignored=matching"
with "--untracked-files=normal" and the corresponding tests are
in 5/5.

Do you have a preference on how I organized this work? I see
several possible ways to split up this work. Maybe it would be
less confusing to have the implementation in the first two
commits, then 1 commit with all the tests, and then a commit with
the documentation? I think it makes sense to have the logic for
the different flag combinations split into their own commits, but
I am open to any suggestions.

>
>>   t/t7519-ignored-mode.sh | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t7519-ignored-mode.sh b/t/t7519-ignored-mode.sh
>> index 76e91427b0..6be7701d79 100755
>> --- a/t/t7519-ignored-mode.sh
>> +++ b/t/t7519-ignored-mode.sh
>> @@ -116,10 +116,68 @@ test_expect_success 'Verify status behavior on ignored folder containing tracked
>>   		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
>>   		ignored_dir/tracked &&
>>   	git add -f ignored_dir/tracked &&
>> -	test_tick &&
>>   	git commit -m "Force add file in ignored directory" &&
>>   	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
>>   	test_i18ncmp expect output
>>   '
>>   
>> +test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
>> +	test_when_finished "git clean -fdx" &&
>> +	cat >expect <<-\EOF &&
>> +	? expect
>> +	? output
>> +	? untracked_dir/
>> +	! ignored_dir/
>> +	! ignored_files/ignored_1.ign
>> +	! ignored_files/ignored_2.ign
>> +	EOF
>> +
>> +	mkdir ignored_dir ignored_files untracked_dir &&
>> +	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
>> +		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
>> +		untracked_dir/untracked &&
>> +	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
>> +	test_i18ncmp expect output
>> +'
>> +
>> +test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
>> +	test_when_finished "git clean -fdx" &&
>> +	cat >expect <<-\EOF &&
>> +	? expect
>> +	? output
>> +	? untracked_dir/
>> +	! ignored_dir/
>> +	! ignored_files/ignored_1.ign
>> +	! ignored_files/ignored_2.ign
>> +	EOF
>> +
>> +	mkdir ignored_dir ignored_files untracked_dir &&
>> +	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
>> +		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
>> +		untracked_dir/untracked &&
>> +	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
>> +	test_i18ncmp expect output
>> +'
>> +
>> +test_expect_success 'Verify status behavior on ignored folder containing tracked file' '
>> +	test_when_finished "git clean -fdx && git reset HEAD~1 --hard" &&
>> +	cat >expect <<-\EOF &&
>> +	? expect
>> +	? output
>> +	! ignored_dir/ignored_1
>> +	! ignored_dir/ignored_1.ign
>> +	! ignored_dir/ignored_2
>> +	! ignored_dir/ignored_2.ign
>> +	EOF
>> +
>> +	mkdir ignored_dir &&
>> +	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
>> +		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
>> +		ignored_dir/tracked &&
>> +	git add -f ignored_dir/tracked &&
>> +	git commit -m "Force add file in ignored directory" &&
>> +	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
>> +	test_i18ncmp expect output
>> +'
>> +
>>   test_done

