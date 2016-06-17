Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A786B20179
	for <e@80x24.org>; Fri, 17 Jun 2016 12:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbcFQMtl (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 08:49:41 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33628 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbcFQMtk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 08:49:40 -0400
Received: by mail-yw0-f196.google.com with SMTP id d137so2809728ywe.0
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 05:49:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EJbb4w7f8oiJM1JEmJlAdN/fLkSaH5vHN2K0hZPYJY4=;
        b=Z78jafec86tA+dcwfehGt6f+ANYHKWondIVvwiPH+9yCHIQ8eUXLpYN9F4vRcDrkRz
         5Cb7j92IsiwO+MBteZSdx4tMccx1bEEFxeBX59JM5LZx8CJoWxbLKIjf79QlGEY1cjjh
         phz+3JsWPmGnq7hB2x2C3zsZrQvREQ+SBuLCvFN479fFYBot3k9hz/JVnQC801aVD06r
         kSmXd1OVTFtyPoYQ5zKB0Ztum/RaLjFeJUVmjtXip1nGA4uoGF+5cFrNIAQweL5Atxbv
         HYuovPIK6/UftRGqaCw25XltSbxiJpZHm3kwMsfhXmnXYKg4zyUgjFcfUg2EMD43yWj9
         kWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EJbb4w7f8oiJM1JEmJlAdN/fLkSaH5vHN2K0hZPYJY4=;
        b=T1fo7qfT2qUJRHk4nouAi+tpnk/aMPGFnaSjNV4TfYkAt+KyYEVoo+fJ0cyWx2ditX
         OceTrO9qvxb7ZaLBPW8nMydhzpoUf8tpoWMRxrAgngr6unLHM6YrJqT+1hHZUly0dXbP
         79fFKkRoDesMfXbvwXOv/mLmz7tqBEjOwaFR3sAXOLt8DmOZ3vELSZ6UIGbK+X/kcPQB
         TQBj5klY7Zk2zaUCcrhBrwiWhObPNBRTLaVOm/fDABi3+Ns7NExOCE3n+Bt1cQ9F5C1d
         lutwdaIl/ua1M+cWHFxMVMkh/Q3/+r6kFzKR5s3P1dWW7og6p1MWu32vY2nLMPXmFkDR
         FQxA==
X-Gm-Message-State: ALyK8tL1nZkmZdeQksdgtYIaH+1TmQ1m7Ii75fmaKgdYKRlc9nOH0jPbZLwoAnkglAYnhDElqTtNLc/xQvyjFw==
X-Received: by 10.37.198.133 with SMTP id k127mr934450ybf.53.1466167779612;
 Fri, 17 Jun 2016 05:49:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.116.193 with HTTP; Fri, 17 Jun 2016 05:49:39 -0700 (PDT)
In-Reply-To: <CAP8UFD0YNNzF4qqdvDbrONaMm8B8G_amePq2g58TYrjm+9W6Vw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-6-pranit.bauva@gmail.com>
 <CAPig+cRNcg496Ty2SJ1ojm1n3OpHzX0obMAD2bY3AzoyrKdA9w@mail.gmail.com>
 <CAFZEwPP0-9rHOKFZBoE55pv4V-+okSLh4M5grNKWnq831Ug4+w@mail.gmail.com>
 <CAPig+cS1=bv588H6yrOy1oFvArjJNbetdTS7+ZhfGn-GtVp4qw@mail.gmail.com>
 <CAFZEwPPBTd6o7qg96cet8RAp5wY1shzQ=jU8dEK1irXSiMAxQg@mail.gmail.com> <CAP8UFD0YNNzF4qqdvDbrONaMm8B8G_amePq2g58TYrjm+9W6Vw@mail.gmail.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 17 Jun 2016 18:19:39 +0530
Message-ID: <CAFZEwPPUX16omOgk4V87UYheJH_+kBueGd4OzAJsit=j2Q6mNg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Christian,

On Fri, Jun 17, 2016 at 2:17 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Jun 16, 2016 at 9:25 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Hey Eric,
>>
>> On Fri, Jun 17, 2016 at 12:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Thu, Jun 16, 2016 at 3:05 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> On Thu, Jun 16, 2016 at 2:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>>>> Reimplement `is_expected_rev` & `check_expected_revs` shell function in
>>>>>> C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
>>>>>> call it from git-bisect.sh .
>>>>>> [...]
>>>>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>>>>> ---
>>>>>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>>>>>> @@ -162,13 +162,44 @@ static int bisect_reset(const char *commit)
>>>>>> +static int is_expected_rev(const char *expected_hex)
>>>>>> +{
>>>>>> +       struct strbuf actual_hex = STRBUF_INIT;
>>>>>> +       int res;
>>>>>> +
>>>>>> +       if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) < 0) {
>>>>>> +               strbuf_release(&actual_hex);
>>>>>> +               return 0;
>>>>>> +       }
>>>>>> +
>>>>>> +       strbuf_trim(&actual_hex);
>>>>>> +       res = !strcmp(actual_hex.buf, expected_hex);
>>>>>> +       strbuf_release(&actual_hex);
>>>>>> +       return res;
>>>>>> +}
>>>>>
>>>>> Not worth a re-roll, but this could be re-structured to avoid having
>>>>> to remember to release the strbuf at all exits:
>>>>>
>>>>>     struct strbuf actual_hex = ...;
>>>>>     int res = 0;
>>>>>
>>>>>     if (strbuf_read_file(...) >= 0) {
>>>>>         strbuf_trim(...);
>>>>>         res = !strcmp(...);
>>>>>     }
>>>>>     strbuf_release(...);
>>>>>     return res;
>>>>>
>>>>> Alternately:
>>>>>
>>>>>     if (strbuf_read_file(...) < 0)
>>>>>         goto done;
>>>>>
>>>>>     strbuf_trim(...);
>>>>>     res = !strcmp(...);
>>>>>
>>>>> done:
>>>>>     strbuf_release(...);
>>>>>     return res;
>>>>>
>>>>> which is a bit less compact.
>>>>
>>>> I will avoid this for the reason that I will have to create a label
>>>> for a lot of functions. If I choose to do this for one function, I
>>>> think it would be more appropriate to do the same for other functions.
>>>> There would be a lot of functions in future which would be in the same
>>>> scenario and creating a separate label for each of them would be quite
>>>> tedious. What do you think?
>>>
>>> Not sure what you're talking about. Label names are not shared across
>>> functions. Anyhow, the first suggestion I presented above is more
>>> concise than the 'goto' version.
>>
>> Yes I am aware of the fact that labels aren't shared across functions.
>> What I meant by "separate label" was that I will have to make a label
>> "fail" in each function. But I recently noticed that its used quite a
>> lot so I think it would be okay to use it. Will re-roll with using
>> labels and goto.
>
> My opinion is that if there is a more concise version without labels
> and gotos, it's better to use it, so I would suggest Eric's first
> suggestion which is:
>
>>     struct strbuf actual_hex = ...;
>>     int res = 0;
>>
>>     if (strbuf_read_file(...) >= 0) {
>>         strbuf_trim(...);
>>         res = !strcmp(...);
>>     }
>>     strbuf_release(...);
>>     return res;

Sure I could do that!

Regards,
Pranit Bauva
