Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65AB020248
	for <e@80x24.org>; Fri, 15 Mar 2019 19:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCOTVU (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 15:21:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38749 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfCOTVU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 15:21:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id e10so4624712edy.5
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LNlpK6fqNt3IMrHX+nQLEJKEabVGoS+D/iDXKshxKJc=;
        b=CdYhpM0GH7KNUGyh5pie8VEk9CtXN+eT1zrWlkVgGl2GfryfpQvNFXns4N/uAgtFWq
         Qtvsts3rD4m93dRZBX8XkL2VOkV5rXTlst0nc8ASYI28as4/Y2bjZ4RrDd+MRqCAf9RB
         IBY0DUuV/BpzZcQRK5Nsl7PKlucGHY1VaY1A8ukbxyiAqXb/5Y63hLhmK2jt7+GmWtwf
         S9xzY4EC4n313VXKecImuRuIu+FN/HB6hyIE9VMUCL6NfOvVIwXKxhilPeJO63S6/9fF
         d0YrneDAlEzhRZdoqoEpWM0qP6Oeb/0H94tiMiSSaJdTJ8nSzEYCO7ct8oTZYgxibJCZ
         t2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LNlpK6fqNt3IMrHX+nQLEJKEabVGoS+D/iDXKshxKJc=;
        b=NH3PDv/40L4qVOXDhTI8mB30E3PHHPFM8hiUg3zOOd8gRRiacqY+Kjr264Va65GbjZ
         GpwIc7TxAKJ8PkStkH/wo9fnFtpVnwZ/2/hsiw+CoFQqq3wlXFyI8k+Vff0Ix+8oSecM
         g99qcVLhJfq3Lsb8oqCca4bmOPQ8pHQYYBxibdLl2uz8fGQQeSDTLiJ5cFRQphZkMSjF
         Qk9S2IMWOV67pRm3kdhrLgKYXPXP9KrY5M/uRm1pkXstqABDqUf3hzCEa4dbaOmaxefZ
         2u8Ic5BaLi+SQrsEoscd2eSt6gmRkSl6pzQmrfUafc2Ca0VsQR81QXxBWN+eot1QtEn0
         2gcw==
X-Gm-Message-State: APjAAAXBpNCJwYSq1rXiy5rYvDnLQv8587LiNika10/h+rqb93+Www/C
        v9vFx8Kjnz5qok4rxqWWtlI=
X-Google-Smtp-Source: APXvYqyaif0zYwpF1115TZPpnvhVJX/ZKPv93zLS3wlnBlPF9KrerRHNfvBk0lADahk7wvNYiCfxvg==
X-Received: by 2002:a50:a8a4:: with SMTP id k33mr3849344edc.261.1552677678627;
        Fri, 15 Mar 2019 12:21:18 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id u47sm887354edm.37.2019.03.15.12.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 12:21:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH/RFC] Use a higher range-diff --creation-factor for format-patch
References: <87y35g9l18.fsf@evledraar.gmail.com> <CAPig+cRMiEcXVRYrgp+B3tcDreh41-a5_k0zABe+HNce0G=Cyw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPig+cRMiEcXVRYrgp+B3tcDreh41-a5_k0zABe+HNce0G=Cyw@mail.gmail.com>
Date:   Fri, 15 Mar 2019 20:21:17 +0100
Message-ID: <87tvg49c5u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 15 2019, Eric Sunshine wrote:

> On Fri, Mar 15, 2019 at 12:09 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-form=
at-patch.txt
>> @@ -261,6 +261,10 @@ material (this may change in the future).
>> +Defaults to 90, whereas the linkgit:git-range-diff[1] default is
>> +60. It's assumed that you're submitting a new patch series & that we
>> +should try harder than normal to find similarities.
>
> My understanding was that the primary use-case of git-range-diff
> itself (which existed before the --range-diff option was added to
> git-format-patch) was to generate a "range diff" for a cover letter of
> a re-rolled series. So, I'm confused about why this tweaks the default
> value of one command but not the other.
>
>> diff --git a/range-diff.h b/range-diff.h
>> @@ -4,6 +4,7 @@
>>  #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
>> +#define RANGE_DIFF_CREATION_FACTOR_FORMAT_PATCH_DEFAULT 90
>
> The point of introducing RANGE_DIFF_CREATION_FACTOR_DEFAULT in the
> first place was to ensure that the default creation-factor didn't get
> out-of-sync between git-range-diff and git-format-patch., Thus,
> introducing this sort of inconsistency between the two would likely
> lead to confusion on the part of users. After all, --range-diff was
> added to git-format-patch merely as a convenience over having to run
> git-range-diff separately and copy/pasting its output into a cover
> letter generated by git-format-patch. If the two programs default to
> different values, then that "convenience equality" breaks down.
>
> So, I'm fairly negative on this change. However, that doesn't mean I
> would oppose tweaking the value shared between the two programs (and
> also the default used by GitGitGadget, if it specifies it manually),
> though I defer to Dscho in that regard.

I think that was the intention initially, but at least I'm now using
range-diff as a general comparison tool of different non-ff-branches,
e.g. the force-pushes to "pu".

I'd expect the tool in general to be used like that, whereas with
format-patch it's safe to say we're dealing with a re-roll of the same
thing.

Hence the hypothesis that for format-patch we can be more aggressive
about finding similarities.
