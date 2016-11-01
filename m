Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D047020229
	for <e@80x24.org>; Tue,  1 Nov 2016 23:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbcKAXAw (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 19:00:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35054 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbcKAXAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 19:00:51 -0400
Received: by mail-lf0-f66.google.com with SMTP id p100so5162433lfg.2
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 16:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UoCblQbmzgPUUBiYDUIo05GA/HkHHfwe4Yj7W+lCqLY=;
        b=LzI0dFWzk6lF2uu3edaRRBPrTXJ/o8mJnjcquthbjOqEady1zF6OeRIycwupPd24KA
         A6inpLjWTpvSX71AoG0e5uHqp0VYGLa9UaIfTgrSq+BBekxAxAlCRZoM/TKUYT/PDq25
         +cqWEr8R0SHqYBmhu2qSstwrZfRrdk4RW3sXMi8XAvLi1lgfbF1PTDwo4rUYiqoxHDiJ
         9Xpqcri4KdHuom14etAcIYTWqpbBQOWtcCkOA7T8rKu8GA0RvECCO766kXUeJE7/i52U
         f15MqduBtrwzEoSuXTbFp9SJMN968WG+mFZcWzjl0MFJPHFYNLI6zi0zEsmVvigIXqlU
         tcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UoCblQbmzgPUUBiYDUIo05GA/HkHHfwe4Yj7W+lCqLY=;
        b=mbScezPKOujHvhCNx3YqDaxYuVQASDzL801TnE2i9loeq/7rWsQ69ETSiWvPbAfWRE
         rDkWoM3c0C0hOB2ooDZ45tf9O6+rnJBXyFabYkQSunGlNmDAcKyrmQa6qpIUfsWxgyH5
         E5EFGsXykd4S9INz82or1/MLjtkFlp838YuPrLBsw07T9sr1w/LM0Jj4+qKf0eeFeYA+
         LWZY3+V/v2JDCMTmgjXI66BAyyzAoxdsGTCgYmYKwdrADZWd3eYLpfnGyFwEnFH9oBB8
         wUy5ncLK5YZ++eg9Bo+y8yfskyP0JTkeXgHyOl+utjXB4wX8iyi4/FX7x01y834jYXvD
         0Xxg==
X-Gm-Message-State: ABUngvfWF5A06ZYWQLKzdYjXdTek1OSBogbmFFXuwxgwRRh80Xk6tn2Clzc5IcRRSlBMRy+Usymvfy3Th5jcWw==
X-Received: by 10.25.74.85 with SMTP id x82mr207876lfa.154.1478041249466; Tue,
 01 Nov 2016 16:00:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Tue, 1 Nov 2016 16:00:48 -0700 (PDT)
In-Reply-To: <xmqqlgx3owbg.fsf@gitster.mtv.corp.google.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-6-chriscool@tuxfamily.org> <CACsJy8Br2q0aadTFjkNgb=oN8nSzbkWJEK7bCCgr7v-oOZtrSA@mail.gmail.com>
 <xmqqlgx3owbg.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 2 Nov 2016 00:00:48 +0100
Message-ID: <CAP8UFD18gcMJY7zjXw+ry6Kq2Foug9r0e=OVgZ_hcFkEVfnChA@mail.gmail.com>
Subject: Re: [PATCH v1 05/19] update-index: warn in case of split-index incoherency
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 8:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>>> index b75ea03..a14dbf2 100644
>>> --- a/builtin/update-index.c
>>> +++ b/builtin/update-index.c
>>> @@ -1098,12 +1098,21 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>>         }
>>>
>>>         if (split_index > 0) {
>>> +               if (git_config_get_split_index() == 0)
>>> +                       warning("core.splitIndex is set to false; "
>>> +                               "remove or change it, if you really want to "
>>> +                               "enable split index");
>>
>> Wrap this string and the one below with _() so they can be translated.
>
> True.
>
> I further wonder if a natural reaction from users after seeing this
> message is "I do want to--what else would I use that option to run
> you for?  Just do as you are told, instead of telling me what to
> do!".  Is this warning really a good idea, or shouldn't these places
> be setting the configuration?

In 435ec090ec (config: add core.untrackedCache, 2016-01-27) we decided
to just use warning() after discussing if we should instead set the
configuration.
