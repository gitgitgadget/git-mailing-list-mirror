Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25C501F855
	for <e@80x24.org>; Wed,  3 Aug 2016 07:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbcHCHWS (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 03:22:18 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38637 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbcHCHWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 03:22:17 -0400
Received: by mail-wm0-f50.google.com with SMTP id o80so321977194wme.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 00:22:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zkNPv6EyJtLSeHCU6RPBQmRUFGe618psAhGNcQjsuW4=;
        b=Ix5Dbfvc5hoCvtEBdmgCgb5RStVuRw7CXwogbILinOdbcUQJHIWqAhntVKY2iEJO+5
         nOSKBT0BFR1xGg1WwWzKq3pybYExWE3+3ZI61yfAPbrCGDTZwYDMRvKOgj7+lvHIzuxR
         qDGrmQinH4QEX2DCTcWO3yO4Z/6dAlGcUXnEoRCKnI4LuuRJISolmfv/JGFJPMC/CxkV
         AXzK5fSGIBcWog4QF44FRAkHlVth2GXbV9Q+BlD6riklNmywoVD99ntNP7d6NJSai65n
         VQOeboOZrI5Zswr8G2/cbTMCIGn17dEZz9PPFHvBydEAlOeXlf0071AJmLNPBb0r4ycw
         dIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zkNPv6EyJtLSeHCU6RPBQmRUFGe618psAhGNcQjsuW4=;
        b=EeK9VjbCWeinCbBx1zWEn8RO8rGXxt10xbQllV4jZwJ0lVCQoV352xOfxYg9NOZncf
         K6TtCDF4R9j9Yf3T7B/3CJff68ZBIxFLpqztQOrfe1QtLd5RhmIWdreTtEJdOkYGYgZA
         D6Q6maSyUSruvhh9g3mKxTyAJaGECctioR3UI3YNfDxwF/mfCVt0DkwZujdHDNOuptXl
         ih9apELa9oNB8mFPIyJSrq1h2Niubrx2xFDpfqp5Yb2VdyGo+gdUud7bCx4GYTH9h1h3
         mQOEJR75KnG6wAriEA+yu4mtHvaZVRGUsLPkEVEU6qsjZ95mSMix1G4PX4qNVVA7lNNA
         CkRw==
X-Gm-Message-State: AEkoouuA0hL/q/c4Ap+0SMqDZXoN6obFds06RAmeeKJ/dYiCPlP4ev3G2Umfl/2fDfW31n9EqatozDRioKkxBw==
X-Received: by 10.28.113.151 with SMTP id d23mr23789645wmi.89.1470207447341;
 Tue, 02 Aug 2016 23:57:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Tue, 2 Aug 2016 23:57:26 -0700 (PDT)
In-Reply-To: <xmqqh9b4i5o6.fsf@gitster.mtv.corp.google.com>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
 <20160730172509.22939-34-chriscool@tuxfamily.org> <CAGZ79kYzxCq6M49Zmf_4J7xTdXHMunvgPuFaLnV7fXtuTbEogQ@mail.gmail.com>
 <xmqqlh0gi5sv.fsf@gitster.mtv.corp.google.com> <xmqqh9b4i5o6.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 3 Aug 2016 08:57:26 +0200
Message-ID: <CAP8UFD2GS1woM0msKJ3w5Bi4LUDkAySScBvk3xAVFVApeZxhWw@mail.gmail.com>
Subject: Re: [PATCH v9 33/41] environment: add set_index_file()
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 10:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> In cache.h we have a NO_THE_INDEX_COMPATIBILITY_MACROS,
>>> and lots of
>>>   #define foo_bar(..) frob_bar(&the_index, (..))
>>>
>>> Could you operate on the raw functions that take pointers to &the_index
>>> and point these to a temporary index?
>>
>> Isn't mention of the_index is a red-herring?
>>
>> The in-core index_state does not even know what file it needs to be
>> written to, so whether you explicitly specify your own index or use
>> the compat macros to access the_index, you would need to specify to
>> which file you would write it out or from which file you would read
>> the new contents.
>
> Having said that, I agree with you that the cop-out "Yes we know
> this is bad" needs a lot more clarification, pointing out what issue
> this side-steps and a direction to solve it correctly.

I am ok to add more explanations like those in my answer to Stefan in
the commit message, and also to add a warning comment in cache.h, but
I am not sure I know really well how to solve these issues correctly.
So I am not sure what I could add about that, except perhaps that it
is an other project to fix these issues and that it should start by
fixing them in other core libified code like dir.c and diff.c.

Do you want me to resend everything, or is it ok if I just resend the
last 9 patches in the series, so starting from this patch (32/41)?
