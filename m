Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFBD2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755591AbdBOXxz (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:53:55 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36522 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755026AbdBOXxx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:53:53 -0500
Received: by mail-qt0-f196.google.com with SMTP id h53so233505qth.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LoDBNGmz0MakWQEkcqT7Zf8wNhpg6kpz0hQvQkxriUc=;
        b=X01Oz7LtlmHvyB2wm1qWcFcld/t+c4em71Nq82JmpZ+nsiak68FcIy+LWB9Hsz8/a/
         AQIoB91hoA08foFS2INqsZXfyG6MpNauXfFJ8dkAW8vVSCYBjHSYKYqEPxb7bFNz/o3S
         KH9yIORHi5l+Q9iv9Yfh+yC1aknCGqOiP39e9NBLz6is+IRcNDbeT3XyvxgN0DbjJ6r3
         LG/c5aAnbE+sYGBVLPNTphsF/pkcpUHNT5vaNhJiYZB7HxDp9Wm7YtRC1OB96cZAsqxb
         4ipi8TLsvs57WyAQ6nuEYT21e6bmgdYVwJsL5JE8WIorPfvwhJsaizJnygtaTIP3S7wt
         wwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LoDBNGmz0MakWQEkcqT7Zf8wNhpg6kpz0hQvQkxriUc=;
        b=YSlTDKhViclUGJJfuX26F++0EZxj7/WNjv1aNLIk2ThLe3oGBi3ikcDwHHZiOmskm8
         9ssYS0Zu1CD5pCLguGztlSsGdobktew5lBAjG2nDWrxv9laEDl/PnwEZaznD+7PoiQ3S
         jSgatI6DCqcjVIH53QK8mUCMFZujXh0J5Bx1YBYp8cUTYIYlZYJ/hK1u4Pp4o37HLs0Y
         rxv9KOnmQap5HrAZGodKnMZ0Jc/7zp52FdzYJljUxLJm9If13CZsRPSbKzHWO8GLYAJ/
         5kJAw2jzbjWv4d+RIAndmjQI/YMopXqSLHyvI5qgpAiUYrDuIlvN/Yf2iLiJzzQSXqC4
         I8GA==
X-Gm-Message-State: AMke39lMjuzMbtEAV5Q9QHwQFNAURGIWYFtMQXvqn5KMMW+V22zNfQJrLaLeZI6qowkt9FKR+q8fnPeE9LjP2A==
X-Received: by 10.200.35.105 with SMTP id b38mr33846907qtb.1.1487202832648;
 Wed, 15 Feb 2017 15:53:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.131 with HTTP; Wed, 15 Feb 2017 15:53:31 -0800 (PST)
In-Reply-To: <CAGZ79kZgmtH1-1i5Fenq8kELbafBL1tCx66SGqGVBmjbpLoBGQ@mail.gmail.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
 <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com> <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
 <xmqqy3x712if.fsf@gitster.mtv.corp.google.com> <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaKhjNPGRVJ6H=CMKQ1RKXmVvSPOMo4c3haNeS60aWQXA@mail.gmail.com>
 <xmqqh93v10vy.fsf@gitster.mtv.corp.google.com> <CAGZ79kZgmtH1-1i5Fenq8kELbafBL1tCx66SGqGVBmjbpLoBGQ@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 15 Feb 2017 15:53:31 -0800
X-Google-Sender-Auth: QOHPpSBHp784PKfXBXIfY3WP-Sc
Message-ID: <CAPc5daVwYNvChw8_q7m=NS8aM5QKRMvUKN6r8PMycLZKy=PLKg@mail.gmail.com>
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ahh, that would work, too.

On Wed, Feb 15, 2017 at 3:43 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Feb 15, 2017 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Yes; though I'd place it in strbuf.{c,h} as it is operating
>>> on the internals of the strbuf. (Do we make any promises outside of
>>> strbuf about the internals? I mean we use .buf all the time, so maybe
>>> I am overly cautious here)
>>
>> I'd rather have it not use struct strbuf as an interface.  It only
>> needs to pass "char *" and its promise that it touches the string
>> in-place without changing the length need to be documented as a
>> comment before the function.
>>
>>>>  config.c | 16 +++++++++++++++-
>>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/config.c b/config.c
>>>> index c6b874a7bf..98bf8fee32 100644
>>>> --- a/config.c
>>>> +++ b/config.c
>>>> @@ -201,6 +201,20 @@ void git_config_push_parameter(const char *text)
>>>>         strbuf_release(&env);
>>>>  }
>>>>
>>>> +static void canonicalize_config_variable_name(struct strbuf *var)
>>>> +{
>>>> +       char *first_dot = strchr(var->buf, '.');
>>>> +       char *last_dot = strrchr(var->buf, '.');
>>>
>>> If first_dot != NULL, then last_dot !+ NULL as well.
>>> (either both are NULL or none of them),
>>> so we can loose one condition below.
>>
>> I do not think it is worth it, though.
>>
>>>> +       char *cp;
>>>> +
>>>> +       if (first_dot)
>>>> +               for (cp = var->buf; *cp && cp < first_dot; cp++)
>>>> +                       *cp = tolower(*cp);
>>>> +       if (last_dot)
>>>> +               for (cp = last_dot; *cp; cp++)
>>>> +                       *cp = tolower(*cp);
>>
>>         if (first_dot) {
>>                 scan up to first dot
>>                 if (last_dot)
>
> just leave out the 'if (last_dot)' ?
>
>     if (first_dot)  {
>         /* also implies last_dot */
>         do 0 -> first
>         do last -> end
>     }
