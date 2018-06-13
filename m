Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23AE81F403
	for <e@80x24.org>; Wed, 13 Jun 2018 22:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935448AbeFMWWT (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 18:22:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38591 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935060AbeFMWWS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 18:22:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so8249171wmf.3
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 15:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7Y/ooYOLuzkOye8uQXQM+ccOwqayY8dICN5hiczla8Y=;
        b=Pso1pywj5pKgYQsdSVK2KuNMEyew0rY58xc036Rm6ohKqk3cgiFAfmwWbaXRMR3mOr
         1QeWNVyHHdQbXa8cpN3sO1OT1pzMgqPToYtxfclbs0iiTts+DtO4ApQXfr2/b91+0It0
         69wcnbwriqpORl+VF1Xl2j2Sfq7AMtvgeYRregu9mCW+64/C+XTmpaN6uLzMw5p27pJj
         k3WTGSQkfX2v9cgbFVR/ay7BMCC+lCr2CcRww8jYLX7Hh3dnf+7zYOysbvn/LGfe9mhE
         m6sVyKtBvj+I0ZCdvpqlRWUtrqEG9RlLr5oGEA09qRtbop4NgWDjthcEu2g2PJ9m8zrI
         nbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7Y/ooYOLuzkOye8uQXQM+ccOwqayY8dICN5hiczla8Y=;
        b=VIxZpu3Fx9OlgWUu+mTlGW2s2fb8R33EGPw/0lCgaTgnXX1hZNRPlkVhqFE8+7Ol/U
         BTK+N8HjSsOQvuju/hPZCkmnioS3Dmp+tJ3JlR1yc98Eam0ZqNI2e9zqXIvv7yEWF+eu
         X1etFU04r4eJRGcWz/5q4Abug//frY3vo0fBNV9oZ1oaHG/JkYRPUkAPo3FFZNf5bAqq
         AYXFlxCulvyEo/sNarTPNE59QJ1uOQBnDkD4iMSz0NDRqmnZ4yJEf2lfWpcfH8TTVvPH
         7CrEpHY9bofNmLb2jdnkGAgI5mV/e1NQCRq8+6ruH18PXsbTHkissvXcZ66Al80jZeAq
         gy+g==
X-Gm-Message-State: APt69E3GvGsobqrRoMBNgvXcL0JdUuyafpE65ssR/ia2sxJBQzoqONOS
        pYsBKfWVplvLA2AUtRc3DtBKHhzU
X-Google-Smtp-Source: ADUXVKJdVPauv4vS8Heb3xWDgvlpZ9giUOtZZmsPmgasGyhe0rw/bpgo4S5Qh9qbqqeNyZUb4CvJ6A==
X-Received: by 2002:a50:80c2:: with SMTP id 60-v6mr6018edb.169.1528928537056;
        Wed, 13 Jun 2018 15:22:17 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id l9-v6sm2200089edb.17.2018.06.13.15.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 15:22:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 19/20] abbrev: support relative abbrev values
References: <20180608224136.20220-1-avarab@gmail.com> <20180608224136.20220-20-avarab@gmail.com> <xmqqvaan95os.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqvaan95os.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 14 Jun 2018 00:22:14 +0200
Message-ID: <871sdawcmh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 12 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Change the core.abbrev config variable and the corresponding --abbrev
>> command-line option to support relative values such as +1 or -1.
>>
>> Before Linus's e6c587c733 ("abbrev: auto size the default
>> abbreviation", 2016-09-30) git would default to abbreviating object
>> names to 7-hexdigits, and only picking longer SHA-1s as needed if that
>> was ambiguous.
>>
>> That change instead set the default length as a function of the
>> estimated current count of objects:
>>
>>     Based on the expectation that we would see collision in a
>>     repository with 2^(2N) objects when using object names shortened
>>     to first N bits, use sufficient number of hexdigits to cover the
>>     number of objects in the repository.  Each hexdigit (4-bits) we
>>     add to the shortened name allows us to have four times (2-bits) as
>>     many objects in the repository.
>>
>> By supporting relative values for core.abbrev we can allow users to
>> consistently opt-in for either a higher or lower probability of
>> collision, without needing to hardcode a given numeric value like
>> "10", which would be overkill on some repositories, and far to small
>> on others.
>
> Nicely explained and calculated ;-)
>
>>  test_expect_success 'describe core.abbrev=[-+]1 and --abbrev=[-+]1' '
>> -	test_must_fail git -c core.abbrev=+1 describe | sed_g_tr_d_n >describe &&
>> -	test_must_fail git -c core.abbrev=-1 describe | sed_g_tr_d_n >describe &&
>> +	git -c core.abbrev=-1 describe | sed_g_tr_d_n >describe &&
>> +	test_byte_count = 6 describe &&
>> +
>> +	git -c core.abbrev=+1 describe | sed_g_tr_d_n >describe &&
>> +	test_byte_count = 8 describe &&
>
> Even though I see the point of supporting absurdly small absolute
> values like 4, I do not quite see the point of supporting negative
> relative values here.  What's the expected use case?

I'll add a better explanation for this to the commit message.

Initially I did this for consistency, since it was easy to implement,
and there's no reason to have that arbitrary limitation, but thinking
about it again I think I'll use this for some of my projects.

E.g. here's a breakdown of my dotfiles repo:

    $ git -c core.abbrev=4 log  --pretty=format:%h|perl -nE 'chomp;say length'|sort|uniq -c|sort -nr
        784 4
         59 5
          7 6

I don't have a single commit that needs 7 characters, yet that's our
default. This is a sane trade-off for the kernel, but for something
that's just a toy or something you're playing around with something
shorter can make sense.

SHA-1s aren't just written down, but also e.g. remembered in wetware
short-term memory.

>>  	git log --abbrev=+1 --pretty=format:%h -1 | tr_d_n >log &&
>> -	test_byte_count = 4 log &&
>> +	test_byte_count = 8 log &&
>
> This, together with many many others in the rest of the patch, is
> cute but confusing in that the diff shows change from 4 to 8 due to
> the redefinition of what abbrev=+1 means.  I have a feeling that it
> may not be worth doing it "right", but if we were doing it "right",
> we would probably have done it in multiple steps:
>
>     - the earlier patches in this series that demonstrates
>       --abbrev=+1 is --abbrev=1 and core.abbrev=+1 is an error.
>
>     - ensure --abbrev=+1 is rejected as syntax error just like
>       core.abbrev=+1 was, without introducing relative values
>
>     - introduce relative value.
>
> That way, the last step (which corresponds to this patch) would show
> change from "log --abbrev=+1" failing due to syntax error to showing
> abbreviated value that is slightly longer than the default.
>
> But a I said, it may not be worth doing so.  "Is it worth supporting
> negative relative length?" still stands, though.

I'll see what I can do about this value churn.
