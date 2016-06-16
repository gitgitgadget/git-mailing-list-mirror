Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A947B1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 19:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbcFPTQW (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 15:16:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36735 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbcFPTQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 15:16:21 -0400
Received: by mail-io0-f195.google.com with SMTP id s63so6833792ioi.3
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 12:16:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BtGP3U+CmFP+ky3hsexTODfq8jvqTH+e/NWz1KNX2b0=;
        b=PJZZi7nN+xkQdjsb8Fqd3sH8uaWo8aC6BYlGo7vGRLishAGtkNu4RwPjL9KmvKmw+y
         gwdUW3c4jALYQFODe3OB7wySOHeb1eQIWIFbvOhuYvB1DL983DuIGeWsXbjj7wJFpj17
         5KdyDfDa3ThVFuglW9Vw6S4smvi2F/1D5KxVla9sfrnF52dER/siIUW2CPVzlUAUt591
         gLvRPTLQRfwRpo+k1Y5pd/rMBtTKvSuWiZZlpOap/bgU888wEqOhsDhz0H4pbgFFKQoq
         ILBsH3vDoFF7WMBeVzBgETfaeqKlKET6rSaIzK8J0pnyN9369qU4DYSZDoiBfxKF6b2o
         MnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BtGP3U+CmFP+ky3hsexTODfq8jvqTH+e/NWz1KNX2b0=;
        b=YBCsZ1x4O9h2HR0JuCWl4yVEZPZaB83ILyZpD3eBpElzwQx6a9MVVaOl0SR6lPXrS8
         Ihhh9Tq0WiPpmfq8RXtvM+W7J14nFP5zD+bU/9gXx6Wrs0xMJFOFESjGcu7vRFvugE0f
         YJpllP8vQ3ZxfDpjLVuhhbB0DU1ZsfJO/FNJ0RGztxRAsUab7ZJdK6RqJsL6HYitV3bO
         V04JL6B92Fq1g8AUKcCBGMYDDkRiSXsHHV3OB6GZZytYI8NjCVzR/CZHJU8msKUtKvJb
         C/DeIFpMU4vXProeXf5qO0QvSCeShkOdE6VW8Vh5IUfMw/JmyJ6z7/aRRidQU6CSgZBE
         zqHQ==
X-Gm-Message-State: ALyK8tJahH2uIdByKnuU+13FAVC4SbHaItYgkOKg96z6p7bsVeXRr9gHm6yVFBGzuxy87Us/1x4W/7PVrWIa6A==
X-Received: by 10.107.132.28 with SMTP id g28mr4161875iod.34.1466104580502;
 Thu, 16 Jun 2016 12:16:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Thu, 16 Jun 2016 12:16:20 -0700 (PDT)
In-Reply-To: <CAFZEwPP0-9rHOKFZBoE55pv4V-+okSLh4M5grNKWnq831Ug4+w@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-6-pranit.bauva@gmail.com>
 <CAPig+cRNcg496Ty2SJ1ojm1n3OpHzX0obMAD2bY3AzoyrKdA9w@mail.gmail.com> <CAFZEwPP0-9rHOKFZBoE55pv4V-+okSLh4M5grNKWnq831Ug4+w@mail.gmail.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Thu, 16 Jun 2016 15:16:20 -0400
X-Google-Sender-Auth: ZExrBG6LdVZy2CtcI74069fvHpA
Message-ID: <CAPig+cS1=bv588H6yrOy1oFvArjJNbetdTS7+ZhfGn-GtVp4qw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:	Pranit Bauva <pranit.bauva@gmail.com>
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

On Thu, Jun 16, 2016 at 3:05 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Thu, Jun 16, 2016 at 2:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> Reimplement `is_expected_rev` & `check_expected_revs` shell function in
>>> C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
>>> call it from git-bisect.sh .
>>> [...]
>>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>> ---
>>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>>> @@ -162,13 +162,44 @@ static int bisect_reset(const char *commit)
>>> +static int is_expected_rev(const char *expected_hex)
>>> +{
>>> +       struct strbuf actual_hex = STRBUF_INIT;
>>> +       int res;
>>> +
>>> +       if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) < 0) {
>>> +               strbuf_release(&actual_hex);
>>> +               return 0;
>>> +       }
>>> +
>>> +       strbuf_trim(&actual_hex);
>>> +       res = !strcmp(actual_hex.buf, expected_hex);
>>> +       strbuf_release(&actual_hex);
>>> +       return res;
>>> +}
>>
>> Not worth a re-roll, but this could be re-structured to avoid having
>> to remember to release the strbuf at all exits:
>>
>>     struct strbuf actual_hex = ...;
>>     int res = 0;
>>
>>     if (strbuf_read_file(...) >= 0) {
>>         strbuf_trim(...);
>>         res = !strcmp(...);
>>     }
>>     strbuf_release(...);
>>     return res;
>>
>> Alternately:
>>
>>     if (strbuf_read_file(...) < 0)
>>         goto done;
>>
>>     strbuf_trim(...);
>>     res = !strcmp(...);
>>
>> done:
>>     strbuf_release(...);
>>     return res;
>>
>> which is a bit less compact.
>
> I will avoid this for the reason that I will have to create a label
> for a lot of functions. If I choose to do this for one function, I
> think it would be more appropriate to do the same for other functions.
> There would be a lot of functions in future which would be in the same
> scenario and creating a separate label for each of them would be quite
> tedious. What do you think?

Not sure what you're talking about. Label names are not shared across
functions. Anyhow, the first suggestion I presented above is more
concise than the 'goto' version.
