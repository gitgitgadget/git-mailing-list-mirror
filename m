Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7440F1FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 10:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbcIDKzB (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 06:55:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33691 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752398AbcIDKzA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 06:55:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id w207so9051911wmw.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=btr+RijBOchgzjhpsp+knSdr+IHSWreuicR93sns0Sw=;
        b=o/iA4Ou/802ST0UroG4YOGckJtVy0ja1Ja+VC77seFqoS57nmVvr700PEycs+yeFSR
         cDxJ9UZCB7DAPNLTKUSvFoIeJWjdBjjfqai+fKXcdMYbWEBrN7SO/Fn3RNM2TlfFAqcL
         TSVDo3pnKxQvH51FDfCXLZo7o+e8fhmWEqdrmgCkO9PLEaSQVJluAmyCWRx9ip0FjRgz
         qIMwQbfs7eNex1+s6Pn0Z2xRv/PA/CoOxs27KiMEujseSZrzBHYDhp6D4GMwctRY6CNS
         zjPQTP/lzsgXuEdo0iBc0QIcqEK+cPFOknEOpc3joCgdO9lEmKfucLkSHTYFYbJAH5Ks
         ALAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=btr+RijBOchgzjhpsp+knSdr+IHSWreuicR93sns0Sw=;
        b=A8MKNWDmLWKFdy2EerFJIWyZExwgFvQ5gmmUJ2UG+0k/Jr+JSGtYQqXhfYsluJ7Qoj
         ne9585tN6INZLR5dtmZmjuIBOPUOUWQwVpcBUBtDdD17IbbPrTFfys3094e1Xbt12od1
         /wg6nwbPG0rRKV0Qk0SfgOswTgeeTdE6hj26diAfcV9sLWpATWLSO7LrFRODFKGrh3OI
         EOt60soxVqgIpL0T+LPQnoA0O7+PEb2RuWLopjGGw1BwOKBEguhOWXnGZ/DpaOX0jKzt
         CYw2Zw3NmI3oJk8YC3+SxyQSr0r96tX2amihNpwL+7yQVK1QoXWar8QOyYhBMOyQquDL
         Ce9A==
X-Gm-Message-State: AE9vXwNrIG7dOWrHQICInewS96MF8MKGEilyaOhOQdBa2xwulblZU6DiPmp1QC7NIuJfZ2IUTP19lFAfYaVN7A==
X-Received: by 10.28.51.210 with SMTP id z201mr11092047wmz.98.1472986465739;
 Sun, 04 Sep 2016 03:54:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Sun, 4 Sep 2016 03:54:25 -0700 (PDT)
In-Reply-To: <CAP8UFD2Lwd_1+cWT702deF8=iFmBRKCi9gLSOizPbyLmeKepsw@mail.gmail.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <20160827184547.4365-11-chriscool@tuxfamily.org> <CAGZ79kbdoF-1=ZBZG8y3sEz6LVaNP4Ou+KVk+=M7y9PSzQ1J0Q@mail.gmail.com>
 <CAP8UFD2Lwd_1+cWT702deF8=iFmBRKCi9gLSOizPbyLmeKepsw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 4 Sep 2016 12:54:25 +0200
Message-ID: <CAP8UFD38CC-Ah9zVcnU3a4nGH2CzOn74Adx=42pmckjPv=e_Bg@mail.gmail.com>
Subject: Re: [PATCH v13 10/14] apply: change error_routine when silent
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 10:19 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Sep 1, 2016 at 12:20 AM, Stefan Beller <sbeller@google.com> wrote=
:
>> On Sat, Aug 27, 2016 at 11:45 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> To avoid printing anything when applying with
>>> `state->apply_verbosity =3D=3D verbosity_silent`, let's save the
>>> existing warn and error routines before applying, and let's
>>> replace them with a routine that does nothing.
>>>
>>> Then after applying, let's restore the saved routines.
>>>
>>> Helped-by: Stefan Beller <sbeller@google.com>
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>> ---
>>>  apply.c | 21 ++++++++++++++++++++-
>>>  apply.h |  8 ++++++++
>>>  2 files changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/apply.c b/apply.c
>>> index ddbb0a2..bf81b70 100644
>>> --- a/apply.c
>>> +++ b/apply.c
>>> @@ -112,6 +112,11 @@ void clear_apply_state(struct apply_state *state)
>>>         /* &state->fn_table is cleared at the end of apply_patch() */
>>>  }
>>>
>>> +static void mute_routine(const char *bla, va_list params)
>>
>> Instead of 'bla' you could go with 'format' as the man page for
>> [f]printf puts it.
>> Or you could leave it empty, i.e.
>>
>>     static void mute_routine(const char *, va_list)
>>     ...
>
> Ok to do that.

Actually I get the following error when doing that:

apply.c: In function =E2=80=98mute_routine=E2=80=99:
apply.c:115:1: error: parameter name omitted
 static void mute_routine(const char *, va_list)
 ^
apply.c:115:1: error: parameter name omitted
make: *** [apply.o] Error 1

So I will leave it as is.
