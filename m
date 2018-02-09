Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87A711F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeBIWOc (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:14:32 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56244 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbeBIWOa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:14:30 -0500
Received: by mail-wm0-f67.google.com with SMTP id 143so56384wma.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6d5r993SkakFwqcE6cphbIDflVcJpZAcLvK0hNGHrsE=;
        b=usRaKMrekmWcvQbHTlNCEFNANi1XbXO8NTY1+Lb6GXdn4vzrEMxRkSUbCpjlMIr2S8
         ZPGBdoQfNmF+jWhR9nc0LivoFOh6zZWHSIJzD5GjvCGSE1OMhRdhsYvpqrEvCP4sacbC
         cy4zAoqxikHSs9KnCmCHJNivSzDek/V7UQ6Fh0w7yPdsVBnikqGBxwFzRzq4g1AZDIgd
         vYxMwEBn9N7TtDW3QLASAQx0lmqdXWO8LVW2N/NsGYJa7Ryxz5YvyI69J/cv+3uilFb/
         y/MpebSKF8a5d79ykt4RyRvt64rfB9zP9SbUJquOX004S0FOg0EGJbwPNPxZS5bsSk+g
         hnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6d5r993SkakFwqcE6cphbIDflVcJpZAcLvK0hNGHrsE=;
        b=n+L8BLRYaMGIKxmhT9jX9X8R+UUpU9IYU5BiFQyjYBdvRZ1DcqWXQ698dJPGwHXaKU
         5GT2eTtl2t0naiOojSIkLYJJgDMOShiiWz4buleN8h4tw7CGzifupn49rEsSAMTC30HN
         pqxMwQpihZ9ouWKS2tKr4rRpfNdsxIKxlBafR35/CmZpMfvy5lDRLMWLz/jq81+q46s8
         LiHjCPxIaQTWc10eHC73TMz8ZF1q4GBcdTL3JKI97u+YZOMJ7cLhCLI9/Yo5+exseorI
         379PSR3pM9lmuJn3LcreecXynHfTyWT15U86uPZvPadlTrxjADJeBKVa0lyegHCnJseV
         suMg==
X-Gm-Message-State: APf1xPDxIR4U4FaZN5UVVisgL+mAqYyQ3cz5IohoVAbduFjuP6syTkBl
        ABX3jkXJUUMpWFZZqJF9IUP8lgnJ
X-Google-Smtp-Source: AH8x2255noUkEPHLSsTBtNN0RDnALL5BXjvGdtPfgrDk63+7JcXlgWtL766jipJPbMojkoh9dyE2HA==
X-Received: by 10.80.243.13 with SMTP id p13mr5820129edm.186.1518214469458;
        Fri, 09 Feb 2018 14:14:29 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id o47sm1858726edc.10.2018.02.09.14.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 14:14:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] update-index doc: note a fixed bug in the untracked cache
References: <20180209210431.409-1-avarab@gmail.com> <xmqq6076xabo.fsf@gitster-ct.c.googlers.com> <20180209210431.409-2-avarab@gmail.com> <xmqqwozlvnij.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqqwozlvnij.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 09 Feb 2018 23:14:27 +0100
Message-ID: <87mv0hbykc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> +Before 2.17, the untracked cache had a bug where replacing a directory
>> +with a symlink to another directory could cause it to incorrectly show
>> +files tracked by git as untracked. See the "status: add a failing test
>> +showing a core.untrackedCache bug" commit to git.git. A workaround for
>> +that was (and this might work for other undiscoverd bugs in the
>> +future):
>
> s/undiscoverd/undiscovered/
>
> But more importantly, would it help _us_ to encourage people to
> squelch the diagnoses without telling us about potential breakage, I
> wonder, by telling them to do this for other undiscovered cases,
> too?

You mean including something like "if you see this the git ML would like
to hear about it"?

> Will queue with the above typofix, together with the other one.  I
> am not sure if we want to say "Before 2.17", though.

I'm just keeping in mind the user who later on upgrades git from say
2.14 to 2.18 or something, and is able to find in the docs when/why this
new warning got added, which helps diagnose it.

>> +
>> +----------------
>> +$ git -c core.untrackedCache=false status
>> +----------------
>> +
>> +This bug has also been shown to affect non-symlink cases of replacing
>> +a directory with a file when it comes to the internal structures of
>> +the untracked cache, but no case has been found where this resulted in
>> +wrong "git status" output.
>> +
>>  File System Monitor
>>  -------------------
