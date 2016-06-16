Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4474C1FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 19:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbcFPTZ5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 15:25:57 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35946 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbcFPTZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 15:25:56 -0400
Received: by mail-yw0-f195.google.com with SMTP id w195so6464127ywd.3
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 12:25:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ttUphSOtTVT8G7It8gJ0Gpof6gdmkuVo1yh2UTowH50=;
        b=JZ6EDD9p72/U8Pt82SB4Z4CYhfmoSHZRmwd1jy6HcNCj0xwBQgNl41oefqF7vzjub5
         Tq4Mu7KTZ9I7F2PZEkJRtQdAJIzdoB8WDxR03H1MmlkiUpkyT5EMN/ocZfEGJXlOXs2p
         Uahgqoj3lDmu/8ppAO8C1AlXnnMgyy9kZ9G/0nRLJPasB0bezxcQ2678BtGYfcAOlvjU
         uRMSl0PCRWw8Qujak79pvO0YqvGGIuFwhv/2BfTtfLqVnPxGzXE/b63cmkzqIQZGu7JA
         MxF9QhNHWrrHRa65KyBa0QIZEJnXVgde4zs+8eg7tQ8mSUSfFQYDdn/Gtybecx0+Le+U
         XV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ttUphSOtTVT8G7It8gJ0Gpof6gdmkuVo1yh2UTowH50=;
        b=blOMdIwQWjIPWTTXcvk/+PxtTrp/dD+ZknjBwJ2SvbbzXgieinvljTQ03sNnXRHQtY
         brds9dxRqEV1gG3zbHn7T/NlppZTmgoJ0ove52nsc9QZfr2bMUtY964lS9eNgZ2s+vPL
         zZZV5Y31Zj/WZsC+vY5q2B81dNnjXOIjU8zi32MXX1ksVVUjwabheYR6MGlXLMGhnZOe
         R47UKHh6CUuYbgXabWdv7ibFL6gBWR42VWddupT3wIc8rMn+orZZVQ96kmhAY+6urU9r
         8zneQ+66k/V/cZrI+RAf1w9lmIByOhAEhDyspHlOWP23SehXR5CVvMCXAUgcPr9OzIlM
         3Y8A==
X-Gm-Message-State: ALyK8tKTCR5iGX8IdvDY00pKfZJdn3dTP6T3yf1YkF2HNf6+XIH16Qsom7bSb1c94cCgk6PWbKe7+AxPqtsn3w==
X-Received: by 10.129.92.193 with SMTP id q184mr3506741ywb.33.1466105155317;
 Thu, 16 Jun 2016 12:25:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.116.193 with HTTP; Thu, 16 Jun 2016 12:25:54 -0700 (PDT)
In-Reply-To: <CAPig+cS1=bv588H6yrOy1oFvArjJNbetdTS7+ZhfGn-GtVp4qw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-6-pranit.bauva@gmail.com>
 <CAPig+cRNcg496Ty2SJ1ojm1n3OpHzX0obMAD2bY3AzoyrKdA9w@mail.gmail.com>
 <CAFZEwPP0-9rHOKFZBoE55pv4V-+okSLh4M5grNKWnq831Ug4+w@mail.gmail.com> <CAPig+cS1=bv588H6yrOy1oFvArjJNbetdTS7+ZhfGn-GtVp4qw@mail.gmail.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 17 Jun 2016 00:55:54 +0530
Message-ID: <CAFZEwPPBTd6o7qg96cet8RAp5wY1shzQ=jU8dEK1irXSiMAxQg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:	Eric Sunshine <sunshine@sunshineco.com>
Cc:	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Eric,

On Fri, Jun 17, 2016 at 12:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jun 16, 2016 at 3:05 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Thu, Jun 16, 2016 at 2:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> Reimplement `is_expected_rev` & `check_expected_revs` shell function in
>>>> C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
>>>> call it from git-bisect.sh .
>>>> [...]
>>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>>> ---
>>>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>>>> @@ -162,13 +162,44 @@ static int bisect_reset(const char *commit)
>>>> +static int is_expected_rev(const char *expected_hex)
>>>> +{
>>>> +       struct strbuf actual_hex = STRBUF_INIT;
>>>> +       int res;
>>>> +
>>>> +       if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) < 0) {
>>>> +               strbuf_release(&actual_hex);
>>>> +               return 0;
>>>> +       }
>>>> +
>>>> +       strbuf_trim(&actual_hex);
>>>> +       res = !strcmp(actual_hex.buf, expected_hex);
>>>> +       strbuf_release(&actual_hex);
>>>> +       return res;
>>>> +}
>>>
>>> Not worth a re-roll, but this could be re-structured to avoid having
>>> to remember to release the strbuf at all exits:
>>>
>>>     struct strbuf actual_hex = ...;
>>>     int res = 0;
>>>
>>>     if (strbuf_read_file(...) >= 0) {
>>>         strbuf_trim(...);
>>>         res = !strcmp(...);
>>>     }
>>>     strbuf_release(...);
>>>     return res;
>>>
>>> Alternately:
>>>
>>>     if (strbuf_read_file(...) < 0)
>>>         goto done;
>>>
>>>     strbuf_trim(...);
>>>     res = !strcmp(...);
>>>
>>> done:
>>>     strbuf_release(...);
>>>     return res;
>>>
>>> which is a bit less compact.
>>
>> I will avoid this for the reason that I will have to create a label
>> for a lot of functions. If I choose to do this for one function, I
>> think it would be more appropriate to do the same for other functions.
>> There would be a lot of functions in future which would be in the same
>> scenario and creating a separate label for each of them would be quite
>> tedious. What do you think?
>
> Not sure what you're talking about. Label names are not shared across
> functions. Anyhow, the first suggestion I presented above is more
> concise than the 'goto' version.

Yes I am aware of the fact that labels aren't shared across functions.
What I meant by "separate label" was that I will have to make a label
"fail" in each function. But I recently noticed that its used quite a
lot so I think it would be okay to use it. Will re-roll with using
labels and goto.

Regards,
Pranit Bauva
