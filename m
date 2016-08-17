Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372351FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 22:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbcHQWSn (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 18:18:43 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36491 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbcHQWSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 18:18:41 -0400
Received: by mail-it0-f51.google.com with SMTP id e63so12107327ith.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 15:18:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/cTRtek7WHcv+T4Dz+LWLdU/eeeHC9kTWMBFsbDiZ6E=;
        b=XPKV/qjMMKqglhvh6zvc6w7HaECUg89oirtyyiHFduOlgewF3fw6gCf4IGzHrbjw5A
         /UXh80VUIO6oQ9BF/73c+/MXZZjbJVefFn+0yU5Z+k9+vqHC/H7Auww+nq/tMs+yG6U1
         iX2MIWfByeXFPYki0iQlRt87M2UqBm2n2NTEb7sULTnfQrxPC7FHVl9LrPzlN6IrYxWH
         rw6ixhM2E3FVrkWrrpmnrkXvCH1mmQTFIYbfrORaKwsM1RDS7ICy3mFgPSQOSCRHfik0
         xQDhV//YPUo+eaEIAJQlmG1LXC4Kioujmncd6+1yusd9GdJQ8npnO/aRRfIMYCt6IOKO
         yFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/cTRtek7WHcv+T4Dz+LWLdU/eeeHC9kTWMBFsbDiZ6E=;
        b=EGTJMN5LXhqpICMjD9/N9iXk+9Uqm3hIsCTRVr/10bRGX43X1RlUqZTqsFK5a//Fvu
         RbvJMpHSf3ZDE7bRMVZtZ6ynmHOxdTBqHmr5UyWdg+fTGYpoFSHr7q4e60CUFDLW1Emp
         jK+nUFhWP9ggK/mIDmf5F+doABPFCBJReap/GXqSIbhYOT5qZG1GPMNSNGSQpywUQnsF
         RumThjk0fl/2siSZVjaQDSxn8vCIjRZKoVg5EwTwlkce1N0XpzXmvxGwWK4RIWp0PhWs
         S7U6+Dyk+FwcsPUs6VgUPlBTtufJ2gubZ9tWBkgmcqoKHjG+uCRCEmMQ59s8WtoYxiHo
         PGfg==
X-Gm-Message-State: AEkoous434VxI0rpwNKgpKLqH6YRlowp32a0WUnYMLi5763k10oaQFY4dSnBgpCvPHE5waA74ene2Z+34UxYiLGA
X-Received: by 10.36.228.138 with SMTP id o132mr30084316ith.49.1471472320596;
 Wed, 17 Aug 2016 15:18:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 17 Aug 2016 15:18:40 -0700 (PDT)
In-Reply-To: <xmqq8tvv82pg.fsf@gitster.mtv.corp.google.com>
References: <20160817214635.22389-1-sbeller@google.com> <xmqq8tvv82pg.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 17 Aug 2016 15:18:40 -0700
Message-ID: <CAGZ79kaBX8UX4Hbq3Ff6DeTT6jfZTHcCXPYGOaDyMQTuWUvbyg@mail.gmail.com>
Subject: Re: [PATCHv7 8/8] clone: recursive and reference option triggers
 submodule alternates
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 17, 2016 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  Added a default for alternateErrorStrategy and hence fixed the null pointer
>>  for error_strategy in prepare_possible_alternates(),
>
> Looks much better.
>
>> +submodule.alternateLocation::
>> +     Specifies how the submodules obtain alternates when submodules are
>> +     cloned. Possible values are `no`, `superproject`.
>> +     By default `no` is assumed, which doesn't add references. When the
>> +     value is set to `superproject` the submodule to be cloned computes
>> +     its alternates location relative to the superprojects alternate.
>
> I am not seeing a code that handles 'no' and any other string that
> is not 'superproject' differently, though.
>
> I can see that "clone" has codepath that writes 'superproject' to
> the variable, but the only thing that seems to care what value the
> variable is set to checks "no".  When somebody sets the variable to
> "yes", shouldn't we at least say "Sorry, I do not understand" and
> preferrably stop before spreading potential damage?  We'd surely end
> up doing something that the user who set the value to "yes" did not
> expect.
>
> There is something still missing?
>

>> +static void prepare_possible_alternates(const char *sm_name,
>> +             struct string_list *reference)
>> +{
...
>> +     sas.submodule_name = sm_name;
>> +     sas.reference = reference;
>> +     if (!strcmp(error_strategy, "die"))
>> +             sas.error_mode = SUBMODULE_ALTERNATE_ERROR_DIE;
>> +     if (!strcmp(error_strategy, "info"))
>> +             sas.error_mode = SUBMODULE_ALTERNATE_ERROR_INFO;

(see below first)
Here goes the same for alternateErrorStrategy

>> +     if (!strcmp(sm_alternate, "superproject"))
>> +             foreach_alt_odb(add_possible_reference_from_superproject, &sas);

here is where we would add

    else if (!strcmp(sm_alternate, "no")
        ; /* do nothing */
    else
        die(_("What's wrong with you?"));

Initially I did not add that as I considered it not relevant. But I
guess it helps as a typo checker as well and it is more comforting
if a wrong value yields an error. Also it is consistent with the rest of
options.

Thanks again,
Stefan
