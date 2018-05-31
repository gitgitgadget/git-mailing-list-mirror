Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0295D1F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753984AbeEaHRp (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:17:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35389 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753952AbeEaHRo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:17:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so637551wme.0
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TA2x8NefcmszIRLD9l8GWObHkcbFYiF8p+H3p1P0u+4=;
        b=QC2oDC2l6s9YHIbZVM69ksTfJu7jB/HdsV6+F1sL2Bz8rJrm4NTAgVFJB6GWm0ycLe
         Phnqcr18goZCFV6iDWEzqejLHO1LFOnQh8byCOrVHBsd4/GJH6LvIEw7ZuuCm7UCLrtQ
         yHtM10KFo+3q+6/pfeuR+/I+/vAnl7QSHP6O+WypvzUCRynUg7W5i01wyGlJfRb7Do2A
         7mPPPl0YF8LdWj92Pju1d9RIu5OZc+eGP8ETVYmScnhhsPI9sYMfbW9D2CwG//zXCCHr
         NyGBvFV7UsyAuS01TYbmtNgWULeqeyUDdUI2TeJ94hHuiTTyaiOtk3OH7s0iJc+iYoL0
         nucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TA2x8NefcmszIRLD9l8GWObHkcbFYiF8p+H3p1P0u+4=;
        b=sfdQp7bUY1BCHaIHqzCU8dnE2+fggTmBGeed8nLsJfftH02pMfr93z7yH5jid5fMs5
         cJITm4Gmb/p7IxqplgWeOuJxmt5yfGAqdidl6WOyUJyMFP03zNiq55sGHePdslrACAjf
         OgSUdzKEZmhxRX6F/T2n7Z/0AHOFZZDsiUpE0byzTTBZ9pahJTrAZr10e3Zw76HEMGh+
         wbec5Y7DfP4VaUnL17nM1mzG5aVZy9DHQ/vtE4Bu4SInyk9oJB6l5BBtYW+GRgO3KQDG
         Yf7+kHsr/NhJ5dLWIu7Sut/44NO42HQ8BNnlg5W4D3CbBpdJcUS5qvmnT6kJf3SFQ4ar
         KApA==
X-Gm-Message-State: ALKqPwcaAvko71NsgEJM83U3UXQeF3hzZ+XjNwKAlMVZiwT8iNjhzHCO
        796Q9TQj28JCjXHeG9BK9b4g7Zsr
X-Google-Smtp-Source: ADUXVKKgc7MaBU5xR+2o3Li8MtOQuY6uSuY5WJQAW9Owa4RyFnsW8FNxs/I/DIlRvYvuXsbyj0RZrg==
X-Received: by 2002:a50:a845:: with SMTP id j63-v6mr6567635edc.210.1527751063012;
        Thu, 31 May 2018 00:17:43 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y63-v6sm21484272edy.63.2018.05.31.00.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:17:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 3/4] color.ui config: don't die on unknown values
References: <20180530210641.19771-1-avarab@gmail.com> <20180530210641.19771-4-avarab@gmail.com> <xmqqin74d9rh.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqin74d9rh.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 31 May 2018 09:17:41 +0200
Message-ID: <87h8mo9tuy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 30 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Before this change git will die on any unknown color.ui values:
>>
>>     $ git -c color.ui=doesnotexist show
>>     fatal: bad numeric config value 'doesnotexist' for 'color.ui': invalid unit
>
> I do not think "unit" is correct, so there may be some room for
> improvement.  For _this_ particular case, I agree that it is not the
> end of the world if we did not color the output (because we do not
> know what the 'doesnotyetexist' token from the future is trying to
> tell us), but as a general principle, we should diagnose and die, if
> a misconfiguration is easy to correct.

Many users (including myself) use the same ~/.gitconfig on many
different machines with different git versions. Maybe at some point I'm
willing to set the new setting to a value I know is supported on most of
them, but it sucks at that point if I logging into 1-3% of old machines
ends up killing git on any invocation.

> than blindly go ahead and do random things that the end-user did not
> expect by giving something we do not (but they thought they do)
> understand.

I think this is highly dependent on what variables we give this
treatment. There may be some where we genuinely have no idea what they
mean, but in this case and for http.sslVersion (which warns, doesn't die
on unknown values) it's reasonable to assume that degrading to a known
value is better than outright dying.

> If we really want to introduce "here is a setting you may not
> understand, in which case you may safely ignore", the right way to
> do so is to follow the model the index extension took, where from
> the syntax of the unknown thing an old/existing code can tell if it
> is optional.  Forcing all codepaths to forever ignore what they do
> not understand and what they happen to think is a safe fallback is
> simply being irresponsible---the existing code does not understand
> the new setting so they do not even know if their "current
> behaviour" as a fallback is a safe and sensible one from the point
> of view of the person who asked for the feature from the future.

This seems needlessly complex. color.ui is one of the most prominent
config variales, so you're proposing we split it up into some dual-key
arrangement and force all users to migrate? I think just following what
we're doing with http.sslVersion makes more sense.
